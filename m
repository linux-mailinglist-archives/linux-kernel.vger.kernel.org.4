Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B95C6F90A3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 10:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjEFIsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 04:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjEFIsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 04:48:05 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2057.outbound.protection.outlook.com [40.107.241.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AA049C5;
        Sat,  6 May 2023 01:48:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVYsjch4TFYu2mYXfaVteM8mREm8K3s4OXOSlJ9bzXX8rQMlHO67cVR1KZnZDXSz8q1IyEVmYGFe36RrqnFZsc/W5hid0qJlcEk1AW3zjRmvDRfwfQD36NcJADMuvijmeyFZ4gQ6KaKCypcZoYUgNnSWo6CDT4vNW31XdwWvy/AmA7tZQP1zcPKidfk3FeyI/Ye/0fAhBysyF1t7B7B7j1jbG67tEzcTXfutJF41adQy7lzgDP9jzoZ7fnYS6pmlqCvKunqgjHI2EmfYp9BdePOxOXSpM5f2GR7JkoUWTrbRhS2MK8sX6PRyxoO67bUUDUcYAGeR6yKOwQunhcVMFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJb4RN2Ti9zndxdo3bzUpjJCHJNuZcW844OshSGkiX4=;
 b=UkFdNxOhipe2aShPWitmW7QftGSydtW/KTE6fz/YezCQ3H8BD0Bvqv0Zv3ciBnY/aUrWxj9++3QFu/3hEDmDDD2vQq8lGe2DQwF7RFWo6RVRvnrWEkRXlpBxubZrU5x5jrJ6IjrOf+BNlzBWj4KoQNfvEUjjFInXZZrYw1pu9H0uyGzB8/QnfFGh2/pqX+w282GrXw+gNmEtdEWVTzydK/t4RF91wlKEt9gzWmNKWZSNPL1Dwn+lVOoMYA+pLEGfsk6A0Wnpib0pNfbXI4vv6sPVcBg17UKOG6qrJvUPHmzxGRYA2TwHx8I5mQbaeq6SnCHfTMBdCA3LweFG4MavHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJb4RN2Ti9zndxdo3bzUpjJCHJNuZcW844OshSGkiX4=;
 b=p+XVI1ZXF717kSLDJYaWI+P4HFnPYHejA88Te3qZGqA4DtaRUF05Y/xzmllu+us8Z9W1+yYQwmYJ0intFsxlMNfo9MSbLd7Ile1VDIgpvHjxmoT/PCCcqd9R54MWbhwcrFDBRUpYq8voH/zVimFdq60qRQKZ/oC6hq/v2ooX2A0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB6927.eurprd04.prod.outlook.com (2603:10a6:803:139::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Sat, 6 May
 2023 08:47:58 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::e878:15f4:ac68:58bf]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::e878:15f4:ac68:58bf%6]) with mapi id 15.20.6363.029; Sat, 6 May 2023
 08:47:58 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: initiate a drain of the capture queue in dynamic resolution change
Date:   Sat,  6 May 2023 16:47:35 +0800
Message-Id: <20230506084735.30744-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|VI1PR04MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: c542fda1-9158-494e-4792-08db4e0e9798
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kAUo+BqVn2exOwBRLxFvEfUS6TeFLw4ley74daC8Rkoe/iUBpKJtKEAztC0STIqu0rJDj/4EGsdPcH0xqTrq2IifuT/Vuk6Sns+7oqAPoieEdVenbGu4RbDqTsF8JEvD5k6aYaEQQFqI+trzb8fDKgQ/32YbBBOPiX8lAFW8tKtgnzYnXxtBzMmS5WiB6P94qbViaTxSoOJUKnLzEK4KPesfO9tM4+kmdI9yyWGssIiyGevZFZxERsp4dUgdmWrlZdTq8R/m6Cbaf0BbtYdfqA341x8BK4shSXmwKZ+gaVdEN11ZaxL29lhqvDtIeJyD7If519S1VHfA1yw2jsMPJb4viNK3aRXHu0QBPo2vMfGSMat6uqZa/umq4YGIammAEZ3LriaTxsDFBJO+iSIWguqnhlqDt9e1PzZqtK+ISFhAvB/67mCvSLbu7Ub7RGwWIxFOKgQO1Bd4E5xjezI1xB4F6ccEs7OLaDqisfOVoMSL8bPyJ3Sz7yV7oQEJ6b5DE3HaymyC5/MqoELNgBJV+OpHHLo40u+GB7sR0LTf7wVxFHAnh3XIe26XtsIUQguW34fgjhUrY4Y5h/KnvcvcffAZuB2vDiL2CKeO41FEqxTUedaBa44ln3Q0Klmzvh29
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(451199021)(36756003)(86362001)(52116002)(316002)(66946007)(66476007)(66556008)(4326008)(6666004)(6486002)(478600001)(7416002)(5660300002)(41300700001)(44832011)(8936002)(2906002)(8676002)(38100700002)(186003)(38350700002)(2616005)(26005)(6506007)(6512007)(1076003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3NlkWqTjq7gc7VJFLAvBi/Eqlou3E6R+bPAgLwvUiv6MNWYFh57I81qNIeOR?=
 =?us-ascii?Q?zl8m2mE6/TvKBy8bfEup6o0i/LbdB7dnoGAiaJHcKQXXUhKrW1mzILsH6rd8?=
 =?us-ascii?Q?H9lsa3OQZDcANbY8aGkZnlHAqRp6WQHnyBy1dp0umzwBRJoEJqfTOY/sGTXK?=
 =?us-ascii?Q?H2huJh1qNnkEJ9v9aMcW733yreoppi/O3aroZBx/un2B56OXCfLGqkCKi/k8?=
 =?us-ascii?Q?ulFREhkKeB+dxcxCzFJvQqMGsPiSnYRii1FRMtjRhX8VSQrtLa8rIP8ZkjPN?=
 =?us-ascii?Q?eDi/YTQ34OPqe3K6POJyL25XS53k4DD80xjuRzaMuNMjEn9nKeWvV9r9lr82?=
 =?us-ascii?Q?DBnWin67illHOm9XQGxCqfUNuOHVcY+Eu6xMLfhIx6M6GlMhpm3+Q34TjvBF?=
 =?us-ascii?Q?ucz6JtK1TeIAS6mDg/t0QAvfMc9cIUeJ3G0vQYU/DQXfHusGpz46ssbkg076?=
 =?us-ascii?Q?x0O0sp0A2Rx8cU1P6NIqdNgNBJoyDDaNh71QObkYW6EPv2npWd0n+FsyK/3v?=
 =?us-ascii?Q?5IvZLNKBvf7/sroZYCojp6xhHVU7i0S74O00mtK+STJI01AFOj30ONNrCAsu?=
 =?us-ascii?Q?+thn82Ssb+NVp8pwNc+1I4YiR5NL7cfdubTWOY2PJtOhv4oP5ghCB6oUeJAq?=
 =?us-ascii?Q?iKd2HuZkF2V0jWKQzh5pQS7Icw+gptoLF7Z49LBAj83r/seRtfS+A4qedM0g?=
 =?us-ascii?Q?PR6LXVI65qCUXRkkQasWmUJbpXDVkG1vWHkC1eKIi1rQ1RfuP5YM9bxW1ReL?=
 =?us-ascii?Q?2/iI7yb5kbbu2nE/Et/+8EhX7DFKnk9zB6ySWLcWUedRWjMGwFJc/Igbkbs4?=
 =?us-ascii?Q?UTxWnJqs7CX3cqIQsjrFIZHZceoBwDrjgl/GiZnXl59TrG10rvDPzOAac3+e?=
 =?us-ascii?Q?t3jOtVggVZfBFv99CVWWkL/4mzq4hzLG4JHrkP/xnKFQQIu4XS+GoPZQOIRx?=
 =?us-ascii?Q?PhvZj+YaR7vQFP2ZwrNwQewChNn0BicDF05oSO6YfuQrczn3Ov8PbuVzJ0pL?=
 =?us-ascii?Q?09fJATxIaFBo+CeS/sIxZdWCDZ5+IWWA29dZza+cEWpGUPS5nnne8FfA1NPk?=
 =?us-ascii?Q?0zSDhp8pDHsnXJeuU0+XcqWNvWPFoDfu3afsxeWvw9SrywyYLYXNyokLMkJJ?=
 =?us-ascii?Q?95Z5LaORz8bEtfY+BfVS+UdP9Cj5y9jQi9tdnv9yCEM1w9WpBw/5OH5+thlQ?=
 =?us-ascii?Q?wQWcpm8ARcIfgWdeMbbim9h97UmQKEZtCmtRz34E8iblQS1yaeBRqNH+cM/x?=
 =?us-ascii?Q?AOoOqpO4Wr0aXnBv+fxslIm5DNgiEg5NrqKcHgGOfbGI/+Q9gGA+RW9QHk0Q?=
 =?us-ascii?Q?Mjl76V/qWLCmc/Z1sgfb8l1ZkMmnOj98zwkyZWn/oxp+h1nJrwf3DTkNHNKn?=
 =?us-ascii?Q?HpyQwQ5jknPpWlm3fuBoN+y0RvLVn+SN8pv+F2vWPHba5b9aPvard7EJAuKb?=
 =?us-ascii?Q?ccnvwY1tGWD21auTEP0ZEG2HP0ejWAV7rSTH+EZyqDx4Uiny+L/Ncv61GRjT?=
 =?us-ascii?Q?o+Tky2zEKrLvVO0jIEJf30cAyZ802nWkm795+R0WXZ/qj1DDVrmeRFW2akUv?=
 =?us-ascii?Q?xbYPp0GmMralPxrP6RLBdytRqXWkBYacMg/yz0RR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c542fda1-9158-494e-4792-08db4e0e9798
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 08:47:58.4708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PNJH741QnCeb9rzrKx00RRiirTzlLJqSTiRe/BrdrK2lQHzPYfEo36wKh1bHTcuFWevva77UFTVIUhqOUrMVAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6927
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last buffer from before the change must be marked
with the V4L2_BUF_FLAG_LAST flag,
similarly to the Drain sequence above.

initiate a drain of the capture queue in dynamic resolution change

Fixes: 6de8d628df6e ("media: amphion: add v4l2 m2m vpu decoder stateful driver")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vdec.c     | 7 ++++---
 drivers/media/platform/amphion/venc.c     | 4 ++--
 drivers/media/platform/amphion/vpu_v4l2.c | 5 +++--
 drivers/media/platform/amphion/vpu_v4l2.h | 2 +-
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
index 3fa1a74a2e20..6515f3cdb7a7 100644
--- a/drivers/media/platform/amphion/vdec.c
+++ b/drivers/media/platform/amphion/vdec.c
@@ -279,6 +279,7 @@ static void vdec_handle_resolution_change(struct vpu_inst *inst)
 
 	vdec->source_change--;
 	vpu_notify_source_change(inst);
+	vpu_set_last_buffer_dequeued(inst, false);
 }
 
 static int vdec_update_state(struct vpu_inst *inst, enum vpu_codec_state state, u32 force)
@@ -314,7 +315,7 @@ static void vdec_set_last_buffer_dequeued(struct vpu_inst *inst)
 		return;
 
 	if (vdec->eos_received) {
-		if (!vpu_set_last_buffer_dequeued(inst)) {
+		if (!vpu_set_last_buffer_dequeued(inst, true)) {
 			vdec->eos_received--;
 			vdec_update_state(inst, VPU_CODEC_STATE_DRAIN, 0);
 		}
@@ -569,7 +570,7 @@ static int vdec_drain(struct vpu_inst *inst)
 		return 0;
 
 	if (!vdec->params.frame_count) {
-		vpu_set_last_buffer_dequeued(inst);
+		vpu_set_last_buffer_dequeued(inst, true);
 		return 0;
 	}
 
@@ -608,7 +609,7 @@ static int vdec_cmd_stop(struct vpu_inst *inst)
 	vpu_trace(inst->dev, "[%d]\n", inst->id);
 
 	if (inst->state == VPU_CODEC_STATE_DEINIT) {
-		vpu_set_last_buffer_dequeued(inst);
+		vpu_set_last_buffer_dequeued(inst, true);
 	} else {
 		vdec->drain = 1;
 		vdec_drain(inst);
diff --git a/drivers/media/platform/amphion/venc.c b/drivers/media/platform/amphion/venc.c
index e6e8fe45fc7c..58480e2755ec 100644
--- a/drivers/media/platform/amphion/venc.c
+++ b/drivers/media/platform/amphion/venc.c
@@ -458,7 +458,7 @@ static int venc_encoder_cmd(struct file *file, void *fh, struct v4l2_encoder_cmd
 	vpu_inst_lock(inst);
 	if (cmd->cmd == V4L2_ENC_CMD_STOP) {
 		if (inst->state == VPU_CODEC_STATE_DEINIT)
-			vpu_set_last_buffer_dequeued(inst);
+			vpu_set_last_buffer_dequeued(inst, true);
 		else
 			venc_request_eos(inst);
 	}
@@ -878,7 +878,7 @@ static void venc_set_last_buffer_dequeued(struct vpu_inst *inst)
 	struct venc_t *venc = inst->priv;
 
 	if (venc->stopped && list_empty(&venc->frames))
-		vpu_set_last_buffer_dequeued(inst);
+		vpu_set_last_buffer_dequeued(inst, true);
 }
 
 static void venc_stop_done(struct vpu_inst *inst)
diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/amphion/vpu_v4l2.c
index 6773b885597c..810e93d2c954 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.c
+++ b/drivers/media/platform/amphion/vpu_v4l2.c
@@ -100,7 +100,7 @@ int vpu_notify_source_change(struct vpu_inst *inst)
 	return 0;
 }
 
-int vpu_set_last_buffer_dequeued(struct vpu_inst *inst)
+int vpu_set_last_buffer_dequeued(struct vpu_inst *inst, bool eos)
 {
 	struct vb2_queue *q;
 
@@ -116,7 +116,8 @@ int vpu_set_last_buffer_dequeued(struct vpu_inst *inst)
 	vpu_trace(inst->dev, "last buffer dequeued\n");
 	q->last_buffer_dequeued = true;
 	wake_up(&q->done_wq);
-	vpu_notify_eos(inst);
+	if (eos)
+		vpu_notify_eos(inst);
 	return 0;
 }
 
diff --git a/drivers/media/platform/amphion/vpu_v4l2.h b/drivers/media/platform/amphion/vpu_v4l2.h
index ef5de6b66e47..60f43056a7a2 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.h
+++ b/drivers/media/platform/amphion/vpu_v4l2.h
@@ -27,7 +27,7 @@ struct vb2_v4l2_buffer *vpu_find_buf_by_idx(struct vpu_inst *inst, u32 type, u32
 void vpu_v4l2_set_error(struct vpu_inst *inst);
 int vpu_notify_eos(struct vpu_inst *inst);
 int vpu_notify_source_change(struct vpu_inst *inst);
-int vpu_set_last_buffer_dequeued(struct vpu_inst *inst);
+int vpu_set_last_buffer_dequeued(struct vpu_inst *inst, bool eos);
 void vpu_vb2_buffers_return(struct vpu_inst *inst, unsigned int type, enum vb2_buffer_state state);
 int vpu_get_num_buffers(struct vpu_inst *inst, u32 type);
 bool vpu_is_source_empty(struct vpu_inst *inst);
-- 
2.38.1

