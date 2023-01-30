Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321EF6813C7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237850AbjA3OwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237849AbjA3OwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:52:01 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B615234FC
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:51:58 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso3363925wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w/BGsdjH3kzkfT6LKJZyI96LnFxoW5s+QoFH5M2WoRo=;
        b=1/+vRbWhaghOFGpUBcEHV3AxQ6Q8sYpKCxRhQNUA8a6jHR/xhzKJT1XCbUh1gjrc8u
         3Oaa+3uDigkdjteWe4g6BhB1FlFFyu4LbNCUjWzaW2+RJV2ZNfFcJY7EQJAEoiPBo9M6
         Qnxeq5SoYDPIBwUGNobgOgQAaBynvH0n4wPpQR4ToomGKAhSy4aJC0Jih+dB8T4w3TEP
         G65m0s/XY7h3plhdtHxAXXtMkBGDIk9qjdwBIxcUt/OwccuXdb+DjfUEVoanN5JL6bTu
         yOSnHV2CeYYyhNlWUnC1PVGf44XgsHb5un5UhkuPT1MsDSLxQvJdTrThTbUX5uX0m3vO
         XfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w/BGsdjH3kzkfT6LKJZyI96LnFxoW5s+QoFH5M2WoRo=;
        b=QJlI07Viy1LTmoNclHoiojBlBN/7+uU0Ce2Ch7CAmHNdF3WqZ/3O/ssJkycvUMGBOn
         +LadbDi7Wgdiw550d/eGBFopnZ1lB7yS/aTKq7YPS2ikM24l1QMheIzd3CQRpKfHttAK
         +64B8A6F3hOl9yO9NUHidQH9BfyBIX+ReCYbQtbRCJ/vh1VKO+fXqPGNQTB0d0gQao03
         EbkSoAJiBe6xt6qy3vh7YjTJyyfCaAExLOuyx1L8xypsxH/K23POY0rtOxqkG8lLsE9y
         QD1YIhUCki8JlbQwcTk7I3i9wJcQVj/JqXv1wU4m1cyirG8Zinm8FMHM6y6TkfXJQ5fG
         EBvw==
X-Gm-Message-State: AO0yUKXbnXBmFQMaykYV7WnOXn21N7B+9Pk0NgLwy52Df65M6vdSRRAz
        OXJHUA9jsij8aIN+xmNUqWq9Og==
X-Google-Smtp-Source: AK7set+ZLvgVqk9VEY+YtMK5GWPiTjquoo1pbvkYmsFSRUYj9NHIH/c+DdZLVRyF9YkJOHHyuhfeKw==
X-Received: by 2002:a7b:c4ca:0:b0:3dc:4316:52be with SMTP id g10-20020a7bc4ca000000b003dc431652bemr10316252wmk.10.1675090317023;
        Mon, 30 Jan 2023 06:51:57 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b9a5:a1fe:d3ab:6b40])
        by smtp.gmail.com with ESMTPSA id q17-20020a05600c46d100b003dc530186e1sm6430248wmo.45.2023.01.30.06.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 06:51:56 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH -next] dt-bindings: clock: qcom,sa8775p-gcc: add the power-domains property
Date:   Mon, 30 Jan 2023 15:51:54 +0100
Message-Id: <20230130145154.195562-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
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

The binding document is missing the power-domains property. Add it and
update the example.

Fixes: 0fff9fa043f9 ("dt-bindings: clock: Add Qualcomm SA8775P GCC")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../devicetree/bindings/clock/qcom,sa8775p-gcc.yaml          | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sa8775p-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sa8775p-gcc.yaml
index dae65ebc5557..0f641c235b13 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sa8775p-gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sa8775p-gcc.yaml
@@ -40,6 +40,9 @@ properties:
   protected-clocks:
     maxItems: 240
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - clocks
@@ -52,6 +55,7 @@ unevaluatedProperties: false
 examples:
   - |
     #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
 
     gcc: clock-controller@100000 {
         compatible = "qcom,sa8775p-gcc";
@@ -71,6 +75,7 @@ examples:
                  <&pcie_phy_pipe_clk>,
                  <&rxc0_ref_clk>,
                  <&rxc1_ref_clk>;
+        power-domains = <&rpmhpd SA8775P_CX>;
 
         #clock-cells = <1>;
         #reset-cells = <1>;
-- 
2.37.2

