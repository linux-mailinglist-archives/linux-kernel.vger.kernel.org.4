Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572346B76BF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjCMLww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbjCMLw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:52:26 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419B3136C0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:52:15 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id k37so7781910wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678708333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2H0CkOqqY9niGb8lT2/yOlC10kv4voB7XBZF/NVVMI=;
        b=PGwxkIfB+Kos7dLMUF2U5qJibiYverU5hfAwFzFTK7XJfNnJaTIDSa6h6OJybMNv2O
         H1UZKuChN/17kudrNeyZk+7im3DwBrZ+noyY0IShsjHaKLZmCJG1txslQiHCtcYaX585
         fJLbJlYhpIIGgfrzleqYhq6XElp2LRnnQc7JclxBM3klB7NhL3DaZfd8jzYAl/0EfFdt
         z4slSj5Aaawde59gAWJ5QXJSNjCUbwTJzAolfxLxcByrQy/bOh+FwpIMsCPdloHHTK0i
         VQDfbGzG+bp2C7zMTBqFaGMrb+oIOatZeM/eHFkMqjDM2KIuEXbB53t32YXvPO+w4Maq
         GyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678708333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R2H0CkOqqY9niGb8lT2/yOlC10kv4voB7XBZF/NVVMI=;
        b=1oHlBTOdwWQMlrWQAJwHAChLFkO710YM+yB1cPf2NmDJGGz1tQuXJYlyi7PzkTvfYY
         4zeUYTP/RrAaxm3BT4/p0sPVZgFFFwY9azRwLUlCMdVW1tRwJ1z+hQJcLbwQ7+pAAsLw
         BzmEgrNhshH8Y6Ong2pAIr/XhwOerwquzG84ZhzM1vYOdqkUk9t96Sc12qjx72RLEFFv
         /zTNhDHCt0Qvkty1/4R0KysIgd9trYVA//aHBRF6e9ikls8EppBwunw6zCEp9H4/SKkk
         xfsKTZV+ifJAyHK22sSvfz/6D1fthqxJVuNUtobd4vwLSfLu9d5Gd+/NlzSWIYqroyTV
         Vpmg==
X-Gm-Message-State: AO0yUKUQ1j0/V5xMNiwoPLHHxpH7XVLfTI8fospxBMX2JPugBHTU8Bfk
        duL+dB2n8SVT0J8yyPa9JnRomw==
X-Google-Smtp-Source: AK7set8B2+uATswZ4wvEtMwdyws1yg+We8smdpDZgmnTRUlEvXLkQjBhfaOjar/FkVynljuYhbpR+Q==
X-Received: by 2002:a05:600c:35c1:b0:3df:deb5:6ff5 with SMTP id r1-20020a05600c35c100b003dfdeb56ff5mr10502817wmq.24.1678708333677;
        Mon, 13 Mar 2023 04:52:13 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c440f00b003e21dcccf9fsm8801090wmn.16.2023.03.13.04.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 04:52:13 -0700 (PDT)
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
Subject: [RFC PATCH v3 3/7] dt-bindings: ufs: qcom: Add ICE phandle and drop core clock
Date:   Mon, 13 Mar 2023 13:51:58 +0200
Message-Id: <20230313115202.3960700-4-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230313115202.3960700-1-abel.vesa@linaro.org>
References: <20230313115202.3960700-1-abel.vesa@linaro.org>
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

Starting with SM8550, the ICE will have its own devicetree node
so add the qcom,ice property to reference it.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

Changes since v2:
 * dropped all changes except the qcom,ice property

 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index c5a06c048389..7384300c421d 100644
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
-- 
2.34.1

