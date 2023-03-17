Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677586BF407
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjCQVb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjCQVbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:31:10 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB7A145B66;
        Fri, 17 Mar 2023 14:30:43 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r11so25444788edd.5;
        Fri, 17 Mar 2023 14:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679088642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WT6hzu0DmgFDhxzzLNhQjlkkdnwsxET9D8SPDLbHKjA=;
        b=UEYfnjckvyeT4ff+QOXYlCo1x0vkS+97iJsTIz5oFMWcTba0RcyN4rXJ8vPaUYhG6l
         v67MSNk2sy7ml1YgGgv1ccNs9CY0pslZzfhAeBYfi0mUbOFP202jj3/QA2rLxgA05uwA
         6W6fiyoeyELDX67v47zpoeSYm+2fLsjeR2mYkcMEJJQGMMfeGV0XjFi9WnWq0P2JF7xE
         5DB+gaaBd/7M3h473Ea4Xhfp706z2NyX+9ILn3URTmuvJLpDGklt2+1tJINvH75aoSrO
         /yISzzEN6WNm33sDxOxS7JU6vm2Krh9bJ4ZtiAmznusxeIb61o60mMuNVsV6zT3Ki18M
         Hsig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679088642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WT6hzu0DmgFDhxzzLNhQjlkkdnwsxET9D8SPDLbHKjA=;
        b=NjwZ3bpSZcLhNKg3ryCIMf97XoUbmi5UoaXGVMqRGtMjJTOgMDucEmoDiNmJBCh3lK
         /WJOpGveyxwxVYOBcuajg6oqdRBwJLY6mOfhBYAsw9vVA3V4bFdn6spp73QfUQwDue6N
         HJ0DclGbCzq5pWrtGMms8g5Bcxf/iXqKjOUOHluKZLFiW0a80SYqiYB4vZQ4wmx8SEHp
         +b3tfO5ptFiDnw2VQsKPWb9jH0Xf/lKTdzi0XYCptRBXfNd+jn5FeIju55fU3cnFFsQZ
         Hjodd9OEiluI/r64CXqSRVv4X/1HTMX1vcX5YazOsjGC5JRn9uQ2Gc+5PbkjMT+1wgzU
         AGSQ==
X-Gm-Message-State: AO0yUKUl7NiX7hrlz6SQVe9cuAaeIXh+NQj2hIPl0F//pg5N+SkLLCZa
        xsigKoCSb9zOm1zwh+AKJak=
X-Google-Smtp-Source: AK7set9o7vfI9g2tW01l5H0yRVqz8bipCXXGTjL299vsol3YqeirzwA6JaKCs9+IdMWE6xdzPmV/5g==
X-Received: by 2002:a17:906:c2d5:b0:92f:d900:9c66 with SMTP id ch21-20020a170906c2d500b0092fd9009c66mr899947ejb.10.1679088641575;
        Fri, 17 Mar 2023 14:30:41 -0700 (PDT)
Received: from arinc9-PC.lan ([149.91.1.15])
        by smtp.gmail.com with ESMTPSA id v19-20020a17090651d300b0092b86d41dbasm1404683ejk.114.2023.03.17.14.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:30:41 -0700 (PDT)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Rob Herring <robh@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Hui Liu <hui.liu@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
Subject: [PATCH v3 10/21] dt-bindings: pinctrl: mediatek: mt6795: rename to mediatek,mt6795-pinctrl
Date:   Sat, 18 Mar 2023 00:30:00 +0300
Message-Id: <20230317213011.13656-11-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230317213011.13656-1-arinc.unal@arinc9.com>
References: <20230317213011.13656-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arınç ÜNAL <arinc.unal@arinc9.com>

Rename mediatek,pinctrl-mt6795.yaml to mediatek,mt6795-pinctrl.yaml to be
on par with the compatible string and other mediatek dt-binding schemas.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 ...ediatek,pinctrl-mt6795.yaml => mediatek,mt6795-pinctrl.yaml} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/pinctrl/{mediatek,pinctrl-mt6795.yaml => mediatek,mt6795-pinctrl.yaml} (98%)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6795-pinctrl.yaml
similarity index 98%
rename from Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
rename to Documentation/devicetree/bindings/pinctrl/mediatek,mt6795-pinctrl.yaml
index 9399e0215526..c5131f053b61 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6795-pinctrl.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/pinctrl/mediatek,pinctrl-mt6795.yaml#
+$id: http://devicetree.org/schemas/pinctrl/mediatek,mt6795-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Mediatek MT6795 Pin Controller
-- 
2.37.2

