Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8421C6115FE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiJ1Pfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiJ1Pfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:35:33 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E8D733F5;
        Fri, 28 Oct 2022 08:35:28 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id f7so2732382edc.6;
        Fri, 28 Oct 2022 08:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1V4gFthMJstNGcNhM92rVABM0TfYB3AObPf1xTowFY=;
        b=FcV+0oYeqEJQCRPz/cdvdrccW6P3vyTfyD5SCo4BOqscyvvcL96TPwX98ubqTa+ZdQ
         QyryJMOTYp1Jw75vsyiY2vodsRkfF6Facm9HcNBXM2ZXd2pY80/68vRvDXSM+2ORvWzh
         +BUeOeRdtzPSw1myhI8mkXAdXxSyP9Rx95E88HVlyxbkAT0HKPyxsIMqSXbpjHvB5juo
         v2hVUpW5e96h/Agd6c3HPxHGftc1w+5k6c/vk+GP6MQovz10bnDoIok+qIVRh5fuJjJH
         sbllyCjmdss3wSuFL7SrsKuCKA6gTT7RvpEcc7uxgvdvdRmmcPWqWceQr2fsQyXRyBEQ
         YUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s1V4gFthMJstNGcNhM92rVABM0TfYB3AObPf1xTowFY=;
        b=YZUg+JvVP9utyVAVdI5mfValDaszh2KtglqEBgm3wAbmdr+UntDA6FU7d3T1zBD+FM
         76Mz+S334UsL3qGBz4HCm/bn8Hv+Hw4IQem+0WvlTuZsWqkh3PhoAelY5nraWQ62WJvm
         LOqewHxWf3UDVcvYPB8dKx7FPykyOPt5Yx3PC5qPFqfvH6qhlaXVRlUhNUm7xlAUS1UY
         uR3MbrEitYdaYpMgJSPCn/pUQLMbfzwMzFfLuzs1PD27NPVtY0lYxjUy65uCKwolnyQQ
         /YqIkeqiat3J9s0JBK6GC1JOb/tJtCBI6FVHoKlhyAOfLm4Jeg0qELnleYTudWgUUW5J
         Gjcw==
X-Gm-Message-State: ACrzQf0soAdo1dGWcx2t7Xr36QbBBQkcvNRwKTLvUC1alCK9ff6QBu6S
        1yuuDpMg7E42FZX6GxvqS24=
X-Google-Smtp-Source: AMsMyM7hzZ4RIeUlH+o0Dg9E0o2OrHjXLCpJwdUn/BZ3QCJyKqaRyjuW2Gw23e5wwKBPfvZisNkd8g==
X-Received: by 2002:a05:6402:254f:b0:45d:3044:d679 with SMTP id l15-20020a056402254f00b0045d3044d679mr276edb.137.1666971326968;
        Fri, 28 Oct 2022 08:35:26 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id ds12-20020a0564021ccc00b00461aebb2fe2sm2830635edb.54.2022.10.28.08.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 08:35:26 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v4 03/13] dt-bindings: pinctrl: mediatek,mt6779-pinctrl: Make gpio-ranges optional
Date:   Fri, 28 Oct 2022 18:34:55 +0300
Message-Id: <20221028153505.23741-4-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221028153505.23741-1-y.oudjana@protonmail.com>
References: <20221028153505.23741-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

The pin controller can function without specifying gpio-ranges so remove
it from required properties. This is also done in preparation for adding
other pin controllers which currently don't have the gpio-ranges property
defined where they are used in DTS. This allows dtbs_check to pass on
those device trees.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml     | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
index c6290bcdded6..d45f0e75a698 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
@@ -67,7 +67,6 @@ required:
   - reg-names
   - gpio-controller
   - "#gpio-cells"
-  - gpio-ranges
   - interrupt-controller
   - interrupts
   - "#interrupt-cells"
-- 
2.38.1

