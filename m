Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE59A680FA1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbjA3NzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236456AbjA3NzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:55:18 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD8C25E38
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 05:55:17 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id m2so31452292ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 05:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FB2g2c4rIfuYP/zAUAb6cfWJDSl3EKVoz2j41/PaiwQ=;
        b=oKKlyJ2KD24h9FCrjwuz/haUT4fzJRmeTAUFdwJELfay8Hmrr9RdTuldtoXPKk7l3p
         wjKE05wTsqwxE5Pwrlk+viGHJ0zt5C88PFLySSl6dpFly3lU7rEyNJbhlQhQSfteMStA
         Dolm5Q6viMft++3VFIlYMcJr8QTay8FUw/huQfHa5Qs5iC0uTR+zgPrjPBKveRITU5g5
         CLUuP7zVsF46o9mCmdOEbmUE+fpgKU+51AfmEabkJIWdHGRcF3u86F4tz+tkoNLvuDGM
         /B9ZZSAVlSJUSid0Tz1xI2bhfxk1SOPrxYdmQvZdXeJ7wbLNefyCRwRCJW8ivCDCVNnk
         GmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FB2g2c4rIfuYP/zAUAb6cfWJDSl3EKVoz2j41/PaiwQ=;
        b=J6UIRhnatkF/PWiQLUdt3NOc/GbGYIgdZSYNq+k6hg29QqmYuNIylNx96xDPScKtKK
         f6AyA+OZce/Xy7Cp4obz6qL5DBcrBodGeRseFArSQbq0ZhB2RimXWrjMHKR8DEO4ToIw
         ZkUzXb9j9s3qwRKQArqLi01htD7U5L6n3UkS5NFNfkK0vMeIU3kKOWNWKF18COBEl3FK
         0Nx+/Z9E6BsIXhK8la2C51Qjz18MKnTmy1RyOsZuOJtl0GiLeKTYWY6+Rceb8HzwSdRJ
         /PY6psYJMVPGO4BX8LRW6cZwQlIf2SHIx8s4QN7BKjBmC31K9EN9cawxD4ddZ9zdNGHw
         1DLA==
X-Gm-Message-State: AO0yUKUbkDG5DG6F/pVChjKJDGvoRzKBRF+YJFCn89C5QJnpNgX8SRab
        zX030K2Xv06br1PHv3LmryX5VQ==
X-Google-Smtp-Source: AK7set8RiuC4MJp0K/vak5+3A+l8zKpBr/VhleJ2+63A+X8OKSsDz4eoJInidBH7tvWLzyPa7G0hYQ==
X-Received: by 2002:a17:906:b353:b0:87d:dd22:a93 with SMTP id cd19-20020a170906b35300b0087ddd220a93mr12275786ejb.54.1675086915736;
        Mon, 30 Jan 2023 05:55:15 -0800 (PST)
Received: from mikrawczyk.c.googlers.com.com (12.196.204.35.bc.googleusercontent.com. [35.204.196.12])
        by smtp.gmail.com with ESMTPSA id a6-20020aa7cf06000000b004a23558f01fsm2817513edy.43.2023.01.30.05.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 05:55:15 -0800 (PST)
From:   "=?UTF-8?q?Micha=C5=82=20Krawczyk?=" <mk@semihalf.com>
X-Google-Original-From: =?UTF-8?q?Micha=C5=82=20Krawczyk?= <mk@semmihalf.com>
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mw@semihalf.com,
        =?UTF-8?q?Micha=C5=82=20Krawczyk?= <mk@semihalf.com>
Subject: [PATCH v2] media: venus: dec: Fix handling of the start cmd
Date:   Mon, 30 Jan 2023 13:54:18 +0000
Message-Id: <20230130135418.1604455-1-mk@semmihalf.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
In-Reply-To: <20230130105423.1338554-1-mk@semmihalf.com>
References: <20230130105423.1338554-1-mk@semmihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michał Krawczyk <mk@semihalf.com>

The decoder driver should clear the last_buffer_dequeued flag of the
capture queue upon receiving V4L2_DEC_CMD_START.

The last_buffer_dequeued flag is set upon receiving EOS (which always
happens upon receiving V4L2_DEC_CMD_STOP).

Without this patch, after issuing the V4L2_DEC_CMD_STOP and
V4L2_DEC_CMD_START, the vb2_dqbuf() function will always fail, even if
the buffers are completed by the hardware.

Fixes: beac82904a87 ("media: venus: make decoder compliant with stateful codec API")

Signed-off-by: Michał Krawczyk <mk@semihalf.com>
---
V1 -> V2: Fix warning regarding unused variable

 drivers/media/platform/qcom/venus/vdec.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 4ceaba37e2e5..9d26587716bf 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -526,6 +526,7 @@ static int
 vdec_decoder_cmd(struct file *file, void *fh, struct v4l2_decoder_cmd *cmd)
 {
 	struct venus_inst *inst = to_inst(file);
+	struct vb2_queue *dst_vq;
 	struct hfi_frame_data fdata = {0};
 	int ret;
 
@@ -556,6 +557,13 @@ vdec_decoder_cmd(struct file *file, void *fh, struct v4l2_decoder_cmd *cmd)
 			inst->codec_state = VENUS_DEC_STATE_DRAIN;
 			inst->drain_active = true;
 		}
+	} else if (cmd->cmd == V4L2_DEC_CMD_START &&
+		   inst->codec_state == VENUS_DEC_STATE_STOPPED) {
+		dst_vq = v4l2_m2m_get_vq(inst->fh.m2m_ctx,
+					 V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
+		vb2_clear_last_buffer_dequeued(dst_vq);
+
+		inst->codec_state = VENUS_DEC_STATE_DECODING;
 	}
 
 unlock:
-- 
2.39.1.456.gfc5497dd1b-goog

