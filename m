Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8C37398AD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 09:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjFVH5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 03:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjFVH5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 03:57:40 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C215A19AD;
        Thu, 22 Jun 2023 00:57:37 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d9443c01a7336-1b6824141b4so2563275ad.1;
        Thu, 22 Jun 2023 00:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687420657; x=1690012657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UQHgCYMSUpJKwkxCT8Gz4j2ViWlUBZ9rAr/225IOUc=;
        b=g0no2cPqfVO8xjN017b6JROAufdBBjR1Wdd9+yaqpm7b1ckjHVlwIfzaDz1E9HPV0l
         BWjLl/79hf2y9EMezQlltv4MobG+gDt0uAKZoMFldLuDhlpONHoBh53ENcUgJeb9z/jm
         pGGCycbtFfex++XRk5PVmyFqkzzs67xPkzv1NG2Dhl0R1e/wCw7P1kJ+LuE2rxDpT0lM
         Fc4ulp9RGi3m3p43s2j8XZoqmH909zD6xAbFd+cGqV2nwyqSBz0FbjTXxBPkec8pTjmL
         RE+d6P2ef4OpdNrWH5HY3BReblfUgfU87YWBgz/1VxfnI4vWML6hHRigP2ATi4tF7so4
         nzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687420657; x=1690012657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UQHgCYMSUpJKwkxCT8Gz4j2ViWlUBZ9rAr/225IOUc=;
        b=dc/vYIgoSvprdsRTRbS/GoSiLc32BB0tJrkZJjyR6GZg26X63A9byjGScpy6WPTNTI
         Y9aLHo3rGYSvn34E3aAxJKFw8/0FrXPIuAIjC0do5vTerzxdWn9KwqcmDtBfKD9OGV61
         WcrLTx1+WrHEdMluhVJKo2L48UOk2lHqf6pD9Phuaeo+WXX2NvtMffNCLhYgNSJpKjjg
         JZbgVScWqfIphctqgA4unoUKQijQhA7RiJkhCDn0OgnN2djC2Cy390MhVWJPnx9N54Fa
         iW+z4xR1KuMvsqO2KFCChuXvlAwPP3pQg1m3wreHXK8XEKHEpuMGGIicMyOrZ4Z/4RhT
         Fsrg==
X-Gm-Message-State: AC+VfDww5/IMHskUMyWu7k2874aWAIx1m9gl0q/q1hQxwzn0J4mdX3DQ
        MdrxHzdEsMZ+O8qK/npExYM=
X-Google-Smtp-Source: ACHHUZ6ltY3XaVWNR0C/rO52PJJq6Yfrrgix/SXdo9NQ6iV0nH4+8LBx7MIhABu+AUx/J6QTh00M3Q==
X-Received: by 2002:a17:902:db04:b0:1b6:4bc2:74bc with SMTP id m4-20020a170902db0400b001b64bc274bcmr15584703plx.2.1687420657080;
        Thu, 22 Jun 2023 00:57:37 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.82])
        by smtp.gmail.com with ESMTPSA id iz3-20020a170902ef8300b001b3e84240b4sm4733338plb.67.2023.06.22.00.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 00:57:36 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     yhs@meta.com, alexei.starovoitov@gmail.com
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, benbjiang@tencent.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>
Subject: [PATCH bpf-next v7 1/3] bpf, x86: save/restore regs with BPF_DW size
Date:   Thu, 22 Jun 2023 15:57:13 +0800
Message-Id: <20230622075715.1818144-2-imagedong@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622075715.1818144-1-imagedong@tencent.com>
References: <20230622075715.1818144-1-imagedong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
index 1056bbf55b17..a407fbbffecd 100644
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

