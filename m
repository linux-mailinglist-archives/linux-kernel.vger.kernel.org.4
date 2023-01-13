Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E6B66943E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 11:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241131AbjAMKeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 05:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240752AbjAMKd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:33:59 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1682A3C39A
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:33:58 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id ss4so44038279ejb.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pfc3GUmZnP2RdKEy7GTwIqjEf+awPwSAK/Qmsi/Wfvs=;
        b=egnJS1opNATsMNWsXs7JeuZ67px6IjkvzBCPIKOmikFcQf3MJT18MqBWPWfCXo99wR
         qpALckRxPTqDrMI/FsFfI5NoeKo2mqk69ctEdOTW4nGxNJSldP/B/P6IvmXJL62WLaVD
         PEMczugAckb6HqEy2e/Jsf4EFP3+ed5tuYizWejPkXd0uQdQehwk1DlMqeYgdoJLctqv
         Gob6eL1+N3nGQ650OtSzc9LfxXCHsHTGD8STKeo2TYnnS5JlOJr3mD1EVFtEdBJM7Qeo
         qlt2OtKcquJSHXNrbyka4U3t3m5SufDxIaCKwkEz7XgF7/KXvErOqoSVKf6sDr5xhqGR
         8Kew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pfc3GUmZnP2RdKEy7GTwIqjEf+awPwSAK/Qmsi/Wfvs=;
        b=WJhz/HgwM5DimkfTRYRIvdTKbRIjZy7v62CN1BAI7Ono5rLI/poY1JgMDm9iKXJ76W
         Y41OZ81XdEY62jWnkIuiYxVqS18PDnUFXXzEtn2ysYVkq7h27vd/bYJoqDvYOUtiNs/S
         8op07i7I+e9LXVGvTRAcRXwleA7+l6f7WHrTrd+boB6DurbdRXD3z66n5YatzgbBpfMs
         E0FhaZdwZ3WAe/YAUx5oXIE+ypQaiUmlEg6kfdI8vj3u52tZ273U0hLOAOUW9GVtxIe0
         /2n2DqSTmgLb7B11CMVYn8ud4rsn+i+gbpQgw3hKDv5hWHvEPZUoaq3xj5BBPyjKnIPi
         mYbA==
X-Gm-Message-State: AFqh2krM4qpbjghx8Hb7vUWMKKWNo1V2ymAQMNdyipztuHoEW1UYAney
        UdFsvCFBxw7UyISQEd9ouF9GzA==
X-Google-Smtp-Source: AMrXdXv3CQLjgv09Qjp6wfRt+2U0nEe+BwdFK51i2oADXH6X0O+xfbjp2b3IoRVxKw2+/zghiDcW+Q==
X-Received: by 2002:a17:907:6748:b0:859:aca8:fe4d with SMTP id qm8-20020a170907674800b00859aca8fe4dmr3236250ejc.46.1673606037704;
        Fri, 13 Jan 2023 02:33:57 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id qw25-20020a1709066a1900b007ae1e528390sm8296926ejc.163.2023.01.13.02.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 02:33:57 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 4/7] dt-bindings: watchdog: qcom-wdt: add qcom,kpss-wdt-mdm9615
Date:   Fri, 13 Jan 2023 11:33:43 +0100
Message-Id: <20230113103346.29381-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113103346.29381-1-krzysztof.kozlowski@linaro.org>
References: <20230113103346.29381-1-krzysztof.kozlowski@linaro.org>
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

Document new MDM9615 qcom,kpss-wdt-mdm9615 watchdog/timer compatible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>

---

Changes since v1:
1. Add tag.
---
 Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
index 93e4381067dd..1828eaf70b3b 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
@@ -40,6 +40,7 @@ properties:
           - enum:
               - qcom,kpss-wdt-apq8064
               - qcom,kpss-wdt-ipq8064
+              - qcom,kpss-wdt-mdm9615
               - qcom,kpss-wdt-msm8960
           - const: qcom,kpss-timer
           - const: qcom,msm-timer
-- 
2.34.1

