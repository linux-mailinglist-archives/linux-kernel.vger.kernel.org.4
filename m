Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94A76E7962
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbjDSMJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbjDSMJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:09:26 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F171986
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 05:09:20 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-2f917585b26so2632733f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 05:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1681906158; x=1684498158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ICV+ifexo83o57cRcwBX/lZ8ijdYT70+Vp9Lz3f2oAg=;
        b=ykMoH/onbS1531mCkS58WF+fhQb/0kz8ZY36KbB/9u0gHHuOZQOTNOcmePMMX3kdcC
         JrZg2yRBqAm6Bueq4rgEySjGr1NJE75dSQkn3jO1q5NFFu/3XDpN3QkIh3ZYNH1amdEa
         MglUuRz0NUd0vIE+JsxOWG4uSvWjcud65TMNLqrFHKUXZjbyxCt4tz0tl+SPCZecRDUt
         hvTGl+Qi8eb98CLLxeZCktJ9fd5qtP3LglWCDJs1KD/yRmust4LchvLPkPzJHp6U88yQ
         z24WJ5AiLKoRN+bHeQ6sisSV5ZVab8ED083r2ZGweEnFvBh6gromIbqRLY5tpYZ5ZD4l
         Vcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681906158; x=1684498158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ICV+ifexo83o57cRcwBX/lZ8ijdYT70+Vp9Lz3f2oAg=;
        b=QEbqmj35DwyiIFGdflUGj1waYna5TfUI5kZbTYeO3KhAA1EwO1eQ/UvlX+6O7Od6/Q
         Tbl7CvfWE1f7ClpyguWG2uAM4Jux7/Wv9emI1kh8gxbrbzK8/nPXcpCK4Xgj+ALZjWxH
         LWtT4Q/PnlqBHgfC/YAvuJe7EIugR5b8q3NkzSBR04O/oOtuW1MSWS7jrvE3O9g49Ug7
         XmrkjQRY+vwbgb3UO/ZRy1XjPaUlUPYRwqzbhO4wJopzXD35a7HdLlAWMw5GLggXc06Z
         JVtL/OyDovumPKAV2cjzUn6Xp8QK0xcoVxK1CargGAMobM3lVqU2rzLXpyu6DC5nbNQX
         ynQg==
X-Gm-Message-State: AAQBX9e6d7FaAAL5RHZfn0sCVxrKwpoKD6g2FatFKmHK8Y+DfqT38B5X
        cccPXy55t1OYj6Z6vxlkv9AUkA==
X-Google-Smtp-Source: AKy350aKXVkWQBioUWRD45UWirKdXtYI4Q7nfX+i1Dn7PTo4kmQYfduYh6Pb3t2kw30YkIia5o26xw==
X-Received: by 2002:adf:e688:0:b0:2fb:f93f:b96 with SMTP id r8-20020adfe688000000b002fbf93f0b96mr4416492wrm.31.1681906158527;
        Wed, 19 Apr 2023 05:09:18 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e836:64e1:77c8:1d5b])
        by smtp.gmail.com with ESMTPSA id v11-20020a5d678b000000b002fa834e1c69sm7634899wru.52.2023.04.19.05.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 05:09:17 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2] dt-bindings: phy: qmp-ufs: tweak clock and clock-names for sa8775p
Date:   Wed, 19 Apr 2023 14:09:14 +0200
Message-Id: <20230419120914.173715-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

maxItems is already globally set to 3. To make the binding easier to read
and remove redundancy, set minItems to 3 for sa8775p as this platform
requires exactly three clocks.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
v1 -> v2:
- rephrased the commit message as this is not a fix but rather
  a readability improvement

 .../devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
index 94c0fab065a8..a1897a7606df 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
@@ -78,9 +78,9 @@ allOf:
     then:
       properties:
         clocks:
-          maxItems: 3
+          minItems: 3
         clock-names:
-          maxItems: 3
+          minItems: 3
     else:
       properties:
         clocks:
-- 
2.37.2

