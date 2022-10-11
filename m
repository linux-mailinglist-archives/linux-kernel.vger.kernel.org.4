Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737905FBE44
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 01:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJKXS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 19:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiJKXSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 19:18:17 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9BA5F99F;
        Tue, 11 Oct 2022 16:18:16 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29BNHxbH086168;
        Tue, 11 Oct 2022 18:17:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1665530279;
        bh=oPlOVAsMdXzy8y19AijK6Kt1rJmvxBuq0bQNBBMio5g=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=JNtsx2BfVvcI7M8/YBNJLPLBOtCW/OlMs95juLOko2oDi2Dce00r9XDhULNWfzEbk
         hWHbMeZbhB5oH0QyntYAzLHFYr3Ge/ziH3et46ouZhxRbcTtQ3zvl3QFAi/aKRu4Uv
         yyXAdZFEc5VjN9oJPB4nemQp9Mjc5offLizF89jc=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29BNHwu5029438
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Oct 2022 18:17:58 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 11
 Oct 2022 18:17:58 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 11 Oct 2022 18:17:58 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29BNHwxN058954;
        Tue, 11 Oct 2022 18:17:58 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Keerthy <j-keerthy@ti.com>,
        Linux Thermal <linux-pm@vger.kernel.org>,
        Linux Device Tree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bryan Brattlof <bb@ti.com>
Subject: [PATCH 02/11] thermal: k3_j72xx_bandgap: use bool for i2128 erratum flag
Date:   Tue, 11 Oct 2022 18:17:18 -0500
Message-ID: <20221011231727.8090-3-bb@ti.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221011231727.8090-1-bb@ti.com>
References: <20221011231727.8090-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1775; h=from:subject; bh=G++pLIL58zYxITYxZt/Js9a9L5y9Z83+mB8bqnuk0QA=; b=owNCWmg5MUFZJlNZc5J6KwAAaX////7vb/+7avme6zsd/nu7/8f/77/8u8bv2pntp/3m7/8wARsw HaTQaAABoAAaA0B6Rk0AAaAaAAABoNNGQA00ADEaDRptJoaaMI0aMnkT1CDRkaBoaDQyaNANGgaYJo NqGgGgAAGQaYhhGQA0aGQNGEGh6gGE0ABoAZCGho0GjQNNNNMgaNBo0BpkYjTQAGgGQMQNAGgMRgjE MgaAADJoANGmjAmmgBA3tsDH1kA+YS4MChQkNMixc48PamP0EQcH3h4R2dDz/YAQVaUENTyAQmq8wF ad8slCVbZEYU3Iu7xYLX0A5wexyloD4T877UUi2M24597+Sw4+8VipicodE4TYYnKVagXAMzImjuxT 2y6fX/C011ECzla3KscgUFGihCA2RkCM81BYHuYjLyoPekVmjWPI1629RHrE41+hs+kYlmqT5hz/Nz T8PLH1RBOhVWqQMx+jD0tWGOoqO6PQyFyrts22J8NpzwY1aTmL5QRWDQiCEoy3Af3xRdqUpDSlCpYX abMTH0B53AEBY35cS37+MiEEWUviNocE8xYnBrmL2gZqfIT4Xk1bjVnWC5YvzgxeQMBmiOiLQPv7Ea bqheyR6jJuDsgAyQ87cCsEueXpGZqK1zLypJEuEvTNBYkqC9OgEmMQgi439/WkR/i7kinChIOck9FY
X-Developer-Key: i=bb@ti.com; a=openpgp; fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
2.38.0

