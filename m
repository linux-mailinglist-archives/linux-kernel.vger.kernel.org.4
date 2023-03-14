Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FCE6B8F77
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjCNKM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjCNKMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:12:45 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51C199BEE;
        Tue, 14 Mar 2023 03:12:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMz7A6qeZI0gDImST8+vYmJgNTwqdM+/hi1BZeDvMuUMjEafTIS4n3bCiEZkMdy5wStFKo021xWJcXBy+FGqpyjgNo6Nfik4Kkkt07acEBq/EvTIzWbeHCLiRN1qygPmEUj0/O33Y7oriKyg+/5LazR9WvDMh0rJ/P5ipXXXwxiPi57dsnfGyPmwr6bdS/aG9Lh1UV9E8dNUAMkeONBFgXruPoW1Y07ATWYy9SpitrXvoDCYFlB+m1LF2WcPEdfyxd77INHQdPEA0i8EiTr0QWUu2UEp0NbDINlYFe242d/VpjEVSb8sKYOPRY4IaFfpg/qbaANqq6IeAonU6N4IAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCAL8779U4zEgsqncy9scuUL8gibGXjTY42SAMO9ens=;
 b=AyngtXbeo0IKZxNFO4pJDf/A6IxqorDlfszhJ5ijg0SsUbB1c6wBDm/ueFSi8rHxT2WSZm7UEs31eBIh4vyjcT2Cu6/3j8YAxpDNhiXhf5VFuz4xvg4XY430UOditfw6DRSmvrG1DXkPikWjxLGKtl3lFncajilYZXTyV/u2ficKgzjZOfpxtmjJaAVPaZHXIIspThGjMUl43lcllBIBjiIJ3cN5gCm6saSoc0g7wJqAxsstbL1KLYBGyVEk8F+ig4n47udg2JRcmWjjY9ZjAN6BHZUvI8OL81zeZ2e73KOA0Ud7zWsm5G/HBt6PPxZChfAqKj5qr1VCqX6ixwEB7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCAL8779U4zEgsqncy9scuUL8gibGXjTY42SAMO9ens=;
 b=jMl10IG2/1xVghzyhY+CL/xWN8VsXSOiW51h4mm4EECv39QHchkg7MHiDR+z5zUeZ12yGVe1JKiIC8FKkoQdDWYnP6dE0yw0IFmOg0lwBZTYsppjyKHhNTRzLhvkKSSS7QBvqtdn3r5qkPaeHgj04Yy51IRKqN05mXkAkbMWrQ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM8PR04MB7841.eurprd04.prod.outlook.com (2603:10a6:20b:244::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 10:10:38 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b%5]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 10:10:38 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 10/10] media: imx-jpeg: Encoder add support for 12bit jpeg
Date:   Tue, 14 Mar 2023 18:08:53 +0800
Message-Id: <f5b6856e1eeb9f03df4bc38538c84cb21ea088fc.1678788305.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1678788305.git.ming.qian@nxp.com>
References: <cover.1678788305.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AM8PR04MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ac5b80d-ef4a-4066-7485-08db24745c43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kI74PbbL7nyySy0uCm0P6EFv9iK8kjUASC1SXeXrAumG3CEJUndMJHn5qLRU8hlq6L6Hns7xTcxI8pyIS38s4PMlwXVNvWt6rv9ITfLMBHqf2MNvN8ejZUuEjKZYMfGdsfYd7ta3colEqTmdCwhF1P/+fju6uPJ9jNWmiTiKqr4hzNav4eivFR44FRy9TdYfo7DceioF+AziOqjRXwAXaMITt/HmJTLEhaxq/rMGsRLVHcVqxUJf5/zaEjKtBMouOY4K80R+xLf5YSVtdZKzCed9WrhuKh//feAgaFwMCgBHXJRHJBDOGzvyN6HD0IHj8HH94l5KqnS3QbqghkTFYIY8vNwEo9SqZCWApmOAX9XB7KOGhY3TcI0LBPjlpGCA+EhNgTsTY9um9w4Aze5Yz/27UmyCILglna8va1lzkocMJGAwOHQWLZucl7fPvp2eTxU+/SSn1SlSdeUcJRI445bJTsjGkdm1NzQ4mPgAHU+xlJC3P/QSajJG/fkJ8MtfMCe25Ij5t22NbL9ipcBLfrS4b4gcX/n1UJeULPNicP+TrhiaCWkuVvN7AIaQgWHSxAjdtiMdE8qFZcD6onh42jmZTzLP+Keecov3w0xeLEXbz1CgzUS8CF+7shVAQf9muwCuQ2XUYnkXXwCsT04WNqGryJeTLBL056Rp/37YbRaM/Ocs62wxgDb9vJ/i8trMCuRt86mQJDLl+mxKH2iFsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199018)(7416002)(5660300002)(30864003)(8936002)(2906002)(44832011)(38350700002)(38100700002)(86362001)(36756003)(41300700001)(478600001)(66946007)(66556008)(66476007)(8676002)(6486002)(6666004)(4326008)(52116002)(83380400001)(316002)(186003)(26005)(6506007)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ARWasc0gq/++sR2xbwLLxc4mnCLZbgamHFfxxlwxZU3WNXRtfUJFM01mOF8J?=
 =?us-ascii?Q?qJV+MhNnnlxo846TEVkMfz5iH5cek4haTwbNYt2lmqd8U+cyw6upJ+OGAPG9?=
 =?us-ascii?Q?+PNgF85vmGo6ONjOIVgAVoYtDY62ns8nAuFrUC6qJNqANoauHjID6QB6zPC6?=
 =?us-ascii?Q?gW5W0uYiJN4cgiyOdy1U7hdG+YYof/+p3fsGeZ2BDTjeUTZGFy4isBQrV2GT?=
 =?us-ascii?Q?sU993avvnC9opf7TX5QKutG0nDqWiRPITOcRHdAqFGn1acMbowZ4bt4fDN9D?=
 =?us-ascii?Q?jdPGM4cNSG3F77C3Ix7iEZ7TpN57DmFpbdd1scsoU/kDTzQMuP/QF1irsjpD?=
 =?us-ascii?Q?GHWirsKD3hLgYjbGY1QGcC9li58cVelO/U3uXAcr0o9VGCGH0ncsdrT628su?=
 =?us-ascii?Q?urERhDb0e8wWuPwQezqsncLuNBVTbJhrOOrcCT2dio/mZXCebyIgepBov0nN?=
 =?us-ascii?Q?PBXyvZHVI1ggpx7qZkb87UlmV6rfZpjyFEMiP1LRrl+xsJj9OyKhC6qTp6XF?=
 =?us-ascii?Q?oSPbnfYY8DRk4ENP97hM9KMrHDJ+D1qZd+eMLMe2nMKDEzDEErqTWeNKfYKv?=
 =?us-ascii?Q?O+PTv1jQpw3vH07jooy/ZuH2pWk43zGQQ4WVBUu/Q2EAeKpB5TpK1+KKs4/O?=
 =?us-ascii?Q?897gEZYwvp1zHMwXtGd000LT4pRYFWiCQ1Kq25oPWpA3oJtfVRxye2a6bZg+?=
 =?us-ascii?Q?/sjkvrEumT5BBUXipYAaL9+uaI5VlC63mMqVRKG/F/D4DxPk0wpo4V2PA2zK?=
 =?us-ascii?Q?4HQNmNd1UK2U0grkf15Mtmy3c5ZNnN8xr1PzLN3G+cVf2tJbGQ2TA7FyWoCC?=
 =?us-ascii?Q?3JPTfjAgddifLDWFQ65joIG9p0tV/shwmZVrDEkJY5sIgBFIqyz/i4+Lrla9?=
 =?us-ascii?Q?J+nRHiHtxlnRDfWuw6dp2OJofpxBo2l2eSmNvEbGwmaEDvhq6+OnMQKaXRN8?=
 =?us-ascii?Q?wo+rWo/RSdApzJ7dZFpgZ/92CEFNDpdcPQ/5BiMbtTqfzVgQ+w13o1cNg1lJ?=
 =?us-ascii?Q?ci015RdL7QDWZ/XMnHJHuVbM5M3DKth6Ou/1GZhnltD6it19j2pRQY6wclsm?=
 =?us-ascii?Q?OQbagWuS0s82ZLS/F+0Zy5e52noa6/8aqmUZNKW/ESsFDhN1oV/EFRjQYhtd?=
 =?us-ascii?Q?Ec+VQNvNqcLLesSFvdyEsNOxaewhmRBICc6aRHfLdscN7XIEY5M4Vftgslvi?=
 =?us-ascii?Q?+OhoC13yZ6g8h3I86BCRZaO7j+N5lEyIQZUkiGIwuWkL02ni8itvPHd9ZybG?=
 =?us-ascii?Q?8yB+KFhSCy1Eo7Y5/Xk884wHBcPvlioO7dnLCBF3tuAs2M1a1hP+YxBcz9Rr?=
 =?us-ascii?Q?tucI+qMbiVTBEkAPSLz7Hi9b21OihmPfqlpcRKCxnrnGWVVD3DD3zXsFHASb?=
 =?us-ascii?Q?XvB+Yx1V1/NxCL89/aG3L9MU3F7KM3ErM67TpU5smCKudLeUwG2BSsuCw7IO?=
 =?us-ascii?Q?pFGp7JGYHVJt/JfVfCMtyNYEX6RZzkczA/Xs7Vi5bnl1Od7S51M5+2C1SAkK?=
 =?us-ascii?Q?YqVxE1DhalA+DAJ690fw+unZiBYpca/nrmQZBDM9SFJLHHUfnXhlI4wdAOAv?=
 =?us-ascii?Q?Yz2BVjXzE2QqDy0WBNqTBhDLkxTOMsSar71qwPNX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac5b80d-ef4a-4066-7485-08db24745c43
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 10:10:38.8444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bew7Unotvncgu23kz1Pms0Nm5LNpBrNyLaVzT+l4UO4Zf/AL5b7QZUH/zdUjEQJwzmOjnBl43Yi0sjD8s0fQ+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7841
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enable encoding 12-bit extended jpeg

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c |  14 +-
 .../media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h |   4 +-
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 172 +++++++++++++++++-
 3 files changed, 175 insertions(+), 15 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
index bbd5d6a9fc86..9a6e8b332e12 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
@@ -97,25 +97,31 @@ void mxc_jpeg_sw_reset(void __iomem *reg)
 	writel(GLB_CTRL_SFT_RST, reg + GLB_CTRL);
 }
 
-void mxc_jpeg_enc_mode_conf(struct device *dev, void __iomem *reg)
+void mxc_jpeg_enc_mode_conf(struct device *dev, void __iomem *reg, u8 extseq)
 {
 	dev_dbg(dev, "CAST Encoder CONFIG...\n");
 	/*
 	 * "Config_Mode" enabled, "Config_Mode auto clear enabled",
 	 */
-	writel(0xa0, reg + CAST_MODE);
+	if (extseq)
+		writel(0xb0, reg + CAST_MODE);
+	else
+		writel(0xa0, reg + CAST_MODE);
 
 	/* all markers and segments */
 	writel(0x3ff, reg + CAST_CFG_MODE);
 }
 
-void mxc_jpeg_enc_mode_go(struct device *dev, void __iomem *reg)
+void mxc_jpeg_enc_mode_go(struct device *dev, void __iomem *reg, u8 extseq)
 {
 	dev_dbg(dev, "CAST Encoder GO...\n");
 	/*
 	 * "GO" enabled, "GO bit auto clear" enabled
 	 */
-	writel(0x140, reg + CAST_MODE);
+	if (extseq)
+		writel(0x150, reg + CAST_MODE);
+	else
+		writel(0x140, reg + CAST_MODE);
 }
 
 void mxc_jpeg_enc_set_quality(struct device *dev, void __iomem *reg, u8 quality)
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
index 8b7cd6526efd..ed15ea348f97 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
@@ -117,8 +117,8 @@ void print_wrapper_info(struct device *dev, void __iomem *reg);
 void mxc_jpeg_sw_reset(void __iomem *reg);
 int mxc_jpeg_enable(void __iomem *reg);
 void wait_frmdone(struct device *dev, void __iomem *reg);
-void mxc_jpeg_enc_mode_conf(struct device *dev, void __iomem *reg);
-void mxc_jpeg_enc_mode_go(struct device *dev, void __iomem *reg);
+void mxc_jpeg_enc_mode_conf(struct device *dev, void __iomem *reg, u8 extseq);
+void mxc_jpeg_enc_mode_go(struct device *dev, void __iomem *reg, u8 extseq);
 void mxc_jpeg_enc_set_quality(struct device *dev, void __iomem *reg, u8 quality);
 void mxc_jpeg_dec_mode_go(struct device *dev, void __iomem *reg);
 int mxc_jpeg_get_slot(void __iomem *reg);
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 74ecc5415aa6..1bf24bf3257d 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -322,6 +322,45 @@ static const unsigned char jpeg_dqt[] = {
 	0x63, 0x63, 0x63, 0x63, 0x63, 0x63
 };
 
+static const unsigned char jpeg_dqt_extseq[] = {
+	0xFF, 0xDB,
+	0x01, 0x04,
+	0x10,
+	0x00, 0x80, 0x00, 0x58, 0x00, 0x60, 0x00, 0x70,
+	0x00, 0x60, 0x00, 0x50, 0x00, 0x80, 0x00, 0x70,
+	0x00, 0x68, 0x00, 0x70, 0x00, 0x90, 0x00, 0x88,
+	0x00, 0x80, 0x00, 0x98, 0x00, 0xC0, 0x01, 0x40,
+	0x00, 0xD0, 0x00, 0xC0, 0x00, 0xB0, 0x00, 0xB0,
+	0x00, 0xC0, 0x01, 0x88, 0x01, 0x18, 0x01, 0x28,
+	0x00, 0xE8, 0x01, 0x40, 0x01, 0xD0, 0x01, 0x98,
+	0x01, 0xE8, 0x01, 0xE0, 0x01, 0xC8, 0x01, 0x98,
+	0x01, 0xC0, 0x01, 0xB8, 0x02, 0x00, 0x02, 0x40,
+	0x02, 0xE0, 0x02, 0x70, 0x02, 0x00, 0x02, 0x20,
+	0x02, 0xB8, 0x02, 0x28, 0x01, 0xB8, 0x01, 0xC0,
+	0x02, 0x80, 0x03, 0x68, 0x02, 0x88, 0x02, 0xB8,
+	0x02, 0xF8, 0x03, 0x10, 0x03, 0x38, 0x03, 0x40,
+	0x03, 0x38, 0x01, 0xF0, 0x02, 0x68, 0x03, 0x88,
+	0x03, 0xC8, 0x03, 0x80, 0x03, 0x20, 0x03, 0xC0,
+	0x02, 0xE0, 0x03, 0x28, 0x03, 0x38, 0x03, 0x18,
+	0x11,
+	0x00, 0x88, 0x00, 0x90, 0x00, 0x90, 0x00, 0xC0,
+	0x00, 0xA8, 0x00, 0xC0, 0x01, 0x78, 0x00, 0xD0,
+	0x00, 0xD0, 0x01, 0x78, 0x03, 0x18, 0x02, 0x10,
+	0x01, 0xC0, 0x02, 0x10, 0x03, 0x18, 0x03, 0x18,
+	0x03, 0x18, 0x03, 0x18, 0x03, 0x18, 0x03, 0x18,
+	0x03, 0x18, 0x03, 0x18, 0x03, 0x18, 0x03, 0x18,
+	0x03, 0x18, 0x03, 0x18, 0x03, 0x18, 0x03, 0x18,
+	0x03, 0x18, 0x03, 0x18, 0x03, 0x18, 0x03, 0x18,
+	0x03, 0x18, 0x03, 0x18, 0x03, 0x18, 0x03, 0x18,
+	0x03, 0x18, 0x03, 0x18, 0x03, 0x18, 0x03, 0x18,
+	0x03, 0x18, 0x03, 0x18, 0x03, 0x18, 0x03, 0x18,
+	0x03, 0x18, 0x03, 0x18, 0x03, 0x18, 0x03, 0x18,
+	0x03, 0x18, 0x03, 0x18, 0x03, 0x18, 0x03, 0x18,
+	0x03, 0x18, 0x03, 0x18, 0x03, 0x18, 0x03, 0x18,
+	0x03, 0x18, 0x03, 0x18, 0x03, 0x18, 0x03, 0x18,
+	0x03, 0x18, 0x03, 0x18, 0x03, 0x18, 0x03, 0x18,
+};
+
 static const unsigned char jpeg_sof_maximal[] = {
 	0xFF, 0xC0,
 	0x00, 0x14, 0x08, 0x00, 0x40, 0x00, 0x40,
@@ -329,6 +368,13 @@ static const unsigned char jpeg_sof_maximal[] = {
 	0x03, 0x11, 0x01, 0x04, 0x11, 0x01
 };
 
+static const unsigned char jpeg_sof_extseq[] = {
+	0xFF, 0xC1,
+	0x00, 0x14, 0x08, 0x00, 0x40, 0x00, 0x40,
+	0x04, 0x01, 0x11, 0x00, 0x02, 0x11, 0x01,
+	0x03, 0x11, 0x01, 0x04, 0x11, 0x01
+};
+
 static const unsigned char jpeg_dht[] = {
 	0xFF, 0xC4,
 	0x01, 0xA2, 0x00, 0x00, 0x01, 0x05, 0x01,
@@ -393,6 +439,90 @@ static const unsigned char jpeg_dht[] = {
 	0xF6, 0xF7, 0xF8, 0xF9, 0xFA
 };
 
+static const unsigned char jpeg_dht_extseq[] = {
+	0xFF, 0xC4,
+	0x02, 0x2a, 0x00, 0x00, 0x01, 0x05, 0x01,
+	0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
+	0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x01,
+	0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+	0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
+	0x10, 0x00, 0x02, 0x01, 0x03, 0x03, 0x02,
+	0x04, 0x03, 0x05, 0x05, 0x02, 0x03, 0x02,
+	0x00, 0x00, 0xbf, 0x01, 0x02, 0x03, 0x00,
+	0x04, 0x11, 0x05, 0x12, 0x21, 0x31, 0x41,
+	0x06, 0x13, 0x51, 0x61, 0x07, 0x22, 0x71,
+	0x14, 0x32, 0x81, 0x91, 0xa1, 0x08, 0x23,
+	0x42, 0xb1, 0xc1, 0x15, 0x52, 0xd1, 0xf0,
+	0x24, 0x33, 0x62, 0x72, 0x82, 0x09, 0x0a,
+	0x16, 0x17, 0x18, 0x19, 0x1a, 0x25, 0x26,
+	0x27, 0x28, 0x29, 0x2a, 0x34, 0x35, 0x36,
+	0x37, 0x38, 0x39, 0x3a, 0x43, 0x44, 0x45,
+	0x46, 0x47, 0x48, 0x49, 0x4a, 0x53, 0x54,
+	0x55, 0x56, 0x57, 0x58, 0x59, 0x5a, 0x63,
+	0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6a,
+	0x73, 0x74, 0x75, 0x76, 0x77, 0x78, 0x79,
+	0x7a, 0x83, 0x84, 0x85, 0x86, 0x87, 0x88,
+	0x89, 0x8a, 0x92, 0x93, 0x94, 0x95, 0x96,
+	0x97, 0x98, 0x99, 0x9a, 0xa2, 0xa3, 0xa4,
+	0xa5, 0xa6, 0xa7, 0xa8, 0xa9, 0xaa, 0xb2,
+	0xb3, 0xb4, 0xb5, 0xb6, 0xb7, 0xb8, 0xb9,
+	0xba, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc7,
+	0xc8, 0xc9, 0xca, 0xd2, 0xd3, 0xd4, 0xd5,
+	0xd6, 0xd7, 0xd8, 0xd9, 0xda, 0xe1, 0xe2,
+	0xe3, 0xe4, 0xe5, 0xe6, 0xe7, 0xe8, 0xe9,
+	0xea, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6,
+	0xf7, 0xf8, 0xf9, 0xfa, 0x0b, 0x0c, 0x0d,
+	0x0e, 0x1b, 0x1c, 0x1d, 0x1e, 0x2b, 0x2c,
+	0x2d, 0x2e, 0x3b, 0x3c, 0x3d, 0x3e, 0x4b,
+	0x4c, 0x4d, 0x4e, 0x5b, 0x5c, 0x5d, 0x5e,
+	0x6b, 0x6c, 0x6d, 0x6e, 0x7b, 0x7c, 0x7d,
+	0x7e, 0x8b, 0x8c, 0x8d, 0x8e, 0x9b, 0x9c,
+	0x9d, 0x9e, 0xab, 0xac, 0xad, 0xae, 0xbb,
+	0xbc, 0xbd, 0xbe, 0xcb, 0xcc, 0xcd, 0xce,
+	0xdb, 0xdc, 0xdd, 0xde, 0xeb, 0xec, 0xed,
+	0xee, 0xfb, 0xfc, 0xfd, 0xfe, 0x01, 0x00,
+	0x01, 0x05, 0x01, 0x01, 0x01, 0x01, 0x01,
+	0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00,
+	0x00, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05,
+	0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c,
+	0x0d, 0x0e, 0x0f, 0x11, 0x00, 0x02, 0x01,
+	0x03, 0x03, 0x02, 0x04, 0x03, 0x05, 0x05,
+	0x02, 0x03, 0x02, 0x00, 0x00, 0xbf, 0x01,
+	0x02, 0x03, 0x00, 0x04, 0x11, 0x05, 0x12,
+	0x21, 0x31, 0x41, 0x06, 0x13, 0x51, 0x61,
+	0x07, 0x22, 0x71, 0x14, 0x32, 0x81, 0x91,
+	0xa1, 0x08, 0x23, 0x42, 0xb1, 0xc1, 0x15,
+	0x52, 0xd1, 0xf0, 0x24, 0x33, 0x62, 0x72,
+	0x82, 0x09, 0x0a, 0x16, 0x17, 0x18, 0x19,
+	0x1a, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2a,
+	0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3a,
+	0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49,
+	0x4a, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58,
+	0x59, 0x5a, 0x63, 0x64, 0x65, 0x66, 0x67,
+	0x68, 0x69, 0x6a, 0x73, 0x74, 0x75, 0x76,
+	0x77, 0x78, 0x79, 0x7a, 0x83, 0x84, 0x85,
+	0x86, 0x87, 0x88, 0x89, 0x8a, 0x92, 0x93,
+	0x94, 0x95, 0x96, 0x97, 0x98, 0x99, 0x9a,
+	0xa2, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7, 0xa8,
+	0xa9, 0xaa, 0xb2, 0xb3, 0xb4, 0xb5, 0xb6,
+	0xb7, 0xb8, 0xb9, 0xba, 0xc2, 0xc3, 0xc4,
+	0xc5, 0xc6, 0xc7, 0xc8, 0xc9, 0xca, 0xd2,
+	0xd3, 0xd4, 0xd5, 0xd6, 0xd7, 0xd8, 0xd9,
+	0xda, 0xe1, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6,
+	0xe7, 0xe8, 0xe9, 0xea, 0xf1, 0xf2, 0xf3,
+	0xf4, 0xf5, 0xf6, 0xf7, 0xf8, 0xf9, 0xfa,
+	0x0b, 0x0c, 0x0d, 0x0e, 0x1b, 0x1c, 0x1d,
+	0x1e, 0x2b, 0x2c, 0x2d, 0x2e, 0x3b, 0x3c,
+	0x3d, 0x3e, 0x4b, 0x4c, 0x4d, 0x4e, 0x5b,
+	0x5c, 0x5d, 0x5e, 0x6b, 0x6c, 0x6d, 0x6e,
+	0x7b, 0x7c, 0x7d, 0x7e, 0x8b, 0x8c, 0x8d,
+	0x8e, 0x9b, 0x9c, 0x9d, 0x9e, 0xab, 0xac,
+	0xad, 0xae, 0xbb, 0xbc, 0xbd, 0xbe, 0xcb,
+	0xcc, 0xcd, 0xce, 0xdb, 0xdc, 0xdd, 0xde,
+	0xeb, 0xec, 0xed, 0xee, 0xfb, 0xfc, 0xfd,
+	0xfe,
+};
+
 static const unsigned char jpeg_dri[] = {
 	0xFF, 0xDD,
 	0x00, 0x04, 0x00, 0x20
@@ -802,7 +932,8 @@ static irqreturn_t mxc_jpeg_dec_irq(int irq, void *priv)
 	if (dec_ret & SLOT_STATUS_ENC_CONFIG_ERR) {
 		u32 ret = readl(reg + CAST_STATUS12);
 
-		dev_err(dev, "Encoder/decoder error, status=0x%08x", ret);
+		dev_err(dev, "Encoder/decoder error, dec_ret = 0x%08x, status=0x%08x",
+			dec_ret, ret);
 		mxc_jpeg_clr_desc(reg, slot);
 		mxc_jpeg_sw_reset(reg);
 		buf_state = VB2_BUF_STATE_ERROR;
@@ -814,10 +945,11 @@ static irqreturn_t mxc_jpeg_dec_irq(int irq, void *priv)
 
 	if (jpeg->mode == MXC_JPEG_ENCODE &&
 	    ctx->enc_state == MXC_JPEG_ENC_CONF) {
+		q_data = mxc_jpeg_get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE);
 		ctx->enc_state = MXC_JPEG_ENCODING;
 		dev_dbg(dev, "Encoder config finished. Start encoding...\n");
 		mxc_jpeg_enc_set_quality(dev, reg, ctx->jpeg_quality);
-		mxc_jpeg_enc_mode_go(dev, reg);
+		mxc_jpeg_enc_mode_go(dev, reg, mxc_jpeg_is_extended_sequential(q_data->fmt));
 		goto job_unlock;
 	}
 	if (jpeg->mode == MXC_JPEG_DECODE && jpeg_src_buf->dht_needed) {
@@ -868,8 +1000,12 @@ static int mxc_jpeg_fixup_sof(struct mxc_jpeg_sof *sof,
 			      u16 w, u16 h)
 {
 	int sof_length;
+	const struct mxc_jpeg_fmt *fmt = mxc_jpeg_find_format(fourcc);
 
-	sof->precision = 8; /* TODO allow 8/12 bit precision*/
+	if (fmt)
+		sof->precision = fmt->precision;
+	else
+		sof->precision = 8; /* TODO allow 8/12 bit precision*/
 	sof->height = h;
 	_bswap16(&sof->height);
 	sof->width = w;
@@ -988,16 +1124,28 @@ static unsigned int mxc_jpeg_setup_cfg_stream(void *cfg_stream_vaddr,
 		offset += sizeof(jpeg_app0);
 	}
 
-	memcpy(cfg + offset, jpeg_dqt, sizeof(jpeg_dqt));
-	offset += sizeof(jpeg_dqt);
+	if (mxc_jpeg_is_extended_sequential(fmt)) {
+		memcpy(cfg + offset, jpeg_dqt_extseq, sizeof(jpeg_dqt_extseq));
+		offset += sizeof(jpeg_dqt_extseq);
+
+		memcpy(cfg + offset, jpeg_sof_extseq, sizeof(jpeg_sof_extseq));
+	} else {
+		memcpy(cfg + offset, jpeg_dqt, sizeof(jpeg_dqt));
+		offset += sizeof(jpeg_dqt);
 
-	memcpy(cfg + offset, jpeg_sof_maximal, sizeof(jpeg_sof_maximal));
+		memcpy(cfg + offset, jpeg_sof_maximal, sizeof(jpeg_sof_maximal));
+	}
 	offset += 2; /* skip marker ID */
 	sof = (struct mxc_jpeg_sof *)(cfg + offset);
 	offset += mxc_jpeg_fixup_sof(sof, fourcc, w, h);
 
-	memcpy(cfg + offset, jpeg_dht, sizeof(jpeg_dht));
-	offset += sizeof(jpeg_dht);
+	if (mxc_jpeg_is_extended_sequential(fmt)) {
+		memcpy(cfg + offset, jpeg_dht_extseq, sizeof(jpeg_dht_extseq));
+		offset += sizeof(jpeg_dht_extseq);
+	} else {
+		memcpy(cfg + offset, jpeg_dht, sizeof(jpeg_dht));
+		offset += sizeof(jpeg_dht);
+	}
 
 	memcpy(cfg + offset, jpeg_dri, sizeof(jpeg_dri));
 	offset += sizeof(jpeg_dri);
@@ -1138,6 +1286,10 @@ static void mxc_jpeg_config_enc_desc(struct vb2_buffer *out_buf,
 	desc->stm_ctrl = STM_CTRL_CONFIG_MOD(0) |
 			 STM_CTRL_IMAGE_FORMAT(img_fmt);
 	desc->stm_ctrl |= STM_CTRL_BITBUF_PTR_CLR(1);
+	if (mxc_jpeg_is_extended_sequential(q_data->fmt))
+		desc->stm_ctrl |= STM_CTRL_PIXEL_PRECISION;
+	else
+		desc->stm_ctrl &= ~STM_CTRL_PIXEL_PRECISION;
 	mxc_jpeg_addrs(desc, src_buf, dst_buf, 0);
 	dev_dbg(jpeg->dev, "cfg_desc:\n");
 	print_descriptor_info(jpeg->dev, cfg_desc);
@@ -1338,7 +1490,9 @@ static void mxc_jpeg_device_run(void *priv)
 		ctx->enc_state = MXC_JPEG_ENC_CONF;
 		mxc_jpeg_config_enc_desc(&dst_buf->vb2_buf, ctx,
 					 &src_buf->vb2_buf, &dst_buf->vb2_buf);
-		mxc_jpeg_enc_mode_conf(dev, reg); /* start config phase */
+		/* start config phase */
+		mxc_jpeg_enc_mode_conf(dev, reg,
+				       mxc_jpeg_is_extended_sequential(q_data_out->fmt));
 	} else {
 		dev_dbg(dev, "Decoding on slot %d\n", ctx->slot);
 		print_mxc_buf(jpeg, &src_buf->vb2_buf, 0);
-- 
2.38.1

