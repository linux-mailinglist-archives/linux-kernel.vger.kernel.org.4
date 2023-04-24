Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9256ED4BF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjDXStT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbjDXSsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:48:38 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FBD5B90;
        Mon, 24 Apr 2023 11:48:19 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33OImBtW087511;
        Mon, 24 Apr 2023 13:48:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682362091;
        bh=nJ7qevk+C4BYIH4h8NNDIO9iDNa/BpFJKBXbdR/B8pM=;
        h=From:To:CC:Subject:Date;
        b=h6YnzudSLEr1WSvZZH9nbV+6lPeTcHOyNaZvIABBm7BAUWcvGHxbc7bASclsv+uMZ
         6JF048qSpi+Fe8bXclHPMm2T9Nhys4FR9K4g2uhr7/2ti/teNX4MD9aYTX4nI7WmR8
         WiV0Dr11Pw0Sj79ApwmiqXou9/VF8+vU9LDJbgn8=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33OImBgQ012258
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Apr 2023 13:48:11 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 24
 Apr 2023 13:48:11 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 24 Apr 2023 13:48:11 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33OImAW5074270;
        Mon, 24 Apr 2023 13:48:10 -0500
From:   Andrew Davis <afd@ti.com>
To:     Peter Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [RFC] mux: mmio: use reg property when parent device is not a syscon
Date:   Mon, 24 Apr 2023 13:48:10 -0500
Message-ID: <20230424184810.29453-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT binding for the reg-mux compatible states it can be used when the
"parent device of mux controller is not syscon device". It also allows
for a reg property. When the parent device is indeed not a syscon device,
nor is it a regmap provider, we should fallback to using that reg
property to identify the address space to use for this mux.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/mux/mmio.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mux/mmio.c b/drivers/mux/mmio.c
index 44a7a0e885b8..42e00b9fd0a9 100644
--- a/drivers/mux/mmio.c
+++ b/drivers/mux/mmio.c
@@ -44,10 +44,13 @@ static int mux_mmio_probe(struct platform_device *pdev)
 	int ret;
 	int i;
 
-	if (of_device_is_compatible(np, "mmio-mux"))
+	if (of_device_is_compatible(np, "mmio-mux")) {
 		regmap = syscon_node_to_regmap(np->parent);
-	else
-		regmap = dev_get_regmap(dev->parent, NULL) ?: ERR_PTR(-ENODEV);
+	} else {
+		regmap = dev_get_regmap(dev->parent, NULL);
+		if (!regmap)
+			regmap = device_node_to_regmap(np) ?: ERR_PTR(-ENODEV);
+	}
 	if (IS_ERR(regmap)) {
 		ret = PTR_ERR(regmap);
 		dev_err(dev, "failed to get regmap: %d\n", ret);
-- 
2.39.2

