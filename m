Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218585B4048
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 22:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiIIUAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 16:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiIIUAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 16:00:52 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6389868AB
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 13:00:50 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 289K0YfQ126728;
        Fri, 9 Sep 2022 15:00:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1662753634;
        bh=xnUFq6xaFcj5P6SRwy+dFuU03cRiw8QseRfWklft+z0=;
        h=From:To:CC:Subject:Date;
        b=HlWWWxMd2Ezcc2u1Dk1r4GImm3gKvXfE4oOrGSidZkrQQlrqRvUbKLXUHkXvfk/f1
         kwkBu1atIvZpHOXMkqukgUegd1HBoRY3OOaEl0Ws+G4WLdKRv+smYRMedfcgWjSQx/
         vMF9YvGW94Hl3n/s/NOZ8NEfL/jJduqmUa40kwcI=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 289K0YMY035514
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Sep 2022 15:00:34 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 9 Sep
 2022 15:00:34 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 9 Sep 2022 15:00:34 -0500
Received: from ubuntu.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 289K0SGE000980;
        Fri, 9 Sep 2022 15:00:29 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <rogerq@kernel.org>, <vkoul@kernel.org>, <vigneshr@ti.com>,
        Matt Ranostay <mranostay@ti.com>
Subject: [PATCH] phy: ti: phy-j721e-wiz: stop name conflict if multiple serdes are initialized
Date:   Fri, 9 Sep 2022 13:00:26 -0700
Message-ID: <20220909200026.3422-1-mranostay@ti.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When multiple serdes instances are initialized the first will succeed but
additional will conflict over clocks names and probing fails.

Signed-off-by: Matt Ranostay <mranostay@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/phy/ti/phy-j721e-wiz.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index 20af142580ad..1f4f585a84ad 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -717,6 +717,8 @@ static int wiz_phy_en_refclk_register(struct wiz *wiz)
 	struct device *dev = wiz->dev;
 	struct clk_init_data *init;
 	struct clk *clk;
+	char *clk_name;
+	unsigned int sz;
 
 	wiz_phy_en_refclk = devm_kzalloc(dev, sizeof(*wiz_phy_en_refclk), GFP_KERNEL);
 	if (!wiz_phy_en_refclk)
@@ -726,12 +728,23 @@ static int wiz_phy_en_refclk_register(struct wiz *wiz)
 
 	init->ops = &wiz_phy_en_refclk_ops;
 	init->flags = 0;
-	init->name = output_clk_names[TI_WIZ_PHY_EN_REFCLK];
+
+	sz = strlen(dev_name(dev)) + strlen(output_clk_names[TI_WIZ_PHY_EN_REFCLK]) + 2;
+
+	clk_name = kzalloc(sz, GFP_KERNEL);
+	if (!clk_name)
+		return -ENOMEM;
+
+	snprintf(clk_name, sz, "%s_%s", dev_name(dev), output_clk_names[TI_WIZ_PHY_EN_REFCLK]);
+	init->name = clk_name;
 
 	wiz_phy_en_refclk->phy_en_refclk = wiz->phy_en_refclk;
 	wiz_phy_en_refclk->hw.init = init;
 
 	clk = devm_clk_register(dev, &wiz_phy_en_refclk->hw);
+
+	kfree(clk_name);
+
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-- 
2.37.2

