Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4646B403B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 14:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjCJNWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 08:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjCJNWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 08:22:30 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB345FD2A5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 05:22:07 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id u9so20407644edd.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 05:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678454526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcXL6MCdOOilzj/9V8Bxhr6PgZvPsGUvEZbtUrf8CA0=;
        b=QWRaO46r5Vlo+LFpfEj41+oWL74m9vY9Ye1RziJsp7mkHfJg357wAQjE6BSqZxl1OP
         WBeQSKR+I0Vz4KemBZidBqo0sdYi30BB7QngnRQtPNPX9izS42xhL4QrpBlEpSMyS1La
         aCMC7sHmtJ9rov8CDTNGUPFBvGl0guj6xQ64aQOx50BOrKAOoADxn6xhQY0nsw40jBnO
         7/yQ5OD8flLzXTkCHyfpRE4L200L6IxelwR7ynIAw5dVdpqoomUVZbyUMDvUKwVFskTc
         UdMTONwoarGEBF554WPMXmeWNd5fnI/gHGkGRiBPJGilCR9hYZj4bgMgX9KTmc2fBJGZ
         gm5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678454526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AcXL6MCdOOilzj/9V8Bxhr6PgZvPsGUvEZbtUrf8CA0=;
        b=HahKWWAsmifZevIjBmReg19FPeYzf34+AJnz6aBYa57AxquDoSYAlvAlW3X+IgYOES
         Rb716ZaWCJnG9yZe7fJGqU8IckAZ9AmgaWvI+KbOLNXjGjMIN8ylknt11WQcbVxvBaCf
         Shb52IV+HMkXRXi6bxQ/0V1sOcJiZBd1W9Bx+HAUZ+9JYOi7TjA45w5fxxmrc4vuCMVQ
         Y9oUTLQ5/xkYWhObEYeGdVcTuyc9mSNSXpNCKlr2zZyZ2iz0BGD6tfNm71gkPJ4Z7Nx9
         t82E/6tmRfdRglUQHoIhMPNUXQ4nmoIqkLdzaycHGs+x79L9B7sqiS1omXsw43xj1g0A
         04KA==
X-Gm-Message-State: AO0yUKVRhYjSv/cPo73xoS/N/5FRv53x7dC9uIm/+L2VVX61J63cpcDM
        +A7oZjK+sLcCPdkmF5P5dl3uUw==
X-Google-Smtp-Source: AK7set86DEihjYozkYNfs2JVNMeu/cjpWbEQPkrPICoAQV9Zd2V3aoH5znXQFvekHR3LgD1deH2NWA==
X-Received: by 2002:a17:906:32d9:b0:8aa:bf4e:7b2c with SMTP id k25-20020a17090632d900b008aabf4e7b2cmr26777378ejk.21.1678454526446;
        Fri, 10 Mar 2023 05:22:06 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:45c4:46be:ec71:4a51])
        by smtp.gmail.com with ESMTPSA id zc4-20020a170906988400b008b17879ec95sm959124ejb.22.2023.03.10.05.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 05:22:06 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/9] ASoC: dt-bindings: qcom,lpass-rx-macro: Add SM8550 RX macro
Date:   Fri, 10 Mar 2023 14:21:54 +0100
Message-Id: <20230310132201.322148-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310132201.322148-1-krzysztof.kozlowski@linaro.org>
References: <20230310132201.322148-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the RX macro codec on Qualcomm SM8550, which comes without NPL clock
exposed.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/sound/qcom,lpass-rx-macro.yaml    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
index 8b3d617a9578..0ae3c81abdf8 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
@@ -15,6 +15,7 @@ properties:
       - qcom,sc7280-lpass-rx-macro
       - qcom,sm8250-lpass-rx-macro
       - qcom,sm8450-lpass-rx-macro
+      - qcom,sm8550-lpass-rx-macro
       - qcom,sc8280xp-lpass-rx-macro
 
   reg:
@@ -92,6 +93,23 @@ allOf:
             - const: dcodec
             - const: fsgen
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sm8550-lpass-rx-macro
+    then:
+      properties:
+        clocks:
+          minItems: 4
+          maxItems: 4
+        clock-names:
+          items:
+            - const: mclk
+            - const: macro
+            - const: dcodec
+            - const: fsgen
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1

