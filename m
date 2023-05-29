Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31095714252
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 05:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjE2DcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 23:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2DcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 23:32:23 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2082.outbound.protection.outlook.com [40.107.7.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8105AF
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 20:32:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=co715FO7nKT4nDKueSdvkCrD1jS3A9sG8LhATrytt/QXDy2WDDdY4YFqgy9ALUIfnuM0nxx2y3H8Qj56oaTszFGnDWF8r6tZaXR+Ps9VHhIHgiJ38AZE9gMOCd0qF1qXg/IR9YOa0KMOoX4t05V3qmoKVn5Qp43gE1xs2aYbq47Jl1IkW3acSG+1ghLZHJMOHMZKopnOSgHqBATuO1uet6dnPB2zirv/C69thkZzVxCAk8YlHtr5csnb5m0BTuRzJ+te0DGzJ+1U4s+UuIwkQJaK9aplzq6j2WAeQG05Gdh/KPF08tiR2ULoLEtI+Rz+FOVUx/bxd7+2IuurOQ43LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fd38Kl2ClLiMiFbV3cYfMRQW8iLtWgNhLpeOsiNEcmA=;
 b=mFZ0+fEIfcUozIWNUsU5Zn8ZTscYO5a0Ighd++Tik44UnoFLzh3Xr0Uh0D1FCH8hBBFRU4y/xLIToZb6287yAEUa9yMB2ozBCqLWpvZC2oh7kThgN2EGr00dX47wgJUHOWtYUGvuTiBWCBa8A3fe1rQzlHNGCLuKN4txlVfdK9xK4jqavn/5V/lGmwWIoJ4sVnql8lyXVdvwP5dJV4lqwpJ3f2/90n8YIorO1/GWwJamDSrkMTehxRnORTa5G8dZ1D/dqmykmYdkcJO3y2XQ4ngNtKlnlV2eaqvMYrvBt+Mzgth3c9n5l5Sy2a46EHTF5khBPZreF92HiHYU3NACxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fd38Kl2ClLiMiFbV3cYfMRQW8iLtWgNhLpeOsiNEcmA=;
 b=Kj0eIehCyEEFPpd51WlRGhAJjbbwxFGSCMdtQd6kfPmjtuB8q1mIy4XFfw26N9FPKlNVd80xM7dUXxuUxfrCExfxQdl4g3cDtKmEvwAT4iAfbfYWz3vsaqVAuqCWcfiNI4wdFnoosraqKuEUrY3uliGCu8xyD7OhSgrq5u0463E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB9062.eurprd04.prod.outlook.com (2603:10a6:20b:445::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 03:32:16 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%7]) with mapi id 15.20.6433.020; Mon, 29 May 2023
 03:32:16 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH V4 1/2] soc: imx: Correct i.MX8MP soc device
Date:   Mon, 29 May 2023 11:37:09 +0800
Message-Id: <20230529033710.4098568-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0033.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB9062:EE_
X-MS-Office365-Filtering-Correlation-Id: f6df57f7-516a-4307-2b16-08db5ff54cbb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GnOtliBr953Vd+okPkpCOD52er3juNLZT8QNyiR/4Cyel043T1zXqDWo2r1ilZrvAV/+QNeNeSoesK2fTJEcf/2g6VhLXJg/5DJLDbb0DtTVikB+ZJoXrF2qwR0qWyXVs92SeosNQp8YG5+91C42Os19wMea2GvWvXLPcEXwWFdtju5gCleN4tLOHZ3tk8I0nP4YfYzSI0/J214DW34iyEMq7Bjh4I5DTYRlViYSmNP1B6UH2GpHAjGWS0u/F5u/W8t1cbuRwejSjG+BFh3pzLur2Qn8w0+sxRavcPiHcE+znAD7sVzQ/K7RSvHS0rSLhZZGGaNH2OKJqAfAGOwlnY9HU592zpQn/do8oTzKPxxDNaZdPAs7JM1PzYsrWev3oPGFM/eWf2YbAmxqP8Sxj1+rEUahyhx8SDsqRT9XJbDRVzl/DQhNp1eJ27SL/FMrFduZDaLsrNZ9CE+kJSMFXUM2Nv3bzwn3vSr100L+pY3r1psJa5050KZZ7OwpNWBaVjVCM3POgUwBG7jbupqaQ6g9NOWIUANvrm5Nc9LGdqKqgg1uql5QpYPL7j7WAAEdK7BTUBUCYOXMN8hwTS4GpYPu+Qrasi8CRte30oNUDsQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199021)(66946007)(4326008)(66556008)(66476007)(83380400001)(5660300002)(86362001)(52116002)(38350700002)(41300700001)(38100700002)(186003)(2616005)(8936002)(8676002)(6486002)(2906002)(966005)(6512007)(6666004)(6506007)(316002)(26005)(1076003)(478600001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h/cdEjhxMA3hg9d0iTIN9eGwL9CuXVRxYKimeQ3f3sDKaJ8dbKB9mTC5vEHv?=
 =?us-ascii?Q?ubO+Y3kkOg175FYhq6qOUTXuYwotPGyW8Jqu3EqwkHZ0ASvVspWIJBnaLG5N?=
 =?us-ascii?Q?Rmg3EOucJJ0zw9ys3KBDbifVnQ8btnbPVWpFXHcQnX7SdN6p+OgZn5N+hhY0?=
 =?us-ascii?Q?PM9cMJ6CFn4Ent18aIOFemoLRboz58bjDbyKsFDAd/OnPbkDmEnnta68OqhT?=
 =?us-ascii?Q?2l3bcp6S0Jl9y/lAXFGFSCXzxl4V/fwlNaNY/hAfZsYhfsp1nsaH+BWX3+be?=
 =?us-ascii?Q?5RF4j541MfeY3hLkQKCwJBS2z7ohS2tZe6zrSWG/I3ojg7iaaGTPsbepN48L?=
 =?us-ascii?Q?uBL8LiuON7HsFh6WLT3KprHECFj57bM5o766IjEp0PohOE8lcZQhEZXmVS44?=
 =?us-ascii?Q?COczFXiLhXV3/NrPFI9PDo2gQtKbcX4qEFL3UDzBk72Ns4zA1Q4L8NOOJGUD?=
 =?us-ascii?Q?2zjbgfKg9iNQ9t2KYtc9OShso5ZgRjaG9nSGVm/mkLnfKynHOvO3OU6acPAH?=
 =?us-ascii?Q?J8APx30KfF77sjYTRMitNUn7ucmDv6PRtn7YoZLnMpnNdqz4HFVot+IXaY2Z?=
 =?us-ascii?Q?nxTVeeZuGjFpl38MatGsNC0z83TyrusxQRZ+Sy5o814DivVZtegs86FtWW8k?=
 =?us-ascii?Q?Vuqr0rh7KLlDhhd0VCLJ3+hUYyR8XADD8cy3csSLG7Nru2dN9dnvR+MSj7Wc?=
 =?us-ascii?Q?cQ0emtplhgvScTLmWd4qahsahFLRgsevOj9MbzUJbu3QXIO1TxygqOq0h1DJ?=
 =?us-ascii?Q?TWqqbNovYcgYdCGjiqT2TvpKTvpWZhqFz9bWn5su4kjR9fAATVMY+PVOxTC7?=
 =?us-ascii?Q?5gH/XWVtDyVdqLKPRVCrRx0rICFezcgqNqOmhhaetBhHD9LdWmwliuP/5EP6?=
 =?us-ascii?Q?Z1b/IhkI90Bmt31No4WmsH4mDNsA7/gF9zbo22SRm6e4GsAlAwj9TG3IbNb3?=
 =?us-ascii?Q?2Py7xjCpABSbBXQeS8CwP3+QVNM/iE0CutpqM7VjVC1mYNQoTsgauX9GnGBs?=
 =?us-ascii?Q?uKNUQ/zGFR9gvhUOmw2yFTvSQ9NF47kZLJz1e6uZlsUNq6Hjm4nJXTrx3Yd9?=
 =?us-ascii?Q?V7xa6t0UItZv1y24YIdnUSyOHO+3S5eDEpTBYLswg4f+gJ+wFI3ilYROGPhD?=
 =?us-ascii?Q?OlXfDGviMfH90+ZNQNY++Pmb9/Enddet52idMcjD2MwLyaVQY7JaHY9vOtf+?=
 =?us-ascii?Q?nOr3+BUjhx1XeD6pePmO7uoKnDHBwwOVzvZj78GviEPlzJ18/4iKMjaB1Cw9?=
 =?us-ascii?Q?19X7NvtVjCEdb2pWmYpCGiC2cYm8pomfPBl1A849T9mdk7S5q1Tza/WH2iFp?=
 =?us-ascii?Q?emwzVe/J3zybQ6njd4gzYLURJrc73v+HxNreskUX8aJRM+cUZeb3ZrKPgl3/?=
 =?us-ascii?Q?W3eSCiV6vk87INQbZiAC3rmWH2SLqdSKDNCLa55hoJMJ+wQSbCcFo2YG8Mp+?=
 =?us-ascii?Q?5vh67tepS1p8l2Sb/BS1DJLs7GuAjf1mWV07URvsBNtdoTpvrLCPCSjAymSp?=
 =?us-ascii?Q?UpNnccqZ4ZN6cSsGyxZxVvMoFbY3E83Bn+/M8L+hqV2AeoD+fpAX5dHZKuuH?=
 =?us-ascii?Q?a8VuZ142yB1ul7gPEcFb7qPaBApDQG5UVh7Rf8a4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6df57f7-516a-4307-2b16-08db5ff54cbb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 03:32:16.4086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TwO7O5VSYvlboVkTVpbUv7EibSPEHtexeRzqgBMQ8Sjw0w+fXVqGptW0TES0rF8JatGE9z2rQJPl93SVhJdTMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9062
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8MP UID is actually 128bits and partitioned into two parts, with 1st
64bits at 0x410 and 0x420, with 2nd 64bits at 0xE00 and 0xE10.

So introduce soc_uid_h for the higher 64bits

Fixes: 18f662a73862 ("soc: imx: Add i.MX8MP SoC driver support")
Reported-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Closes: https://lore.kernel.org/all/fe5e2b36-6a8e-656c-a4a6-13a47f4871af@prevas.dk/
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V4:
 New patch

 drivers/soc/imx/soc-imx8m.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
index 1dcd243df567..be26bbdac9fa 100644
--- a/drivers/soc/imx/soc-imx8m.c
+++ b/drivers/soc/imx/soc-imx8m.c
@@ -24,6 +24,7 @@
 #define OCOTP_UID_HIGH			0x420
 
 #define IMX8MP_OCOTP_UID_OFFSET		0x10
+#define IMX8MP_OCOTP_UID_HIGH		0xE00
 
 /* Same as ANADIG_DIGPROG_IMX7D */
 #define ANADIG_DIGPROG_IMX8MM	0x800
@@ -34,6 +35,7 @@ struct imx8_soc_data {
 };
 
 static u64 soc_uid;
+static u64 soc_uid_h;
 
 #ifdef CONFIG_HAVE_ARM_SMCCC
 static u32 imx8mq_soc_revision_from_atf(void)
@@ -114,6 +116,12 @@ static void __init imx8mm_soc_uid(void)
 	soc_uid <<= 32;
 	soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW + offset);
 
+	if (offset) {
+		soc_uid_h = readl_relaxed(ocotp_base + IMX8MP_OCOTP_UID_HIGH + 0x10);
+		soc_uid_h <<= 32;
+		soc_uid_h |= readl_relaxed(ocotp_base + IMX8MP_OCOTP_UID_HIGH);
+	}
+
 	iounmap(ocotp_base);
 	of_node_put(np);
 }
@@ -212,7 +220,12 @@ static int __init imx8_soc_init(void)
 		goto free_soc;
 	}
 
-	soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX", soc_uid);
+	if (soc_uid_h)
+		soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX%016llX",
+							soc_uid_h, soc_uid);
+	else
+		soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX", soc_uid);
+
 	if (!soc_dev_attr->serial_number) {
 		ret = -ENOMEM;
 		goto free_rev;
-- 
2.37.1

