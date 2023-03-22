Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5C36C4793
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 11:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjCVK1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 06:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjCVK1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 06:27:01 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1691D5F200
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 03:26:54 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id q21-20020a05600c46d500b003ee570749f7so840102wmo.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 03:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679480812;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wZ9f1BjLJkOFx0USqHh1WH8B1brZoQG0BbTDKoggwrY=;
        b=Ejct3CO8JsVUJdMjCYvwmgl3ejKMv9zBdrexMkafvTz3btw8DlF3TGWS8WHdbD8VEI
         31NyEqErGFRnD56yw1XbEP0lsaAIMPQrI6HHtM4iO7xtaaUlOXNjGvFnKAV0/v5sDKsO
         BR82aJxENZcGtR4b0IxJE7lNVYuj98cYWUDUjv6x+Lf+MWz0z3y4BSv0EFigZ4MwHail
         KrgaMmTEh28dPxKa9ZeWsFmiFhjE61UW2NpoCRzbF9Z455wG0DqMKe5uQvAXFzUdkFNd
         nhD9lhGHM1InvN23fvM1Fg7BG04GOR9oZyyNpbbUaAejQ5hIgzn/pIjC5soMlOhwNn/V
         l+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679480812;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wZ9f1BjLJkOFx0USqHh1WH8B1brZoQG0BbTDKoggwrY=;
        b=eq+tw9hUtuKXXIr5kXY5aW8Vx9/YexYDhgLZgnwkeufdLsk2KBFGIQ4LMATqdi5SmZ
         DM0cORUZsYEPNgXMtAMaT6I9GhhF+UgJlz6X7BASPu7O/uAMjIUS1h2xKA5Ms1shG9/3
         ASJNnn+Ixka83tU+OiMhjK4y0oApuy0VTFlC9kT6vFn8nhOJBKhyrUKXzyv4tZs0lULT
         N7PMeljocohdS7607Z5JQiH1KtnsMauWrVXGQCGLrHR8Zix1Tz/QRGcSOOnv3uSuZzrH
         m0euM2ZPrLMIT/GKf78mQkR4KtUQbTzCfCXEJ1TT25/31OTQLqiuPDp/V2E8tHNdox87
         3mEA==
X-Gm-Message-State: AO0yUKUPLF6g7m2y07VomrRmfV5byQV8W/E7wLvysoJagcMs/5/sR2x1
        ahRRxvuLyoMlLknkgojHOigB+25TCLhUVJL1
X-Google-Smtp-Source: AK7set/jzeu/HzOtAk02LcoJyMCJOw0BLZu0S3oh+aO1r7aJsqhV5v9IafmheLKGw4WyyABB5MuVYzel/M/1+w+c
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a5d:534e:0:b0:2c5:557a:59b2 with SMTP
 id t14-20020a5d534e000000b002c5557a59b2mr1138478wrv.12.1679480812653; Wed, 22
 Mar 2023 03:26:52 -0700 (PDT)
Date:   Wed, 22 Mar 2023 10:22:44 +0000
In-Reply-To: <20230322102244.3239740-1-vdonnefort@google.com>
Mime-Version: 1.0
References: <20230322102244.3239740-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230322102244.3239740-3-vdonnefort@google.com>
Subject: [PATCH v2 2/2] tracing: Allow user-space mapping of the ring-buffer
From:   Vincent Donnefort <vdonnefort@google.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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
index 7794314a80e9..c33adea0aa84 100644
--- a/include/uapi/linux/trace_mmap.h
+++ b/include/uapi/linux/trace_mmap.h
@@ -22,4 +22,7 @@ struct ring_buffer_meta_page_header {
 	__u32	data_start;	/* offset within the meta page */
 };
 
+#define TRACE_MMAP_IOCTL_GET_READER_PAGE	_IO('T', 0x1)
+#define TRACE_MMAP_IOCTL_UPDATE_META_PAGE	_IO('T', 0x2)
+
 #endif /* _UAPI_TRACE_MMAP_H_ */
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 45551c7b4c36..65251a28f2a9 100644
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
@@ -8453,6 +8465,63 @@ static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned
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
+	vmf->page = page;
+
+	get_page(vmf->page);
+	vmf->page->mapping = vmf->vma->vm_file->f_mapping;
+	vmf->page->index   = vmf->pgoff;
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
@@ -8461,6 +8530,7 @@ static const struct file_operations tracing_buffers_fops = {
 	.splice_read	= tracing_buffers_splice_read,
 	.unlocked_ioctl = tracing_buffers_ioctl,
 	.llseek		= no_llseek,
+	.mmap		= tracing_buffers_mmap,
 };
 
 static ssize_t
-- 
2.40.0.rc1.284.g88254d51c5-goog

