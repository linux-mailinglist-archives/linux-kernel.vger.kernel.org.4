Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AA064939F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 11:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiLKK2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 05:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiLKK2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 05:28:06 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50FB1021
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 02:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1670754472; bh=h5ZsvKk0jLOMltEX2Tm3YLW0RimP91lrdUzmymUhPh0=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=hR1MrwjcI5uIJ0PoDlu93756wQ7ZD0S87+zzlIHySLa7PEuMb5rIMOJnjmaXsC4dh
         IL1pSBWHkKCgy+O9XAoM7CT+gIjX+VAbk7g3sjF8RTD34YXO5Fp05mL3YYEYTYActF
         4Y98BT+texc20t5TWcPQf/wJX7JLp2k5/O94u918=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun, 11 Dec 2022 11:27:52 +0100 (CET)
X-EA-Auth: M5fmEULy5RJ4vQRVAfSZc6NK/yB1xxCg8DoyViGqtSK55fxLDJDylPnIf4dbbWeHekc09LKvMmBnrZj2pmEHyGaGJMyxFoAS
Date:   Sun, 11 Dec 2022 15:57:47 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>, drv@mailo.com
Subject: [PATCH] drm/fsl-dcu: Remove redundant error logging
Message-ID: <Y5Wwo6Gr1rJOdf3B@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A call to platform_get_irq() already prints an error on failure within
its own implementation. So printing another error based on its return
value in the caller is redundant and should be removed. The clean up
also makes if condition block braces unnecessary. Remove that as well.

Issue identified using platform_get_irq.cocci coccicheck script.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index 8579c7629f5e..1ba7d95e1956 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -272,10 +272,8 @@ static int fsl_dcu_drm_probe(struct platform_device *pdev)
 	}

 	fsl_dev->irq = platform_get_irq(pdev, 0);
-	if (fsl_dev->irq < 0) {
-		dev_err(dev, "failed to get irq\n");
+	if (fsl_dev->irq < 0)
 		return fsl_dev->irq;
-	}

 	fsl_dev->regmap = devm_regmap_init_mmio(dev, base,
 			&fsl_dcu_regmap_config);
--
2.34.1



