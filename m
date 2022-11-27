Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A46639CE5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 21:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiK0UlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 15:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiK0UlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 15:41:08 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B697DFC1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 12:41:07 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id y5so2299400lji.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 12:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOZoVt4W+lcxF9f/uabO01wFDTt/KZZXxvtLpd6GcEU=;
        b=OFOl6Tiuk2EJnZ+H7210boETaHKYs5EM+OlbSujUfTjA3Blu82yWfJYE7AOXExUQDA
         cf14LqDa7er8/vucmRje1ik314TFQI053W14ZScQBqJnx/YopkUQKKcIY469gCMRPLwC
         +Um+QoGkb0LY1F28qYshrA2sRIWl60kKjoSx0PyQ9C0SFN4uiBHbCdx6OEVkq/qUu/id
         yZH8svuG6lP2jIQ16SWBrbACLs6jdjeCJrV5uoikCWqfxofjy6jHZOTpqBMd1M6IcoI5
         5fpWncOz9Sa3qNXHR6LngkYFqdQtCzX00c1+g0fXWuXydxC0vZCW7LtQdDfVss4VN13m
         A3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOZoVt4W+lcxF9f/uabO01wFDTt/KZZXxvtLpd6GcEU=;
        b=sWgpNT0H0q4qtOU2OsbmTvBYxGwXlvQ+e7K669QtOXNYn7kfbOEfpEoX8Bm5WXssYL
         toO4lt6XHQAAPdsQ+APMwSKrBjYqNSTUC7fdE9tBLwffrpjyoKsKUzJlfZ+pCwsM+4Xf
         tDIkmXxczmQQV9gpjBX9/MwYKQnGBJnOs3++RMPBLZ8IwzJZ51EViBpg3wH9oKBiQLIx
         OqC/vom+p4L3sWMA3l8yD/Xh0Qb+rssFsHznCTt3HJ4SlxLGjwOqv+SEbxKMGmGnZKVH
         M5azu64io+gX1snp1OpBun5+IcItYvDwQlcq9Vif8zaCPrvdcFsqV05xuG7IwbKHDHq/
         pCJA==
X-Gm-Message-State: ANoB5pmPnYTZVYBR9NL5/nRYSv127UI6pzNBcziiluAG2kGcZNux/aBE
        Pikf67cXZMXqVJwRvodX4Ybxvg==
X-Google-Smtp-Source: AA0mqf4PbVbjiI63poW81OvqdUlewSeDUZ8M7xGwA3CsG0+c4K+ZxOuzuyxbwV+a7yxTRjNplz75kA==
X-Received: by 2002:a05:651c:1551:b0:277:6132:ec9b with SMTP id y17-20020a05651c155100b002776132ec9bmr14385014ljp.466.1669581665800;
        Sun, 27 Nov 2022 12:41:05 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bi39-20020a05651c232700b002773ac59697sm644607ljb.0.2022.11.27.12.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 12:41:05 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Nikita Travkin <nikitos.tr@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Andrew Davis <afd@ti.com>, Gene Chen <gene_chen@richtek.com>,
        Bjorn Andersson <andersson@kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Luca Weiss <luca@z3ntu.xyz>, Neil Brown <neilb@suse.de>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/6] dt-bindings: leds: lp55xx: switch to preferred 'gpios' suffix
Date:   Sun, 27 Nov 2022 21:40:55 +0100
Message-Id: <20221127204058.57111-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221127204058.57111-1-krzysztof.kozlowski@linaro.org>
References: <20221127204058.57111-1-krzysztof.kozlowski@linaro.org>
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

The preferred name suffix for properties with single and multiple GPIOs
is "gpios".  Linux GPIO core code supports both.  The DTS has mixed
usage, so switch to preferred naming:

  omap3-n900.dtb: lp5523@32: 'enable-gpios' does not match any of the regexes: '^led@[0-8]$', '^multi-led@[0-8]$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/leds/leds-lp55xx.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml b/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
index dfaa957eee74..9a38e5ee43fe 100644
--- a/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
@@ -43,7 +43,7 @@ properties:
       - 1 # internal
       - 2 # external
 
-  enable-gpio:
+  enable-gpios:
     maxItems: 1
     description: |
       GPIO attached to the chip's enable pin
-- 
2.34.1

