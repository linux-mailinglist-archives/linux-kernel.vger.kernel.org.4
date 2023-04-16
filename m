Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE9B6E3771
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 12:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjDPK2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 06:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjDPK2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 06:28:37 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517C0B8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 03:28:36 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a5so291633ejb.6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 03:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681640915; x=1684232915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/WILy0R6WPnh24gnV28OdDxLUSQ9/ia0lYz5to4X3E4=;
        b=D5+/AYVDV9/VXSXZywzl29KDIlRKY2rhFEYvNT6WBi/I2JklFtddcJFH7AoWpfvIR8
         o1lqUcR89kKAhgGjtT8NTFuviqUGOOU0doydbzevQxwsNeQYeC5FMRP5KMyl+JatuysM
         xM5MogoqR0hhZYr5N2yn4gDQd+Zfeq1gK194aW94jbQymL29rKHX+6WOLCQ3FOSMCKx5
         KZdlY2nlxTK843H7crmorevgRzRxHhwIb1usFmEGcb4LcKqvWCMhLZ+hW0FafGdfTyqm
         09Lujb5dUAag9tSy5k0Dst/iIheji7k10v+J3v7Z3qqrghGqI5YSNsoLAOjzLZF/sH9t
         RIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681640915; x=1684232915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/WILy0R6WPnh24gnV28OdDxLUSQ9/ia0lYz5to4X3E4=;
        b=lEV3U3n9tFfN4ST48f/UmgE3aTB/5Crob3+vRoOdeI3TrZYwhvUbByGSp95Q7mGkd3
         tItb+0+1+rqwNiXRW7DdLavhyr/fo7K5Q4ACN4/YOqfjdZy+euKLw1gRqzpe22CoQkS6
         4xUf2GfsFWfY0r9GU2ynb/L+Fo8BUf6jAk3WJq9aOP9VYiNXmTZA6WN9u0h/EkoDOqSA
         rJVHF5PAVqTZTKAYq2FZ1X0mVQReqDnsLBQNI5ORvUikcM3z28CDievAIcEkRvdwmuwt
         mF9CENA/NqeXrP7NR4iXvaUwo3FTgA/ONzluHtFmZPPVscceC5rIuEpPZIJF20RYpNLF
         YV8Q==
X-Gm-Message-State: AAQBX9daOl4deZeNnFtY1PGKLfu8c03bhsAd7cq62IVJADdrS6nlA0FM
        vikvmxiie7CJjyx0rQalpZHEiQ==
X-Google-Smtp-Source: AKy350YJuCe+g6rNAc/lyyClksEAhlVM2GqnbhdhRYhBv/Ql1CQa0WHC39XoqBHbnRC43uDadqkvlA==
X-Received: by 2002:a17:907:9908:b0:885:a62c:5a5c with SMTP id ka8-20020a170907990800b00885a62c5a5cmr3442825ejc.46.1681640914846;
        Sun, 16 Apr 2023 03:28:34 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:29dd:ded4:3ccc:83db])
        by smtp.gmail.com with ESMTPSA id n17-20020a170906119100b0094f3e169ca5sm1063268eja.158.2023.04.16.03.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 03:28:34 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: interrupt-controller: qcom,pdc: document qcom,qdu1000-pdc
Date:   Sun, 16 Apr 2023 12:28:31 +0200
Message-Id: <20230416102831.105136-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Add QDU1000 PDC, already used in upstreamed DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/interrupt-controller/qcom,pdc.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
index 480778d8725c..36f79ad1fe98 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
@@ -26,6 +26,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,qdu1000-pdc
           - qcom,sa8775p-pdc
           - qcom,sc7180-pdc
           - qcom,sc7280-pdc
-- 
2.34.1

