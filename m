Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996406B9E7C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjCNSbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjCNSbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:31:10 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF5D1B578
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:30:59 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l7-20020a05600c4f0700b003e79fa98ce1so10828651wmq.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678818657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIxBA2zlxML9hOs0dvz6DfCwg7oJrI83UIUnR1uCeBs=;
        b=EmK746apIdSh2XdjgbFudbJUw7DZowe3fkKEnVOTcm+/waCIPVsMPo5l9XVIZqhEIO
         QFNPofrD2Wt/8/WEmFgMPOfKG46WUG6a1AgapIsGwUjKpOt/KBWtPBR4QlqpwpZbFzZg
         915V6WTJzBBU9t6rcmlxJaWbjy1PC6Z8GY8HtgmGoxQMMRtEumaRbig0x1hYgs9KzMJm
         zgiEOQC394GKZ+hYtmQ77I4zJ480N9DANqlT9JUtwxGU3AHw2ooJMdDhgIR79U1vQ9Lh
         GaAb6R+5HZaGdjcacVzUNkE695LrM+TKoXodjCh3ZgioY0UgxFcux1eeH0k15P1H/DFc
         Myeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678818657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kIxBA2zlxML9hOs0dvz6DfCwg7oJrI83UIUnR1uCeBs=;
        b=AzQm721YVoy7faqG5s+j4UsLYmGRTPG8RGXNMO02L/6pv2+MUPWOfFyOLeMi1RFfg/
         Fe9OTB8rQKDRRmuMnF4qkY16JP40HSaDlAl63OSH2SJbAbsryU+bPs0bp10uEECQWowJ
         VNMDVikXlB7tPb4XtMeTZ1EKEENg0BpzKY9ps2eMz9/zoJkJ5Nr6rHspQxEt5D3lbN/k
         PQy5h9AnN4+uP6hGIudRHPDAqg46gYUGxnay3q4DGWld06OjVgOwTsNc7tiCGVAccrPG
         yqNz+DxhXK9jEySu/Z6GrIIg82T2D5vnBRNieXq9hj07wP7193pU9y1n8xkKZfoFrS7o
         cBog==
X-Gm-Message-State: AO0yUKVIrOMGq5KI+ZKpU0khpNX1A43QOuDpYzkYlheP4AHgiHK4fUu8
        AdRmQYKBtaXHGXrEBataXOcC6Q==
X-Google-Smtp-Source: AK7set84D2+qEChnMMW7hzfFJ0HZv09T5dJ/RFfHz5KNaLX2ov7ZL0fOGx3WxVO4zS+Y8j7bQGU+1w==
X-Received: by 2002:a05:600c:4746:b0:3ed:25c4:9 with SMTP id w6-20020a05600c474600b003ed25c40009mr3150753wmo.15.1678818657622;
        Tue, 14 Mar 2023 11:30:57 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:fd14:bd52:b53b:d94c])
        by smtp.gmail.com with ESMTPSA id k28-20020a05600c1c9c00b003e209b45f6bsm4083938wms.29.2023.03.14.11.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 11:30:57 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Lee Jones <lee@kernel.org>
Subject: [PATCH 04/14] dt-bindings: mfd: qcom,spmi-pmic: add compatible for pmm8654au
Date:   Tue, 14 Mar 2023 19:30:33 +0100
Message-Id: <20230314183043.619997-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230314183043.619997-1-brgl@bgdev.pl>
References: <20230314183043.619997-1-brgl@bgdev.pl>
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

PMM8654au is the SPMI PMIC variant used on sa8775p-ride. Add a compatible
for it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Lee Jones <lee@kernel.org>
---
 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index 8f076bb622b1..078d47a6ac83 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -78,6 +78,7 @@ properties:
           - qcom,pmk8350
           - qcom,pmk8550
           - qcom,pmm8155au
+          - qcom,pmm8654au
           - qcom,pmp8074
           - qcom,pmr735a
           - qcom,pmr735b
-- 
2.37.2

