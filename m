Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3101970E5F2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 21:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238505AbjEWTuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 15:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238492AbjEWTuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 15:50:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C9D184;
        Tue, 23 May 2023 12:50:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C13D629C6;
        Tue, 23 May 2023 19:50:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB75C433D2;
        Tue, 23 May 2023 19:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684871402;
        bh=fBS/TFMmP5wWRy24F52O1gwfStwYk0nNfHkwST2oexI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NG455Tl0vWLpNic92+yDmnydWpWAOAAxtUmp/dTwFggd4/CtMVMKZIqB6o9vFVF7p
         8ZDXi/cDVJA+QrAgVNU7tQMV9jCFKsRMWPLtUSJ+xCfIELMXFWu1TRAbynXFmudQgG
         aiILmeO+z++iOIYl7sPUdbqKgBD4n1b94lSXjEpFUVd1qahQuPj5FItjnq7Jc3NJF0
         zWet0be6sE9jG5K99mRyWsiTFKPy/Nusdokl4atQTRDYWZ+Oy4QZnfzAjR9q/3OKRs
         7E/1vAWF3Hx8Eo7hMopeUmge8NDk8zlNHs8cjjORHyVNWUOsZUbb670U8CMOqTpidz
         XARRjGUWtsBRw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        Delyan Kratunov <delyank@fb.com>,
        Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/2] [v2] bpf: fix bpf_probe_read_kernel prototype mismatch
Date:   Tue, 23 May 2023 21:43:07 +0200
Message-Id: <20230523194930.2116181-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230523194930.2116181-1-arnd@kernel.org>
References: <20230523194930.2116181-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

bpf_probe_read_kernel() has a __weak definition in core.c and another
definition with an incompatible prototype in kernel/trace/bpf_trace.c,
when CONFIG_BPF_EVENTS is enabled.

Since the two are incompatible, there cannot be a shared declaration
in a header file, but the lack of a prototype causes a W=1 warning:

kernel/bpf/core.c:1638:12: error: no previous prototype for 'bpf_probe_read_kernel' [-Werror=missing-prototypes]

Change the core.c file to only reference the inner
bpf_probe_read_kernel_common() helper and provide a prototype for that.

Aside from the warning, this addresses a bug on 32-bit architectures
from incorrect argument passing with the mismatched prototype.

Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
--
v2: rewrite completely to fix the mismatch.
---
 include/linux/bpf.h      | 2 ++
 kernel/bpf/core.c        | 9 ++++++---
 kernel/trace/bpf_trace.c | 3 +--
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 36e4b2d8cca2..6a231ec61a87 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2619,6 +2619,8 @@ static inline void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr)
 }
 #endif /* CONFIG_BPF_SYSCALL */
 
+int bpf_probe_read_kernel_common(void *dst, u32 size, const void *unsafe_ptr);
+
 void __bpf_free_used_btfs(struct bpf_prog_aux *aux,
 			  struct btf_mod_pair *used_btfs, u32 len);
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 0926714641eb..e7f0d5f146fa 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -35,6 +35,7 @@
 #include <linux/bpf_verifier.h>
 #include <linux/nodemask.h>
 #include <linux/nospec.h>
+#include <linux/bpf.h>
 #include <linux/bpf_mem_alloc.h>
 #include <linux/memcontrol.h>
 
@@ -1635,11 +1636,13 @@ bool bpf_opcode_in_insntable(u8 code)
 }
 
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
-u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
+#ifndef CONFIG_BPF_EVENTS
+int bpf_probe_read_kernel_common(void * dst, u32 size, const void *unsafe_ptr)
 {
 	memset(dst, 0, size);
 	return -EFAULT;
 }
+#endif
 
 /**
  *	___bpf_prog_run - run eBPF program on a given context
@@ -1931,8 +1934,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
 		DST = *(SIZE *)(unsigned long) (SRC + insn->off);	\
 		CONT;							\
 	LDX_PROBE_MEM_##SIZEOP:						\
-		bpf_probe_read_kernel(&DST, sizeof(SIZE),		\
-				      (const void *)(long) (SRC + insn->off));	\
+		bpf_probe_read_kernel_common(&DST, sizeof(SIZE),	\
+			      (const void *)(long) (SRC + insn->off));	\
 		DST = *((SIZE *)&DST);					\
 		CONT;
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 2bc41e6ac9fe..290fdce2ce53 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -223,8 +223,7 @@ const struct bpf_func_proto bpf_probe_read_user_str_proto = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
-static __always_inline int
-bpf_probe_read_kernel_common(void *dst, u32 size, const void *unsafe_ptr)
+int bpf_probe_read_kernel_common(void *dst, u32 size, const void *unsafe_ptr)
 {
 	int ret;
 
-- 
2.39.2

