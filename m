Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A5C6B8F61
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjCNKLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjCNKLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:11:07 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E58199D7E;
        Tue, 14 Mar 2023 03:10:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbfTqEFid/QHWoH7JEDA/kgkhlGwdpj5rFOuScdzC5Z0RA3qWf5rhBcZgEVQXSe6GKoQH6OvC2TZJPYdJYeXWvRqWkAgrbOdwTrNsmpEgTT2htIM0e7t6FCtlpOciXfKji5omTx2km6oi55P6Kz923JyPQM9wrOQ54LwML/E9utpPofuz5bZstJqqp6Escm1BptahHrgQVtNcleX3OjHBz22gHNzAe7Ins0XxU4U3euKBcEopyuvcaJ3Cv2aj8Z7z27WRb13t9bLaSyH4ZED5jXa24GMDFc4+UWQ9sqeLcZanXYA3CKkC6lJdlvJ7Rhy1vEhbGQp6MVHwpSMgHQBAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HtPUGDrL90dDHNDgqSHbRFOdqqqZXS5JUCzQX0fw9o=;
 b=Ojf5PZj6rDRX83DkaoDQraRCZmSBBo9zg0tswtD7zpM+NAACUSr3+CeNSaNf9UWzd468Jrq4+u+iWikfPHChHVdr4kXRzqJIMpXePK4F9JETsome1QEuhb8yuIcIKVn35SDa5y+zoZcMToLis/HgwvfrP5cZgcsnPAvNqlmVfgqsgXt8XqQCRoCJNtuEgHehi0xqzeTlKD6l9spiPk/LQmZAu0xZiF9DMTLClwpCirg74V1dW2zdk9CQCRQ69Hh40kkUTSxWQahEftL+Y9zB67Iu6O2N8MPWuZqe/fqHX1cMU3ySN6MQZcE+C21ChWqh933D4l2Bsjq5eZ2C5sEiEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HtPUGDrL90dDHNDgqSHbRFOdqqqZXS5JUCzQX0fw9o=;
 b=nPLphcCfSJkuUki5HrgWClGpNLDjkjGFzqkfGaJDuvrzfPAp1WAefZ8JNZY7HSoPCPIRMiIuV1Tfj6OkxVJZr8OM2D7Sb+u5ccPoG7ZZUWwK7YmD630cksbOo/FF5ev7N1kTkf9rCipUVMESu90YNR3FmJk/Fm8ICURgNtH/LL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM8PR04MB7841.eurprd04.prod.outlook.com (2603:10a6:20b:244::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 10:10:26 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b%5]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 10:10:26 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 07/10] media: imx-jpeg: Refine the function mxc_jpeg_find_format
Date:   Tue, 14 Mar 2023 18:08:50 +0800
Message-Id: <58cbaa978ccb4d9c96b169dd268bb06f17816e2f.1678788305.git.ming.qian@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: bb2f2559-a9e5-41f7-3265-08db2474550e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eA9uyWBo7NUiwW708lIb0yQ8RR3zj7e7kEylukJ/OPQc3N3gju+fhawtU87PCk8XBT5+SUxiqSyXSRHpo2YYivr/jT6yMs6WkxD4kpvdduvyD0HsYzBadxjjXVS6Qb1V4oCuugCCYjD3YoZmnSBEtp2+aVX3Y4BveqbQnZQz8tUwbUZHl5+WcxJjuxkVTfEdmh1ZsaZcpMipgBgpW7iUJJ7k7kjHhzVMg6Si2trzfq+lMqRY2jGTZ9a147xVr5cpZSs6RS0AzrzvvMMhK1/Ue+XMnyzUNeId2pIXKiRFkMi4ST2WjwxQuu2dSZBc1MvYlYlLLJTjaWjw7im3aCJfjwfrIVxVsmlpV0Brv6Aozy5idM00ozdg/dk3tcAxBiN16j6KpaeoXLkEjrA5EkzRAK9VunLlN5jZ4vLPi5OnLH/ZGbCGGQrmadBIajhnJYtBCES3IEiNI4GAy9U3XeE9UGP9qu0+wkk9IW/Bow0oqf72Nd4LnfNu5F6klWuGmsPV9WbrrfxUMYI3Sq++HB9h3hqYyk70Z5U58e/gPF2cjLu9nIsEjys/D3yBTo1MfS08LdgaZkO9d50CZgvmHgP5IkpCdOwxBLvLmFiK6xX85qTNo+ynqIQC7F/ptTn2UCkrkH/+h4jVjZN6vzQ43T9L52VOLMsyR/9JmyZdrtQyJFc2vM91jE7tyQeTiwRbMwyY3p3QJw3/IflOIQ5GP/2pbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199018)(7416002)(5660300002)(8936002)(2906002)(44832011)(38350700002)(38100700002)(86362001)(36756003)(41300700001)(478600001)(66946007)(66556008)(66476007)(8676002)(6486002)(6666004)(4326008)(52116002)(83380400001)(316002)(186003)(26005)(6506007)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NNgur0fSIMbLvW5GPfTH0jmErDq0aLD7uSTWIhQVkYX/XiY5FoNKh++Ur37u?=
 =?us-ascii?Q?t1NT7sYMKG/dAqC7OK3ZmXuDUfstt98/T97RjNxczBfQ3s4xPGj24XZg8zVD?=
 =?us-ascii?Q?8KLOb5CcWSdQYXUZ5PqkZ1BzvPJWGEARBtt4MtNc8JdEv/VGxrQA9VRGNiwc?=
 =?us-ascii?Q?sk3iSFROZCQAEUt2aIU8kdvFBTBH0xHAcJNwQhWsbb+2R3nAJwsHtVjdOAil?=
 =?us-ascii?Q?PRJ6UEXKjpe9IsinZHhoVnE03zqjlGp7EoCFrUD5mV0Q9tG20Jy2xE1bDum6?=
 =?us-ascii?Q?60eTZNqUV+yX7ZznRwdQnQOexXxwHuCT0gzg4gJMeaqvm3Kj5kEhZk67KVlh?=
 =?us-ascii?Q?AsjOUv70C0NVL+df7GN+AGv8OylJA6OSvGTnDq+ji/jKai8i0cVi9Tpo99hE?=
 =?us-ascii?Q?ZEWIkf68RwrSd30SG+MmzSZtMtJ/TA0agUX2VrUHcmzTfgU8g9DCN3lCDMs1?=
 =?us-ascii?Q?I+VCBN6YNaAD+Q5VJqS9G4i07Iw3UMG6frU3RLRaevabdfwibC+O/xdYjLiN?=
 =?us-ascii?Q?edNIr10q9G07JIOMJz6BDO9SkLwV17qCoOnavfkaS2/i2llKzqvYTWsqAcRr?=
 =?us-ascii?Q?VUjbe8ArxwtVfXHuJae2TwOp04PNrKvn2vb0rFgcXWfHXjJlV51z9Ex0GvB7?=
 =?us-ascii?Q?tw3+RIyxqJ+9yhxH33urir3pvRc1mtujzLDzY7FWYCNB6UMIqpFbxt5Z2a4S?=
 =?us-ascii?Q?6kBnexThXMDVQoheTyaar7fm1pru8UCQEdq34GXZkKAzAoc8GWCKpxG2DqFm?=
 =?us-ascii?Q?v19CegB9VojujAD9sAqrOnjtURtvac2bjh+6d6lpc8Ch3VOTB8evGklNZBpq?=
 =?us-ascii?Q?o5Us9Il8K96MHQsJKix0T34D0d9+hh9qNra1WpvhPHr7MhBuVVgG/W0rSW5D?=
 =?us-ascii?Q?yZapBo2x786b8NFmhiYkcyhrpTaw9DhWvuBxoMHjWO10SqrlHoKztPAanHvT?=
 =?us-ascii?Q?9qJCoNgbY8QclYDRfwABkvKojtXZ+Jb1O8p3AVi+BhewKaMYoagv9i2iNB9D?=
 =?us-ascii?Q?61hYTxPrbxtWU7yypzvMMh3nW56tQvn/EzYgAWhgfLzUrIPQFtep1V1aqsyO?=
 =?us-ascii?Q?R9sLFGQ2HzaruV/J+FJkPnbenEtYzR183/IkFx6CAggC3vgtl9HWtbZhtxpq?=
 =?us-ascii?Q?7CrpH7GVSSwFzOGqcfBE/r7u1iXUbA/YjK9GSnVQzXbNapBJNjSnksme8zrb?=
 =?us-ascii?Q?JWNnUCnnf2/p0g7zaGAGC3k+4MBBPgBD9BphtAzJ0JtNHtAdEcUXXASBdGQ7?=
 =?us-ascii?Q?uyKwdKQgHWOwjLpwexbq7ylvy+/ISK7lSd7s9Boko8WiLXJJXrKnE2LukGVc?=
 =?us-ascii?Q?tfgk3kUjQrzLCSrxncv6IyNA5rFf7rnHSr/srxwpHKTtQ6U/os8eF7a0mWl1?=
 =?us-ascii?Q?Sn8LJxW4AxNVjQ0FK+J9wcuog0FXEpHj6BIzrs358uxMt0rhajlWnHAQpxP0?=
 =?us-ascii?Q?D+oJ5qESH/EbZyf3jU+pSllBc6aV3wthzZDkzlNKxwhWWbDxo5leEYIYQzBK?=
 =?us-ascii?Q?nZCW7GldhSM+Jhkw6r6XcecjrxsIGQCYD+NJtWSaCNXFv6ok7W2uj1OHVjaV?=
 =?us-ascii?Q?6fcSuf72nde7xYnFFw+iMQsNOVtITjkDd9q3+nJy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2f2559-a9e5-41f7-3265-08db2474550e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 10:10:26.6732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bzWptyUeA+rYTg3lxk9XO+ybZ5atmzFkaSOujboia7updFDIZ4Eg3XZw3nrn0dk1Kzy6oDfyUrD69ldxCIgBPQ==
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

remove the unused parameter ctx

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index f085f14d676a..70b6eea733e7 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -420,8 +420,7 @@ static int enum_fmt(const struct mxc_jpeg_fmt *mxc_formats, int n,
 	return 0;
 }
 
-static const struct mxc_jpeg_fmt *mxc_jpeg_find_format(struct mxc_jpeg_ctx *ctx,
-						       u32 pixelformat)
+static const struct mxc_jpeg_fmt *mxc_jpeg_find_format(u32 pixelformat)
 {
 	unsigned int k;
 
@@ -1562,7 +1561,7 @@ static int mxc_jpeg_parse(struct mxc_jpeg_ctx *ctx, struct vb2_buffer *vb)
 	if (fourcc == 0)
 		return -EINVAL;
 
-	jpeg_src_buf->fmt = mxc_jpeg_find_format(ctx, fourcc);
+	jpeg_src_buf->fmt = mxc_jpeg_find_format(fourcc);
 	jpeg_src_buf->w = header.frame.width;
 	jpeg_src_buf->h = header.frame.height;
 	ctx->header_parsed = true;
@@ -1702,11 +1701,11 @@ static void mxc_jpeg_set_default_params(struct mxc_jpeg_ctx *ctx)
 	int i;
 
 	if (ctx->mxc_jpeg->mode == MXC_JPEG_ENCODE) {
-		out_q->fmt = mxc_jpeg_find_format(ctx, MXC_JPEG_DEFAULT_PFMT);
-		cap_q->fmt = mxc_jpeg_find_format(ctx, V4L2_PIX_FMT_JPEG);
+		out_q->fmt = mxc_jpeg_find_format(MXC_JPEG_DEFAULT_PFMT);
+		cap_q->fmt = mxc_jpeg_find_format(V4L2_PIX_FMT_JPEG);
 	} else {
-		out_q->fmt = mxc_jpeg_find_format(ctx, V4L2_PIX_FMT_JPEG);
-		cap_q->fmt = mxc_jpeg_find_format(ctx, MXC_JPEG_DEFAULT_PFMT);
+		out_q->fmt = mxc_jpeg_find_format(V4L2_PIX_FMT_JPEG);
+		cap_q->fmt = mxc_jpeg_find_format(MXC_JPEG_DEFAULT_PFMT);
 	}
 
 	for (i = 0; i < 2; i++) {
@@ -1950,7 +1949,7 @@ static int mxc_jpeg_try_fmt(struct v4l2_format *f,
 		 pix_mp->height : MXC_JPEG_MAX_HEIGHT;
 	int i;
 
-	fmt = mxc_jpeg_find_format(ctx, fourcc);
+	fmt = mxc_jpeg_find_format(fourcc);
 	if (!fmt || fmt->flags != mxc_jpeg_get_fmt_type(ctx, f->type)) {
 		dev_warn(ctx->mxc_jpeg->dev, "Format not supported: %c%c%c%c, use the default.\n",
 			 (fourcc & 0xff),
@@ -1958,7 +1957,7 @@ static int mxc_jpeg_try_fmt(struct v4l2_format *f,
 			 (fourcc >> 16) & 0xff,
 			 (fourcc >> 24) & 0xff);
 		fourcc = mxc_jpeg_get_default_fourcc(ctx, f->type);
-		fmt = mxc_jpeg_find_format(ctx, fourcc);
+		fmt = mxc_jpeg_find_format(fourcc);
 		if (!fmt)
 			return -EINVAL;
 		f->fmt.pix_mp.pixelformat = fourcc;
-- 
2.38.1

