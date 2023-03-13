Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AA76B76BC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjCMLwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjCMLwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:52:25 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8EB1A64D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:52:13 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id j19-20020a05600c191300b003eb3e1eb0caso10732457wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678708332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8zljTNF4Pe4dDvsxbbCfXKVrLgdz9C9Te0bWssuxG4=;
        b=LIKvu/0rcwz5S4cPE3dnmQ3G7EujLWKSt6Qg7bVuNT+6nnsm76nwlXKVJh/CF69Vo4
         0+uY+jSaHQOGOHQCuwp9jNnU2yqR9W0UqZFOXPk67NUHnwtfobIEeX3vUoqnTe5vB684
         KLLKkHaTEYCUDfkohy2L3HAm3ln2X7r6F9uqQh77CDH1Rm4+OdIbbW/QJAmHQ3sZa+Lo
         MBiA+6Wk8burl01cGeSdLpnQAMVqMCE6fGqNIlG9tnwV3hFxgpPbX/KaFYg8FfgWF9oh
         e9388rXt3xzfD2e4I7xi79OeiqJjtUmSpDVsMsDJE2mtj+qggcVx1DAHbIo6ejgPvf+G
         SXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678708332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8zljTNF4Pe4dDvsxbbCfXKVrLgdz9C9Te0bWssuxG4=;
        b=K7lY0k3ZdP1BKxqB5uZ3S5jagZWDSeRn94onGBylU1J7fUmPHW4iR+BhmBNqdjVrr1
         bwKkHpnXtCN0gjrGZEDC1rEgVIvP5vxJqn4dYX7sE0WA9wbFq9QjBUMgDsIbvVPleZ6w
         Bc3XSmQnNJ8xdjy5GcCVu7gJ/+KXMLeXyXnfxpAIHar1/dKmiIRJrG8zws96wiZcOAXz
         Vs4OUMKLyuLjbOT8ajkAcw76sNE8JeJUZ6zv444h7NlwLgXRlvXPWzpl7ODwnIvBrJ9j
         JsnoaFIyBR7LnFJtN7NQ4G/yrMMMJM4NLty9Zll/VOyhTrodus6y2WJu+XgdYQK917mp
         ZIpw==
X-Gm-Message-State: AO0yUKW9rTCXAOuejTQ2G+kEqLz1gtCo/0tnlWJEV/CX3zrseJwMBAO9
        JAp9fcpKAoBB5btcUjLVTOrsdg==
X-Google-Smtp-Source: AK7set/eDxqplp8SwG4mA/yLb8hDWH+E1HWLcvcJD9Gxy3aH1WN/n+eqGPvd9Pmsqx+w13r8BQnT1Q==
X-Received: by 2002:a05:600c:1c95:b0:3ed:29db:cb85 with SMTP id k21-20020a05600c1c9500b003ed29dbcb85mr477035wms.11.1678708332124;
        Mon, 13 Mar 2023 04:52:12 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c440f00b003e21dcccf9fsm8801090wmn.16.2023.03.13.04.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 04:52:11 -0700 (PDT)
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
Subject: [RFC PATCH v3 2/7] dt-bindings: mmc: sdhci-msm: Add ICE phandle and drop core clock
Date:   Mon, 13 Mar 2023 13:51:57 +0200
Message-Id: <20230313115202.3960700-3-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230313115202.3960700-1-abel.vesa@linaro.org>
References: <20230313115202.3960700-1-abel.vesa@linaro.org>
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

Starting with SM8550, the ICE will have its own devicetree node
so add the qcom,ice property to reference it.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

Changes since v2:
 * dropped all changes except the qcom,ice property

 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 64df6919abaf..0ad14d5b722e 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -120,6 +120,10 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: platform specific settings for DLL_CONFIG reg.
 
+  qcom,ice:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to the Inline Crypto Engine node
+
   iommus:
     minItems: 1
     maxItems: 8
-- 
2.34.1

