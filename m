Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140D265C80A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 21:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237959AbjACUZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 15:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238270AbjACUZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 15:25:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321AD140F4
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 12:25:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B77E46150C
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 20:25:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA21C433EF;
        Tue,  3 Jan 2023 20:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672777538;
        bh=x+GcchtGQYQlLai5+CmXMMkSiw5EhNLH81SImALJnoU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=atZioraLtfipKzb/gvK5yhLPjflghimV3TvgC2ZebNAsQJy8DfVaq+O7rnYfidsMU
         jpAQ8PP+THbR0IeKguJoQR45bdRhiztILjS4GmXO9iVNQNYKnvR/tf8dNxtB0Iu+Q2
         WCb1f2YRz0tYxhaDRuN0oxv9Ty93NL8Rttb8aGzeN3TXWIP0soiZMUcgwFnwQVBD0f
         7853MFNggpNdn/6MVCG+Ebnnqyps5iCLcGpaIO1SQ4KcDg/I8KqCWTGQ4tvlwreQY8
         fS7vDh5f3FApODEM9Bsf3Dmq4lVWxUO2ec+psA1OWMlgm/nsLGvc41FTiIOAjfEvm0
         YQrAiEBYj8e9w==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 03 Jan 2023 20:25:16 +0000
Subject: [PATCH v2 2/6] arm64/signal: Remove redundant size validation from
 parse_user_sigframe()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221212-arm64-signal-cleanup-v2-2-14a8f3e088b7@kernel.org>
References: <20221212-arm64-signal-cleanup-v2-0-14a8f3e088b7@kernel.org>
In-Reply-To: <20221212-arm64-signal-cleanup-v2-0-14a8f3e088b7@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-214b3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2702; i=broonie@kernel.org;
 h=from:subject:message-id; bh=x+GcchtGQYQlLai5+CmXMMkSiw5EhNLH81SImALJnoU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjtI85bDh+bOarIH4knGB/z8JxY1l40IEwpTz1YryH
 ifnKvo+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY7SPOQAKCRAk1otyXVSH0Eq0B/
 9JVDlOxCNJR3j7nZcG2xkBNML//sZkZxAKPdNhA8Nco5iJy60qjGNl55augVclshngRMKjyy6IvM2e
 PLurtzrwQKV4CH0qc7dqRYPXo9zMN4wuwW4sJ1FK4Qm/lqXME6uOIWoGgBje4ZfwdfbvoG0up9pIwn
 2mbZ/p+9HfXqll9G5RbRQT9phdCckO8qh+UqxGV8+Ewgq625I95pShkfb5q3/0SYTF5Xpg8dT0UK4t
 FTjjTEVnJDesKhYLxvLND/rhSlOulgiu6T0hCAmZAajtwYO40Y345Qy48mRjaWzJ5UieSK1AJaRZOy
 7Vc1gJnhpBczsW/F/Pemi9/B4YuCBW
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
index 9d3d10269da7..a7b4bb584d17 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -274,6 +274,9 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 	if (__copy_from_user(&sve, user->sve, sizeof(sve)))
 		return -EFAULT;
 
+	if (sve.head.size < sizeof(*user->sve))
+		return -EINVAL;
+
 	if (sve.flags & SVE_SIG_FLAG_SM) {
 		if (!system_supports_sme())
 			return -EINVAL;
@@ -289,7 +292,7 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 	if (sve.vl != vl)
 		return -EINVAL;
 
-	if (sve.head.size <= sizeof(*user->sve)) {
+	if (sve.head.size == sizeof(*user->sve)) {
 		clear_thread_flag(TIF_SVE);
 		current->thread.svcr &= ~SVCR_SM_MASK;
 		current->thread.fp_type = FP_STATE_FPSIMD;
@@ -404,10 +407,13 @@ static int restore_za_context(struct user_ctxs *user)
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
@@ -510,9 +516,6 @@ static int parse_user_sigframe(struct user_ctxs *user,
 			if (user->fpsimd)
 				goto invalid;
 
-			if (size < sizeof(*user->fpsimd))
-				goto invalid;
-
 			user->fpsimd = (struct fpsimd_context __user *)head;
 			break;
 
@@ -527,9 +530,6 @@ static int parse_user_sigframe(struct user_ctxs *user,
 			if (user->sve)
 				goto invalid;
 
-			if (size < sizeof(*user->sve))
-				goto invalid;
-
 			user->sve = (struct sve_context __user *)head;
 			break;
 
@@ -540,9 +540,6 @@ static int parse_user_sigframe(struct user_ctxs *user,
 			if (user->za)
 				goto invalid;
 
-			if (size < sizeof(*user->za))
-				goto invalid;
-
 			user->za = (struct za_context __user *)head;
 			break;
 

-- 
2.30.2
