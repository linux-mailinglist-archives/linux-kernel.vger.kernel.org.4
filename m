Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E518D65C80B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 21:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238489AbjACUZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 15:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238278AbjACUZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 15:25:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320E9140F3
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 12:25:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C359BB810FD
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 20:25:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A5CC433B0;
        Tue,  3 Jan 2023 20:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672777536;
        bh=zFC31q+ex+1Dl3BDwtcnroCVfROJ0aqVLE555+t4k/s=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=R/L1HV0Dq6n53aNNnFFlg83TGKpPpHSMTjNvh4z6pems6ig10W/eGh7lAatJddfHl
         TFnhMs2ecWcMKwUq9Z6Tv+w4TiPy9AvABwZzIeVe+RcBdB6m7ncgm27hN/HjFym86E
         rPWUXZiFeeIAwW7RbOL6naMf9wBqXrVAFrh08DxFAoapBzoTWr5vX2lcUifx+/ojS5
         iluVczswqBEXcreZLxHxJTqbrUWzKozXsmUy/7sxqhw2jBlYiNwnJ/F7TdM46DIH6z
         K58g2basDaMccxTc84UkTKmvWCfKZc57PVlQI6CbqYwovWR75k6RxDznRTdpLOc9hn
         kcM+3wzAC/TvA==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 03 Jan 2023 20:25:15 +0000
Subject: [PATCH v2 1/6] arm64/signal: Don't redundantly verify FPSIMD magic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221212-arm64-signal-cleanup-v2-1-14a8f3e088b7@kernel.org>
References: <20221212-arm64-signal-cleanup-v2-0-14a8f3e088b7@kernel.org>
In-Reply-To: <20221212-arm64-signal-cleanup-v2-0-14a8f3e088b7@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-214b3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1247; i=broonie@kernel.org;
 h=from:subject:message-id; bh=zFC31q+ex+1Dl3BDwtcnroCVfROJ0aqVLE555+t4k/s=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjtI85VdbUmWZx8pESGvVVzybsGVa/FrGZIdhgibbe
 LHcz2syJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY7SPOQAKCRAk1otyXVSH0Fk1B/
 9OGuQiovaH9EVYAhVRVZPIrfWq046KVBbZSCyKVgx3wFdkm3xfcwW10T2edp6UKYr0qCHOKC/85dlQ
 dYzOrCdNmYTbqaLKDeYvcqFCCBnAB2fNjCoqFv9VkvFQ/e6BwntCCM+ASUFN51g6dpZ5cnBQywl4Zh
 hSCas1IPotkR2yiefDL78cn/xdnJZhCsT6HHqJxxxWGRrgm1F3vPhmAmiG5jkgDZQQHUZIa/c/XAZu
 ud6Vy0+N27bA89FJBsU5cPjdW6ICvjDmiz1yIieVveJ+dsoIEOa+pvXGKE8+LKJ2Xjmk3MPZ7Isht2
 YvHD7vKZcnmuUvL/XPTNZh3CrYLG09
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

We validate that the magic in the struct fpsimd_context is correct in
restore_fpsimd_context() but this is redundant since parse_user_sigframe()
uses this magic to decide to call the function in the first place. Remove
the extra validation.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/signal.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index e0d09bf5b01b..9d3d10269da7 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -189,15 +189,14 @@ static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
 static int restore_fpsimd_context(struct fpsimd_context __user *ctx)
 {
 	struct user_fpsimd_state fpsimd;
-	__u32 magic, size;
+	__u32 size;
 	int err = 0;
 
-	/* check the magic/size information */
-	__get_user_error(magic, &ctx->head.magic, err);
+	/* check the size information */
 	__get_user_error(size, &ctx->head.size, err);
 	if (err)
 		return -EFAULT;
-	if (magic != FPSIMD_MAGIC || size != sizeof(struct fpsimd_context))
+	if (size != sizeof(struct fpsimd_context))
 		return -EINVAL;
 
 	/* copy the FP and status/control registers */

-- 
2.30.2
