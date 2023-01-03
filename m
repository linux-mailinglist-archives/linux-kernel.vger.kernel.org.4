Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29AB065C80E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 21:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238481AbjACU0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 15:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233937AbjACUZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 15:25:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4AB11472
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 12:25:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A259D614FE
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 20:25:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104F0C433F2;
        Tue,  3 Jan 2023 20:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672777541;
        bh=tm7z3a7e1dpUp7BcDdm5psXlFys9Y+jlcThdQocuGaE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=GdDp/KIBN0qrkw2lYv5TQueXUnahj+WhE4Ml+XDglEKFX1Gie4jRQ00fKMmz/GRcW
         aT4Zs88w98JpYOFstEl7tpWsQsxjwGLH8YrElaO4yJ6rumjIX24ooshqfEzR4ZOssA
         ttiEJmoe+BaRh0VD4nqYdD2VX8zdfpHM2qfWWn4rVriW1SU72Ex1aSnrNXI4cZd2RQ
         1Z4hxBNHrcFQRPDbFwF2YFQ2FiQwC6nCiYSyxXeJIPld1pBLJ9EkmatiDJs6A7sYVb
         7p88MYUpj7SI9jHzD7Aje90S3jEu/ugp3/PpSMEbu4IHJ8ZThwvTXN9mlLbrtBMqXf
         kDXIKKtSnI5Cg==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 03 Jan 2023 20:25:18 +0000
Subject: [PATCH v2 4/6] arm64/signal: Avoid rereading context frame sizes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221212-arm64-signal-cleanup-v2-4-14a8f3e088b7@kernel.org>
References: <20221212-arm64-signal-cleanup-v2-0-14a8f3e088b7@kernel.org>
In-Reply-To: <20221212-arm64-signal-cleanup-v2-0-14a8f3e088b7@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-214b3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4225; i=broonie@kernel.org;
 h=from:subject:message-id; bh=tm7z3a7e1dpUp7BcDdm5psXlFys9Y+jlcThdQocuGaE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjtI87xKgAdFEn5VkiKiBgPouDLRE9SqfWc8ILuuPT
 EuE12aCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY7SPOwAKCRAk1otyXVSH0FGlB/
 9Sbh85w0Zd93xBgkXHw7aoF2+e44NyDjC17RXGbyfiYDs/tDa+pNhkPcD4R9tJ6SA3/tHRsth+wSKx
 Apc0G2h+08XKWnPjaUIhIF8sypbJB5kUh1cJ9TVRhlU/7O5NIPFkhpxuRt4CG20onl0sFJZwUqsP3s
 jVblAE+fXSR/p+3V3CPue6wXlRf/5M0X3EC1yw2EYKouuoD6UP2AbOFI5nivJyb2JlaEA2r5y49SUD
 NSyD5ViY6e5m7dFn9E7dyJSJcUBOMMLvPxJfZsHVVfp9Et+BqXiIL0OZnqscylVlbKKw1rbWwlIZDK
 v2FNKL7gCW/fv6dgS3Pxnno5ANwtUX
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

We need to read the sizes of the signal context frames as part of parsing
the overall signal context in parse_user_sigframe(). In the cases where we
defer frame specific parsing to other functions those functions always
reread the size and validate the version they read, opening the possibility
that the value may change. Avoid this possibility by passing the size read
in parse_user_sigframe() through user_ctxs and referring to that.

Note that for SVE and ZA contexts we still read the size again but after
this change we no longer use the value, further changes will avoid the
read.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/signal.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index e9c6ffc1ebba..82a89b0852ee 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -170,8 +170,11 @@ static void __user *apply_user_offset(
 
 struct user_ctxs {
 	struct fpsimd_context __user *fpsimd;
+	u32 fpsimd_size;
 	struct sve_context __user *sve;
+	u32 sve_size;
 	struct za_context __user *za;
+	u32 za_size;
 };
 
 static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
@@ -195,14 +198,10 @@ static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
 static int restore_fpsimd_context(struct user_ctxs *user)
 {
 	struct user_fpsimd_state fpsimd;
-	__u32 size;
 	int err = 0;
 
 	/* check the size information */
-	__get_user_error(size, &user->fpsimd->head.size, err);
-	if (err)
-		return -EFAULT;
-	if (size != sizeof(struct fpsimd_context))
+	if (user->fpsimd_size != sizeof(struct fpsimd_context))
 		return -EINVAL;
 
 	/* copy the FP and status/control registers */
@@ -271,12 +270,12 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 	struct user_fpsimd_state fpsimd;
 	struct sve_context sve;
 
+	if (user->sve_size < sizeof(*user->sve))
+		return -EINVAL;
+
 	if (__copy_from_user(&sve, user->sve, sizeof(sve)))
 		return -EFAULT;
 
-	if (sve.head.size < sizeof(*user->sve))
-		return -EINVAL;
-
 	if (sve.flags & SVE_SIG_FLAG_SM) {
 		if (!system_supports_sme())
 			return -EINVAL;
@@ -292,7 +291,7 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 	if (sve.vl != vl)
 		return -EINVAL;
 
-	if (sve.head.size == sizeof(*user->sve)) {
+	if (user->sve_size == sizeof(*user->sve)) {
 		clear_thread_flag(TIF_SVE);
 		current->thread.svcr &= ~SVCR_SM_MASK;
 		current->thread.fp_type = FP_STATE_FPSIMD;
@@ -301,7 +300,7 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 
 	vq = sve_vq_from_vl(sve.vl);
 
-	if (sve.head.size < SVE_SIG_CONTEXT_SIZE(vq))
+	if (user->sve_size < SVE_SIG_CONTEXT_SIZE(vq))
 		return -EINVAL;
 
 	/*
@@ -404,23 +403,23 @@ static int restore_za_context(struct user_ctxs *user)
 	unsigned int vq;
 	struct za_context za;
 
+	if (user->za_size < sizeof(*user->za))
+		return -EINVAL;
+
 	if (__copy_from_user(&za, user->za, sizeof(za)))
 		return -EFAULT;
 
-	if (za.head.size < sizeof(*user->za))
-		return -EINVAL;
-
 	if (za.vl != task_get_sme_vl(current))
 		return -EINVAL;
 
-	if (za.head.size == sizeof(*user->za)) {
+	if (user->za_size == sizeof(*user->za)) {
 		current->thread.svcr &= ~SVCR_ZA_MASK;
 		return 0;
 	}
 
 	vq = sve_vq_from_vl(za.vl);
 
-	if (za.head.size < ZA_SIG_CONTEXT_SIZE(vq))
+	if (user->za_size < ZA_SIG_CONTEXT_SIZE(vq))
 		return -EINVAL;
 
 	/*
@@ -517,6 +516,7 @@ static int parse_user_sigframe(struct user_ctxs *user,
 				goto invalid;
 
 			user->fpsimd = (struct fpsimd_context __user *)head;
+			user->fpsimd_size = size;
 			break;
 
 		case ESR_MAGIC:
@@ -531,6 +531,7 @@ static int parse_user_sigframe(struct user_ctxs *user,
 				goto invalid;
 
 			user->sve = (struct sve_context __user *)head;
+			user->sve_size = size;
 			break;
 
 		case ZA_MAGIC:
@@ -541,6 +542,7 @@ static int parse_user_sigframe(struct user_ctxs *user,
 				goto invalid;
 
 			user->za = (struct za_context __user *)head;
+			user->za_size = size;
 			break;
 
 		case EXTRA_MAGIC:

-- 
2.30.2
