Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2832A6BBE72
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 22:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbjCOVD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 17:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbjCOVDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 17:03:16 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAFFA3B7C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 14:02:51 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id d13so10221481pjh.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 14:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678914118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8rqjPBjOCvuXU+1mFLCudR89i/pQL+YsrnWDFzg2So=;
        b=Gd+4FKYMQamsr9AeYrxn3zumzXcdq9zHX6onwL2IP9I59aS/rY4kKq+h5hS+W9sBlC
         IS+AX81iQ4Mwm6iLBHnVhCACW1oUUzeXlPRePe/+z8gXOSfIRm3oBv1D5JkMcC9xzLhe
         480Qnc4QLgf2EX2nTckxXG2H32QDoM+FZAVYo6d7Z8WkQrufuHD8rEpfE7FhgO3g8LB2
         eOgJqbyCPLZ+4/IobOyV0KJNfxBTDPSaP+R8UolJZ0a1/qyxB2BJr3FBtX9thvn6meNu
         k4BkFs0DY9VtefJUaHs1r5mgjdCU3adOK/Oo8kEOh5rCqimImGYYfZhErKhEBom9QWTf
         7tAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678914118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8rqjPBjOCvuXU+1mFLCudR89i/pQL+YsrnWDFzg2So=;
        b=CuKbhtSs7os7IUvsXpz0Iw5GHcUOBhRAI9qYvlbbSCoqMbAOvY271FQWT62E0UX0rX
         0gzF8gnJFPgNmikM/9MVd+2/xJeebF18h6V3sii6vrgT7NdHaeEyMjP+9vHfpcyvQNMv
         N2t/JsVLLEGJJaqlyy5Yt5m9WCUSjip+ThsyFOrhtteqvVDjHEKaU757Y3r6f6ewPfoh
         +bIYHuL3mMPjoLsr5z9PIR194n/wmZvfhQda3NUh+AuuZ3UtHGt46EdlZoVn42LnXN7i
         Gxj5hi07kBz00a0seNwQoksGeaBsicDEnIqm//RvV9dgoZlGizwUlMdE1kax4LIUdppx
         YLnw==
X-Gm-Message-State: AO0yUKULZ15LcXFqJl4yJHoBz2Jfu1fjE4faprlLrp8zie/8I8sm0Jom
        0ryt1HQrxFdpM6IFo0zaPM1vtg==
X-Google-Smtp-Source: AK7set/GrL/RW6fxKOjqOOQQgN4PPpwIgoxOXqK96L5huYYoPelfeq98z07ApqH5couQc1S71KrcFg==
X-Received: by 2002:a17:902:e38b:b0:19f:3b86:4715 with SMTP id g11-20020a170902e38b00b0019f3b864715mr718167ple.8.1678914118659;
        Wed, 15 Mar 2023 14:01:58 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c61:1acb:9af6:bd7f:78e7:7ae6])
        by smtp.gmail.com with ESMTPSA id 10-20020a170902c14a00b0019a91895cdfsm4066498plj.50.2023.03.15.14.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 14:01:58 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org
Subject: [PATCH v2 1/2] dt-bindings: arm: qcom: Document the Qualcomm qrb4210-rb2 board
Date:   Thu, 16 Mar 2023 02:31:44 +0530
Message-Id: <20230315210145.2221116-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230315210145.2221116-1-bhupesh.sharma@linaro.org>
References: <20230315210145.2221116-1-bhupesh.sharma@linaro.org>
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

Document the Qualcomm qrb4210-rb2 board based on Robotics version
of the Snapdragon SM4250 Soc, i.e. QRB4210.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 23c9c9ba5d52..5490593dc8f1 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -46,6 +46,7 @@ description: |
         msm8998
         qcs404
         qdu1000
+        qrb4210
         qru1000
         sa8155p
         sa8540p
@@ -90,6 +91,7 @@ description: |
         liquid
         mtp
         qrd
+        rb2
         ride
         sbc
         x100
@@ -848,6 +850,12 @@ properties:
               - oneplus,billie2
           - const: qcom,sm4250
 
+      - items:
+          - enum:
+              - qcom,qrb4210-rb2
+          - const: qcom,qrb4210
+          - const: qcom,sm4250
+
       - items:
           - enum:
               - lenovo,j606f
-- 
2.38.1

