Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F270070CB34
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbjEVUfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbjEVUeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:34:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B311510C;
        Mon, 22 May 2023 13:34:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 444F362BBB;
        Mon, 22 May 2023 20:34:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB531C433D2;
        Mon, 22 May 2023 20:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684787682;
        bh=1nSMve/w+XuFrnfWUZ8RsoJsky+kpG672VPmYmGZMVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OjIfMDYxThs+94da/eP9DyEKjk1djZsZmlgvOcUGIyktqWEeB8FDfqbvX2OvN1Ndg
         4LNUZF1YbqGcHFMGy/wYetTmlYq8TMdF5GxRgf8C25A1ztK1VriLnqHLM86GQymu+N
         UYv/1/079BM+ixi2hmsqeYBlLheImXe17wtzaveWoqaxNyL4B96eiccZWuQx+c9KKT
         iOIaHcGr+VxdNg5jK1RnmG9WcMbVc5OXeqScKHS85tqpBm4x+jT7qFp5OXLLDvS+75
         GEV8VDoTAwzMkTCEIWJ0XQq3rYjyuGT9eB7fuONVoKHETfPESc+IkYgvd4IDAy1o+Q
         7Mk933+rF7JDg==
From:   Jiri Olsa <jolsa@kernel.org>
To:     stable@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        bpf@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Mah=C3=A9=20Tardy?= <mahe.tardy@isovalent.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH stable 5.4 3/8] bpf: Restrict bpf_probe_read{, str}() only to archs where they work
Date:   Mon, 22 May 2023 22:33:47 +0200
Message-Id: <20230522203352.738576-4-jolsa@kernel.org>
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

From: Daniel Borkmann <daniel@iogearbox.net>

commit 0ebeea8ca8a4d1d453ad299aef0507dab04f6e8d upstream.

[Small context conflicts due to not bckported changes in previous patch]

Given the legacy bpf_probe_read{,str}() BPF helpers are broken on archs
with overlapping address ranges, we should really take the next step to
disable them from BPF use there.

To generally fix the situation, we've recently added new helper variants
bpf_probe_read_{user,kernel}() and bpf_probe_read_{user,kernel}_str().
For details on them, see 6ae08ae3dea2 ("bpf: Add probe_read_{user, kernel}
and probe_read_{user,kernel}_str helpers").

Given bpf_probe_read{,str}() have been around for ~5 years by now, there
are plenty of users at least on x86 still relying on them today, so we
cannot remove them entirely w/o breaking the BPF tracing ecosystem.

However, their use should be restricted to archs with non-overlapping
address ranges where they are working in their current form. Therefore,
move this behind a CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE and
have x86, arm64, arm select it (other archs supporting it can follow-up
on it as well).

For the remaining archs, they can workaround easily by relying on the
feature probe from bpftool which spills out defines that can be used out
of BPF C code to implement the drop-in replacement for old/new kernels
via: bpftool feature probe macro

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/bpf/20200515101118.6508-2-daniel@iogearbox.net
---
 arch/arm/Kconfig         | 1 +
 arch/arm64/Kconfig       | 1 +
 arch/x86/Kconfig         | 1 +
 init/Kconfig             | 3 +++
 kernel/trace/bpf_trace.c | 2 ++
 5 files changed, 8 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a70696a95b79..7c1cb0ebdb18 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -14,6 +14,7 @@ config ARM
 	select ARCH_HAS_KEEPINITRD
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
+	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PTE_SPECIAL if ARM_LPAE
 	select ARCH_HAS_PHYS_TO_DMA
 	select ARCH_HAS_SETUP_DMA_OPS
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 384b1bf56667..0d96acb2ca3e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -22,6 +22,7 @@ config ARM64
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_KEEPINITRD
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
+	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PTE_DEVMAP
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SETUP_DMA_OPS
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6002252692af..7be388116732 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -70,6 +70,7 @@ config X86
 	select ARCH_HAS_KCOV			if X86_64
 	select ARCH_HAS_MEM_ENCRYPT
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
+	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PMEM_API		if X86_64
 	select ARCH_HAS_PTE_DEVMAP		if X86_64
 	select ARCH_HAS_PTE_SPECIAL
diff --git a/init/Kconfig b/init/Kconfig
index f641518f4ac5..2297b7ce6665 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2231,6 +2231,9 @@ config ASN1
 
 source "kernel/Kconfig.locks"
 
+config ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
+	bool
+
 config ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 	bool
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 9ac27d48cc8e..61c81c38202b 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -737,10 +737,12 @@ tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_current_task_under_cgroup_proto;
 	case BPF_FUNC_get_prandom_u32:
 		return &bpf_get_prandom_u32_proto;
+#ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	case BPF_FUNC_probe_read:
 		return &bpf_probe_read_compat_proto;
 	case BPF_FUNC_probe_read_str:
 		return &bpf_probe_read_compat_str_proto;
+#endif
 #ifdef CONFIG_CGROUPS
 	case BPF_FUNC_get_current_cgroup_id:
 		return &bpf_get_current_cgroup_id_proto;
-- 
2.40.1

