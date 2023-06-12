Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFAF736EE3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjFTOkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbjFTOkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:40:01 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C350170A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:39:45 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-4716726b741so864981e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687271980; x=1689863980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+b4wcWVHeA19pd6y6fqWTIC5LoXJqCFk+0Tw0j4g+R4=;
        b=WyVqURcKcIYpMyLO2NU//B5H951+Vn108apEVN+kctGGLNIejqck8XEXeekwBy6h+U
         ZvHAMW0nujNWw+uOkX07IHxCGJgywLypQcF3XpU5kHSnplkCKegVQ7MElmzKxIp/Er3/
         uGOlKcNdPNKcNncAMeQv9KOGta0bkhFEhfzBNQ0WlcJBY+zziAnJRFf+o3ET6EHoH+Dj
         oUiKrLove5CHdNrPWzqdYTtZmGTaeG1beKHjmtjJVd3kbVoWkV9qpvSvFopEqMk7g+z7
         xQHaXQpJY156xEesIaPnu9EmCJjH9ANqUj0cNnZupmlrQNNCcMWum1GZxZilvS/S0VCT
         fj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687271980; x=1689863980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+b4wcWVHeA19pd6y6fqWTIC5LoXJqCFk+0Tw0j4g+R4=;
        b=MouiklC4wHq4672ZeMnYsXDx2B2PfpVAoGNQfYYuleIcOFS+mlMQGf29hXK2pmtp67
         MIWdXnRySudXrfBPJzi8TZe4TTdXWAtu2eGm1PK/2fTcJ57xsfmt0nb2GXYwSUs7ziOi
         v6czo99MaGWokUiNFeSr8n7MnRcbtoHApeMEhLGb2apow0Hu3lHMCJRZGQGT4Bgf4hfH
         AmDZbF9m3lgxwv1CDBryOMT34PoqaDtgYmNcFeCh5IBEp3JC46delbU4VijkG5t8aZgT
         7xIzFMVdMIacUV7fMDuLSAVaCvTiFHhlkKN+H4oXhePT1vM8e32GOwQiD0EUAiBs0Qd/
         9faQ==
X-Gm-Message-State: AC+VfDxZG6XNup6YgzhrmHvBrFWogb9+ioedW0QgMaYIwyvTh0Yps61J
        temf+znK7UCKR5yO3T7F+STzHw==
X-Google-Smtp-Source: ACHHUZ4mrGP6SAvz5CEBdiFvOJBKfyMRK5l9BvTXSU6LnVUYYPiIBH3lsx0FcRsMaKW0P/idAPRr2A==
X-Received: by 2002:a1f:3f02:0:b0:471:2aa6:41f4 with SMTP id m2-20020a1f3f02000000b004712aa641f4mr2747781vka.7.1687271980303;
        Tue, 20 Jun 2023 07:39:40 -0700 (PDT)
Received: from fedora (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id h85-20020a1f9e58000000b0045ae1b37251sm335202vke.35.2023.06.20.07.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 07:39:39 -0700 (PDT)
Date:   Mon, 12 Jun 2023 01:14:03 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     William Breathitt Gray <wbg@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, andy.shevchenko@gmail.com
Subject: Re: [PATCH 1/3] counter: i8254: Introduce the Intel 8254 interface
 library module
Message-ID: <ZIapmzFJ0Bz7Bofj@fedora>
References: <cover.1681665189.git.william.gray@linaro.org>
 <f6fe32c2db9525d816ab1a01f45abad56c081652.1681665189.git.william.gray@linaro.org>
 <ZIHpGUWZ8wE7tkJP@ishi>
 <32ddaa7b-53a8-d61f-d526-b545bd561337@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f1xoCXDbZXT2QnXa"
Content-Disposition: inline
In-Reply-To: <32ddaa7b-53a8-d61f-d526-b545bd561337@linux.intel.com>
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f1xoCXDbZXT2QnXa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 20, 2023 at 05:03:53PM +0300, Jarkko Nikula wrote:
> Hi
>=20
> On 6/8/23 17:43, William Breathitt Gray wrote:
> > On Sun, Apr 16, 2023 at 01:36:53PM -0400, William Breathitt Gray wrote:
> > > Exposes consumer library functions providing support for interfaces
> > > compatible with the venerable Intel 8254 Programmable Interval Timer
> > > (PIT).
> > >=20
> > > The Intel 8254 PIT first appeared in the early 1980s and was used
> > > initially in IBM PC compatibles. The popularity of the original Intel
> > > 825x family of chips led to many subsequent variants and clones of the
> > > interface in various chips and integrated circuits. Although still
> > > popular, interfaces compatible with the Intel 8254 PIT are nowdays
> > > typically found embedded in larger VLSI processing chips and FPGA
> > > components rather than as discrete ICs.
> > >=20
> > > A CONFIG_I8254 Kconfig option is introduced by this patch. Modules
> > > wanting access to these i8254 library functions should select this
> > > Kconfig option, and import the I8254 symbol namespace.
> > >=20
> > > Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
> >=20
> > I've queued this patch to the counter-next branch of my Counter tree.
> >=20
> > Jonathan, Bart, I've created an immutable branch with just this patch
> > for you to pull which should allow you each to merge the other patch in
> > this patchset for your respective tree.
> >=20
> I noticed this patch cause in linux-next "Counter support" submenu to
> disappear and its menu entries are listed directly in "Device Drivers" me=
nu.
>=20
> Then I wonder why the CONFIG_I8254 has the help text defined since drivers
> should select it.
>=20
> Or was the idea something like below?
>=20
> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> index bca21df51168..80631b5b0fc6 100644
> --- a/drivers/counter/Kconfig
> +++ b/drivers/counter/Kconfig
> @@ -10,9 +10,10 @@ menuconfig COUNTER
>           interface. You only need to enable this, if you also want to
> enable
>           one or more of the counter device drivers below.
>=20
> +if COUNTER
> +
>  config I8254
> -       tristate
> -       select COUNTER
> +       tristate "i8254 interface library"
>         select REGMAP
>         help
>           Enables support for the i8254 interface library functions. The
> i8254
> @@ -25,8 +26,6 @@ config I8254
>=20
>           If built as a module its name will be i8254.
>=20
> -if COUNTER
> -
>  config 104_QUAD_8
>         tristate "ACCES 104-QUAD-8 driver"
>         depends on (PC104 && X86) || COMPILE_TEST

Hi Jarkko,

Thank you for pointing that out, the config I8254 entry should have been
added above the menuconfig COUNTER entry instead of below it; if you
move it you should notice the "Counter support" submenu items go back to
normal. The intention is for consumer drivers to select I8254 when they
use the library. The I8254 module doesn't do anything on its own so
that's why it's hidden in the menu (the help description is there for
the sake of reviewers). I'll submit a patch soon fixing this.

Thanks,

William Breathitt Gray

--f1xoCXDbZXT2QnXa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZIapmwAKCRC1SFbKvhIj
K1zWAQDgvHN1klZit98Ym3Y7KgZ+qH4fGB67KXhG98BdzqfzbQD6Aq8xOLSBhW5w
jPLruPTNw6CugIkfrTtSbt09dOp19Ac=
=4vwM
-----END PGP SIGNATURE-----

--f1xoCXDbZXT2QnXa--
