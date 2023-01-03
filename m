Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D302665C80D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 21:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238663AbjACU0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 15:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238245AbjACUZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 15:25:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DBF140A3
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 12:25:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1E7DB810FE
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 20:25:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8304EC433EF;
        Tue,  3 Jan 2023 20:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672777542;
        bh=QLG+un43OSJkuZgSGfNUjwhIH30UO3Hbr7mdGNV8oRY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=fvbEzG+u/5WihFXfooAH3R485gxI6LI1JKV1BiglRWQR0lBXi2ODHKtY/O6gj227n
         IoVbQXQK+l/wmJX0PvbZ62c2kYqCl/Cg7hwPg1G5WAW5rlNDsIa6Ito3MwYIhffBBM
         X+2SMHPuzL+eheMukTd8owRhAhuo/D9ZlDhI2ID/P4elLwKXgzhtjI2wZ7fdrZ7JvH
         9kSFgadN/J9GL1w8bYkNgKfXFbl2/IiVQhPc0IifjDFivyeK4ETr6Z7yVGbDJ3Eian
         DIWK2Rqct+2gGNT8zOHaEAA0JncTzD7xNtcCqlhgPNy+TZ5C2+nssaDtaQQGyh8P2Q
         /3ATCBHMxj2aQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 03 Jan 2023 20:25:19 +0000
Subject: [PATCH v2 5/6] arm64/signal: Only read new data when parsing the SVE context
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221212-arm64-signal-cleanup-v2-5-14a8f3e088b7@kernel.org>
References: <20221212-arm64-signal-cleanup-v2-0-14a8f3e088b7@kernel.org>
In-Reply-To: <20221212-arm64-signal-cleanup-v2-0-14a8f3e088b7@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-214b3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2160; i=broonie@kernel.org;
 h=from:subject:message-id; bh=QLG+un43OSJkuZgSGfNUjwhIH30UO3Hbr7mdGNV8oRY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjtI88DMxlllW4ILPHh2dr2Kaoqe5Lgf9TJ8pFyIGJ
 5N+t1ziJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY7SPPAAKCRAk1otyXVSH0LIHB/
 0ZFpu1JxRbiEULqJ51l6GuED4UNoQjywLG32hX8RXSv86WSjL0dbOFm2KjUC36Ftbp3dGJOPHZc5nL
 b42Ei7nQVz0hUuH5Jd0UaoJMFwifv973ZNiDeGI1xCD7s7JP+ea+jn/xJbFYjFPngtCjIxM7BhmRcw
 0MXL+bfybD9R4oITe/F1Bp5fzxZ1/xltCDXyBeh8RqEtMtLI4E1OyejyiKnRsTm0sfV0nGQ5DvanF1
 VJO0b52a/3st8a/lvtS9H2o/QTva0QQvM7PSVIdeq/vmf6ggX5i37DRRZbH8sQn+pPuSHdzK2wsjRE
 ImN0Xrj9xK9QiAzvY6a8WYft2ie9Rf
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

When we parse the SVE signal context we read the entire context from
userspace, including the generic signal context header which was already
read by parse_user_sigframe() and padding bytes that we ignore. Avoid the
possibility of relying on the second read of the data read twice by only
reading the data which we are actually going to use.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/signal.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 82a89b0852ee..26192ab56de4 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -265,18 +265,20 @@ static int preserve_sve_context(struct sve_context __user *ctx)
 
 static int restore_sve_fpsimd_context(struct user_ctxs *user)
 {
-	int err;
+	int err = 0;
 	unsigned int vl, vq;
 	struct user_fpsimd_state fpsimd;
-	struct sve_context sve;
+	u16 user_vl, flags;
 
 	if (user->sve_size < sizeof(*user->sve))
 		return -EINVAL;
 
-	if (__copy_from_user(&sve, user->sve, sizeof(sve)))
-		return -EFAULT;
+	__get_user_error(user_vl, &(user->sve->vl), err);
+	__get_user_error(flags, &(user->sve->flags), err);
+	if (err)
+		return err;
 
-	if (sve.flags & SVE_SIG_FLAG_SM) {
+	if (flags & SVE_SIG_FLAG_SM) {
 		if (!system_supports_sme())
 			return -EINVAL;
 
@@ -288,7 +290,7 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 		vl = task_get_sve_vl(current);
 	}
 
-	if (sve.vl != vl)
+	if (user_vl != vl)
 		return -EINVAL;
 
 	if (user->sve_size == sizeof(*user->sve)) {
@@ -298,7 +300,7 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 		goto fpsimd_only;
 	}
 
-	vq = sve_vq_from_vl(sve.vl);
+	vq = sve_vq_from_vl(vl);
 
 	if (user->sve_size < SVE_SIG_CONTEXT_SIZE(vq))
 		return -EINVAL;
@@ -326,7 +328,7 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 	if (err)
 		return -EFAULT;
 
-	if (sve.flags & SVE_SIG_FLAG_SM)
+	if (flags & SVE_SIG_FLAG_SM)
 		current->thread.svcr |= SVCR_SM_MASK;
 	else
 		set_thread_flag(TIF_SVE);

-- 
2.30.2
