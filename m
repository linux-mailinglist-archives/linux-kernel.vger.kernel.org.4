Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882C9697A66
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 12:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjBOLEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 06:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjBOLEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 06:04:44 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52271715
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 03:04:43 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id s13so993152wrw.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 03:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acqka9R/vT4zXe+0BPN9/ZwtFH80tExv/tQK17XMr2k=;
        b=Ci2ObqN3csJOleKlnTMv8t4Gz1Wa5HkgUJGLJGL8sRZsLOhdpGc0pvoq5LAIVXC1Rp
         Qum3hNrvQm53hkIYBE8CWXF9onkJ3VHfJSgGh/UG1TTvmJZ2ZU7M+fVaO8AJv+XjdIl8
         XNS6mdzBTcZxdGffNIoMKtf8710Ph7TZdyU9SlIzdoNWV4myk/fGm9W1DpwpebC9Yvaf
         cJrwhFXb3laE7/7YOEeB7hHQAiJnFLmtpC5w2M69jyBOGBS9CiNfCIF705AE+cddaG28
         dQxhkYsETQABHr25nzFeUIohaqnRgMZDdPKAb+pLdLkjQW3BzobQyKoGqTBbs5EuoOuc
         zZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=acqka9R/vT4zXe+0BPN9/ZwtFH80tExv/tQK17XMr2k=;
        b=4JYuwfpFZ11kVmQDbSd9Lig0LP+i8KBoIiNd3wpkMwFHzz5e6akEGakNUTI/lzzgew
         skqq7DzVcs0YwvnsrbUdUMvDbjI6Dyjy/ZA628Txd48+vR/hTm+7O/GPDEQu2y9VepOf
         S8px6sBZhdsMIbRjMAu89EjoaydTiFy5lEZdOFnukXzE7G91UVOqc5VBwSGDmBJISH36
         x+L405MVySMgvK9RY5scRGFTDYjeEf7MjLmLZlfRpSPR2a5UynF0K4wJJ0y8mALhII5U
         +PQgIt1QPIK25NGPQrEyeHEwHSmdhAltDvZdlj/k66eHoA3QslGP2LuSa2fYNESf8mis
         Z36A==
X-Gm-Message-State: AO0yUKX4VuV8hhiAivoBnWfdinlz6iyAzqvH5rAJL6YqPkBoNSKZyT6Q
        UEiXO04nF29wtcMQAn2fcALiDuIvfOFxB2ns
X-Google-Smtp-Source: AK7set/nL9zc6sMzHOD+0vfKrXaroh5awNKeEV4ufdTKmKhF4GzOiZSQSOaHj8kUx9ck/0dNvKe7BQ==
X-Received: by 2002:a5d:65cb:0:b0:2c5:594f:121d with SMTP id e11-20020a5d65cb000000b002c5594f121dmr1401169wrw.12.1676459082018;
        Wed, 15 Feb 2023 03:04:42 -0800 (PST)
Received: from lmecxl1178.lme.st.com (176-165-103-159.abo.bbox.fr. [176.165.103.159])
        by smtp.gmail.com with ESMTPSA id h10-20020adfe98a000000b002c5501a5803sm10419916wrm.65.2023.02.15.03.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 03:04:41 -0800 (PST)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        op-tee@lists.trustedfirmware.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH v3 2/2] firmware: arm_scmi: optee: use optee system invocation
Date:   Wed, 15 Feb 2023 12:04:36 +0100
Message-Id: <20230215110436.1454781-2-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230215110436.1454781-1-etienne.carriere@linaro.org>
References: <20230215110436.1454781-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes SCMI optee transport to request an OP-TEE system invocation
context per SCMI channel. This prevents possible deadlock when many
Linux clients invoke OP-TEE are all suspended waiting for an OP-TEE
RPC request access an SCMI resource through the SCMI OP-TEE PTA service.

Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
Changes since v2:
- Fixed syntax issues (missing ';' chars), reported by kernel test robot.

Changes since v1:
- Updated to use new tee API functions tee_client_request_system_context()
  and tee_client_release_system_context().
---
 drivers/firmware/arm_scmi/optee.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
index 2a7aeab40e54..28a006348e1c 100644
--- a/drivers/firmware/arm_scmi/optee.c
+++ b/drivers/firmware/arm_scmi/optee.c
@@ -119,6 +119,7 @@ struct scmi_optee_channel {
 	u32 tee_session;
 	u32 caps;
 	u32 rx_len;
+	bool sys_thread;
 	struct mutex mu;
 	struct scmi_chan_info *cinfo;
 	union {
@@ -432,9 +433,15 @@ static int scmi_optee_chan_setup(struct scmi_chan_info *cinfo, struct device *de
 	channel->channel_id = channel_id;
 	mutex_init(&channel->mu);
 
+	ret = tee_client_request_system_context(scmi_optee_private->tee_ctx);
+	if (ret)
+		dev_warn(dev, "Couldn't provision an OP-TEE system context\n");
+	else
+		channel->sys_thread = true;
+
 	ret = setup_shmem(dev, cinfo, channel);
 	if (ret)
-		return ret;
+		goto err_release_sysctx;
 
 	ret = open_session(scmi_optee_private, &channel->tee_session);
 	if (ret)
@@ -458,6 +465,9 @@ static int scmi_optee_chan_setup(struct scmi_chan_info *cinfo, struct device *de
 err_free_shm:
 	if (channel->tee_shm)
 		tee_shm_free(channel->tee_shm);
+err_release_sysctx:
+	if (channel->sys_thread)
+		tee_client_release_system_context(scmi_optee_private->tee_ctx);
 
 	return ret;
 }
@@ -483,6 +493,9 @@ static int scmi_optee_chan_free(int id, void *p, void *data)
 
 	scmi_free_channel(cinfo, data, id);
 
+	if (channel->sys_thread)
+		tee_client_release_system_context(scmi_optee_private->tee_ctx);
+
 	return 0;
 }
 
-- 
2.25.1

