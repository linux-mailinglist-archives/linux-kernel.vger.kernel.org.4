Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DE6696058
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjBNKIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjBNKIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:08:16 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2063.outbound.protection.outlook.com [40.107.105.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655D812060;
        Tue, 14 Feb 2023 02:07:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJcKFUQSskvIZTIStACnNs8gE/jhdCzYSS55yf9C3fNzCW9U4dUdYH6kC6HcEdsW79qr63fb6AocNpb/OS/B3q2fH8UqyBcyrkqMXr06YBaGIuYIhUm7UND9ATOVJNI3YzLD0SmzyGHum1BtwCAYXX8lRaBUTpXGdcrfamq0zDmETQzBXKRLxoS7NEYINSpT451bo7RpWy2/CN9+uthqqwaBw1Uxt9Sj4HDBYA3qAkiutFuDzb8EbxY8xK1t5MuMu1Egf/8AKrDM/2/f9viEs0gtPs+xhsRlsDU/pMN3Qhj/V8tAWYx3jjYbBWQsphsqhwObZ8UnaNlvUX9k2E1ACA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWE2v7gcmTZgAjF135o2R8bWHo+YHguXRwe76ddTpZg=;
 b=kqMc1wfuMYeYDAoVY7BuI0rnFRwbHySlWETY3IoVutcEvauvJpJBuTnZ0dZfloPzQw3XOhrzzaWfvzr8GSu28Ht2+90xOaCqlPWAQXN1GT+WqhPRuEkeXEdiCABLI1CVDfffh8A14WyIWtbUWgLMGJvP6HgKkb5gY5Luu+228l+aPfFrcJEwtvAHrJfQN+wxw20MOTgLvzn/FjK4WGcWFcqG9kICkTvmI/b9A/81o7YYNg16rBPvGlPoOmerOfSmKDbiX82f50iXdJbo39VmR9y6C296fAi9+cXbLAvbV0kaq2nsRgu6DQtK0IO8yNwXLsVjvmNEVHCR3rGmVyX26A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWE2v7gcmTZgAjF135o2R8bWHo+YHguXRwe76ddTpZg=;
 b=iA9BSDZJBf//Bgv/ggPRETLqoLEE7IqfEiTNr9FDeF6rVrFDNsV3rwY2YTy54McU1zTppZK0BH9DOpaUYBmtf6C2w2xzK6mrFc+ojYZQXTSbv9pPM+kbTWcV2pe4os1QZLdExwZOpDnfNmldPjZa/y9tX0PxxVJvt7oJ+Hcd0k8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB6800.eurprd04.prod.outlook.com (2603:10a6:803:133::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Tue, 14 Feb
 2023 10:06:15 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6086.023; Tue, 14 Feb 2023
 10:06:15 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 08/10] media: imx-jpeg: Clear slot next desc ptr if config error
Date:   Tue, 14 Feb 2023 18:04:50 +0800
Message-Id: <4cd90d5670b4df5708abccacf210930eb0f44ede.1676368610.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1676368610.git.ming.qian@nxp.com>
References: <cover.1676368610.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::13) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|VI1PR04MB6800:EE_
X-MS-Office365-Filtering-Correlation-Id: 91803d5b-eda1-40bb-ab3c-08db0e731be5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: imVMnzDyQ6xnQLU3A+Ji5eVZ5MNHrq3t7MEmNVzQ0VYa5seoWTJNa95PaBp/3qJ4dkhA7ZujKAwpcv5g2N1+P60ShrYd2y3bj8sYuNHGaZrSyy9Kz7dPTatwvj1pji4wPCwcfLTdYAkb+3NRo5IOsLnyAlvU0wCRfnsvlx2ab2oNyokywM3YRo72CzfpP5FoW4PlAbKygrUYruDuCUoilb1eNmc0ZJm0Euerx0INnbeIquRDVRZiJexw1z2pv2EqmLuGlfcPXaXXmwAEjamzv4JbH7ftb6p7MuKtDkS2qALTMoYH6PPB8NN3dKqoXJU2+cKq23qJA3L+YMXSxSP0mLUE99yOcyFNU5HBSB5jrwSAcohq1b+BGUh6yVY956HdT4P9Puim592tUp4wMyxuKNzZzdMGC8q8/2FhhxEA6KdjaGrUROSz7BUUz234aRqktxUvcvg6C54I/cmRXoWp+dz3u3OEz6ANwyIcW7nxtL8LoZiRvEcUesFiPsbGUT0vIQkbLfAuCaPxlmeuQcQFEiA6SnPmKC633azsIiY2q6Z0p76KA16SUsqZbdgT1QJBzCKrEKDLfQQ5xeYLkb4onGFPmMuNGTOHaAzfuB71iUpbUgN9HSgOF+Vj2fZWuCN1JU8UEh666mtw85KRTAj8a0vpJZEvFinDvpKBkPNIciI/qwetwZIuh4cgsLhADp6SyQDuVC7Fd9BzlL8A8PA20A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199018)(6506007)(52116002)(6486002)(2906002)(36756003)(26005)(186003)(38100700002)(66556008)(8676002)(66476007)(66946007)(8936002)(6666004)(6512007)(38350700002)(2616005)(4326008)(44832011)(478600001)(316002)(86362001)(5660300002)(7416002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8NpHm8zpXrHu6qaCTaXBHj0F3wG8XN3Mpk+xlLNlBhLfKwrvp62PrSXikn4T?=
 =?us-ascii?Q?uFiVfKkesW7clOzYe1bls2ZA8SF/N/hRhiGGj6Jb8WmJcP5XKwGRtb5uuHrS?=
 =?us-ascii?Q?f8LY8bAcQPdAUh1pm460tNjBNRt1yLoma2KXwRyLQn1aT8tU1ZOxRCM/dLc1?=
 =?us-ascii?Q?ANApkTf4+Sw6DZGyXf8s4A480y5cM8n1Ypyyo6MMCYxv22TuBeBQPThf1h4k?=
 =?us-ascii?Q?NaS8uesGg9eZ6bzqa4rFL/fjOrQ86zfTUt5ax1wov7sgWZHZz2vxGFum/sia?=
 =?us-ascii?Q?8MeshNH8GX/VXGjP3TUdlaEQOYz35A3U1SiOVCZuVPvrjXnl4Z07qAxdEOEl?=
 =?us-ascii?Q?ab5GJaSVqd7WV8mlktw/lJ8bwUu9fK9ikB8faC2tSSakEKXnrb8mCsPQdD1R?=
 =?us-ascii?Q?5IGvwTwOevykQ/detSyzF1FIrVTd7iAdPovVIAgh+gtwnsYjNDREcl124sIm?=
 =?us-ascii?Q?7Ny/GCtQ/R+Ya4S09xN+FabFTlgPREx7ih7DxBM7xS0BrxGtZuKvJeqc8w1b?=
 =?us-ascii?Q?K4aICXpXyrVY1D/65A85B8gaTcXl4njtMJj3ERieVYSQcECUST633QoppppV?=
 =?us-ascii?Q?Z3KOVBjcq0z/yI+soxDhZ1gbuDjPavMm0lga97ZsiwBReNDWTPUYUgl5rfli?=
 =?us-ascii?Q?Tns85RdwTfJ+bpLkOscXNinXXilJK7B6ga4ZLhU+Cl6iNgy7SbuQzd8+l5eV?=
 =?us-ascii?Q?VKnmJlVuLtnNgNDw8UyVhWS3jDvi+mxJqj8vdDbJky1Yo/FCzK0GgyWUQvV6?=
 =?us-ascii?Q?6FlmedcNpH0hOt6Ny4VU2Zx0a0mooL7HjP3A0fl0Mkky3QQCRlxy7vBN5eiT?=
 =?us-ascii?Q?nOloZP4N+8PNGZSEbmCqwbenrfrntzJmqDZm8A3Kc9w/ffwgxb1iRiAegWBL?=
 =?us-ascii?Q?tBW/xJ3jAYUOsSvy4cs/9/7M3pDJ2593ChvhqAKrcF79M89PdrAQLV1+pGoG?=
 =?us-ascii?Q?L7STUv/jkzWC69Y9yvs7ccKdSaZv+9HSrTBILy1Dpy9zokYwMAN+omtF8Bp2?=
 =?us-ascii?Q?1+UJ3Vkdg781pG0UT17Kyv/Uxs4OaoeB8BXM78IVMUUlrOKQsfvxecFI0UQI?=
 =?us-ascii?Q?cbVQzRwftyUjDmjIHCOVYw4wuTYdVnMqB/w7BNA6Zzv1+hqSABn/hh1qSVLt?=
 =?us-ascii?Q?A86bkbDuZilhKp1IxpHYhzF5m6+/TRZgLf4Cg2UBluy8aAGVLN6QoLT/q+nB?=
 =?us-ascii?Q?UTnRgMxrt3oRvjPzeX2Nn53lp9/NjohIL9Bh9phZtVjxnj9H75VWm1UxyP80?=
 =?us-ascii?Q?N1FJzBwonQrR60mXWGyLyyGPKbTqENbhvqkBidrdGpcpqm3XrCZOj8AxR90N?=
 =?us-ascii?Q?Ci51OoCjQqarvFUlQuY5b2D8iI8zd2GmQCXhoi2/yvr9tAJYo0xsjBUNP+TI?=
 =?us-ascii?Q?knwhUALJKI4cQTdLRl3tOLEiUkrpYeebOYhzhRvTJFKkcgcUb5ASKT1Bp78Z?=
 =?us-ascii?Q?E8s105PPDPXZW1WFU/RPUGssPSQ27vadXjl1s5uCp8PA4aowIyzFaShltN4J?=
 =?us-ascii?Q?kHpdSb2KhAO46Gjf/Gzw+YmWYLzDlhyANK+PEE0sUFLB8zKahtzHdeKoO7qq?=
 =?us-ascii?Q?QnDfkxrjlL3GycMNSRH1xHS/ZDSTyOPTtvWAwex6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91803d5b-eda1-40bb-ab3c-08db0e731be5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 10:06:15.7152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76L/lHmsc29i3VpYuIEIlB6UkvRNQq8KS/X0pcZ/kucvVw//YvKXxYuTwjpt+Bbp0Eh6BUbNaTJxIJhHm4iH+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6800
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clear slot next desc ptr if config error,
otherwise codec will report config error interrupt repeatedly,
it may led to system hang.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c | 5 +++++
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h | 1 +
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
index ef28122a5ed4..bbd5d6a9fc86 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
@@ -178,3 +178,8 @@ void mxc_jpeg_set_desc(u32 desc, void __iomem *reg, int slot)
 	writel(desc | MXC_NXT_DESCPT_EN,
 	       reg + MXC_SLOT_OFFSET(slot, SLOT_NXT_DESCPT_PTR));
 }
+
+void mxc_jpeg_clr_desc(void __iomem *reg, int slot)
+{
+	writel(0, reg + MXC_SLOT_OFFSET(slot, SLOT_NXT_DESCPT_PTR));
+}
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
index ecf3b6562ba2..8b7cd6526efd 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
@@ -137,6 +137,7 @@ void mxc_jpeg_set_bufsize(struct mxc_jpeg_desc *desc,  u32 bufsize);
 void mxc_jpeg_set_res(struct mxc_jpeg_desc *desc, u16 w, u16 h);
 void mxc_jpeg_set_line_pitch(struct mxc_jpeg_desc *desc, u32 line_pitch);
 void mxc_jpeg_set_desc(u32 desc, void __iomem *reg, int slot);
+void mxc_jpeg_clr_desc(void __iomem *reg, int slot);
 void mxc_jpeg_set_regs_from_desc(struct mxc_jpeg_desc *desc,
 				 void __iomem *reg);
 #endif
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 70b6eea733e7..3f1c9bc4b144 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -692,6 +692,7 @@ static irqreturn_t mxc_jpeg_dec_irq(int irq, void *priv)
 		u32 ret = readl(reg + CAST_STATUS12);
 
 		dev_err(dev, "Encoder/decoder error, status=0x%08x", ret);
+		mxc_jpeg_clr_desc(reg, slot);
 		mxc_jpeg_sw_reset(reg);
 		buf_state = VB2_BUF_STATE_ERROR;
 		goto buffers_done;
-- 
2.38.1

