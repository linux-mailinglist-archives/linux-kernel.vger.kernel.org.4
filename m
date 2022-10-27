Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1F560F486
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 12:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbiJ0KKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 06:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbiJ0KKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 06:10:43 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2045.outbound.protection.outlook.com [40.107.105.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD6B4B9B2;
        Thu, 27 Oct 2022 03:10:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZwfQAH7FIF+7lgZQqjsAr66TKZFdgCi3Xb0Wg9vT81c+WqHROThE3XznYfVI6keh/5wB+psO/L97s5+ykYLk09k7OXXTEVPmUVHpffWnkaLddLhXbStHvKkMTbYOhqI85jS68NCo83dXNegoA7p5bK5iOkQ7Vkr+cvbBe/FMgLDkfY25yM9ZMVMMnTA0u7KC5OSKtj3goBDClN2VWdd54nixDbpPVpy4goZBwkpnh9zGr6VypJTpkny4Uj7fDAeyoMSXJsEDU4nyoGkb8c98pT+xNSJ1lb9q9Iq6iHZMXxmobrODWfAmgYUnV8oATzrOhNal1KB1Jjew75qUmVAzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCK4+CAft4YD+4vtWrpNNJ50gAt2GZlH8Q7y4AflR0s=;
 b=ezOil3aGbxmGh7DFwnDEV4W2PeB5LWoSAyk78BS9paZZLUOZ/6rX8mJcmosxOsqd1anJyHhyz3Wo77aZoECff6jxjRtfXr8rne58F0wem2Wi8S8f/qLcAAq4bXDXSllPWEv0nq0Ke2pqQLAroE/q1NkhY1AXtxa6K8aV4uIxyrZ1PHFXEKvr53hMySU1aMNRxsP+bGWauhzgGUeAljQL16FysQvAzlhtoCCcfOqNo1QhUbc4KyCTSejT8MMHBOfLHzb0J+XxDjsO8ahibxtNFUNpXUCSix3ZuKkcTUyblC0xshzT816vz7wbmDyY9EoUI1thWljoCJqyFB2jl3WPDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCK4+CAft4YD+4vtWrpNNJ50gAt2GZlH8Q7y4AflR0s=;
 b=kvrcC+yVayN2pWRpgzT4ywpDVkCn7yWR5PwvOvqbxjRFAFWhh0oovGvj8Nrva1NaygnhmBbH89GYpnODvvy79rq78VLtgJzf5poStFI0AFeqxnPIvrR1jZRlPsqFkXaBea+OjSo6SVaq9aFIc3WHZCuaK1w2CLOpuVv/TfSn7T8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB6871.eurprd04.prod.outlook.com (2603:10a6:20b:109::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 27 Oct
 2022 10:10:38 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18%5]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 10:10:38 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 1/6] clk: imx93: unmap anatop base in error handling path
Date:   Thu, 27 Oct 2022 18:11:54 +0800
Message-Id: <20221027101159.942843-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221027101159.942843-1-peng.fan@oss.nxp.com>
References: <20221027101159.942843-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM7PR04MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: 58e0ce20-6616-4c79-cde2-08dab8037ea6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NoFaazaFWN9AXmuwt/wSVN4lFlGkuFwF5iIk1BLgr67LrjeNHh6Qbjq4nhX3dsl0wHeJQQUuaLVhzawyzgeUlSd7q1vgVkbVXWDkiz2H4yFNyayJtzEoBBwxjTSY41Kedp+6GHeN2lID1sSuBnVJnbGOoi3U5QRjzmTPNI/pDkvbVnH/qKB3fz/hAnvrYPzKfdNvj/UkIK9GN1W3hm3+dlYL0UslavFWJZzBwR75laiDkAd8AV4i46/DSZktO+bntD8cBYc48K8OYBFnmn9z7XTBaujU7Ojmbz+sICvTUTrpbFxOHUcUr3ilB/8TWZWjdK2N/SuWYDU2nBs+CrUpMBAIX71K9clfFf2SbEMh7Jy/SkzyDSVBqrPCyUAvXxqW2BIy7ELRQ9Cdp2LKyEfKFj1llr4BiS99HdgN/FOekwfasRY2BdD+sLrfH/WRQi2NShZC+2k+7eHYn28N5VaBotwt66OY8KlSdFx42XAYOF19Gu3/7lZiQ6dH+2+mJrXQ6yN00WAQ18FSLBB5TkE26/ZFmNBHZOu4WpHaAlhMXp9YM61uRdSzNZJ5wXm5+OEHaqU6DsvVbfT7RxJWJYCbKsU6Ju0sIqq65vjWnn5J1qnYln6sWJt7dWrrq1a1c3tuUEtNwCD5GY4JYrKsfNRsKvj9CDevPQELdFuAhmpxoEkV/lHpOAkRZnEZ66Yn7aFwl9KGji8Bjuzio6/ZVIH2zzllrcLvI406SzbjtGEpxLJs4gX9y6x8vU7ETepAb5CRdfH5hCL15Te7UTrZzflldzqnMieoyUng1Vn7rDkkxAE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199015)(316002)(54906003)(83380400001)(38350700002)(8936002)(41300700001)(921005)(7416002)(86362001)(5660300002)(2906002)(4326008)(8676002)(66476007)(66556008)(66946007)(38100700002)(6506007)(6486002)(52116002)(478600001)(6666004)(186003)(1076003)(2616005)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oS4KTllouKrZ+8HmZoFP4FM00IHOhb4QA2+SyZoeJ1fWf0BOh7WosQvtRPi1?=
 =?us-ascii?Q?jjJW7pbeuvEVuXq+t9kbeKCAV3uoUs4oL9qnrl5qPajcreQlTAompd2yS3O/?=
 =?us-ascii?Q?MdF8YU8yCIkmIGtGkdIW3pczprZUwMQgaqmV9GQPR/DQnE6SJ69iE+FDOfV7?=
 =?us-ascii?Q?zggcwCtUTv71FBAbCLVDzJyd2aAnnboXMTeSQT2ULlnayFUFL7n0OCSoKpkx?=
 =?us-ascii?Q?Q9+IJOmUbuoueSwKsqqAcVUvkBj0uXZ4Vd1QoXh6eH6yy1mu4gEHbY2UI3Qz?=
 =?us-ascii?Q?0fZ1Qqropc5x8plcVRKbR3I6or+R8Yfuip/ptlAMJWNnC5CmmOaJpKnPaRBV?=
 =?us-ascii?Q?U68/Q1wpxmfcjozuhgsXPXbiZDjA/LvFCiQ8yUG7i6ulZ7MqruM1ADhvAc4W?=
 =?us-ascii?Q?D+xUS++NIjzSs5el+jjX0sMX8Aia2tLxU5MPGmK6focq3fo4W9S9gojFcJPW?=
 =?us-ascii?Q?45troqT+/x2N7uN0Dg7JIdKGD7152vhXY2oYipTds2sDOEc6xfH8TfVH35h0?=
 =?us-ascii?Q?8agfRpZeGZwL6rJGeWafys6Ci8noBVTv5qiXMUkgUb+4WJpxAcAXqgYsjn5k?=
 =?us-ascii?Q?gNouYDLz7Keha0K7C85at4yPv2ruNpi0Lpt1ac6hZvkU6Fzeyj2qmE1hU2ym?=
 =?us-ascii?Q?JGhz8pWoAhnh4eErDnTxdXsZMpejLDKY0113I/M0xr3nvdusMs/tnGqEfE/e?=
 =?us-ascii?Q?Daled/gpJPpTUKLXj4lzy+eYZtDcBePSlfZgszMb/TR5W5DJzH9PFwM8/4sk?=
 =?us-ascii?Q?EaXJezTDTHb5+tb73EGXODpscz0wBlXKSknjTMRfj5W8ik/riLNSX0FDjRR+?=
 =?us-ascii?Q?akatJ6SE4o2ufey4OAOx39Fp6BwvaMQqp3NzqBksSRIs6kuyD0IYm7hMvyMX?=
 =?us-ascii?Q?y96hokAX5FlIHOCmudf+Dt2TMl2iusy7p3NNgkAoXr17lidPocC3fWve5O3Y?=
 =?us-ascii?Q?2loGal2SDgBPkKADEk3/IrMxvfXT+YLMHl4xsvkjD2Gyd6Mut7/+Y9ZeF9Q+?=
 =?us-ascii?Q?5CK1ellRQxB40b7tPg8hWqulYfpE63T9Gr30ws84XQV2xIBGbOzKGBusa91V?=
 =?us-ascii?Q?t8WCYb133NMFMEWEoIsUWWbMuLrE15I2APWhlIEnBSZgyzh+8FqWdIb0eeVg?=
 =?us-ascii?Q?M4ZGy1eHuZr2ZmVcEeLhYSgUSfDLy7LgcMfJ4ueSqC3Vu4sy6iyW8OcJHx9r?=
 =?us-ascii?Q?xk0aERO8jXdHwoQe8XCadvQaIQfFFLJVJMUQ+pO/7/4gjKbWSRuOlbMlRk34?=
 =?us-ascii?Q?BqI6wogNeVWAcfdgsaN6WLxx9hYg9Yn5H8rDtKgQ+T5/PGUmE8pEc4Wb48Db?=
 =?us-ascii?Q?a3ZjdIfYc2LEmsAtWqeY8JTdPrZLweqBuYJiSFoCQFIlJUCFy+sjuOAERYDV?=
 =?us-ascii?Q?lxifSp+uT4FNoSB1/vGVgWYSsXW6W0qYqhpk4kKqcqyf9ZU4nqKFOmFRqJFL?=
 =?us-ascii?Q?HuhKB8ExN0AoXXMWy48kHgXUFYeu/MIwhn+LVvQN6CNcVhiFwf+cpJ2foA51?=
 =?us-ascii?Q?HcwOouBfz64mOUnFaNf7SyDl6beiOWYl2wtu5PVFs+GNQ5GWWaOUCKPSsJxP?=
 =?us-ascii?Q?ExKQZ58CWuN3IbCWpHhZffZodnqDuyJpmweJlyyh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e0ce20-6616-4c79-cde2-08dab8037ea6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 10:10:38.1569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jy3yKLipYm0hrCWReIzj6qusuU0wyfsioh04eg9WQq8oLFNi9pDK1qgkUPkZG61xiXwwBjNpq2+44bnT4t4qMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6871
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The anatop base is not unmapped during error handling path, fix it.

Fixes: 24defbe194b6 ("clk: imx: add i.MX93 clk")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx93.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index 99cff1fd108b..9ef3fcbdd951 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -258,7 +258,7 @@ static int imx93_clocks_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	const struct imx93_clk_root *root;
 	const struct imx93_clk_ccgr *ccgr;
-	void __iomem *base = NULL;
+	void __iomem *base, *anatop_base;
 	int i, ret;
 
 	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
@@ -285,20 +285,22 @@ static int imx93_clocks_probe(struct platform_device *pdev)
 								    "sys_pll_pfd2", 1, 2);
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx93-anatop");
-	base = of_iomap(np, 0);
+	anatop_base = of_iomap(np, 0);
 	of_node_put(np);
-	if (WARN_ON(!base))
+	if (WARN_ON(!anatop_base))
 		return -ENOMEM;
 
-	clks[IMX93_CLK_AUDIO_PLL] = imx_clk_fracn_gppll("audio_pll", "osc_24m", base + 0x1200,
+	clks[IMX93_CLK_AUDIO_PLL] = imx_clk_fracn_gppll("audio_pll", "osc_24m", anatop_base + 0x1200,
 							&imx_fracn_gppll);
-	clks[IMX93_CLK_VIDEO_PLL] = imx_clk_fracn_gppll("video_pll", "osc_24m", base + 0x1400,
+	clks[IMX93_CLK_VIDEO_PLL] = imx_clk_fracn_gppll("video_pll", "osc_24m", anatop_base + 0x1400,
 							&imx_fracn_gppll);
 
 	np = dev->of_node;
 	base = devm_platform_ioremap_resource(pdev, 0);
-	if (WARN_ON(IS_ERR(base)))
+	if (WARN_ON(IS_ERR(base))) {
+		iounmap(anatop_base);
 		return PTR_ERR(base);
+	}
 
 	for (i = 0; i < ARRAY_SIZE(root_array); i++) {
 		root = &root_array[i];
@@ -327,6 +329,7 @@ static int imx93_clocks_probe(struct platform_device *pdev)
 
 unregister_hws:
 	imx_unregister_hw_clocks(clks, IMX93_CLK_END);
+	iounmap(anatop_base);
 
 	return ret;
 }
-- 
2.37.1

