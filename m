Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC176D1843
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjCaHPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjCaHPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:15:01 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2085.outbound.protection.outlook.com [40.107.247.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCE1F754;
        Fri, 31 Mar 2023 00:14:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfA6IqdlV4obgK8wvs54F6Ah6MeGyivnp+9lLhBgT0SydboTkhavBvtJ6IrxWphoqluy+hH+2LZuPqYRN3Xg9TM4QIP4J+xa0iVkRzeAW6RiMe5KMXO5XeUjXZ3pZsoGdd9KIOdHHMFOUMAVmVlMTrlbLkm33ck79mhQiJFJkbRg5JGDvbKZt8c/HAckpP7cCmuBChpta2q6RXRpVoDAw80DapiFahBDVlZwBmru3odAmom25MDbZr8j2+EQzXF0t0hu4lUGiv90tGjzXJqsxA2nH2dNzpO8z71h2aJIHsKeqd9zVKfjUxUn6Ydrd3Rjl880W45Sqq8epbnjJQQZIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgYNHx8gfwAW1T3KjEyWRBhshB2kPrkWmf8HRgU4OT0=;
 b=meTjAjnY0gJNR/QhaURcKIB911i6627eFANWMphzbsS/5wkXzS/f2DOcnkHzAVPWeLQngzoMOK7QrW8+E3COv3cofNwdSPolp5oNEw4li0tYP8TU7K79YJEwV3ZFmzIuJcJxOeuRwuuQK+FlPdMeA6Fmv/2iOx682Bs+qkYg5RAey2RZmdT2uKah+AjHhTHxQtGMZefFvTvol+fMM6D2+xdYVggRIBXA5IlQRQ0SbROgfM9PaHuuBaX6dpb/8ePCyFe59halOnqJkhZX88iQztE0c237tcRypDg8ptG7naa8ogYElBuI/TeUNLErzkwwBlFcE3mvyNyv2NYwRzayGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgYNHx8gfwAW1T3KjEyWRBhshB2kPrkWmf8HRgU4OT0=;
 b=GWaRrq/zFv3Fpz+NG9OrQEHqx3h1ie8MtghPKaVMKAJG3xOva6kFLtopVLN/JnX+sI5rNZpc/sJAQNPr0mmnSPVDB2veQ3rgFRgG+fyM61s942Zuat0cqEDArqkt2JH6owfTXcby7GfX3T4/sRBYGXSntWaJ6SZ1lIpMzyiay70=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by GVXPR04MB9879.eurprd04.prod.outlook.com (2603:10a6:150:11c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Fri, 31 Mar
 2023 07:14:56 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Fri, 31 Mar 2023
 07:14:56 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liu Ying <victor.liu@nxp.com>, Sandor Yu <Sandor.yu@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/3] clk: imx: imx8mp: Add LDB root clock
Date:   Fri, 31 Mar 2023 15:18:00 +0800
Message-Id: <20230331071801.2483686-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230331071801.2483686-1-peng.fan@oss.nxp.com>
References: <20230331071801.2483686-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|GVXPR04MB9879:EE_
X-MS-Office365-Filtering-Correlation-Id: aa753587-d813-4a33-8f1a-08db31b7a17b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GvQJ5mf5hwsVT2d6ilmJJcaREC3OxYyWeIMF5cdVO54zrGsQqD2nG/oBWRCePRYnii8iFHdBQ6TN2MRQFzDfZ+R3qzFGlohzdA45uG0CSRA44FWICIyEM0kfTi/ZzWdnH7WS/YOC04ug/RDNbUSOYA9cixtRPtAhYJt+7i1d3oeivDETzTsdoU8pDl4fqhec2YtbyjJ+LRvYbY5nmrbGCI+OSSKYUAxa1RoF1WZqsQCbOQ6BFrw243FGJ6AX/+fQm7i+RjBz0qo5NDTNK7KZu3liZ6ZU2OF0sAs9KrmL3WAuCuxwQDonuNhPwgfNWdeFDqv+domuucMHNtfemv0L8iqVZE8Jrfs/Ik+n+ZGIgJ4ie/Vou77JRfFvqapyGnZMx05u4Ts0Yr6p1H7QkroaddUKrFEEOz/4ETQECWT/X7pze5UZVwxy5vq2Oqf7rgxYEN5CPlJTnj3LsZjhivRfnlTXYpJcthytRBk6H1zoWY6Wxspywp3OkGGJIk5MuHGlSWTpzh8datyOFQchsr+YYc2DS3oVK56w+KByje7sEkM5BWlMpKGqkuVeIIEYdaLid3xsmH+zMc11HmKTEL8o222XnxC/LJszgAZh3JbQ54v8o6o8FHLLXFg67YV91GyeV0mpWC4G2IIy4JhR6L3dfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199021)(66476007)(4326008)(66946007)(66556008)(7416002)(5660300002)(38100700002)(38350700002)(316002)(186003)(41300700001)(54906003)(8936002)(6506007)(2616005)(83380400001)(6512007)(6666004)(52116002)(478600001)(1076003)(8676002)(6486002)(86362001)(2906002)(26005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z9f3hSqGBPbAuZQ9a1c3tbYU8zjpD79ZvCeXO7/WRpzvB4ZMig+17+iZFXsR?=
 =?us-ascii?Q?pV73HjjbeJeqLTCS7gN8P5/NGoIrw7qCSzLGpOJSUaPW4DGZxPUxoDsLCs6L?=
 =?us-ascii?Q?o1PWI7bmtAQPz/4Nq1/fMfXkt5c0AF46XEmLSF0h2nP9A9TkqPN/t/27Mg7c?=
 =?us-ascii?Q?RLS0DnKM2HhGbsBRCW2x/RhVGzVyE8cQBCgU5HSS0TKNHiHPl5ZzVnAqYQ3s?=
 =?us-ascii?Q?KHI3jToAS+i02JwWtInhQoZLZPL+//roswyeaq6cDDQpS+hpBSwvzXo4zvBy?=
 =?us-ascii?Q?moc7NMBHifazk+4OLO7p/TFT0lqsPUqeX2o9rmpMuSLMIIjHuwxATiY4+mED?=
 =?us-ascii?Q?/iohpu+02z7aElRxKYlLGt94WM4Iq+T6omkR1yc5EUm9seC5OucKNxyNO463?=
 =?us-ascii?Q?VYM0sq0i9DC4oJT3OO4y1ko9qg69hs3Hmi3ZQIpzFptNcKAXXGHAcgIdzQ4g?=
 =?us-ascii?Q?C0gA+wuywoD4dLYpHy960wFILoyTL2QvmvPHvUcmtMxbC61m850a6miDhF9F?=
 =?us-ascii?Q?6JCUJmuE4VYLqA7KE/tGQkzOmaIZ0l8idV/rmOIFatxBA1kDWzDMTfaq4/hX?=
 =?us-ascii?Q?mzyW2cc4g9tUVcOXEyS2LH0NaQERzXSmhGgc99T65SdYFBNba1t3P/y02o/a?=
 =?us-ascii?Q?u8PKFIPDm+Ng6mq9MCJmr27cTsssBzfiqdXK1MjrUiKEcbSdqVzioju2MLRK?=
 =?us-ascii?Q?K1SFOvDPVMvRKVIQMztJw681CBXJxLNg+Td0YN1yR95o1Lat1445e/NCLGvo?=
 =?us-ascii?Q?AGgRgWhrXfFOix10Mk0oOro1in31rf0mC/lO8qacH44AyZAglhr9t6JmBa7K?=
 =?us-ascii?Q?sjS2MSE6SX3LdAkwnSHn5uG7NTzz4yNMJSzZrN2jPxmbyYtsLbFte5FjXfPt?=
 =?us-ascii?Q?/FQrZasKbdz2MKYBbtNAG1d6SBNtYgSYe6M7Qe9s9iNM5tnS+7zwLcEqISp4?=
 =?us-ascii?Q?NwUUrS2/tb4Ku62tG9pTTbOxDp2EvVyBzY2meaGrExndjoffbwiGeY4OQBky?=
 =?us-ascii?Q?XuAjZxN6k8la3UXYDSV6Vo0mnFR7/aGq4yEZA697y4/JUr1/CS7XNNUeIkUN?=
 =?us-ascii?Q?TQkFKcRczFUV3dPbAvPLrKd8iOoY0RNV4w9B4T7kqyUW7AX0BJ8E69leLDvF?=
 =?us-ascii?Q?mrNYztaIniAUGnWP/gdKlgpJq8uRJRUg8m/Zp3yyfUbGMfdcMAYHaC/UL2A9?=
 =?us-ascii?Q?qs/pxjGiL49Aoliy6MCg2NnyVIVCabnfc+yOoKdIm7s7r832DGKRDLWpgshC?=
 =?us-ascii?Q?XucX24R5ReNbBRylBPz1cVimybjP36v9hjgp/HFFVojxG8JwfYLrMNFBNNPX?=
 =?us-ascii?Q?8tVGOy+G500i8euQHLbav3s0T/1LAVm/nfE/lDxUXD8dMHQtcanys6/ea5JG?=
 =?us-ascii?Q?Xqa3CmWnwgpHvv+QxcjsEl1t1biRiyyX9WmfCt+hrpGCGDosZY7SscS/+BLZ?=
 =?us-ascii?Q?lzKzs8fu8KBKpTA5D+ktsF/2BjZNCJ7kk9CgjBjvQotYO3Xgl/qKNMieCcNk?=
 =?us-ascii?Q?9/Ci1p5KegE4nMKmNSrJiu8P/GGFbD18s1acdlKZYxdTOfeSbctZd2DlGoaU?=
 =?us-ascii?Q?xMH0hBfVe4QlHsfftMROzBHD2PeoJopizDogLM2K?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa753587-d813-4a33-8f1a-08db31b7a17b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 07:14:56.3974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQeL490Dvm1Kopkdsn8xZbLLXFPPYTIkrqIDY9OXsXaigSRLd174hsIC9lvvyMoH1CtL5hCtLKyt0T0nTZ2mxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9879
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Ying <victor.liu@nxp.com>

This patch adds "media_ldb_root_clk" clock for
the LDB in the MEDIAMIX subsystem.

Reviewed-by: Sandor Yu <Sandor.yu@nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mp.c             | 1 +
 include/dt-bindings/clock/imx8mp-clock.h | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 4a0f1b739fd4..8dcaeb213277 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -696,6 +696,7 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MP_CLK_MEDIA_DISP1_PIX_ROOT] = imx_clk_hw_gate2_shared2("media_disp1_pix_root_clk", "media_disp1_pix", ccm_base + 0x45d0, 0, &share_count_media);
 	hws[IMX8MP_CLK_MEDIA_DISP2_PIX_ROOT] = imx_clk_hw_gate2_shared2("media_disp2_pix_root_clk", "media_disp2_pix", ccm_base + 0x45d0, 0, &share_count_media);
 	hws[IMX8MP_CLK_MEDIA_MIPI_PHY1_REF_ROOT] = imx_clk_hw_gate2_shared2("media_mipi_phy1_ref_root", "media_mipi_phy1_ref", ccm_base + 0x45d0, 0, &share_count_media);
+	hws[IMX8MP_CLK_MEDIA_LDB_ROOT] = imx_clk_hw_gate2_shared2("media_ldb_root_clk", "media_ldb", ccm_base + 0x45d0, 0, &share_count_media);
 	hws[IMX8MP_CLK_MEDIA_ISP_ROOT] = imx_clk_hw_gate2_shared2("media_isp_root_clk", "media_isp", ccm_base + 0x45d0, 0, &share_count_media);
 
 	hws[IMX8MP_CLK_USDHC3_ROOT] = imx_clk_hw_gate4("usdhc3_root_clk", "usdhc3", ccm_base + 0x45e0, 0);
diff --git a/include/dt-bindings/clock/imx8mp-clock.h b/include/dt-bindings/clock/imx8mp-clock.h
index ede1f65a3147..3f28ce685f41 100644
--- a/include/dt-bindings/clock/imx8mp-clock.h
+++ b/include/dt-bindings/clock/imx8mp-clock.h
@@ -334,8 +334,8 @@
 #define IMX8MP_CLK_SAI6_ROOT			326
 #define IMX8MP_CLK_SAI7_ROOT			327
 #define IMX8MP_CLK_PDM_ROOT			328
-
-#define IMX8MP_CLK_END				329
+#define IMX8MP_CLK_MEDIA_LDB_ROOT		329
+#define IMX8MP_CLK_END				330
 
 #define IMX8MP_CLK_AUDIOMIX_SAI1_IPG		0
 #define IMX8MP_CLK_AUDIOMIX_SAI1_MCLK1		1
-- 
2.37.1

