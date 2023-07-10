Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A9374CEC9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjGJHov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjGJHon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:44:43 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2064.outbound.protection.outlook.com [40.107.241.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD08E1;
        Mon, 10 Jul 2023 00:44:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCj+3oGNv3mQaIW+wonAfDV/Xa9p0n4KT0wUnFjq8IxCxrEpHNJRA1Xusucav2GKMi89Kv4Y+AzWa7fqwL8AvYTTXk3iqglCxL7uL6r0N2o7bczg7fTTJ+EA4Oa49yLxiC6XAgxYdQj841cP4xiDfymhWWnYBlFkd4OHrnkowqYf005mOgc7TKe+t2z+pFPi9Hh59Oh4IlTXj/WGpoI7xM0XTr1JS0ErapgE4PE5Xqwnl+FVb2IIoHGoVPk7tfCx74DZoIlqnM/6zLKy3rbhhC56MHLXCTW+O1B4T8jOJV7ZYYk1Mu7aoJUTcDy7tnW5T9Mjf7ZVI5mAcFTJetVz0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RyA/8xyzCl3muqcAlRQ2TDG5w/ClrjnijXZdGqv1szA=;
 b=S/5ziL9PSQX9wcmC3sTyQgQkyw4LrXE2GyN0MEpcFnneLHGjMMfOB5G407gocChaN+hRMtZxPkVcxlt/GbNfWNWmvAJWGVw7CTHS8AIPAfhQp33xHGW/dujNOz+cQnJGRVRcLB3WDHgfjxAXrlOJ9rrn8b8/pfiZhMZsJkDcyZzm4PX81sj/MU8WGD+B0GNNW0Mj6QXpMIlKD8sIfZ9uq8BWFYD1znPkRGmeJewkzKCs9/1Xgs/H+rlmf2yuXaVMBWsKBEl1C0IYfnfVeydRp4b6z4b666m/U15ggIRfqn9nMyLb24uRmEOcsaqD2dTz9tzhvvPXxpyuKu6a3S779Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyA/8xyzCl3muqcAlRQ2TDG5w/ClrjnijXZdGqv1szA=;
 b=HAnud100k0EezKUb/Rei+Aa+QBgnOdea57u2RDVhbDSEZI6/3LEG7OP8HHuB+6MyZPSFAuDW3/hDSvgHol8d3UBO40ZH7QQ2Lqe+bKgBu4k3DXlCdmkfpI+Xt+TDXEOhOcMqxysGNGPLCLkr4xDupQXJpSxzsXoFIgbp2dQKljk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB9PR04MB8073.eurprd04.prod.outlook.com (2603:10a6:10:24d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 07:44:35 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5c63:1211:716e:ac60]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5c63:1211:716e:ac60%6]) with mapi id 15.20.6565.026; Mon, 10 Jul 2023
 07:44:35 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: decoder support display delay for all formats
Date:   Mon, 10 Jul 2023 15:44:11 +0800
Message-Id: <20230710074411.21558-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0207.apcprd06.prod.outlook.com
 (2603:1096:4:68::15) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|DB9PR04MB8073:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c05b9bb-1687-465c-8fbd-08db81198174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yAYRn3t1FsyCQBfKgONPQXahZdvPUPMUWSwiYEpCh3I+efoCnOOKKwi31XK6JmKTmlLUT1MIZpahIoRaQWIIJGcKuk+XNSxKcmm4z+zDhCFlVrYtM+cgVTJbiKV03E06xKl5977r4rxtmPS+yeQO18brYJhnkJ5LKAFoDTJhfAprtovd1D37TbY0cEZEB8pJ8C4aw+AqWDZP88wTsR7QPJUjZ7YGDccJCtZ93ibxvs6VkNZTsnzkW1Y8kIGN0jocxjIbm8hao+IEitE9ZjlfU9DmkTl1oxdMgnftjWFMkNbwu+F0US/fvPQPJQ4qDPOqjVDldWVmj3qk3WK48G1Hk199mnXS3zGN6SNcz/MX0j4hmMrn8a/Nh6XBdbydt58NjzWgt03r1Ily1+Odax2KJgjCgid3ShwDN4oUeruF1PV2KW8b99OCTeYEjptNkgO+BQC33YedX3TEz3lbynU+RqFOiHDXqzhESEyCOK0UXV6N9R5QFheNY/3SBrx2a3NlsJZW9ZsVoD/ZocvHV3d3Ma/7m76Wg2FJAbmKI4GIlOL8nxcwppzxzpjg/EP5VgVFNgbhuZY68ZyS67Lme0zwBJ0SwwRqWUP2vD56BqrOTsmE7gdl7TEd5oAggCFz3JDR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(451199021)(86362001)(38350700002)(38100700002)(36756003)(6666004)(6486002)(52116002)(1076003)(6506007)(186003)(26005)(6512007)(2616005)(44832011)(7416002)(5660300002)(2906002)(66556008)(316002)(66946007)(478600001)(66476007)(8676002)(8936002)(83380400001)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7FdREA81EDWLnIJZKmr7tJiNwK8rREN4gugkoKypqvHMBng+bE9Zg5SsLZop?=
 =?us-ascii?Q?Upp7700CXkr1necE3Pv6rIJy8+imx4VyM8y5JLEoTRxJpGXVQGhowe93dbbl?=
 =?us-ascii?Q?eaUtWMyu8/VIauZ43hf/Lz2ZhkahEmPSbt+x0BEZTg+E6LptDKmUxN9dada9?=
 =?us-ascii?Q?GWTfnDeiWDqQI9Ufn4TmJYzmwLPPgksr8mBo/HrNyqIDQahS3Df5J/7YXnob?=
 =?us-ascii?Q?OwHr3tK1xokA3Ipne/QyS7miwIWzvT7/dfWe+qS+XLbZZ9+lKbaIRQBeIDMn?=
 =?us-ascii?Q?3NNCEwRKg3VaXrWlOkUCLd7Y9gnZc55+47ekHFUKdmxT7NPMgdCOLssyTZgN?=
 =?us-ascii?Q?CG65L3AcLcTfAQ7q1mqifx6SJx954vQQ1wQ9lva3KaTxDU98pf3NQdacVzgv?=
 =?us-ascii?Q?MC/nwO0K0jsTDXOAUEHUHvaDOcAyxnHiv6Z09PxlFXuzpDoWrFFx7j/fSHdo?=
 =?us-ascii?Q?8zK/v4yOiAIHlZzfXVronhwX22Y12yntlYXmceWPUbLdl5DjqgFz5byH0MIs?=
 =?us-ascii?Q?OPwLYtU8fF1YH77OhPYho7K3eyCXkdDJ8JOTHVd+DRJzlGkoQYY5cg8XyXiL?=
 =?us-ascii?Q?J726pBTi9bM66DgQ6K9/lnIJqXH6pgTnr/I8yRtfHBBVp85Kgx91w9N5iv+N?=
 =?us-ascii?Q?BWjeznfmGVEGZ1COZJvan3418GrOFh7QGF2Wmy463wObnk1B3VeWf/2tZsY1?=
 =?us-ascii?Q?8yDMmbbSVfHvj0BsIJvro5qJcB1UUxGO5MAXFeFucRKtBbgizOu4vlPTrd/u?=
 =?us-ascii?Q?1MAc+PH89zi56gp+LdZqiSR0Fjn2BJUUdq7x8yu55AT0nkrN0ZPn60w2C8n+?=
 =?us-ascii?Q?WNq8N7WI5nB5BrahJ5hJNHV3NemauFWdKvYQ4J5tzS5i0++4sNIiw+Ab61ke?=
 =?us-ascii?Q?FMTb7z29OUu1rxhu5Lk3XKzGZ54Vi9kyiBx/5y5q7MzO/boQ5WOWq1DO1Fjp?=
 =?us-ascii?Q?hY+3a9mgzsvjh4ueXdXQLDpdM8Tbp7gERc2dyJp+d6pvzDeNvVken+4UYDVX?=
 =?us-ascii?Q?NtGyIq/D/mLiaEc4RUrYgzKr1MFGK3HVfoyc5L0hSvznaXfIiZy8+OENjKQ1?=
 =?us-ascii?Q?VR3m2ttPTgcpM7BBKBGD/T+PpKgEKmWhMRnsHglVeCLg8gzT1qMmxTTcv2Tn?=
 =?us-ascii?Q?pGtuVvg4qLBdustjUQsaQnJOw6SMK00DrIXz7nmvTIhGFnm+bqPZnmz2a97o?=
 =?us-ascii?Q?Zpds76zDtlUwS9nTIGUJSDCYqGNVisgyDphebBy7siAVZTxishqG2SHQRsbq?=
 =?us-ascii?Q?HfyismjxQ1JA5Rbumvcv0vY0B9BEP+5qQoPn8UeXB6viaSOi5HUZkKch9X43?=
 =?us-ascii?Q?MK+d7MvGEDJ1YupDj2utzluL5Cb0dN1z3+039HFxLDYH2Zw+Pe2mwoCbCsZ7?=
 =?us-ascii?Q?65bEot0ncCBmizDoXZajq8A86a/OaBdJ30ahmL4Fy2Lp2oZXSIP+8OwXCoFT?=
 =?us-ascii?Q?dHvdYHDJLhdxqkmTlr/fiDcemOtY/puk+QLqKlDNvpYbGDFBgGvLAmjssXqo?=
 =?us-ascii?Q?DKYQyEGcFH3nmVhDwITzVrwY20WskrSk70CncS6ozZgh3u7bFumegbvoAegH?=
 =?us-ascii?Q?pW+X2Hmc7Nv2zh+RyAKktguG2hcJeKgJ4afB2jjw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c05b9bb-1687-465c-8fbd-08db81198174
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 07:44:35.1514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mzTOG0nOKkps94VRMaxYoLwdMk+i8l1J14bzrO5ZgariW4JzUzkW3NbdRic405z2kTYUk1961HlmhQAUBK8ZRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the firmware only support low latency mode for h264,
but firmware will notify an event to driver
when one frame is decoded,
if V4L2_CID_MPEG_VIDEO_DEC_DISPLAY_DELAY_ENABLE is enabled,
and V4L2_CID_MPEG_VIDEO_DEC_DISPLAY_DELAY is set to 0,
driver can display the decoded frame immediately.

Fixes: ffa331d9bf94 ("media: amphion: decoder implement display delay enable")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vdec.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
index 60f3a73c6a8a..eeb2ef72df5b 100644
--- a/drivers/media/platform/amphion/vdec.c
+++ b/drivers/media/platform/amphion/vdec.c
@@ -742,6 +742,21 @@ static int vdec_frame_decoded(struct vpu_inst *inst, void *arg)
 		dev_info(inst->dev, "[%d] buf[%d] has been decoded\n", inst->id, info->id);
 	vpu_set_buffer_state(vbuf, VPU_BUF_STATE_DECODED);
 	vdec->decoded_frame_count++;
+	if (vdec->params.display_delay_enable) {
+		struct vpu_format *cur_fmt;
+
+		cur_fmt = vpu_get_format(inst, inst->cap_format.type);
+		vpu_set_buffer_state(vbuf, VPU_BUF_STATE_READY);
+		for (int i = 0; i < vbuf->vb2_buf.num_planes; i++)
+			vb2_set_plane_payload(&vbuf->vb2_buf,
+					      i, vpu_get_fmt_plane_size(cur_fmt, i));
+		vbuf->field = cur_fmt->field;
+		vbuf->sequence = vdec->sequence++;
+		dev_dbg(inst->dev, "[%d][OUTPUT TS]%32lld\n", inst->id, vbuf->vb2_buf.timestamp);
+
+		v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_DONE);
+		vdec->display_frame_count++;
+	}
 exit:
 	vpu_inst_unlock(inst);
 
@@ -769,14 +784,14 @@ static void vdec_buf_done(struct vpu_inst *inst, struct vpu_frame_info *frame)
 	struct vpu_format *cur_fmt;
 	struct vpu_vb2_buffer *vpu_buf;
 	struct vb2_v4l2_buffer *vbuf;
-	u32 sequence;
 	int i;
 
 	if (!frame)
 		return;
 
 	vpu_inst_lock(inst);
-	sequence = vdec->sequence++;
+	if (!vdec->params.display_delay_enable)
+		vdec->sequence++;
 	vpu_buf = vdec_find_buffer(inst, frame->luma);
 	vpu_inst_unlock(inst);
 	if (!vpu_buf) {
@@ -795,13 +810,17 @@ static void vdec_buf_done(struct vpu_inst *inst, struct vpu_frame_info *frame)
 		dev_err(inst->dev, "[%d] buffer id(%d, %d) dismatch\n",
 			inst->id, vbuf->vb2_buf.index, frame->id);
 
+	if (vpu_get_buffer_state(vbuf) == VPU_BUF_STATE_READY && vdec->params.display_delay_enable)
+		return;
+
 	if (vpu_get_buffer_state(vbuf) != VPU_BUF_STATE_DECODED)
 		dev_err(inst->dev, "[%d] buffer(%d) ready without decoded\n", inst->id, frame->id);
+
 	vpu_set_buffer_state(vbuf, VPU_BUF_STATE_READY);
 	for (i = 0; i < vbuf->vb2_buf.num_planes; i++)
 		vb2_set_plane_payload(&vbuf->vb2_buf, i, vpu_get_fmt_plane_size(cur_fmt, i));
 	vbuf->field = cur_fmt->field;
-	vbuf->sequence = sequence;
+	vbuf->sequence = vdec->sequence;
 	dev_dbg(inst->dev, "[%d][OUTPUT TS]%32lld\n", inst->id, vbuf->vb2_buf.timestamp);
 
 	v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_DONE);
-- 
2.38.1

