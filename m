Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594785B3852
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbiIIMyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiIIMyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:54:15 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B6E102D7B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 05:54:13 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id k10so2529419lfm.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 05:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ZCn0GXiANcQyKgY9nJuVQIOooC9FiUvx8arkQzAhTjA=;
        b=NJwi1XURZwjxJWSP/FP1Ny/k149KULPjvRUsBNwUg9CDptARDut2sw1/XupZf53bh/
         qZGKlOchtHZlbu3GECtIl/IgWXAQfgYoFM1xa8LMKhXIkJpsm6KSyFK42DhTv9FrZt8m
         whQnrXrBFrafnYpxWe7t3Wd2g3pIBrenhQVF1YLXgagYsqq6PBTBgAySbL69q2oJxG/g
         g4uuY6MFqj85MwQ0/jlq+xhfh4ULMOXCzuiKNaAKkr+Jr76vImEa6NE6GfIz8dmDHE3Y
         tzyb0wa+jO+LqVmxqAPaHfUAtE2x6ZDgYSKOSJKpBuY4wnjUGkCWzIC2st+V1ieypElN
         t2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ZCn0GXiANcQyKgY9nJuVQIOooC9FiUvx8arkQzAhTjA=;
        b=nJB9D77iVEirxk2FpxeKS2gD/JD/UuF9ItUnu/xwES5wvxsp7+ntv9V2tljRx7f347
         /1xreXwPqZN5uABjXNsZGq7RIALpT/yD4GX6hjWrwuH1HdHt5tbONH8kI67NakRUuEiI
         2UlBuBgMsYqSs7pOLrdDZmQtYvTkZa1jsE/HoNALPEIJvUxPZtUDHPn10VubHMKlOs8m
         AMCMxc+D+7YnspkGs7AVyfS4NjwskzD/nM/QYxfUqpAStC304ImITMB/v3d+0ywU6Ast
         uA0ad0M6/AumMhOMvMm2PdAqLj+zk1j7i4TtvFZxxwwtiF8WRRGyNMkhK6q5ZJWCR5HU
         KyxQ==
X-Gm-Message-State: ACgBeo2P+hYilfSOeN2YiAF8PHc6RonBmuUVif+aIUb69Ng/Ac6GlLLN
        OwoinFcpEN6i3c1eAaicnXby1Q==
X-Google-Smtp-Source: AA6agR4f50I/Or/c9b7nX9faAawZV7glusqu6EbfTDJbrxAJfZ52ZAAYt4fyjWipoeuBt7AvYCZSUg==
X-Received: by 2002:ac2:4e10:0:b0:498:f132:d5c1 with SMTP id e16-20020ac24e10000000b00498f132d5c1mr2502595lfr.648.1662728051901;
        Fri, 09 Sep 2022 05:54:11 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g10-20020a2eb0ca000000b00263630ab29dsm64750ljl.118.2022.09.09.05.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 05:54:11 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        David Heidelberg <david@ixit.cz>,
        Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/7] dt-bindings: misc: qcom,fastrpc: restrict channel names
Date:   Fri,  9 Sep 2022 14:53:59 +0200
Message-Id: <20220909125403.803158-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220909125403.803158-1-krzysztof.kozlowski@linaro.org>
References: <20220909125403.803158-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm FastRPC is expected to in GLINK or SMD edge node and its
channel name is always the same.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
index 809de43afe35..1ed0ce0f3cbe 100644
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -32,7 +32,8 @@ properties:
       A list of channels tied to this function, used for matching
       the function to a set of virtual channels.
     $ref: "/schemas/types.yaml#/definitions/string-array"
-    maxItems: 1
+    items:
+      - const: fastrpcglink-apps-dsp
 
   qcom,non-secure-domain:
     description:
@@ -43,7 +44,8 @@ properties:
     description:
       Channel name used for the RPM communication
     $ref: "/schemas/types.yaml#/definitions/string-array"
-    maxItems: 1
+    items:
+      - const: fastrpcsmd-apps-dsp
 
   qcom,vmids:
     description:
-- 
2.34.1

