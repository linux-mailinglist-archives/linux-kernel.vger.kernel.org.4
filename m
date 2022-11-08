Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16C3621890
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbiKHPlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbiKHPlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:41:07 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF173140E9
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 07:41:06 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id t1so9065884wmi.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 07:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2RysX7TiVCclv2UJBtgXviDFq2/T3mQypqGPEA1b7s=;
        b=xA55vWiaWt8+Fe2aBbuyjq3MufWdeda/bR3VkkuFVXy/V29Bn6ByY13oKRLcE0c0Ix
         twWWJ+pcSFTWqzaI1Dj0ByIFNnejv6NQfJCfDqXbdg1b2R7L5mBfV2QQ+JAmH3q2oEO8
         1f5gJKr6qA9czzXKrUwjln7XBPP6fgTOGQBLXd49aMbQisAWxSnwHcn7LVXO+ARPvyJJ
         iKoOGCioiyMm6lLAmkMU9OLd+8kF6JhVCmEgX+0qpAbl89EEwXW5A1cNfbyfMU04bL3s
         CwZceFoA2ubcBjKOwMZI4Z+8BM1qVpQat7OGXfx0T2hTyc/07azuwLW+1lJ9ie84N19H
         0wxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2RysX7TiVCclv2UJBtgXviDFq2/T3mQypqGPEA1b7s=;
        b=vHrywfz6+eqYWC6LHgQGPCD320vCRIs1BBiymKYgtyEih67eVZrscn9oAefzVnIOp/
         PtCOnquCBMOrkO2cIBrjoDwQzg8osknt648n/cqIefGu6d3P0eKFOb5rRzOcC/WoH/A9
         gGrkrwoEaKaekRpmKTkXqmANY+FLdV5E4lWn41qsrYUYW882LJ9TR8wVFl/Xlg0eu0fK
         b3NkIJ307Ylkxpo1xa1GV12YX3We+1UadIR1za56HzgNd1TTaTxCtUoqYWFCaFVOwp/G
         awpmsNUSxXMNgBtvJaDwL8LM7kLpwKfapTpbbffiOUL5P2Ao3tYVC776TvJcGNmOaepO
         cH8w==
X-Gm-Message-State: ACrzQf04c0nP3FQyXyWF6AMZnJmnFk9+LbaiOma8dZ4lpsriF3cKvi7d
        EAJZ1c8lq4jVXzU12U2u7QhG
X-Google-Smtp-Source: AMsMyM7yx9QbMyaOL2dR5xLPaW8JEVOPUnz7jDgDCn18u96ZPux42UEmEwKr9ZkHufK7lz3zC+Z2Nw==
X-Received: by 2002:a7b:c5d6:0:b0:3c6:f970:e755 with SMTP id n22-20020a7bc5d6000000b003c6f970e755mr37377706wmk.132.1667922066448;
        Tue, 08 Nov 2022 07:41:06 -0800 (PST)
Received: from localhost.localdomain ([117.207.25.46])
        by smtp.gmail.com with ESMTPSA id e4-20020adff344000000b002364c77bc96sm10906899wrp.33.2022.11.08.07.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 07:41:05 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, viresh.kumar@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org
Cc:     johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 1/3] dt-bindings: cpufreq: cpufreq-qcom-hw: Add cpufreq clock provider
Date:   Tue,  8 Nov 2022 21:10:35 +0530
Message-Id: <20221108154037.111794-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221108154037.111794-1-manivannan.sadhasivam@linaro.org>
References: <20221108154037.111794-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm platforms making use of CPUFreq HW Engine (EPSS/OSM) supply clocks
to the CPU cores. Document the same in the binding to reflect the actual
implementation.

CPUFreq HW will become the clock provider and CPU cores will become the
clock consumers.

The clock index for each CPU core is based on the frequency domain index.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index e58c55f78aaa..676d369a6fdd 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -56,6 +56,9 @@ properties:
   '#freq-domain-cells':
     const: 1
 
+  '#clock-cells':
+    const: 1
+
 required:
   - compatible
   - reg
@@ -83,6 +86,7 @@ examples:
         enable-method = "psci";
         next-level-cache = <&L2_0>;
         qcom,freq-domain = <&cpufreq_hw 0>;
+        clocks = <&cpufreq_hw 0>;
         L2_0: l2-cache {
           compatible = "cache";
           cache-unified;
@@ -103,6 +107,7 @@ examples:
         enable-method = "psci";
         next-level-cache = <&L2_100>;
         qcom,freq-domain = <&cpufreq_hw 0>;
+        clocks = <&cpufreq_hw 0>;
         L2_100: l2-cache {
           compatible = "cache";
           cache-unified;
@@ -118,6 +123,7 @@ examples:
         enable-method = "psci";
         next-level-cache = <&L2_200>;
         qcom,freq-domain = <&cpufreq_hw 0>;
+        clocks = <&cpufreq_hw 0>;
         L2_200: l2-cache {
           compatible = "cache";
           cache-unified;
@@ -133,6 +139,7 @@ examples:
         enable-method = "psci";
         next-level-cache = <&L2_300>;
         qcom,freq-domain = <&cpufreq_hw 0>;
+        clocks = <&cpufreq_hw 0>;
         L2_300: l2-cache {
           compatible = "cache";
           cache-unified;
@@ -148,6 +155,7 @@ examples:
         enable-method = "psci";
         next-level-cache = <&L2_400>;
         qcom,freq-domain = <&cpufreq_hw 1>;
+        clocks = <&cpufreq_hw 1>;
         L2_400: l2-cache {
           compatible = "cache";
           cache-unified;
@@ -163,6 +171,7 @@ examples:
         enable-method = "psci";
         next-level-cache = <&L2_500>;
         qcom,freq-domain = <&cpufreq_hw 1>;
+        clocks = <&cpufreq_hw 1>;
         L2_500: l2-cache {
           compatible = "cache";
           cache-unified;
@@ -178,6 +187,7 @@ examples:
         enable-method = "psci";
         next-level-cache = <&L2_600>;
         qcom,freq-domain = <&cpufreq_hw 1>;
+        clocks = <&cpufreq_hw 1>;
         L2_600: l2-cache {
           compatible = "cache";
           cache-unified;
@@ -193,6 +203,7 @@ examples:
         enable-method = "psci";
         next-level-cache = <&L2_700>;
         qcom,freq-domain = <&cpufreq_hw 1>;
+        clocks = <&cpufreq_hw 1>;
         L2_700: l2-cache {
           compatible = "cache";
           cache-unified;
@@ -215,6 +226,7 @@ examples:
         clock-names = "xo", "alternate";
 
         #freq-domain-cells = <1>;
+        #clock-cells = <1>;
       };
     };
 ...
-- 
2.25.1

