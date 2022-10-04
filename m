Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C05F5F43C6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 14:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiJDM7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 08:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiJDM5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 08:57:49 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3CEB865
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 05:54:57 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id c11so21189485wrp.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 05:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PkPNtuib5iRHSYoXuvCITszxB1jeo5nPeYiHHZL01UU=;
        b=aKbbnZoDBY06Fjy3RSKQhfzAXP/Fpd7Z0NocPlMkBTEjqE9KysXAj0smHAg6k5bZ52
         G3kcQkx0Y+fM9LPYRSAHWxnErO5LuGtgSVK5VU7qtIpqFjFr8isprkSzhfCKvlZNg5Uc
         bblamli2YxIlhbGYCKmlXDAzxtU1rW+o67ONYWDWlTadw7ufy/9sA5vbxKE5/l3KtwTE
         z2gYoyV1NmPHkKI13GaBFPLMSiD5exh43C6GJXFeIVNiDI/a1bE/3dHN4HF/N3uh3LPY
         CplV3F1T6nmpxOHlfxlj29KE5vlrZJQcjHRWqW7O8bdocUUXeHQeZbuxNPrGVVl6tSYg
         r5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkPNtuib5iRHSYoXuvCITszxB1jeo5nPeYiHHZL01UU=;
        b=HwQ8yyH47N6loqNc08vkuq2XV+l0WB631AqcqptjIjQmEDEDNsuTgPOz54CRz+GmCQ
         ZK1OYFwvDKgZ+1tq14k4CEA0+QtWUA41bDQKCfpq17Ilie7YaFdDh9c4Hh14JbYZukcd
         Ki+teNKEywL/LsTRPXc7ey4jU9kuyIgMo24C6oySbQ3X1nbZ6z05/R+eY1R43kYUul3D
         QUgWCEOHT+shqS4AKOr96LU3+l/ZwpnfIPkjf5F7Y0jaJqSwnwegHtZ1YSTBZkHc5/O3
         2PkkeWZxTPTgDYlusIolCZPKMElQtb7oLg/PMQi/V2NR007ofTjrhK5bLC4+JxWjqJSn
         pNjg==
X-Gm-Message-State: ACrzQf0z/c9fHNAJoUoupZetwp8CcF6rIpiGp72QurBatSmEjX9M37P+
        M5oIlBk/xUM0lozc9rs8DaX+nQ==
X-Google-Smtp-Source: AMsMyM6zkuocVUmsW5crCUEXtpbvBS7DDgsVlES5Am7dCaMtOQ/Tak12eHP2HL2OCi1vm5tQZq3p3Q==
X-Received: by 2002:a5d:588f:0:b0:22b:5cc:e1d3 with SMTP id n15-20020a5d588f000000b0022b05cce1d3mr15148579wrf.142.1664888095272;
        Tue, 04 Oct 2022 05:54:55 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id w10-20020a05600c474a00b003b4ac05a8a4sm25305803wmo.27.2022.10.04.05.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 05:54:54 -0700 (PDT)
Date:   Tue, 4 Oct 2022 13:54:51 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [RFC/PATCH] backlight: hx8357: prepare to conversion to gpiod API
Message-ID: <YzwtG8CT9sTCqQQk@maple.lan>
References: <YzN6A9Y20Ea1LdEz@google.com>
 <CACRpkdZF9TVA3+3pgjqm_cnhfPO6p0oOT=2jrqFafMCHe2cwDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZF9TVA3+3pgjqm_cnhfPO6p0oOT=2jrqFafMCHe2cwDg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 11:02:06AM +0200, Linus Walleij wrote:
> On Wed, Sep 28, 2022 at 12:32 AM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>
> > Properties describing GPIOs should be named as "<property>-gpios" or
> > "<property>-gpio", and that is what gpiod API expects, however the
> > driver uses non-standard "gpios-reset" name. Let's adjust this, and also
> > note that the reset line is active low as that is also important to
> > gpiod API.
> >
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> I think the gods of Open Firmware will try to punish you for such
> incompatible changes. But I have long since renounced them.
>
> > Another option is to add another quirk into gpiolib-of.c, but we
> > may end up with a ton of them once we convert everything away from
> > of_get_named_gpio() to gpiod API, so I'd prefer not doing that.
>
> We need to know if i.MX is shipping device trees stored in flash,
> or if they bundle it with the kernel.

This part is frequently found in add-on boards so it's not purely an
i.MX-only question.


> In the former case, you have to add quirks, in the latter case this
> patch is fine.
>
> Sascha, what does the Freescale maintainer say?

IMHO for not-in-the-soc devices like this the presence of in-kernel DTs
isn't enough to make a decision. What is needed is a degree of
due-diligence to show that there are no obvious out-of-kernel users.

To be honest, I suspect the due-diligence checks will probably yield a
green light for this one. Most of the tutorials for the popular HX8357
devices, show how to run python code in userspace that sends raw SPI
commands. That sucks but at least it doesn't raise any concerns about
bindings maintenance.


Daniel.
