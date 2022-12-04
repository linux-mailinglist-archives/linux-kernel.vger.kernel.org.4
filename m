Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C001A641ECA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 19:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiLDS3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 13:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiLDS32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 13:29:28 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B66E12D2F
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 10:29:24 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id s8so15347830lfc.8
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 10:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3M3VyN+gt6ftGeaDe6rXF+qMLaJNZCrheDPOaVNkN4=;
        b=Ds+u0ZbE0sJq/iBjWNK+IxPNbNDviPYZcAp+xql3tG9OD0vWUJ8mfgXG/Vaw9ddwiW
         xEav0N5hivFM+WsRUKsisnKVi+OmcpfL+dZh8IyGIx3ry1F7tciUd61J6xe5BkkBOu35
         qcgH6KTuszPG+CggawH1zVfd+rwsK/WqTeoFO4uhXP40rVGDcGMBqo3AJ7jCC99KeYuS
         3slDIWRZWydsycY6PPEmkDMDfNgcnAMpx0XUZpzcDVZls3N9jS2EkxyZUeIlfG8lW2To
         BbA7HiVcq1qaBvak1jJPKyygT50cVcPfUrAjRvEflATLZXrFKApwLkzPdn4FeUE+3iUa
         XySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3M3VyN+gt6ftGeaDe6rXF+qMLaJNZCrheDPOaVNkN4=;
        b=phHy6H5RCf0Hi2eyE00CG9y2iKLpd0e3ffUDpqubnW8tlbit1kO4RHs4WxWkuJL2Av
         aj240szkYlcqKceMBmM4ebKrcdCpw0aoZZmaG3HYBsdUvV6F2byQH1uUwj/axSphywgm
         7dZRAGQrAbVRCkrwd7ZlBsw+Qc43eRHruF9RIEduIJth9lCYr1Bo28rftQOESY3ztbIX
         ELdHmpN1h398wm7RH9NQ0+Vmeg77KU7wOI2RbCZgN+XQvtiYeQFeGbMTiAb6WibeBXoy
         CBqVHHClP8uOcgwdj1Uj1wmpNAK0q/cQX51AuDZ4JHwmN8Bjo/Qb6sT7qYvLYsb2+DtE
         zqfw==
X-Gm-Message-State: ANoB5pl4aUlUhk+1IYy1qVN1zw+feefQxB6HZqZy4+0MYyKndKX1TzJb
        AalvGfsFs38xF6/N0k9Cagq4AA==
X-Google-Smtp-Source: AA0mqf6pY51XPJcwK4YklKJNLUWc3bAAU36hqO/Jj5kXIUWVKjswhYHVnyQo7swA5lN98jdcrzxwiA==
X-Received: by 2002:a19:f713:0:b0:498:f36a:76fa with SMTP id z19-20020a19f713000000b00498f36a76famr27418948lfe.532.1670178562707;
        Sun, 04 Dec 2022 10:29:22 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id i15-20020a056512340f00b004b3b2a9f506sm1838996lfr.4.2022.12.04.10.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 10:29:22 -0800 (PST)
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
Subject: [PATCH 4/9] media: dt-bindings: amlogic,meson-gx-ao-cec: reference common CEC properties
Date:   Sun,  4 Dec 2022 19:29:03 +0100
Message-Id: <20221204182908.138910-4-krzysztof.kozlowski@linaro.org>
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

Reference common HDMI CEC adapter properties to simplify the binding and
have only one place of definition for common properties.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

