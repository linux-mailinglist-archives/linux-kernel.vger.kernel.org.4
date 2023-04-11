Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6766DDC5F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjDKNks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjDKNkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:40:43 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6A344B8;
        Tue, 11 Apr 2023 06:40:34 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id cp25-20020a056830661900b00693ce5a2f3eso3861069otb.8;
        Tue, 11 Apr 2023 06:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681220433; x=1683812433;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kgFPvyHrHPtWE9sKCzX6mH86Owceqhrm+Hat2sO8n/A=;
        b=MrjRJQAHsKT5D9MRrrI7jRj4QO9oi0vDxaEsUC0BuvQh5GooLZhjISuaGDmmXpl/9N
         3PUTMqcZcqgDKcMNgowbdXo+3zoqIBSVFdhfa7VVst7s2I6FgKZ2BisOS2U/47H4wgm1
         a9nBdxQLutH6BbTJuKKFIwC8OWZv8y87LG1DVmiXM5saS9WvSWxLc1WW5YUjY73xXScC
         Om/9dpdJWqrkJeMn5MkB+Y4+IUtDx58Dp0/we7b7yGMbMrbcn2yDYcwrFr3fXbp5R+6c
         nm+Z78myxWOgQJn0MVHyhb+zJn6OaL/rGBxff5ykliF5NVr/ptBZJGaPyiDbD0gyCtqE
         8tAQ==
X-Gm-Message-State: AAQBX9fcrPqbtV39JmEhUT9WGLnB+6uoQkomcX9glvKoxULBO0i/c5mh
        KODN5kKnjpayEz//Vmfauw==
X-Google-Smtp-Source: AKy350YG5U9QNvXG9urYlKAKQZf2PCcV3KsTjbecvU+8kIfA5d1v5KG8LereLUse+pLSeMjkUuqZwQ==
X-Received: by 2002:a9d:6659:0:b0:6a3:c70d:bb94 with SMTP id q25-20020a9d6659000000b006a3c70dbb94mr5785020otm.17.1681220433511;
        Tue, 11 Apr 2023 06:40:33 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g25-20020a9d6c59000000b0069f95707335sm5338427otq.69.2023.04.11.06.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 06:40:33 -0700 (PDT)
Received: (nullmailer pid 2941891 invoked by uid 1000);
        Tue, 11 Apr 2023 13:40:31 -0000
Date:   Tue, 11 Apr 2023 08:40:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
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
        catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
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
Message-ID: <20230411134031.GA2934043-robh@kernel.org>
References: <20230203-evk-board-support-v5-0-1883c1b405ad@baylibre.com>
 <20230203-evk-board-support-v5-3-1883c1b405ad@baylibre.com>
 <CAFGrd9oi0AT3L8DVs7OYq-RjzBTqD+CB5mjKOwEbgNJDdyj2=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFGrd9oi0AT3L8DVs7OYq-RjzBTqD+CB5mjKOwEbgNJDdyj2=g@mail.gmail.com>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 03:11:18PM +0200, Alexandre Mergnat wrote:
> + To: Catalin Marinas <catalin.marinas@arm.com>
> + To: Will Deacon <will@kernel.org>

Why? They don't take bindings or dts files. Those go thru the subsystem 
(watchdog (for bindings) or Mediatek sub-arch tree.

Second, if they did pick this up, they likely need the original mail 
sent to them, not a reply.

Rob

> 
> Sorry for the noise.
> 
> Regards,
> Alexandre
> 
> Le ven. 7 avr. 2023 à 14:59, Alexandre Mergnat <amergnat@baylibre.com> a écrit :
> >
> > Add binding description for mediatek,mt8365-wdt
> >
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> > ---
> >  Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> > index 55b34461df1b..66cacea8e47f 100644
> > --- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> > +++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> > @@ -38,6 +38,7 @@ properties:
> >                - mediatek,mt7623-wdt
> >                - mediatek,mt7629-wdt
> >                - mediatek,mt8173-wdt
> > +              - mediatek,mt8365-wdt
> >                - mediatek,mt8516-wdt
> >            - const: mediatek,mt6589-wdt
> >
> >
> > --
> > 2.25.1
> >
