Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5311360F48A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 12:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbiJ0KK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 06:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235141AbiJ0KKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 06:10:47 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140040.outbound.protection.outlook.com [40.107.14.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1846D5B788;
        Thu, 27 Oct 2022 03:10:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAOaIVFMWToGAqMmhyCbfvgqIYK+fhhnkkL8LG7//wMaqfux+HHBKvyeLl5dmAYuGnVRtX8PbayNo4pnHhlJoMUGSO9+7Q2quGZyS2Fw7OpEsy0+Qlf1N7zPH6X8NEhJ/oLJ+lVUb+tI7jrYxVpb7IZT6FsgV0orb1R3YwGPmdrP1kj+jFsIQyJjn9v/4Km15j8zeezc0XC/+qEgG4WxrfG5Wof5QEK7MdZ0djK3oXezG48wof7PtQ3x9SYkF2EmX2MDqfBmJHoKBqsrW/bfdcY/49MGYFq5UWLVSQqZoZ8EbsmRIPIyO5Rynh5kQPCq8CoI2JmJdGUFibuCJFiw5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPeYFNzYxfzSKhDdsuPnk4X+UkX6e60sELc8CFOss3g=;
 b=M/yruUOpbQTOdFw4mF/FlWWnYssyDa5f/QKWgQn77gF1Y2rrWv45ZFby5HM9SqdOZ6z0DDlNDq0WCbPuaG3juqwaenObxsxUbD7fS1K7gcVmnhSdOqcPyaPrZRuqRATvflOp+EUwiVv5h457fVkofKKc6k+BoxsTixgULCMoGDcUenoITRfvpWzrS0J+Ec+efkjMbR8cUorPfN/Zn7zJOfbsP8aqYwSQc05El/OJCpuBpLffoGAKJD9gO8deTDV8aTq7ZLc56A2cSsmYpJ84FPB9lLYd41RwX7G6tUbNONXz4Ejkk5v7a8UAD/3Yon23mWcClj56t2ydcELHLtXW9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPeYFNzYxfzSKhDdsuPnk4X+UkX6e60sELc8CFOss3g=;
 b=auVQrA0pZ7lmf0V4JvfXIHlPCTK62ihuii2chgCqcmZUIHF7jEIXY4aHao+IicZwK9U/fB2paKEbs0f8RADgkJIIdWdD1diAPqxip6ZodFe3qLTfZX0znoN8Isy75PxXJ3d9LkAJU8/rx+wCq3bJXKRdUx+BQkZFTXOBYr47Xq0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB6871.eurprd04.prod.outlook.com (2603:10a6:20b:109::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 27 Oct
 2022 10:10:43 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18%5]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 10:10:43 +0000
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
Date:   Thu, 27 Oct 2022 18:11:55 +0800
Message-Id: <20221027101159.942843-3-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: cd59c212-792d-4339-ad59-08dab80381da
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Og5bg06Vhc/N4auFsIDYtTS/nsq2IMTe0Y13+aSN8FMe3nrAzWy9B8+is9k3XvgpeZ6pVhoAX1b9EZQCpSZbNaRgq1LaATDcUBU4Z6RR/mXwqkeIku+/J3USNKEVen+UVsA4O0YPmRcPXIOFXrf1BROIC9I+PG381Ntfl1Vv/yfrk0oV/47qq8aKFBTaif/BCeSdq2RRFswuIPkR9WqDRvmLrCwtlcWW/OemriwQPlc9z+F22UBIW8DjjQ36wRiGNDfLr4C8JC7J+DVYDx7NT8Rso7ST9jtwRQZE8BP9WjZfiRcqHwmHzEqoddLRC1qRPaH95V4gyVHD2lpXMU9jPfvL1ftADWyDMq1156+Zvuie/OnvOJOzUK9Xp958GnYEClNcjtgDVnRt3l1jacjp/jrDgiK/DwCMQ3Nell1ujwwdO5uDjq6oz5mcv2yrwPtjj1j0tcTtSZS/e2+mdX1hb0NRFL+OXF3gkXaAPG+Dq9+Kw1cUSKvOr3jL5KcbEsL0l2Qj+9ZQGofROPgeMFoJCadiQEPWlg1Jek6gN2FTfNp0Y4RT2tFMnGZCiIiPYUPHoDKU7Fh+vLL+kinIHqGlPnj7EawfZAM1AB2zWsMRPUzhcrBXUkPCehnLttlZk41WM3H1TGKvuEWNGIgeGs0OrzqTNNyxd82NwpXo7iUBFSQspyNHvwmD7FWgXw6Sl6lrh7uSKUfnXS70bRlqxNCA60efzXJb49yHryJQOtqgvVWiWC0lp9iI5He2u8h27lO7rH6nyiBPbZOkAjHlZk6qPCaLeB39KxPkb/mXV97gdjU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199015)(316002)(54906003)(83380400001)(38350700002)(8936002)(41300700001)(921005)(7416002)(86362001)(5660300002)(2906002)(4326008)(8676002)(66476007)(66556008)(66946007)(38100700002)(6506007)(6486002)(52116002)(478600001)(6666004)(186003)(1076003)(2616005)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7OFH3MgGZ7zZKOeaEUC4SNYypD5378hfOCSpnKxeC/AYh4cGuqpsPw/Ux+e7?=
 =?us-ascii?Q?pbQvRguWDsEA5G0e7hD2ftRZmz9E0AIt90jMHmOvprKXPBq+h+n7drcfG3JJ?=
 =?us-ascii?Q?Sbz4A8mhzD7z0eUYg30oUhLOKV9bZGkIdBQMo91jQC9nXpPsJ+OrmL4I+/Fs?=
 =?us-ascii?Q?x7FLCfBXScGTfxB5B+w0pzQXMMglsc+fCxtoiU7McUvrAZNjGsxFZh4mX8hH?=
 =?us-ascii?Q?i9ONiVsmouhDEDNbGU6tg5XRkoKZhlaEsTGHGgjcS9BS3vljLqqs/oxYkN7E?=
 =?us-ascii?Q?+GNdOFQCpA2gXlw18oU99i2b6GcmXQtX43LbJf50YJYHOmRUvCs4wTJ7AOx+?=
 =?us-ascii?Q?n62rp5ptMBemjCBPA9HtvB3iDU3mcpeB5MTV23N1a4uP3P7CyYxNJ4med4nd?=
 =?us-ascii?Q?iVKXAje9UYXAgs3d0lCrQdlM9gg4zQn+DUkKvgogoavlmdArcEXNSq4e+fSh?=
 =?us-ascii?Q?jwpF6V7sXrS0Z4Q9l73LUelPNhR5eCTHGgpoMEh+36Gwt1+DcukMZsCerNOz?=
 =?us-ascii?Q?ePVM5Q7kh5EdUk0QZauqmuQ1XGyganUaEX5oDSSCJweAh98wrLajOxfEIyfX?=
 =?us-ascii?Q?+ikyVvBoCv8z3L7Gv1XlJhbzLqfVjB2bP9xWQ+oJMmeQ4lSboB1W1XPGY3jf?=
 =?us-ascii?Q?W5vFmYyfllsL9cutNTMYGXzMg7o8bmvaTsuhTjKtWT1jYStxxd1h4vYJW0eR?=
 =?us-ascii?Q?BkwwIHX9c2no45mqEmFB8Ixj4/tGWpStJwvMG4+mJbPln4qjHRFqZ8fDDQNv?=
 =?us-ascii?Q?SHahQolH/jqYbZ3vJKlSHeC4argkSVxKKb4ftGOaGaKPOCdaMWt0KvplxB/5?=
 =?us-ascii?Q?dED8Gvctx1BxxGMvdLpfYTL0bkr+cHkhTC+/RWaZnrfZTd46wO9TGk28Zruy?=
 =?us-ascii?Q?Pvv+DuiBIGdxibYfzF1ncZkHuAsbQAbSv9VBXHEOnRV/2SNVMZ4JlYGfhgj7?=
 =?us-ascii?Q?jR30lmdclNxoHV5Daskm6JneniU8S6WGjIBFiCq1tmiw7EGshsfQZnGCWr/x?=
 =?us-ascii?Q?BDAGRW6Ef6qTULx40nbBbADZlajPhXDg3QoGoTjD+6BpDbZLPhvYF3QrgvBU?=
 =?us-ascii?Q?S6Jd+STPq7A62SqKYcUMr0/CtnfssLormREfTCxodI+xIXVWgDj2x0pcpZ1v?=
 =?us-ascii?Q?Wz374iSZ1hHll9Dzh2ZZzq3jvLt3g3u9QA4gbCvf73e7xJUbngIfhCt2c6Ex?=
 =?us-ascii?Q?wwgt0YwvyHaEeArFwoLkZEndMPQV5dVhB3doUub3h99WH5WxD5tM+HHSUmU5?=
 =?us-ascii?Q?cOot3WATlrjoT4EddloZ8tFiUyJAihE4tuSENUCh0TYf8dP/sfrvKGKX8Yc7?=
 =?us-ascii?Q?2ryqyXUo9uugvx2XBDPfMJpbRdkONfAi6MBiJjI0Tef916RODMvhy9fpq9Z1?=
 =?us-ascii?Q?EKITj9BiYZFub0UPGZvTvuWHqzHsFD6edZAgNRyK8MgbtzgQROKTmytVLCIw?=
 =?us-ascii?Q?pBVkagfc90cjsaXefFHpg2XG3s5HzX4lWOsVwkRKzaiSID6DIiDuEYkTGWMN?=
 =?us-ascii?Q?niQcRMh+GltorizJRpry3HThEokdWTAsaqPd5R6hzh7hnOjTaC1bOe+9G3uY?=
 =?us-ascii?Q?LLe/zk8/8uMVmNo+zeVGPaeu36/c3HshT0PHVdXJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd59c212-792d-4339-ad59-08dab80381da
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 10:10:43.2631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vclOOqTANFZCmYj5YE3gUXcnT8HRfmbkgn9nfhrTxbaIBbpEp9av8n3B1Uja2uqFC5RHeFkSVvM+2yyMnjY0aQ==
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

