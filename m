Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DF5654F0D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 11:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiLWKQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 05:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiLWKQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 05:16:30 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3A61BEB1;
        Fri, 23 Dec 2022 02:16:29 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BNA1Wcn021709;
        Fri, 23 Dec 2022 10:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=4r5hLgxakUU17RWBCFGD+ncHlZjhDEmePTaBGoXGBmg=;
 b=ElVQRflvkAwNQ8hF+uAWHV9FkOkjt3dsKbKerHw/ASK2uAspcE0FKHhr203Cd3AZdlMu
 7G+Jqf6fXV4ycoBTCJhKyToivSeEXHWhVyk36FOu3/VX2fiaEYwz2TFr6hLI/7sM9ktV
 iaoWu/nZ3qhjWe7Bcl2ZJjCpqAbbSWaFyYWMNyK3ITNH/0XxNTJ6qzUX+bJMl212I9lC
 3+1uLGjGxuYoSy7lmDSV68Xt+UuWp/EIqQN3G7dXg8CTvOv66DtMlkDoyL7CXG8u6Uwn
 nRuTK22zoS1DVSAR+ZFPCX3oqDlTYC2lPUe4JFdzSVA+7YnBcOBsx/9P6in515G/asVb gg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mm3cjvsp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Dec 2022 10:16:27 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2BNABZ2o017142;
        Fri, 23 Dec 2022 10:16:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3mh6ukxpqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 23 Dec 2022 10:16:23 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BNAGMgP022302;
        Fri, 23 Dec 2022 10:16:22 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 2BNAGMlN022301;
        Fri, 23 Dec 2022 10:16:22 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
        id 1BACE4972; Fri, 23 Dec 2022 15:46:22 +0530 (+0530)
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
To:     linux-media@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2] venus: venc: add handling for VIDIOC_ENCODER_CMD
Date:   Fri, 23 Dec 2022 15:46:13 +0530
Message-Id: <1671790573-6432-1-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zdRAQe6udSvg-TxVfbJq5y_gp_DCB9cM
X-Proofpoint-ORIG-GUID: zdRAQe6udSvg-TxVfbJq5y_gp_DCB9cM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-23_04,2022-12-22_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212230087
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add handling for below commands in encoder:
1. V4L2_ENC_CMD_STOP
2. V4L2_ENC_CMD_START

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 drivers/media/platform/qcom/venus/core.h |  9 +++++
 drivers/media/platform/qcom/venus/venc.c | 63 ++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 32551c2..d147154 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -317,6 +317,14 @@ enum venus_dec_state {
 	VENUS_DEC_STATE_DRC		= 7,
 };
 
+enum venus_enc_state {
+	VENUS_ENC_STATE_DEINIT		= 0,
+	VENUS_ENC_STATE_INIT		= 1,
+	VENUS_ENC_STATE_ENCODING	= 2,
+	VENUS_ENC_STATE_STOPPED		= 3,
+	VENUS_ENC_STATE_DRAIN		= 4,
+};
+
 struct venus_ts_metadata {
 	bool used;
 	u64 ts_ns;
@@ -428,6 +436,7 @@ struct venus_inst {
 	u8 quantization;
 	u8 xfer_func;
 	enum venus_dec_state codec_state;
+	enum venus_enc_state enc_state;
 	wait_queue_head_t reconf_wait;
 	unsigned int subscriptions;
 	int buf_count;
diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index cdb1254..a7804b0 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -520,6 +520,46 @@ static int venc_subscribe_event(struct v4l2_fh *fh,
 	}
 }
 
+static int
+venc_encoder_cmd(struct file *file, void *fh, struct v4l2_encoder_cmd *cmd)
+{
+	struct venus_inst *inst = to_inst(file);
+	struct hfi_frame_data fdata = {0};
+	int ret = 0;
+
+	ret = v4l2_m2m_ioctl_try_encoder_cmd(file, fh, cmd);
+	if (ret)
+		return ret;
+
+	mutex_lock(&inst->lock);
+
+	if (cmd->cmd == V4L2_ENC_CMD_STOP &&
+	    inst->enc_state == VENUS_ENC_STATE_ENCODING) {
+		/*
+		 * Implement V4L2_ENC_CMD_STOP by enqueue an empty buffer on
+		 * encoder input to signal EOS.
+		 */
+		if (!(inst->streamon_out && inst->streamon_cap))
+			goto unlock;
+
+		fdata.buffer_type = HFI_BUFFER_INPUT;
+		fdata.flags |= HFI_BUFFERFLAG_EOS;
+		fdata.device_addr = 0xdeadb000;
+
+		ret = hfi_session_process_buf(inst, &fdata);
+
+		inst->enc_state = VENUS_ENC_STATE_DRAIN;
+	} else if (cmd->cmd == V4L2_ENC_CMD_START &&
+		inst->enc_state == VENUS_ENC_STATE_STOPPED) {
+		vb2_clear_last_buffer_dequeued(&inst->fh.m2m_ctx->cap_q_ctx.q);
+		inst->enc_state = VENUS_ENC_STATE_ENCODING;
+	}
+
+unlock:
+	mutex_unlock(&inst->lock);
+	return ret;
+}
+
 static const struct v4l2_ioctl_ops venc_ioctl_ops = {
 	.vidioc_querycap = venc_querycap,
 	.vidioc_enum_fmt_vid_cap = venc_enum_fmt,
@@ -548,6 +588,7 @@ static const struct v4l2_ioctl_ops venc_ioctl_ops = {
 	.vidioc_subscribe_event = venc_subscribe_event,
 	.vidioc_unsubscribe_event = v4l2_event_unsubscribe,
 	.vidioc_try_encoder_cmd = v4l2_m2m_ioctl_try_encoder_cmd,
+	.vidioc_encoder_cmd = venc_encoder_cmd,
 };
 
 static int venc_pm_get(struct venus_inst *inst)
@@ -1196,6 +1237,8 @@ static int venc_start_streaming(struct vb2_queue *q, unsigned int count)
 	if (ret)
 		goto error;
 
+	inst->enc_state = VENUS_ENC_STATE_ENCODING;
+
 	mutex_unlock(&inst->lock);
 
 	return 0;
@@ -1215,10 +1258,21 @@ static int venc_start_streaming(struct vb2_queue *q, unsigned int count)
 static void venc_vb2_buf_queue(struct vb2_buffer *vb)
 {
 	struct venus_inst *inst = vb2_get_drv_priv(vb->vb2_queue);
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
 
 	venc_pm_get_put(inst);
 
 	mutex_lock(&inst->lock);
+
+	if (inst->enc_state == VENUS_ENC_STATE_STOPPED) {
+		vbuf->sequence = inst->sequence_cap++;
+		vbuf->field = V4L2_FIELD_NONE;
+		vb2_set_plane_payload(vb, 0, 0);
+		v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_DONE);
+		mutex_unlock(&inst->lock);
+		return;
+	}
+
 	venus_helper_vb2_buf_queue(vb);
 	mutex_unlock(&inst->lock);
 }
@@ -1260,6 +1314,10 @@ static void venc_buf_done(struct venus_inst *inst, unsigned int buf_type,
 		vb->planes[0].data_offset = data_offset;
 		vb->timestamp = timestamp_us * NSEC_PER_USEC;
 		vbuf->sequence = inst->sequence_cap++;
+		if ((vbuf->flags & V4L2_BUF_FLAG_LAST) &&
+		    inst->enc_state == VENUS_ENC_STATE_DRAIN) {
+			inst->enc_state = VENUS_ENC_STATE_STOPPED;
+		}
 	} else {
 		vbuf->sequence = inst->sequence_out++;
 	}
@@ -1362,6 +1420,9 @@ static int venc_open(struct file *file)
 	inst->core_acquired = false;
 	inst->nonblock = file->f_flags & O_NONBLOCK;
 
+	if (inst->enc_state == VENUS_ENC_STATE_DEINIT)
+		inst->enc_state = VENUS_ENC_STATE_INIT;
+
 	venus_helper_init_instance(inst);
 
 	ret = venc_ctrl_init(inst);
@@ -1424,6 +1485,8 @@ static int venc_close(struct file *file)
 	v4l2_fh_del(&inst->fh);
 	v4l2_fh_exit(&inst->fh);
 
+	inst->enc_state = VENUS_ENC_STATE_DEINIT;
+
 	venc_pm_put(inst, false);
 
 	kfree(inst);
-- 
2.7.4

