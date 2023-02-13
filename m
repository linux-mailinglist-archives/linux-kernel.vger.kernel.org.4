Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E0D69444D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjBMLUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjBMLUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:20:35 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55362C160;
        Mon, 13 Feb 2023 03:20:34 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id r9-20020a17090a2e8900b00233ba727724so5426193pjd.1;
        Mon, 13 Feb 2023 03:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yhUwkGMbfcta0BgiSZrgFVKdvG85/JtJXXzQxSbA5YQ=;
        b=B6fPkWSEu9uiErCCsKFH4Qb+CG8wznVqNXHcGOl+/oxHKNpZxDDNCC8ApRe23IPnjQ
         YMiBYq8TMAIekQvSZ0iSkLAYRKr7uyTWQ62H0oUBB4+n9qzlDYR8JZFp+s9s69UTOiy/
         GZA4Y+9rDimUIXiDbwSybiOMt5Pg77f6mwfObFAzGvN5QZ8MJmGKr3WU7oyGrxGI3V1l
         evuq8IkzHWirRrvEqMefvSxk99GF5D7lncdSBEZY5SNokXebCfSzMomc4MX9NUIrtSOA
         f22sApfftWaxt8ODCbSbWRslv4Dyd9ibnkXkvr5hFEL/mXDEXR4KJcFazUxy50m5o65v
         3ioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhUwkGMbfcta0BgiSZrgFVKdvG85/JtJXXzQxSbA5YQ=;
        b=WJM5Qq4HzizyCtKGsyVzrdlG6/iCQaBO7NcJPv5ajwUb9Gv5tO9CBNUVaEYGP0tMEW
         bWxRUmQLoCvnxx3+X+KZ/2Zpy63vqa7LngU0nEkjJuZ7p3I2INfezG0T0B9/MGF28JWv
         ZaqPckx8T1eGWSVQkMQCY8BbvbNZnHQAUGmsqXTFSMEdeLy4LHjObf1bD9Y3ttCbpV4L
         dBy4PE9RU4G8OKAL06gPiX7Tn5u76dBeO4DfS+d0x9Dv+YHKDH8ZlfeMO34zd9+rGIbN
         BO/taGYLRB3Vmq4E3se8yhNZm60ofgUCv7kSfOvILfsaFLQZMLtXnKO2BQ6W1K8vzTMz
         K1xg==
X-Gm-Message-State: AO0yUKUkXSLwSB7gEAeY7twWxiZuG9ESixmRh9fdr55cX9pyQR9Jwjsu
        OL9IrSG/Lxilo82ruAiFZCs=
X-Google-Smtp-Source: AK7set+uAhLU/ISmNgXiCtRLzy+Ssc5QgA2lwcvZbThMYhB+3YMWL1TTaVsO0Mt6Wu/EUPH1xlvPQg==
X-Received: by 2002:a17:90a:195a:b0:231:284:ea4d with SMTP id 26-20020a17090a195a00b002310284ea4dmr21468329pjh.22.1676287233846;
        Mon, 13 Feb 2023 03:20:33 -0800 (PST)
Received: from Gentoo (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090a3f8b00b002312586b5b1sm7702406pjc.57.2023.02.13.03.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 03:20:33 -0800 (PST)
Date:   Mon, 13 Feb 2023 19:20:26 +0800
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: Add Novatek NT36523
 bindings
Message-ID: <Y+oc+kEDoiMsebWF@Gentoo>
References: <20230210161925.32343-1-lujianhua000@gmail.com>
 <6cffa875-d8cc-a4fe-e18d-2e24c28a49d8@linaro.org>
 <Y+oZOXyE8/a+vreS@Gentoo>
 <ad5dd369-842f-7301-e57d-d0445f0a5268@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad5dd369-842f-7301-e57d-d0445f0a5268@linaro.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 12:08:27PM +0100, Krzysztof Kozlowski wrote:
> On 13/02/2023 12:04, Jianhua Lu wrote:
> > On Mon, Feb 13, 2023 at 11:45:23AM +0100, Krzysztof Kozlowski wrote:
> >> On 10/02/2023 17:19, Jianhua Lu wrote:
> >>> Novatek NT36523 is a display driver IC that can drive DSI panel. It
> >>> is also present in the csot and boe video mode panels. It is found
> >>> in Xiaomi Mi Pad 5 series.
> >>>
> >>> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> >>> ---
> >>>  .../display/panel/novatek,nt36523.yaml        | 101 ++++++++++++++++++
> >>>  1 file changed, 101 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
> >>> new file mode 100644
> >>> index 000000000000..a7098d0ce7e1
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
> >>> @@ -0,0 +1,101 @@
> >>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/display/panel/novatek,nt36523.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: Novatek NT36523 based DSI display Panels
> >>> +
> >>> +maintainers:
> >>> +  - Jianhua Lu <lujianhua000@gmail.com>
> >>> +
> >>> +description: |
> >>> +  The nt36523 IC from Novatek is a generic DSI Panel IC used to drive dsi
> >>> +  panels.
> >>> +  Right now, only support cost and boe LCD display panels with the
> >>
> >> boe? both?
> > Boe Technology Group Co., Ltd
> 
> Then what is "cost"? If both are names, then they start with capital
> letters or how the company officially spells itself.
both are company name, I will search offical name for it.
> 
> >>
> >>> +  resolution of 1600x2560. It is a video mode DSI panel.
> >>
> >> The binding or hardware supports only 1600x2560? The how it can be
> >> "right now"? It's defined, isn't it?
> > Yes
> 
> What yes? How it can be "right now"? It implies it will change, so how
> hardware can change?
sorry, my wrong. This binding only support 1600x2560.
> 
> 
> Best regards,
> Krzysztof
> 
