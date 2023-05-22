Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE22070CB48
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbjEVUgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbjEVUgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:36:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387EF10DD;
        Mon, 22 May 2023 13:35:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A84CE62BBB;
        Mon, 22 May 2023 20:35:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A3CC4339B;
        Mon, 22 May 2023 20:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684787740;
        bh=hPFjOzuSnoN/PTZCIZOnbk80dddEgF6LEUhE4eMCblA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W5XbiWtuhMenbbX2eUsoinsN+8nRR/kk7KRzLM8u5n0ct6UJ6TQgEMjP7g7qlnGGs
         2OVjjAHxKwg5pjH9dqMzfV222zpLYZ/4BpTR7v7ZCSUSb9jtV8BcjfGrC0a/Y7Nhe8
         72PtsNoXrMmSGA5Rtsqncf24gdJ8qlDxXHN3WtRUJKeMt7zKVZkNWBC+ElyUbnBE3r
         9+8EDRyGXj7XaXJTyEfdXze96jJhrwyIlAESgXyTKCXz+LfKhh7NDX+ciCPw2ypc2E
         usyZxZNSzHp7HWwnbbdBDf9vxIu5tWnhCC7dSJYUjPRNH7Uy7lq+/9b+s74HUGmrBx
         KVs56ZQh4lioA==
From:   Jiri Olsa <jolsa@kernel.org>
To:     stable@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        bpf@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?q?Mah=C3=A9=20Tardy?= <mahe.tardy@isovalent.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH stable 5.4 7/8] bpf: rework the compat kernel probe handling
Date:   Mon, 22 May 2023 22:33:51 +0200
Message-Id: <20230522203352.738576-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522203352.738576-1-jolsa@kernel.org>
References: <20230522203352.738576-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

commit 8d92db5c04d10381f4db70ed99b1b576f5db18a7 upstream.

[Conflicts due to applying hunks only to the functions that
were taken in 6ae08ae3dea2 upstream commit backport earlier]

Instead of using the dangerous probe_kernel_read and strncpy_from_unsafe
helpers, rework the compat probes to check if an address is a kernel or
userspace one, and then use the low-level kernel or user probe helper
shared by the proper kernel and user probe helpers.  This slightly
changes behavior as the compat probe on a user address doesn't check
the lockdown flags, just as the pure user probes do.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20200521152301.2587579-14-hch@lst.de
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 kernel/trace/bpf_trace.c | 93 +++++++++++++++++++++++++++-------------
 1 file changed, 64 insertions(+), 29 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index d1fd13a47bdf..a46256f99229 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -139,65 +139,99 @@ static const struct bpf_func_proto bpf_override_return_proto = {
 #endif
 
 static __always_inline int
-bpf_probe_read_kernel_common(void *dst, u32 size, const void *unsafe_ptr,
-			     const bool compat)
+bpf_probe_read_user_common(void *dst, u32 size, const void __user *unsafe_ptr)
 {
-	int ret = security_locked_down(LOCKDOWN_BPF_READ);
+	int ret;
 
+	ret = probe_user_read(dst, unsafe_ptr, size);
 	if (unlikely(ret < 0))
-		goto out;
-	ret = compat ? probe_kernel_read(dst, unsafe_ptr, size) :
-	      probe_kernel_read_strict(dst, unsafe_ptr, size);
-	if (unlikely(ret < 0))
-out:
 		memset(dst, 0, size);
 	return ret;
 }
 
-BPF_CALL_3(bpf_probe_read_compat, void *, dst, u32, size,
-	   const void *, unsafe_ptr)
+static __always_inline int
+bpf_probe_read_user_str_common(void *dst, u32 size,
+			       const void __user *unsafe_ptr)
 {
-	return bpf_probe_read_kernel_common(dst, size, unsafe_ptr, true);
+	int ret;
+
+	ret = strncpy_from_user_nofault(dst, unsafe_ptr, size);
+	if (unlikely(ret < 0))
+		memset(dst, 0, size);
+	return ret;
 }
 
-static const struct bpf_func_proto bpf_probe_read_compat_proto = {
-	.func		= bpf_probe_read_compat,
-	.gpl_only	= true,
-	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
-	.arg3_type	= ARG_ANYTHING,
-};
+static __always_inline int
+bpf_probe_read_kernel_common(void *dst, u32 size, const void *unsafe_ptr)
+{
+	int ret = security_locked_down(LOCKDOWN_BPF_READ);
+
+	if (unlikely(ret < 0))
+		goto fail;
+	ret = probe_kernel_read_strict(dst, unsafe_ptr, size);
+	if (unlikely(ret < 0))
+		goto fail;
+	return ret;
+fail:
+	memset(dst, 0, size);
+	return ret;
+}
 
 static __always_inline int
-bpf_probe_read_kernel_str_common(void *dst, u32 size, const void *unsafe_ptr,
-				 const bool compat)
+bpf_probe_read_kernel_str_common(void *dst, u32 size, const void *unsafe_ptr)
 {
 	int ret = security_locked_down(LOCKDOWN_BPF_READ);
 
 	if (unlikely(ret < 0))
-		goto out;
+		goto fail;
+
 	/*
-	 * The strncpy_from_unsafe_*() call will likely not fill the entire
-	 * buffer, but that's okay in this circumstance as we're probing
+	 * The strncpy_from_kernel_nofault() call will likely not fill the
+	 * entire buffer, but that's okay in this circumstance as we're probing
 	 * arbitrary memory anyway similar to bpf_probe_read_*() and might
 	 * as well probe the stack. Thus, memory is explicitly cleared
 	 * only in error case, so that improper users ignoring return
 	 * code altogether don't copy garbage; otherwise length of string
 	 * is returned that can be used for bpf_perf_event_output() et al.
 	 */
-	ret = compat ? strncpy_from_unsafe(dst, unsafe_ptr, size) :
-	      strncpy_from_kernel_nofault(dst, unsafe_ptr, size);
+	ret = strncpy_from_kernel_nofault(dst, unsafe_ptr, size);
 	if (unlikely(ret < 0))
-out:
-		memset(dst, 0, size);
+		goto fail;
+
+	return 0;
+fail:
+	memset(dst, 0, size);
 	return ret;
 }
 
+#ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
+BPF_CALL_3(bpf_probe_read_compat, void *, dst, u32, size,
+	   const void *, unsafe_ptr)
+{
+	if ((unsigned long)unsafe_ptr < TASK_SIZE) {
+		return bpf_probe_read_user_common(dst, size,
+				(__force void __user *)unsafe_ptr);
+	}
+	return bpf_probe_read_kernel_common(dst, size, unsafe_ptr);
+}
+
+static const struct bpf_func_proto bpf_probe_read_compat_proto = {
+	.func		= bpf_probe_read_compat,
+	.gpl_only	= true,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
+	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type	= ARG_ANYTHING,
+};
+
 BPF_CALL_3(bpf_probe_read_compat_str, void *, dst, u32, size,
 	   const void *, unsafe_ptr)
 {
-	return bpf_probe_read_kernel_str_common(dst, size, unsafe_ptr, true);
+	if ((unsigned long)unsafe_ptr < TASK_SIZE) {
+		return bpf_probe_read_user_str_common(dst, size,
+				(__force void __user *)unsafe_ptr);
+	}
+	return bpf_probe_read_kernel_str_common(dst, size, unsafe_ptr);
 }
 
 static const struct bpf_func_proto bpf_probe_read_compat_str_proto = {
@@ -208,6 +242,7 @@ static const struct bpf_func_proto bpf_probe_read_compat_str_proto = {
 	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg3_type	= ARG_ANYTHING,
 };
+#endif /* CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE */
 
 BPF_CALL_3(bpf_probe_write_user, void __user *, unsafe_ptr, const void *, src,
 	   u32, size)
-- 
2.40.1

