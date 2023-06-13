Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4013872DC8E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241339AbjFMIfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241299AbjFMIf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:35:29 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9864E6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:35:27 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id 5b1f17b1804b1-3f7ef0e0292so20192915e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686645326; x=1689237326;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=idAAT7Bu38PyLwdgVJzIw2LhWBOsmVWg1cRqwUSMs3c=;
        b=iC7aqWyh5guGQ8w2RsWJlR+Gt6z8z/IRLsbShnWPEnE/6BuKjltRc1ZvvLoTOUJ+sA
         e86rcGyhDEbWTQJSFyuVxpwbbgroNhEXexSnAM15DpvMypfzOdRCEdUHqkiTHh4AIBrL
         TwnMMbGyE3zdWjj0vfWS+ZiVhR6d2+wXIkW6DlRhey3s5ejNhnCFL2vEah3VzWnaBFyx
         3P3w0mPaL/Q77VfhMpP3+hMorNDJa83pAVSNIsvrwP8OXNn3zpoHAO+xsI4HcftbtZDU
         8J1U43RiKQFPEy5pS8n7hFQ2PGg6FUpvtylW7xC5uyFjth3BhP/9Ry7JaRr8lWfMW325
         +kvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686645326; x=1689237326;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=idAAT7Bu38PyLwdgVJzIw2LhWBOsmVWg1cRqwUSMs3c=;
        b=OWMICiDgbwfL2hcR7n+Nc19FcotzGsPfxDkm3iFFludejcD+ra65sOUBepcQXprILI
         dqG02Dtdy2k3egkcN9Uy1iCEB5DHMBBKG9IMHLDqzWLFtPlFR5Msok/BHkh8OPyHwJdo
         8swJRQ9EmdrXItYnMJYCRXCtl0+1+54ChLM9ax4tsRliOaiZCdf5/D2n64ILIGeqCiFU
         yQF2DLOalviiEMtBx7y8tvF+Orffi/nVRj6GgWK8rkvg4a6K8hipmba9dR+kSZXsjgqa
         wXQS5zolWRwe29bhHa4kCfnaQnowAHQt8wbWMGcFEbOJMyA3qA2/Xkud/6FgaQddXkF6
         efnA==
X-Gm-Message-State: AC+VfDw3OhsmD5vJz8fY6sYRHfKuhYo/1KSgCoa+MLXpkdJ88z3lwAEZ
        KA4Hh9EDWfR4LA9yOOmOBmMyrm1OOrby85o/
X-Google-Smtp-Source: ACHHUZ6BB9LQNmvz3OBHDcP4izKCFJjELfYij7NbhEc05xqwReS9Wmy2mk3JHK18tWhu6KubN1Z6Ux1zlRcxdG9v
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a1c:750a:0:b0:3f7:38dd:5ea8 with SMTP
 id o10-20020a1c750a000000b003f738dd5ea8mr1901891wmc.8.1686645326337; Tue, 13
 Jun 2023 01:35:26 -0700 (PDT)
Date:   Tue, 13 Jun 2023 09:35:13 +0100
In-Reply-To: <20230613083513.3312612-1-vdonnefort@google.com>
Mime-Version: 1.0
References: <20230613083513.3312612-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230613083513.3312612-3-vdonnefort@google.com>
Subject: [PATCH v4 2/2] tracing: Allow user-space mapping of the ring-buffer
From:   Vincent Donnefort <vdonnefort@google.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 653176cc50bc..fd323a92cf78 100644
--- a/include/uapi/linux/trace_mmap.h
+++ b/include/uapi/linux/trace_mmap.h
@@ -23,4 +23,6 @@ struct ring_buffer_meta {
 	} reader_page;
 };
 
+#define TRACE_MMAP_IOCTL_GET_READER_PAGE	_IO('T', 0x1)
+
 #endif /* _UAPI_TRACE_MMAP_H_ */
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 64a4dde073ef..ccc0e1dd7d0d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6432,7 +6432,7 @@ static void tracing_set_nop(struct trace_array *tr)
 {
 	if (tr->current_trace == &nop_trace)
 		return;
-	
+
 	tr->current_trace->enabled--;
 
 	if (tr->current_trace->reset)
@@ -8465,15 +8465,21 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
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
+		return ring_buffer_map_get_reader_page(iter->array_buffer->buffer,
+						       iter->cpu_file);
+	else if (cmd)
+		return -ENOTTY;
 
+	/*
+	 * An ioctl call with cmd 0 to the ring buffer file will wake up all
+	 * waiters
+	 */
 	mutex_lock(&trace_types_lock);
 
 	iter->wait_index++;
@@ -8486,6 +8492,63 @@ static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned
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
@@ -8494,6 +8557,7 @@ static const struct file_operations tracing_buffers_fops = {
 	.splice_read	= tracing_buffers_splice_read,
 	.unlocked_ioctl = tracing_buffers_ioctl,
 	.llseek		= no_llseek,
+	.mmap		= tracing_buffers_mmap,
 };
 
 static ssize_t
-- 
2.41.0.162.gfafddb0af9-goog

