Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A9B6B8BF4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 08:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjCNHb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 03:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjCNHb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 03:31:56 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39007B9B3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 00:31:53 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32E7Vdgn049498;
        Tue, 14 Mar 2023 02:31:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678779099;
        bh=32Yd0EmcM73jx9u+iu/Ik61H9RGH4/tolyK6eCbwNqI=;
        h=From:To:CC:Subject:Date;
        b=xXc7uCPp8xMgqEKaD8pYtVL07KSSEs3vg0OKc+m6FF+H7TyS+/6TKSFQbhypsqKJh
         2JB6YZhBef8eZF52awlDXZwmsja323b4RJgzag9dm5bJZJvPuc653szLKvRUy1an5V
         5z3jIB9CYo2qUztMb6jqM0vIoTU0/LdcAsgVM+3g=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32E7VdVQ089133
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Mar 2023 02:31:39 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 14
 Mar 2023 02:31:39 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 14 Mar 2023 02:31:39 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32E7VbVJ003849;
        Tue, 14 Mar 2023 02:31:38 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <linux-phy@lists.infradead.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <j-luthra@ti.com>,
        <devarsht@ti.com>, <tomi.valkeinen@ideasonboard.com>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <vigneshr@ti.com>,
        <nm@ti.com>, <sinthu.raja@ti.com>, <vaishnav.a@ti.com>
Subject: [PATCH] phy: cadence: cdns-dphy-rx: Add common module reset support
Date:   Tue, 14 Mar 2023 13:01:37 +0530
Message-ID: <20230314073137.2153-1-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sinthu Raja <sinthu.raja@ti.com>

DPHY RX module has a common module reset (RSTB_CMN) which is expected
to be released during configuration. In J721E SR1.0 the RSTB_CMN is
internally tied to CSI_RX_RST and is hardware controlled, for all
other newer platforms the common module reset is software controlled.
Add support to control common module reset during configuration and
also skip common module reset based on soc_device_match() for J721E SR1.0.

Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
Co-developed-by: Vaishnav Achath <vaishnav.a@ti.com>
Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---

Tested on J721E SR1.0 and SR 1.1 by CSI2RX streaming,
without this changes CSI2RX streaming fails on J721E SR1.1
and all other newer TI platforms (J721S2, J784S4, AM62X).

Logs: https://gist.github.com/vaishnavachath/3ecda7de0e63b13c6f765ae2c4f9c5ff

 drivers/phy/cadence/cdns-dphy-rx.c | 32 ++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/phy/cadence/cdns-dphy-rx.c b/drivers/phy/cadence/cdns-dphy-rx.c
index 572c70089a94..c05b043893a9 100644
--- a/drivers/phy/cadence/cdns-dphy-rx.c
+++ b/drivers/phy/cadence/cdns-dphy-rx.c
@@ -11,10 +11,12 @@
 #include <linux/phy/phy.h>
 #include <linux/phy/phy-mipi-dphy.h>
 #include <linux/platform_device.h>
+#include <linux/sys_soc.h>
 
 #define DPHY_PMA_CMN(reg)		(reg)
 #define DPHY_PCS(reg)			(0xb00 + (reg))
 #define DPHY_ISO(reg)			(0xc00 + (reg))
+#define DPHY_WRAP(reg)			(0x1000 + (reg))
 
 #define DPHY_CMN_SSM			DPHY_PMA_CMN(0x20)
 #define DPHY_CMN_RX_MODE_EN		BIT(10)
@@ -33,6 +35,9 @@
 #define DPHY_POWER_ISLAND_EN_CLK	DPHY_PCS(0xc)
 #define DPHY_POWER_ISLAND_EN_CLK_VAL	0xaa
 
+#define DPHY_LANE			DPHY_WRAP(0x0)
+#define DPHY_LANE_RESET_CMN_EN		BIT(23)
+
 #define DPHY_ISO_CL_CTRL_L		DPHY_ISO(0x10)
 #define DPHY_ISO_DL_CTRL_L0		DPHY_ISO(0x14)
 #define DPHY_ISO_DL_CTRL_L1		DPHY_ISO(0x20)
@@ -57,6 +62,10 @@ struct cdns_dphy_rx_band {
 	unsigned int max_rate;
 };
 
+struct cdns_dphy_soc_data {
+	bool has_hw_cmn_rstb;
+};
+
 /* Order of bands is important since the index is the band number. */
 static const struct cdns_dphy_rx_band bands[] = {
 	{ 80, 100 }, { 100, 120 }, { 120, 160 }, { 160, 200 }, { 200, 240 },
@@ -142,13 +151,36 @@ static int cdns_dphy_rx_wait_lane_ready(struct cdns_dphy_rx *dphy,
 	return 0;
 }
 
+static struct cdns_dphy_soc_data j721e_soc_data = {
+	.has_hw_cmn_rstb = true,
+};
+
+static const struct soc_device_attribute cdns_dphy_socinfo[] = {
+	{
+		.family = "J721E",
+		.revision = "SR1.0",
+		.data = &j721e_soc_data,
+	},
+	{/* sentinel */}
+};
+
 static int cdns_dphy_rx_configure(struct phy *phy,
 				  union phy_configure_opts *opts)
 {
 	struct cdns_dphy_rx *dphy = phy_get_drvdata(phy);
 	unsigned int reg, lanes = opts->mipi_dphy.lanes;
+	const struct cdns_dphy_soc_data *soc_data = NULL;
+	const struct soc_device_attribute *soc;
 	int band_ctrl, ret;
 
+	soc = soc_device_match(cdns_dphy_socinfo);
+	if (soc && soc->data)
+		soc_data = soc->data;
+	if (!soc || (soc_data && !soc_data->has_hw_cmn_rstb)) {
+		reg = DPHY_LANE_RESET_CMN_EN;
+		writel(reg, dphy->regs + DPHY_LANE);
+	}
+
 	/* Data lanes. Minimum one lane is mandatory. */
 	if (lanes < DPHY_LANES_MIN || lanes > DPHY_LANES_MAX)
 		return -EINVAL;
-- 
2.17.1

