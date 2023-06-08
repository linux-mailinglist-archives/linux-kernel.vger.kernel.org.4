Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C274B72872F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 20:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236302AbjFHS3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 14:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjFHS3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 14:29:02 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA113210D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 11:28:59 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f58444a410so4044e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 11:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686248938; x=1688840938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sg+jgrZ1/pLYVdsF6FD4BAEjAYjHjHaxTOxuDk/I6Ec=;
        b=4biWtRHkowG2GbJ8n7X9/jAFWlnPTiFVaZ7xDisBbs929xXDgQji4IMHip6od5+JhG
         ZVtRQiXBI8mzPKVfyuNXMWeL9aLVubgxyg55hg6lqM8t0t4gSC4HoXG5JhdrASp8PeCY
         jp3zY/xTm4kZq/Aaa/AbIIap3nGV7vzIGWgLv8HGu8Mo2HVm7l3mCGpV8gi0op0OFl2U
         hNDqxCBH5Cn2GSdKtMnGVprzB3BnEDAgEfZcFUPJny1VC5hZ57e4YsUAkDjirKfjUczn
         oT2NPE0pMta0QIR0DQB+8R5CIGkWQ556etjto3pQ2gZXeO3F4WSwdf7Ica6a5w2lYcAm
         PuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686248938; x=1688840938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sg+jgrZ1/pLYVdsF6FD4BAEjAYjHjHaxTOxuDk/I6Ec=;
        b=cY0OT0zK1JU10PBTRPLnzwVd4em+2CPfqyWkgTGrNUaXYWQf0lQkta3/Xi/atVFG3V
         cZDBzqBe2TpSAjLH+gnMG1O1eb56h1X5lR6PIJdtoQ31GkWX/FV+7yZWV3uTAhzbLNrj
         9qNbY+crvALVW/JAlYeebHHLE2VCtJIM7dzb3goZ7+VYZrUGhP0ezJgA0UtrHGpt52eG
         PIwoibgLav4uEkj9O5uGHEEqSak8mSO4BUUnkvV6W1WHIhHZrTmYQF2UlILicVMePM8y
         kHghTTYeriVYgTRRl/CMYN2lCGg+kbbV/EPilq4yqVxU66wpA0cmKoRdCIhuGD/wgAD0
         VSFw==
X-Gm-Message-State: AC+VfDxIvZmtajgVPYa0k2WmbOCBPyi9144V2MPW/C4R4WFID36+d23F
        RyHyYrOvUOL1IxvVJSPRr23IdrijGr1tVE0QtWJmrvle+EHNmzioJ3qSPw==
X-Google-Smtp-Source: ACHHUZ4WSfEUNbKpGapWwS5vPVJau9ApqeYajvcMQT6xTSwqTAshn6e8TdYQifYuRfE5v4Hhu7g5Fi9YLjLKjRcdC6A=
X-Received: by 2002:ac2:48bb:0:b0:4f6:257f:318f with SMTP id
 u27-20020ac248bb000000b004f6257f318fmr167004lfg.4.1686248937856; Thu, 08 Jun
 2023 11:28:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230608025435.29249-1-rdunlap@infradead.org>
In-Reply-To: <20230608025435.29249-1-rdunlap@infradead.org>
From:   Joe Tessler <jrt@google.com>
Date:   Thu, 8 Jun 2023 14:28:18 -0400
Message-ID: <CAJPkMDR-7u4nqZTsik8=sZUS28E1EL6R0+UnzynEXG41=RG9Yw@mail.gmail.com>
Subject: Re: [PATCH] media: cec: i2c: ch7322: also select REGMAP
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jeff Chase <jnchase@google.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 10:54=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Selecting only REGMAP_I2C can leave REGMAP unset, causing build errors,
> so also select REGMAP to prevent the build errors.

Hi Randy,

I'm curious how you got into this state given that REGMAP is "default
y" when REGMAP_I2C is set.

$ grep -w REGMAP -A4 linux-6.3.6/drivers/base/regmap/Kconfig
config REGMAP
  default y if (REGMAP_I2C || REGMAP_SPI || REGMAP_SPMI || REGMAP_W1
|| REGMAP_AC97 || REGMAP_MMIO || REGMAP_IRQ || REGMAP_SOUNDWIRE ||
REGMAP_SOUNDWIRE_MBQ || REGMAP_SCCB || REGMAP_I3C || REGMAP_SPI_AVMM
|| REGMAP_MDIO || REGMAP_FSI)
  select IRQ_DOMAIN if REGMAP_IRQ
  select MDIO_BUS if REGMAP_MDIO
  bool

FWIW, I only see four cases where both REGMAP and REGMAP_I2C are
selected in the linux-6.3.6 tree (out of 400+ REGMAP_I2C instances).

Joe

>
> ../drivers/media/cec/i2c/ch7322.c:158:21: error: variable 'ch7322_regmap'=
 has initializer but incomplete type
>   158 | static const struct regmap_config ch7322_regmap =3D {
> ../drivers/media/cec/i2c/ch7322.c:159:10: error: 'const struct regmap_con=
fig' has no member named 'reg_bits'
>   159 |         .reg_bits =3D 8,
> ../drivers/media/cec/i2c/ch7322.c:159:21: warning: excess elements in str=
uct initializer
>   159 |         .reg_bits =3D 8,
> ../drivers/media/cec/i2c/ch7322.c:160:10: error: 'const struct regmap_con=
fig' has no member named 'val_bits'
>   160 |         .val_bits =3D 8,
> ../drivers/media/cec/i2c/ch7322.c:160:21: warning: excess elements in str=
uct initializer
>   160 |         .val_bits =3D 8,
> ../drivers/media/cec/i2c/ch7322.c:161:10: error: 'const struct regmap_con=
fig' has no member named 'max_register'
>   161 |         .max_register =3D 0x7f,
> ../drivers/media/cec/i2c/ch7322.c:161:25: warning: excess elements in str=
uct initializer
>   161 |         .max_register =3D 0x7f,
> ../drivers/media/cec/i2c/ch7322.c:162:10: error: 'const struct regmap_con=
fig' has no member named 'disable_locking'
>   162 |         .disable_locking =3D true,
> ../drivers/media/cec/i2c/ch7322.c:162:28: warning: excess elements in str=
uct initializer
>   162 |         .disable_locking =3D true,
> ../drivers/media/cec/i2c/ch7322.c: In function 'ch7322_probe':
> ../drivers/media/cec/i2c/ch7322.c:468:26: error: implicit declaration of =
function 'devm_regmap_init_i2c' [-Werror=3Dimplicit-function-declaration]
>   468 |         ch7322->regmap =3D devm_regmap_init_i2c(client, &ch7322_r=
egmap);
> ../drivers/media/cec/i2c/ch7322.c:468:24: warning: assignment to 'struct =
regmap *' from 'int' makes pointer from integer without a cast [-Wint-conve=
rsion]
>   468 |         ch7322->regmap =3D devm_regmap_init_i2c(client, &ch7322_r=
egmap);
> ../drivers/media/cec/i2c/ch7322.c: At top level:
> ../drivers/media/cec/i2c/ch7322.c:158:35: error: storage size of 'ch7322_=
regmap' isn't known
>   158 | static const struct regmap_config ch7322_regmap =3D {
>
> Fixes: 21b9a47e0ec7 ("media: cec: i2c: ch7322: Add ch7322 CEC controller =
driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jeff Chase <jnchase@google.com>
> Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Cc: Joe Tessler <jrt@google.com>
> Cc: linux-media@vger.kernel.org
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> ---
>  drivers/media/cec/i2c/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>
> diff -- a/drivers/media/cec/i2c/Kconfig b/drivers/media/cec/i2c/Kconfig
> --- a/drivers/media/cec/i2c/Kconfig
> +++ b/drivers/media/cec/i2c/Kconfig
> @@ -5,6 +5,7 @@
>  config CEC_CH7322
>         tristate "Chrontel CH7322 CEC controller"
>         depends on I2C
> +       select REGMAP
>         select REGMAP_I2C
>         select CEC_CORE
>         help
