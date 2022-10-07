Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6845F7872
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 15:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiJGM7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 08:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiJGM7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 08:59:43 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0B41082;
        Fri,  7 Oct 2022 05:59:41 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a3so7250899wrt.0;
        Fri, 07 Oct 2022 05:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJLkzhckeFshQoIGVrBkoMvfKHebYXfQWu6zMogaTcc=;
        b=MbC4F10bh/tlVCl4xj5R5MQ1vOtQYYCiiRNFuLXnd4i+cCBlKq/mprYpbArI82WKsM
         9S/0zLq4TCfkxlCa3fg5HVTRuQtIPlbIZVEYKAT+Kg03X8sMNe7iLGZuWnFtumxWgzvq
         fi5gzYjgIJOAWqkghM3txtIOzSNY3BCGzQuHzxNzoe3T6DhXkjOxijlKgLxoq4PE4rLs
         Medfdip2Tq1TvY7REoqhbDW7eGejcVvaFBDS559mX5xxu+i0/8zBLUUFHWFgpw5RXEBr
         I75gSoh4qfJm7DybeActXnnFtu0k3dWkXz5+x27QnUXXZn7AIoWYkfH67RIEHj/uEkP6
         /sHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJLkzhckeFshQoIGVrBkoMvfKHebYXfQWu6zMogaTcc=;
        b=Fg3cy0TFEPaaxQLnXJkF3s+Q+eESTkOQON5uqKjgAS4fqADnNWHUGgHWW4yvXWxkcF
         8HKI9f1ZsNybg1hk6O/4prW1kFn+l1mfRu/Vy1uWG2O1OhLzDBGCjA6b/zJxCV06e/Ts
         JbahT1xRwvM9nBeAnf30TvgYGZyCrNOxHqE2I1xMA1ETDJhEWRtEzVCGfXykUFbQWVl5
         L3hMS9CKhoGQolriMPzYo1GQmnnin1izXAryqtzsXsYSFqKEl3VZfwY/2SUktafSWPCN
         FT2JwJN58ghI1ktVF/dHQyxDPpRcdz9yKzVCbFsFm0/7DtVMKcrZsAv5R/ggAIO/wFtd
         5YPg==
X-Gm-Message-State: ACrzQf1/SJmfC7qXajAajtbXhqhsenj3tgc/P5m6BNCRVWZ5sdXtuaEf
        A5zYrzCQpenNrOtKmgEWWDU=
X-Google-Smtp-Source: AMsMyM7ikBxF1zrx15wf2hOuBcYSBcCJ4aCMTyIZGiuKvrxstdB5PaJsAMBv1q/+NQL2LEiimRY3aA==
X-Received: by 2002:a05:6000:15ce:b0:226:f2ab:516d with SMTP id y14-20020a05600015ce00b00226f2ab516dmr3215174wry.264.1665147579829;
        Fri, 07 Oct 2022 05:59:39 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id i15-20020adffdcf000000b00223b8168b15sm2008243wrs.66.2022.10.07.05.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 05:59:39 -0700 (PDT)
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
Subject: [PATCH v3 03/10] dt-bindings: pinctrl: mediatek,mt6779-pinctrl: Make gpio-ranges optional
Date:   Fri,  7 Oct 2022 15:58:57 +0300
Message-Id: <20221007125904.55371-4-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221007125904.55371-1-y.oudjana@protonmail.com>
References: <20221007125904.55371-1-y.oudjana@protonmail.com>
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
2.38.0

