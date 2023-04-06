Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354A16DA130
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbjDFT22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjDFT2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:28:24 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0186455BD
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 12:28:22 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id y14so40603934wrq.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 12:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1680809301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TovaMoNXmH9olijKp9TzGAILwIizt6Ev5VA4GI6JW9U=;
        b=sn2YJQMZ57QrO/ByEheQoj+2yMet1GIGkI+xIJHZMiDrSF06mW+ZLZ8okC8x35PZox
         rnGpTvzfsWQ9lxbMRw21uHIlWNQReAMzp4lhdj8m7AwEI7P5iVuxctBBANxag7zBRDG2
         Xz/pTtcVGpMDu2bvH1kYKJXyVGoXWi55KJycnpeeV5dL7kiKJutHP+boBfQEErgZTv2C
         iuJYRcIF0fTcTMewRVVH6sDNwSD+9OHq2Q4bnHozoM3O2U7Zmt4GgjjaLwvkQdyyrV7G
         s+q4FjBES5MkFwyafeWEPYwpB0H3c89driolMepgNCPxEioQCAnARKXEzK6iAlimRbc3
         2qGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680809301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TovaMoNXmH9olijKp9TzGAILwIizt6Ev5VA4GI6JW9U=;
        b=zUo+RCKpPwTMIKfVe5kiFUd3wjH/9uu7Re660MK7hm5vUC7f9Usw0c2u0PVl5/e19l
         tre/Vaa4vqt+xYcW9bDldV/BAui0QOybSigkOiawmwZfgzrqvtKto5XIVtyGC1i2EOBo
         Tzec00jXNxoEkdG2PNCw+zoT8odm+onoTXOy8z1fxSKL/yz27OAhVRc3KwXsavYJKK1Z
         tFT+Bn93BFLbvUk0RRvESSMjEelxczo3l8HPyyOWYEM105u7gkLutR2KkzEKqcwgwF75
         ybcMOk/UQZDzhD2Iw3JjQghp8pDyWQBRo4CU86i8OQvgd7YsJirS/C5/E4XBKad4RVR+
         0h5A==
X-Gm-Message-State: AAQBX9cTejnsKyZs1qphvTkBLnsroOxjSCheqZoWMVKfy0HPFq1wJU/5
        hXRENZxUB80axBVnZfwYURAwLw==
X-Google-Smtp-Source: AKy350YX0pmv5BdbpIbsSq+hglTSaqFhVo6RZPYoJcU5bh1J1HOt1vUe93bXOpq3F+RvuOQ2KWbBOg==
X-Received: by 2002:adf:e841:0:b0:2df:7c0a:df33 with SMTP id d1-20020adfe841000000b002df7c0adf33mr7468485wrn.30.1680809301359;
        Thu, 06 Apr 2023 12:28:21 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4793:cb9a:340b:2f72])
        by smtp.gmail.com with ESMTPSA id c11-20020adfe74b000000b002d89e113691sm2489321wrn.52.2023.04.06.12.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 12:28:20 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/3] dt-bindings: regulator: qcom,rpmh: add compatible for pmm8654au RPMH
Date:   Thu,  6 Apr 2023 21:28:09 +0200
Message-Id: <20230406192811.460888-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230406192811.460888-1-brgl@bgdev.pl>
References: <20230406192811.460888-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add the compatible for the pmm8654au RPMH regulators present on the
sa8775p-ride development board.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../bindings/regulator/qcom,rpmh-regulator.yaml | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
index 7002d2654382..f879ccbb3767 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
@@ -80,6 +80,7 @@ properties:
       - qcom,pmg1110-rpmh-regulators
       - qcom,pmi8998-rpmh-regulators
       - qcom,pmm8155au-rpmh-regulators
+      - qcom,pmm8654au-rpmh-regulators
       - qcom,pmr735a-rpmh-regulators
       - qcom,pmx55-rpmh-regulators
       - qcom,pmx65-rpmh-regulators
@@ -247,6 +248,22 @@ allOf:
       patternProperties:
         "^vdd-s([1-9]|10)-supply$": true
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,pmm8654au-rpmh-regulators
+    then:
+      properties:
+        vdd-l1-supply: true
+        vdd-l2-l3-supply: true
+        vdd-l4-supply: true
+        vdd-l5-supply: true
+        vdd-l6-l7-supply: true
+        vdd-l8-l9-supply: true
+      patternProperties:
+        "^vdd-s[1-9]-supply$": true
+
   - if:
       properties:
         compatible:
-- 
2.37.2

