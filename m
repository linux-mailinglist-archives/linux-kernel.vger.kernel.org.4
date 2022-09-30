Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC505F04F6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 08:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiI3GlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 02:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiI3GlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 02:41:15 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2048.outbound.protection.outlook.com [40.107.21.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDF213DDB4;
        Thu, 29 Sep 2022 23:41:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXZRXpuiqKN9NfHcrpBu4D5dggJec92ccqY8jQPpS5AgHntPoSzCm8g6HWsa8wTe6/rk8wCvC/fUfckGIv6NxEHC20WJ58h8UPMKgB/yDzq9+j5Ztg/DPCXoGRdIxNn3DWd1veS2hiMJIEaTNtuYqFweaZSwfzi/F4sqYW5caSBwTCBjpFdvepOmoLGrR4MRb84obFcEcBVy3CzN/oALex2VFHxQI4SDUBovv1dBR///Jeu28xqb2PTvP6GMOBhnIp4aWAH8o8cUcKtu0vL3Avl+LDtbYtgCUXp7k38Mt+ttZQ/l7AOJzooFrmKUZJqwX8JqmSaO8FR9+VEE06PynQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7M/JtMp792+OsSFh6igLnhCjxWEygIu6JqcVO6GK53c=;
 b=I7XVqKQBYpCPTbFgc1eK5yflAklLWYihg2f8ea/YwBrxq+HEr3nElsyQSWLUuxA5Q3ezvOsFM1Bgw/doqNmb/+hLpRxpQOT6RJVuK1fkTTBjDsQnUYJ+VlB4iK3zYcwm+HxaexzUIA8s9w210D8yplY+T0LZ1lSXzhihsSwkQwdLzWPtb732oY+AGatfBpguguGLtUqCIWrqljuSA352D89hwtgUkb3Ym+k4liei4JqRZvgh2an0l2G9nvKnszpdZO2HKiJs5kXCwunx4pcOJFn3bn0ibfPs0ktLbDz9dNnQdpKBwqoivuzsSNWZmhNC3U87YPkHJN0kmnAIpBEGMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7M/JtMp792+OsSFh6igLnhCjxWEygIu6JqcVO6GK53c=;
 b=IKL5TlRRspcIqpO6RYocg7OWdfRbVLxwi8nSy0QySTQlU5rCg/dcw4dPHLKTUCblPeHKnR0Dvn1PA5/XalE4IPg1LZKY1efb9YRToqkgrcTcT80uxXnqwi8CZPcNxeaxKzFtRhgpLpLpOC/OOpG3aFT9MrFgJu6z9JwBYy6NUVk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DU2PR04MB8998.eurprd04.prod.outlook.com (2603:10a6:10:2e1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Fri, 30 Sep
 2022 06:41:10 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::4550:e439:2389:be53]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::4550:e439:2389:be53%5]) with mapi id 15.20.5676.023; Fri, 30 Sep 2022
 06:41:10 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: reset instance if it's aborted before codec header parsed
Date:   Fri, 30 Sep 2022 14:40:47 +0800
Message-Id: <20220930064047.19759-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:196::9) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|DU2PR04MB8998:EE_
X-MS-Office365-Filtering-Correlation-Id: af07d2a7-8c11-4f62-3466-08daa2aec2fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bSjarGprVSRO6XRmUVjTL5O+gy1maIFCZgMMLHXjJR35oYzrdln3QHB2w4O9hg0X4kAVKOF07ZUT5sJg+VVFlncjo7wOxZ7wtdIqBZMzYH79SSt+0EwfXvuAbpqcp264pJGZbhtzyZiIMFPMOQgbvHhm8UfRZVBe3TljW1J3C8CNe1eXkjAU17oq5NmS6xi9ya52nzHE83I0rdHXVAUYoewVypMF5tbsfXWgFhKCCvDQkPhSGbYX/CTxp9poxYNuu+nDCT44Lig7bjehMktfa873Yfw7GzaabADPk6VS3KIceb8EcyF3VGHPorRMkkP85a7krxWOyIbt9VN0zg8I8wOX+G1uOVhQM9djJA9si3rT4mU6qO1ra+hrwBKjn8VlNKb1O4/rU6+hhRKkBEw3iPpKH4VTfSA/RqnQyeM3+PyHxUQIMj+5WNKn2HlGhg5xJy9bpLUC6KcYk8iFhOIUQuKWy9nDjWaIJA9qwap5Olc3piQ1o02avlQFixM8NyBjd7aCTho3ZOXlxdooxdv1i0xaHb2Q+MzF95G6m49l9iWg7gsDY1uIRdIVIH9tMkrQxk8/iYWTTJeDzoBhd/OHSEgys3gDWVFiaAsJmDZxDlFkAtcQZJqodNLRJLGnuZKDsilLIEil2ww8F4vMYv+6yUOrFfrf5zeSTz6wNYjqKMmB7c86H6nRgI/S8xL6HiE8uuHAbvSvow9oZp4TzjG+E2Bv1v3YlPTRbqvebPIBNb+1oduR0g1akSxLZyLG5c1PemsKH+2W5kQA85KiD2AlOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199015)(6486002)(6666004)(2616005)(38100700002)(38350700002)(2906002)(41300700001)(8936002)(4326008)(86362001)(66556008)(8676002)(316002)(26005)(66946007)(52116002)(6506007)(7416002)(36756003)(478600001)(5660300002)(44832011)(6512007)(66476007)(186003)(83380400001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wSgbllEOZ8ih8Yp7VXOm93HlEfbxEUI9D2lPSd+HWRC8G8SpKEgPUYym/UXn?=
 =?us-ascii?Q?C238m9BhNILi+8aVRD79wChtiGOOr1pOi49HNU1VkbC50nXcgzhO0/wP6kmJ?=
 =?us-ascii?Q?Oont4kMv3NgDVRDRjbtvuely6ZRGsSW97F4qoXcU0+Bv0KMFb8NtXeWtoCpF?=
 =?us-ascii?Q?lYtfY5Orqf6eqNYA4u5UEKSDfFmnD0JUW8CqF1xgnDosJfm1FxKDWAH3i8xk?=
 =?us-ascii?Q?zExh9LEho1Z+QqaVsdyMjAWbr7fDQGi7+7yyaBjGeAHG/sw46j5rk3asDKHS?=
 =?us-ascii?Q?TUvDhcF9vBjjE/zfX/bu/FugBlbniEsrDsUkCMQRzMDXMK41fp145xwT8tuC?=
 =?us-ascii?Q?02gIrWTjpCe7FjhuqEtIb1s1yE/rGoFGk6dkP3VU1Ceut9i/qIBKxbEmB/7T?=
 =?us-ascii?Q?bSgiagX5rqqkDIGZujqE0a2ZiAFZ15N39M524fkpZoQ6aqMW745ajpkr31vk?=
 =?us-ascii?Q?BbOSqFYfnDLQsRmV6/Kg6mnLYLzDxybfQqlaUPn9IshM1tMgBjUlER1fxPBk?=
 =?us-ascii?Q?guHpDoQ8hdQkRMvXhyLmG4Ul53Dfk6Y05kNE8w8PlhDFFuiyWbEwt+CYSRGY?=
 =?us-ascii?Q?TZ5VCfAu4UjVEKaQUKzaIMcWOTOnhYqRU9uWZzIfVaJEeK+kUsvXwLITnk+v?=
 =?us-ascii?Q?TT4rCB7OX1Ag0AOwoxsKRh+d/BKZcnZAKq7CAsqfaYHOTDEI1fwOmXB5tIHK?=
 =?us-ascii?Q?+c4BsWzrNokou0kKg79x8/6B2BKnNJIFxasCM+uyaIe2pxwxsJAFv3JYpY+j?=
 =?us-ascii?Q?ji0Wylee3JnZzfZtFXO0yt45B9REkOY6Lnm1kgnlTpgFtdD9QFf1CRLrOoxO?=
 =?us-ascii?Q?LILQte1npLqa/5R6ux9SV4Alx/a2KFWRqqTV3ykp8W2WHkYS+G8dONNIZoq7?=
 =?us-ascii?Q?gxR3VHBXRntaIbstH+4DcoRBMhnls7Lr44z/Z7AIHcr7r9/FIvj78Jns//6T?=
 =?us-ascii?Q?Kfh+NxSBf718dxPX4E4gf8KgxlS46abmcPqN1ykeiO1Uaec8356KsgaCvLIn?=
 =?us-ascii?Q?T4aXfDxK4s1m72xg6sGekzyxRK21jYPXoUNMOKRbZ5v5A453p751ApZ/3yVY?=
 =?us-ascii?Q?fCaWIdPYPfZV/TSqo0nkdQyv/gb4bDA1V+qAHGqDd+Erd0SlJdtRL7q4lPzv?=
 =?us-ascii?Q?k4+tFc6AGLclj39+an+6aDn09qPuV981mHCqn86KnA9wfeR1D9nevY1SG1TX?=
 =?us-ascii?Q?gOEHklyRREVpROIEhVYpWVYKfzzhTk1SToUROU4FCVU0zFo7UzlvvOYklkPo?=
 =?us-ascii?Q?7Dzh50UwbTSBss0WwE83GMJQDwyD2GFA3BHdr4D3/gNeDj1j4SXMHNIORs12?=
 =?us-ascii?Q?I+VpLheHdSWn35Kzpi9vb6++YBy+xgiWpY6vRQQscZZ1jDZjmKVdDnX28khU?=
 =?us-ascii?Q?atDy4Coh6dZYwm/7O1tWzmvMkwxOjEnxjj/4yIaqjM+QgKK8zaEslesKkI/i?=
 =?us-ascii?Q?s+xzL+sujnYzX146r7hMd5PEJgvtpI4P8ViaeRBOAU94GSwSPt7GVL1O+HI7?=
 =?us-ascii?Q?LNlEyS40wqX2BMZuQefx5//DEf9ZQBYfpydvc6vqncWjiGxThVfAEDFbNFdF?=
 =?us-ascii?Q?DALNoLlWLEHuWlSh8D0+hIyGveR8VwFtssJHavfS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af07d2a7-8c11-4f62-3466-08daa2aec2fe
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 06:41:10.7826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l93UeRXKBIEnClTaclSSx3XpFIjIODEiFXi/2Zu3ZuJaIh6xuBLVWiJifRgBzNDF66ewJHOi1vbCxs5afbpv5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8998
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is hardware limitation that if it's aborted before
the first codec header parsed, the codec may be stalled
unless we do reset codec.

and drop the source change event if it's triggered after reset.

Fixes: 6de8d628df6e ("media: amphion: add v4l2 m2m vpu decoder stateful driver")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vdec.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
index 9c3324717cbc..0d7676eee5ea 100644
--- a/drivers/media/platform/amphion/vdec.c
+++ b/drivers/media/platform/amphion/vdec.c
@@ -786,6 +786,9 @@ static bool vdec_check_source_change(struct vpu_inst *inst)
 	if (!inst->fh.m2m_ctx)
 		return false;
 
+	if (vdec->reset_codec)
+		return false;
+
 	sibling = vpu_helper_find_sibling(inst, inst->cap_format.type, inst->cap_format.pixfmt);
 	if (sibling && vdec->codec_info.pixfmt == sibling->pixfmt)
 		vdec->codec_info.pixfmt = inst->cap_format.pixfmt;
@@ -1113,7 +1116,8 @@ static void vdec_event_seq_hdr(struct vpu_inst *inst, struct vpu_dec_codec_info
 		vdec->seq_tag = vdec->codec_info.tag;
 		if (vdec->is_source_changed) {
 			vdec_update_state(inst, VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE, 0);
-			vpu_notify_source_change(inst);
+			vdec->source_change++;
+			vdec_handle_resolution_change(inst);
 			vdec->is_source_changed = false;
 		}
 	}
@@ -1360,6 +1364,8 @@ static void vdec_abort(struct vpu_inst *inst)
 		  vdec->decoded_frame_count,
 		  vdec->display_frame_count,
 		  vdec->sequence);
+	if (!vdec->seq_hdr_found)
+		vdec->reset_codec = true;
 	vdec->params.end_flag = 0;
 	vdec->drain = 0;
 	vdec->params.frame_count = 0;
@@ -1367,6 +1373,7 @@ static void vdec_abort(struct vpu_inst *inst)
 	vdec->display_frame_count = 0;
 	vdec->sequence = 0;
 	vdec->aborting = false;
+	inst->extra_size = 0;
 }
 
 static void vdec_stop(struct vpu_inst *inst, bool free)
@@ -1489,8 +1496,7 @@ static int vdec_start_session(struct vpu_inst *inst, u32 type)
 	}
 
 	if (V4L2_TYPE_IS_OUTPUT(type)) {
-		if (inst->state == VPU_CODEC_STATE_SEEK)
-			vdec_update_state(inst, vdec->state, 1);
+		vdec_update_state(inst, vdec->state, 1);
 		vdec->eos_received = 0;
 		vpu_process_output_buffer(inst);
 	} else {
@@ -1654,6 +1660,7 @@ static int vdec_open(struct file *file)
 		return ret;
 
 	vdec->fixed_fmt = false;
+	vdec->state = VPU_CODEC_STATE_ACTIVE;
 	inst->min_buffer_cap = VDEC_MIN_BUFFER_CAP;
 	inst->min_buffer_out = VDEC_MIN_BUFFER_OUT;
 	vdec_init(file);
-- 
2.37.1

