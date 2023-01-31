Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B58683936
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 23:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjAaWVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 17:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjAaWUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 17:20:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C237199
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:20:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57D1A6172A
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 22:20:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8258C433EF;
        Tue, 31 Jan 2023 22:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675203653;
        bh=Bvjd0wKL3IezF1RIcyZzfYSmixW4eXGxsRFPUFTikY0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=GxyNY8Gigyx5SY8G0zQZa8KeGq3ntE8x1y2m01Dro0WF5AAd+l5nMh/c0R2ZHLKmi
         PGYQcCGgSNDd/Xaiwh3ILsT/De0jXoHGOzhNViJijVJ9s25Wyzqu/GQJ5BXQuCzaJ4
         mFS5X1cPpfurTqhj0TQp3jyorjDdjZHQ+9ETgF1Ml/swjaxEyM/fm0A9pX1HYoht9m
         FeJNMGW4sct1SGWGG0LV0dDnZ/bUjJCuwvAlOFFFVP6yp1SM/GlNd80Q9BoWFebGBQ
         BzU5ezwoTPRIaaInYZCIuhmV6Vgsb1gsgqZAQBji6wPWoIotDm++QqKoTSDrSvMjco
         eAMsTxk0RZ1eg==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 31 Jan 2023 22:20:40 +0000
Subject: [PATCH v3 2/7] arm64/signal: Remove redundant size validation from
 parse_user_sigframe()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221212-arm64-signal-cleanup-v3-2-4545c94b20ff@kernel.org>
References: <20221212-arm64-signal-cleanup-v3-0-4545c94b20ff@kernel.org>
In-Reply-To: <20221212-arm64-signal-cleanup-v3-0-4545c94b20ff@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2702; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Bvjd0wKL3IezF1RIcyZzfYSmixW4eXGxsRFPUFTikY0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBj2ZQ8fd+t/jv/LtlkcIgmR1L3zvdjC5XmHVLvRKFX
 udHpDpKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY9mUPAAKCRAk1otyXVSH0HgYB/
 99cPZKE0Jkozh61lbraxE3reOXEccVY9lpN7tzcIvqReeuet0AHZ+telIRwHBbWbsWtU3GC1LHZgDb
 2CB6F04ZbOiTMc1PwWif8GQguQHb1RiYpqsN+pZvkfnqP40Ev6gTH4x8IqvirzRjPYMK1PlMr2vAni
 oqLjclS6m16x2W92tLfs+Ef5OP+UISV5j3qF0dmr4X7VAuxfF7VbdLBme4hI9WVc9Yev+0XCCq9q8Q
 Lb0QNdA0UxDcRqF30M6eSaugjbzfbJdFWtrfky5OxLIS+/gBMfqckn5POSyg5h2Rk5lJdRiB5B9Ier
 im2YmCNBn2guclR3inEEHjis4e26+k
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

There is some minimal size validation in parse_user_sigframe() however
all of the individual parsing functions perform frame specific validation
of the sizing information, remove the frame specific size checks in the
core so that there isn't any confusion about what we validate for size.

Since the checks in the SVE and ZA parsing are after we have read the
relevant context and since they won't report an error if the frame is
undersized they are adjusted to check for this before doing anything else.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/signal.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 882f6d913508..3228b5a1dfe3 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -278,6 +278,9 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 	if (__copy_from_user(&sve, user->sve, sizeof(sve)))
 		return -EFAULT;
 
+	if (sve.head.size < sizeof(*user->sve))
+		return -EINVAL;
+
 	if (sve.flags & SVE_SIG_FLAG_SM) {
 		if (!system_supports_sme())
 			return -EINVAL;
@@ -293,7 +296,7 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 	if (sve.vl != vl)
 		return -EINVAL;
 
-	if (sve.head.size <= sizeof(*user->sve)) {
+	if (sve.head.size == sizeof(*user->sve)) {
 		clear_thread_flag(TIF_SVE);
 		current->thread.svcr &= ~SVCR_SM_MASK;
 		current->thread.fp_type = FP_STATE_FPSIMD;
@@ -434,10 +437,13 @@ static int restore_za_context(struct user_ctxs *user)
 	if (__copy_from_user(&za, user->za, sizeof(za)))
 		return -EFAULT;
 
+	if (za.head.size < sizeof(*user->za))
+		return -EINVAL;
+
 	if (za.vl != task_get_sme_vl(current))
 		return -EINVAL;
 
-	if (za.head.size <= sizeof(*user->za)) {
+	if (za.head.size == sizeof(*user->za)) {
 		current->thread.svcr &= ~SVCR_ZA_MASK;
 		return 0;
 	}
@@ -614,9 +620,6 @@ static int parse_user_sigframe(struct user_ctxs *user,
 			if (user->fpsimd)
 				goto invalid;
 
-			if (size < sizeof(*user->fpsimd))
-				goto invalid;
-
 			user->fpsimd = (struct fpsimd_context __user *)head;
 			break;
 
@@ -631,9 +634,6 @@ static int parse_user_sigframe(struct user_ctxs *user,
 			if (user->sve)
 				goto invalid;
 
-			if (size < sizeof(*user->sve))
-				goto invalid;
-
 			user->sve = (struct sve_context __user *)head;
 			break;
 
@@ -657,9 +657,6 @@ static int parse_user_sigframe(struct user_ctxs *user,
 			if (user->za)
 				goto invalid;
 
-			if (size < sizeof(*user->za))
-				goto invalid;
-
 			user->za = (struct za_context __user *)head;
 			break;
 

-- 
2.30.2

