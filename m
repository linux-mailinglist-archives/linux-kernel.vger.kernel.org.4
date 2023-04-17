Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C966E4F5C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 19:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjDQRiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 13:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjDQRh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 13:37:58 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0974218
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 10:37:56 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id x34so13863172ljq.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 10:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681753075; x=1684345075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C5D6a8r2vjcLnAgtEKEffI+VrzgTR4nUIJcaNud3nvU=;
        b=i2y7sA+e2AtfVmI0/a/icI4GjhAi8a09xMJWMpjdA+b7DUhrpZwSodiezPPSt9DkeP
         ebIcFstiJu/JyhWOhvE7i1mxgUtIGezRPfJtdxWS4CPc+X7VmI3cnLGDqI4gBPfGmSLd
         hDj5OElHR69FseLlXB04zzTO9zSa5WoDkECv1vgqQD0/ywmMVaW/RaNlIoAGvVbxRsN2
         7mm1F6/Vgdegl40GLipEv+tNWHLhoNJ4zfAuqj/06+gEwn+xGgXTSVRKinF07fhZAMHh
         kvj9HrSeAsFQ9whcqPBIHDMpGRRPrnFBmXNZRtrs33y52iYlt4xobSe58yUEQVHJUHk+
         DgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681753075; x=1684345075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5D6a8r2vjcLnAgtEKEffI+VrzgTR4nUIJcaNud3nvU=;
        b=SkiYrAKP6laAlpz+6+eBEMdT9oZqYnKPKOcXoXT0YTYqt46pr/GtnmqdUbVGUtRO3F
         1YekmtglRpGPOxKblE6IZCoY7So9qcu0S0pU0MGvzdyu1JvjhhXAhttq5erkheHoLam0
         H6+wUA2zeCz+Re8ZmBAaoAouc4rPPCIx6LssUArzzaldWPtT7XtjITVOK9Ks/HchFkIt
         GQoWwiMVDeqWqTJ01iR5XwBXBI8H4sEpr8l/5abVtz0o7FkrLhELveb1WC9pflslTqDO
         9qPy10OZkD0smycGLM0MhLk52vpX31X2fzlxjm8hemX3hSFl9KGyE1aIiihGICwBmQnY
         4t5Q==
X-Gm-Message-State: AAQBX9eNMFqCgum3nQThHX3QxdsKUEUgu9Se+hI9MEVfRJ3eqS22VEoZ
        328U8x/Pac6/BHXdawVrx/YpSQ==
X-Google-Smtp-Source: AKy350biWhtlI02iewRAKVnJqDOa5+ZHZDdRo4wnh7ptET3fhlxhCLw6FLRwJ+NY0eQFcWpNmy4mZw==
X-Received: by 2002:a2e:8758:0:b0:2a7:71ef:f89 with SMTP id q24-20020a2e8758000000b002a771ef0f89mr4269708ljj.15.1681753074985;
        Mon, 17 Apr 2023 10:37:54 -0700 (PDT)
Received: from [192.168.1.101] (abyk99.neoplus.adsl.tpnet.pl. [83.9.30.99])
        by smtp.gmail.com with ESMTPSA id h13-20020a2e900d000000b002987088bda4sm2191329ljg.69.2023.04.17.10.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 10:37:54 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 17 Apr 2023 19:37:52 +0200
Subject: [PATCH v4 1/2] dt-bindings: soc: qcom: Add RPM Master stats
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-topic-master_stats-v4-1-4217362fcc79@linaro.org>
References: <20230405-topic-master_stats-v4-0-4217362fcc79@linaro.org>
In-Reply-To: <20230405-topic-master_stats-v4-0-4217362fcc79@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681753072; l=3175;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=xF/pWuxUJ8x72O6U8YUe4JAHlOtuPuhzk2ELuhhwxdk=;
 b=Dvdm0IRU+WFG0mCrHoNch34vBJnaHxhh6Y8K2CbAuI3yBLBG4dNE4vNgEyjIoyZJq4JcRYH3tWT/
 IDlUkKA5DDK/qajP8WtRKbh1CzKRybPu5I6/IY6m5G+ppXe29bmB
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RPM MSG RAM contains per-RPM-master (e.g. APPS, ADSP etc.) sleep
statistics. They let one assess which core is actively preventing the
system from entering a true low-power mode.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/soc/qcom/qcom,rpm-master-stats.yaml   | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,rpm-master-stats.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,rpm-master-stats.yaml
new file mode 100644
index 000000000000..8a654979ce92
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,rpm-master-stats.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/qcom/qcom,rpm-master-stats.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. (QTI) RPM Master Stats
+
+maintainers:
+  - Konrad Dybcio <konrad.dybcio@linaro.org>
+
+description: |
+  The Qualcomm RPM (Resource Power Manager) architecture includes a concept
+  of "RPM Masters". They can be thought of as "the local gang leaders", usually
+  spanning a single subsystem (e.g. APSS, ADSP, CDSP). All of the RPM decisons
+  (particularly around entering hardware-driven low power modes: XO shutdown
+  and total system-wide power collapse) are first made at Master-level, and
+  only then aggregated for the entire system.
+
+  The Master Stats provide a few useful bits that can be used to assess whether
+  our device has entered the desired low-power mode, how long it took to do so,
+  the duration of that residence, how long it took to come back online,
+  how many times a given sleep state was entered and which cores are actively
+  voting for staying awake.
+
+  This scheme has been used on various SoCs in the 2013-2023 era, with some
+  newer or higher-end designs providing this information through an SMEM query.
+
+properties:
+  compatible:
+    const: qcom,rpm-master-stats
+
+  qcom,rpm-msg-ram:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: Phandle to an RPM MSG RAM slice containing the master stats
+    minItems: 1
+    maxItems: 5
+
+  qcom,master-names:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description:
+      The name of the RPM Master which owns the MSG RAM slice where this
+      instance of Master Stats resides
+    minItems: 1
+    maxItems: 5
+
+required:
+  - compatible
+  - qcom,rpm-msg-ram
+  - qcom,master-names
+
+additionalProperties: false
+
+examples:
+  - |
+    stats {
+      compatible = "qcom,rpm-master-stats";
+      qcom,rpm-msg-ram = <&apss_master_stats>,
+                         <&mpss_master_stats>,
+                         <&adsp_master_stats>,
+                         <&cdsp_master_stats>,
+                         <&tz_master_stats>;
+      qcom,master-names = "APSS",
+                          "MPSS",
+                          "ADSP",
+                          "CDSP",
+                          "TZ";
+    };
+...

-- 
2.40.0

