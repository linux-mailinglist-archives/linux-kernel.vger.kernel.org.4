Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765466D51E5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 22:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbjDCUFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 16:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbjDCUFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 16:05:43 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941223AA9
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 13:05:41 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l15-20020a05600c4f0f00b003ef6d684102so15255317wmq.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 13:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680552340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtkVbXjOkWE1mDRtDA64NnPbwftHZmH0QT3gMjYI38Y=;
        b=anUhkD130aHAwvsiiZmvlUZHWOZZqMhnR0U+GdzME761AblPsoBRbfBX9SUdODa9dW
         AAL/ZnWQadaW2iESlmdRhpFwYsXxLxd0hB0srtAtHNfzRygDunJrMlyfVsYUd+8b7IE1
         w0ItXIzjJsH5rm/6X1LQSH5EYPvHwFetKWtqdoQjD2fzZfU/QBjs7WsW5w3tHnHnij4o
         11h+C7VTBMHu3qAHrTgY2HE7f+v6BQf3bWAGNVlX31ceSZv0t9xcNxNIFFmRkeFQRfIL
         VryBsthFzMWOAb0ymNzg01I+d37TH4F6SiDaJGnSS7jgmwCsQIjv95Gli3sjBPD5v/6H
         hmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680552340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtkVbXjOkWE1mDRtDA64NnPbwftHZmH0QT3gMjYI38Y=;
        b=UkFg7CbqmC9fzamtN3s7cgsVEvmuROZRpJMzt5f1XtifuyiQjRzoBA6rsAE4k4eWYU
         twLECTQBrJgGB8cWUeIHV6lbVPTxdlnHoapQIFq/GEfIK3Nms/zCqGaQzBEeBLVKpHCt
         gzgweVdEzRxLGl4jz/leCJfYK4aAfSjHV+N9V02XC3dkdiwF7JuR1oCALpJaS7DrMPCO
         i6sZFXZx6H3yP+3DLRINR5C5p1cbnMH5XzqvoWB9t3fSSzgnVMQA+iswL/Lb6EV9e/6p
         vr6FuppprKcGxVmtbDlXGkoEbxK8c28gtaUh41ZhWqLQSlx8BUNb6Mx0dsaYUlRHEdfp
         Y/dQ==
X-Gm-Message-State: AAQBX9cTU9o4O4dA1XbrdZTf5mVD2qHYG0oIBjNHgiQMPHmmI7ltq9cD
        TC7jGVxFjg63Yi1Fof6FEMazrw==
X-Google-Smtp-Source: AKy350bj3IrGeAoQoYkvn2I1Vjw5NcNZcwu0HvQvJr9grwiEu24uikLR1si+m25JGlZp28CqggFwEg==
X-Received: by 2002:a1c:f70d:0:b0:3ee:814b:9c39 with SMTP id v13-20020a1cf70d000000b003ee814b9c39mr468393wmh.18.1680552339953;
        Mon, 03 Apr 2023 13:05:39 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id iv19-20020a05600c549300b003ef69873cf1sm20798037wmb.40.2023.04.03.13.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 13:05:39 -0700 (PDT)
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
Subject: [PATCH v5 2/6] dt-bindings: ufs: qcom: Add ICE phandle
Date:   Mon,  3 Apr 2023 23:05:26 +0300
Message-Id: <20230403200530.2103099-3-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230403200530.2103099-1-abel.vesa@linaro.org>
References: <20230403200530.2103099-1-abel.vesa@linaro.org>
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

The v4 is here:
https://lore.kernel.org/all/20230327134734.3256974-4-abel.vesa@linaro.org/

Changes since v4:
 * Added check for sm8550 compatible w.r.t. qcom,ice in order to enforce
   it while making sure none of the other platforms are allowed to use it

Changes since v3:
 * dropped the "and drop core clock" part from subject line

Changes since v2:
 * dropped all changes except the qcom,ice property


 .../devicetree/bindings/ufs/qcom,ufs.yaml     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index c5a06c048389..874de31d2c41 100644
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
@@ -187,6 +191,21 @@ allOf:
 
     # TODO: define clock bindings for qcom,msm8994-ufshc
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8550-ufshc
+    then:
+      properties:
+        qcom,ice:
+          maxItems: 1
+    else:
+      properties:
+        qcom,ice: false
+
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1

