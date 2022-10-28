Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26296610DC5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiJ1JxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiJ1JwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:52:22 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2052.outbound.protection.outlook.com [40.107.104.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF71173FFC;
        Fri, 28 Oct 2022 02:51:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJtJcWfBZ5AJA83ykNNKWR0f6tBq2gkXcgmGHGBbgi963K8265FArT9tsl8z4AsYG+Skg7n5q/RsJq6/caas1Ro+pupLHwToFlblKeHmhZOyEd/NHKsgDORZs9QdK7kTmm9W0EGj3BGRkNu0K1ZySjzsWBhq5ddCF8XNTO7RLerLVLCYDvDzlO3EmC01HgaKPZCEnx74tiGZqFBMnSE1n0EoGu5/lVGR8rW0fII/D1vbHIIKGF19TRQ+MCmgN0Kq1e3hMBfzWGV8ohrx8k+CV5I41VuXS4dHIRIHkKmIMhsz2eDOX01KL/CbRgsF7mRALGGPN8WIxeWClVC/QRIOQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPeYFNzYxfzSKhDdsuPnk4X+UkX6e60sELc8CFOss3g=;
 b=INCmTVDDPWPe4/27n/NLlex+6INPQa/R+ToVox0AZ10UHT7o72/Tnf5JIcc2Mm9HG/Mh70ZKY+jzciwVc3NLz+IMCAmbOkDTU24+N6cW0/3WZ26B5v/00NAujI5jVzGj1KGOZHf2qTLy8s0Ds/2M60IdYekWjH+bZeouxSR30V6cbqcIuqoNeAjQztw69l3xyna6KnmA2g9/p6Tal3iEm94hTbCNFMGB4LZYN0xvsDlNx1iCaIHjTcL6LVkF6UgVf7zxOC5o+yEbcIFXVC2UYfl+eD3zNyUWlM/8luvu3Wz84szgcyWEnT68hW4ESjjeV4ZqkPFxsi47aYFB2SPU6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPeYFNzYxfzSKhDdsuPnk4X+UkX6e60sELc8CFOss3g=;
 b=GyPMsMFcfpaPlsMMwVM1MdE45tBEHXwxnBfIFMjYY6drI2z9beZWSBFOPUNMTgiJv1242XcF73NesU44g036CjaaQe6KSUsUJJ0y8vIxwvQcKjQSsR5NHDJ1sEMMlAVniFmXfhL/w2Z6gLyzJGM+3AHDta4mwue5DMW+JpsGyAQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7690.eurprd04.prod.outlook.com (2603:10a6:10:200::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 09:50:58 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18%5]) with mapi id 15.20.5746.028; Fri, 28 Oct 2022
 09:50:58 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Ye Li <ye.li@nxp.com>
Subject: [PATCH 2/6] clk: imx93: correct enet clock
Date:   Fri, 28 Oct 2022 17:52:07 +0800
Message-Id: <20221028095211.2598312-3-peng.fan@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 41fd7a23-93db-4541-310d-08dab8c9ea39
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jjFJnJweTFpYhFF70w8KtOGetklsvYTvwE1nyBQUGi8BHaj5/3AD029m7sjZ5ZvZNhR6zId564TXexll2GGH3WrNbrStpmbvmes3FCTomSLDWqZ1go7+OkaXSIKAFe4biRh+Wc6MDIhFVxTQ7GUwjuK9fDCNk4gSNmpsGMW0rjB3etKLGNEpIXlgEdE5ucgUWVoxvIRZB1AjT7Pvrxp0crZfug25fUmEPHS4LeiHjcLlyAJvgfpYVaPFb/Pd9ek5SSPj/fP+IONx6KeaTSn6cHPD9xi3PgooEPhbxKywP2VVrPzYFGwpZfQ/RNjifWUcWWaG0vbxiqZcAKqSnzFodZ4XhONwmYhfx0erQrNwdEyucuOpICw3UPNDfTW0bJhLM83ZVb1wGXY++AV0H0BKLbcihL/h+vuBLj9j7EjkDeU9QGKxAGHm8uwS5Jf7hrGmtBW/BLpRfPuD20azV3j1wXuRDIHF381cZZRTE/8k3PuXosILfDCTzkbAqePXBm7aZ01Cwq8kibSEae1h5A5vmr5vzjePUr1PwUwTW7aCJ03rsWdDPSt5DDSFjYjoX9oga0PSbquFfbemYHLiQyO6c0DQC36qL69aTIaY6TgpOogrUlK6EzfzLiVoNfR6mQ51zukL59oo8VPURaEIxIcwCJ+617BbFOHnVQ3TKlGmvpEqtSv3h8KpWHzq5Y/QR0jbRZIWhfB7bRTZEuAE+49MCnukClsHywHrsox7Ajsx8r/nAy8kN4xZlVLv53Ios7moowhCtQY+dacXi2gJAZKFKZKepo/6UK+z23b/b7Jf4s4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199015)(52116002)(2616005)(6506007)(26005)(6512007)(478600001)(186003)(6666004)(1076003)(83380400001)(8936002)(2906002)(316002)(54906003)(6486002)(7416002)(5660300002)(4326008)(8676002)(66476007)(66556008)(66946007)(41300700001)(86362001)(38100700002)(921005)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HGxNq0w9kodCHinFTggXgA1F+Cva55aorr82nH8MQiMZGyJhd3MxnKpt73Xy?=
 =?us-ascii?Q?96Ao77aFGquCzae/HcjqPGhL2q8+VICIN+UATCJt4tx3Wqia8XiKVhuo+Sw4?=
 =?us-ascii?Q?8N8YahOWNewc38DLnaPxaCEFeZkTjj+QLK0N+x18BHkvhDArn1NPKma32PF2?=
 =?us-ascii?Q?EYoTklZBGGYfbDj+qOvSXUptIoo4efyc1zE4ATvXNzFRDShVECXr/cJ/IieZ?=
 =?us-ascii?Q?if8hFBSAB0VRrOE1ygu9kIPFm6pE73KWnGnkuCqyvZpTjqWsLJMUS09ZTE/e?=
 =?us-ascii?Q?gGjGic+crxDV0z5tcV7EpiB/oae9bmkC9+AgXCZ3jRZeMB38eTMYZc6xUEFD?=
 =?us-ascii?Q?pt202f+37HstEY797XTgLgl4EoGZkx+uO9+97mWb5QQFR7rrBCmeTNBUI//9?=
 =?us-ascii?Q?dUdGWqEYNbk5jgnN5BJ80uLS+G4CoB1Y1lCEWsWZn9ZOigqCZzjTHhw/rN1M?=
 =?us-ascii?Q?q75K5LRyt1oCVXEAAjg858mAWPXDVAvk+PM5wBnxAXwD6eVbMFfihW3Bevzx?=
 =?us-ascii?Q?jMFBH2RtK5uV7//FVgfU4T017wQrfbT0yfRmGpd9YkvEBZrZOHVL/ykMA6tU?=
 =?us-ascii?Q?JPhevjp44mMstysQFxPfXYpAewJM0E8HBTluhfUZj9zYCcpxmw/zSRuG3xDt?=
 =?us-ascii?Q?0u0CJ61KXL0d/v/8/5IMIbzppGXgW+sV/fNUV3+TM40wH3fIEdHgt0aX3HBl?=
 =?us-ascii?Q?l3kTpQBcys0eozREXUtufxTTeU3l8Cna8V+AK5ggXAQXtiDoDmKPT4D8ILXw?=
 =?us-ascii?Q?NsMdYEoF4AtM/8EiaI52b+0XslCb9l3KzM8dGxHwuuDVgB7YyGpuji+F0hjf?=
 =?us-ascii?Q?M4gLUovgf0pN08HaDfRAouL2yhdgSi9Y9SL4zPxlicBxJunRNP/7eRn/sNqN?=
 =?us-ascii?Q?DRP4qZHEgQjTYmtho3jDEYqWPha2ONILLyz0EPH2NcoF/+qhJSRBbidIsg90?=
 =?us-ascii?Q?MCFsu83WJxMDjR8GnuyFafpv125AEAwAkFX8g/UajoPp1WLVHGsyUHIpMGYl?=
 =?us-ascii?Q?F3hzdtWei8IwXyG7OEb/fTyZGUN/RX3uuQyhwDxy3UxgGwqiYJFj2LflXfCK?=
 =?us-ascii?Q?jx/TX4GRKGSS/RxBAPND555bHlT4GaH8ejw7UZbK7RlxYVzCkD/Iu7MWTRRG?=
 =?us-ascii?Q?4q9mDZKZRidaP6oXdVJmz63TWbhrdsIophbUxkQv2PTb+yYghnRax7XrZSdr?=
 =?us-ascii?Q?/NXNNntui0LPxRID5Gc4pMEeL8b7XNcFST9nx4Bx9lSmVZiLj0q27i7dLysT?=
 =?us-ascii?Q?3WUcdPlosMNpDybNnV1KWwFtIm8eBGZBKGiltgOlMsZCzRYG71c+2iA+Mkjg?=
 =?us-ascii?Q?c9hbrpFfhTDW9FNFmUWY56r/mGjEkh5Q+LjI5Bnl//1s/3uYL9sKvWcXMCw2?=
 =?us-ascii?Q?N6h9QbcRhna2vM7wIb5VRbuyFmWYu+Vans60ImzG46Ecu1Vb1xPviNbyuZ7j?=
 =?us-ascii?Q?A6ozwHa1uplvigIUhtGrsX/CsRA9NqZc8YNojqfNWtkhUY2GUwj+osiPehwC?=
 =?us-ascii?Q?L/nsE1wNGfF73SfyO8Ccm0eo1NeqBogLyPssA0mTtVuF+MAP0vEiXAY4s6kT?=
 =?us-ascii?Q?lxo70soGjoTJgvQvDin6YCRidTp0CHCTftNqn4ui?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41fd7a23-93db-4541-310d-08dab8c9ea39
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 09:50:58.7089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7QrPHFkXclYSplUv+GN22lVl3UulaOx6TJo8j5Zyx7H3IcwVermI+c2sBe1vyqzeHzh7K5zjwvCNFdrWgn3ojg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7690
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per update Reference Mannual, correct the enet clock parent to
wakeup_axi_root.

Fixes: 24defbe194b6 ("clk: imx: add i.MX93 clk")
Reviewed-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx93.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index 9ef3fcbdd951..7fdc30062a46 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -240,7 +240,7 @@ static const struct imx93_clk_ccgr {
 	{ IMX93_CLK_AUD_XCVR_GATE,	"aud_xcvr",	"audio_xcvr_root",	0x9b80, },
 	{ IMX93_CLK_SPDIF_GATE,		"spdif",	"spdif_root",		0x9c00, },
 	{ IMX93_CLK_HSIO_32K_GATE,	"hsio_32k",	"osc_32k",		0x9dc0, },
-	{ IMX93_CLK_ENET1_GATE,		"enet1",	"enet_root",		0x9e00, },
+	{ IMX93_CLK_ENET1_GATE,		"enet1",	"wakeup_axi_root",	0x9e00, },
 	{ IMX93_CLK_ENET_QOS_GATE,	"enet_qos",	"wakeup_axi_root",	0x9e40, },
 	{ IMX93_CLK_SYS_CNT_GATE,	"sys_cnt",	"osc_24m",		0x9e80, },
 	{ IMX93_CLK_TSTMR1_GATE,	"tstmr1",	"bus_aon_root",		0x9ec0, },
-- 
2.37.1

