Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E176B5169
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjCJUHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjCJUHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:07:07 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36916127118
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 12:06:57 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id ec29so25220229edb.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 12:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678478815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YIfiMP3YESLd/oa/N7VLY54fnA1n1mTobvMyaeAJG5I=;
        b=iGQt9h62mnOTsUoZavnl37r/m6EoFfEyryWnN1OsmzpjCwdXw+DPmgZQYPg34N9Sut
         GBePtrnBp0ZKDZ7tKGeeOSr72F/QLtTC3uh04U3j1sBy/LP124DbBOZg3BNJBrgTHFB3
         XoGmwC0Uemtlq6tJ6saDG6/9Uv0LOV3vQhpuOQead4HZWLZTqxz8nD0vifOYsfY41f6x
         etSSU/8Q92k5hPLlXOcCbaui8VMt/qNfsLByZkmISBwhr2n4u96Jyy4mSmfNFlsihoy8
         nz8Imtz50qcLgjx2oOVuOeBpgxu7WfIa0wcNzXdeNj5X5K2l0Ecscnv8Ez3vms67Nt+g
         B6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678478815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YIfiMP3YESLd/oa/N7VLY54fnA1n1mTobvMyaeAJG5I=;
        b=DB08VK/SrlV9CCVpnxMwlqAbGDoMvwdgGERKscwBBtHybrtKuKbmLfVyW3U/SWw8lJ
         vt+ZAkVYtmeyref8iHBVhu9CImgnAvhl3+jwxKXPphkm+yHVWp2SbI9y4BC8rmZ2L2Xb
         DJfmVhcqPv1Rwc8hOMAA2BSMWLGMPx3f6QCXGi41fdTptcfuS9/i2NV4GWQ7tI53afSq
         GyRYO1+uZ/sUtnoShM5ImTAJ495naVAQvZSWM3oyNMJz+XI5nT0YjCbR54MEBBwQ398a
         UIi1F6T8GfGpDTQZ6E1zBqzHyuiWX2YbSJijqC1tyGSrtKOHD8dsJ8Yw3OFcpLbJY/fA
         YUaA==
X-Gm-Message-State: AO0yUKXL8ldiPXqEgicelhWhD28PeybeIljaQli6HqIDznMS3hMxvdyn
        Gk6JHS2BrrSQh1LrxPhoXqcAlw==
X-Google-Smtp-Source: AK7set9dhsGv4dhMKgAdhPFfT8I0cHuw6MK8CUdJF+4SF1RDBXCP/KvCfvd2pZjlUPEoFRIcVZ1STg==
X-Received: by 2002:a17:907:9719:b0:895:ef96:9d9b with SMTP id jg25-20020a170907971900b00895ef969d9bmr29890226ejc.30.1678478815726;
        Fri, 10 Mar 2023 12:06:55 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:34:52e3:a77e:cac5])
        by smtp.gmail.com with ESMTPSA id mp27-20020a1709071b1b00b008d398a4e687sm234154ejc.158.2023.03.10.12.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 12:06:55 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] power: reset: qcom-pon: drop of_match_ptr for ID table
Date:   Fri, 10 Mar 2023 21:06:52 +0100
Message-Id: <20230310200652.19926-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm SoC power-on driver is specific to ARCH_QCOM which depends
on OF thus the driver is OF-only.  It's of_device_id table is built
unconditionally, thus of_match_ptr() for ID table does not make sense.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/power/reset/qcom-pon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
index 16bc01738be9..ebdcfb28c4a0 100644
--- a/drivers/power/reset/qcom-pon.c
+++ b/drivers/power/reset/qcom-pon.c
@@ -91,7 +91,7 @@ static struct platform_driver pm8916_pon_driver = {
 	.probe = pm8916_pon_probe,
 	.driver = {
 		.name = "pm8916-pon",
-		.of_match_table = of_match_ptr(pm8916_pon_id_table),
+		.of_match_table = pm8916_pon_id_table,
 	},
 };
 module_platform_driver(pm8916_pon_driver);
-- 
2.34.1

