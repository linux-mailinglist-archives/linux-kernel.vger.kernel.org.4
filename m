Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45C06FFFF8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 07:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239941AbjELFmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 01:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239806AbjELFml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 01:42:41 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586684202
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 22:42:40 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-307d84f5ce4so520902f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 22:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683870158; x=1686462158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3sWptRJ4HCeO/3jgQ00+CgJQMZupq2nS86x9qoxAVo=;
        b=oZeB7VbYT00G91DAclJhBSsDzdlBIhNpC7OTsRbUqOwZn5mpv9ufQJ7xCK4NbjULhv
         rAYjh8TEFxluHS5BdGDDr+0YNDYrvsaphmwMjVOxBshm44P/xf898xJBk0T8OvG1PCHH
         rM8R7f1u7aCHvOW0arlr7DqNlGFazZXDVYUgGzdsX1UtrGFu9dQVU1Yg3HLMwOac1c6O
         NPFUftf+aOJZcSjEPBTwwrOl1rn3w8a/aKWWemff06gBHBqBPZZxixNcEkOGDt72z/lE
         l9O3A2QA4HfClgNE0AxC1yPQcJBsP89TTgSamouNqFPkf1+6hkhMnbILM5l+nnmpKE5Q
         bDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683870158; x=1686462158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q3sWptRJ4HCeO/3jgQ00+CgJQMZupq2nS86x9qoxAVo=;
        b=FBZjmDDhRtiU29hb1cw/NcHvsMeTZ5ft3sTAoc4KQIrGWEzpwDSZ74o2gcVRsVdlpk
         kDnfT7q+dj8aI0KAHWSjnX+di7xPUDKbyUZ0d104Pzl9hHWj+/2wX478kurRxNmq5Tp1
         BgzTFxSLiZ8TWexlf8Ikc+dFOimkHyAEnQELinmo3IRTZf5dyBSO9ZieKOQJGH84WaDk
         dXDPginthtC5LcYdG4DZDaSbmmWqL027YO35Xx/D4LlzNm82TKOwISt06WtFEBQhqUXD
         IM+J/7rB9I8bpNQdgeAHcNLu3rALbEeUhJ3gabHUScdnhv+XXrmsvf/dRI9tFvfs0771
         R9Dg==
X-Gm-Message-State: AC+VfDxlkahLZNGViUju/VvW2MhYkb8PmEhS4EWuqcnSu/gKGjXtnxO0
        d2AJ4/G30YAGty0M0BFlC/J9NEQU68egVpN2Shk=
X-Google-Smtp-Source: ACHHUZ4OFiUwFCNp8LOXM1mxpXcRSDxkQteOStR9vzulYjXmFEBoejaLR9m/EK9eVWQRyg58Wmea4g==
X-Received: by 2002:a5d:5968:0:b0:2c9:e585:84b0 with SMTP id e40-20020a5d5968000000b002c9e58584b0mr14693910wri.1.1683870158633;
        Thu, 11 May 2023 22:42:38 -0700 (PDT)
Received: from lmecxl1178.home (lfbn-nan-1-1169-52.w86-212.abo.wanadoo.fr. [86.212.112.52])
        by smtp.gmail.com with ESMTPSA id j18-20020adfff92000000b00307bc4e39e5sm6301253wrr.117.2023.05.11.22.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 22:42:38 -0700 (PDT)
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
Subject: [PATCH v7 4/4] firmware: arm_scmi: optee: use optee system invocation
Date:   Fri, 12 May 2023 07:42:22 +0200
Message-Id: <20230512054222.2088837-5-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230512054222.2088837-1-etienne.carriere@linaro.org>
References: <20230512054222.2088837-1-etienne.carriere@linaro.org>
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

