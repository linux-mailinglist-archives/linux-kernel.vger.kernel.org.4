Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5092750202
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbjGLIui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjGLIuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:50:35 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9ECA9;
        Wed, 12 Jul 2023 01:50:34 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id 5614622812f47-3a337ddff16so5131668b6e.0;
        Wed, 12 Jul 2023 01:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689151833; x=1691743833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9OF5rBDxNaq2DXKTbLZbdXHNFefw4Fd6mHFek0g5ew=;
        b=GqZC724uRGB8EI7NVoL2gpkWJhwqtLUoh/F5Etq9pXusL2ZNU1vzfcH1RBUmIGSaqL
         aPmiWfgRrwiDmryFst9e6cdX0ndOSyHKV+aN2G7oTSCaoTrapTi/R+Jz/Z2bXRRaSJgl
         LKOFBZfGPM3kNvH/3AzyTgCGky03cWJ10FpZpmf5eacIGCPr3e0GrbB/xRMDY+1flKBh
         RfqoaWZM4wKgzVzyQkI8vWd1r9rwp6yKWqMvlOK4qN9Bk2OxDgwiT/sIfkYGVtDs4oh0
         E0L2kdfzsg7O7k0P7a30qUo5OVz5Ey6pCz8m3bmG0tL6SNnOSrqsxRuBoKYlxhcMlWtq
         Ap5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689151833; x=1691743833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n9OF5rBDxNaq2DXKTbLZbdXHNFefw4Fd6mHFek0g5ew=;
        b=KXTYDSFI+u0A7K+96QzwyE2HBjTMv00LMMPST5meNUyclb+aoVtmNTTxEPLTsUze6A
         1dFdpocTteuF0UvS4xezTvqbBY1Ie41jmCx1rcR5u2rVM9FjMn8nePR1Lu3d3uQmvuhh
         UiV2cvK31CdjwUuATJ9zrRChpzC7jqRXBE25nyQEw3ji+Ycu4fs/w9HvAkBMVvqH18rJ
         LGFj4eMJp/ZF+KuRAhwvluj7W/gPlJIg76B70nwVqvBaYIM2OlbUMiIA8B26Z134VGT6
         Pf6SLtUh6+1mOhKi9yUgAbW424MEd5hp88eEo71YZujGKNYFTN9O4qHK/xzmO6RKDOsu
         tTIw==
X-Gm-Message-State: ABy/qLbXRdEFZmlR7Jrcpnwurnfg30DP+FkWtjnfKqw4PRisEjZX3AGw
        HefaQSf1WRHECX2FhU0Sw5w=
X-Google-Smtp-Source: APBJJlF/H5vtJvQjmKe2xarfkyIPhIvsykpKtkX/5/jdXEDnHjMwAHUyQUR5TQGXworB36BWI5dtNw==
X-Received: by 2002:a54:478d:0:b0:3a3:7e62:fca2 with SMTP id o13-20020a54478d000000b003a37e62fca2mr16189582oic.0.1689151833397;
        Wed, 12 Jul 2023 01:50:33 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.11])
        by smtp.gmail.com with ESMTPSA id e26-20020a62aa1a000000b006749c22d079sm3037066pff.167.2023.07.12.01.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 01:50:33 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     yhs@meta.com, daniel@iogearbox.net, alexei.starovoitov@gmail.com
Cc:     ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        dsahern@kernel.org, jolsa@kernel.org, x86@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Menglong Dong <imagedong@tencent.com>
Subject: [PATCH bpf-next v9 1/3] bpf, x86: save/restore regs with BPF_DW size
Date:   Wed, 12 Jul 2023 16:47:44 +0800
Message-Id: <20230712084746.833965-2-imagedong@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230712084746.833965-1-imagedong@tencent.com>
References: <20230712084746.833965-1-imagedong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Menglong Dong <imagedong@tencent.com>

As we already reserve 8 byte in the stack for each reg, it is ok to
store/restore the regs in BPF_DW size. This will make the code in
save_regs()/restore_regs() simpler.

Signed-off-by: Menglong Dong <imagedong@tencent.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
v6:
- adjust the commit log
---
 arch/x86/net/bpf_jit_comp.c | 35 ++++++-----------------------------
 1 file changed, 6 insertions(+), 29 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 438adb695daa..fcbd3b7123a4 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1860,57 +1860,34 @@ st:			if (is_imm8(insn->off))
 static void save_regs(const struct btf_func_model *m, u8 **prog, int nr_regs,
 		      int stack_size)
 {
-	int i, j, arg_size;
-	bool next_same_struct = false;
+	int i;
 
 	/* Store function arguments to stack.
 	 * For a function that accepts two pointers the sequence will be:
 	 * mov QWORD PTR [rbp-0x10],rdi
 	 * mov QWORD PTR [rbp-0x8],rsi
 	 */
-	for (i = 0, j = 0; i < min(nr_regs, 6); i++) {
-		/* The arg_size is at most 16 bytes, enforced by the verifier. */
-		arg_size = m->arg_size[j];
-		if (arg_size > 8) {
-			arg_size = 8;
-			next_same_struct = !next_same_struct;
-		}
-
-		emit_stx(prog, bytes_to_bpf_size(arg_size),
-			 BPF_REG_FP,
+	for (i = 0; i < min(nr_regs, 6); i++)
+		emit_stx(prog, BPF_DW, BPF_REG_FP,
 			 i == 5 ? X86_REG_R9 : BPF_REG_1 + i,
 			 -(stack_size - i * 8));
-
-		j = next_same_struct ? j : j + 1;
-	}
 }
 
 static void restore_regs(const struct btf_func_model *m, u8 **prog, int nr_regs,
 			 int stack_size)
 {
-	int i, j, arg_size;
-	bool next_same_struct = false;
+	int i;
 
 	/* Restore function arguments from stack.
 	 * For a function that accepts two pointers the sequence will be:
 	 * EMIT4(0x48, 0x8B, 0x7D, 0xF0); mov rdi,QWORD PTR [rbp-0x10]
 	 * EMIT4(0x48, 0x8B, 0x75, 0xF8); mov rsi,QWORD PTR [rbp-0x8]
 	 */
-	for (i = 0, j = 0; i < min(nr_regs, 6); i++) {
-		/* The arg_size is at most 16 bytes, enforced by the verifier. */
-		arg_size = m->arg_size[j];
-		if (arg_size > 8) {
-			arg_size = 8;
-			next_same_struct = !next_same_struct;
-		}
-
-		emit_ldx(prog, bytes_to_bpf_size(arg_size),
+	for (i = 0; i < min(nr_regs, 6); i++)
+		emit_ldx(prog, BPF_DW,
 			 i == 5 ? X86_REG_R9 : BPF_REG_1 + i,
 			 BPF_REG_FP,
 			 -(stack_size - i * 8));
-
-		j = next_same_struct ? j : j + 1;
-	}
 }
 
 static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
-- 
2.40.1

