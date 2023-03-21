Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B99E6C2793
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 02:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjCUBp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 21:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCUBpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:45:24 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177F32A151;
        Mon, 20 Mar 2023 18:45:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7F810CE1742;
        Tue, 21 Mar 2023 01:45:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0904AC433EF;
        Tue, 21 Mar 2023 01:45:17 +0000 (UTC)
Date:   Mon, 20 Mar 2023 21:45:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vincent Donnefort <vdonnefort@google.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20230320214516.01c18367@gandalf.local.home>
In-Reply-To: <20230317143310.1604700-2-vdonnefort@google.com>
References: <20230317143310.1604700-1-vdonnefort@google.com>
        <20230317143310.1604700-2-vdonnefort@google.com>
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

On Fri, 17 Mar 2023 14:33:09 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> Also, the meta-page being... a single page, this limits at the moment the
> number of pages in the ring-buffer that can be mapped: ~3MB on a 4K pages
> system.

I hate this limitation, so I fixed it ;-)

I added a meta_page_size field to the meta page, and user space can do:

	meta = mmap(NULL, page_size, PROT_READ, MAP_SHARED, fd, 0);
	if (meta == MAP_FAILED)
		pdie("mmap");

	map = meta;
	meta_len = map->meta_page_size;

	if (meta_len > page_size) {
		munmap(meta, page_size);
		meta = mmap(NULL, meta_len, PROT_READ, MAP_SHARED, fd, 0);
		if (meta == MAP_FAILED)
			pdie("mmap");
		map = meta;
	}

This appears to work (but I'm still testing it).

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
index 10a17e78cfe6..77c92e4a7adc 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -526,6 +526,7 @@ struct ring_buffer_per_cpu {
 	u64				read_stamp;
 
 	int				mapped;
+	int				meta_order;
 	struct mutex			mapping_lock;
 	unsigned long			*page_ids;	/* ID to addr */
 	struct ring_buffer_meta_page	*meta_page;
@@ -5898,7 +5899,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 EXPORT_SYMBOL_GPL(ring_buffer_read_page);
 
 #define META_PAGE_MAX_PAGES \
-	((PAGE_SIZE - (offsetof(struct ring_buffer_meta_page, data_page_head))) >> 2)
+	((PAGE_SIZE - (offsetof(struct ring_buffer_meta_page, data_pages))) >> 2)
 
 static void rb_free_page_ids(struct ring_buffer_per_cpu *cpu_buffer)
 {
@@ -5908,22 +5909,34 @@ static void rb_free_page_ids(struct ring_buffer_per_cpu *cpu_buffer)
 
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
+	free_pages((unsigned long)cpu_buffer->meta_page, cpu_buffer->meta_order);
 	cpu_buffer->meta_page = NULL;
 }
 
@@ -5932,14 +5945,20 @@ static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
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
@@ -5960,6 +5979,7 @@ static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
 	meta->pages_touched = 0;
 	meta->reader_page = cpu_buffer->reader_page->id;
 	meta->nr_data_pages = cpu_buffer->nr_pages;
+	meta->meta_page_size = 1 << (cpu_buffer->meta_order + PAGE_SHIFT);
 	meta->data_page_head = 0;
 }
 
@@ -6092,10 +6112,12 @@ int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
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
@@ -6103,10 +6125,11 @@ struct page *ring_buffer_map_fault(struct trace_buffer *buffer, int cpu,
 {
 	struct ring_buffer_per_cpu *cpu_buffer = buffer->buffers[cpu];
 
-	if (!pgoff)
-		return virt_to_page(cpu_buffer->meta_page);
+	if (pgoff < (1 << cpu_buffer->meta_order) + 1)
+		return virt_to_page((void *)cpu_buffer->meta_page + (pgoff << PAGE_SHIFT));
+
+	pgoff -= (1 << cpu_buffer->meta_order);
 
-	pgoff--;
 	if (pgoff > cpu_buffer->nr_pages)
 		return NULL;
 
