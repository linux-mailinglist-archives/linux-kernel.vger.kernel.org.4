Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2524661456B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 09:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiKAIEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 04:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiKAIEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 04:04:45 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80048.outbound.protection.outlook.com [40.107.8.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB40656D;
        Tue,  1 Nov 2022 01:04:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3u4lfaOjGHoTAHP4B/S4eA2nwfJEsfQZoWL/DtlZcsdvFsqUGhC7QRJPtkI/8FhY35UflUxO8mKk7MEsDeai77hTFoXXM7JkEtCKAwJH/dE642T9/seEydwsvev1/V7Htd9aOgX458ei6pblblCSrOn639T1WfCdsK+GxRX7PrIUEnCoC19Lx+138+IJznjiCA0LeuXUb7SjnGAbJUgAUbXhaqdhN+LqNkSmRRZIQtSzPCLYHNfCbW/cE7yMohlU2UkWYT+Z8obPGWluXWfNar/a5wdLqEMAm1kRbCTywDCRGOvW/miUPd/DcOsFTcPhjEYa/Gfp64B/DE8oDs1hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VJ9kjzVRdgf+YXReMuCuljt4g+Ac0X1ZVZe9hadQ54=;
 b=KFGaORmhOoaxWygSu0bk4j0aBj7A22X4w03V+7/SJTBSu458zKmJywWEeJNm3OGIdBjdR+CnqzI1Xq4ZebZEuuGEkl81WKcCCjl69nDiF8dngjt04nX9b9G4WIz+IoGliBxNMw0BujGU6FMXw7OmjUG219vWpJ075crkvNTe81E75HC2djwBJbPAUFU2FYTHocS/mDMOxrn98I/6q12cFdKdvodBios6LEfHz07ca9e7+kOlw9I48kkDcTW67UBZQ46nbyGo6pZr6/lvHNLuBIJdljki5acl5AWPOXiejhPpUWbIzyVAwFOgk+lNLuKEdbTyUwuHuv8Nd/cA5bhXog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VJ9kjzVRdgf+YXReMuCuljt4g+Ac0X1ZVZe9hadQ54=;
 b=R7xCAh7Gr/fM+l1Abn/7SRDuEkkRvxfK0UL0Oo1ksDwE2dRms6GKkVro2R3pZ28PCLE+OShoxagzWglS35L1cJzxgjQMNpCHT9EwM4AtgMkHIHKDB1CQsvnKrc90p6N7OIqWSeIiB9mG3FS4CQVBvEt/vSXPuf0fr1HETjxK5AQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM9PR04MB8633.eurprd04.prod.outlook.com (2603:10a6:20b:43c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Tue, 1 Nov
 2022 08:04:41 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::976e:7d79:975e:8d23]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::976e:7d79:975e:8d23%3]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 08:04:41 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: add lock around vdec_g_fmt
Date:   Tue,  1 Nov 2022 16:04:20 +0800
Message-Id: <f7a5cd01795a0ec1e45cbbf80292288bf1ddada1.1667289227.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0181.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::13) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AM9PR04MB8633:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b0ba421-8c32-4b07-ffa5-08dabbdfbafb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KNyvACvepPyYVqP02TvDEH1OsKYTQwt1C/2ZxXJhJUc/K7Ot8bqX2NP2OSp+nenXy+cC+P/pIJ06TXdH3Tqtor9/gG09siOKyW8V5Tj+ekdyblrNa+ywMCKv1O89TDa2G4yJYT0sYCI9qwLHdfjdQJ9SJdtOsMgoLtnSWt2KurfJoCDTVFDBs4KkHXFcwHLYqSJi1o8lb85N/ropR+J5dkQUe7/d+dfNje69pM2P3oclBSI6aRz/hgkTTSEEtgkfYlGoHJ7blF0G1Akci2i5Np7r1XvCMwhcfAd594ZvM7dWBXKD5qgzo2ej0tQiFlQSc0drwWUq/0HrpenCoz1/dp4sBmRb4IpesitW/P+GPOLSNeGJeCCvR9tZJMtJtXj/s3N0FnfCJ6p/ns92iz2sKHJ1LPolUEVh6E1mY4ktIq0jf5INjIwzkqyi67BbtF4xGJapd9rCPzyxS4RtFbqHe9DQbatvEvMT+vowTF+OCzPrguGG6EZizCa+BgJNqiKGLbjP7MefpemC1qxfVrhsQtfW7lnOdHG+dIxAYgWmkTgbL1QVRfuqMC4is0U4S9F7JrA6fXuuNyXsEpdX4KT3jeMHJydfI2KvRla+ZzszB+UkuqXNXm/U6VbX8lGbkWSi4MYqhifNfVrlILpy/9Vcwkx+QwjO/AoFIFmQenu5bAXENMyGYVdfCmPqQNg6esVV+JW7B3QjYAKVRUeILtMEgB8eUKDdQFETo5MtOwpOQwEpvGL66vq5Na99+bgymwVkAI3Fa98TkO4KqH6jQerf3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(451199015)(8936002)(36756003)(38350700002)(38100700002)(86362001)(83380400001)(186003)(6512007)(2616005)(26005)(6506007)(52116002)(6666004)(478600001)(6486002)(7416002)(8676002)(44832011)(2906002)(41300700001)(66556008)(316002)(66946007)(4326008)(66476007)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DuXBIPKIxolRKIAtq45Dehn9MmJBRVyd0/xf6B0GnzlcgPr2NDj4jnYAzivI?=
 =?us-ascii?Q?e490naTr9OtC3cz62pRLgJqgohPTSgP2pYSI2GyE8nGIx32WdhPQsflUMdTA?=
 =?us-ascii?Q?RPcayOC+ecSoIvI+hG4eYrL2DrB67QvtyUipuOo+3xg0t1OXFJV/3YQLOghb?=
 =?us-ascii?Q?tJ3OHyBtw3h1eT44Fo5jtIeArPT9xcEzrrBKvlvroOJp9Eqhe+r0DK9Nm9LH?=
 =?us-ascii?Q?yU+oJ/8myv0mOg98TpZ1VY2s78RS12XsRdj2wOO/TZIZfqRb4LoRAJgZ0DsC?=
 =?us-ascii?Q?CAv7X4WQz3Ti0XvcRZwlT2HLFRj84AOWjT2HUq6KPQlBzjgJZNXFgnLkn8Q+?=
 =?us-ascii?Q?vPEuU0ouuBFITo6PtI516fz7iqiMHxuhTJj86/OnhHUpJqMoltOREFv5sJQT?=
 =?us-ascii?Q?VIamyeo3+DUUB/EVmZMYNPh6OUapL2HGo/zGwUMruVASgmPFKHQT1bju8CvQ?=
 =?us-ascii?Q?eCRzrxE/hLBUhxB/DDNnKI7kA0mVgP53tpw2QITEL4MXX6qmO659PLOIuuFi?=
 =?us-ascii?Q?VlL8xUCAm2vsja84JcNAUJdNijrLc5H7TLCiyrJ4vxPfPQR9kBYy2v0pMK2S?=
 =?us-ascii?Q?6dIC+xAEOOHNC1mh6MaIMfOLjVx6Hvd/uMXexZjf7QgyjC6Ethiog97PFii5?=
 =?us-ascii?Q?66ZrqSRWJWA5sOd/3n/umtjeIxb1fJX8zne4ZiccmamNlhKG3FuSDAP4OhLW?=
 =?us-ascii?Q?QVHEgB4yeLxIvWIpjFkWgcETbr5YfcXYMC8dzR1O1prF9eXshirbMpdUdJud?=
 =?us-ascii?Q?ebZZWjv3BDhaYrumKRnftfwOC/sOgZ3QkACqy7mHsymrrJqp3Hn3dFcc2Huk?=
 =?us-ascii?Q?F1t3WES+eTFntxv6Iydg+E/GCvb2Lo6XkMqBvgd3TC11Dkfjb/P6S0dJs5FZ?=
 =?us-ascii?Q?tNiTfm1hquvc+Wo8GSqbYOgpcdlKy17btKRMyXp3EXFa1z5aLf2GdKxu+Yi1?=
 =?us-ascii?Q?XOCKzgTZNf4AFWWot6sv9ykkeRhrRw8EtbvR/tU37QqKAzr8aBmbKQFDhxxg?=
 =?us-ascii?Q?tkUw7Cx9u4jw8zltEaG23w+U7XNlh+SekY4zRpe84wupLr2i2iW6aD6+WQz5?=
 =?us-ascii?Q?7a++J2efew5Ny8zgJ06fo+SURRPDCGh/HbyzcUQJa7V1dBJqLAZcTfj55Qpp?=
 =?us-ascii?Q?xoQquxFKDCT8BDYPYO3dlBjH/LeYi2x+Cz2PFMHAWypbK0ZurMvQcgqHrwpt?=
 =?us-ascii?Q?cOPGncTVcr7WLumdAdM5mCgtmiAIXO1eWg7Fzb9Z6214EA21Erafz5QiRgTf?=
 =?us-ascii?Q?36YFlk/lH8qbIZUz13UCGvoj8V3LDTP9pOJIef12WhCs9/6r8QUhn9fYDhMM?=
 =?us-ascii?Q?eMnIalvqTD1RiSeToWBZoOOs3mRj7Haqwcowr2WHk8dPFYaxZCftkgxkMRhg?=
 =?us-ascii?Q?XA2GTJF6Bov03TtIMPIrHLGZ5ywXhNzmhput0sRTr05PD5uD8vtbMVSdpR1g?=
 =?us-ascii?Q?cZUazIoTbV2/nxocRM0rFxgH54mUEGZSK6QxfX9JVWQEXn7JK6EJlcoCDj4I?=
 =?us-ascii?Q?8b1V19m3h4AAcvsF6ch77M8nMwnuHZgQ5XtSHUIouAw9qY6vrsGmM8TKVby8?=
 =?us-ascii?Q?LFNxBroSRfZMOSz9ehQOX8SlY1/5UQxTPvH/tS3W?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0ba421-8c32-4b07-ffa5-08dabbdfbafb
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 08:04:41.8649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: symLLYMMj+pIY+6PSZ7oc3IG9o9+pXDPHIUs3yJ5ouOjE189PX8w6lMMasZ2G9IvL4OtIuIZkM3oNFYOkzGe3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8633
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the capture format may be changed when
sequence header is parsed,
it may be read and write in the same time,
add lock around vdec_g_fmt to synchronize it

Fixes: 6de8d628df6e ("media: amphion: add v4l2 m2m vpu decoder stateful driver")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vdec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
index 0d7676eee5ea..87f9f8e90ab1 100644
--- a/drivers/media/platform/amphion/vdec.c
+++ b/drivers/media/platform/amphion/vdec.c
@@ -314,6 +314,7 @@ static int vdec_g_fmt(struct file *file, void *fh, struct v4l2_format *f)
 	struct vpu_format *cur_fmt;
 	int i;
 
+	vpu_inst_lock(inst);
 	cur_fmt = vpu_get_format(inst, f->type);
 
 	pixmp->pixelformat = cur_fmt->pixfmt;
@@ -331,6 +332,7 @@ static int vdec_g_fmt(struct file *file, void *fh, struct v4l2_format *f)
 	f->fmt.pix_mp.xfer_func = vdec->codec_info.transfer_chars;
 	f->fmt.pix_mp.ycbcr_enc = vdec->codec_info.matrix_coeffs;
 	f->fmt.pix_mp.quantization = vdec->codec_info.full_range;
+	vpu_inst_unlock(inst);
 
 	return 0;
 }
-- 
2.38.1

