Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DC16141C8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 00:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiJaX2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 19:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiJaX1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 19:27:30 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC351115E;
        Mon, 31 Oct 2022 16:27:30 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29VNRGEg108482;
        Mon, 31 Oct 2022 18:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667258836;
        bh=T7L44GLh1Vpy3fYEU2edI0jDVnA8qvZMddOrW4XRkQw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Q2mlQAQRS56AUpM7/MwyXVVMYxBCJJVHWtKFmXOxxWHo9Bg5QmEwXNaFBRKcpcjZ6
         +ZlTKmk0XI5weist8ViEGpmSKqZh0Sz6j76aMmWqrHfRo61Mh1ymQISuMCvcI6uGWL
         Acds9UFKJirzfmxVaxMp+caGr2twba+F3/wJqCHo=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29VNRGap022965
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Oct 2022 18:27:16 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 31
 Oct 2022 18:27:15 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 31 Oct 2022 18:27:15 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29VNRFl1124758;
        Mon, 31 Oct 2022 18:27:15 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     Keerthy <j-keerthy@ti.com>, Linux PM <linux-pm@vger.kernel.org>,
        Device Trees <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LKML ARM <linux-arm-kernel@lists.infradead.org>,
        Bryan Brattlof <bb@ti.com>
Subject: [PATCH v3 01/11] thermal: k3_j72xx_bandgap: simplify k3_thermal_get_temp() function
Date:   Mon, 31 Oct 2022 18:26:52 -0500
Message-ID: <20221031232702.10339-2-bb@ti.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221031232702.10339-1-bb@ti.com>
References: <20221031232702.10339-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1018; h=from:subject; bh=g+YxgOMLXP3w1bq6vyZoRrUwJBsI9oCmt8mLlbeowlY=; b=owNCWmg5MUFZJlNZg+zNZwAAZH///v//+/mt7hnctdv7+j26Efwz+raf3f+b7mt491nR//awARsz Uh6jQABo0ZAZANBoGgDQZNGmmgA000AGjIaAAMgaGahpk0xHqM0ENDNR4mocCA000AaGTIGQA9TIGE ZDQDNT1AaB6gBieoBpoekaDEDQ9QaPUAaB6gwQCHqH6pkaGI0yHpPUBo0GjIZMQAAaGTQAGmgNGmmm mjQAaBkDJhBkZHpNAyHqDQADAhbQ2MIAlP+MX1lDm+Zh2lew/hkw0GNGTQZaCNugsdZWYZ13AQmfxV Oym3cAXJBPQyLupUz3nK/C2nZCULkWXehYkE3rloeC68BJQHnZe3l0mgxh+XaFTHm/CIDwP58zsWIH J8gtH4oYwQZqqyfQdoQhZjmKQL3Z2YBLcSOcqtg026S0b/E8lJ+09WbcxzxDmm/iSOYaeMWH0LQ+pt aqEDIvQJ2rJK5ySZoc24PCXRRq6MOlATZessdWc8KH59ipkqcBWb3ECW7SXHfopp2LBolYDDRXJlIV 4qglVIOEe/NmhmXeTaiArsAuh4YXu8PQv7JnLP9DZiCRAsD1iQS0vCLxQ14QoT1iNxPftY/Pq17xG8 TbpP6GAFQDcILd6IIRGkO9rWMijZpy9Nd4aWBux5DpiTcu/AIozFERaHEF1Of4u5IpwoSEH2ZrOA==
X-Developer-Key: i=bb@ti.com; a=openpgp; fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The k3_thermal_get_temp() function can be simplified to return only
the result of k3_bgp_read_temp() without needing the 'ret' variable

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 drivers/thermal/k3_j72xx_bandgap.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
index c073b1023bbe7..a9f99a190cb61 100644
--- a/drivers/thermal/k3_j72xx_bandgap.c
+++ b/drivers/thermal/k3_j72xx_bandgap.c
@@ -249,14 +249,7 @@ static inline int k3_bgp_read_temp(struct k3_thermal_data *devdata,
 /* Get temperature callback function for thermal zone */
 static int k3_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct k3_thermal_data *data = tz->devdata;
-	int ret = 0;
-
-	ret = k3_bgp_read_temp(data, temp);
-	if (ret)
-		return ret;
-
-	return ret;
+	return k3_bgp_read_temp(tz->devdata, temp);
 }
 
 static const struct thermal_zone_device_ops k3_of_thermal_ops = {
-- 
2.38.1

