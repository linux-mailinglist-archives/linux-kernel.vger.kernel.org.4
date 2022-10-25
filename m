Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D706960D48A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 21:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbiJYTQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 15:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbiJYTPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 15:15:35 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944597F13B;
        Tue, 25 Oct 2022 12:15:34 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29PJFJrZ114081;
        Tue, 25 Oct 2022 14:15:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666725319;
        bh=QYyMABB6AHijjyJOhUhJ54RA/v1ktwtBQZkA4ygi9Aw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=K9BoHj8QXa/HeNJdh12vspKOhzzEEqdGWZD1TKRB1gowftRa+VL2J48B3N/83Jw2w
         27oxd9ZN1u6PMWMmLqxI9282GkbHbxNiWdMyJs5+R+yUU1zjeFAw2kRV+cBZ4u0Bwb
         WK1X8seN1xsPVv3sv7Ay6Nxqz3t6Qex+cfjYblTE=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29PJFJf0058279
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Oct 2022 14:15:19 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 25
 Oct 2022 14:15:19 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 25 Oct 2022 14:15:19 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29PJFJF3038866;
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
Subject: [PATCH v2 02/11] thermal: k3_j72xx_bandgap: use bool for i2128 erratum flag
Date:   Tue, 25 Oct 2022 14:15:06 -0500
Message-ID: <20221025191515.9151-3-bb@ti.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221025191515.9151-1-bb@ti.com>
References: <20221025191515.9151-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1775; h=from:subject; bh=plpAnJmVQap8rt0k9uux1w9KO8wCDCu2HZBNeax8/MM=; b=owNCWmg5MUFZJlNZmD5tcAAAbH////ffH/Xpvu/en193Xl3W3Xd/7c9Z/u8/d1ub9/f60fwwARsw IepoA0ZDQABpk0AADRkGgDQAGgaAADQMgNAZAAMTTQNBtJiZGmA009UOmjQNNAaaZNGI0yZGgGjIYT TQyNNGgAAyG1NNBkAAAGjQNNGQyaGJoyA2kANB00ZNMIAMjQaADIwQxDTRoGQ0ZDRpoYAmQA0NGjEA BoGmgyAZDJkAADAQJmHOHBAS98YOIdxUPlwKohMhPg2Z9qBdDf0fFgOwAiAuVzu5IfnJNMrZqN8oDA Js5+tUA+suMLzF6GFPRSc2fOoldg4YPqwQGZAuDaVmsuNCqm9fnVBEAi6wsU+9Y+HxHjgMofkFlKre HUUjxPGIFWo3570L8BDGW7rwYAD4p+hSWw9JL+RYTcJikYDrvjxaJaDiEmhMhxp+WU8JxGfnZeux1A z0YsBtwuK9wiT6JMmpjTiKVATBjOwaG7bGmnqr3hxlalSuJhT/I6E6tXOFWAWTl1p0U2LCJ1Jyi9gB BpI88JyhzCsaNNFJDF29U23FYsR7lNHFhW3WHxC8OYZnLCDHsV6jEXregcOlhGDK/qs3wECfWjhNsh CyIwDdsgMVLNEQtSTUPaC1USzqWWecTvsgD3ourn0k7QED3lRVQRQiACYAP8XckU4UJCYPm1wA
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

Some of TI's J721E's require a software trimming method to report
temperatures accurately. Currently we are using a few different data
types to indicate when this device should apply the erratum.

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

