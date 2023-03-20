Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0206C1BC9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjCTQfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbjCTQeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:34:46 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B7D227B6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 09:28:15 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b20so16081676edd.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 09:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679329693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VruUI//IRhqNmoD8Q5azVtaM6cIQmuR0hWrVWNp3gY=;
        b=j3GTB6zHSKFYXwDQR3E75kyaRy94kg9SJlGrDtLjgfeNNL7C8a2zIQZMBiwZzaBOvq
         A1oKUQGCLqHpSxoFOgQw9zITYp9gl02CN4IW+PAogO2SoRMuw3oedfXd+Cy127sMqQTQ
         lDxV/2E+ahZe4v1wUuqxnbVhWvUmXQF0k423ZD4GKDrh+Sf7nKyiH1+Sjx6O1AjYs/AL
         uk8FC7STV5uZ5glOfJkSoevW2AscX9m0mK5pl7hR9u8LKSBbrjI7HVtngg42YmTKRgLk
         5E++zMI29aqhLBI+RF9FGUZW5m3cbkP/KwJ+4wnmv3e9VJzmDP0PITYiozSWQPJ7TB8L
         nIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679329693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5VruUI//IRhqNmoD8Q5azVtaM6cIQmuR0hWrVWNp3gY=;
        b=MJHe9CPy2Gh6iVUecr/GAOUhp4W9UbSBfOflD5rTCv+Pr8I/Cy5QRIKXlivZbR0iam
         yvMU+ILKNEi5nMzuKxHwdA9URbRu2s7dCu1Qf1XNmnn2ziodxo2xg5R0FME5bDrxODC9
         4olMelg0qnLVfJK9evDMELyBI9z1QSAtOluitw6taIByroNgBk1jxV8c/wvHwAPGbWcH
         484ygsfePjSJN9EZm5iuy8B5oZEwKpTesCSZJ/lPfhmJkQsjxwTDQ2QuSIvyQRXRdl4t
         UY+LqnVHoyi6eXGsGu6YCSFSz7/XhwpuT8dDghBMEntq+m3HFAoAxjC8flsXuDhV0I5w
         KntA==
X-Gm-Message-State: AO0yUKXYRmWlzZmr5seAA6cRHOkYNXNZuQyeblDsLh+AJnZvJd7Ihccf
        qTmd6bRAXRixGAfm5y63qGIEVgr1utRd4hXllFU=
X-Google-Smtp-Source: AK7set9Iv6t2+PyYJsM6ejBSCEG9d1L/0eAS+5joUH5SJA6dhXKXvwsVY0nnH2B8M0poXUoHdOlTxA==
X-Received: by 2002:a17:906:7fc9:b0:8ab:4c4:d0f6 with SMTP id r9-20020a1709067fc900b008ab04c4d0f6mr8657609ejs.56.1679329692978;
        Mon, 20 Mar 2023 09:28:12 -0700 (PDT)
Received: from lmecxl1178.lme.st.com ([2a04:cec0:104a:5611:7bcb:e0c2:1993:f82b])
        by smtp.gmail.com with ESMTPSA id b17-20020a17090630d100b009300424a2fdsm4646335ejb.144.2023.03.20.09.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 09:28:12 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH v5 4/4] firmware: arm_scmi: optee: use optee system invocation
Date:   Mon, 20 Mar 2023 17:28:01 +0100
Message-Id: <20230320162801.2811542-4-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230320162801.2811542-1-etienne.carriere@linaro.org>
References: <20230320162801.2811542-1-etienne.carriere@linaro.org>
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

Changes SCMI optee transport to call tee_client_system_session()
to request optee driver to provision an entry context in OP-TEE
for processing OP-TEE messages. This prevents possible deadlock
in case OP-TEE threads are all consumed while these may be waiting
for a clock or regulator to be enable which SCMI OP-TEE service which
requires a free thread context to execute.

Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
Changes since v4:
- Updated to new API function tee_client_system_session() introduced
  in patch v5 2/3.

No change since v3

Changes since v2:
- Fixed syntax issues (missing ';' chars), reported by kernel test robot.

Changes since v1:
- Updated to use new tee API functions tee_client_request_system_context()
  and tee_client_release_system_context().
---
 drivers/firmware/arm_scmi/optee.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
index 2a7aeab40e54..22a755160c2f 100644
--- a/drivers/firmware/arm_scmi/optee.c
+++ b/drivers/firmware/arm_scmi/optee.c
@@ -440,6 +440,10 @@ static int scmi_optee_chan_setup(struct scmi_chan_info *cinfo, struct device *de
 	if (ret)
 		goto err_free_shm;
 
+	ret = tee_client_system_session(scmi_optee_private->tee_ctx, channel->tee_session);
+	if (ret)
+		dev_warn(dev, "Could not switch to system session, do best effort\n");
+
 	ret = get_channel(channel);
 	if (ret)
 		goto err_close_sess;
-- 
2.25.1

