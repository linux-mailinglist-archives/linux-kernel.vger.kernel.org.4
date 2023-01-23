Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BAE6773FC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 03:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjAWCOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 21:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjAWCN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 21:13:56 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2080.outbound.protection.outlook.com [40.107.14.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5C3125A5;
        Sun, 22 Jan 2023 18:13:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1oYmRkTWhd1biYey7fywkFSGJ3WJNAa7hRz3xKx8xO3WI989hggmUdahicEyw+IVfcGTa+6PCRSNDMchrVSKJOaZSucLoITv2dlr3cKC10xztouPefoPoo3vuK1H3L9bpFon2Kuv9/SJCDYpm9jz/a4dKtjoZYLKss3rDPgG97gOgy5b8+xadpHbfeJHUomWOyvPmz5vZ2CA1OGe4yMuUr4Uzp/vo6tcz0YWaW1RIXNwmosDusqiDVSuPlZNlePUmyIu/z7LSTpO2CEjufUHEqDrTdlaI+dUrZdX4VdXePH708Eb+1DMGFsIgEeLQnHhSrjNVtaHBpaJE2WGup2JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbQ4hXdcQ9XzWZ3sm2C00GQzDJIopwbebbFoD4Y3CI8=;
 b=dPkC98QB4EsHCS10t2pDzrRrYAdYu9OUheh5ZdEFTxGXzn0vq4KFQAV7my9/aymA4jzqCHzseEp3Jwz5n7iLFEsmEzT+sR828UBa3Dt1ncqR8azr/3sZScMIVIA4V/XiFNaUmVM3gnuyS8GRD2AeLbWFSKUt1d+iZ6FWXwdD9G/BmAHgrIZ5ZPVjd0ys73x1vthxAnpxOv12ScFAkEGlhn5/JZNWqwDXQc9FfZaEhFEMTBUtR3z7MuLdGCRnClKnYMszqfw+KfGN7lAQSZZ2XdX2sPSh+K4uHYXAeV6R0jtHMdBi2P0nswjfZ6JggF47WrDoFN2wBMz0Lobb1QheVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbQ4hXdcQ9XzWZ3sm2C00GQzDJIopwbebbFoD4Y3CI8=;
 b=g2wpDe7kvh1s3OZsk+o7jpxxXgOFAubrWmIvRvxy0sxlW9kvztqJxgnfRGv8gel5LkI36AM5PCo9p56bJuI9mFXBvqrrIjy+PCtXebhpwOPHFu2rwkn2Fgk52+ZUC96YCST7BHQi3Yh98fTHUzwrimTGXOD/qjkRxhf2Z79kAGo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by PAXPR04MB8878.eurprd04.prod.outlook.com (2603:10a6:102:20d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 02:13:51 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::5725:92ec:f43e:f5fc]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::5725:92ec:f43e:f5fc%7]) with mapi id 15.20.6002.028; Mon, 23 Jan 2023
 02:13:51 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, marex@denx.de,
        linux-imx@nxp.com, krzysztof.kozlowski@linaro.org
Subject: [PATCH v3 2/2] drm/bridge: fsl-ldb: Add i.MX93 LDB support
Date:   Mon, 23 Jan 2023 10:14:49 +0800
Message-Id: <20230123021449.969243-3-victor.liu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230123021449.969243-1-victor.liu@nxp.com>
References: <20230123021449.969243-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::34)
 To AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|PAXPR04MB8878:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c517fee-776a-4ff1-fcd9-08dafce77881
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NGorLzKPvZmQy4eAsssUKZ9hKOX8+NIx+3S/iDmdSfynXmOCUKwxFtvu9wyGaiXVJVem9YwkRXJNpqyRjFORVB/ILVIHBlmlfYO7NrPOBcDH+07T3obwAYSJ6XeLyOsw8l0tUTNoY0mgqShKhS79lY7TfoOFX35QrkCc1P82r9tqcVEHj57+lmkF2MwBNIEU0zYGWRNZhvrueO5pemFkZPN8MCH1AXbk2ggagyPhEYB5uWvSEG5vyn2iPgf1h/9ix6I3ruB0CB3OY2WELhl7U1XY8vY1gJr8ZdkefYQu0Q8snAsu4/6LWTlGR8hJxULlOPXQ7LKNMVXHnbFiNChND2EdqBtvEre3FdJbt2vlJTxWpfz7IP0uKq2nQR0tkzljaZDP6Os4gkaA18yZ9z+P2qmzssmhXMy44C2fH3UgVvME9VNfVkpgMPkw627HRCiq7hMbijdnNeU+RvjMWnOXRJtrUcUhfizXnHODMWieSBcYrACvmN1ZcacbyWMT5Q0y2XzWa8JPlRx9Sn5nuGBRUKEDywqY19DV4c8TSvhNzTYAXoWR21untu4GBGOhHv6oGbjpxZTnB60An3zuXiCN4UCkaa08i1KsQyn7gExHzUcN3QGgOWoCfLr66x/L1qdeSun9/+soyF097UyOe952DrLID3o2D+PvALan8G2QuJSpt3bLcQqdJCXdqoM7oXn602O3adkL3hnqDSlyV9zO4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(451199015)(36756003)(2906002)(5660300002)(38100700002)(38350700002)(7416002)(8936002)(4326008)(41300700001)(83380400001)(52116002)(478600001)(6486002)(66476007)(86362001)(8676002)(26005)(6512007)(186003)(6506007)(316002)(2616005)(66946007)(1076003)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?znieduWDIf/vuG2eZEaZ8T7fjoewtuPykJ3MIvX9bWvg3epJAX1BZsMjuDOT?=
 =?us-ascii?Q?VYGeveqllYLOQkn3jq/kMzVVTfaYanpxowgBJbv1LycX/lehalnbAQGSZj1f?=
 =?us-ascii?Q?wZf9iW2SS3+KZiyhLME2oezrTi3tkLLs7pCee9syfASUL+o7ahY0rYOrd9d2?=
 =?us-ascii?Q?sBQsmaMnuaLlWaJJShEskgfvOd19GwD8pLBmkr5oFnBj7mlQ0Oz/ydqGeePB?=
 =?us-ascii?Q?JX0hU/GfS6i+awN5W1dPp7Tj1O5W/UFAY92ATsb9HIfQqIk0f0kUDCHXw3uD?=
 =?us-ascii?Q?qKj5vliLBXxAh3LfRloZTLcmySo1bftxG3BK7BUK+sSbZcuSeySrzBIqYF/k?=
 =?us-ascii?Q?b+OW8Ox2Q9ABPakZglKC+Z3LycNGLUR1IbyaLRFJ7sA6mA7S7h+nqRtU8BJy?=
 =?us-ascii?Q?0hXe/UUy0xU6ADZvpTABrrnxmgxfT6IjBX+mk6HnOb0Qgu7v6zwL/XtIqgKk?=
 =?us-ascii?Q?cdXyYBzI8hzW1DLiVCby80yujpHpU8tV0zkSxWbRzIPgdpzGiDEuktPZgqnY?=
 =?us-ascii?Q?UR7dF3x0+tQMfTUjPc2ipB1DPYQQ+1xys94fLB9fUtfSPYzq9NCaH//2qGNo?=
 =?us-ascii?Q?aSxgRQmFMXJ92otMyQ/Sz8Wz1WAyYpBTo34fHkATZo/Tctx++pJ1kPcGvHAX?=
 =?us-ascii?Q?nls6lRDAxQUYhOJMy8x+7TkmdLD74pzXz5/Y6ZE4lbkvdIY9YvcBrLsUP5Jv?=
 =?us-ascii?Q?zmq1SgwQ7RYF3ndtyd7Z4U4sTjCKcamNTF1lXXgKQXLxuuLxVvKS6XSXb5Wi?=
 =?us-ascii?Q?aIh6h9ioaguQHvsFVJ9jDlYQu5qw4WS++iFVmqeuicF77/4zFp23WloWKgWV?=
 =?us-ascii?Q?uUdKUHWcNBRHb2Yr8MBzblzwI2lSjrb6gP86rt3ITzjulZudATfkKYb5hYiX?=
 =?us-ascii?Q?ogrJB8w6GV0PgpPKnbUg8esrdXfGqwpdsjoZ6y3P62bb1roGoE5j241e41Yx?=
 =?us-ascii?Q?CH9QFBZRMVLkNKFENiSZqc7tLeqFAWYtE+H0XEcb92oWz/C1I3hXQ7DOtbKx?=
 =?us-ascii?Q?bOLxcdC/tyof50HCwMvJCKhhWlvc2iIIF7N8bPSjof7q7wUoq73JvXM0KfX/?=
 =?us-ascii?Q?VjTwaNBUIlNpOVCkQpOMuW2G1yZx/a8uMe8hyAhKZLKJBCe7G9I4N4cfoyUH?=
 =?us-ascii?Q?lXp1QaKHPF4d6kFGlVW8aeRkOvWLa64CJNbwEl0z+RAFpSiW2nEKS99oFWSZ?=
 =?us-ascii?Q?IdBBHZ9MkYp4C91eOqp8Gvm/QDs4b6SvuN9+x22srJdwoQFJ/GRTvwKcuzUA?=
 =?us-ascii?Q?1dD7TQ7lJSWruYkaCyyvII4ADgRGeu3eyYZR09T3Guj0+OtkFpMITmPb5QCu?=
 =?us-ascii?Q?J4KnCaj3spCJxiP/zJYMXYB/oQGU5Y0SnKqmCWVvCu8wB/EzSxtsInCoZov8?=
 =?us-ascii?Q?v70HC1rpQxMluE3dKbTntQjUlX6hlJCHh+5B+lXLYTCWoletn8YadmfxuLIk?=
 =?us-ascii?Q?X3gOUSoNFeZPrPLOSpsBLsGzCcmU0QknM837XpuYqDjjZigLAG/JyFyVZ1AP?=
 =?us-ascii?Q?mu1EXAYU0St/4dOkg6NqkEu4130fIYoAbKJmqTcyZfpGCutlrfgmMU3weHr/?=
 =?us-ascii?Q?o7FDZrA6e2/YcHwhtQrwTFQm0NSGVbn8Bf2nEeZ7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c517fee-776a-4ff1-fcd9-08dafce77881
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 02:13:51.7493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qXGc1ZGqJNahAMmQTLUaZ3DsbFhld5FxhM4mHqDHaJ0qMVzojHIM/5kVqaOndDfJ07wok6Rat3w7LOj3g5ddzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8878
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same to i.MX8mp LDB, i.MX93 LDB is controlled by mediamix blk-ctrl
through LDB_CTRL and LVDS_CTRL registers.  i.MX93 LDB supports only
one LVDS channel(channel 0) and it's LVDS_CTRL register bit1 is used
as LVDS_EN instead of CH1_EN.  Add i.MX93 LDB support in the existing
i.MX8mp LDB bridge driver by adding i.MX93 LDB compatible string and
device data(to reflect different register offsets and LVDS_CTRL register
bit1 definition).

Reviewed-by: Marek Vasut <marex@denx.de>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v2->v3:
* Provide comment on LVDS_CTRL_LVDS_EN bit when defining it's macro. (Marek)
* Add Marek's R-b tag.

v1->v2:
* No change.

 drivers/gpu/drm/bridge/fsl-ldb.c | 57 +++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c b/drivers/gpu/drm/bridge/fsl-ldb.c
index f9e0f8d99268..85e0ccb27afe 100644
--- a/drivers/gpu/drm/bridge/fsl-ldb.c
+++ b/drivers/gpu/drm/bridge/fsl-ldb.c
@@ -18,7 +18,6 @@
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 
-#define LDB_CTRL				0x5c
 #define LDB_CTRL_CH0_ENABLE			BIT(0)
 #define LDB_CTRL_CH0_DI_SELECT			BIT(1)
 #define LDB_CTRL_CH1_ENABLE			BIT(2)
@@ -35,9 +34,13 @@
 #define LDB_CTRL_ASYNC_FIFO_ENABLE		BIT(24)
 #define LDB_CTRL_ASYNC_FIFO_THRESHOLD_MASK	GENMASK(27, 25)
 
-#define LVDS_CTRL				0x128
 #define LVDS_CTRL_CH0_EN			BIT(0)
 #define LVDS_CTRL_CH1_EN			BIT(1)
+/*
+ * LVDS_CTRL_LVDS_EN bit is poorly named in i.MX93 reference manual.
+ * Clear it to enable LVDS and set it to disable LVDS.
+ */
+#define LVDS_CTRL_LVDS_EN			BIT(1)
 #define LVDS_CTRL_VBG_EN			BIT(2)
 #define LVDS_CTRL_HS_EN				BIT(3)
 #define LVDS_CTRL_PRE_EMPH_EN			BIT(4)
@@ -52,6 +55,29 @@
 #define LVDS_CTRL_VBG_ADJ(n)			(((n) & 0x7) << 17)
 #define LVDS_CTRL_VBG_ADJ_MASK			GENMASK(19, 17)
 
+enum fsl_ldb_devtype {
+	IMX8MP_LDB,
+	IMX93_LDB,
+};
+
+struct fsl_ldb_devdata {
+	u32 ldb_ctrl;
+	u32 lvds_ctrl;
+	bool lvds_en_bit;
+};
+
+static const struct fsl_ldb_devdata fsl_ldb_devdata[] = {
+	[IMX8MP_LDB] = {
+		.ldb_ctrl = 0x5c,
+		.lvds_ctrl = 0x128,
+	},
+	[IMX93_LDB] = {
+		.ldb_ctrl = 0x20,
+		.lvds_ctrl = 0x24,
+		.lvds_en_bit = true,
+	},
+};
+
 struct fsl_ldb {
 	struct device *dev;
 	struct drm_bridge bridge;
@@ -59,6 +85,7 @@ struct fsl_ldb {
 	struct clk *clk;
 	struct regmap *regmap;
 	bool lvds_dual_link;
+	const struct fsl_ldb_devdata *devdata;
 };
 
 static inline struct fsl_ldb *to_fsl_ldb(struct drm_bridge *bridge)
@@ -158,12 +185,12 @@ static void fsl_ldb_atomic_enable(struct drm_bridge *bridge,
 			reg |= LDB_CTRL_DI1_VSYNC_POLARITY;
 	}
 
-	regmap_write(fsl_ldb->regmap, LDB_CTRL, reg);
+	regmap_write(fsl_ldb->regmap, fsl_ldb->devdata->ldb_ctrl, reg);
 
 	/* Program LVDS_CTRL */
 	reg = LVDS_CTRL_CC_ADJ(2) | LVDS_CTRL_PRE_EMPH_EN |
 	      LVDS_CTRL_PRE_EMPH_ADJ(3) | LVDS_CTRL_VBG_EN;
-	regmap_write(fsl_ldb->regmap, LVDS_CTRL, reg);
+	regmap_write(fsl_ldb->regmap, fsl_ldb->devdata->lvds_ctrl, reg);
 
 	/* Wait for VBG to stabilize. */
 	usleep_range(15, 20);
@@ -172,7 +199,7 @@ static void fsl_ldb_atomic_enable(struct drm_bridge *bridge,
 	if (fsl_ldb->lvds_dual_link)
 		reg |= LVDS_CTRL_CH1_EN;
 
-	regmap_write(fsl_ldb->regmap, LVDS_CTRL, reg);
+	regmap_write(fsl_ldb->regmap, fsl_ldb->devdata->lvds_ctrl, reg);
 }
 
 static void fsl_ldb_atomic_disable(struct drm_bridge *bridge,
@@ -180,9 +207,14 @@ static void fsl_ldb_atomic_disable(struct drm_bridge *bridge,
 {
 	struct fsl_ldb *fsl_ldb = to_fsl_ldb(bridge);
 
-	/* Stop both channels. */
-	regmap_write(fsl_ldb->regmap, LVDS_CTRL, 0);
-	regmap_write(fsl_ldb->regmap, LDB_CTRL, 0);
+	/* Stop channel(s). */
+	if (fsl_ldb->devdata->lvds_en_bit)
+		/* Set LVDS_CTRL_LVDS_EN bit to disable. */
+		regmap_write(fsl_ldb->regmap, fsl_ldb->devdata->lvds_ctrl,
+			     LVDS_CTRL_LVDS_EN);
+	else
+		regmap_write(fsl_ldb->regmap, fsl_ldb->devdata->lvds_ctrl, 0);
+	regmap_write(fsl_ldb->regmap, fsl_ldb->devdata->ldb_ctrl, 0);
 
 	clk_disable_unprepare(fsl_ldb->clk);
 }
@@ -248,6 +280,10 @@ static int fsl_ldb_probe(struct platform_device *pdev)
 	if (!fsl_ldb)
 		return -ENOMEM;
 
+	fsl_ldb->devdata = of_device_get_match_data(dev);
+	if (!fsl_ldb->devdata)
+		return -EINVAL;
+
 	fsl_ldb->dev = &pdev->dev;
 	fsl_ldb->bridge.funcs = &funcs;
 	fsl_ldb->bridge.of_node = dev->of_node;
@@ -306,7 +342,10 @@ static int fsl_ldb_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id fsl_ldb_match[] = {
-	{ .compatible = "fsl,imx8mp-ldb", },
+	{ .compatible = "fsl,imx8mp-ldb",
+	  .data = &fsl_ldb_devdata[IMX8MP_LDB], },
+	{ .compatible = "fsl,imx93-ldb",
+	  .data = &fsl_ldb_devdata[IMX93_LDB], },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, fsl_ldb_match);
-- 
2.37.1

