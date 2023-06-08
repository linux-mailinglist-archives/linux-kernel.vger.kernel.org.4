Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F36727CB2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbjFHKXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235934AbjFHKXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:23:20 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34691FE9;
        Thu,  8 Jun 2023 03:23:18 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3f805551a19so2983371cf.3;
        Thu, 08 Jun 2023 03:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686219798; x=1688811798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTGc9+CSoeOkMBrTWKiVuewpGFLPDLPpalEIUi+52BA=;
        b=kMHuP+l6AXKx3KQnUOjWbYWoygOj0EqlCR/SK6JXYS+kMBFEU6Rc0eujR7UkxtqWiS
         PFNuVRkOld8O9nw/mj5VeVXmSX0JxgBmHGPhsUBVcyFvSickkEiNBG8j1LhYi5TD+cYd
         I5+N+MIwfLY7HVC98OSVb1lPZSFebqzyfkpj1onClKIC5dyTV8QvMi90Czq8CiUSKsi1
         MG5xq0NPfANPTYKkHgFgqYrKwDAlkoqMTWp15YW84I3d/H5i/0U1/aKkvMN9z+IgVz+p
         L373YuR0Obd7S9i57laQRaPTyYVPvSjBLsZfwxco9/RvhgjeIVqugHwba9mm8xFVft+h
         NeYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686219798; x=1688811798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kTGc9+CSoeOkMBrTWKiVuewpGFLPDLPpalEIUi+52BA=;
        b=BHpe/r0S46w/kFpx62JLs/UI2piH0qyDlPwtKBo0WW610XTztEZqZuKXWQW/fhiJsH
         srugB8K1ebQpazABhrR6G5lrB3d8ybNfUJu7ZZsuThEVBd+ZcvxaVGU6ZBDijF+5PBtx
         9KKA3JmYmsNGJdZa8JPNng/hUiM+u+QhvxgQobXIaexXRsjt0RyA0XQlms5Vc0zzxy+k
         z4TcQBJbhwWRF90jd0yUMLgwV3cdpDpcmoS9Sm8vzx7NUwEK31h/v1wqmPUYHTqroZRE
         104k343EZz6q5Wt7RUbC4GbgQ3Ntx8b6sZ/WudJhbl2skU0KkaOGQUTAnwxIcNODEDRb
         2Sgg==
X-Gm-Message-State: AC+VfDynQQbVNUdbLEoVDjxY81cG0TxvM3oRb2oo8NRb6i4DAix+NwN2
        apWVZN+XzDparXT3HUBctnOCSpiMJlJM4q08lHU=
X-Google-Smtp-Source: ACHHUZ6z0z1c6MZ/b7vwZN5NjCnABNDqKYUfgcFRXC3Draq6zwT1osRCCxn9GS7FNS/Wdk25um1UK7eE6Ytu4bxgJq4=
X-Received: by 2002:ac8:5a11:0:b0:3f6:e3aa:a61f with SMTP id
 n17-20020ac85a11000000b003f6e3aaa61fmr6798441qta.19.1686219797956; Thu, 08
 Jun 2023 03:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230606014234.29491-1-nick.hawkins@hpe.com> <20230606014234.29491-3-nick.hawkins@hpe.com>
 <ZH76x6E9cbfrJHeu@surfacebook> <DM4PR84MB19278E9DD0BF34C570F714708852A@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
 <CAHp75Vcc9hh6MYPSCJa1vniU=rC4Y+j9pCS4Np-b-Pyh5eUwNg@mail.gmail.com>
 <81CFCEE8-5276-475A-A2AB-A814DEDA04B2@hpe.com> <CAHp75VeZkLSTw8OFmDMYb+im0qK0NQRHpndzBM7fMHm=HZCzeA@mail.gmail.com>
 <7FEECBB4-482E-4719-94CA-6D10E4C08078@hpe.com>
In-Reply-To: <7FEECBB4-482E-4719-94CA-6D10E4C08078@hpe.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 8 Jun 2023 13:22:42 +0300
Message-ID: <CAHp75VfQguYENE0EtZ-ou=CXo0mAmeDT9byTu6hffT6w_cgM=Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] gpio: gxp: Add HPE GXP GPIO
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 11:45=E2=80=AFPM Hawkins, Nick <nick.hawkins@hpe.com=
> wrote:
>
> > It does care about things the average GPIO controller driver needs to
> > repeat. So at least you may try and see how it will look.

...

> Is there any documents available describing how regmap_gpio
> populates the GPIO lines? Does it automatically go through and add lines
> for each successful regmap_read and bits per byte?

Nope, it assumes one bit per register or something different if xlate
callback is defined. This is my understanding. That said, it might be
that this is a limitation which does not allow you to switch to that
library.

...

> static const struct regmap_config gxp_int_regmap_config =3D {
>         .reg_bits =3D 8,

>         .reg_stride =3D 1,

AFAIU 0 is the same as 1, so this can be dropped.

>         .val_bits =3D 8,
>         .readable_reg =3D gxp_read_write_int_register,
>         .writeable_reg =3D gxp_read_write_int_register,
>         .max_register =3D 0x7f
>         .name =3D "gxp-gpio-pl-int"
> };

--=20
With Best Regards,
Andy Shevchenko
