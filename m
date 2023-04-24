Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0316E1E8E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjDNImx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjDNImt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:42:49 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF477ED7;
        Fri, 14 Apr 2023 01:42:44 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33E8X1nu006620;
        Fri, 14 Apr 2023 10:42:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=FbOTl+8MNsgRED5FCS4rKIwqJQZWuMOClivGmNkcn8g=;
 b=Xr+i4UhvYLawbgqLDpK5Ddx3gVGz6c4028aQtkKGL+sl/TMRY3BdfnwQuuF14YVsg5Uu
 yJtllOgRvY9rjxJbaud+yBY+SbP0wdtxgjLYhCWEpCy61zN2g04Xvl3647wpRLTJco9i
 NvirofQdrwzxg7eKAj96wZb/Ha/zYACHE7yOyix5fWF29Z2FCtIk7bJCg55BIA7TWwq3
 yKJOMSrdJq3d/wQXPeqoDcL2mCHEYzJwMGSHcoH8jV04SwswZZtMDufMRICau/Kyw1Mc
 iXmmmEmiNXq5tIuURaxIXlNyLjJggcK7PCKTWyHhSvPlrsOUTwc7lFkuIQF5W6AzBfgW eQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pwsgpq3q1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 10:42:33 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8FF84100038;
        Fri, 14 Apr 2023 10:42:08 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A75402138E3;
        Fri, 14 Apr 2023 10:42:08 +0200 (CEST)
Received: from localhost (10.252.1.127) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 14 Apr
 2023 10:42:09 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <hminas@synopsys.com>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <alexandre.torgue@foss.st.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <amelie.delaunay@foss.st.com>, <fabrice.gasnier@foss.st.com>
Subject: [PATCH v2 1/4] usb: dwc2: improve error handling in __dwc2_lowlevel_hw_enable
Date:   Fri, 14 Apr 2023 10:41:34 +0200
Message-ID: <20230414084137.1050487-2-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230414084137.1050487-1-fabrice.gasnier@foss.st.com>
References: <20230414084137.1050487-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.1.127]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_03,2023-04-13_01,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add error handling in __dwc2_lowlevel_hw_enable() that may leave the
clocks and regulators enabled upon error.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/usb/dwc2/platform.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index d1589ba7d322..c431ce6c119f 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -104,7 +104,7 @@ static int __dwc2_lowlevel_hw_enable(struct dwc2_hsotg *hsotg)
 	if (hsotg->clk) {
 		ret = clk_prepare_enable(hsotg->clk);
 		if (ret)
-			return ret;
+			goto err_dis_reg;
 	}
 
 	if (hsotg->uphy) {
@@ -113,10 +113,25 @@ static int __dwc2_lowlevel_hw_enable(struct dwc2_hsotg *hsotg)
 		ret = hsotg->plat->phy_init(pdev, hsotg->plat->phy_type);
 	} else {
 		ret = phy_init(hsotg->phy);
-		if (ret == 0)
+		if (ret == 0) {
 			ret = phy_power_on(hsotg->phy);
+			if (ret)
+				phy_exit(hsotg->phy);
+		}
 	}
 
+	if (ret)
+		goto err_dis_clk;
+
+	return 0;
+
+err_dis_clk:
+	if (hsotg->clk)
+		clk_disable_unprepare(hsotg->clk);
+
+err_dis_reg:
+	regulator_bulk_disable(ARRAY_SIZE(hsotg->supplies), hsotg->supplies);
+
 	return ret;
 }
 
-- 
2.25.1

