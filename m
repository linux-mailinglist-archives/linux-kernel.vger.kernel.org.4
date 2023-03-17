Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DB36BEB59
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjCQOdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjCQOdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:33:38 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F83FE4C5A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:33:33 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id o13-20020adfa10d000000b002d34203df59so385250wro.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679063612;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pr8i0Eumz09pFpMEBVzLFDV1F++dQdI0hyhxEAp2n3w=;
        b=KFFpGv1i3Q3hEABcr9gwon1e9ZOOii+a9nok8Xz6VJHQXlZj8a4ilUYyQ7HMnuhkCI
         sXZLVNB42WAB9R7e4mMHVa9IZOWnDXuNH+2j9OKDAHzVLPmvvD6GIRnvO3NL+LPmoXb7
         CuYqX6HtBJEl7yOy8tE3CbgH2a9QuAhgQH0TMKy6gIwD8vuHiQY14lGwrbFvySHqxjcW
         UHWAke4bMF7QCgim7nTrat4IpktRIS4roz/VIcQX5Tyx5Mc3q8mmJStRrFEcodzEy9VI
         XUqcI0Leb2W5ruN5ngLNBSm4rP1RDU/TYfcc9QEzXLb0+IXTjftKOL6d3GVh+lQTWdfp
         ZTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679063612;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pr8i0Eumz09pFpMEBVzLFDV1F++dQdI0hyhxEAp2n3w=;
        b=5+fYIZX3nwu9Kisyap9AcS55z411c1WvNxVWw7R6H9FuX+h/jrUOxWAYTELCGMXPuV
         HbOTR6fbTBvJaMcVgAjc+D8akY7DBBc2AJUSw2SNKPRd1U5meTFIlSOrk3S5X2eYPPWd
         mADfhCtIlURzVuEXIe4XL0E+oBbFxEgVNmrN6RmBRCTWL8qpaohpQJI77duEO+YqSrE4
         EfvQA5QIuBXgW3rdhwV6opqPM40nrQ9w6M6VAG1ou6iKYcTFqP37B24GtVLuvtJhXeG9
         yp9leE3Rv3j4sMJQWNJIXKsXQcepU840S/dArRSfnLjafBpHKCh9dtrTHdipj6yjNyOZ
         XYng==
X-Gm-Message-State: AO0yUKWo543mhSJx9JO7ag994GpXGn9kmcWpEa0CxZCekeCHWIZ4kstw
        L4dHThwTYxEOK4gTXfHQNjbwiFpz9TjZtDGL
X-Google-Smtp-Source: AK7set/+ZPVsiYqB7Hdp5WNTZma1qHm7dbiDdmEBcxtiq5xxh7zeGKnvdJNfz8Sgi+ddXtHaCz11zbRlVfE7ArBN
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:adf:efc1:0:b0:2cf:e74f:c5b1 with SMTP
 id i1-20020adfefc1000000b002cfe74fc5b1mr653973wrp.7.1679063612090; Fri, 17
 Mar 2023 07:33:32 -0700 (PDT)
Date:   Fri, 17 Mar 2023 14:33:10 +0000
In-Reply-To: <20230317143310.1604700-1-vdonnefort@google.com>
Mime-Version: 1.0
References: <20230317143310.1604700-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230317143310.1604700-3-vdonnefort@google.com>
Subject: [PATCH 2/2] tracing: Allow user-space mapping of the ring-buffer
From:   Vincent Donnefort <vdonnefort@google.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, user-space extracts data from the ring-buffer via splice,
which is handy for storage or network sharing. However, due to splice
limitations, it is imposible to do real-time analysis without a copy.

A solution for that problem is to let the user-space map the ring-buffer
directly.

The mapping exposed via the per-CPU file trace_pipe_raw. The first page
is the meta-page and is followed by each page of the ring-buffer,
ordered by their unique page ID. It is therefore easy to translate a
page-ID to an offset in the mapping.

  * Meta-page -- include/uapi/linux/trace_mmap.h for a description
  * Page ID 0
  * Page ID 1
     ...

The mapper must then do what use to be the kernel jobs: swap the reader
with the head. This is done with a newly introduced ioctl:
TRACE_MMAP_IOCTL_GET_READER_PAGE.

Entries, pages_touched and overrun fields are automatically updated by
the writer. Only readers keep the head page field updated. An additional
ioctl TRACE_MMAP_IOCTL_UPDATE_META_PAGE allows to query that update,
enabling non-consuming read from userspace.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
index b5caed17a066..24bcec754a35 100644
--- a/include/uapi/linux/trace_mmap.h
+++ b/include/uapi/linux/trace_mmap.h
@@ -21,4 +21,7 @@ struct ring_buffer_meta_page {
 	__u32	data_pages[];
 };
 
+#define TRACE_MMAP_IOCTL_GET_READER_PAGE	_IO('T', 0x1)
+#define TRACE_MMAP_IOCTL_UPDATE_META_PAGE	_IO('T', 0x2)
+
 #endif /* _UAPI_TRACE_MMAP_H_ */
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 45551c7b4c36..51d06a2a7545 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6399,7 +6399,7 @@ static void tracing_set_nop(struct trace_array *tr)
 {
 	if (tr->current_trace == &nop_trace)
 		return;
-	
+
 	tr->current_trace->enabled--;
 
 	if (tr->current_trace->reset)
@@ -8432,15 +8432,27 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 	return ret;
 }
 
-/* An ioctl call with cmd 0 to the ring buffer file will wake up all waiters */
 static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct ftrace_buffer_info *info = file->private_data;
 	struct trace_iterator *iter = &info->iter;
 
+	switch (cmd) {
+	case TRACE_MMAP_IOCTL_GET_READER_PAGE:
+		return ring_buffer_get_reader_page(iter->array_buffer->buffer,
+						   iter->cpu_file);
+	case TRACE_MMAP_IOCTL_UPDATE_META_PAGE:
+		return ring_buffer_update_meta_page(iter->array_buffer->buffer,
+						    iter->cpu_file);
+	}
+
 	if (cmd)
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
 
+	/*
+	 * An ioctl call with cmd 0 to the ring buffer file will wake up all
+	 * waiters
+	 */
 	mutex_lock(&trace_types_lock);
 
 	iter->wait_index++;
@@ -8453,6 +8465,60 @@ static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned
 	return 0;
 }
 
+static vm_fault_t tracing_buffers_mmap_fault(struct vm_fault *vmf)
+{
+	struct ftrace_buffer_info *info = vmf->vma->vm_file->private_data;
+	struct trace_iterator *iter = &info->iter;
+	vm_fault_t ret = VM_FAULT_SIGBUS;
+	struct page *page;
+
+	page = ring_buffer_map_fault(iter->array_buffer->buffer, iter->cpu_file,
+				     vmf->pgoff);
+	if (!page)
+		return ret;
+
+	get_page(page);
+	vmf->page = page;
+
+	return 0;
+}
+
+static void tracing_buffers_mmap_close(struct vm_area_struct *vma)
+{
+	struct ftrace_buffer_info *info = vma->vm_file->private_data;
+	struct trace_iterator *iter = &info->iter;
+
+	ring_buffer_unmap(iter->array_buffer->buffer, iter->cpu_file);
+}
+
+static void tracing_buffers_mmap_open(struct vm_area_struct *vma)
+{
+	struct ftrace_buffer_info *info = vma->vm_file->private_data;
+	struct trace_iterator *iter = &info->iter;
+
+	WARN_ON(ring_buffer_map(iter->array_buffer->buffer, iter->cpu_file));
+}
+
+static const struct vm_operations_struct tracing_buffers_vmops = {
+	.open		= tracing_buffers_mmap_open,
+	.close		= tracing_buffers_mmap_close,
+	.fault		= tracing_buffers_mmap_fault,
+};
+
+static int tracing_buffers_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct ftrace_buffer_info *info = filp->private_data;
+	struct trace_iterator *iter = &info->iter;
+
+	if (vma->vm_flags & VM_WRITE)
+		return -EPERM;
+
+	vm_flags_mod(vma, VM_DONTCOPY | VM_DONTDUMP, VM_MAYWRITE);
+	vma->vm_ops = &tracing_buffers_vmops;
+
+	return ring_buffer_map(iter->array_buffer->buffer, iter->cpu_file);
+}
+
 static const struct file_operations tracing_buffers_fops = {
 	.open		= tracing_buffers_open,
 	.read		= tracing_buffers_read,
@@ -8461,6 +8527,7 @@ static const struct file_operations tracing_buffers_fops = {
 	.splice_read	= tracing_buffers_splice_read,
 	.unlocked_ioctl = tracing_buffers_ioctl,
 	.llseek		= no_llseek,
+	.mmap		= tracing_buffers_mmap,
 };
 
 static ssize_t
-- 
2.40.0.rc1.284.g88254d51c5-goog

