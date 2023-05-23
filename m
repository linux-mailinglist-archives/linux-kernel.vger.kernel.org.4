Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B7070D8EC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236052AbjEWJ0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjEWJ0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:26:35 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32510102
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:26:30 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-96fb1642b09so440501866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684833988; x=1687425988;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8F5s7KNQ8pR0l7gVQkr0wi0q05FJrKQ/4O2Ot0cPFmo=;
        b=bkb1ITlRNG6DYkPUwBGpIQCQlJBS64KcKl7OcxEhlDKQU0+X8WKtxMNEKF8ddlVep1
         Qn2Oq4taRlVPpzuJdBdHwMyzXmwG3l6U2ljLciexshvbqv0B9cY0AikK3nB/kwJLqUfV
         KiVLxulUyVSEkjIkH9Dx4xj4CnFOnmPhFXgQzVuw44mKiPF9J5/i3GxdKYRmvZdlSxxg
         ubDmVn4dyaSsOs/jgmurwsjM0/lnsCf+376OhsQCiXvDkykEyyvhGnGAS3tXpgZyNqzC
         noCdtscq3Ni3JGtEBesgwDqyuA+my0a3gtZqWpuKQsSVqIcTm5yN1pZIUcMfdAYEtg+t
         h29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684833988; x=1687425988;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8F5s7KNQ8pR0l7gVQkr0wi0q05FJrKQ/4O2Ot0cPFmo=;
        b=PfWfv63eA79kpjsbTG2ksUwEo1Jj5WEYJ1VJwP1xI9YxQVaG2+iptKyDvGnobXau2r
         wnGNTF/Io+J1Bd6E8YGyJHmP7pccPc5ZhhDp/cRG5hVI0kBDWimxnYRmFE87Hu5YMUYa
         4sNw8XD+/JdO2KU5kkb1rXW929Xl5Cy63edzPZBA5mAYygatxSTnRGLCGbr99eiPcDrG
         rBLc7M1S0U8WGijk7O21lkhC1jT0xx5VWmV95F6s63c2xtvaX2+lUaGbw+WYT2z39Hw6
         wQugnzcw5fxpqkQkOxVPV7oFWKgJ1YU3mj6VbphlklIewlQ0jhjLDltffWggUBI1hq0Z
         PaUw==
X-Gm-Message-State: AC+VfDzDI7KAZy6/5sEvhe4G3HwXVrmHmI9XOc6ec8XyY2ESNJggOFMc
        TW6arMz6+tw3yHQMf//lhGHVr/OfqtRETipZZljOeg==
X-Google-Smtp-Source: ACHHUZ7QRnooOds/zXLfgK+9lidBQnpV71o40aikCyZ11/YFivdpecTnbUZ5s8ET0k2VWK+tmhcJGQ==
X-Received: by 2002:a17:906:fd8e:b0:96a:f688:db6e with SMTP id xa14-20020a170906fd8e00b0096af688db6emr11577426ejb.74.1684833988681;
        Tue, 23 May 2023 02:26:28 -0700 (PDT)
Received: from localhost (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id x8-20020a1709064a8800b00965f5d778e3sm4194556eju.120.2023.05.23.02.26.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 02:26:28 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 23 May 2023 11:26:26 +0200
Message-Id: <CSTJSWD0ZQGE.2XVJAULQKQTRM@burritosblues>
Subject: Re: [PATCH v4 2/3] pinctrl: tps6594: Add driver for TPS6594 pinctrl
 and GPIOs
From:   "Esteban Blanc" <eblanc@baylibre.com>
To:     "Andy Shevchenko" <andy.shevchenko@gmail.com>
Cc:     <linus.walleij@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <jpanis@baylibre.com>, <jneanne@baylibre.com>,
        <aseketeli@baylibre.com>, <sterzik@ti.com>, <u-kumar1@ti.com>
X-Mailer: aerc 0.14.0
References: <20230512141755.1712358-1-eblanc@baylibre.com>
 <20230512141755.1712358-3-eblanc@baylibre.com>
 <ZF5yb4DbVDbfxVU4@surfacebook> <CSNQ2RRG7XDC.164H6P357UHSR@burritosblues>
 <CAHp75VdNgBv5yVTXzDpY3rrF31p=p99cfXdEs0q7m8VmLLJwbg@mail.gmail.com>
 <CSOGQIRNP61G.1Q2A4ZXB43YYQ@burritosblues>
 <CAHp75Vc-c=VU5Bfy5097z4wm43=bZ4LG83QBYV19YOrC7zSGag@mail.gmail.com>
 <CSOMS0W9MIUG.2MN43QZO9EX7Q@burritosblues>
 <CAHp75VeNvfDqkQZq_ghiv8vb2NaogKqkiFi9i0N3yLgA=ZTDbA@mail.gmail.com>
In-Reply-To: <CAHp75VeNvfDqkQZq_ghiv8vb2NaogKqkiFi9i0N3yLgA=ZTDbA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed May 17, 2023 at 5:04 PM CEST, Andy Shevchenko wrote:
> On Wed, May 17, 2023 at 5:43=E2=80=AFPM Esteban Blanc <eblanc@baylibre.co=
m> wrote:
> > On Wed May 17, 2023 at 3:51 PM CEST, Andy Shevchenko wrote:
> > > On Wed, May 17, 2023 at 12:58=E2=80=AFPM Esteban Blanc <eblanc@baylib=
re.com> wrote:
> > > > On Tue May 16, 2023 at 6:48 PM CEST, Andy Shevchenko wrote:
> > > > > On Tue, May 16, 2023 at 4:05=E2=80=AFPM Esteban Blanc <eblanc@bay=
libre.com> wrote:
> > > > > > On Fri May 12, 2023 at 7:07 PM CEST,  wrote:
> > > > > > > Fri, May 12, 2023 at 04:17:54PM +0200, Esteban Blanc kirjoitt=
i:
>
> ...
>
> > > > > > > > -#define TPS6594_REG_GPIOX_CONF(gpio_inst)          (0x31 +=
 (gpio_inst))
> > > > > > > > +#define TPS6594_REG_GPIO1_CONF                            =
 0x31
> > > > > > > > +#define TPS6594_REG_GPIOX_CONF(gpio_inst)  (TPS6594_REG_GP=
IO1_CONF + (gpio_inst))
> > > > > > >
> > > > > > > Why? The original code with parameter 0 will issue the same.
> > > > > >
> > > > > > I felt that replacing 0x31 with a constant would make the compu=
tation
> > > > > > in TPS6594_REG_GPIOX_CONFIG more understandable. What do you th=
ink?
> > > > >
> > > > > The question is why that register is so special that you need to =
have
> > > > > it as a constant explicitly?
> > > >
> > > > It is not special, it's just the first one of the serie of config
> > > > registers. I felt like just having 0x31 without context was a bit w=
eird
> > >
> > > I'm not sure I understand what 'context' you are talking about.
> > I was trying to convey the fact that 0x31 was representing
> > TPS6594_REG_GPIO1_CONF address. This way when looking at
> > TPS6594_REG_GPIOX_CONF(...), one will better understand that this macro
> > is just about offsetting from the first GPIO_CONF register.
>
> You can add a comment on top of the macro, so anybody can read and see
> what this macro is doing.

> > > This is pretty normal to have two kind of definitions (depending on t=
he case):
> > > 1/
> > >
> > >   #define FOO_1 ...
> > >   #define FOO_2 ...
> > >
> > > and so on
> > >
> > > 2/
> > >
> > >   #define FOO(x)  (... (x) ...)
> > >
> > > Having a mix of them seems quite unusual.
> > I did not know that. I will revert this change for next version then.
>
> Don't get me wrong, it's possible to have, but since it's unusual it
> needs to be well justified. In the change you proposed you have
> changed that, but I haven't seen where the new definition is used  (in
> *.c files).

Actualy it used in 2 places:
- In the switch case of `tps6594_gpio_regmap_xlate`
- In `tps6594_pinctrl_probe` when setting `reg_dir_out_base`

I already sent a v5 with this change but I managed to fail my .config
and this driver was not compiled... and it is not compiling... I feel so
stupid.

I need to send a v6 now anyway. Should I convert all
TPS6594_REG_GPIO1_CONF to TPS6594_REG_GPIOX_CONF(0)?

