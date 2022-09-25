Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09095E9607
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 22:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbiIYUr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 16:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbiIYUrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 16:47:21 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFCF2A96F;
        Sun, 25 Sep 2022 13:47:20 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a3so7956890lfk.9;
        Sun, 25 Sep 2022 13:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=mzAbe27dU/1yrwR+00TAM5R4bCuMUl4NRC/4hekP9HI=;
        b=hz1ovK9Or+e2daOD7XcWiIVIIGAStl3645jGmUeDcJtXjtZUBcfaHhOKHnJDTiXZ7+
         4gPzTu7YGViW7gnr6+JjWFzDFnulxav+zqdZROFCUHgMjchT1i50ptMxOBzMjd9giHXX
         OR3DJM3MitSoqx1u5IQUU8JRgoDCqGMUae4XZLbFKzIof30HgsvPU/m+PXhN0X0bfaQS
         LV/XU+VVpxy42LUMNYwHIg4i7DvtL4OeUpMQ+Vva08vUXoOxYJyMreQlUDDraz9MhF8y
         rbWEfs+C1NAT2CejZa1j647EQybfxOBekE/HaFooARuxvBqw+91fnHB/LfCcQc+ppUCS
         wCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=mzAbe27dU/1yrwR+00TAM5R4bCuMUl4NRC/4hekP9HI=;
        b=h6n+NsH4lmtszgDNFdex6u/YQzMWyk9iZgEUa2Jipz3QallLMgieSD+KFaAYJuvo4x
         8T3JqnYlqQgRNfwetkJEiGbDYyG3wOUyzOfiK3B6rMlCX16sVuTbgtKsGJU2fHjmA+Fn
         YqkrOJYxPC5oMx1XViJxGj19L74mKgfQtpiE9WRIal0yUnuoANYtcqphzG3xk9D8dXL5
         CWK3/DVOhbrMSbHOJ8kFczHAnnTSpmVJb70e0KMcfZTgoELKmxRec043zCILh5mFdWx1
         XB3rNJzV7Qm75rQ9lcQFgL85iQ3QsIHu8qboVwoafx1gK1AhfRtaVG8o/DGnUQXObqg4
         VD3g==
X-Gm-Message-State: ACrzQf1GI+ALw0LGHa+AtgZluXQ9LzP/2RoawN5Vd4bdcxv9h1aXIzmE
        oDDquNaw3TdPxjzB3rS8Y/LzAOgFANYmWg==
X-Google-Smtp-Source: AMsMyM46PaLD7nrJJWvFmZGO1Vq0bbo4D3Pjuj6wNj+SIjp0+9gpT6PevAHgQRMEZHMKbaL0tGrQvA==
X-Received: by 2002:a05:6512:3ba1:b0:498:f547:866b with SMTP id g33-20020a0565123ba100b00498f547866bmr7185151lfv.653.1664138838585;
        Sun, 25 Sep 2022 13:47:18 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-5673c7-93.dhcp.inet.fi. [86.115.199.93])
        by smtp.gmail.com with ESMTPSA id c24-20020a196558000000b0049472efaf7asm2297667lfj.244.2022.09.25.13.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 13:47:17 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3] dt-bindings: arm: qcom: Document samsung,matisse-wifi device
Date:   Sun, 25 Sep 2022 23:44:14 +0300
Message-Id: <20220925204416.715687-3-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220925204416.715687-1-matti.lehtimaki@gmail.com>
References: <20220925204416.715687-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for Samsung Galaxy Tab 4 10.1 (2014) wifi
tablet which is based on Snapdragon 400 (apq8026) SoC.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
(no changes since v2)

Changes in v2:
  - Change codename to matisse-wifi
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index fb1d00bcc847..883ba92f589c 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -115,6 +115,7 @@ properties:
           - enum:
               - asus,sparrow
               - lg,lenok
+              - samsung,matisse-wifi
           - const: qcom,apq8026
 
       - items:
-- 
2.34.1

