Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208456457A4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 11:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiLGKXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 05:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiLGKXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 05:23:05 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF8718389
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 02:23:03 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id bn5so20384625ljb.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 02:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxOwaXNbTiEohgYyBqos3ms0rULNHpJBLRwyMfOuuH0=;
        b=NtKUk2m1h3tLka81IoJVoYRO3XnaUNp+OqGVpu2UIcDW9+4BaG8iIZFmn/vtIjuTqi
         V4+WX4tk+TwKIvxxQWDijQxly9/gd6KSixNCxktzJkBLGftbVPRtuGBJBJZKOT2BRvpq
         WQyIFgXaeLdSnCBUAFJB6fdBC44QK0SZOP6rCHfdL5PRyW0mNbIWRuF3goCn15W+GkaY
         oKboGUhxZwqjHwmQDc5U7yUDwNaEM9y3el52V+V604DZkpjjsyukn1yOulYSUhnatiD+
         ki4VLvjYWaIqEqHMYS9EwMBeukSVaaP/ZPe0tkSMGvnLG9AADxtjgyREr08Di6iZ1cJv
         jXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxOwaXNbTiEohgYyBqos3ms0rULNHpJBLRwyMfOuuH0=;
        b=qJAmW90kL4B7QDbXoGxHufHFHJLUKQANFdAAhoQumTFO2ExUP5pBrUZt4VjgkFC0Tq
         58ZoABYk9PaxtYMvsR2bLPQTRGvhvCZ4owfNRZ5puiFMq/CsbUefIkeMRC/zsOJrQcoD
         az6/TJkwnP7o6VaQeW9FOJdyv4o85tuZLuhMy/nuZgVgahITRIL7PaMNHFlrVFinZrOw
         oSgCIOsj2+l3uup+F5AwnqumnbspNnDFh5oPDTloo4lzUKDEU2FWTQGecm6QmEIXeMi9
         V33LRlY1TotSK5E/sMnVteBnMhXUHpblOi1243uUA496GaPf2s1IukFzbCXQeq4B4MhO
         oWWw==
X-Gm-Message-State: ANoB5pmALnid0jfZ9NxSGH0tenUdfWUPqteV+w7H2M926z7o0nTs+6aj
        WeKgT3IEWww0G4R+q0vAVNSGNQ==
X-Google-Smtp-Source: AA0mqf6kl71n3zxYJOrPVwuyZZp4Mf3tgmyBuSLPs/1nIQLPZ1sv2HBeaCPNbpwVi7Vl5Oxm8OdFqQ==
X-Received: by 2002:a2e:b88f:0:b0:277:f46:617b with SMTP id r15-20020a2eb88f000000b002770f46617bmr26983808ljp.221.1670408583209;
        Wed, 07 Dec 2022 02:23:03 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bu31-20020a056512169f00b00499b27a329esm1953183lfb.300.2022.12.07.02.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 02:23:02 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Joe Tessler <jrt@google.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Jeff Chase <jnchase@google.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 4/9] media: dt-bindings: amlogic,meson-gx-ao-cec: reference common CEC properties
Date:   Wed,  7 Dec 2022 11:22:48 +0100
Message-Id: <20221207102253.26663-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221207102253.26663-1-krzysztof.kozlowski@linaro.org>
References: <20221207102253.26663-1-krzysztof.kozlowski@linaro.org>
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

Reference common HDMI CEC adapter properties to simplify the binding and
have only one place of definition for common properties.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/media/cec/amlogic,meson-gx-ao-cec.yaml        | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/cec/amlogic,meson-gx-ao-cec.yaml b/Documentation/devicetree/bindings/media/cec/amlogic,meson-gx-ao-cec.yaml
index f65c9681a9f7..b1fab53418f9 100644
--- a/Documentation/devicetree/bindings/media/cec/amlogic,meson-gx-ao-cec.yaml
+++ b/Documentation/devicetree/bindings/media/cec/amlogic,meson-gx-ao-cec.yaml
@@ -33,11 +33,8 @@ properties:
   interrupts:
     maxItems: 1
 
-  hdmi-phandle:
-    description: phandle to the HDMI controller
-    $ref: /schemas/types.yaml#/definitions/phandle
-
 allOf:
+  - $ref: cec-common.yaml#
   - if:
       properties:
         compatible:
@@ -81,7 +78,7 @@ required:
   - clocks
   - clock-names
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1

