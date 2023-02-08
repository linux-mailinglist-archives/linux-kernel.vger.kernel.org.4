Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DED68F3D6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 17:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjBHQ5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 11:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjBHQ5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:57:50 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A5216328;
        Wed,  8 Feb 2023 08:57:46 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id h24so21423282qta.12;
        Wed, 08 Feb 2023 08:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p40yUwStxrTwrm1i0BG8hTSkPrclrhU7LySkzWtVeSQ=;
        b=pRbKeS+4nS4noT4Qu99I2I0Y52Clu2wQLmNDUbHqZt+nwUQgV5xIQ/5htCxIRuAbPc
         0ppGluqSaodYaZLq/vinXbhpO7vyWfD7CAdUgDxtonx79FW8uLZfaGwM14kFa9qvfpkT
         qxuXrCY+kW02CBSqFum24piX+jH8oRO6G+pOtS2rr8IzyQmU/nIQDxMqDzSWXLcz8mkK
         SMR0WSJe7PwY/sUPzUVxsQJVaN21QQbk2Cyqhtwx37DNGHMqPj2bwY3sTZSeWdF8961W
         EoWQcjZ+Dx6b9gifq+Wqvx+9emt2RSoIXlFcVt81BOI29L5wfYY3wWeW6FYzlluCCcPH
         iEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p40yUwStxrTwrm1i0BG8hTSkPrclrhU7LySkzWtVeSQ=;
        b=4FljvvgRPus9m0JA6XoB0Xapg877FUJZYJa5rZHTm+Sfye2sTSus2rRYUzqu6YcXu+
         ZwiGmoUSww/dn1CGT/ZD95HVuNnpEYEuwyeeUVJP+k26FhDSjOsvvNloaYCh65OhYFLv
         718cZp9LGhaJSfPpTFxG5193L/85Ndu9zsc9YUvSqeQAuyHQKx5pCsSR4BmSYZvNBroP
         M+rpVG+pKsacwZ5sHBdkmeR9vvA4A2wvzFvkF6JwzIBDUDffVjNOW/dIxMB8WFCNF5Sf
         /7njkkVxHmayzQh5g/fQ1HRSPqshKXlKVVPSmjst8MjVDDfL/BfCr45ABAgYjKRZl0cw
         CAow==
X-Gm-Message-State: AO0yUKVG/Kt4RC7vNrNS7hFnncrq37QrPQbZu01uR0HbrWQn4eLKnk1R
        jDBmgZDIIyWTsLdZGxfT1a8=
X-Google-Smtp-Source: AK7set93BFBKyDcDH4kf4S3mJ5vR93Pg00QiC2uzDqpaNy+0GwvHnWjHmj3pBOXax42P6YwEhDn4rg==
X-Received: by 2002:a05:622a:1008:b0:3b8:6cb0:8d28 with SMTP id d8-20020a05622a100800b003b86cb08d28mr11823600qte.6.1675875465964;
        Wed, 08 Feb 2023 08:57:45 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id x17-20020ac86b51000000b003a7eb5baf3csm11567488qts.69.2023.02.08.08.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 08:57:45 -0800 (PST)
Date:   Wed, 8 Feb 2023 11:57:43 -0500
From:   Trevor Woerner <twoerner@gmail.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] riscv: dts: nezha-d1: add gpio-line-names
Message-ID: <20230208165743.GA8848@localhost>
References: <20230208014504.18899-1-twoerner@gmail.com>
 <Y+PRGjn8a26pe5Dy@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y+PRGjn8a26pe5Dy@spud>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

Thank you for your review!

On Wed 2023-02-08 @ 04:43:06 PM, Conor Dooley wrote:
> On Tue, Feb 07, 2023 at 08:45:03PM -0500, Trevor Woerner wrote:
> > Add descriptive names so users can associate specific lines with their
> > respective pins on the 40-pin header according to the schematics found at:
> > 
> > 	http://dl.linux-sunxi.org/D1/D1_Nezha_development_board_schematic_diagram_20210224.pdf
> 
> Dunno about the sunxi folk, but ideally that'd be a Link: tag IMO.

Okay, np.

> > 
> > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > ---
> >  .../boot/dts/allwinner/sun20i-d1-nezha.dts    | 53 +++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> > 
> > diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts b/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts
> > index a0769185be97..33489c7619cb 100644
> > --- a/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts
> > +++ b/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts
> > @@ -90,6 +90,15 @@ pcf8574a: gpio@38 {
> >  		gpio-controller;
> >  		#gpio-cells = <2>;
> >  		#interrupt-cells = <2>;
> > +		gpio-line-names =
> > +			"pin13 [PP0,gpio8] ",
> > +			"pin16 [PP1,gpio10]",
> > +			"pin18 [PP2,gpio11]",
> > +			"pin26 [PP3,gpio17]",
> > +			"pin22 [PP4,gpio14]",
> > +			"pin28 [PP5,gpio19]",
> > +			"pin37 [PP6,gpio23]",
> > +			"pin11 [PP7,gpio6] ";
> 
> dtbs_check does not like this:
> arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dtb: gpio@38: 'gpio-line-names' does not match any of the regexes: '^(.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
>         From schema: Documentation/devicetree/bindings/gpio/nxp,pcf8575.yaml
> 
> >  	};
> >  };

Okay, I'll look for other examples of giving names to io-expanders to see
what's needed to keep dtc happy.

> >  
> > @@ -164,3 +173,47 @@ &usbphy {
> >  	usb1_vbus-supply = <&reg_vcc>;
> >  	status = "okay";
> >  };
> > +
> > +&pio {
> > +	gpio-line-names =
> > +		/* Port A */
> > +		"", "", "", "", "", "", "", "",
> > +		"", "", "", "", "", "", "", "",
> > +		"", "", "", "", "", "", "", "",
> > +		"", "", "", "", "", "", "", "",
> > +		/* Port B */
> > +		"pin5  [PB0, gpio2/twi2-sck]",
> > +		"pin3  [PB1, gpio1/twi2-sda]",
> > +		"",
> > +		"pin38 [PB3, gpio24/i2s2-din]",
> > +		"pin40 [PB4, gpio25/i2s2-dout]",
> > +		"pin12 [PB5, gpio7/i2s-clk]",
> > +		"pin35 [PB6, gpio22/i2s2-lrck]",
> > +		"",
> > +		"pin8  [PB8, gpio4/uart0-txd]",
> > +		"pin10 [PB9, gpio5/uart0-rxd]",
> > +		"",
> > +		"",
> > +		"pin15 [PB12,gpio9]",
> 
> Why not pick a consistent styling w.r.t. the space between PB#, & gpio?

I thought it looked better when doing:

	nezha-allwinner-d1:~# gpioinfo
	gpiochip0 - 224 lines:
		...
		line  32: "pin5  [PB0, gpio2/twi2-sck]" kernel input active-high [used]
		line  33: "pin3  [PB1, gpio1/twi2-sda]" kernel input active-high [used]
		line  34:      unnamed  "interrupt"   input  active-high [used]
		line  35: "pin38 [PB3, gpio24/i2s2-din]" unused input active-high
		line  36: "pin40 [PB4, gpio25/i2s2-dout]" unused input active-high
		line  37: "pin12 [PB5, gpio7/i2s-clk]" unused input active-high
		line  38: "pin35 [PB6, gpio22/i2s2-lrck]" unused input active-high
		line  39:      unnamed       unused   input  active-high
		line  40: "pin8  [PB8, gpio4/uart0-txd]" kernel input active-high [used]
		line  41: "pin10 [PB9, gpio5/uart0-rxd]" kernel input active-high [used]
		...

I guess "better" is subjective :-)

I'll do a v2, thanks!
