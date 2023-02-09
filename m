Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7718D690453
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 10:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjBIJ6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 04:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjBIJ6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 04:58:01 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF58E1ABE1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 01:57:59 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id n28-20020a05600c3b9c00b003ddca7a2bcbso1066784wms.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 01:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQYt7bPE7+yoK0uFXiir+snqUYSV/63iwqp5X9wGaYA=;
        b=pQ5cW30yFem/wh2/ys3M2j1jYT6VgldXATOGIQDXDG6DFwwMQfTJvXjAqPEZ8BlOim
         rPIbA5QWasLBWxOkl+lgqNk0Rl1WBszKWNMMSglt6zG1HC7Cs5EKu7d3pWQhx7lsd5dE
         Bhi8u3sG9gA9Tc6UBQwLdBW0rAwg1mr3/h8XsJqwkj9GVC9bBjeo8+w87yhldAfomTPV
         ocFFQKka29macWS4UamXYfEbQ88rtDKiOmILwkQ8a/6n1+hYQh48n2kKNmhB7pG3lDDS
         QEjk/HphzoR9qAEiBF8mNs50BnlSL5Mq4CSz/Jg8S22fDirK6XphZJug24SpORPEfhix
         6JRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQYt7bPE7+yoK0uFXiir+snqUYSV/63iwqp5X9wGaYA=;
        b=iNIUnQ4hyswTu+uyUc/KbJkpN7JN+kgVzpr8Bo5TzYfY3Gslvp96Ke8k8Siacvl88G
         H7KRTwSqzyQoWf93kE/shIEF85NoS/HWqBT53PJ5GMMdnrQBCvnfWW8ZGAvPLrQHPntV
         6JL8pFiXaYOx8ktGpFm8VW/CwLhgTcvPCIo2D9yJCqWUKFHXrR/nyMxJoZ7Rc8YNYhrL
         NtoeLU2l7NI8xvf87Czl8Y/mC8X3NfVgHQgz+WNvMN+5/bl68tqsE9R7NFX9FDlt6WC6
         Gocj+tQzvNACagufHMchkDamRZeNb7DbhTz1ClKI2bJukg0yqG2oiL9OzqHxE1UTAqCA
         NwfQ==
X-Gm-Message-State: AO0yUKX0Yo679aAuKpUyKGpTRVqpkjLIjwYZb6V99lN8h+s4rtu7t1tJ
        oB3uq24zEXXxE9Oht4xc/cF6Yw==
X-Google-Smtp-Source: AK7set99MutiRACwkV0Up4fuguH3459Hhpghskk3ZMxPUBGDrEZ/655PWn406F9eAvkdN71Dwgmz3g==
X-Received: by 2002:a05:600c:331a:b0:3df:eeaa:816d with SMTP id q26-20020a05600c331a00b003dfeeaa816dmr3779625wmp.28.1675936678528;
        Thu, 09 Feb 2023 01:57:58 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7e6e:bfb6:975d:225b])
        by smtp.gmail.com with ESMTPSA id c63-20020a1c3542000000b003df14531724sm4628913wma.21.2023.02.09.01.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 01:57:58 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/3] dt-bindings: arm: qcom: add the SoC ID for SA8775P
Date:   Thu,  9 Feb 2023 10:57:52 +0100
Message-Id: <20230209095753.447347-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230209095753.447347-1-brgl@bgdev.pl>
References: <20230209095753.447347-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add the SoC ID entry for SA8775P.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/dt-bindings/arm/qcom,ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
index 22d7ba17804b..bfdf066cc690 100644
--- a/include/dt-bindings/arm/qcom,ids.h
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -223,6 +223,7 @@
 #define QCOM_ID_SC7180P			495
 #define QCOM_ID_SM6375			507
 #define QCOM_ID_SM8550			519
+#define QCOM_ID_SA8775P			534
 #define QCOM_ID_QRU1000			539
 #define QCOM_ID_QDU1000			545
 #define QCOM_ID_QDU1010			587
-- 
2.37.2

