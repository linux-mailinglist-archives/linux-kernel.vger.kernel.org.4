Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281D6727965
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbjFHIAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbjFHH7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:59:51 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F8A2733
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 00:59:26 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-6261d4ea5f0so2456276d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 00:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686211165; x=1688803165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZI03Cx2EY1sdWTSmlFdME9tStwh4n+KWL1+nYy0WC8=;
        b=u2lkZs0DGHOkdhYckKh0vEmvah3mtcUdCmEiM9iXyPblop5XpmI9V2CgRiqW0jtbGV
         reK5FwiItuCG6+d63dQrJiv1YAltYFcixhf3BClc1sq7/GkfKOxDGLziQ9p32emOQ5wp
         vFd0z7XXebB2KBeLEa3YGfFTTJ15GBqRq7Cyc31lqh6GZCWsSIfJFfyzloc4gHGYkWBy
         ww/YKeXgj5vQENHB73hyBy5MFfEUMWxx+Slw4MSxv1++d/Jj4RlLPaCSKAbQgJmQOM+R
         Pbj8aiB+yf4XOMIFOX9SC45h3BsmfRlDyvKSXoQ0Aa2y8giPk41G4iZYJ+UUC3RX+mZQ
         7gzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686211165; x=1688803165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZI03Cx2EY1sdWTSmlFdME9tStwh4n+KWL1+nYy0WC8=;
        b=LSx8fJFOvStvKR9lQKP802r6fuy1IdXn2ppp0YhwzUL6ZEAe3nO/I9cnxAy5NxSaYE
         lO7CXSSo+kvLS++kcJSZS3UzENI6MqD7bn9cYwSPn+Sbw5QY/8pCKHxI9FB6OJmfd5O/
         5JeHW0Neozhi3XdrZdi0kNEaqgOl6ZJQtTWkXjvjgWW1xvJ5300C5IsqxTGbx79Dz0eK
         34kt0G3TcYnr8q9P+vsbkg5l5mZ+K07HKvhgOIAT3R682ZjHbTf/+mGwp0sSAO40CZIA
         8DWIBIVy4yJEefzD/IOQGMaB1UEgucHLfdJhC6sXEY9+3KRoNfBCLKnlSdP/jPKLHJwj
         prPQ==
X-Gm-Message-State: AC+VfDxF/67YX825sZF1cnwQS49b1USvYmueR/1idKDkqxuJMfSoCgLe
        NGdqmMhRjwTFplT5hBvIG471xSMQGWo3CzMQ3TcWtw==
X-Google-Smtp-Source: ACHHUZ5d+KjHBE3nn6IbQfTfPODDpmdVKrp2o+VWenaYC3pqaAqWhAb1Zwc6F2zu1aZB2hIhws1GsEELHYPrhnaMvp0=
X-Received: by 2002:ac8:58c1:0:b0:3f9:aa9f:84f5 with SMTP id
 u1-20020ac858c1000000b003f9aa9f84f5mr6032848qta.65.1686211165115; Thu, 08 Jun
 2023 00:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230608025424.29033-1-rdunlap@infradead.org>
In-Reply-To: <20230608025424.29033-1-rdunlap@infradead.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 8 Jun 2023 09:59:14 +0200
Message-ID: <CAMRc=Me1U_SznMfsVzYxoD7De1iBJjHzzTtNhvVi=pd+ekKGxQ@mail.gmail.com>
Subject: Re: [PATCH] eeprom: at24: also select REGMAP
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-i2c@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 8, 2023 at 4:54=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
>
> Selecting only REGMAP_I2C can leave REGMAP unset, causing build errors,
> so also select REGMAP to prevent the build errors.
>
> ../drivers/misc/eeprom/at24.c:540:42: warning: 'struct regmap_config' dec=
lared inside parameter list will not be visible outside of this definition =
or declaration
>   540 |                                   struct regmap_config *regmap_co=
nfig)
> ../drivers/misc/eeprom/at24.c: In function 'at24_make_dummy_client':
> ../drivers/misc/eeprom/at24.c:552:18: error: implicit declaration of func=
tion 'devm_regmap_init_i2c' [-Werror=3Dimplicit-function-declaration]
>   552 |         regmap =3D devm_regmap_init_i2c(dummy_client, regmap_conf=
ig);
> ../drivers/misc/eeprom/at24.c:552:16: warning: assignment to 'struct regm=
ap *' from 'int' makes pointer from integer without a cast [-Wint-conversio=
n]
>   552 |         regmap =3D devm_regmap_init_i2c(dummy_client, regmap_conf=
ig);
> ../drivers/misc/eeprom/at24.c: In function 'at24_probe':
> ../drivers/misc/eeprom/at24.c:586:16: error: variable 'regmap_config' has=
 initializer but incomplete type
>   586 |         struct regmap_config regmap_config =3D { };
> ../drivers/misc/eeprom/at24.c:586:30: error: storage size of 'regmap_conf=
ig' isn't known
>   586 |         struct regmap_config regmap_config =3D { };
> ../drivers/misc/eeprom/at24.c:586:30: warning: unused variable 'regmap_co=
nfig' [-Wunused-variable]
>
> Fixes: 5c015258478e ("eeprom: at24: add basic regmap_i2c support")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: linux-i2c@vger.kernel.org
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> ---
>  drivers/misc/eeprom/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>
> diff -- a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
> --- a/drivers/misc/eeprom/Kconfig
> +++ b/drivers/misc/eeprom/Kconfig
> @@ -6,6 +6,7 @@ config EEPROM_AT24
>         depends on I2C && SYSFS
>         select NVMEM
>         select NVMEM_SYSFS
> +       select REGMAP
>         select REGMAP_I2C
>         help
>           Enable this driver to get read/write support to most I2C EEPROM=
s

Applied, thanks!

Bart
