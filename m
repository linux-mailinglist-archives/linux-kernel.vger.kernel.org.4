Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47796E39F6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 17:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjDPPr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 11:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDPPr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 11:47:26 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D942D73;
        Sun, 16 Apr 2023 08:47:25 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-329560b1994so4741565ab.3;
        Sun, 16 Apr 2023 08:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681660044; x=1684252044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=475k3G03c46QPyiaxfGPBy/K6bUcqTXt0A1kqbPfJrQ=;
        b=QRcu8+d2+ACNA4wQ+1n+kyTE6ET4Dmpf3RebBLyuTpj9Vwy5kuABYUWs4kExn48Ns1
         aqkleZBSYA6B+QySAnae45XqmA+iylIHoMWArKNgQys9jjzpX/wcUc/9DuSGnWGQqV00
         PKaBxQx4oPWGlcILHCfEM9Krm5IOJsjz/0qRgED8NLccCrjjzfxsfHriJp2AvH7qqmXm
         C/1DPNM+OLDZctbLAqx809+9FgHu6/clZlt6wA9uxgUqawx6J05vicQ/7Pbt7EPElbCO
         wA7+H5YRpDrA3udh9qtw7dY7gyKsVs4IUROTnv1gVbMEZqeG0/4KPLCED7XiqNXwhvbH
         BJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681660044; x=1684252044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=475k3G03c46QPyiaxfGPBy/K6bUcqTXt0A1kqbPfJrQ=;
        b=WV2sJ91tBxoRnVEusfUg6vf4CKTkpcJBz9lGIdoXns2M75aaFvAzNWtBNQqd6ymqs8
         B95An3i1y/7nRmhRm3mrAxy9bGWKUajvhKU5x0PsZBJhUplXVhy7fPJJn+XpRuKGZdOg
         nphYBll2KmAD/rG8zn2tMzg8uDbSvX2TV8iFqE8OMzrGIqYwlrlwNcuqu9UomLXeKJY3
         fUDq81XSbDp6POpyLNIVEsbi0BUgxc1Rcy4GDITyuH9Kjp8ge7wt1iHkdXimXas4CgAh
         90ADMO06TOSES81DpXOjd8n6G3EgjvE6rbHWq+zwBaQZg/jztWCelDPLoWkhIDQ8BeEy
         l4fA==
X-Gm-Message-State: AAQBX9e/co7QZWrnZ33r66XDeBe4Gm6DaZjpwrSjto9/XrI7FhaFwA2F
        23OueBZZnhbvEKFURpe1Bk0=
X-Google-Smtp-Source: AKy350aiKvWziwxjnRlCjjjVuxGGl1XwZhqvK/dJAcHfLH23CksyCOFNBusPgWMemoZmy81VyyssvQ==
X-Received: by 2002:a92:dc50:0:b0:32a:93f5:fbd with SMTP id x16-20020a92dc50000000b0032a93f50fbdmr6050404ilq.27.1681660044687;
        Sun, 16 Apr 2023 08:47:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 7-20020a921307000000b0032732e7c25esm2571870ilt.36.2023.04.16.08.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 08:47:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 16 Apr 2023 08:47:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Bernhard =?iso-8859-1?Q?Rosenkr=E4nzer?= <bero@baylibre.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 03/12] dt-bindings: watchdog: mediatek,mtk-wdt: add
 mt8365
Message-ID: <05d07422-d53d-408b-972b-5937861afa63@roeck-us.net>
References: <20230203-evk-board-support-v5-0-1883c1b405ad@baylibre.com>
 <20230203-evk-board-support-v5-3-1883c1b405ad@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203-evk-board-support-v5-3-1883c1b405ad@baylibre.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 02:59:22PM +0200, Alexandre Mergnat wrote:
> Add binding description for mediatek,mt8365-wdt
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> index 55b34461df1b..66cacea8e47f 100644
> --- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> @@ -38,6 +38,7 @@ properties:
>                - mediatek,mt7623-wdt
>                - mediatek,mt7629-wdt
>                - mediatek,mt8173-wdt
> +              - mediatek,mt8365-wdt
>                - mediatek,mt8516-wdt
>            - const: mediatek,mt6589-wdt
>  
