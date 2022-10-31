Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA576141C7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 00:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiJaX2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 19:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiJaX1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 19:27:30 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBF713DD3;
        Mon, 31 Oct 2022 16:27:28 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29VNRGJO058546;
        Mon, 31 Oct 2022 18:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667258836;
        bh=40t8c0//hZUFD6l6R3W73jp60b91DTNg2PGZAtjfemM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ypCn9bgYYTe5JNk0VG97XYJDpYfSyCYdTVKaO1DAvw8V7fWh0F+T2zMg4G00Z1pd8
         m8Psiw2eGTp/HxYVsEDwNr65CxDJLxJvTflXJ8RkwKktg615qwEPMO7bJwwQ32gQRC
         kYu9N0171+7+MEMlpt0KJQV2Dwa9+OA5VLdHFoW8=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29VNRGxv023429
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Oct 2022 18:27:16 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 31
 Oct 2022 18:27:15 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 31 Oct 2022 18:27:15 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29VNRFwN027828;
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
Subject: [PATCH v3 02/11] thermal: k3_j72xx_bandgap: use bool for i2128 erratum flag
Date:   Mon, 31 Oct 2022 18:26:53 -0500
Message-ID: <20221031232702.10339-3-bb@ti.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221031232702.10339-1-bb@ti.com>
References: <20221031232702.10339-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1769; h=from:subject; bh=CBnvYRL9huVrlmYgI1dWwQk4JHA1y8ajdopZHQJDTuQ=; b=owNCWmg5MUFZJlNZdxwcoAAAan///rfr/r/recf+u+n/WPlT1rP/fv5iWu6v37/f/fd1126wARsY HagGgyAAAA0DQ09QGgAPUAA0NAAAAAxDRoAAGhkaD1MJoximEaN6SHQHqA00GmgBpoAPQmQaaAAGgA AGIMQBoG1DJo9TRoep6T1DINMgAPU0AZDaghoZNNMjQ0YmgAGhpiZMmQ0DRoAABoGCYjEyYAEANGhp iAYIANAAAAEDqhBNpiA0AKKDB+cf4+8wD3JwJD0QWGso8PBIPo2h5QFdWKNKU0WZ6aq9ftAWy6ZVS2 0DyTGOZrJBBEATxcU/boPoaTXjd61zZhJGa9DXhCD1TVkGEZPTiQVsXHbKSJdbHT5UHbrr8peEEMZI mHiH7jc+VDGUTvmFAfzJO3NsPZUjoNJ/ChfcQkOMLs0yvBMEoZS01/NQeyFz2VNVCs3ocbQCbHJ8sI H02YnhO/oJhgsQ6rx6gPiNQbyiOZ7RZLA7emlpvqkc1L5rCDGXwJ/DvTyCmeFK8c2rnNRi2hLlTJpc KlC/2fmQwqFZ8HCiufTJPwkhF2fIeBncpc8aQRXPaKS93dREdQRm2kW0goQg7tBlBxgpiv2SGi8BUN iuPEg5DOMAIwza7jBG3DswIQDOKB0EErTMAdCTVZIKkMk41vHhL/i7kinChIO44OUA
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

Some of TI's J721E SoCs require a software trimming method to report
temperatures accurately. Currently we are using a few different data
types to indicate when we should apply the erratum.

Change the 'workaround_needed' variable's data type to a bool to align
with how we are using this variable currently.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 drivers/thermal/k3_j72xx_bandgap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
index a9f99a190cb61..b9d20026771a5 100644
--- a/drivers/thermal/k3_j72xx_bandgap.c
+++ b/drivers/thermal/k3_j72xx_bandgap.c
@@ -340,7 +340,7 @@ static void print_look_up_table(struct device *dev, int *ref_table)
 }
 
 struct k3_j72xx_bandgap_data {
-	unsigned int has_errata_i2128;
+	const bool has_errata_i2128;
 };
 
 static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
@@ -351,7 +351,7 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct k3_j72xx_bandgap *bgp;
 	struct k3_thermal_data *data;
-	int workaround_needed = 0;
+	bool workaround_needed = false;
 	const struct k3_j72xx_bandgap_data *driver_data;
 	struct thermal_zone_device *ti_thermal;
 	int *ref_table;
@@ -522,11 +522,11 @@ static int k3_j72xx_bandgap_remove(struct platform_device *pdev)
 }
 
 static const struct k3_j72xx_bandgap_data k3_j72xx_bandgap_j721e_data = {
-	.has_errata_i2128 = 1,
+	.has_errata_i2128 = true,
 };
 
 static const struct k3_j72xx_bandgap_data k3_j72xx_bandgap_j7200_data = {
-	.has_errata_i2128 = 0,
+	.has_errata_i2128 = false,
 };
 
 static const struct of_device_id of_k3_j72xx_bandgap_match[] = {
-- 
2.38.1

