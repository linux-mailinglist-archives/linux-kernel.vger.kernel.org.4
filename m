Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3E57203BC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbjFBNvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjFBNvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:51:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060D1137
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 06:51:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97DD26100A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 13:51:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BA4C433D2;
        Fri,  2 Jun 2023 13:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685713897;
        bh=+FsSpx9RH7B04NclB3EiDSdjh3wRRkb9YV3Jl0GU0lc=;
        h=From:To:Cc:Subject:Date:From;
        b=ImH0SK4xMGhP5BS50S2vxwDTc+bpUVKnvvZjh7vAUdBlhNZMJysg3FXiYW8H6EkN/
         UgkvcuTKbQqVz4wvwQ3QO8S6g9oVMGJSyyvWTGmlUOLe/0/dE+18ECounmjtPb4diM
         mRHFBW5qp2ooJ2KsVn7pbkE+867c5SoCklzFvLUpKQV/tB/dXZloj6Kf5hf6Occ6mw
         Zb1mGaUEITebvwkKJ9px3QU6VoCROvvl0mTAgxRbUgkAdsFxG2Qc9zlL20muWFexkn
         aFAc/sr/8x5vtC5yCu2zBulNEG0XNwTUZxPakRGMIa9OtNDsR7GMzjgGGFXiOoMHTN
         qSHCZ4+FSD2MA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Yonghong Song <yhs@meta.com>, Alexei Starovoitov <ast@kernel.org>,
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
Subject: [PATCH 1/2] [v3] bpf: hide unused bpf_patch_call_args
Date:   Fri,  2 Jun 2023 15:50:18 +0200
Message-Id: <20230602135128.1498362-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This function is only used when CONFIG_BPF_JIT_ALWAYS_ON is disabled,
but CONFIG_BPF_SYSCALL is enabled. When both are turned off, the
prototype is missing but the unused function is still compiled,
as seen from this W=1 warning:

kernel/bpf/core.c:2075:6: error: no previous prototype for 'bpf_patch_call_args' [-Werror=missing-prototypes]

Add a matching #ifdef for the definition to leave it out.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v3: fix incorrect changelog text
v2: change indentation to align arguments better. Still not great
as the line is just too long
---
 kernel/bpf/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 7421487422d48..0926714641eb5 100644
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

