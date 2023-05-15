Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E24E703D97
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 21:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244809AbjEOTTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 15:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242789AbjEOTTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 15:19:19 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCFD10C6;
        Mon, 15 May 2023 12:19:18 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34FJJB4W045695;
        Mon, 15 May 2023 14:19:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684178351;
        bh=nJ7qevk+C4BYIH4h8NNDIO9iDNa/BpFJKBXbdR/B8pM=;
        h=From:To:CC:Subject:Date;
        b=QE+WudY+/6rFlxWzxHJnzi/yDfo5cgKI8GHnTZOURmoiVa85SeWPzHeOjwr9vFXBb
         IJnoGZPH1RY/LiG2hz6ju19ZRO8C6FwBVXz3gql5J4hgK5d2ElakFPgYV3s84ihQqE
         brAMYtTOiBHAVi15WkhEpM4jSyhSZL73aQ5evuR0=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34FJJB1o045054
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 May 2023 14:19:11 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 May 2023 14:19:10 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 May 2023 14:19:10 -0500
Received: from fllv0039.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34FJJAsP104430;
        Mon, 15 May 2023 14:19:10 -0500
From:   Andrew Davis <afd@ti.com>
To:     Peter Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH] mux: mmio: use reg property when parent device is not a syscon
Date:   Mon, 15 May 2023 14:19:09 -0500
Message-ID: <20230515191909.611241-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

