Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CA168C6DE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 20:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjBFTdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 14:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjBFTdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 14:33:22 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A6B23670
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 11:33:19 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so11585426wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 11:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OQAWcnBlImqpI8dh4fMJUJ4uLuslVZFojFS90E2YNEE=;
        b=KbOLSuz5sGWWK7dHMkv8zGADe7M8qgs5BFVn7L46N6R3TXmVg9cJMtz3F1HjvU3McB
         3HNS8XdeC7qsXimdqUQu8woKnmJbknQ4un29W0Z3I7FOI3+ccbmW8P8J7j7I32MEzyeq
         h4wNqaKp72hM8THzFErBUXKjTv2xwzQguI/GGOJWgXbGMLXn4NXb7ugBDgwtJcMcgQH7
         8f4uBajafCKH63L3e5Kt/O+3EIAPvu9MlJddXTIkx3Fe9ziKliSCO59HWMuH4QA8/LFh
         9Pw59JDso5dJjRPINPuqMjdaNfCTqioWzJO+qpXlZaT4SZy1y96tigBTbpDFzvaANdWe
         Coyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OQAWcnBlImqpI8dh4fMJUJ4uLuslVZFojFS90E2YNEE=;
        b=djXb/4V8i9KDS2FBsHuWvwA9sKuCiNdSNSqVmeL8BoVAEYwUnZLegh29UuOSRw8IaL
         5Yg+X2tNeToViNUxiJTFi+Nch76B+4JvSk5aZLiKP2pUWFa4A9cxWiLwIV7hK2HqaH3Z
         axxQImA+QAB9PWfNmjovpdodolDswvFsNqQSjalsQGb8XcuHrTICwQjqQqLVyHvu87SP
         ENjIk6Bd0j3y76n/qgSgKbYggVnXaZLrecEIyJclqpUlq0BXnfN6DkAT7q2x8xW3IsDg
         r6UGqE5/S8NyDriG/gKQxUvqCdfJC8W7Mq4oQrsZF4eEvTjGEBpXkP8EAgz6pz8DUwdZ
         lUNQ==
X-Gm-Message-State: AO0yUKUDnlC3zSvdqDhsSyjIKRCWTNaOArGPsRUeZeKbLkfSAxr96+t/
        eq0OFCBwyMFx1zwUdHdPMqo1ZQ==
X-Google-Smtp-Source: AK7set8Wq9hruDY7Cyh2+1+BQehRoY/JRRLJGz2O8xHgkkEXbm1aPoTVQ5cOlFCXglnhOTHEx8uZ9w==
X-Received: by 2002:a05:600c:920:b0:3dd:af7a:53ed with SMTP id m32-20020a05600c092000b003ddaf7a53edmr791250wmp.11.1675711997717;
        Mon, 06 Feb 2023 11:33:17 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600c2cc400b003dfefe115b9sm9351021wmc.0.2023.02.06.11.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 11:33:17 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: remoteproc: qcom,sm8550-pas: correct power domains
Date:   Mon,  6 Feb 2023 20:33:13 +0100
Message-Id: <20230206193313.30667-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Correct CDSP and MPSS power domains to match what is used in DTS and the
Linux driver:

  sm8550-mtp.dtb: remoteproc@32300000: power-domain-names: ['cx', 'mxc', 'nsp'] is too long

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml   | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
index ae612809e260..fe216aa531ed 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
@@ -99,22 +99,22 @@ allOf:
       properties:
         compatible:
           enum:
-            - qcom,sm8550-cdsp-pas
+            - qcom,sm8550-mpss-pas
     then:
       properties:
         power-domains:
           items:
             - description: CX power domain
-            - description: MXC power domain
+            - description: MSS power domain
         power-domain-names:
           items:
             - const: cx
-            - const: mxc
+            - const: mss
   - if:
       properties:
         compatible:
           enum:
-            - qcom,sm8550-mpss-pas
+            - qcom,sm8550-cdsp-pas
     then:
       properties:
         power-domains:
-- 
2.34.1

