Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3A76DC0E3
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 19:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjDIRjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 13:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjDIRje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 13:39:34 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCFB35B0
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 10:39:33 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id m17-20020a509991000000b0050463defdabso4750968edb.6
        for <linux-kernel@vger.kernel.org>; Sun, 09 Apr 2023 10:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681061972;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wqRGpCqbtVC488h2OQKSqrWXyjUQrRT9sWanjh2AEc4=;
        b=L61O/4Racqisn/CcQLsLz24hTVM47/kWqySmywyAx04F7n968AzREOpP8feCMzqZwq
         j2dE9gfVX5EfVDpjchXJtg4nxpepHOAqaTYb2ukFcNUHsOGXGp019qhdHPI2A/1GQqil
         PFQHWuYK8zFKi3gnSs/YHt2S2fLGZAf/G+kgWAjXMNH8H1EHA5HBJUaWI2z7UsY5nCoA
         FkT0xkNNUHWmS2hSllA7GlHghiuKdHDAye89ZSw2iiyXP+rhGz6ke/PWFUmw2G+C50ni
         LNDAtsot4prlpFYk3Dv9G6YWWM6shk2rDellkwGfdE08GL+fHujgxR1tGQRS4WkRYGyQ
         jZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681061972;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wqRGpCqbtVC488h2OQKSqrWXyjUQrRT9sWanjh2AEc4=;
        b=0oLPkykFYDOaeX1/ZemUKosmUi+yzNf1OZNEi0nb6AwgyzIh6zyZCwB5QtozgzGYiK
         sGGkkAYSlRIWvH6hbbDtsCah5J5Cnsf7juADKdsEMyx6kqMsHw55dCkavKOiOJCiXIh1
         y3NY29gc06quuHjXJIlWTEhAwOCqfjs9yzoakLKOdgFb3dweWvMG5QIIwmFG7qWAy/hR
         hiEAwPZNRhGCinciD+xrbk2eMm+IjyWLw20xNqoUkmpgEylejfCmvixN2ejkkgpdYqrf
         5cR+IhFTqwkTZWxfH0gzrPTazrjxjla/XAfsfkwKVUH8+TGtdG8tfxjsHQ3thVNTWFwm
         TIug==
X-Gm-Message-State: AAQBX9cact4IorjVYoorbAgvK5fgy3IuciDKxMWnDbj5tfv7qZ8t9Vvi
        quFJjRoqrSr+eHa5MWXNMfqXv6ca2P3DpVQ6
X-Google-Smtp-Source: AKy350ZO9BPOKGQZeu7RmWzOReHJC5wm910vzRkwdsDWBDG1NfR3U6Yj8m0HcJTG0td13mCw7ONx56F5VONFFFLG
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a17:906:cd28:b0:932:4d97:a370 with SMTP
 id oz40-20020a170906cd2800b009324d97a370mr2113151ejb.14.1681061972164; Sun,
 09 Apr 2023 10:39:32 -0700 (PDT)
Date:   Sun,  9 Apr 2023 18:39:23 +0100
In-Reply-To: <20230409173923.1822455-1-vdonnefort@google.com>
Mime-Version: 1.0
References: <20230409173923.1822455-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230409173923.1822455-3-vdonnefort@google.com>
Subject: [PATCH v3 2/2] tracing: Allow user-space mapping of the ring-buffer
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

The mapper must then do what use to be the kernel job: swap the reader
with the head. This is done with a newly introduced ioctl:
TRACE_MMAP_IOCTL_GET_READER_PAGE.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
index b89e0c8562b5..70b97c0ea888 100644
--- a/include/uapi/linux/trace_mmap.h
+++ b/include/uapi/linux/trace_mmap.h
@@ -21,4 +21,6 @@ struct ring_buffer_meta_header {
 	__u32	read;		/* Number of bytes read on the current reader page */
 };
 
+#define TRACE_MMAP_IOCTL_GET_READER_PAGE	_IO('T', 0x1)
+
 #endif /* _UAPI_TRACE_MMAP_H_ */
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 45551c7b4c36..8a64ca87afaf 100644
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
@@ -8432,15 +8432,21 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 	return ret;
 }
 
-/* An ioctl call with cmd 0 to the ring buffer file will wake up all waiters */
 static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct ftrace_buffer_info *info = file->private_data;
 	struct trace_iterator *iter = &info->iter;
 
-	if (cmd)
-		return -ENOIOCTLCMD;
+	if (cmd == TRACE_MMAP_IOCTL_GET_READER_PAGE)
+		return ring_buffer_get_reader_page(iter->array_buffer->buffer,
+						   iter->cpu_file);
+	else if (cmd)
+		return -ENOTTY;
 
+	/*
+	 * An ioctl call with cmd 0 to the ring buffer file will wake up all
+	 * waiters
+	 */
 	mutex_lock(&trace_types_lock);
 
 	iter->wait_index++;
@@ -8453,6 +8459,63 @@ static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned
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
@@ -8461,6 +8524,7 @@ static const struct file_operations tracing_buffers_fops = {
 	.splice_read	= tracing_buffers_splice_read,
 	.unlocked_ioctl = tracing_buffers_ioctl,
 	.llseek		= no_llseek,
+	.mmap		= tracing_buffers_mmap,
 };
 
 static ssize_t
-- 
2.40.0.577.gac1e443424-goog

