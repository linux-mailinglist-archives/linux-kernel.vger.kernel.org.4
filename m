Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4BE6C373F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 17:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjCUQox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 12:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjCUQot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:44:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A31311640;
        Tue, 21 Mar 2023 09:44:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABD8861D32;
        Tue, 21 Mar 2023 16:44:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0EAC433D2;
        Tue, 21 Mar 2023 16:44:29 +0000 (UTC)
Date:   Tue, 21 Mar 2023 12:44:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vincent Donnefort <vdonnefort@google.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20230321124425.6ca93621@gandalf.local.home>
In-Reply-To: <20230321114047.3432afbe@gandalf.local.home>
References: <20230317143310.1604700-1-vdonnefort@google.com>
        <20230317143310.1604700-2-vdonnefort@google.com>
        <20230320214516.01c18367@gandalf.local.home>
        <ZBnKe55cvTZybZLF@google.com>
        <20230321114047.3432afbe@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Mar 2023 11:40:47 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > 
> > Thanks a lot for having a look. Do you mind if I fold this in my patch for a V2?  
> 
> Hold off, I found some bugs that I'm fixing ;-)

OK, you can fold this in. I also fixed an issue with your patch where it
was missing setting a page->mapping and also clearing it.

I haven't updated to replace "__u32 *data_pages[]" with an "__u32 data_start"
But I think that should still be done.

-- Steve

diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
index 24bcec754a35..12f3f7ee33d9 100644
--- a/include/uapi/linux/trace_mmap.h
+++ b/include/uapi/linux/trace_mmap.h
@@ -18,6 +18,7 @@ struct ring_buffer_meta_page {
 	__u32	reader_page;
 	__u32	nr_data_pages;	/* doesn't take into account the reader_page */
 	__u32	data_page_head;	/* index of data_pages[] */
+	__u32	meta_page_size;	/* size of the meta page */
 	__u32	data_pages[];
 };
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 10a17e78cfe6..d546fdd14fc3 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -526,6 +526,7 @@ struct ring_buffer_per_cpu {
 	u64				read_stamp;
 
 	int				mapped;
+	int				meta_order;
 	struct mutex			mapping_lock;
 	unsigned long			*page_ids;	/* ID to addr */
 	struct ring_buffer_meta_page	*meta_page;
@@ -5898,32 +5899,63 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 EXPORT_SYMBOL_GPL(ring_buffer_read_page);
 
 #define META_PAGE_MAX_PAGES \
-	((PAGE_SIZE - (offsetof(struct ring_buffer_meta_page, data_page_head))) >> 2)
+	((PAGE_SIZE - (offsetof(struct ring_buffer_meta_page, data_pages))) >> 2)
+
+static void unmap_page(unsigned long addr)
+{
+	struct page *page = virt_to_page(addr);
+
+	page->mapping = NULL;
+}
 
 static void rb_free_page_ids(struct ring_buffer_per_cpu *cpu_buffer)
 {
+	int i;
+
+	for (i = 0; i < cpu_buffer->nr_pages; i++)
+		unmap_page(cpu_buffer->page_ids[i]);
+
 	kfree(cpu_buffer->page_ids);
 	cpu_buffer->page_ids = NULL;
 }
 
 static int rb_alloc_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
 {
+	struct page *meta_pages;
+	int pages;
+	int order = 0;
+
 	if (cpu_buffer->meta_page)
 		return 0;
 
-	if (cpu_buffer->nr_pages > META_PAGE_MAX_PAGES)
-		return -E2BIG;
-
-	cpu_buffer->meta_page = page_to_virt(alloc_page(GFP_USER));
-	if (!cpu_buffer->meta_page)
+	if (cpu_buffer->nr_pages > META_PAGE_MAX_PAGES) {
+		/* Calcualte how many more pages we need to hold indexes */
+		pages = DIV_ROUND_UP(cpu_buffer->nr_pages - META_PAGE_MAX_PAGES,
+				     PAGE_SIZE / sizeof(u32));
+		/* Add back the meta_page itself */
+		pages++;
+		order = fls(pages) - 1;
+	}
+	meta_pages = alloc_pages(GFP_USER, order);
+	if (!meta_pages)
 		return -ENOMEM;
 
+	cpu_buffer->meta_page = page_to_virt(meta_pages);
+	cpu_buffer->meta_order = order;
+
 	return 0;
 }
 
 static void rb_free_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
 {
-	free_page((unsigned long)cpu_buffer->meta_page);
+	unsigned long addr = (unsigned long)cpu_buffer->meta_page;
+	int i;
+
+	for (i = 0; i < (1 << cpu_buffer->meta_order); i++) {
+		unmap_page(addr);
+		addr += PAGE_SIZE;
+	}
+	free_pages((unsigned long)cpu_buffer->meta_page, cpu_buffer->meta_order);
 	cpu_buffer->meta_page = NULL;
 }
 
@@ -5932,14 +5964,20 @@ static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
 {
 	struct ring_buffer_meta_page *meta = cpu_buffer->meta_page;
 	struct buffer_page *first_page, *bpage;
+	int data_page_end;
 	int id = 0;
 
 	page_ids[id] = (unsigned long)cpu_buffer->reader_page->page;
 	cpu_buffer->reader_page->id = id++;
 
+	/* Calculate the last index of data_pages[] */
+	data_page_end = (1 << (cpu_buffer->meta_order + PAGE_SHIFT)) -
+		offsetof(struct ring_buffer_meta_page, data_pages);
+	data_page_end /= sizeof(u32);
+
 	first_page = bpage = rb_set_head_page(cpu_buffer);
 	do {
-		if (id > META_PAGE_MAX_PAGES) {
+		if (id > data_page_end) {
 			WARN_ON(1);
 			break;
 		}
@@ -5960,6 +5998,7 @@ static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
 	meta->pages_touched = 0;
 	meta->reader_page = cpu_buffer->reader_page->id;
 	meta->nr_data_pages = cpu_buffer->nr_pages;
+	meta->meta_page_size = 1 << (cpu_buffer->meta_order + PAGE_SHIFT);
 	meta->data_page_head = 0;
 }
 
@@ -6092,10 +6131,12 @@ int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
 /*
  *   +--------------+
  *   |   meta page  |  pgoff=0
+ *   |     ...      |
+ *   |              |  pgoff=(1<<cpu_buffer->meta_order - 1)
  *   +--------------+
- *   |  data page1  |  pgoff=1 page_ids=0
+ *   |  data page1  |  page_ids=0
  *   +--------------+
- *   |  data page2  |  pgoff=2 page_ids=1
+ *   |  data page2  |  page_ids=1
  *         ...
  */
 struct page *ring_buffer_map_fault(struct trace_buffer *buffer, int cpu,
@@ -6103,10 +6144,11 @@ struct page *ring_buffer_map_fault(struct trace_buffer *buffer, int cpu,
 {
 	struct ring_buffer_per_cpu *cpu_buffer = buffer->buffers[cpu];
 
-	if (!pgoff)
-		return virt_to_page(cpu_buffer->meta_page);
+	if (pgoff < (1 << cpu_buffer->meta_order))
+		return virt_to_page((void *)cpu_buffer->meta_page + (pgoff << PAGE_SHIFT));
+
+	pgoff -= (1 << cpu_buffer->meta_order);
 
-	pgoff--;
 	if (pgoff > cpu_buffer->nr_pages)
 		return NULL;
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ea48eabce7b7..2f43e4a842e7 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8479,9 +8479,12 @@ static vm_fault_t tracing_buffers_mmap_fault(struct vm_fault *vmf)
 	if (!page)
 		return ret;
 
-	get_page(page);
 	vmf->page = page;
 
+	get_page(vmf->page);
+	vmf->page->mapping = vmf->vma->vm_file->f_mapping;
+	vmf->page->index   = vmf->pgoff;
+
 	return 0;
 }
 
