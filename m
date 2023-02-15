Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75B3698187
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 18:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjBORCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 12:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjBORCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 12:02:51 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2638A60
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 09:02:48 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id f18-20020a7bcd12000000b003e206711347so1079911wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 09:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiZADvWOmxCdPIUazfbuTYmfEz/1yOYWessMhqvHszk=;
        b=dNPM7pL8rUSgc2jImPNKjwMXskjKNPF92j+W7BvGiWNoCyqXMGJjeiJnsFASxSbw1x
         BdyBuBGuRhFCwAhQAqSZXbBE1sGpoHhlHQftxTw6iS2SG+QJ67KbSVywRG5zyZ6vlLvC
         h90CUmLnQF0kfM7LVwSlkL6X2yMtSG9T4rQSb4HIFhJK6svycNoFF5SsCZSlvdg38TnM
         xCBBzCckeLLK9WdbleYwoSGRErxGb9FpVB0CWIdvavHjxvQVLJ4ErHW6TjcHoMR/WNpr
         16aZ6SqqlJhyOjK6TPHHzSZJ8ZRJUYHvK7fVSThJd0NR08URygAYQuAoExueg5M3XIhD
         dJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WiZADvWOmxCdPIUazfbuTYmfEz/1yOYWessMhqvHszk=;
        b=u1uJVBaep4coEGLIRmmPpcXNwA34aFX6TqMwmSZMYhO7Lf0SMlCihtZHOBkE8KjWRo
         IEOTQQVXjrqaeAqN74aiiJSskmONvRtuefY3AJTI8nwT9qbtc/sWXviG0WV+Dz5kRYF8
         Oczio4cqDPN7Y8UpzVAx+bWS6NKaWv4hXZpRghte3YmqmL6AduCaRweQIXu1G+dNvM6l
         k5UcjaSImB9P3C6pbZoqEWt3Ik78PAMfqfc3lRygoIvci4UauEdVq+weV4dm9cZH+2sF
         rkgBPQ+WpY0HujonboqXPGJNHW7geVo6dI3fGqomgWKPQQFDnwHK0uzA/m+HSvRX/m2C
         OqHw==
X-Gm-Message-State: AO0yUKWefRdpFw5su5Crq9T7wQCrG9xojgxCdhPL4h9sQ4iwl0fxqbph
        VhHzQZGFfXsR6+xsCfdOKunAO0+F8yKUJohv
X-Google-Smtp-Source: AK7set9lwS1FJrOeQaKOqyxbs6IcpeDLkn/cpCKO3rYtS5QGwP2it0Kqho+hBDKMHykhGMegaHSYyg==
X-Received: by 2002:a05:600c:4488:b0:3d9:fb89:4e3d with SMTP id e8-20020a05600c448800b003d9fb894e3dmr2559026wmo.28.1676480566248;
        Wed, 15 Feb 2023 09:02:46 -0800 (PST)
Received: from lmecxl1178.lme.st.com (176-165-102-236.abo.bbox.fr. [176.165.102.236])
        by smtp.gmail.com with ESMTPSA id c2-20020a05600c0a4200b003e1fb31fc2bsm2941556wmq.37.2023.02.15.09.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 09:02:45 -0800 (PST)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        op-tee@lists.trustedfirmware.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH v4 2/2] firmware: arm_scmi: optee: use optee system invocation
Date:   Wed, 15 Feb 2023 18:02:38 +0100
Message-Id: <20230215170238.1864311-2-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230215170238.1864311-1-etienne.carriere@linaro.org>
References: <20230215170238.1864311-1-etienne.carriere@linaro.org>
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
No change since v3

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

