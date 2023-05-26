Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088D8712470
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 12:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242723AbjEZKUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 06:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjEZKUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 06:20:38 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7041DF
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 03:20:36 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f6d7abe9a4so4051855e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 03:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685096435; x=1687688435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K3s8ooFUr7HL+mpTddtdIbpP60KFH9AqWFjPieFL2f0=;
        b=p544sBJGWXY4zsoCH8La6KGT/b7IZ3KC4/Cb2RBc6TTAQ079uZ0TwZKZIDE9bY9mdN
         jSyDQeGQHabEWxnqNhx+63wreMSikab92tS6SWP0/5800mboefbLbjXRsQMYDiedr1WA
         KIEhNxV63VtqbDewUfiGREsbFWZZsTzTxdWXp6ufmAiqrfiH5WGmBkgpMk2SHJtBRcRp
         EmlqjNdxsElkCSvP/mwKx7jx83BCMzCjjf+Ufqv4D47faVqctT4cyWTwNlRZ6P9XLUaO
         1vePDY7gGucj3mMbS8Jv1+7zmqhSzuCEVMaa5xmHv/zb8F/ivWyzy8DSK/Giu8OVFr8o
         SHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685096435; x=1687688435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3s8ooFUr7HL+mpTddtdIbpP60KFH9AqWFjPieFL2f0=;
        b=eqFlLSxXRId0Fx6BQbysavUPQ+BCpUh7UU4n2JgxBvbsxjFibriBxBhcRLRe8soI+4
         /wngREkdzj+XPdnqKxFWYl5dkkpEuYnD5E7ujLRxIWoQazNxToEeeMuS9YQvdmeMsxAu
         g6KJzJ7ee5HbVNPll39/kWcK9qXnom09+C19drAqTvdnJ2Fr6efkL4nbK0myFn0LUG/+
         6XQIpw2j3K3kZN/a2glXFsLaoyos1IWFevrR0giDZ6bLexlGF9DVnkGd3FQoVhI5fg4w
         RrjP4VVFwaCoehNKZYN0XMl1a2LXkI5depN3vP8eRtujZUAxpFYMXD+rVsZtN567loYq
         pb/w==
X-Gm-Message-State: AC+VfDwtKVogOGgNsRK9ZQjZ0Uw/YM9OduLEY6AtlZ6UPvaQSiYNE0Yv
        Z6Qw+UHRb0PZtcEWI9iodTqcfg==
X-Google-Smtp-Source: ACHHUZ6Yy3l1CCvu264LHxVdtKGZKPPjZRT/yx0dNniT9+GDgWRelslel+8Hr4u3Yzz8fMPt5HybXQ==
X-Received: by 2002:a5d:5402:0:b0:30a:b030:9cdd with SMTP id g2-20020a5d5402000000b0030ab0309cddmr956532wrv.25.1685096435053;
        Fri, 26 May 2023 03:20:35 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id a15-20020a5d508f000000b002ceacff44c7sm4535860wrt.83.2023.05.26.03.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 03:20:34 -0700 (PDT)
Date:   Fri, 26 May 2023 11:20:32 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Alexandru Ardelean <alex@shruggie.ro>
Cc:     dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org, lee@kernel.org, jingoohan1@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        deller@gmx.de, Yannick Fertre <yannick.fertre@foss.st.com>,
        Philippe CORNU <philippe.cornu@foss.st.com>
Subject: Re: [PATCH 2/2] dt-bindings: backlight: document new property
 default-brightness-level
Message-ID: <20230526102032.GB626291@aspen.lan>
References: <20230519200520.10657-1-alex@shruggie.ro>
 <20230519200520.10657-2-alex@shruggie.ro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519200520.10657-2-alex@shruggie.ro>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 11:05:20PM +0300, Alexandru Ardelean wrote:
> From: Yannick Fertre <yannick.fertre@foss.st.com>
>
> Add documentation for new default-brightness-level property.
>
> Reviewed-by: Philippe CORNU <philippe.cornu@foss.st.com>
> Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
> Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
> ---
>
> Link to original patch:
>   https://github.com/STMicroelectronics/linux/commit/c4067d7bd883c6fa14ffd49892c4ce663cdafe98
>
>  .../bindings/leds/backlight/gpio-backlight.yaml          | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
> index 584030b6b0b9..b96c08cff0f0 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
> +++ b/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
> @@ -23,6 +23,15 @@ properties:
>      description: enable the backlight at boot.
>      type: boolean
>
> +  default-brightness-level:
> +    description:
> +      The default brightness level (index into the array defined by the
> +      "brightness-levels" property).

gpio-backlight does not have a brightness-levels array property!

I think it is also necessary to improve the docs of both properties to
distinguish between the meaning of default-on and
default-brightness-level. The result of setting default-on and
default-brightness level to zero is that the GPIO will be off (this is
correct behaviour but hard to figure out from the current text).

default-on is a control that can "enable" the backlight at boot when it
is not linked to a display in the DT (e.g. it is mostly for legacy
cases). When the backlight is linked to a display then the backlight
enable state will be automatically linked to the display enable state
instead.

default-brightness-level is useful for handling displays that
are still readable with the backlight off (e-ink, reflective/
transflexive LCD, etc), otherwise is should be absent or set to 1.


> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +dependencies:
> +  default-brightness-level: [ "brightness-levels" ]

As above, depending on brightness-levels doesn't make any sense here.


Daniel.
