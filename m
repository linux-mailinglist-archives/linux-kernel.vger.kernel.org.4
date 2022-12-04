Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB41641EBF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 19:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiLDS3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 13:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiLDS3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 13:29:22 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBD412AFF
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 10:29:21 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id z24so11190951ljn.4
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 10:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+PteMG/Ads8tC893Hy13VLmIBDMK2suUNCe/1HZdDs=;
        b=zP5nnhCXiClJ1DgCHNM3yk7JNqSv02YTEZax4FH6Y0gPcr14cFqylT8Hbkz3SNtRTn
         MkkF0S/zRYGUQLLy4DbRInPHw2yzVtW7QyTVzI4pU4RpNqkljZEkCcCg/LtaUqR2smha
         hbhh0k+4K7ONv9Dwd34Xy49ceZftpvWYk8vLjLe/4r/8nB6LiBKf0wYrWO4+eP0fH/jD
         3L9eUcSGuHBbDzFwLP8nW/QAjNXtSdRxAemSmyqfsEcvdW5FPFWbBwVX038t0+yVF/nA
         QpcSWxI0MFIR6ADPslPbPPo2k43pYt8w9InuRouSkiNz/hL1UPAbLyX8H8DHD/vrcD1A
         Zhxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+PteMG/Ads8tC893Hy13VLmIBDMK2suUNCe/1HZdDs=;
        b=cy+XkP6OLGNyd2yk1oXLwJq/scAYc5g0AsLkZ3GVTRvRRuRObrPm6lDA7cxdK137Wn
         HExhzL8mojNhuQicisPSycuoh6r2XEah32oti9hdS3oTXYK7qdhhlBnfTQZ6vR0AfnT1
         yjCocpbnfwLOkNWLlLAZjLgtt80NEUdJw30o1iOBgwUMWeSC1930mYIWwINqRMikkQWA
         C0rKoULWf/X/LBTA8xxm5Rouxijj5S92eR6MMnGTY+ZAIDiuSb2o6HmqbzzUofOWF11D
         IoCtDFTK/zf9GFJMFK/JJHurX7TLiGy1aBKv8xMx/YLYX4RNa51RnfcF06+ucLoD0bgR
         ljxg==
X-Gm-Message-State: ANoB5plgUgECfuDpmBYBB2VjwPZibXY1yCdL7qqUclm0pLoW9VwhT5HX
        cRhbiiPfEdL7dkyK6XrkHgg+LQ==
X-Google-Smtp-Source: AA0mqf7cT4VZxE40h1S5qRGuAOZwWxzBWZBIYv7ax4dztOW39Zzssoufn9ODgvCoaB+u5NHzZC0IXw==
X-Received: by 2002:a05:651c:1145:b0:277:8759:bf65 with SMTP id h5-20020a05651c114500b002778759bf65mr23608947ljo.108.1670178559826;
        Sun, 04 Dec 2022 10:29:19 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id i15-20020a056512340f00b004b3b2a9f506sm1838996lfr.4.2022.12.04.10.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 10:29:19 -0800 (PST)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/9] media: dt-bindings: st,stm32-cec: move to cec subfolder
Date:   Sun,  4 Dec 2022 19:29:01 +0100
Message-Id: <20221204182908.138910-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221204182908.138910-1-krzysztof.kozlowski@linaro.org>
References: <20221204182908.138910-1-krzysztof.kozlowski@linaro.org>
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

Move st,stm32-cec.yaml bindings to cec subfolder and drop unneeded
"bindings" in the title.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/media/{ => cec}/st,stm32-cec.yaml     | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/media/{ => cec}/st,stm32-cec.yaml (89%)

diff --git a/Documentation/devicetree/bindings/media/st,stm32-cec.yaml b/Documentation/devicetree/bindings/media/cec/st,stm32-cec.yaml
similarity index 89%
rename from Documentation/devicetree/bindings/media/st,stm32-cec.yaml
rename to Documentation/devicetree/bindings/media/cec/st,stm32-cec.yaml
index 77144cc6f7db..2314a9a14650 100644
--- a/Documentation/devicetree/bindings/media/st,stm32-cec.yaml
+++ b/Documentation/devicetree/bindings/media/cec/st,stm32-cec.yaml
@@ -1,10 +1,10 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/media/st,stm32-cec.yaml#
+$id: http://devicetree.org/schemas/media/cec/st,stm32-cec.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: STMicroelectronics STM32 CEC bindings
+title: STMicroelectronics STM32 CEC
 
 maintainers:
   - Yannick Fertre <yannick.fertre@foss.st.com>
-- 
2.34.1

