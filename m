Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C023610DCC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiJ1JxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiJ1Jw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:52:29 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2072.outbound.protection.outlook.com [40.107.104.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3571C7127;
        Fri, 28 Oct 2022 02:51:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFjTl6dPgmT64thy1CvEt6Np9YDiNipoTFKv0LU3sU4qMRxkkG6vVUe+CgIaLOMb5oXjbvCPPNNpPULTALIFs7HDKCng8rR4jsYT4f/QAULid1ynr/QGq/8orwETWOQmsTYVw5H6QYe13Fj40tRHj8VqiMAFckzGI9dENck/5oqjbtmmTDhoR31Hje4xl5Zx/9OCU/ihOhteACJwLBJb6fAXt34UI6jZ2FwBqZA1+O3NhFM/jAfabqnW8QQbpyk6jD6/eDc7JVNwLFuJlwDu9ZIoh6MVsVFlfTE48dOdVOBAKtwsxv85mmBj1F29xJcRCThaE9gjpRhaHymsFc4EdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EIE1Rdy8McrFUlqWR6tNZu974PdiQqqyFo1QeCyMELw=;
 b=MZvfrYyRuEWArdTK9wnw0xNn0H5NXoWqmbva70b2H77BWjQ+QAhMGJRpnaDS6N4JLw3N4oml79okl+AqbGGxfD95ggnOTB8mQ9rzjE7FKzcmCR+mxAWOP4hUuHo06fzymNnA80cuanvN20xXJ/XARBsrTnbuP0/01iFYZkhmrM1fns9DvHM86xbDKUOUZXYvKg+dM79/st8Ea6ny+7wHk2M/nW3BQZZQ+EeQIjv2n2dngzJAeGfPU/S2jqaQbPC7JsRHgMkeS0T+j/JJXt2K1pbXdham/1K2QxaQ+c4zLS4GU29eFE3bIqh2hVPF0OVnJSz1xo4eUI4XAcTd4lTv3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIE1Rdy8McrFUlqWR6tNZu974PdiQqqyFo1QeCyMELw=;
 b=V0FMH/Jz4Ps8udGmsHWUKfb+rwpJ1QI1jy93WTTrXsMeLZwIzV0+w6xx7qe6ovMo1VlYZytbTCiGEYZxKtTxIxlVsFz3kUfBLxUUBBMRJEKCwstGGXPcPFXOZ91GpWaOh6QR/QbCk0xoL4Q+k0dTS8Q7IPr/IR0Gjkq5KOlmCXg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7690.eurprd04.prod.outlook.com (2603:10a6:10:200::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 09:51:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18%5]) with mapi id 15.20.5746.028; Fri, 28 Oct 2022
 09:51:09 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH 4/6] clk: imx93: drop tpm1/3, lpit1/2 clk
Date:   Fri, 28 Oct 2022 17:52:09 +0800
Message-Id: <20221028095211.2598312-5-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c28ee965-0dd5-4dbb-4320-08dab8c9f080
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t4GtsHQbyRJ/X6si/JjDi1/edzpkFPgxQnIvAa2obNATa5zr8O9begDHO/ewNZ0HwQR5cXO5Ot4brepRgVKKoBPrKTjJNRIAFjZXlD9QqXJPpMSZ8ZYOzXSQQD8cIAp9OBt9nz1wKq7V8dkUiBPTEtzFICZgyRi3XMjnLGK8QNyWLQJsBzdhpob9r19Bf8FZCgTzkTAuGj82vj/GnwZfhTIXVkW9mNZ/Ec4meKR7Wa3ad3/zv2GMJNs8/R5vFO9mNwr84kfZ6yNHgGq6PWzoury/voqXEKVWJd0QlM6vXDpw5kbbPYgh1dQLy5J1mZQ/WD6cduEl19ekKKCJitS1LBWRASnaMLkYulcNR4yLsr/kZysqLQlMjAmbzdSHM8IoTKvQUHmZQ19j+/k0D2x+9qi5fqDENlnMzfUfTck7TXhVpfuvxjj3kUYCOYbmpICBanpLmrXumcvlBMSXgV9nItXT5JXgnLgh231YLiJm/ttBVtKjVNuna0dQy/IZAuQje4p4+yJtVbgpNw+/akJbpDPWTt8BhaMuPkGd22ccpiop0pJs675wpEia5z8s2xQK6ac+0stceO8vBGgixp6Ok1DeDSc9Ovys4XqG8F8aPad1oqnEpCZhSNPVY15KImxErwpjePRqpqn1yq2vmSIpc0IwEZbKLhRlfPOAr6XK8KjD/vIbI+UW1UmonfnnTKUSA9NO29BLnbjXUpv7mPu5GYF0Y8Fw2fJxpPHVRBZ6wNN2B8mUFhNm2XPZK5jelAl7gboYgrIOIA5EJvY3UogHKNbqlzBNncl/jVx4iZVORjY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199015)(52116002)(2616005)(6506007)(26005)(6512007)(478600001)(186003)(1076003)(83380400001)(8936002)(2906002)(316002)(54906003)(6486002)(7416002)(5660300002)(4326008)(8676002)(66476007)(66556008)(66946007)(41300700001)(86362001)(38100700002)(921005)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ISsvs1nUcCV/3zpyAjCPWGaGQtaZCFuP7qCe/lgMBJ3uXx8U027Y7qbMYwNC?=
 =?us-ascii?Q?382ay/2Wae2nA832t4MUNuSLlQlXJoFDOj7O/Hhwgb4Rnuh7lnt1D0KrR3I9?=
 =?us-ascii?Q?canklouMqe1XH6JXNyqwtTIGlDH4uOGQRLWrZl6A9z0vcz3DzW1JopOivrMV?=
 =?us-ascii?Q?DoblCoQRQ0I21m/VtcQLzDtk0BS66t6XqBMia39GMIF2RZPvnMoUUS4/aGB/?=
 =?us-ascii?Q?W8xuplolsKT2z19B8/PfMmGiGSwWeKfm3XeXlZx1IsCxcybplkgugYkjM8VG?=
 =?us-ascii?Q?jtesd1iqFG5QiJp5wEaArFpAglOIcYQRsAM2vQ641Q8rglDX9ZR4YLc65pDU?=
 =?us-ascii?Q?FkzVCplxXgVIPjuDxX97a4U7Hz9E2UoH1XY3cS2FOtGfMxaR8yMSlwO2Svif?=
 =?us-ascii?Q?HnX4qZqOsmBNfjGOPvIEYngPedBl7njIsfSHHoCMMeCL3UcSOTx3pNSUg1y5?=
 =?us-ascii?Q?SAC5BYCdQWpD8ly2mHKSgLndHXNTkAWnq0EWIwOReSEdzYTzlhXuWmnE+uDc?=
 =?us-ascii?Q?3bqKEEZj8/OheGv1FniIKh34eGwVMmqvbUuM5p1L4QFbT00cFf9SycCH2gk5?=
 =?us-ascii?Q?4WCqazYMGYM7C3tfM9EwwC0WEOjA8ZTbtV9gM3i8Goteh4MYUKEOtN8vrEf9?=
 =?us-ascii?Q?JH69ePQx2FWTe8RsXEZNBaAgbmEClXjlO5dd0iT7PCWYkMs2QbvL+GjMTVmg?=
 =?us-ascii?Q?I0g23cFosVCJ3awdBNTxcE0ulMy9IuhnvmO7OhiwVb5gi4wfD/MhXxNJ+r1Q?=
 =?us-ascii?Q?8dBzlpF86hnoBNkKnXrK1WBa8pzPFgC8DkFrGm9svpyiAMERu7QYzisSpyrJ?=
 =?us-ascii?Q?PCtbUhKqikDFhPMfd89Pdw+xztI2cODCDmGZ+3Vv1Oi9NAv9dcNcrDDXrnhp?=
 =?us-ascii?Q?j0CBNQwTS1Cwh4GZNPouAKNgeHrMk26WuS65PFsoJD/wS2IsUysQWxNCbS0r?=
 =?us-ascii?Q?EyAk8mOm+iUrf4DWvdHio0k6My8SKSPFFzJpab7HHeuxZIl5Gm4L6iFuSdag?=
 =?us-ascii?Q?VudTF1SgKw7G0QIDpoxAUARv0SdSOXK+SDWZoGKSauI5yjFFlW0obdiArOEX?=
 =?us-ascii?Q?dDrwBBvSxjwn20ttVgflRsV5cweGgCoSLP6/ol/piiyuWMDg4gMyeL2gIx4i?=
 =?us-ascii?Q?P8wZDoBDUhK3WJRuyyHQWom6J5edDCWO97RL3+2pHIbXZKA3CIwkQFaznGvZ?=
 =?us-ascii?Q?KN0pSXxSAy9/g+/V8dM5MmsLSrOgzIftiDeJFM0chaw0YmUoBxxffGKU/jqt?=
 =?us-ascii?Q?8ZVMUSAEpqKpuWM070HPLQ4913NqL9VIr3OzEgym+G6DMA3utUSFnRkGjyE8?=
 =?us-ascii?Q?eZPWzEBD4I4bxk+uuOWYM0Jxui7fI1sxhgZC8Yi7pTpKVQVsNO34kbeFwIPZ?=
 =?us-ascii?Q?vjJy4F5HNoQrChNcSJQLLe2/3hx02hUiY6LEJjVei+5gX6biMdiwUIRI+7rd?=
 =?us-ascii?Q?mYKvy4S1onPbq1ooQ/spjA1NVNGss7zMWRagg7P2fZ9MOyEceu+yp+XM8grb?=
 =?us-ascii?Q?BJE56zg2nN473w42k5nQnMmE4oD+hJUPeH/NAmUssBYCgr6A2jIgEJupceZl?=
 =?us-ascii?Q?sCBoDIk6Xlavs0vxUGVHdjKvtWONUeNY1t7Ta02v?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c28ee965-0dd5-4dbb-4320-08dab8c9f080
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 09:51:09.1577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KoK/Xl7RAyJlcjYOWVM48kXqzNOhXzEAZEDx/CMgqtfV9izykXa3x+qZiFH8fSr7EiQyWxR8D5bva50lBmpNSg==
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

Per Reference Mannual System Clocks Table,
LPIT1 and TPM1 sources from bus_aon_root
LPIT2 and TPM3 sources from bus_wakeup_root

So update driver to reflect that.

Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx93.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index 7fdc30062a46..422ad3c89845 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -64,13 +64,9 @@ static const struct imx93_clk_root {
 	{ IMX93_CLK_M33_SYSTICK,	"m33_systick_root",	0x0480,	LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_FLEXIO1,		"flexio1_root",		0x0500,	LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_FLEXIO2,		"flexio2_root",		0x0580,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_LPIT1,		"lpit1_root",		0x0600,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_LPIT2,		"lpit2_root",		0x0680,	LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_LPTMR1,		"lptmr1_root",		0x0700,	LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_LPTMR2,		"lptmr2_root",		0x0780,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_TPM1,		"tpm1_root",		0x0800,	TPM_SEL, },
 	{ IMX93_CLK_TPM2,		"tpm2_root",		0x0880,	TPM_SEL, },
-	{ IMX93_CLK_TPM3,		"tpm3_root",		0x0900,	TPM_SEL, },
 	{ IMX93_CLK_TPM4,		"tpm4_root",		0x0980,	TPM_SEL, },
 	{ IMX93_CLK_TPM5,		"tpm5_root",		0x0a00,	TPM_SEL, },
 	{ IMX93_CLK_TPM6,		"tpm6_root",		0x0a80,	TPM_SEL, },
@@ -177,13 +173,13 @@ static const struct imx93_clk_ccgr {
 	{ IMX93_CLK_GPIO4_GATE,		"gpio4",	"bus_wakeup_root",	0x8940, },
 	{ IMX93_CLK_FLEXIO1_GATE,	"flexio1",	"flexio1_root",		0x8980, },
 	{ IMX93_CLK_FLEXIO2_GATE,	"flexio2",	"flexio2_root",		0x89c0, },
-	{ IMX93_CLK_LPIT1_GATE,		"lpit1",	"lpit1_root",		0x8a00, },
-	{ IMX93_CLK_LPIT2_GATE,		"lpit2",	"lpit2_root",		0x8a40, },
+	{ IMX93_CLK_LPIT1_GATE,		"lpit1",	"bus_aon_root",		0x8a00, },
+	{ IMX93_CLK_LPIT2_GATE,		"lpit2",	"bus_wakeup_root",	0x8a40, },
 	{ IMX93_CLK_LPTMR1_GATE,	"lptmr1",	"lptmr1_root",		0x8a80, },
 	{ IMX93_CLK_LPTMR2_GATE,	"lptmr2",	"lptmr2_root",		0x8ac0, },
-	{ IMX93_CLK_TPM1_GATE,		"tpm1",		"tpm1_root",		0x8b00, },
+	{ IMX93_CLK_TPM1_GATE,		"tpm1",		"bus_aon_root",		0x8b00, },
 	{ IMX93_CLK_TPM2_GATE,		"tpm2",		"tpm2_root",		0x8b40, },
-	{ IMX93_CLK_TPM3_GATE,		"tpm3",		"tpm3_root",		0x8b80, },
+	{ IMX93_CLK_TPM3_GATE,		"tpm3",		"bus_wakeup_root",	0x8b80, },
 	{ IMX93_CLK_TPM4_GATE,		"tpm4",		"tpm4_root",		0x8bc0, },
 	{ IMX93_CLK_TPM5_GATE,		"tpm5",		"tpm5_root",		0x8c00, },
 	{ IMX93_CLK_TPM6_GATE,		"tpm6",		"tpm6_root",		0x8c40, },
-- 
2.37.1

