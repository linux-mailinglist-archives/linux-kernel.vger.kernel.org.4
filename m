Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018356C44D6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 09:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjCVIYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 04:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjCVIYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:24:20 -0400
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30803D51F;
        Wed, 22 Mar 2023 01:24:19 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4PhM2T19V6z501Sb;
        Wed, 22 Mar 2023 16:24:17 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
        by mse-fl2.zte.com.cn with SMTP id 32M8O1ot000843;
        Wed, 22 Mar 2023 16:24:01 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 22 Mar 2023 16:24:03 +0800 (CST)
Date:   Wed, 22 Mar 2023 16:24:03 +0800 (CST)
X-Zmail-TransId: 2afa641abb23ffffffff92a-995fd
X-Mailer: Zmail v1.0
Message-ID: <202303221624038805664@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <thierry.reding@gmail.com>
Cc:     <airlied@gmail.com>, <daniel@ffwll.ch>, <jonathanh@nvidia.com>,
        <dri-devel@lists.freedesktop.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBkcm0vdGVncmE6IGRwYXV4OiBVc2UgZGV2X2Vycl9wcm9iZSgp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 32M8O1ot000843
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 641ABB31.001/4PhM2T19V6z501Sb
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Xingchen <ye.xingchen@zte.com.cn>

Replace the open-code with dev_err_probe() to simplify the code.

Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
 drivers/gpu/drm/tegra/dpaux.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dpaux.c b/drivers/gpu/drm/tegra/dpaux.c
index 3c84e73d5051..6a3a6589a4d6 100644
--- a/drivers/gpu/drm/tegra/dpaux.c
+++ b/drivers/gpu/drm/tegra/dpaux.c
@@ -503,14 +503,9 @@ static int tegra_dpaux_probe(struct platform_device *pdev)

 	dpaux->vdd = devm_regulator_get_optional(&pdev->dev, "vdd");
 	if (IS_ERR(dpaux->vdd)) {
-		if (PTR_ERR(dpaux->vdd) != -ENODEV) {
-			if (PTR_ERR(dpaux->vdd) != -EPROBE_DEFER)
-				dev_err(&pdev->dev,
-					"failed to get VDD supply: %ld\n",
-					PTR_ERR(dpaux->vdd));
-
-			return PTR_ERR(dpaux->vdd);
-		}
+		if (PTR_ERR(dpaux->vdd) != -ENODEV)
+			return dev_err_probe(&pdev->dev, PTR_ERR(dpaux->vdd),
+					     "failed to get VDD supply: %ld\n");

 		dpaux->vdd = NULL;
 	}
-- 
2.25.1
