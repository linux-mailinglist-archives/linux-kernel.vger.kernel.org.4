Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10B4715675
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjE3HS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjE3HSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:18:40 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2070.outbound.protection.outlook.com [40.107.247.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF491B4;
        Tue, 30 May 2023 00:17:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ub3osgusWAuVSpepBCVvWLfMB2I+LJSsDVf/Y+sEg6+Ar7803/14UWm/j86LEUO9EvASt52iaKgyselk3qwAX2Vs4G+8Yl7XAYvP1kGeGF4IX3jeArhxfWU6RiN2lbW1PXntlNYK1LZAx1/HEw5Lt3FPyKlPkzYohWp72nwnwFuFG+nswoMjnL3hV0cqWKw9U5kHD+I6oFv8/ieDzxQmK3SbQFNLq9C/fRXr7ezojVRk4tDHT7ZMRO53JQynyFEipsvKLNTpIYfOf5g2SPWQD5KA8Q00CmgUrWES2PvHA+fvbn7vpB4b6WY5znRJEfhUak6oOnKMbMgut5mp37aO3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Di2BlG93WL6wVUOJsXBpvYUaQ3MX6fol2V7Wft25wQI=;
 b=XMs+FiV8FFiAW8IbrMwPwbwHlGvsreVO3hz1BTp+nvUvBe11CUmepYQyNDqoDtdsenyPCYVKCWlv584tKJ0YqurB+VUrnVu9XUTsly53eaQzQkbkBFjOFhKxbpvbjvoGUjY6CPc8PAD4YTAwEIh71MT8B+qpabqkTMI1cb7Lh95EaTYhAfTXXSiL+o7souxw+0zOBA1VGa+A3nSEEn7NToLm/r9PRy+IE87jUGzIk03/jxSWVrjPr3wL/Mdt6uxqWdWpPmPOIuP3QsA5EhJEnfzOINrFdupZJZecWp2sp09B7ViHylbmCRUMWDjNFuA5uN+7QVESbX2LisdZwmlI9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Di2BlG93WL6wVUOJsXBpvYUaQ3MX6fol2V7Wft25wQI=;
 b=aaHJb4YBoGe8T7UzWiHJX2lfmD3Blaibo3RFCl17yZ+ivb+Jk2PcVQ9XItsLiCerzznBzl8mVjohQGNKVf9JPSteeqGSbhTVPvtQ1MXSW68H2rkVejrxqv3ksqQ/3m4EYC5aHEqzsikaa3/1vsoa0cn5JQT5oFdYiu+pqwNza/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB9PR04MB8496.eurprd04.prod.outlook.com (2603:10a6:10:2c8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 07:17:23 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::79f2:2888:dbd7:ad6f]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::79f2:2888:dbd7:ad6f%7]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 07:17:23 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] media: imx-jpeg: Support to assign slot for encoder/decoder
Date:   Tue, 30 May 2023 15:16:30 +0800
Message-Id: <cdadb4a23697fdc97def958c69b12cd00f547212.1685430841.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:3:17::13) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|DB9PR04MB8496:EE_
X-MS-Office365-Filtering-Correlation-Id: c493b55d-dd3b-4d69-1393-08db60dde9e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3X/JrQjlUtUWaKgutrdNLdr9DxcZh2kaDWdz9GQNIGeyVMvzX+CCxTFkJys4s52JCMbhvGwhDbdOSRZ6ic2LodHfq/LIlEjn5bMQflc4t1p6TQZKAY+NiB61aj7qjXIR+5oE0iK1ykAvqMkuXlkFAYTIaJ5dUpP9x5/pX55HyXoNwso4dYMJ8re7KDbXVJfWU2AYpIRY9nhtruWD7BW7vd7KbLaN1ZHf5Iv0THJCa9uUnxjgBgkP1TdVJMkbE5clOHBNhN+l8MrFKpHmJ8BeuO0D8vRMk7cFl3E1S9TqJe+PJgbZl/r89kDvIgX5C5exrtEhVDbKCwl2Nkjv8XTa71YZVMS+RukrUFbHKeIbPppYvJTkgTRrCedc8rOLJUf+eEkdNzoHZyog5/AE4jIHzqaND2nrejsibSoyJPzrMMZXzIIzy43Eksm2j6Uyo+TVJcxmws5QGm0Idp0bsJY9TywIhDm1aJo6wEpr2ejtG3YvgU444YJNcdWlca8vDLXqeV/bI+BQdqMZeTUElcohtLN68x7anBigPefznJeGrvXpH2Of1xIu9xYbLF+SGsTQWyGJiqlMDnuIlgzglQCPOvbE/K6HKwjOKBC+xTuIydpCN/AaQRc/Fmb2YT+suUBp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199021)(4326008)(66946007)(66556008)(66476007)(86362001)(478600001)(5660300002)(41300700001)(6486002)(52116002)(8676002)(8936002)(7416002)(44832011)(6512007)(316002)(6666004)(26005)(6506007)(186003)(2616005)(83380400001)(2906002)(30864003)(36756003)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AdecdLRaIbIE17Hcgxp6p0ec9xGtC5I7Sz07rnMwkNXBpoa653y4QjfFB1v1?=
 =?us-ascii?Q?qfnGLab79dxNO4YY9lLzR5U7ClAX6i5NImPjesD6fpkG6ctsgTtZxh+6t78J?=
 =?us-ascii?Q?k4Sp826PRItT1Y6FRuNHbzHSsKuOZpCHtBR9g58eldYOdcVX8LYysK5/0X90?=
 =?us-ascii?Q?cqPDTVfQoMKA4yYjeEzgw8zNDk/hyxwFsnwfuYfhivZJ3CqqEd8Cy/Wzhe71?=
 =?us-ascii?Q?ZmqZkVt/+Z7BXY5GMOUI3B6JcLhntJcnyrOu6gnrZg7ae+/MdT6/Hp0WB0Bn?=
 =?us-ascii?Q?5bMrWOLwvpb2Em1HKXDZ3BJCAY7u1Xx7pyM5GrYx1mIt3DwB3QbvWbzVkrby?=
 =?us-ascii?Q?4fIRVa2BOwLl+p4ywQQyARRDCQ5V515xv9yYnFaBUuEcxYYe4B2UH9vRdD0/?=
 =?us-ascii?Q?X3LaBQ1yQBdBLA95pN2BkBLHRgwrzjLpEmZctGPJuoPZ880DTi8lGgRfN1Ai?=
 =?us-ascii?Q?UFQT7LiBraUTM46mhWTcdL94/6wpWhR4sDsLbNhmdViG+Dszxojwrj9hoJUV?=
 =?us-ascii?Q?yVVxk/dBkuJci1uoow3L+kiIMT0mxgJK0vXciIZe2HJzVKOyRn56Rn61hUzS?=
 =?us-ascii?Q?h4NWhA5M93zcU5R6xCWOy+gZH7kolXiCD4AtLoLheDjsy0D3faDwxutovXQf?=
 =?us-ascii?Q?HBd3cxOT96g7AbXDzs5OGe6Wqvyq0Xas6dxrJCuoTC8aQ4RoGmM3sO3Mhq+P?=
 =?us-ascii?Q?IUsQZIGMCUjxloh7NhMfCxco2KZKY9fVWs6bgKtIHiUJTqapJvLyqdSIFLXF?=
 =?us-ascii?Q?aXFg8OK69kkq5tqEq80Xw/wl5Tj4PKKZzpuitZ8nsxW7wCsuOsUhMA5k2mtH?=
 =?us-ascii?Q?OmfKyxlmbPQbr0qkQeJs8YJKjL5cNalwmm60y0kymp9PvTqGaanpUnWO/2+Z?=
 =?us-ascii?Q?IMQrdebGOx6d5o9Foae7mbg1HyepWeA/U3UY79U61dbkrtTxCoDONsDzmQ0y?=
 =?us-ascii?Q?scONbvRgo8kAj8LligLly+o3d59lOBEN5pIURAS7TsG3Kh6+QI8HuEeDcsaP?=
 =?us-ascii?Q?6qFOpIj7cOLtp0FiQwI44DG1DCp7gu6v2IXd4Ga3pRna6opW0i9303NYoIpr?=
 =?us-ascii?Q?SSQsv7vwDzo/ASfaJVmTSqauN4PAOMyLbAk+bohtPUouS863bcJg4j6mO2wD?=
 =?us-ascii?Q?h9LEbTYpCazf87p+SXyAUMYMpQytUcLiHTis4pF1buT9U0FT9N8I1js2R7Uc?=
 =?us-ascii?Q?bECAAvyl3pGtVDn2hxuwriQejclg6jG9j4w7F/yE63gMHn2GmCuWZQER1rXu?=
 =?us-ascii?Q?ZpWrl2pH5aQHoL69Mz2qyIBRFf08bKvVStbqQt2mtYCCTzI3vQGui9YNwPmV?=
 =?us-ascii?Q?rbyqxkJUqeFf+vU/gnc7586kVWWaRmXw9AXWNl0QeO3vmEnlRxlM5SH8zTmr?=
 =?us-ascii?Q?GfJ27bEoplpXLA7GRmmz8jU58JjJEkbDQmFM50SoeZtFFSJl3EmCZ6Iz9EGj?=
 =?us-ascii?Q?Jpxb2layTAJRjmG1W+cthoeoj4F4O3Joa3Oi7GRLA4rjHXZtoMdoeptPrjtJ?=
 =?us-ascii?Q?XesU+hPdmMoimKIBgyVK62ub+46D9V+F2uL1tAE9zgzs7Gqc74twQuo0CRf7?=
 =?us-ascii?Q?GY515+WkC+OBBzvhuXYpCSRcOOZq5rcZPp7jioU7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c493b55d-dd3b-4d69-1393-08db60dde9e3
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 07:17:23.4833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XRDFjouxtmmAs/jvlpBp8ewE+qDf1YQcgdbrex/9S3YgtPaYvwkMYAF5JxhOY+ejsdJ8vj7Kmpmt30qtyu1dag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8496
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

imx jpeg encoder and decoder support 4 slots each,
aim to support some virtualization scenarios.

driver should only enable one slot one time.

but due to some hardware issue,
only slot 0 can be enabled in imx8q platform,
and they may be fixed in imx9 platform.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h |   1 -
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 135 +++++++++---------
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.h    |   5 +-
 3 files changed, 68 insertions(+), 73 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
index ed15ea348f97..a2b4fb9e29e7 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
@@ -58,7 +58,6 @@
 #define CAST_OFBSIZE_LO			CAST_STATUS18
 #define CAST_OFBSIZE_HI			CAST_STATUS19
 
-#define MXC_MAX_SLOTS	1 /* TODO use all 4 slots*/
 /* JPEG-Decoder Wrapper Slot Registers 0..3 */
 #define SLOT_BASE			0x10000
 #define SLOT_STATUS			0x0
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index c0e49be42450..9512c0a61966 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -745,87 +745,77 @@ static void notify_src_chg(struct mxc_jpeg_ctx *ctx)
 	v4l2_event_queue_fh(&ctx->fh, &ev);
 }
 
-static int mxc_get_free_slot(struct mxc_jpeg_slot_data slot_data[], int n)
+static int mxc_get_free_slot(struct mxc_jpeg_slot_data *slot_data)
 {
-	int free_slot = 0;
-
-	while (slot_data[free_slot].used && free_slot < n)
-		free_slot++;
-
-	return free_slot; /* >=n when there are no more free slots */
+	if (!slot_data->used)
+		return slot_data->slot;
+	return -1;
 }
 
-static bool mxc_jpeg_alloc_slot_data(struct mxc_jpeg_dev *jpeg,
-				     unsigned int slot)
+static bool mxc_jpeg_alloc_slot_data(struct mxc_jpeg_dev *jpeg)
 {
 	struct mxc_jpeg_desc *desc;
 	struct mxc_jpeg_desc *cfg_desc;
 	void *cfg_stm;
 
-	if (jpeg->slot_data[slot].desc)
+	if (jpeg->slot_data.desc)
 		goto skip_alloc; /* already allocated, reuse it */
 
 	/* allocate descriptor for decoding/encoding phase */
 	desc = dma_alloc_coherent(jpeg->dev,
 				  sizeof(struct mxc_jpeg_desc),
-				  &jpeg->slot_data[slot].desc_handle,
+				  &jpeg->slot_data.desc_handle,
 				  GFP_ATOMIC);
 	if (!desc)
 		goto err;
-	jpeg->slot_data[slot].desc = desc;
+	jpeg->slot_data.desc = desc;
 
 	/* allocate descriptor for configuration phase (encoder only) */
 	cfg_desc = dma_alloc_coherent(jpeg->dev,
 				      sizeof(struct mxc_jpeg_desc),
-				      &jpeg->slot_data[slot].cfg_desc_handle,
+				      &jpeg->slot_data.cfg_desc_handle,
 				      GFP_ATOMIC);
 	if (!cfg_desc)
 		goto err;
-	jpeg->slot_data[slot].cfg_desc = cfg_desc;
+	jpeg->slot_data.cfg_desc = cfg_desc;
 
 	/* allocate configuration stream */
 	cfg_stm = dma_alloc_coherent(jpeg->dev,
 				     MXC_JPEG_MAX_CFG_STREAM,
-				     &jpeg->slot_data[slot].cfg_stream_handle,
+				     &jpeg->slot_data.cfg_stream_handle,
 				     GFP_ATOMIC);
 	if (!cfg_stm)
 		goto err;
-	jpeg->slot_data[slot].cfg_stream_vaddr = cfg_stm;
+	jpeg->slot_data.cfg_stream_vaddr = cfg_stm;
 
 skip_alloc:
-	jpeg->slot_data[slot].used = true;
+	jpeg->slot_data.used = true;
 
 	return true;
 err:
-	dev_err(jpeg->dev, "Could not allocate descriptors for slot %d", slot);
+	dev_err(jpeg->dev, "Could not allocate descriptors for slot %d", jpeg->slot_data.slot);
 
 	return false;
 }
 
-static void mxc_jpeg_free_slot_data(struct mxc_jpeg_dev *jpeg,
-				    unsigned int slot)
+static void mxc_jpeg_free_slot_data(struct mxc_jpeg_dev *jpeg)
 {
-	if (slot >= MXC_MAX_SLOTS) {
-		dev_err(jpeg->dev, "Invalid slot %d, nothing to free.", slot);
-		return;
-	}
-
 	/* free descriptor for decoding/encoding phase */
 	dma_free_coherent(jpeg->dev, sizeof(struct mxc_jpeg_desc),
-			  jpeg->slot_data[slot].desc,
-			  jpeg->slot_data[slot].desc_handle);
+			  jpeg->slot_data.desc,
+			  jpeg->slot_data.desc_handle);
 
 	/* free descriptor for encoder configuration phase / decoder DHT */
 	dma_free_coherent(jpeg->dev, sizeof(struct mxc_jpeg_desc),
-			  jpeg->slot_data[slot].cfg_desc,
-			  jpeg->slot_data[slot].cfg_desc_handle);
+			  jpeg->slot_data.cfg_desc,
+			  jpeg->slot_data.cfg_desc_handle);
 
 	/* free configuration stream */
 	dma_free_coherent(jpeg->dev, MXC_JPEG_MAX_CFG_STREAM,
-			  jpeg->slot_data[slot].cfg_stream_vaddr,
-			  jpeg->slot_data[slot].cfg_stream_handle);
+			  jpeg->slot_data.cfg_stream_vaddr,
+			  jpeg->slot_data.cfg_stream_handle);
 
-	jpeg->slot_data[slot].used = false;
+	jpeg->slot_data.used = false;
 }
 
 static void mxc_jpeg_check_and_set_last_buffer(struct mxc_jpeg_ctx *ctx,
@@ -855,7 +845,7 @@ static void mxc_jpeg_job_finish(struct mxc_jpeg_ctx *ctx, enum vb2_buffer_state
 	v4l2_m2m_buf_done(dst_buf, state);
 
 	mxc_jpeg_disable_irq(reg, ctx->slot);
-	ctx->mxc_jpeg->slot_data[ctx->slot].used = false;
+	jpeg->slot_data.used = false;
 	if (reset)
 		mxc_jpeg_sw_reset(reg);
 }
@@ -919,7 +909,7 @@ static irqreturn_t mxc_jpeg_dec_irq(int irq, void *priv)
 		goto job_unlock;
 	}
 
-	if (!jpeg->slot_data[slot].used)
+	if (!jpeg->slot_data.used)
 		goto job_unlock;
 
 	dec_ret = readl(reg + MXC_SLOT_OFFSET(slot, SLOT_STATUS));
@@ -1179,13 +1169,13 @@ static void mxc_jpeg_config_dec_desc(struct vb2_buffer *out_buf,
 	struct mxc_jpeg_dev *jpeg = ctx->mxc_jpeg;
 	void __iomem *reg = jpeg->base_reg;
 	unsigned int slot = ctx->slot;
-	struct mxc_jpeg_desc *desc = jpeg->slot_data[slot].desc;
-	struct mxc_jpeg_desc *cfg_desc = jpeg->slot_data[slot].cfg_desc;
-	dma_addr_t desc_handle = jpeg->slot_data[slot].desc_handle;
-	dma_addr_t cfg_desc_handle = jpeg->slot_data[slot].cfg_desc_handle;
-	dma_addr_t cfg_stream_handle = jpeg->slot_data[slot].cfg_stream_handle;
-	unsigned int *cfg_size = &jpeg->slot_data[slot].cfg_stream_size;
-	void *cfg_stream_vaddr = jpeg->slot_data[slot].cfg_stream_vaddr;
+	struct mxc_jpeg_desc *desc = jpeg->slot_data.desc;
+	struct mxc_jpeg_desc *cfg_desc = jpeg->slot_data.cfg_desc;
+	dma_addr_t desc_handle = jpeg->slot_data.desc_handle;
+	dma_addr_t cfg_desc_handle = jpeg->slot_data.cfg_desc_handle;
+	dma_addr_t cfg_stream_handle = jpeg->slot_data.cfg_stream_handle;
+	unsigned int *cfg_size = &jpeg->slot_data.cfg_stream_size;
+	void *cfg_stream_vaddr = jpeg->slot_data.cfg_stream_vaddr;
 	struct mxc_jpeg_src_buf *jpeg_src_buf;
 
 	jpeg_src_buf = vb2_to_mxc_buf(src_buf);
@@ -1245,18 +1235,18 @@ static void mxc_jpeg_config_enc_desc(struct vb2_buffer *out_buf,
 	struct mxc_jpeg_dev *jpeg = ctx->mxc_jpeg;
 	void __iomem *reg = jpeg->base_reg;
 	unsigned int slot = ctx->slot;
-	struct mxc_jpeg_desc *desc = jpeg->slot_data[slot].desc;
-	struct mxc_jpeg_desc *cfg_desc = jpeg->slot_data[slot].cfg_desc;
-	dma_addr_t desc_handle = jpeg->slot_data[slot].desc_handle;
-	dma_addr_t cfg_desc_handle = jpeg->slot_data[slot].cfg_desc_handle;
-	void *cfg_stream_vaddr = jpeg->slot_data[slot].cfg_stream_vaddr;
+	struct mxc_jpeg_desc *desc = jpeg->slot_data.desc;
+	struct mxc_jpeg_desc *cfg_desc = jpeg->slot_data.cfg_desc;
+	dma_addr_t desc_handle = jpeg->slot_data.desc_handle;
+	dma_addr_t cfg_desc_handle = jpeg->slot_data.cfg_desc_handle;
+	void *cfg_stream_vaddr = jpeg->slot_data.cfg_stream_vaddr;
 	struct mxc_jpeg_q_data *q_data;
 	enum mxc_jpeg_image_format img_fmt;
 	int w, h;
 
 	q_data = mxc_jpeg_get_q_data(ctx, src_buf->vb2_queue->type);
 
-	jpeg->slot_data[slot].cfg_stream_size =
+	jpeg->slot_data.cfg_stream_size =
 			mxc_jpeg_setup_cfg_stream(cfg_stream_vaddr,
 						  q_data->fmt->fourcc,
 						  q_data->crop.width,
@@ -1265,7 +1255,7 @@ static void mxc_jpeg_config_enc_desc(struct vb2_buffer *out_buf,
 	/* chain the config descriptor with the encoding descriptor */
 	cfg_desc->next_descpt_ptr = desc_handle | MXC_NXT_DESCPT_EN;
 
-	cfg_desc->buf_base0 = jpeg->slot_data[slot].cfg_stream_handle;
+	cfg_desc->buf_base0 = jpeg->slot_data.cfg_stream_handle;
 	cfg_desc->buf_base1 = 0;
 	cfg_desc->line_pitch = 0;
 	cfg_desc->stm_bufbase = 0; /* no output expected */
@@ -1408,7 +1398,7 @@ static void mxc_jpeg_device_run_timeout(struct work_struct *work)
 	unsigned long flags;
 
 	spin_lock_irqsave(&ctx->mxc_jpeg->hw_lock, flags);
-	if (ctx->slot < MXC_MAX_SLOTS && ctx->mxc_jpeg->slot_data[ctx->slot].used) {
+	if (ctx->mxc_jpeg->slot_data.used) {
 		dev_warn(jpeg->dev, "%s timeout, cancel it\n",
 			 ctx->mxc_jpeg->mode == MXC_JPEG_DECODE ? "decode" : "encode");
 		mxc_jpeg_job_finish(ctx, VB2_BUF_STATE_ERROR, true);
@@ -1476,12 +1466,12 @@ static void mxc_jpeg_device_run(void *priv)
 	mxc_jpeg_enable(reg);
 	mxc_jpeg_set_l_endian(reg, 1);
 
-	ctx->slot = mxc_get_free_slot(jpeg->slot_data, MXC_MAX_SLOTS);
-	if (ctx->slot >= MXC_MAX_SLOTS) {
+	ctx->slot = mxc_get_free_slot(&jpeg->slot_data);
+	if (ctx->slot < 0) {
 		dev_err(dev, "No more free slots\n");
 		goto end;
 	}
-	if (!mxc_jpeg_alloc_slot_data(jpeg, ctx->slot)) {
+	if (!mxc_jpeg_alloc_slot_data(jpeg)) {
 		dev_err(dev, "Cannot allocate slot data\n");
 		goto end;
 	}
@@ -2101,7 +2091,7 @@ static int mxc_jpeg_open(struct file *file)
 	}
 	ctx->fh.ctrl_handler = &ctx->ctrl_handler;
 	mxc_jpeg_set_default_params(ctx);
-	ctx->slot = MXC_MAX_SLOTS; /* slot not allocated yet */
+	ctx->slot = -1; /* slot not allocated yet */
 	INIT_DELAYED_WORK(&ctx->task_timer, mxc_jpeg_device_run_timeout);
 
 	if (mxc_jpeg->mode == MXC_JPEG_DECODE)
@@ -2677,6 +2667,11 @@ static int mxc_jpeg_attach_pm_domains(struct mxc_jpeg_dev *jpeg)
 		dev_err(dev, "No power domains defined for jpeg node\n");
 		return jpeg->num_domains;
 	}
+	if (jpeg->num_domains == 1) {
+		/* genpd_dev_pm_attach() attach automatically if power domains count is 1 */
+		jpeg->num_domains = 0;
+		return 0;
+	}
 
 	jpeg->pd_dev = devm_kmalloc_array(dev, jpeg->num_domains,
 					  sizeof(*jpeg->pd_dev), GFP_KERNEL);
@@ -2718,7 +2713,6 @@ static int mxc_jpeg_probe(struct platform_device *pdev)
 	int ret;
 	int mode;
 	const struct of_device_id *of_id;
-	unsigned int slot;
 
 	of_id = of_match_node(mxc_jpeg_match, dev->of_node);
 	if (!of_id)
@@ -2742,19 +2736,22 @@ static int mxc_jpeg_probe(struct platform_device *pdev)
 	if (IS_ERR(jpeg->base_reg))
 		return PTR_ERR(jpeg->base_reg);
 
-	for (slot = 0; slot < MXC_MAX_SLOTS; slot++) {
-		dec_irq = platform_get_irq(pdev, slot);
-		if (dec_irq < 0) {
-			ret = dec_irq;
-			goto err_irq;
-		}
-		ret = devm_request_irq(&pdev->dev, dec_irq, mxc_jpeg_dec_irq,
-				       0, pdev->name, jpeg);
-		if (ret) {
-			dev_err(&pdev->dev, "Failed to request irq %d (%d)\n",
-				dec_irq, ret);
-			goto err_irq;
-		}
+	ret = of_property_read_u32_index(pdev->dev.of_node, "slot", 0, &jpeg->slot_data.slot);
+	if (ret)
+		jpeg->slot_data.slot = 0;
+	dev_info(&pdev->dev, "choose slot %d\n", jpeg->slot_data.slot);
+	dec_irq = platform_get_irq(pdev, 0);
+	if (dec_irq < 0) {
+		dev_err(&pdev->dev, "Failed to get irq %d\n", dec_irq);
+		ret = dec_irq;
+		goto err_irq;
+	}
+	ret = devm_request_irq(&pdev->dev, dec_irq, mxc_jpeg_dec_irq,
+			       0, pdev->name, jpeg);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to request irq %d (%d)\n",
+			dec_irq, ret);
+		goto err_irq;
 	}
 
 	jpeg->pdev = pdev;
@@ -2914,11 +2911,9 @@ static const struct dev_pm_ops	mxc_jpeg_pm_ops = {
 
 static void mxc_jpeg_remove(struct platform_device *pdev)
 {
-	unsigned int slot;
 	struct mxc_jpeg_dev *jpeg = platform_get_drvdata(pdev);
 
-	for (slot = 0; slot < MXC_MAX_SLOTS; slot++)
-		mxc_jpeg_free_slot_data(jpeg, slot);
+	mxc_jpeg_free_slot_data(jpeg);
 
 	pm_runtime_disable(&pdev->dev);
 	video_unregister_device(jpeg->dec_vdev);
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
index 87157db78082..d80e94cc9d99 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
@@ -97,7 +97,7 @@ struct mxc_jpeg_ctx {
 	struct mxc_jpeg_q_data		cap_q;
 	struct v4l2_fh			fh;
 	enum mxc_jpeg_enc_state		enc_state;
-	unsigned int			slot;
+	int				slot;
 	unsigned int			source_change;
 	bool				header_parsed;
 	struct v4l2_ctrl_handler	ctrl_handler;
@@ -106,6 +106,7 @@ struct mxc_jpeg_ctx {
 };
 
 struct mxc_jpeg_slot_data {
+	int slot;
 	bool used;
 	struct mxc_jpeg_desc *desc; // enc/dec descriptor
 	struct mxc_jpeg_desc *cfg_desc; // configuration descriptor
@@ -128,7 +129,7 @@ struct mxc_jpeg_dev {
 	struct v4l2_device		v4l2_dev;
 	struct v4l2_m2m_dev		*m2m_dev;
 	struct video_device		*dec_vdev;
-	struct mxc_jpeg_slot_data	slot_data[MXC_MAX_SLOTS];
+	struct mxc_jpeg_slot_data	slot_data;
 	int				num_domains;
 	struct device			**pd_dev;
 	struct device_link		**pd_link;

base-commit: a23a3041c733e068bed5ece88acb45fe0edf0413
-- 
2.38.1

