Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B3965C80C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 21:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238559AbjACU0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 15:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238336AbjACUZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 15:25:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967C0140C4
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 12:25:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FABD61505
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 20:25:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE24C433D2;
        Tue,  3 Jan 2023 20:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672777539;
        bh=m/i01gOUfGyH1isH9K2Vdw5gOTY2fsfv2BhXcFDefdw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=GQHtas3Q10YUpJ1JIhQT+4m0IWcorj3gxw/dRyZvENJ+oMLG22cm629b3Tl+Ukq3V
         stoEO46Kpel+EyY0ETyMONc8cCxLwcZ5oG76Z7VGL2ird2CATT9z1zBWbFmQECJT+R
         L0OmMrQEhxA1h2XTlvOdTb8tl0Qj8x7Y0fK3LXGom6+l4VTfGq2/em5ZsclN39FKxS
         a38Pqag8lioq2nKwl/QCB7XP4gRjBtRp01a4Orqexe8TkXnH/0BQduTcIv4ZIZ9/vt
         mDSbIrUh1Iqf9em4z+opqF4zJ+6iTdhVfEEd6w70WUD+mT/2QaZLihtOoy4PrrQExl
         zjHaZr3VnvlsQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 03 Jan 2023 20:25:17 +0000
Subject: [PATCH v2 3/6] arm64/signal: Make interface for
 restore_fpsimd_context() consistent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221212-arm64-signal-cleanup-v2-3-14a8f3e088b7@kernel.org>
References: <20221212-arm64-signal-cleanup-v2-0-14a8f3e088b7@kernel.org>
In-Reply-To: <20221212-arm64-signal-cleanup-v2-0-14a8f3e088b7@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-214b3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2830; i=broonie@kernel.org;
 h=from:subject:message-id; bh=m/i01gOUfGyH1isH9K2Vdw5gOTY2fsfv2BhXcFDefdw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjtI860ynH1NRfkt0zjncUSHTijMZP7XY9Q6c0kfBo
 H1rE2WaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY7SPOgAKCRAk1otyXVSH0GwWB/
 sEpN5A1l4gTcIxiZ9ARTdx4xO6CDsVEzVFHIvD1DCps3muwtLfwF2IMXpNXvlNdIo5OQVPMO4Z/EXt
 ak1Wx+e8zqNLKK/vr4IUjSzmYqNSB3Yw5JbKrAJM7ca+imSGdqRvAvVYHV/CE4nN87FeKhDKqWBW2s
 IMQHMJzUvnz8Sx13F9RK01k3pUR7b8WdKbusvn3RaDiojRYSDYkuJsQoDsh+t/01uBAKQo4MXCf5b5
 RJ9Lni1o+y4uHwSPHzU0jihGEo4iEPtx6CX/GMaB/ZBnY/RJGRLnPF16MM/1Y81h4VlJwSCLOCOU2D
 URFwleBalMV9NscCMJvFteHr2kguzA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of taking a pointer to struct user_ctxs like the other two
restore_blah_context() functions the FPSIMD function takes a pointer to the
user struct it should read. Change it to be consistent with the rest, both
for consistency and to prepare for changes which avoid rereading data that
has already been read by the core parsing code.

There should be no functional change from this patch.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/signal.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index a7b4bb584d17..e9c6ffc1ebba 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -168,6 +168,12 @@ static void __user *apply_user_offset(
 	return base + offset;
 }
 
+struct user_ctxs {
+	struct fpsimd_context __user *fpsimd;
+	struct sve_context __user *sve;
+	struct za_context __user *za;
+};
+
 static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
 {
 	struct user_fpsimd_state const *fpsimd =
@@ -186,24 +192,24 @@ static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
 	return err ? -EFAULT : 0;
 }
 
-static int restore_fpsimd_context(struct fpsimd_context __user *ctx)
+static int restore_fpsimd_context(struct user_ctxs *user)
 {
 	struct user_fpsimd_state fpsimd;
 	__u32 size;
 	int err = 0;
 
 	/* check the size information */
-	__get_user_error(size, &ctx->head.size, err);
+	__get_user_error(size, &user->fpsimd->head.size, err);
 	if (err)
 		return -EFAULT;
 	if (size != sizeof(struct fpsimd_context))
 		return -EINVAL;
 
 	/* copy the FP and status/control registers */
-	err = __copy_from_user(fpsimd.vregs, ctx->vregs,
+	err = __copy_from_user(fpsimd.vregs, &(user->fpsimd->vregs),
 			       sizeof(fpsimd.vregs));
-	__get_user_error(fpsimd.fpsr, &ctx->fpsr, err);
-	__get_user_error(fpsimd.fpcr, &ctx->fpcr, err);
+	__get_user_error(fpsimd.fpsr, &(user->fpsimd->fpsr), err);
+	__get_user_error(fpsimd.fpcr, &(user->fpsimd->fpcr), err);
 
 	clear_thread_flag(TIF_SVE);
 	current->thread.fp_type = FP_STATE_FPSIMD;
@@ -216,12 +222,6 @@ static int restore_fpsimd_context(struct fpsimd_context __user *ctx)
 }
 
 
-struct user_ctxs {
-	struct fpsimd_context __user *fpsimd;
-	struct sve_context __user *sve;
-	struct za_context __user *za;
-};
-
 #ifdef CONFIG_ARM64_SVE
 
 static int preserve_sve_context(struct sve_context __user *ctx)
@@ -659,7 +659,7 @@ static int restore_sigframe(struct pt_regs *regs,
 		if (user.sve)
 			err = restore_sve_fpsimd_context(&user);
 		else
-			err = restore_fpsimd_context(user.fpsimd);
+			err = restore_fpsimd_context(&user);
 	}
 
 	if (err == 0 && system_supports_sme() && user.za)

-- 
2.30.2
