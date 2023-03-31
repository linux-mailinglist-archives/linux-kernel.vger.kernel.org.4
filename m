Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CD36D177C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 08:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjCaGdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 02:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjCaGds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 02:33:48 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2058.outbound.protection.outlook.com [40.107.8.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125E2191ED;
        Thu, 30 Mar 2023 23:33:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=at6QYGqrf3+06h6UIwS24VVJ73AUxUT1zJq0vCXCwj+YT7g/x9dxL0kIsE/P92iA2pNotV71vho8rXaejq+LAzDeSai+FoiEAh+4n9lFjQ02QQ55fPZ3eFq0nLqy+tSSEaALwJpDQUVvNvK+jy6sIm87WjG1YUN4RdGgWqmnivc6y9JkjV/vOMnPOlGwwErNH/xYK8DUHAyB4vTT9VkZi6KFukH74pfkLeBUDSh+mXx/HGZZrnYI4Pi2WJjpxrPqP9qn4vJ5oXAc8nhizmVXgQOtcPGMtzSTlrhJsfmvRt4j+6RHQraeeck9k1GAvXS2AHI/UeRrXw7a1DvIWEP9HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCAlVrf7WPXxM4Ec216kAXvFV8loseSRMwzFKq9O5OM=;
 b=BkwEizVJolug3Jd81OFN17fIAazBZpSdoOeMG9PWFTSw1b0SykEy0eddes+bn5Bg0DeunJ/BDxL97hZfTjUQOuZScDX7uMM61EvSNKbNRMcxXsQhmX1qgaFcZ2sORrzVf6lj5XN/0Fd1ZR8KunG3HuMbYInNWcdVf+P47ULXP5VgFOQNadycMxYa9pYyz/Crg0Olbwk7go3tMn/u4OeHiG7ortgl4MF/kcXT6XC8DRDFAan+2zFtuDcdDCC0+XRzBtwDyYwGWHEz9a8EKc/OxihkK0/eqvfUluPgjPu+nLNqJibPZhHPcuRUKGtPDijJdiLawvebylA8NrqEdfkC5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCAlVrf7WPXxM4Ec216kAXvFV8loseSRMwzFKq9O5OM=;
 b=knQG5LqMY/Ggq4OEXWxFGKWJrvC0HkKw/z7r6XuXnZh7/vASuLcfkblvZYp1JGXlFS9hGQCz2SrUhDdDJZFEZ1YFnFyVG9bfZ8E7eWJC0NZj96G99t1NNCR6A3JKCLd8bUdfa603DV+ndthpnFrZEC15JU2DzzX/E6mlq7Xw1XY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7356.eurprd04.prod.outlook.com (2603:10a6:102:8d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.21; Fri, 31 Mar
 2023 06:33:37 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Fri, 31 Mar 2023
 06:33:37 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/5] clk: imx: imx8ulp: Add divider closest support to get more accurate clock rate
Date:   Fri, 31 Mar 2023 14:38:11 +0800
Message-Id: <20230331063814.2462059-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230331063814.2462059-1-peng.fan@oss.nxp.com>
References: <20230331063814.2462059-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0030.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::17)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PR3PR04MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: aa69b31c-d622-4d32-486d-08db31b1dbde
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: slm04YQXoxr+gjzit94xe5gn3aja30p5+VHYNXwixD72/GHyMLpMXuQ74VX6wAegWuUrgXN+USgAKkX/e9AsVg/YqsXkq3OiRmg/4EW2l0Ao4M01Vo+6QEZlU4kwxW8P/jkfBX1kPuFUdzSR+3FZVWvsHzf4xMOjiSAZXgYDvL1y6WvuK3nhoEJvpegnmpzXrPgdcFLaiLlTfKGw5QJ9SJaKhrbzCh55zVuuqTalQ6tlNBmnR9Q0obOfegn/LOxzRBWlCdBN1zNBJvgsQyXB59W9R9znxt28+HuYvSZ2JSSsMfr4tpFQWY33of3sw9wlmMXqA/GBg++rSrqgx503VgCWTiCHhhijXoUqNNwB+v2PIoSP7D61Sv+OWO0woMHaGh4c8HUvFiDGRcMRHZqmm9mHdzDPDEQ5RTjt3Dxl1JlXkwAcnYIvPGu8GdK2t6KOup/96KyN/maw7qTIcBz71IY16vjtcjCjZz3XA+sVvIyk7h4WzANaGgfWIvJ09m4hia2ieuqCPuCb8imRpALCxzztWku3QotKN3ja7z+Gxqge7z/JCiW2oZ835uv7Ic9EcHa3v9yKAbUe3qGYb9snQbX3d8O8vwt1OwND/tq/Ld8IRoOKW9C6X8FQlz5N6GdNYlH7zX3TuPXmaMe6p5q8fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199021)(38100700002)(5660300002)(8936002)(7416002)(66946007)(41300700001)(38350700002)(4326008)(8676002)(66476007)(66556008)(6486002)(83380400001)(2616005)(54906003)(6512007)(26005)(1076003)(186003)(6666004)(86362001)(6506007)(2906002)(52116002)(478600001)(316002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LODTunL2bRxGj8K1jiLlbf2NA4uDzWVuwn3Qo4zZDiPH7SN5MMuW1IW07HKX?=
 =?us-ascii?Q?78ghJ/J+CtltWJwmt1vJhcf0f2kbcoMlqd+n6JZCedLgp6FcBe0RBfzc7NDc?=
 =?us-ascii?Q?0A288YQP5V+lIpvRVuWuSaG87kiT+UYDWzl7ebVf9OWA74MvUejDiW0UbF62?=
 =?us-ascii?Q?7ucnBFc9qEYbl8Rc+f4j/qB9eVCR4KcYK/6xj4lRumT+21DBzrSvQ4JUBCvv?=
 =?us-ascii?Q?03sXBr+eGPUaRg5AqNfbX0t60ICpK2cGVB8ndT3cqmJaPKyss3AAlSpuFyPX?=
 =?us-ascii?Q?o5pqnz36LjGJXTEtJfLxToC6IY/4JVQn4n1+herQDVDEXuMIT9w+SiihAnDr?=
 =?us-ascii?Q?luz7GKV4gy4H/49pIIioIBvt0qsPjqUnLaUZAHryIp4YtifXgoG/rZ78oOjU?=
 =?us-ascii?Q?e7VOzqacYSlGicwHjdJz6wdG/W5Df/OhK05M3Gfif2V/cfYAmPqeDNAYnBd8?=
 =?us-ascii?Q?AHPizg+vdY8IDvqXM/u7cjMWRzq9fp7LRcDTAjsuaeDGECZ+wZfFeUBBzjcn?=
 =?us-ascii?Q?Pxrmlh81wPOqRBxvrlbKNDOw0ymf7A8zGw0/HnOWOabrh3wj7YHpHmon8trX?=
 =?us-ascii?Q?3cd3HJFSe9bFzx9yeSupwWvv4/6/SRoz4DhDrbP1BtEaBOrZPxqdJJQQtR8c?=
 =?us-ascii?Q?xJq23oyymfoAD1UITP1iiCERD2NZvxW2LYO2bl+o5oJbdqIncmnnMFbTqx+Y?=
 =?us-ascii?Q?7aYt3jJnY0zB2ensewymajs7R2npbRhjqHeYe73VX7R+625+1fDNXdSLLW+7?=
 =?us-ascii?Q?hwxWc5YZgzRqGFwaQs5ru5dEP5e9cPZXBT+lLGr3drHm+lidKNhAkydh4okp?=
 =?us-ascii?Q?susaZmRSMVuKgt1j1oQEABKW7Wy5ZLWDnyqKRGnMTN0NJHtr2Saqro4302/J?=
 =?us-ascii?Q?RUrbBEgBk7Af4DNNINqHEQMm+TL080+y87EM2RYKF+AfT5tpAvxh1X9+NRef?=
 =?us-ascii?Q?OVvFhr2SUzUajHmV7UdVALa8qk8ghYVxsopxEKIvEIM9LyCTKqLBZeA2aLo+?=
 =?us-ascii?Q?cISvH5cUAutm4imIXZksvMK3A9IbzAFf3jlbC2Zq6UdyALPstlgq8QJ//iAO?=
 =?us-ascii?Q?nT4m43B6FdGYmizziYP+aZrKArGnX49CTecru+1Dr7t8rAhM0cV675FFMCGH?=
 =?us-ascii?Q?kD2r9fsY4fWpdiE3xSp7RIN0Wd7Z6JF0xoKkj+slAFfJI7PhO+fcMNsv8HVr?=
 =?us-ascii?Q?cR0F1rHKHbqyk7CsXzqqOWITguLrJPowGK1drrF8YnCIGh9GhAtjBnCZu/YX?=
 =?us-ascii?Q?CEwsJzywJtSBY2oTtsGxCO2m0L6/ADZjVKFIEa5Ea+cfqN5uesiAiFSxt0yX?=
 =?us-ascii?Q?/Hg5IP6HqZrisHDtoM+3bjSpVBilV/+GCW95ERytcvxytmZCYDkwPe07Wa2p?=
 =?us-ascii?Q?WygS98mJp4JrcgmlKHg+w0XV6VUdRp2PjF4eoKskQwBLG9QDObvfNVYXxv0S?=
 =?us-ascii?Q?90GZUPe5OCWoq0kDAw9TzK+6SRYahqFALqS1cXL1fdbKp9lwiNUckivEuJhY?=
 =?us-ascii?Q?3KDBr2cTK4sElPbXImcPgwMGBH1QdCrUhPSub5OsaJj3/gfsbYIJU07tUiAx?=
 =?us-ascii?Q?+6KmRo/S1hfxWFEoYicxsTtOXsfTjNmKL3k8zzx5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa69b31c-d622-4d32-486d-08db31b1dbde
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 06:33:37.4104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pTqe7ll0Uh7cfrj3yU78I02GYfIafA3bVg6d/Ulj5aG4p2eXe4/LeFZBOTJFIdfk3NT8IHdv4hnDqR7mmusoVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7356
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Bai <ping.bai@nxp.com>

If a divider's parent clock has fractional part, it will hard to round out a
more accurate clock rate for this divider, add the 'CLK_DIVIDER_ROUND_CLOSEST' flags
for such divider to get a more accurate clock rate.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8ulp.c | 16 ++++++++--------
 drivers/clk/imx/clk.h         |  9 +++++++++
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8ulp.c b/drivers/clk/imx/clk-imx8ulp.c
index 89121037a8f0..3cf4b094dfff 100644
--- a/drivers/clk/imx/clk-imx8ulp.c
+++ b/drivers/clk/imx/clk-imx8ulp.c
@@ -275,14 +275,14 @@ static int imx8ulp_clk_cgc2_init(struct platform_device *pdev)
 	clks[IMX8ULP_CLK_PLL4_PFD2_DIV2_GATE] = imx_clk_hw_gate_dis("pll4_pfd2_div2_gate", "pll4_pfd2", base + 0x60c, 15);
 	clks[IMX8ULP_CLK_PLL4_PFD3_DIV1_GATE] = imx_clk_hw_gate_dis("pll4_pfd3_div1_gate", "pll4_pfd3", base + 0x60c, 23);
 	clks[IMX8ULP_CLK_PLL4_PFD3_DIV2_GATE] = imx_clk_hw_gate_dis("pll4_pfd3_div2_gate", "pll4_pfd3", base + 0x60c, 31);
-	clks[IMX8ULP_CLK_PLL4_PFD0_DIV1] = imx_clk_hw_divider("pll4_pfd0_div1", "pll4_pfd0_div1_gate", base + 0x608, 0, 6);
-	clks[IMX8ULP_CLK_PLL4_PFD0_DIV2] = imx_clk_hw_divider("pll4_pfd0_div2", "pll4_pfd0_div2_gate", base + 0x608, 8, 6);
-	clks[IMX8ULP_CLK_PLL4_PFD1_DIV1] = imx_clk_hw_divider("pll4_pfd1_div1", "pll4_pfd1_div1_gate", base + 0x608, 16, 6);
-	clks[IMX8ULP_CLK_PLL4_PFD1_DIV2] = imx_clk_hw_divider("pll4_pfd1_div2", "pll4_pfd1_div2_gate", base + 0x608, 24, 6);
-	clks[IMX8ULP_CLK_PLL4_PFD2_DIV1] = imx_clk_hw_divider("pll4_pfd2_div1", "pll4_pfd2_div1_gate", base + 0x60c, 0, 6);
-	clks[IMX8ULP_CLK_PLL4_PFD2_DIV2] = imx_clk_hw_divider("pll4_pfd2_div2", "pll4_pfd2_div2_gate", base + 0x60c, 8, 6);
-	clks[IMX8ULP_CLK_PLL4_PFD3_DIV1] = imx_clk_hw_divider("pll4_pfd3_div1", "pll4_pfd3_div1_gate", base + 0x60c, 16, 6);
-	clks[IMX8ULP_CLK_PLL4_PFD3_DIV2] = imx_clk_hw_divider("pll4_pfd3_div2", "pll4_pfd3_div2_gate", base + 0x60c, 24, 6);
+	clks[IMX8ULP_CLK_PLL4_PFD0_DIV1] = imx_clk_hw_divider_closest("pll4_pfd0_div1", "pll4_pfd0_div1_gate", base + 0x608, 0, 6);
+	clks[IMX8ULP_CLK_PLL4_PFD0_DIV2] = imx_clk_hw_divider_closest("pll4_pfd0_div2", "pll4_pfd0_div2_gate", base + 0x608, 8, 6);
+	clks[IMX8ULP_CLK_PLL4_PFD1_DIV1] = imx_clk_hw_divider_closest("pll4_pfd1_div1", "pll4_pfd1_div1_gate", base + 0x608, 16, 6);
+	clks[IMX8ULP_CLK_PLL4_PFD1_DIV2] = imx_clk_hw_divider_closest("pll4_pfd1_div2", "pll4_pfd1_div2_gate", base + 0x608, 24, 6);
+	clks[IMX8ULP_CLK_PLL4_PFD2_DIV1] = imx_clk_hw_divider_closest("pll4_pfd2_div1", "pll4_pfd2_div1_gate", base + 0x60c, 0, 6);
+	clks[IMX8ULP_CLK_PLL4_PFD2_DIV2] = imx_clk_hw_divider_closest("pll4_pfd2_div2", "pll4_pfd2_div2_gate", base + 0x60c, 8, 6);
+	clks[IMX8ULP_CLK_PLL4_PFD3_DIV1] = imx_clk_hw_divider_closest("pll4_pfd3_div1", "pll4_pfd3_div1_gate", base + 0x60c, 16, 6);
+	clks[IMX8ULP_CLK_PLL4_PFD3_DIV2] = imx_clk_hw_divider_closest("pll4_pfd3_div2", "pll4_pfd3_div2_gate", base + 0x60c, 24, 6);
 
 	clks[IMX8ULP_CLK_CGC2_SOSC_DIV1_GATE] = imx_clk_hw_gate_dis("cgc2_sosc_div1_gate", "sosc", base + 0x108, 7);
 	clks[IMX8ULP_CLK_CGC2_SOSC_DIV2_GATE] = imx_clk_hw_gate_dis("cgc2_sosc_div2_gate", "sosc", base + 0x108, 15);
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index bb105d6e5b39..ca1f75eb3197 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -356,6 +356,15 @@ static inline struct clk_hw *imx_clk_hw_fixed_factor(const char *name,
 			CLK_SET_RATE_PARENT, mult, div);
 }
 
+static inline struct clk_hw *imx_clk_hw_divider_closest(const char *name,
+						const char *parent,
+						void __iomem *reg, u8 shift,
+						u8 width)
+{
+	return clk_hw_register_divider(NULL, name, parent, 0,
+				       reg, shift, width, CLK_DIVIDER_ROUND_CLOSEST, &imx_ccm_lock);
+}
+
 static inline struct clk_hw *__imx_clk_hw_divider(const char *name,
 						   const char *parent,
 						   void __iomem *reg, u8 shift,
-- 
2.37.1

