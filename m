Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2A0685F83
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 07:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbjBAGEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 01:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjBAGEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 01:04:40 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2041.outbound.protection.outlook.com [40.107.249.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA345CFC0;
        Tue, 31 Jan 2023 22:04:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3uH0BBauGOeJnZmmAN4gXWsVE7lL/Fz5BoF2QIRdOz38iw3Wf0cQBUIOTHdZ8HlF2ejBGtvCxVZy/gDCYUawZxGZ95v+WeqnBTdSOvTrfjeec6l2ocHLMmY0MmwFXFSaCay2te39CWnUw0ZxZ5yjngfJWAD/shuBatCC30e56Mcdccyn8daxppApltFPQt1XpFutVmLgusBigHY7WfvaPsHL9JBRGtg7e5+eWSaBfIiokBNw1xDOS58Sqm/1f76iAEpnBi5oxWn5VQyYJOz6IdXpKwC00YTsGaderi6PiiJKGTBCqVESX/0gi/Qh8SCp1tgyALyo0CWyyInY2rRrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZ2LXMJuZO+HHc137IjW94mxEk1lL8Xi4srJtfgS/i4=;
 b=LZD9MCuy38tQ5gkasFf7ncA+F/nTStdocj1G9M2TwtXNNWd4AjU4ac31gj5j+JGFGTvpvgp96UcFH4N+z/sKkpMc9oFXVy3mpyhj+2s/gVFkTxQFN29eM3GnbSB8J4ItLYla1sbGyIIjX7IVxYaGNt/79HWsD2ivIli6hLzOK2K5EcfcmytRJQUr3Z3MW+aZsj/6OmfcL7RUC+7Z02HCtqXGO+V0PiWLQuJ2CXpkkN2Yt7hsUayVFQnYT6TB8ksadn40khD59L9iXNDeloz+C/WZ/Y/2hScEsq17rrWk+PHY0OoJ+fyJmEPIrA3V2FE5gvUelOr++l5sKOYhpr8M9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZ2LXMJuZO+HHc137IjW94mxEk1lL8Xi4srJtfgS/i4=;
 b=ZXh7QfuTwqHFneG2e1GMPQKhl+vkZUe9Unz5EKbgN9+j0vqPUiVNL7pKpprRx/9pwd5I24pHd+uIUcvgqBRvLjuWTh4MAUlw8z7jw03Ge7CJTKiBe/fGVIwEygEraq/eKFBljBb/83lgPeczkADQdYqTBZBApxswdlCySGqIjBU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 06:03:57 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6043.036; Wed, 1 Feb 2023
 06:03:57 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 10/10] media: imx-jpeg: Encoder add support for 12bit jpeg
Date:   Wed,  1 Feb 2023 14:02:32 +0800
Message-Id: <d9d428e98b13d0850feda3049615726cdf806e78.1675230665.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1675230665.git.ming.qian@nxp.com>
References: <cover.1675230665.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|DB9PR04MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: 52671d98-9613-4bb6-878f-08db041a1af9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ong+Eyi415gN+ci0PJcSl9MI+1Zu+yNzL1YUBSloKX7bLvcL9fr57ylxza/g7x6IR4FIqxbbk1cOmN40xIvutfydKcY0Leeob03nHw7Px26/ovkUIVhHBMETu5WZWzdGJyaY1lQrpk9Bggk3qT6UkLvyMDmVpzNJWxrPvoxnHyfT3k5HldsUvbgHVHP/+wXGU5PxRPlGOoaReU2xc9rW9+kg+ql01U8nWvnx73KxTVmEAuc9wxoo+TZsxCF3picHCCilzX5yJ/n5pk5+9f0p2BkNQxwdwuNcWhoohUTxBbHN2PI9C+oNhrxPeu/g0nEOvRaq5SwLskL0G4CwqYnIxbCDax4ezOKfALekJlI3YAW1IRrhSYIZGdcePKn8tv9hHkpvDGOUekYlkjQdIbQMbzGe80iR2eoBMHDWdsIdqXBNEUFpdListCclITiv5KtypMfIbkdp94l0mWSUKN0xnVrCicP9hAxhytJ5R4Ay0r6thdt9lxzkJFaOX2l6ivfxTcPaAcIDcR/ZKachxEDYN11XWAavoEV8HXaWwmSs7KFyoVPqZjxmWJHIT+kBHd+/XjmvIzpYbHU81dAVLjhwennOR0ALt3o86Im8CmSCtSa8/QM+DhGQ5trNaiYGryVI4cdYbWB0EHN0v2EQgBQZKX71Uge2VyV+qUSvbwj29B9eIErQxcCP8XOKjwUckhzjsCObxtC402tFiWnCh4OzuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199018)(38100700002)(52116002)(2616005)(38350700002)(36756003)(30864003)(7416002)(8936002)(86362001)(5660300002)(44832011)(316002)(41300700001)(2906002)(83380400001)(6506007)(6512007)(8676002)(4326008)(186003)(26005)(478600001)(66476007)(66556008)(6666004)(6486002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tHfpgfiEUzNNCggGuyD3a5h+j9EOycI1f2qdAtoDaH4IubLQ8B24igXS2XeU?=
 =?us-ascii?Q?WnTboOfHZx4xibT2F3P172cJpypynHYchQouhNaeENl6CVuME4w1qz6HvI2S?=
 =?us-ascii?Q?aBEyeHZACa9ksEJlmOi7N82sLpuXFb43FeUIxIOQ4f7pMxjYEPtH7B7cwaaF?=
 =?us-ascii?Q?yAgO1vgjNZzh25MP201ubBgcIIn8D4EP48ONo7ZtZ2SLnpYEGr0x0y2Phx34?=
 =?us-ascii?Q?8kcr+5CypNfkV0g6q7FpP16XGpQ4EGVE1F6gb7jc67vhH5+4B9CpYK5iNTo4?=
 =?us-ascii?Q?yuY49UrWWCHfcyrDFxYTwI/4p3P0jiCVyJPJAECSUHzELOA638GsvMxZAfuf?=
 =?us-ascii?Q?7eLnKss3CDuxdneSS8Efb/rI3nz48OECBU3HjmBfBlpzdi3vSiJP6n821udH?=
 =?us-ascii?Q?TTILVTVumFfDiO4Ilh2RcsCPKIkzJTGfcjpBXkAjwISuL3B39qlP2L16BLTS?=
 =?us-ascii?Q?CVUrKGpOZ9Tv265UJ51tIJvZ05tYbPeQFlo/iGmdHNY5gd7Bfmm9ySzpz8qY?=
 =?us-ascii?Q?bNwoTxoHvTtk4uRJMfBRACXl0gectdHGrI7g47q4ZPYZOvd5OXXvTqIQc4Ok?=
 =?us-ascii?Q?J4Dyv4CbHnyjAoh+6TnwLq8mkTPIoNCXlzLsdU7e8yS9FcNCtfeRWdrn94TO?=
 =?us-ascii?Q?L6lMtHeigiVq5WH78VPe+iFi3ycPyj/+1sFLDgZzdhCxfK60zcIHkbGkWeWf?=
 =?us-ascii?Q?gGcPhr6CPcXPlgW47gGhq/R22Gzmq2kr5FM4bTm0NvCmLUhJkiXzhMSTpGZL?=
 =?us-ascii?Q?vD0HCDZZDscJGIC1Tv6l/CcqE2H32nq0bSxkCZGyOfjuTKUlNgo9fT0b1oI/?=
 =?us-ascii?Q?wmz8XXDS8F5bhqDaIOSD3ZOxj8vuAGPJPEox/9cnTaOz2tno2ON9Qjdshcqk?=
 =?us-ascii?Q?I+uDaYWtYmNxpMGa3IdHmEo4vbOnCrT2OWiT2pAPAprMi860KpZEnyt10iux?=
 =?us-ascii?Q?yEBTJdVzZAs07vdlEW1T/3ZmbzT3Bw8UADMs0WB3/CPHtK9KAwyibTw84wGF?=
 =?us-ascii?Q?622LXJBnQkjoVrv6hGjXOum9VQyyLRS4kSPSIYq9ptvNOp+85fpSt1ccOpxr?=
 =?us-ascii?Q?r4GAHI2dCMG6Y+urHrkcB3T3XDcn2VVwzc+NC6INxVl06S7nfrey6e3+WooZ?=
 =?us-ascii?Q?7WCI/DxMUTIN9M85mP4LmwbDM6+sRvKXpbd29n4VCT3gUQXNjeA0HyUfK0lL?=
 =?us-ascii?Q?cFd2uDh7Iz/oXJFeVTqhmSwerCZ8V1umSwbNzDQWqIw2p55KMHzdIIHUMTd1?=
 =?us-ascii?Q?wMqk2d7vR6aQ4b3hiQqIycr5I5jBwoorWwjXolgSJU8V34XVgG4s+yfiAB3W?=
 =?us-ascii?Q?hjPHmTf7exQPxVWN04BbvHixdE/zcDfxjA3WGqa7a6/iRCmZRe6VkYf18SiW?=
 =?us-ascii?Q?10RItMuNNzYZaNgOnoaoX8x2iQ7u8T2zZip/P4MvRbMY9OzWfUS0dvfI3Whs?=
 =?us-ascii?Q?8+JYirj2jb191D8bUCt26f/WUMAc+hAv9Zut/denicXC10mFIAQ8Qs1OUu7E?=
 =?us-ascii?Q?DasMW2dbpeDWkbyEP1clJ8PVK5wgQf8guSXsBmlJ70U0NEFM10HKo1gkqfiS?=
 =?us-ascii?Q?S/iak/RPoNdVukHF1Eu+qccAygrpC5rz1JeC34hU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52671d98-9613-4bb6-878f-08db041a1af9
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 06:03:57.4091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O+JR/ELDLr6ZUhre1xF6T9nJR3OTak+GjsPwLNfgu9u88idlM86YNNHqD1g1H+7WxoWfrg3BSX1PM8y7KkMx0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
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
index d493fddf114c..289d8c62b61e 100644
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

