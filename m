Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DFF62D0C5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 02:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbiKQBo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 20:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbiKQBo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 20:44:26 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C49E25D4;
        Wed, 16 Nov 2022 17:44:25 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id g24so246651plq.3;
        Wed, 16 Nov 2022 17:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EDFRO4ir4ILg9SYyImo6kJHYqgKoQ77M/+5NG4Igr1I=;
        b=DiYy7g7FrHEWrc0tBV5wiCg1bpw+Gjmdk9uzx0JRFnRaLbgdVd+7R9sTnKp5t8iJQm
         WurTM2UP9HczRUJD1zwlouS3gR1bZZp3ozJUMvrMLKw9jXSDinVqcRp5zK54bPUopcNh
         GCuoNu6yCzey/rprSqhDl0oXg+8QT1w9w8QYONv+i57esurXzTfooN1HJrAartTB+pIR
         4nZfRV+S9hcTgwZUa7Qnsmo2t28pEIGOuXoSBg39NAukzXYLyLT0+UoqGtO2EGcYA7SE
         wiwUfCR6en+dIz5qtmzj7BZllh0KOGu0nczXp6snALGDAUNARumTaAJfA7b9eUM+opcJ
         pPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EDFRO4ir4ILg9SYyImo6kJHYqgKoQ77M/+5NG4Igr1I=;
        b=nGEinXTjU0kyZ23PmKQNVr/eTjKNlq33KcuXe56GCoTHHj9fuN8oq0Z4Wvnf7+RoX0
         evuGDRWnQYqGc+L2TW3P7XFdeYRBFGsgpOw1aif6v3W9MjZeDQg6FAwJuiNRYUO2fmkN
         P4EjXF8Wi6OmfxcXwXTl9dh6E5NLNXSydaB0gSvywR5pEd3KwavrFv8QtRQUJ2Yg+K+Z
         4Zvu5wZMvyrd8n5qaVQl/O+zPQUhQQb1EYnv6VgPPQkgg/FgKTQZ7EeT1qCXR4RPFe12
         0oLwchtK5/tqc+9BaXenU4dyFoB60hKN5IX6qfmlpKy/PjtIwpPF7ZNsk2JTKyqXPZ9F
         wV4w==
X-Gm-Message-State: ANoB5plzEy5qIIa6sYIGlL5FTubdig2x5CeNHL/S0nAliUFw0yza/tOg
        CmT+N3Sngpkl/E47Zqe8PkEFfOaEeUU=
X-Google-Smtp-Source: AA0mqf4tdjWO8Pv9D2HuJldcSRJNLFIJHgHoRyepomoy6EuCUurPitYdjAVOD4Ub0kWjY8N7yyiCdg==
X-Received: by 2002:a17:902:e212:b0:180:a0e6:f81b with SMTP id u18-20020a170902e21200b00180a0e6f81bmr559101plb.78.1668649464441;
        Wed, 16 Nov 2022 17:44:24 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2d1-d066-3cca-666c-d593-6ca1.emome-ip6.hinet.net. [2001:b400:e2d1:d066:3cca:666c:d593:6ca1])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e80d00b001869f2120a6sm13064337plg.108.2022.11.16.17.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 17:44:24 -0800 (PST)
From:   Owen Yang <ecs.taipeikernel@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Harvey <hunge@google.com>,
        Douglas Anderson <dianders@chromium.org>,
        Bob Moragues <moragues@chromium.org>,
        Owen Yang <ecs.taipeikernel@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/2] Adding DT binding for zombie
Date:   Thu, 17 Nov 2022 09:43:07 +0800
Message-Id: <20221117094251.2.Ibfc4751e4ba044d1caa1f88a16015e7c45c7db65@changeid>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221117094251.1.I74849cf9699b8ff2e47f6028e28861101297549b@changeid>
References: <20221117094251.1.I74849cf9699b8ff2e47f6028e28861101297549b@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    creating first device tree binding for zombie case.

    Documentation/devicetree/bindings/arm/qcom.yaml

    Series-to: LKML <linux-kernel@vger.kernel.org>
    Series-cc: Douglas Anderson <dianders@chromium.org>
    Series-cc: Bob Moragues <moragues@chromium.org>
    Series-cc: Harvey <hunge@google.com>

Signed-off-by: Owen Yang <ecs.taipeikernel@gmail.com>
---

 Documentation/devicetree/bindings/arm/qcom.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index c15a729a6852..878ecfbc1baa 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -578,6 +578,16 @@ properties:
               - qcom,sm8350-mtp
           - const: qcom,sm8350
 
+      - description: Google Zombie
+        items:
+          - const: google,zombie
+          - const: qcom,sc7280
+
+      - description: Google Zombie with LTE
+        items:
+          - const: google,zombie-sku512
+          - const: qcom,sc7280
+
 additionalProperties: true
 
 ...
-- 
2.17.1

