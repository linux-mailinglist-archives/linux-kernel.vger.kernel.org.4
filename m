Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4D85B3842
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbiIIMyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiIIMyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:54:14 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D596102D74
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 05:54:12 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id f11so2507861lfa.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 05:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=+M7usIL1UBKOSaYCum2sbivjEepOZO9lCMezSOTId5o=;
        b=SRbPAS7sRrfEKyrj1lSOrt5AzOIDyyykqTBUNKTn5OEbd7+U80yl6snRLxfTonJk2X
         u4jdXcyrNr6qPcjgzP0G7MVvuKq5Qbt2aVml4e3nIVq1wXQsnkJmArV51I1MU80rrDx0
         fFp5yuuEt8v1ZGSfbLHUOfmhBW1HcNk/Yc+0pjB2sYuXjwT5exvMgt3yLjUbrzM3Oaka
         739trqEOAoDFxkZYSGcLQjEASLsC9bbzMXyjxN9wNYwePErZ4adMe/qBaUkR3i8oC/on
         9hDczp8+AdnM+CqJi77CYDxnwxleiF9klM8/LV/saRDAZZxgZfoedNCqMLtqeIdFVyeu
         iVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+M7usIL1UBKOSaYCum2sbivjEepOZO9lCMezSOTId5o=;
        b=wlZvYG+HTR4Stk++blY++2mtOzi5gA10BgeaOwYeyQBfgj4kfQExiwbIwye471qDMP
         KR4Kv6jDrcTcwO2D2LNxyCiOR7CPm61cLSluY4GUO1Hx+2Rvq1NM9LgzR6DTeviRkM4w
         ykciKsKzzma3nfhENDz9ZODc/Zq1KHOJcF+pSGLMXc42W4R/tmnJAdLLADInKHX/HZy2
         VV/s7Au9vRexyGsA1HUYzWhgidOz4SeF7w+IoCDKLR8dccJQ0IEn8+T6H/lxTBq4aRy1
         ejSnRcHJrbvIFW4zKIrZ8yV1jJthtrEcK1GqKPqzkUwgIF5np49kd4cBPtJvG6gTkA63
         oNwg==
X-Gm-Message-State: ACgBeo07IxG1g+ghys8jb/dq9ifTF+ZFmFhHkWePtedJJxXmVw5sUVHv
        JA3liQfy0Yed47lAW2euZvrwTA==
X-Google-Smtp-Source: AA6agR6Nwp8HMLeKt/flW5sgc5rPxmQY4GPbJfqaKFV8XM/OJEP4c3BWNPQ8e9sx2kXjRIcDx2CcyQ==
X-Received: by 2002:a05:6512:b9d:b0:48b:2567:4bad with SMTP id b29-20020a0565120b9d00b0048b25674badmr4410678lfv.9.1662728050367;
        Fri, 09 Sep 2022 05:54:10 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g10-20020a2eb0ca000000b00263630ab29dsm64750ljl.118.2022.09.09.05.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 05:54:09 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        David Heidelberg <david@ixit.cz>,
        Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/7] dt-bindings: misc: qcom,fastrpc: add compute iommus
Date:   Fri,  9 Sep 2022 14:53:58 +0200
Message-Id: <20220909125403.803158-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220909125403.803158-1-krzysztof.kozlowski@linaro.org>
References: <20220909125403.803158-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The children of FastRPC have either one or two IOMMUs in existing DTS
(SM8150, SM8450 and others).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
index 4b4072b6be1c..809de43afe35 100644
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -70,6 +70,10 @@ patternProperties:
       reg:
         maxItems: 1
 
+      iommus:
+        minItems: 1
+        maxItems: 2
+
       qcom,nsessions:
         $ref: /schemas/types.yaml#/definitions/uint32
         default: 1
-- 
2.34.1

