Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E98610DC4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiJ1JxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiJ1JwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:52:21 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2071.outbound.protection.outlook.com [40.107.104.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEA7DB546;
        Fri, 28 Oct 2022 02:50:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fj9umIzwpBHtOFP9KEYQoEFJm7YgshCC8UPuRSo9L0k+XBoBRRtNywSAWlIepdOoJ1ok6VQIJSeESg9uivjbUtQSlvck+nbD03LDssG/XnuPcliRsLmvUk7lBL0iLiRXSOCXNB5XWd8wPvMeZ6LERUIx67xexoR+nXrohYph2Euv9TMKzrXBa3G/2eRPGel5JUSrdv9y0GVunV9W73stFue8IUvFnHdZvaRWOjfYXqJkSLfSH3WiUIzA+RIlUd3L0bBebRYrscWJIVS7xccfoB/e8V6HsnbpnKXJbrhA09KHvdcDb8z4hOQ0tUm74NchOKCjGKmxnAuYcSv+pld6Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCK4+CAft4YD+4vtWrpNNJ50gAt2GZlH8Q7y4AflR0s=;
 b=Nanuh1zZP/F/Zpm2Hsv4JNC1f0TrN8cqOJioKnMu5mzbA9EM75pE6wDAXibrtgPt0mWZ1MiYNtW1TCPHJ1QKf325UVq0UgjWVV7OwqzxRrVp4ZzOBr66exlek2kCL23VxlTzvY0FxRY0VdGohVKSWKYVDmOUQnHuEI/XPDVvSPr5eEZNaHA8WmNEvDzcKoFR4KpJaZ41re+U9vMtgBONCEKC/9VmfLdqDwkQSP/6nI+U4OG9H/ZZolQVbdi/qFU9tWWq5Nt7J1HsbYCzf1i4US6u/S160jFnFvNNi52+cxdZh6oP4e3zgGutzq0sNj6hzsDrAuJH1mCkxV/BiLv9EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCK4+CAft4YD+4vtWrpNNJ50gAt2GZlH8Q7y4AflR0s=;
 b=V2CwWqrhfgskByAXfH2Ek0GqA9dm39vznviod0E6cGhKtjSBAupv85tuJoO9KA2qyfnRzOj98vkX8t59vsXs5Otc9Byaw7b8AYSfgEow7zdbtMArZS9axNJyEtHUMlRprmKhkBvugejWbJPyyFYY1VXiuwcDrKtNKKOyNIZTb3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8853.eurprd04.prod.outlook.com (2603:10a6:10:2e0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Fri, 28 Oct
 2022 09:50:54 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18%5]) with mapi id 15.20.5746.028; Fri, 28 Oct 2022
 09:50:53 +0000
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
Date:   Fri, 28 Oct 2022 17:52:06 +0800
Message-Id: <20221028095211.2598312-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221028095211.2598312-1-peng.fan@oss.nxp.com>
References: <20221028095211.2598312-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b2d0535-d001-4b5a-1477-08dab8c9e73c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xrRnHSo3YZCLnvKzyYTiCNwKcZkl6eh+46O5Em+V7E67GcF/nCW4wN4BQh/aJINDCz3/4iiLONpkAY7z0Dk1NvLWHLh7W6NXqkBP1OI775ZGZdwNWFD5zkkqzG8+rE6b1OCaPiP6L4LRmE40joHYvd8xeIckei5YJKd1M3mVK9uNaLuBrR+zlaIeLnAt5JJT/9X2f2yKJH4LJv5pmcZKUmVKN7GKtcyr3m3oA6KtX+dnG8JeXaWHJsOyChrbHmkLmrprpfqaeVVK/UlCQLP40jOUgHHKcv6mYNjOkQD/uH2Nv70pUv8g50SYNVh3lima4NqMTPJiDEok5QbD8EZxj16hJRAoF17sR+LjAX8t6HlZriXllTyXD8skxCgDhez9jCaHpBopkdg7vqcdM4nOhxAEudURWjz5nhZ9MtdHcVMMjtMPQrq7dbViJrxnilb/rFJ2WgRfwheidsMK+UzMEgwEPmOtX3xA4hxIRgco4GbLRXPe9H87zHIfah2RsoVO7HyWRpa55xmIwydmdOU+totbqNJOfxQanxsmCaazR82XSloc/eIB9R7nR8bDfZynXagGsoWEAxs9dBU5K9xQXK52G8pjAaO5FGAs1z3ds9APOfK7wrdf2dYpvMH1SVBEhq3Zq2IMch+4AuEnbuH1IVx9XPtLVa9eIIQsHX6Oc6PviqumzZoijr56YF+vrHFTZTflSvEi1BsZnbnE9EYHPjj1I4GUOvSS7K3USnRYCCIIHG3Eg+j94xKBSsnkxjbFbsULZhpgSvdVK5+6SC9Ud61cfKuqfYHFwI42v7Y+BnU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199015)(478600001)(38100700002)(38350700002)(6486002)(921005)(54906003)(1076003)(316002)(6666004)(4326008)(8936002)(186003)(52116002)(6506007)(26005)(83380400001)(41300700001)(86362001)(66946007)(2906002)(6512007)(8676002)(66476007)(66556008)(2616005)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GSmeVoz7m9DDkPuXii8hNuPIb+dNfQtLKU6WrTOjnmB9XtjXqwUULWHoFJzv?=
 =?us-ascii?Q?zT8vzwunPioeBTx9CaGjFowYdtou6DTYGU462iWMI+XvsJQOGzrKuth2HR3f?=
 =?us-ascii?Q?BtiOaDNbJvtDFm+vdbVHlqyoltPKzpUon7/ye/4S4U7kMdVpPHCSTBZgLkAn?=
 =?us-ascii?Q?/Q79qYSySf13V2a0TS8QlvmtFggfUgVbJJv5inU//OQ6fGnUg5IHSOitLPIY?=
 =?us-ascii?Q?gbmd4lYh1Kyl5xmOCc3Aqf3/puIcOsj6jjY8FpHXT8efmJ+hyvL8QrVPrmrd?=
 =?us-ascii?Q?ScJawXKg6s5xWy82Bjf+xGzsfLzpAmBe7CzujfgndqeZ+ZrZ7KZFCzzobheo?=
 =?us-ascii?Q?FL5RtJ+DmcQGR820B6S16jyFzi0kYfqy/xdjd/2xhtDgkrkWaKz5770Qgmsk?=
 =?us-ascii?Q?bW3jvtDXRwQPay/8KrksqY60Qg/XZbvHH7yFfq67AourIIch5z2784yEItFh?=
 =?us-ascii?Q?GaIckMAw1apCweBblmbFKxdotGZl0gMb3xb4u9XbKfmsy10CD1hFP6XZ6kjV?=
 =?us-ascii?Q?PkJuFpje2VgZgjz/zt7R0c8rGqj8jIardOYaErCIXPGr/SWRiCGgBymrF4IB?=
 =?us-ascii?Q?gelpag206vsGoCfl45Wsc0WWuqmMxjY9GNEBF5FvCBnH0Dif+uwSMxExoRXu?=
 =?us-ascii?Q?8VhK7AOoev+4v6/TrhlMS9cVIEN7IuJ4+uyI6jriev08tVOdjEaXtJrlO7a2?=
 =?us-ascii?Q?jbAWuS/SVJ6HHoJVN3JzkCcA4xeY6A/fZTXtAIIpdjLuosMfedGuvOpRHNAv?=
 =?us-ascii?Q?D86WY0+taenNIFrotQnBs3ljOUSQo+7oFsMNLuu7PxjZ0x0sF36EEJ5fCzoh?=
 =?us-ascii?Q?cvtjvy1C1TqnuD0DG8M1HEprVO4fv0Uz+31eRr/lHM1ddRWRXyqve6PVxrVy?=
 =?us-ascii?Q?xZbTsk727GIsgulci85VZWY8+IcUpwoL7lkG67HqzSVokI0gJeT2EztafHsc?=
 =?us-ascii?Q?O/rpxif3ogqrpI/NzihCunVSRXnG8T4X5yVc6wz1lyfUT1MAUmEJ1BrLodkM?=
 =?us-ascii?Q?qEzH8NByJ84CvYzD9QB4Cm2uaUsv46C5I3QyTjl0V5ehc0YjaOTpPD0qSEy/?=
 =?us-ascii?Q?G/F/pQCTG8Ori6+H3lAWF+cS1lbqNvWqerMvjt2lXcXft6eGojwEwa8FuLGW?=
 =?us-ascii?Q?8n0QyRdU1RLbhMj3i/Vzac5VsH4LhsITR6M3qMe1rKCo1FNnCFkCMA9btl16?=
 =?us-ascii?Q?1UymF4NxH3kF0ys2x/HtULqwwDo5e5KBzNQbdKJja/dCJqwvhkj/CnopX38N?=
 =?us-ascii?Q?GJ7+xFkoP6ZwGpvbVtvT4FPusb1VFnLp4LJ+TLUNBpTlexX7njj4K9LsnuJG?=
 =?us-ascii?Q?9k5iPooJxQ79FEOQBBPKWI0YKtTpMUwaNviQ4GOP8CgjVqWr1EEKrsclEpym?=
 =?us-ascii?Q?+LtRIuVo8ZBqeJEfci+pTk/Qw8MdCIIblHXeTxYmdvIakuZfSN49OZu9Tk2y?=
 =?us-ascii?Q?EFwv7Ij2vqZ/zMghq8dmV52dOR32RRtvMvf14zyohdmlrku7+Tto8xD12RgM?=
 =?us-ascii?Q?G2qz0nwu5rTnWT81S3PavCQXzfg0QdP0QtbsttZeZ3lrtpJwEm6a6IUyhovp?=
 =?us-ascii?Q?uf4dbzdqFA7adqOIF7YrunkDW4z4oqYEQOq/v2SL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b2d0535-d001-4b5a-1477-08dab8c9e73c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 09:50:53.6570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPuAVRKBRG56i/n2lP1aP1gDaGzyX2w62Bdlry+Ha1KX0UJkdZAXbxhx5kU3hRnkeE2bO47xVztjOZ0HDuH3cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8853
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
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

