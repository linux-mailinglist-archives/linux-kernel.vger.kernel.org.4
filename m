Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0935EC188
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbiI0Lfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiI0LfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:35:12 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887558C02E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:35:04 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1664278500; bh=5V2FNZPR/FdcUVzzKFU8iKVMDZyNajtosOiBMcFQsT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=epQhjYPmlZqP/1YEmMW5V9o7ox8YLE07sN5IT+3c4uucytmQspASsFu3ECdKzHBZM
         8JSIcd4NQFQEypJvmQGjxIizfiCept4da+QPhxsjQAU/aGKhWHHKbEpOeYuqerB1XH
         X4SwHtoQ81W4y2TV0HWLPL19lYsg1MOs4PqsE6/w=
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     asahi@lists.linux.dev, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
Subject: [PATCH 3/3] ASoC: apple: mca: Adjust timing of component unregister
Date:   Tue, 27 Sep 2022 13:34:26 +0200
Message-Id: <20220927113426.49724-3-povik+lin@cutebit.org>
In-Reply-To: <20220927113426.49724-1-povik+lin@cutebit.org>
References: <20220927113426.49724-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On removal of the driver, the ASoC component should be unregistered
first, before we start releasing any of the other resources.

Fixes: 3df5d0d97289 ("ASoC: apple: mca: Start new platform driver")
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 sound/soc/apple/mca.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/apple/mca.c b/sound/soc/apple/mca.c
index 7ca653987b78..24381c42eb54 100644
--- a/sound/soc/apple/mca.c
+++ b/sound/soc/apple/mca.c
@@ -1129,8 +1129,8 @@ static int apple_mca_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = devm_snd_soc_register_component(&pdev->dev, &mca_component,
-					      dai_drivers, nclusters * 2);
+	ret = snd_soc_register_component(&pdev->dev, &mca_component,
+					 dai_drivers, nclusters * 2);
 	if (ret) {
 		dev_err(&pdev->dev, "unable to register ASoC component: %d\n",
 			ret);
@@ -1148,6 +1148,7 @@ static int apple_mca_remove(struct platform_device *pdev)
 {
 	struct mca_data *mca = platform_get_drvdata(pdev);
 
+	snd_soc_unregister_component(&pdev->dev);
 	apple_mca_release(mca);
 	return 0;
 }
-- 
2.33.0

