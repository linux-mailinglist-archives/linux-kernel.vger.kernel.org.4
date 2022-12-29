Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE97659078
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 19:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbiL2Ser (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 13:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbiL2SeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 13:34:15 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A862F5A0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 10:34:15 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id kw15so46758406ejc.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 10:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXKNJ1J6Lsp8k0SIwGKGS7Q0ipF67IrwBVbQHNzAoBU=;
        b=M8Pk7N/H2os6BSaRPHa/SnYYrwf5fCOP2GVc/7uz1AbklBGyEeT8f9DAV6tvTzDxAE
         75e+BDfLdkLCFCdRcPoaiPaqC2E0maYIV3sczUgSWJkB+HJf0AJsq9yll2uF1QxseR7m
         MJFxYgMLJpbDkEsCGdv5DbADCu8+FapDvVpiaEnQaAKOj80MHTnLmN6aZS8QBLLCrYpU
         7Nab3O4U++tj4XWSBANo6s1X17KFWk50+khhKmw9AuF8NubcgMsYyYgPQO+fhXecK/fZ
         XmzWDnH0Wd2MzijMXsRZbHz64BgdGtR8Ft+AcfxXv0Ch9Ypnqq/w6hlgIdBIxd4QQQ/A
         wGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXKNJ1J6Lsp8k0SIwGKGS7Q0ipF67IrwBVbQHNzAoBU=;
        b=e+FJhT+ZP1jTP9TOKgx9BUCiHMPqPuDIpNqK6V5o3c5jDbt+brKxz/5gw7ivpk8lvZ
         cjTJieU7ZWC3BliYXz0jmbtNx0kaFbv8i5DN42oWZj60OUgicb9sbMQ3jylMM7k2lYKA
         p7t0YMGQcT7r2aW9OvXVcZ2ZrbbvynN1gWG0dydCYEgl/CSK51cYTK9aSlhGOFZc2pBZ
         pBwJVy6U9pootKsTrCofKO3cBhZ657l4bZxMqJDh/1cPm9j2CrtFlN/Wjq4Hnsx8wE7X
         +ALEmuZRppInF4aTCTjbAQtGus0GmxmnPJVCqe/lT7HcQ6FKRiTNhx/6pS/b9N2BQlx9
         2vWQ==
X-Gm-Message-State: AFqh2kqGnJQwmtjOjQhL4WczAZ9gJC5L4AObl9wdtXTRZemC+I0lLbpg
        w1j2npzAHtXQeWzhboPxfOpXVA==
X-Google-Smtp-Source: AMrXdXtPbNLhLa24gVerdkNtAMJWqBLZdt11LDIbsHOmT54yzYbO2XvTuSa6HT8CKAZmDMOqFhLmNQ==
X-Received: by 2002:a17:907:a08d:b0:7c0:dac7:36d8 with SMTP id hu13-20020a170907a08d00b007c0dac736d8mr25614107ejc.10.1672338853657;
        Thu, 29 Dec 2022 10:34:13 -0800 (PST)
Received: from planet9.chello.ie (2001-1c06-2302-5600-12a8-8cf4-e3f6-f90f.cable.dynamic.v6.ziggo.nl. [2001:1c06:2302:5600:12a8:8cf4:e3f6:f90f])
        by smtp.gmail.com with ESMTPSA id g22-20020a1709064e5600b007c0688a68cbsm9013936ejw.176.2022.12.29.10.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 10:34:13 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bryan.odonoghue@linaro.org
Subject: [PATCH v2 1/2] dt-bindings: phy: Add qcom,dp-manual-pullup description
Date:   Thu, 29 Dec 2022 18:34:09 +0000
Message-Id: <20221229183410.683584-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221229183410.683584-1-bryan.odonoghue@linaro.org>
References: <20221229183410.683584-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
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

The original Qualcomm driver for the HighSpeed USB PHY contains a flag
which tells the driver that the controller and PHY do not connect to VBUS.

In this case an external IC such as a Type-C port manager supplies VBUS and
the VBUS signal is not routed to the SoC. This means we cannot detect the
presence or absence of VBUS and cannot take action based on it.

Document the downstream boolean qcom,dp-manual-pullup to allow the HS PHY
implement the necessary logic.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
index aa97478dd0161..c55a59df71ad0 100644
--- a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
@@ -80,6 +80,13 @@ properties:
             the address is offset from the ULPI_EXT_VENDOR_SPECIFIC address
         - description: value
 
+  qcom,dp-manual-pullup:
+    type: boolean
+    description: This flag indicates to the HS USB PHY driver that it should
+                 enable or disable an internal pullup when powering on or
+                 powering off the HS PHY instead of toggling the value when VBUS
+                 is absent or present.
+
 required:
   - clocks
   - clock-names
-- 
2.34.1

