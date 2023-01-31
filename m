Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A9F683937
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 23:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjAaWVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 17:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbjAaWU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 17:20:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336928A67
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:20:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4CE261735
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 22:20:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E1AC4339E;
        Tue, 31 Jan 2023 22:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675203655;
        bh=YpH6fafYhYf6x8eZ1M52Uvm+n4ibYwRkXd68E+NmahA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ptf92ot01JM8ibIKFVKAzJ8iWzbEdOzZCbejJ0uCr7PWP9R6hM/F1WU6KLOw9YxQQ
         M1ej0b6SM3h7UP/t9eTKeFU+QIvkaOzCQanpctrZXcU//Tjg1JCJS9F6fbU6kQhc20
         t/EXSrh61ZvBYv6S8ta8b55bjIX7Oajv/TvjKMON6I8XM2bPCLzjy+oKXZvIM2smJW
         K/Q1zgKAiIOrb833XbJcyw6i+VN3C10jsabz/wd4c2DxmGCbkKemheBQo80/XZTxAo
         Ts7tEupTB5e30U+tIXkMGv1pi7CGhnXbmJNkZybd/k0HH0ufX4HCC3g197B8MVOve4
         w4o+rJtOREWqA==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 31 Jan 2023 22:20:41 +0000
Subject: [PATCH v3 3/7] arm64/signal: Make interface for
 restore_fpsimd_context() consistent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221212-arm64-signal-cleanup-v3-3-4545c94b20ff@kernel.org>
References: <20221212-arm64-signal-cleanup-v3-0-4545c94b20ff@kernel.org>
In-Reply-To: <20221212-arm64-signal-cleanup-v3-0-4545c94b20ff@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2986; i=broonie@kernel.org;
 h=from:subject:message-id; bh=YpH6fafYhYf6x8eZ1M52Uvm+n4ibYwRkXd68E+NmahA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBj2ZQ9fHCnj8dkZztyALYAHjjyd8EPZIlYCtsqjP5c
 GDSfij2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY9mUPQAKCRAk1otyXVSH0FS4B/
 4zVVkW0f2BCTCH7L1lh6Da+09h/d60AJzBcMEyfUVqKXwQ9elJsAklmELyXt9gvN57iRvLLkdsBbDF
 7Ahk8fmDgYwtcLi/KoQhb4v8O9niZ1z1Afx7v0SmEtVW4S45D6ZmkrdeIGNtiG0FlfgURY9vfMaij+
 si5mj9Hhxrkjtiys7goDhYcxx1qorL64r7VVlU5D0QnCKVbNRG8j3/oi1c+0HiMnjolDv+oGXQ9W3B
 xfAm6UBYgzilpRgadLDGiWVSECiBVinF/TbEVCqtHOXmR9JSmybB0LoMFQSgTJJPIRAmJsVSrADaI3
 Te3LClDqPCtl1FrF9xJzO/REvVwnNg
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
 arch/arm64/kernel/signal.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 3228b5a1dfe3..49321871783d 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -170,6 +170,14 @@ static void __user *apply_user_offset(
 	return base + offset;
 }
 
+struct user_ctxs {
+	struct fpsimd_context __user *fpsimd;
+	struct sve_context __user *sve;
+	struct tpidr2_context __user *tpidr2;
+	struct za_context __user *za;
+	struct zt_context __user *zt;
+};
+
 static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
 {
 	struct user_fpsimd_state const *fpsimd =
@@ -188,24 +196,24 @@ static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
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
@@ -218,14 +226,6 @@ static int restore_fpsimd_context(struct fpsimd_context __user *ctx)
 }
 
 
-struct user_ctxs {
-	struct fpsimd_context __user *fpsimd;
-	struct sve_context __user *sve;
-	struct tpidr2_context __user *tpidr2;
-	struct za_context __user *za;
-	struct zt_context __user *zt;
-};
-
 #ifdef CONFIG_ARM64_SVE
 
 static int preserve_sve_context(struct sve_context __user *ctx)
@@ -789,7 +789,7 @@ static int restore_sigframe(struct pt_regs *regs,
 		if (user.sve)
 			err = restore_sve_fpsimd_context(&user);
 		else
-			err = restore_fpsimd_context(user.fpsimd);
+			err = restore_fpsimd_context(&user);
 	}
 
 	if (err == 0 && system_supports_sme() && user.tpidr2)

-- 
2.30.2

