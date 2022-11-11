Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A9A625752
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbiKKJx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbiKKJxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:53:25 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731F2BED
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 01:53:24 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id io19so3847725plb.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 01:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l8aDxDsNnGd9Cti6vqMoMN7YUwle0jy3PVcJaHD2rW4=;
        b=Wu1zQP8EzPVqNDzRo8j8C0Xo3hhPg6iViTQGEnZepBOg9p03rjrgpYMlPw7aOlaK/q
         FDHsTrtL1xO2WzglqEjy87RlpbE+i/BUqCkNAdDaJ1Tr0R2uVE3Lmi+diDNQeBVolnFc
         Z9qkQN7QtqGhEGvREKwBJ18z5qn66ZZgDkUZL0QX9lmhFkp28DpLKtz2elrieaQf600O
         jK6v2uWD1h4fdJyPQr54ISGEVsIcFaZU16OSDGCkCGoXW2qGLunTeHVPeuPw+FmAjvAa
         LWO3SDH+6mRNli12b14lNoWw8X7JSEJOIA0lTw57OCvvX9b+UWjA9roZtxhJnWsCDUVC
         4g8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l8aDxDsNnGd9Cti6vqMoMN7YUwle0jy3PVcJaHD2rW4=;
        b=Muhzq7HCQNq1xnTZfNfaMY6678bFLAs/HkEq/Bn0hEWEF2C7kaTqg0htErPVUQavv1
         SW68FbyIeVV+dzex/dRa0PPnGBFTajXTr2C2HR2MgHtivW3cT9SBM8iMCChlBf5zZrgH
         pJVOHx6TXa7+ZkyylVJlW/PgMQZSHzdel9JDh+sCrE14TGb9xWFxBzcImkVsdpg3L3Lq
         NXpN58R4Fe+nR/F4dUqU5dt2IvgijMcoY+Wy6wfokN0wO4S1FC0xGD2LE7kDGMYCk1K+
         wzToLf32FMz212ZWOxzMnHOUzfq+KgXjNwvc/cBZNnHSMIsVn7ejcVjy5EPbrtSvGHOC
         G6Ug==
X-Gm-Message-State: ANoB5pnwypfUrgb0LKE+Phg3J/UMhMMwVIMKz2LAJqTk5xxXWlz+dv1p
        XUMdXZC2Ai6ix8V4evNOV+oRpQ==
X-Google-Smtp-Source: AA0mqf42efNqQh0ZHyiZ1BEVeklQH50qPLWGdjt9msce9pDA/5Xb/0iTmCZijwdkYcmiO9QDX3PwlQ==
X-Received: by 2002:a17:902:8d8f:b0:179:f94a:6fda with SMTP id v15-20020a1709028d8f00b00179f94a6fdamr1778751plo.118.1668160404006;
        Fri, 11 Nov 2022 01:53:24 -0800 (PST)
Received: from sumit-X1.. ([223.178.212.236])
        by smtp.gmail.com with ESMTPSA id b14-20020a170902650e00b00177e5d83d3esm1263094plk.88.2022.11.11.01.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 01:53:23 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com,
        Ludvig.Parsson@axis.com, jens.wiklander@linaro.org,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH] firmware: arm_scmi: Resolve dependency with TEE subsystem
Date:   Fri, 11 Nov 2022 15:23:13 +0530
Message-Id: <20221111095313.2010815-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The OP-TEE SCMI transport channel is dependent on TEE subsystem to be
initialized first. But currently the Arm SCMI subsystem and TEE
subsystem are invoked on the same initcall level as subsystem_init().

It is observed that the SCMI subsystem initcall is invoked prior to TEE
subsystem initcall. This leads to unwanted error messages regarding TEE
bus is not present yet. Although, -EPROBE_DEFER tries to workaround that
problem.

Lets try to resolve inter subsystem dependency problem via shifting Arm
SCMI subsystem to subsystem_init_sync() initcall level.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/firmware/arm_scmi/driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index f818d00bb2c6..f43e52541da4 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -2667,7 +2667,7 @@ static int __init scmi_driver_init(void)
 
 	return platform_driver_register(&scmi_driver);
 }
-subsys_initcall(scmi_driver_init);
+subsys_initcall_sync(scmi_driver_init);
 
 static void __exit scmi_driver_exit(void)
 {
-- 
2.34.1

