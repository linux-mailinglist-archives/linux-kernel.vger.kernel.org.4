Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F5870E5F0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 21:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238489AbjEWTtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 15:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjEWTtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 15:49:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26E2119
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 12:49:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C81162701
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 19:49:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3827C433D2;
        Tue, 23 May 2023 19:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684871377;
        bh=wGtFDXPE8CltQmJ9Fbh/aecZq2T4bSX/gGoZYsF+49Q=;
        h=From:To:Cc:Subject:Date:From;
        b=oMQbKI0Nj0UwqawJ3TbFjDbSkvvztGzzZjp2YrN7OJvYD+vJFcZCyydU6kdAJQjhu
         NAlf2lrJzRw5flZWTMAMVarPR/j+i1+s333STkNgcKC2cmhqD+TV/lxHwaAyeRWBqH
         PRfd5PM1IShFAHDWpWoSLNJVVA0y3J/bpB5eLiyu4bdEVMMrA65OVDUwgFr05NZUFT
         u8C+RcCuK4Knv0x+eE6T3SxhPx50u5Mncc97c4i2rY4v9dMbN2QRaj4dFiP8oDHsC9
         kaDktqxoy/vLFovbKxqjj00KfGQLlupsY3cYfXtMJNNNst74ncHlF+ag5Vyt0i3npL
         cASbX5JTIUp/Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] [v2] bpf: hide unused bpf_patch_call_args
Date:   Tue, 23 May 2023 21:43:06 +0200
Message-Id: <20230523194930.2116181-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

From: Arnd Bergmann <arnd@arndb.de>

This function has no callers and no declaration when CONFIG_BPF_JIT_ALWAYS_ON
is enabled:

kernel/bpf/core.c:2075:6: error: no previous prototype for 'bpf_patch_call_args' [-Werror=missing-prototypes]

Hide the definition as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: change indentation to align arguments better. Still not great
as the line is just too long
---
 kernel/bpf/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 7421487422d4..0926714641eb 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2064,14 +2064,16 @@ EVAL4(PROG_NAME_LIST, 416, 448, 480, 512)
 };
 #undef PROG_NAME_LIST
 #define PROG_NAME_LIST(stack_size) PROG_NAME_ARGS(stack_size),
-static u64 (*interpreters_args[])(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5,
-				  const struct bpf_insn *insn) = {
+static __maybe_unused
+u64 (*interpreters_args[])(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5,
+			   const struct bpf_insn *insn) = {
 EVAL6(PROG_NAME_LIST, 32, 64, 96, 128, 160, 192)
 EVAL6(PROG_NAME_LIST, 224, 256, 288, 320, 352, 384)
 EVAL4(PROG_NAME_LIST, 416, 448, 480, 512)
 };
 #undef PROG_NAME_LIST
 
+#ifdef CONFIG_BPF_SYSCALL
 void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
 {
 	stack_depth = max_t(u32, stack_depth, 1);
@@ -2080,6 +2082,7 @@ void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
 		__bpf_call_base_args;
 	insn->code = BPF_JMP | BPF_CALL_ARGS;
 }
+#endif
 
 #else
 static unsigned int __bpf_prog_ret0_warn(const void *ctx,
-- 
2.39.2

