Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A95960D48B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 21:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbiJYTQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 15:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbiJYTPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 15:15:36 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D367F0B3;
        Tue, 25 Oct 2022 12:15:35 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29PJFJJM112020;
        Tue, 25 Oct 2022 14:15:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666725319;
        bh=T7L44GLh1Vpy3fYEU2edI0jDVnA8qvZMddOrW4XRkQw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=O3OVR6Gugrx01MazxWrZvcLX9pdJ+1Yy4WBWkeDg845n4p40h0aEfPqhu/Lgx7ZqQ
         Sm4To9gPFrLBeHMuRcELuv1Iuk92p23Fu2PynOz6HzhvKstUf7BymfWV1XIUtq97qY
         g1f43i+3wOpDwF5uCwbz3hLXYEFwvEyYnPPxAsVs=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29PJFJex058279
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Oct 2022 14:15:19 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 25
 Oct 2022 14:15:19 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 25 Oct 2022 14:15:19 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29PJFJKQ018057;
        Tue, 25 Oct 2022 14:15:19 -0500
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
Subject: [PATCH v2 01/11] thermal: k3_j72xx_bandgap: simplify k3_thermal_get_temp() function
Date:   Tue, 25 Oct 2022 14:15:05 -0500
Message-ID: <20221025191515.9151-2-bb@ti.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221025191515.9151-1-bb@ti.com>
References: <20221025191515.9151-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1018; h=from:subject; bh=g+YxgOMLXP3w1bq6vyZoRrUwJBsI9oCmt8mLlbeowlY=; b=owNCWmg5MUFZJlNZ00DIPQAAbv///v/Pf39sW92/r9/veX1/t3O+zxeur+Z7S5v/81/wjmawARsY yHqBkDQaaGQDQA0eoMgGRoAaANAHqAAyAAAPUGgMgaADQ0PFNpHqeUep6ahwj1AaAADQGgGgNGgwjQ DIDQDQyDI0NPJAyGjJo0aaHqZHkQNDIYmh6hoBodNMEYEDTJppoBkAGmEyGRo0GTEYg0HpNBkyYgyD BAGg0BkyAAyAAA0BQrwSmeh/OzZB42vG1khoUrQtFYPX021+N8e4kPBAfPYC+sWJSuAKhSpnYIm78h 4KvYfkJsGC+BTy93/IwJsnkQCq2yaGyUXR+JJPOdy4QC3wZ/qGYFsrjYCQ4CogljFI5MaqnGh+voQA eJUILXtWFss7btkLWfbEGpk3Z46RE89XNKpWaiU0INIb/LjEqQdue4RWx/CqarJqHaLgiqO8dNwxF6 tnt4qR/lhXTLwwAdXW9I0JHXjUZ+HlPM7WbzIZCGirV0cGUKHqfyQTk4x2c0x/Wc8KyY23pIV/tXND APVSWb3/bUwaitRcxSlESFODvwDXF4rI3WuvMCMM4HIHHOrXWDvl7Q8f4loVBUolQA5JBzFoQCi1xP MMVsEkWDCdSo6swAtGhLMn0ASBsC2NCVnqpfGmvG+Cq1Th+I1IAG2Olhn+LuSKcKEhpoGQeg==
X-Developer-Key: i=bb@ti.com; a=openpgp; fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

