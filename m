Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2DD696819
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 16:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbjBNPaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 10:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjBNPaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 10:30:14 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC19252A6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 07:30:13 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id o18so16084377wrj.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 07:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZaj9uTvJGoga0iJH/48gNUnrybDI9fdV0k7oGNbvSE=;
        b=nO83UxELRVQF2lj+JaJMVun78CpOi5C9SnvM9yW0ivcYzX4Xhy16Vpf+YsZOhyojjd
         ZYWf7n9uXo4zM4DFCh5ZaYFTo6NBFPbmCaQAcBTe1O8NolN42m71efRl0LuMhmP14ra4
         sY7DLtHExGbdzny9s9AQd6Y77ZFtYq8EDwJ5BB2jIDGL+bPhEr05Nq7cf2hjCAeVPu6d
         HCulzo7u+DTqOnt61r/kJb4FWneK60On/h42TpN/YDgqGk/xj0EgGJtGHGc+meeGfH3y
         0at/RNbazjz5gvrgeWap+is1ShmqyxThDCvA67Jt3+nGqh/VG2qO1OYnntEhzUTFIgBk
         lkpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZaj9uTvJGoga0iJH/48gNUnrybDI9fdV0k7oGNbvSE=;
        b=G8WLyblyf3t2gzA0yk5NUK5XypHz7MHcxywJFl/ekYlQxDlT57R+cbv0ykxHQ+Fzev
         g3g3x8GKTLVxQ/O4ZzV3R3l+hcMCDLUw6HnTYcbL2Jdy9gZLouRF50gu3InLRXYAS2vu
         oCzhG9mHUA1EuWNyV4p2vJQr2rBCdJZX+wZnRmJ2/NtjN0icw/U9GjZgD19G+IklNTMW
         pejZFZhjl9dOOxlZxG71ECTOwExcZUloMZlRIh1lOPEasHGhV6mYuAAg0ku63UGQVDBV
         yayZH5al23iYqbxDfeaa9DzJtAXim6zSFiifN7ZPP3lobp3GkQt8r9STHgBnjcvg96OT
         rzYw==
X-Gm-Message-State: AO0yUKUTfHeqEQrBKdllefl+e5v5V/OaPZ2x27xfuEe1+4wZoNDTFlfU
        gbUMCat6gADrSOhL5gd8QBGYYOx9jWkH8s/4
X-Google-Smtp-Source: AK7set92kZLDRXgdUSfTasq0IR59Q8GBXr8dP8A5HltZe2YJ6SPVXK01up77huc+bLMAMOHhgPUldA==
X-Received: by 2002:adf:dfcd:0:b0:2c3:f0ed:4beb with SMTP id q13-20020adfdfcd000000b002c3f0ed4bebmr2533044wrn.70.1676388611571;
        Tue, 14 Feb 2023 07:30:11 -0800 (PST)
Received: from lmecxl1178.lme.st.com ([80.214.29.100])
        by smtp.gmail.com with ESMTPSA id a4-20020adfeec4000000b002bfc0558ecdsm13224166wrp.113.2023.02.14.07.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 07:30:11 -0800 (PST)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        op-tee@lists.trustedfirmware.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH v2 2/2] firmware: arm_scmi: optee: use optee system invocation
Date:   Tue, 14 Feb 2023 16:20:47 +0100
Message-Id: <20230214152047.1143106-2-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230214152047.1143106-1-etienne.carriere@linaro.org>
References: <20230214152047.1143106-1-etienne.carriere@linaro.org>
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
--
Changes since v1:
- Updated to use new tee API functions tee_client_request_system_context()
  and tee_client_release_system_context().
---
 drivers/firmware/arm_scmi/optee.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
index 2a7aeab40e54..fe91e2de3f9c 100644
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
 
+	ret = tee_client_request_system_context(scmi_optee_private->tee_ctx)
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
+		tee_client_release_system_context(scmi_optee_private->tee_ctx)
 
 	return ret;
 }
@@ -483,6 +493,9 @@ static int scmi_optee_chan_free(int id, void *p, void *data)
 
 	scmi_free_channel(cinfo, data, id);
 
+	if (channel->sys_thread)
+		tee_client_release_system_context(scmi_optee_private->tee_ctx)
+
 	return 0;
 }
 
-- 
2.25.1

