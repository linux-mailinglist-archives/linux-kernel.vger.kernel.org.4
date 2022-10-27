Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74ABD60FA78
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 16:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbiJ0Oeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 10:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbiJ0Oee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 10:34:34 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DAB614E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 07:34:30 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id ml12so1478792qvb.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 07:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Elgx/yfm289sAtkCYegANchVqYKxAF2vr4d85UGafk=;
        b=qe2yzrEfB6gYDu97LZwQjj8l1w5YksJdkQuZJRNijntprQa6U6HSXv5tsDs7aCuFPo
         cmpqdfBvFiLWtJp/lBumeuvsP3Y8aRChyg5VnnZTA2R0FGCrBtseoY+x0WUTibasrIJC
         WHdWALtH0uPoTT9k70bzSaO50tkgUYWYQarzkzLvfFMnn6qVRfxQ3aqWoC3Of7KHCebc
         ZoqyOPXscRD+LiXlVBXvF1s2Xeipvv6lwopSUoqH3eld9CVDmZubKY1ZMtI73RoRf0yD
         iGv0QlCXLdXvmWSPBcsJ0WBDhnMCFUBru1/sPzd0oTdORVRMwSqR23HONbnHMsR/eVpY
         WoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Elgx/yfm289sAtkCYegANchVqYKxAF2vr4d85UGafk=;
        b=o+XPXaM7pgDjuhpSEEpQHifN3Ssu/TLnJO4yus3cvTzwpOaWx7KDq8m8c6ytk+D1f2
         lEpYgU9FkDkvEtYVUTZYznkmoxDt8NtA0+fy+51b1xepB96aTqVXlwF43FACIYJCwT3q
         Vri3r4tEBwzfxbETG+aLQur5ECtQaSTZqqMdhA/H2xHXHa1tEqe1B1CkecUQ8+HIRWfx
         KREIQuNDHedCwZRMHK8Q8TPctiV5uEMUTjSh3mRMhEJtsA3xj4uTMrEBtTTtd+Tk9k9n
         eXpJY/JNHIPX4CuS3gf8cy7QqIfcMHCvDw6nuUwYVKQAGslYIRWzFlaZoAVFaAMDrNl0
         guUA==
X-Gm-Message-State: ACrzQf1EvFHOV+4VBwWQ/iqafypOjJNNRhws4hLARKLOgkY2giy9hPXz
        l+tE2Rl5TPtDTFot5gBN1JHrng==
X-Google-Smtp-Source: AMsMyM46cXvgjnQPpBH112h9LLu7kzNk/O4CQ0zeyEfk4ob+MF+ZhGEsvn9O6xNqUxB/arblHia0CA==
X-Received: by 2002:ad4:4ea7:0:b0:4b9:365b:2a86 with SMTP id ed7-20020ad44ea7000000b004b9365b2a86mr31544620qvb.58.1666881269483;
        Thu, 27 Oct 2022 07:34:29 -0700 (PDT)
Received: from krzk-bin.. ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id w10-20020a05620a444a00b006f9e103260dsm1076749qkp.91.2022.10.27.07.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 07:34:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: iio: adc: qcom,spmi-vadc: simplify compatible enum
Date:   Thu, 27 Oct 2022 10:34:10 -0400
Message-Id: <20221027143411.277980-1-krzysztof.kozlowski@linaro.org>
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

The second compatible item in oneOf is just an enum, not a list.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml  | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
index 8bac0c4120dd..a848df37db06 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
@@ -22,13 +22,11 @@ properties:
       - items:
           - const: qcom,pms405-adc
           - const: qcom,spmi-adc-rev2
-
-      - items:
-          - enum:
-              - qcom,spmi-vadc
-              - qcom,spmi-adc5
-              - qcom,spmi-adc-rev2
-              - qcom,spmi-adc7
+      - enum:
+          - qcom,spmi-vadc
+          - qcom,spmi-adc5
+          - qcom,spmi-adc-rev2
+          - qcom,spmi-adc7
 
   reg:
     description: VADC base address in the SPMI PMIC register map
-- 
2.34.1

