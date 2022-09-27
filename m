Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8015EC189
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbiI0Lfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbiI0LfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:35:12 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8848E8C027
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:35:03 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1664278499; bh=nOoQhB339U5GGM36GHbGtBpVI5SaHkuDid0bhw4EnqY=;
        h=From:To:Cc:Subject:Date;
        b=Nwr09I/sqmPoJufDCxfV0CwuwcAg026CaPqliB8Oe3lX+CrBM0UrVDJPUK2yi5mTE
         v8fnko6E1l8dZp8T5Rv3h2rT8UYSLLgRUxfPi9FagnEeKVon6MGyq6OGD8EimtcO5k
         Zj2oZ7LspQSEulDJ4+BhsWOy2A8fK2xIZGoe8o6g=
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     asahi@lists.linux.dev, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 1/3] ASoC: apple: mca: Trigger, not deassert, the peripheral reset
Date:   Tue, 27 Sep 2022 13:34:24 +0200
Message-Id: <20220927113426.49724-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the deassertion of the peripheral's shared reset with the
triggering of a pulse on it. This is what we should have been using all
along as the platform's custom is not leaving the reset asserted on
unused peripherals.

Fixes: 3df5d0d97289 ("ASoC: apple: mca: Start new platform driver")
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---

Cc: Philipp Zabel <p.zabel@pengutronix.de>

 sound/soc/apple/mca.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/apple/mca.c b/sound/soc/apple/mca.c
index 69643524796e..75925bfcf754 100644
--- a/sound/soc/apple/mca.c
+++ b/sound/soc/apple/mca.c
@@ -995,7 +995,7 @@ static void apple_mca_release(struct mca_data *mca)
 	if (!IS_ERR_OR_NULL(mca->pd_dev))
 		dev_pm_domain_detach(mca->pd_dev, true);
 
-	reset_control_assert(mca->rstc);
+	reset_control_rearm(mca->rstc);
 }
 
 static int apple_mca_probe(struct platform_device *pdev)
@@ -1049,12 +1049,12 @@ static int apple_mca_probe(struct platform_device *pdev)
 					       DL_FLAG_RPM_ACTIVE);
 	if (!mca->pd_link) {
 		ret = -EINVAL;
-		/* Prevent an unbalanced reset assert */
+		/* Prevent an unbalanced reset rearm */
 		mca->rstc = NULL;
 		goto err_release;
 	}
 
-	reset_control_deassert(mca->rstc);
+	reset_control_reset(mca->rstc);
 
 	for (i = 0; i < nclusters; i++) {
 		struct mca_cluster *cl = &clusters[i];
-- 
2.33.0

