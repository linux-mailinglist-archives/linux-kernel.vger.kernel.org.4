Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C42646CF6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 11:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiLHKds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 05:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiLHKcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 05:32:07 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0100981D81
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 02:31:35 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id p36so1337915lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 02:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxOwaXNbTiEohgYyBqos3ms0rULNHpJBLRwyMfOuuH0=;
        b=SNdyGSv85VbVAi3pneX2JkKUEzvN0PW4W9IL5g4DRhHvrBMOeni6Z+pOOEUpcInHC4
         8Oe7zRj7yqve48LHxc9nGSZ8mjyRRCvJpCF3Z+HStSkQrZAQaWw7GQJclRQO/E9VVVfd
         Buw7kNckTMw6llktH1TFtA8zYKuFyKlQfBHRHR2N0gMd5aCUYKIQZHVTqSpTEg/De5ZJ
         /7DYMHhSqyEC4K8AQQoiej8iBaSgPHsLttayPnDRwNPyQdAbC6HBdlCjQciE5QjQ2mgc
         Vx23NFx3NOCox+iJMxdZPi1LNdtRivWrNNhADRl2USslYsznJEGxEtTQac8m8oo5Up8r
         ayQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxOwaXNbTiEohgYyBqos3ms0rULNHpJBLRwyMfOuuH0=;
        b=wVzY5VkWiHvCgtHN8w1Z0/Fq+u3e6gO/WnrR5Nq653FszXoQuPoYlorTMZFAdwSYBq
         A+4W3Z4qSGO17CBpAx7icAQ3EfHVTrJUmqeOSWDx+seC920w6lRYSGp+fTitydVH+yhE
         qwONIM6M3fIyEx4j92TRgGqTN/WP9obI4nEmzOa8PWuIKkHKiofGhquIzLkvbuXRgPPv
         xcZMwwKXBt4ei0EtrSYB0M0w99GJURcRzLBhpEWE/gejN6mV6HMG3tx+Ez8yX9FobuOo
         +To23IbxP2CDmwsUOg50+oE0l7MPmSNI26Ic9GVHPL8aB1WCfj7XjkyHMmEIyl457R+P
         +j+Q==
X-Gm-Message-State: ANoB5pmAqW5lML3BYYjS9AhAoDYTSxlm2saC0cq7K+sI8LyPcFwvw2vo
        cQgtJIgOiW8yxSic6sGtgV8+Qw==
X-Google-Smtp-Source: AA0mqf4diiVxd7W4vZQ0KqLCAk/r4Pm72qA2Aa2aQQA5cwubEv5SXUy9nz5yQdu/ga1nWqYYYtXzrw==
X-Received: by 2002:a05:6512:3a96:b0:4b4:f5da:fb28 with SMTP id q22-20020a0565123a9600b004b4f5dafb28mr20618283lfu.169.1670495494230;
        Thu, 08 Dec 2022 02:31:34 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id h18-20020a2eb0f2000000b00279e5247dabsm1699580ljl.18.2022.12.08.02.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 02:31:33 -0800 (PST)
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
Subject: [PATCH v4 4/9] media: dt-bindings: amlogic,meson-gx-ao-cec: reference common CEC properties
Date:   Thu,  8 Dec 2022 11:31:10 +0100
Message-Id: <20221208103115.25512-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221208103115.25512-1-krzysztof.kozlowski@linaro.org>
References: <20221208103115.25512-1-krzysztof.kozlowski@linaro.org>
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

