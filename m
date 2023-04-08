Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D786DBD4A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 23:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjDHVk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 17:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDHVkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 17:40:51 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0596A6E8F
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 14:40:50 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id g5so4922065wrb.5
        for <linux-kernel@vger.kernel.org>; Sat, 08 Apr 2023 14:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680990048; x=1683582048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/ds8fvt8IhNIUkcMPcB2187U+f/tO5X7bx8/qa8ONM=;
        b=m0SLzn1iqfD6YsYtHojGNxnFSimTvg28gxXYWGvhbeFi3ywBXyW2aKpPKcOOnk81GA
         pLcEC/zzrZ2ZJakFH4GZvs1NXYVS8Q5ZATw+aSem6W2Z4reoZoq35ICKnVa68eA/Po/7
         BFDtRtkmaD6WxD4wCiLae4gl/1Q2r4k3JeKUpjo012rA+ctcgAR0df1Cf5XPDm4XLmRV
         YMWY1CvCaELFO2/x7NQzHDQWbhzCpl7SOTToN6mh4//P9fwC7b1iIqg+NZ8ZIVkIWySc
         Pi2SUMiMC5Z6faMkDkzq3p3ZxBXZ2Nq+Es4E+Y0cqnd3Kht+YjeQRGlh9xH60wew+601
         brew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680990048; x=1683582048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/ds8fvt8IhNIUkcMPcB2187U+f/tO5X7bx8/qa8ONM=;
        b=5lgBWx6QK/1Tkj9MyuU08TyAtMe4wqc+1rARKriBbHzWphTD0O5B6qLJQxHLPu2uRI
         W349AKJr0pgcym8QVWKWUZy/WK9Usk6XpxkPYeLfvTABx5N1HeA56XxWbYUkKLHF5XQE
         h8XabnTf/fUQJp1WQTkTbKY7HtsOOBjbt2ldnbVSTKl99Q9ufe58xVs0jJesSoj76Qq/
         1lnLFKA3np/Lzx6iUVIjJFjuXEhxMz0iLpyrnFodl+XxCmGEKLCq8nNd8PWM6AIbUXCl
         Tr2kKEWlDiPfSynVQydey3VOOFYrfulgtSK7dmEdY4HYl/TpUcQou6T+kRvrP/1JEcUd
         R9yA==
X-Gm-Message-State: AAQBX9dCIE7zV7XIBgZZlXRd4A1RJmTxTqXh/psUvyhvdgqnsU7QTKmM
        SSrxoeUm593O6ZMZSOSk/dpnjQ==
X-Google-Smtp-Source: AKy350ZoIOX+1ULO+/6nI4Sk6F63spIEVpgG402AEJu/jOF7CaFaEsl7we9f/uNDu20eJD4ZJ49o7A==
X-Received: by 2002:adf:dc07:0:b0:2e2:730a:c7de with SMTP id t7-20020adfdc07000000b002e2730ac7demr1863136wri.24.1680990048420;
        Sat, 08 Apr 2023 14:40:48 -0700 (PDT)
Received: from localhost.localdomain ([188.25.26.161])
        by smtp.gmail.com with ESMTPSA id s6-20020a5d4ec6000000b002efb6e0c495sm3061377wrv.91.2023.04.08.14.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 14:40:48 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH v7 1/3] dt-bindings: ufs: qcom: Add ICE phandle
Date:   Sun,  9 Apr 2023 00:40:39 +0300
Message-Id: <20230408214041.533749-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230408214041.533749-1-abel.vesa@linaro.org>
References: <20230408214041.533749-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting with SM8550, the ICE will have its own devicetree node
so add the qcom,ice property to reference it.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

The v6 is here:
https://lore.kernel.org/all/20230407105029.2274111-3-abel.vesa@linaro.org/

Changes since v6:
 * Dropped the minItems for both the qcom,ice and the reg in the
   qcom,ice compatile subschema, like Krzysztof suggested

Changes since v5:
 * dropped the sm8550 specific subschema and replaced it with one that
   mutually excludes the qcom,ice vs both the ICE specific reg range
   and the ICE clock

Changes since v4:
 * Added check for sm8550 compatible w.r.t. qcom,ice in order to enforce
   it while making sure none of the other platforms are allowed to use it

Changes since v3:
 * dropped the "and drop core clock" part from subject line

Changes since v2:
 * dropped all changes except the qcom,ice property


 .../devicetree/bindings/ufs/qcom,ufs.yaml     | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index c5a06c048389..10d426ba1959 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -70,6 +70,10 @@ properties:
   power-domains:
     maxItems: 1
 
+  qcom,ice:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to the Inline Crypto Engine node
+
   reg:
     minItems: 1
     maxItems: 2
@@ -187,6 +191,26 @@ allOf:
 
     # TODO: define clock bindings for qcom,msm8994-ufshc
 
+  - if:
+      properties:
+        qcom,ice:
+          maxItems: 1
+    then:
+      properties:
+        reg:
+          maxItems: 1
+        clocks:
+          minItems: 8
+          maxItems: 8
+    else:
+      properties:
+        reg:
+          minItems: 2
+          maxItems: 2
+        clocks:
+          minItems: 9
+          maxItems: 11
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1

