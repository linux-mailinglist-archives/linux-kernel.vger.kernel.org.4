Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC260706DE8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjEQQR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjEQQRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:17:47 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2081.outbound.protection.outlook.com [40.107.6.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7899DAD13;
        Wed, 17 May 2023 09:17:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrFEF3GtTS0q6qk5HK2W0VTVOLxv6tPsz0TfyV2Uij68yM/bES2YkAqxnAoBdaFiOkOmXp1zsLT8nodye10CArNDxg0P1WhFYb7whUJ4OVDmxUFcCuUR/G5AB5rNGJOujuF6EHGJgSe+wu9Hcivwr0/NZcc8T3jjK8GpL0Q13iQ+G744cIOJpbNKGxq1THlH2ArYEpcpMkinVHO83lLRPlH/tbINB4+GEkg0YdC4uQO9vzpHILGzlZK0bJ+d3gyWDQ2EQtoe7Zs3SvUXHtIjhWoc04nYep0xdJAflqhW0qCCkzJDSYqKGrKtsFnksGtA7jifkO3POzsI8P8e5MsFqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nX0CZJ3GGOrXF/ob/7N3uvCKNqXVGbt/JOtIlC5YRno=;
 b=UWFOveDHZvVNZP+B0R/BorZwEyibDnVvwTFqSwlAAscfJQw2X010iWXcP6SLOCQGJP2pqCWuwpnEa8/yY2zVQ1M2XKbYWMX7aZAd3QdWO+VcANb9cJTxaV3RPiaz0SIiIdbJxFzzhv0LAZj1RdKKA3gt32XjR9mx7hqnzJzsoiGhDm16oL2q+/o9CMhtfpadjLxY2lfOc2pcekm+MvBDJ5M9Dql2NmZxYPaIlG841NxFuB6z5vQ+6oaAYDkBWAY1WpRysP29aWtnEonw8FPET7W4ivVHG7rFAQOeAlv/qG+jacgbv7GIvu8UJmdWZtvgROB12MRH2MJVSdt5xXkurg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nX0CZJ3GGOrXF/ob/7N3uvCKNqXVGbt/JOtIlC5YRno=;
 b=jSI5VtJnyV1Y+T14neE1u/P8Fjkl4ogCQ+QUdXv9f50Q6sf+nZV8ojhXb3ZF1+x6QJpzIqAFLnm8KYECZq5jfhfYCxdnIfM1pAO7+Fc0TE7fDaFCzWm3XWF8X0och0o+a6u6mk6GExuY+6sp+2Qqdsi0U4UfHuqWD0yNTMgwCBQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9962.eurprd04.prod.outlook.com (2603:10a6:10:4c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.34; Wed, 17 May
 2023 16:17:25 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 16:17:25 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org
Cc:     Frank.Li@nxp.com, devicetree@vger.kernel.org, fushi.peng@nxp.com,
        imx@lists.linux.dev, kernel@pengutronix.de, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: [PATCH v5 5/6] phy: cadence: salvo: Add cdns,usb2-disconnect-threshold-microvolt property
Date:   Wed, 17 May 2023 12:16:45 -0400
Message-Id: <20230517161646.3418250-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517161646.3418250-1-Frank.Li@nxp.com>
References: <20230517161646.3418250-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::16) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB9962:EE_
X-MS-Office365-Filtering-Correlation-Id: fc15543a-61cf-438d-fa14-08db56f233c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wt1hYMW/6EM6+GIL4MTQlM6ruJmvM2I0vRRe5jpYBmqtpBUm3khsVhFEVoddIxi9dYPkiKTP8Ee60aqMt20aLtR5x0dWe4Z7IOhb79hWLkmHIy6fykoAUnYsuMUwukoU6XcK0SOYCnLfIMi4UpHJxlZA0APG19+amsj4QxSSqv7JZxid/hCgsk2uvNWM/AMeAIMpWw0HlxMwv7MU4Usa4CfJmuYMjuGOtQbweTgcabPY6fG9Jcs89aJy0NVzDl2GFhGh++uJIxjZFSk6rFf5TBzRH1vlyvB+uomXPhIAWA83gRzGek0LiT1+Cs6lQAHSmWqHJUu81kupZZvMOFhbeMeSydVpAr6zAVXH+wjV0fqfqyKXKlfobbcWzQa7EwY+tgEYm2CF+cQlRX30JNu2vASJIvEy8B9e4XM6mFIXnoKhKaVLNr6J72mOkMoCugL0Q5+mzXdi4U0xjnP1Ztnz4CNzJfi1Muw/X9fOmt8k1McVtujasUzXtHn0328RpM5d0JaSu1UeEPisHK+Tajt8Ytxk7CayJ/VfHbw1mLXVD/N3XJI+vVdpfVZ6nT67gN17cQjFALkqM6KoHPK3plD0xe1LMiv6hKlCKfoZh5gaZaGeF9HHfPGfu80FYnjPy1pb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199021)(6916009)(316002)(66946007)(66476007)(8936002)(66556008)(4326008)(8676002)(2906002)(478600001)(6486002)(41300700001)(5660300002)(6666004)(7416002)(52116002)(26005)(1076003)(6512007)(6506007)(186003)(2616005)(83380400001)(36756003)(38350700002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3WAfWwb7hhIch+a08N+XpZpjtUQC/AxSOzbXAo+jy79ttLheGeV+DZb6V05l?=
 =?us-ascii?Q?tRTI/N6rjKSXjHUrIDjUuQtXGsGWnc9y5Ze3ckcCW6XyZ9tFhswZ96/CSnm0?=
 =?us-ascii?Q?i0xtLzJJ24CBvoSbD07kyCEK/OzE4P2bC2kwjaWo7+cRTN254immYhhpzcV+?=
 =?us-ascii?Q?qWlhv3KwlJn8WSeS3KoR+k1aZdQ8O+Yy8eJ6zaZm+lh4IjxpZkFPbkXZVP7C?=
 =?us-ascii?Q?OB/MfRe+4Cp1E/TvvbJztXAP96AJ6i1hSZUMJocxIVSF3tByNc0a87ygDqY0?=
 =?us-ascii?Q?MYkxfRK0jCWYdEzggZIWV3Nahae5xNfqiW4Sn+lK5wPqZNb2m3Qt4uotmlhJ?=
 =?us-ascii?Q?gR1SHlhjGSle5MjwiUSV8hhfq8ajzn4StJ91kZzNiUiAMNccn6ykBcJ1yHCC?=
 =?us-ascii?Q?0u6xIa9V/SdVjAc1OQjXFS7n/tluinZYCReyemgVMmPGO3yvqf+aeOzU6ig3?=
 =?us-ascii?Q?3/b7Dg+w0t6mnmjQm0pbs0wrbbvHbqM9qJzWOo3ClGlC1SM7SUNa+aVYNzmQ?=
 =?us-ascii?Q?lUfZew6rSdGXcDBZ3ZQAbOSdlze2d5vWoA7UJt/iYeDkV5zfb0VMf4VnAxBA?=
 =?us-ascii?Q?cSN2Tp4kZ9K2M/DAlCohfYf+pbz/8c+rVJe745j6gDorx85fa8b5nyCcEJa6?=
 =?us-ascii?Q?DPEmiKMhoFSrg/yAC4HZ9trUkcmZdSoJDmxC+GGfr1tiRFUK50Vd23i9x9CY?=
 =?us-ascii?Q?vRTvhu8KAzKnIj+cRAPDWqEnMwPiXINXK9j46gd4GYmQs5+9G9cszD2m6pQv?=
 =?us-ascii?Q?KGsrIIpihB1GZx0Zc+dGqfsMmIL5YdoL/BT1a2sNJH7KdFhDvPNrGwU1+PxC?=
 =?us-ascii?Q?NxzmNoB/8/HoyW7B4feUsOGHbXKLqU/NPJ4stWV8IkTeK3BjzQ0R7914XDZI?=
 =?us-ascii?Q?QjaQu1BtLxZpg69QrqNBGg0R/qKvxm/JJYptnJ2i89rOqhYnjuEuroy7c/HW?=
 =?us-ascii?Q?WMuj4vGUEOW4M/s4k7dYPIdw99BchC9p8d6nsZ4BVmv0bvGECk0mfqyDYMBL?=
 =?us-ascii?Q?y86THlSxNCN40D/s5qLPEU1m5QW9wxQIbwSk1u0rdR+dh5MWmRSrr3bkpidj?=
 =?us-ascii?Q?Cjb1IrAblNguP7ld7FHz8ZykEiR3jkXFYXZJku0utPPip+Vd6ERJJFbXMzmW?=
 =?us-ascii?Q?sU5ntXyWdQzIdgqCooSAUTMpJjaaUu3vBVRe/29nh0wwGvZnFiZMVg/ykIYA?=
 =?us-ascii?Q?yH/WQkL+j5Rxw4fxRi0L5ScmO7jIhupuB3daJW9lKh/BKqdC0XrR17kWn076?=
 =?us-ascii?Q?C+z0r1pGAsWyAb42Rp1UFFs6voydH4J0ph2ZL7aF2ewj9I11LFtBmtmqeQme?=
 =?us-ascii?Q?+4eI8wlebzuiqin+mXeLQUu63+ATcgCGUogjbgpFRkmTA/j91+LUHv0tIbhZ?=
 =?us-ascii?Q?/333uKe5zx3MGfo96AO1u7kBncsOyoKun53jxo5O2h0GJgjpRe0av7o8dLyd?=
 =?us-ascii?Q?5h5KUSddTfhw10cugAkQ49RAQK05VEWsEJzG5j+Kfh2+q2UrG7Z44GndFucN?=
 =?us-ascii?Q?fRlCCFpRt7GMw9QlmapUcFE95STXJwjnXDrgyhxA9t89QGI4OJe/H3fFw98x?=
 =?us-ascii?Q?yLgbz/UqVsqHKIBQz94=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc15543a-61cf-438d-fa14-08db56f233c4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 16:17:25.5202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QBfD697m1lJLTK8G4gq5OTj/wrgIsUNXdM9ah05AI24RSo1bdhPcsgTdmb371F/EAxvE3UOk0/a3+V/hXQhP5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9962
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add cdns,usb2-disconnect-threshold-microvolt property to address fake USB
disconnection issue during enumeration or suspend state for difference
platform.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/phy/cadence/phy-cadence-salvo.c | 29 +++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-salvo.c b/drivers/phy/cadence/phy-cadence-salvo.c
index 083de7190819..f461585c84c6 100644
--- a/drivers/phy/cadence/phy-cadence-salvo.c
+++ b/drivers/phy/cadence/phy-cadence-salvo.c
@@ -6,6 +6,7 @@
  * Copyright (c) 2019-2020 NXP
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -91,9 +92,19 @@
 
 /* USB2 PHY register definition */
 #define UTMI_REG15				0xaf
+#define UTMI_AFE_RX_REG0			0x0d
 #define UTMI_AFE_RX_REG5			0x12
 #define UTMI_AFE_BC_REG4			0x29
 
+/* Align UTMI_AFE_RX_REG0 bit[7:6] define */
+enum usb2_disconn_threshold {
+	USB2_DISCONN_THRESHOLD_575 = 0x0,
+	USB2_DISCONN_THRESHOLD_610 = 0x1,
+	USB2_DISCONN_THRESHOLD_645 = 0x3,
+};
+
+#define RX_USB2_DISCONN_MASK			GENMASK(7, 6)
+
 /* TB_ADDR_TX_RCVDETSC_CTRL */
 #define RXDET_IN_P3_32KHZ			BIT(0)
 /*
@@ -125,6 +136,7 @@ struct cdns_salvo_phy {
 	struct clk *clk;
 	void __iomem *base;
 	struct cdns_salvo_data *data;
+	enum usb2_disconn_threshold usb2_disconn;
 };
 
 static const struct of_device_id cdns_salvo_phy_of_match[];
@@ -260,6 +272,12 @@ static int cdns_salvo_phy_init(struct phy *phy)
 			 value | TXVALID_GATE_THRESHOLD_HS_0US);
 
 	cdns_salvo_write(salvo_phy, USB2_PHY_OFFSET, UTMI_AFE_RX_REG5, 0x5);
+
+	value = cdns_salvo_read(salvo_phy, USB2_PHY_OFFSET, UTMI_AFE_RX_REG0);
+	value &= ~RX_USB2_DISCONN_MASK;
+	value = FIELD_PREP(RX_USB2_DISCONN_MASK, salvo_phy->usb2_disconn);
+	cdns_salvo_write(salvo_phy, USB2_PHY_OFFSET, UTMI_AFE_RX_REG0, value);
+
 	udelay(10);
 
 	clk_disable_unprepare(salvo_phy->clk);
@@ -314,6 +332,7 @@ static int cdns_salvo_phy_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct cdns_salvo_phy *salvo_phy;
 	struct cdns_salvo_data *data;
+	u32 val;
 
 	data = (struct cdns_salvo_data *)of_device_get_match_data(dev);
 	salvo_phy = devm_kzalloc(dev, sizeof(*salvo_phy), GFP_KERNEL);
@@ -325,6 +344,16 @@ static int cdns_salvo_phy_probe(struct platform_device *pdev)
 	if (IS_ERR(salvo_phy->clk))
 		return PTR_ERR(salvo_phy->clk);
 
+	if (of_property_read_u32(dev->of_node, "cdns,usb2-disconnect-threshold-microvolt", &val))
+		val = 575;
+
+	if (val < 610)
+		salvo_phy->usb2_disconn = USB2_DISCONN_THRESHOLD_575;
+	else if (val < 645)
+		salvo_phy->usb2_disconn = USB2_DISCONN_THRESHOLD_610;
+	else
+		salvo_phy->usb2_disconn = USB2_DISCONN_THRESHOLD_645;
+
 	salvo_phy->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(salvo_phy->base))
 		return PTR_ERR(salvo_phy->base);
-- 
2.34.1

