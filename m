Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DE865C80F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 21:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjACU0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 15:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238335AbjACUZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 15:25:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A650D13CF8
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 12:25:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F713B81107
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 20:25:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C59C433F2;
        Tue,  3 Jan 2023 20:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672777544;
        bh=R/W8mmKeaxpR93qWBCl3bp8iHKra8Il/mJ3al5xv2xs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=I7qAR66ZRCypjHbZX5mvJtml3HXj5+Orkb/Q/6L+zYBGEQBpKFELl6bO+IG2dZ5Vv
         DSjhuSEI3WBV4Brcx0wvlPMAU9nDEblzXBXq47QmRHIpK7ZE5j/ywGeyuqagGrqAQ1
         pDFgtnzlQZy5Q6og7FHp1VwVKmNWypSFHQXr0WfEOd/AQubz6XoOoIF1s5ftdNH0li
         SVcPWftl/RHHbVgc443jP0iskPxQ13CwZboO9E0eqZhF+kg0qP7mQFCRbt+M5z8iEu
         BBGtnal37FdUqPVvw3114WgqcEaSGkTYBwUS63al8tFI+7eZqCwzGRhayTHmO1xGFK
         y2haoNBQPiXyA==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 03 Jan 2023 20:25:20 +0000
Subject: [PATCH v2 6/6] arm64/signal: Only read new data when parsing the ZA context
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221212-arm64-signal-cleanup-v2-6-14a8f3e088b7@kernel.org>
References: <20221212-arm64-signal-cleanup-v2-0-14a8f3e088b7@kernel.org>
In-Reply-To: <20221212-arm64-signal-cleanup-v2-0-14a8f3e088b7@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-214b3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1541; i=broonie@kernel.org;
 h=from:subject:message-id; bh=R/W8mmKeaxpR93qWBCl3bp8iHKra8Il/mJ3al5xv2xs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjtI89bC1hF4Oqw8vOg9ajAIq4OrFhynOGKQtYhWvC
 s9O/wm+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY7SPPQAKCRAk1otyXVSH0HYZB/
 0a2p8lwqzzdweZpr3X+MR3f1Vwopfqc66IJXP/cGcepmIu3RaicP/UdoqD7/LN1i+TucQizeWEAF0X
 RXWaVWKXA+8qJoR3K3catNwHz/xLJhNfqzpMTmiY9B0fU3lacN3ATTv1teTEnVYtNrsxxsBz8Qa+CS
 SP8EofQ1qegyC5AUOCzsSi9Yh8nHN7HO7WutfvFP/E6+1eY2iUjQc2/4rso11w9z1IM6JQTY0EvJLo
 i/x0ekIYFppGh28mkN6KV3k1tlCCPAys5Nkxbhp1ntXJdXGhNVjIwe0ipVu3pf/0HaiDVwrpNHB2iW
 rqestOwUMVUyibcD5BrDYP7wu1bMuU
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

When we parse the ZA signal context we read the entire context from
userspace, including the generic signal context header which was already
read by parse_user_sigframe() and padding bytes that we ignore. Avoid the
possibility of relying on the second read of the data read twice by only
reading the data which we are actually going to use.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/signal.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 26192ab56de4..bed27d4f8ce9 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -401,17 +401,18 @@ static int preserve_za_context(struct za_context __user *ctx)
 
 static int restore_za_context(struct user_ctxs *user)
 {
-	int err;
+	int err = 0;
 	unsigned int vq;
-	struct za_context za;
+	u16 user_vl;
 
 	if (user->za_size < sizeof(*user->za))
 		return -EINVAL;
 
-	if (__copy_from_user(&za, user->za, sizeof(za)))
-		return -EFAULT;
+	__get_user_error(user_vl, &(user->za->vl), err);
+	if (err)
+		return err;
 
-	if (za.vl != task_get_sme_vl(current))
+	if (user_vl != task_get_sme_vl(current))
 		return -EINVAL;
 
 	if (user->za_size == sizeof(*user->za)) {
@@ -419,7 +420,7 @@ static int restore_za_context(struct user_ctxs *user)
 		return 0;
 	}
 
-	vq = sve_vq_from_vl(za.vl);
+	vq = sve_vq_from_vl(user_vl);
 
 	if (user->za_size < ZA_SIG_CONTEXT_SIZE(vq))
 		return -EINVAL;

-- 
2.30.2
