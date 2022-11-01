Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E725615151
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 19:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbiKASKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 14:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiKASJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 14:09:45 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B980A1D0D0;
        Tue,  1 Nov 2022 11:09:43 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A1I9Z8X066871;
        Tue, 1 Nov 2022 13:09:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667326175;
        bh=zuc2d798pjg2cZJq4aTsVQVxPd6NLeA8WTnzeqH9IYg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=nml7eN3xtPKWgOOOSL7rto7+nj8u1GpdloyYEmZgo5jcVCW2wH4ediMZETDxTMR1a
         2DlKPYUDatjrCDB5T4E8iNG6RE5M00ADQqc6b085ECoVxjFbDj0sVsydSR6nYMPASk
         q7ysvErDYA7UyaehMIEGeV2kCojNOBv40wEDkA+A=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A1I9Zdl076789
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Nov 2022 13:09:35 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 1 Nov
 2022 13:09:35 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 1 Nov 2022 13:09:35 -0500
Received: from maitri.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A1I9ZVm008602;
        Tue, 1 Nov 2022 13:09:35 -0500
From:   Vibhore Vardhan <vibhore@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH RESEND 1/5] cpufreq: ti-cpufreq: Add support for AM625
Date:   Tue, 1 Nov 2022 13:09:31 -0500
Message-ID: <20221101180935.139268-2-vibhore@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221101180935.139268-1-vibhore@ti.com>
References: <20221101180935.139268-1-vibhore@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Gerlach <d-gerlach@ti.com>

Add support for TI K3 AM625 SoC to read speed and revision values from
hardware and pass to OPP layer.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
---
 drivers/cpufreq/ti-cpufreq.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index f64180dd2005..be4209d97cb3 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -39,6 +39,14 @@
 #define OMAP34xx_ProdID_SKUID			0x4830A20C
 #define OMAP3_SYSCON_BASE	(0x48000000 + 0x2000 + 0x270)
 
+#define AM625_EFUSE_K_MPU_OPP			11
+#define AM625_EFUSE_S_MPU_OPP			19
+#define AM625_EFUSE_T_MPU_OPP			20
+
+#define AM625_SUPPORT_K_MPU_OPP			BIT(0)
+#define AM625_SUPPORT_S_MPU_OPP			BIT(1)
+#define AM625_SUPPORT_T_MPU_OPP			BIT(2)
+
 #define VERSION_COUNT				2
 
 struct ti_cpufreq_data;
@@ -104,6 +112,25 @@ static unsigned long omap3_efuse_xlate(struct ti_cpufreq_data *opp_data,
 	return BIT(efuse);
 }
 
+static unsigned long am625_efuse_xlate(struct ti_cpufreq_data *opp_data,
+				       unsigned long efuse)
+{
+	unsigned long calculated_efuse = AM625_SUPPORT_K_MPU_OPP;
+
+	switch (efuse) {
+	case AM625_EFUSE_T_MPU_OPP:
+		calculated_efuse |= AM625_SUPPORT_T_MPU_OPP;
+		fallthrough;
+	case AM625_EFUSE_S_MPU_OPP:
+		calculated_efuse |= AM625_SUPPORT_S_MPU_OPP;
+		fallthrough;
+	case AM625_EFUSE_K_MPU_OPP:
+		calculated_efuse |= AM625_SUPPORT_K_MPU_OPP;
+	}
+
+	return calculated_efuse;
+}
+
 static struct ti_cpufreq_soc_data am3x_soc_data = {
 	.efuse_xlate = amx3_efuse_xlate,
 	.efuse_fallback = AM33XX_800M_ARM_MPU_MAX_FREQ,
@@ -198,6 +225,14 @@ static struct ti_cpufreq_soc_data am3517_soc_data = {
 	.multi_regulator = false,
 };
 
+static struct ti_cpufreq_soc_data am625_soc_data = {
+	.efuse_xlate = am625_efuse_xlate,
+	.efuse_offset = 0x0018,
+	.efuse_mask = 0x07c0,
+	.efuse_shift = 0x6,
+	.rev_offset = 0x0014,
+	.multi_regulator = false,
+};
 
 /**
  * ti_cpufreq_get_efuse() - Parse and return efuse value present on SoC
@@ -301,6 +336,7 @@ static const struct of_device_id ti_cpufreq_of_match[] = {
 	{ .compatible = "ti,dra7", .data = &dra7_soc_data },
 	{ .compatible = "ti,omap34xx", .data = &omap34xx_soc_data, },
 	{ .compatible = "ti,omap36xx", .data = &omap36xx_soc_data, },
+	{ .compatible = "ti,am625", .data = &am625_soc_data, },
 	/* legacy */
 	{ .compatible = "ti,omap3430", .data = &omap34xx_soc_data, },
 	{ .compatible = "ti,omap3630", .data = &omap36xx_soc_data, },
-- 
2.34.1

