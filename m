Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFCB68393B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 23:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjAaWVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 17:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjAaWVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 17:21:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDED25A814
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:21:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D62CB81F6F
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 22:20:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219E7C433EF;
        Tue, 31 Jan 2023 22:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675203658;
        bh=IN6lMV+oaoaxi8+vZVcEWJL7NnQKJn0obuqWcAFzEg8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=rZQkjJBL00CKKDPNfnoDEsYzjJol2KMDyLu1Ng6W7e17+eFMFgx6MFwH96ywTneNo
         oJtkGMLVJQMo5krm4NyRKDrkSiFx/eUjAVOWVvHvcrfnwzcKV12Ma0ayEwmEmoRlwc
         iMIwl5ctFhu+T5oidPQHJUQNZZvtZsigo/kSqlalRF3OriuOYZGeJ4J8YkG6rVw9Ay
         lPUZQXyV8V0/2MhoPNoScw9kkXUiGeFiGPDyy3r+O8rwQOahZgTcoAkI2u7nS7/yvz
         lN3x3y7XArRQYOopNhCbBlE7hntuDyxZ0vyE0mpek+WgkG+5aSA8D231Hwa3kbHLP4
         IdVo1675wdNpA==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 31 Jan 2023 22:20:43 +0000
Subject: [PATCH v3 5/7] arm64/signal: Only read new data when parsing the
 SVE context
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221212-arm64-signal-cleanup-v3-5-4545c94b20ff@kernel.org>
References: <20221212-arm64-signal-cleanup-v3-0-4545c94b20ff@kernel.org>
In-Reply-To: <20221212-arm64-signal-cleanup-v3-0-4545c94b20ff@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2160; i=broonie@kernel.org;
 h=from:subject:message-id; bh=IN6lMV+oaoaxi8+vZVcEWJL7NnQKJn0obuqWcAFzEg8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBj2ZQ/3uckocqxHNHA3IsS8LkF9bc1GcaI+LosFUw7
 ix6iH6GJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY9mUPwAKCRAk1otyXVSH0LPIB/
 45Iu7NrW9B+QYf6wdBo8V27T7fN1GCaIyBz5rjgUQM/m7lR7gdOlRjinTIvcMdCmeB+cpF2rC7qQv5
 BUXA+QSOkcwAcwdbwdYq7BbIX3jr/Clqqv5OImF9sg7LznvhM3Ar/1+VKDIf+0P1Cd8AvfhWHR81ve
 iku3xHI/sKP6nIl+T9w3rR7w70Ixnj7U59SLdXZ9vIjud9/isq4iGD4v1QGMgUXGx3n1cNeekZlXOj
 blT/DdXm1YUtAriHHgS0dodmAGf2kKYxYLaMr7hlOX3PPztmuVSBaxYBVrpdnuxY/e9y3rAz2oZJzG
 J3AAIn+MYCQ68mXU97Cr8gF4fL4bM7
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
index 567e8e5b6998..27a1fa37f926 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -271,18 +271,20 @@ static int preserve_sve_context(struct sve_context __user *ctx)
 
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
 
@@ -294,7 +296,7 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 		vl = task_get_sve_vl(current);
 	}
 
-	if (sve.vl != vl)
+	if (user_vl != vl)
 		return -EINVAL;
 
 	if (user->sve_size == sizeof(*user->sve)) {
@@ -304,7 +306,7 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 		goto fpsimd_only;
 	}
 
-	vq = sve_vq_from_vl(sve.vl);
+	vq = sve_vq_from_vl(vl);
 
 	if (user->sve_size < SVE_SIG_CONTEXT_SIZE(vq))
 		return -EINVAL;
@@ -332,7 +334,7 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 	if (err)
 		return -EFAULT;
 
-	if (sve.flags & SVE_SIG_FLAG_SM)
+	if (flags & SVE_SIG_FLAG_SM)
 		current->thread.svcr |= SVCR_SM_MASK;
 	else
 		set_thread_flag(TIF_SVE);

-- 
2.30.2

