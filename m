Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852FD6809D4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 10:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbjA3JmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 04:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235725AbjA3JmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 04:42:13 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A195FD9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 01:42:11 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso4857550wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 01:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0t96y3FkXLiiInAiF7GMyUM6Gu9zpGQXe2nbijo00u8=;
        b=ybsShXm5tTFAPukgpSLb+cbxoAvhAgJCNnyXmTkKCJ37DAqqHf/XjSI0FbLgeK12w6
         HZPRA/1JQiCBoKbAuXfluzsutzTcA/vkCzQC1w/ru5ZQ2WRPdornAJ2a+UNJ/mdgwHER
         rwu1hbj403wQ+qTpY8TNhv0KyZk5fQPmGRhwwESfxwkrcsRkAJtjJpyqRtm9ZpQ68H3I
         jADislAuT59q4au3Tclzf3OCxWclBO6hAAJ4Acsw1i4icQVLemj2+AjvPQxj6WMJOn3c
         nrZt86VmC2toRWTFJtTRKoY2E+E1faQu2UMGQTOG41OnJmYBxg00pzYLnPaf2HLrR4Ri
         P3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0t96y3FkXLiiInAiF7GMyUM6Gu9zpGQXe2nbijo00u8=;
        b=EWJidWVLKOxl/1H/OJvRsV0nTel9Kd83fqo6LmhjQClBFmthkBx8H5FKl0ph0SyAXV
         SuFnJ0Wat0ieOGzSHUDAX72lodSEleoZCe3mUzHVPz6BxXE065CoRPRT2ZWlysrWcX+H
         f58psXMI1qD/o8+oNjHi9bhN5x4d3Xo7jxr8HwQQx9zg4F6IjqVZZJYlO8x9F2KLhKds
         PvGUFFjmcJgmEqPcqQNQa8lGFaFaWawlnLk1ZQ9xG2Cr8iR/mmZBPWv1RD/l9ZSvlBGI
         FgGOmAr0t2BL+f7oPR1xOsgC4jJWgnLDf6kpwgd3l00nd0s61cftZqRSJh6R3a97Z1jP
         rWNg==
X-Gm-Message-State: AFqh2kqY/TGVjY/CnQcTsm6noFlqEjO+/loTymVuUOkjke3ECvI65VbJ
        XLQuQrnqCDIdvOZM8RXlIJ32ng3BR962tUFH
X-Google-Smtp-Source: AMrXdXuC+dEKXJlmfv5Nn2MwvVWClowQHDNX7f6bEFuAizBj3VRG2y8pN35Le3YmF/KEKjYh0vUvIw==
X-Received: by 2002:a05:600c:444b:b0:3da:fd06:a6f1 with SMTP id v11-20020a05600c444b00b003dafd06a6f1mr47372661wmn.31.1675071729531;
        Mon, 30 Jan 2023 01:42:09 -0800 (PST)
Received: from lmecxl1178.lme.st.com ([80.215.193.251])
        by smtp.gmail.com with ESMTPSA id i27-20020a05600c4b1b00b003dc54d9aeeasm3865606wmp.36.2023.01.30.01.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 01:42:09 -0800 (PST)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH 2/2] firmware: arm_scmi: optee: use optee system invocation
Date:   Mon, 30 Jan 2023 10:41:57 +0100
Message-Id: <20230130094157.1082712-2-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230130094157.1082712-1-etienne.carriere@linaro.org>
References: <20230130094157.1082712-1-etienne.carriere@linaro.org>
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

Changes SCMI optee transport to enable sys_service capability of
its tee context to leverage provisioned system resources in OP-TEE
preventing possible deadlock.

Such deadlock could happen when many Linux clients invoke OP-TEE are
are all suspended waiting for an OP-TEE RPC request access an SCMI
resource through the SCMI OP-TEE PTA service.

Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
 drivers/firmware/arm_scmi/optee.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
index 2a7aeab40e54..91840345e946 100644
--- a/drivers/firmware/arm_scmi/optee.c
+++ b/drivers/firmware/arm_scmi/optee.c
@@ -559,6 +559,9 @@ static int scmi_optee_service_probe(struct device *dev)
 	if (IS_ERR(tee_ctx))
 		return -ENODEV;
 
+	/* SCMI agent can used TEE system service resources */
+	tee_ctx->sys_service = true;
+
 	agent = devm_kzalloc(dev, sizeof(*agent), GFP_KERNEL);
 	if (!agent) {
 		ret = -ENOMEM;
-- 
2.25.1

