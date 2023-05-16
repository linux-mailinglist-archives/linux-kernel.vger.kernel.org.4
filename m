Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9BE704E34
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbjEPMym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbjEPMyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:54:25 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014E2269D
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:54:13 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3090408e09bso2917983f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684241652; x=1686833652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7B0ppPlpnqNlvLrDWw6A691nD5+RAL8Y7RlKrfxQcUs=;
        b=i8DkuUNO7jqjnmiTGpWShOI4F0dtKSFavowIVOFBQrBm5+jxryTOBAS8rlEesuGMuy
         Qil9RJA8Lfy+5jM+359EgQtVOYhrrusDTtOdtYLYuPcWl7wC4WJv87bE5WczG86Mpmsa
         jE3AUTGKfvtldAqz53Zx9pWEuGZdP4tsvoE+B2htbfcQS1egDBkBKz4YehQRJBapA6Jc
         rdrIvOyYpZJyftD0L5JxenLTaB/rrMcHeZW1H7D7kfLj81+/V/bXnCKF/RCU7Wt/NQlh
         dOc1Dr46Swod5TiQLagjJk9D4Xqrp2yqOW2z5jaFnmUddGH/PmRGx4AABMvrE4XJoXhj
         wRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684241652; x=1686833652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7B0ppPlpnqNlvLrDWw6A691nD5+RAL8Y7RlKrfxQcUs=;
        b=IpgrpV6j8CWLRmxquSuUak/5oDCjOUv/W7I14bYibjNwrbAeiQCVsEmTkRK+GDAh6+
         /YHtuzpOlTpvRy2Cu2uQJbiEA+B6+E9Ds5dKvlFqrdd+ggUJpnbbAfO3vtmEyRfEkrRI
         G7vWoII4KSAfNV34NvU48OWqDa/oAcCrX0Ii7JhM9Wn3GuBhThc5PXt3Iw1CjosnOJK/
         EpcE6d3ugKG9YsoDhXoQ4WQNu4sgvkLS10dR9vYbIlT0SdGeFm68DOkJRI86/yP6d1/n
         yJdupv+N83bMqywpHmTIsClVozbbkVopLZd6dxWBF+ilVGK845IU3EKOwJlWI0EZCVFP
         0H3Q==
X-Gm-Message-State: AC+VfDyWxYDZqKwFb4gcQL9znZYiENAELTAXQajc5q/Ofoy8YKasgnoU
        2GUwCDOeCOh56cskPtroTAka0SsGtnxeCIT/mxk=
X-Google-Smtp-Source: ACHHUZ50KLhm96H8lf/YBH4BlkA2lKLNNueGedVaZlua9xQGiWfUfsr0vxjrKcq0uJq9oJPYm6tnmw==
X-Received: by 2002:a5d:4684:0:b0:309:3698:7feb with SMTP id u4-20020a5d4684000000b0030936987febmr1024123wrq.46.1684241652102;
        Tue, 16 May 2023 05:54:12 -0700 (PDT)
Received: from lmecxl1178.lme.st.com (87-88-164-239.abo.bbox.fr. [87.88.164.239])
        by smtp.gmail.com with ESMTPSA id r18-20020a056000015200b003047d5b8817sm2521963wrx.80.2023.05.16.05.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 05:54:11 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH v8 4/4] firmware: arm_scmi: optee: use optee system invocation
Date:   Tue, 16 May 2023 14:51:11 +0200
Message-Id: <20230516125111.2690204-5-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230516125111.2690204-1-etienne.carriere@linaro.org>
References: <20230516125111.2690204-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
No change since v7

No change since v6

Changes since v5:
- Applied Sudeep's review tag

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
index e123de6e8c67..25bfb465484d 100644
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

