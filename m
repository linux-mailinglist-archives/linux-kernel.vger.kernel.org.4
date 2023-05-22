Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C4570C327
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 18:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjEVQUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 12:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjEVQUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 12:20:18 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF30C106
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 09:20:16 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-456f19307f6so1690497e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 09:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684772416; x=1687364416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FalLkpE5rBhioycXpzcRGsd9t4B3UEdrc8kKo+SrZ70=;
        b=EK40A2SkIC3P0WJlSNOs9/Rf7WaG8J3seZH6jvZAJhhpbmXs6FpRl8xtVST4+ZCkgB
         byVFQxrYD7NgOxtnyebwPTHggyArZB3ks4mLo5jngt38C6i6hCGN+ImEgISfg7ho1+9/
         mowuqLM0vXejxcg4Cuy+ECT0IWepdlhjzgxpDM7Unk87NHxOFtk6gXwdWzhtOq6NwzKT
         GJC+EpAdsfjkLfyLHvHxnCtDEgthhZstkfjKNXqUCQ5VgMPlAvHKI+51jG3vrAP5rL7a
         NRe8306rRqvwRc2zNfaROm44icDg8LrVseii5ZQ60P/ZrDnp0X8ah3MuNVZGzqCNupqM
         XKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684772416; x=1687364416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FalLkpE5rBhioycXpzcRGsd9t4B3UEdrc8kKo+SrZ70=;
        b=SibwKQvbFKRnCcKaM2GKL9YKlyMsiGXvTmsUCF6SeY6JpSIE5BjAW5WZXB9EoHEJpm
         cDsl1sdlAUVZi+dYpHY1Qs4GDdHj8VeUIdcQbTTTSNW8lcfmQw4cWmo006kkgOAtCsxb
         3bCWPCPpvRcTX9yMiH9CE+wqmP3IcL/gLaIgJLgc0JqJIfbzU/B1bMG6LEkfZghJ7HJo
         5qiNO4nkgdoPLf/KLd6zMaI6ydU7UlsoelbqBCTYWelH1BdaVd+dLoqELc3gE6AZbt5U
         2bdFjeopzWThr4WHXmQPxgYIeTLO46xgqPE5AZpOuHjy0htc7kdUWJA1e2dY0XcMnKFK
         /yUA==
X-Gm-Message-State: AC+VfDzNY0vMJUjU8Fw77tVxvr7iBdd1coutFOF0q0gE3AK8dfKoMpkH
        6jOfoTMe0LKmpU2MRRq8U/3iuQ==
X-Google-Smtp-Source: ACHHUZ5+zMzHkGvG9VnYhqxBM2xUVswEzHSYhmBAmaUR7Po3+eu0mrPsLd9HsIGTpk+WHEJ0Bt6XQw==
X-Received: by 2002:a05:6102:414:b0:42e:6689:d762 with SMTP id d20-20020a056102041400b0042e6689d762mr2766155vsq.8.1684772415683;
        Mon, 22 May 2023 09:20:15 -0700 (PDT)
Received: from fedora (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id t20-20020ab05514000000b00772378e82b6sm1238858uaa.33.2023.05.22.09.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:20:14 -0700 (PDT)
Date:   Mon, 22 May 2023 12:20:12 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     andy.shevchenko@gmail.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH 0/3] Add Intel 8254 Counter support
Message-ID: <ZGuWPLISTk7ALOe/@fedora>
References: <cover.1681665189.git.william.gray@linaro.org>
 <ZGiYr6XLguZ8R3_8@surfacebook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NvvVxlDlF1weS4K3"
Content-Disposition: inline
In-Reply-To: <ZGiYr6XLguZ8R3_8@surfacebook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NvvVxlDlF1weS4K3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 20, 2023 at 12:53:51PM +0300, andy.shevchenko@gmail.com wrote:
> Sun, Apr 16, 2023 at 01:36:52PM -0400, William Breathitt Gray kirjoitti:
> > The Intel 8254 PIT first appeared in the early 1980s and was used
> > initially in IBM PC compatibles. The popularity of the original Intel
> > 825x family of chips led to many subsequent variants and clones of the
> > interface in various chips and integrated circuits. Although still
> > popular, interfaces compatible with the Intel 8254 PIT are nowdays
> > typically found embedded in larger VLSI processing chips and FPGA
> > components rather than as discrete ICs.
> >=20
> > This patch series introduces a library to provide support for interfaces
> > compatible with the venerable Intel 8254 Programmable Interval Timer
> > (PIT). Modules wanting access to the i8254 library should select the
> > newly introduced CONFIG_I8254 Kconfig option, and import the I8254
> > symbol namespace.
> >=20
> > Support for the i8254 is added in respective follow-up patches for the
> > 104-dio-48e driver and stx104 driver whose devices feature i8254
> > compatible interfaces. Several additional dependencies are necessary for
> > the 104-dio-48e [0][1][2] and stx104 [3][4].
> >=20
> > Due to the dependency requirements, I can take the i8254 introduction
> > patch through the Counter tree and provide an immutable branch that can
> > be merged to the GPIO and IIO trees; the 104-dio-48e patch and stx104
> > patch could then be picked up separately by the respective subsystem
> > maintainers.
>=20
> Good job!
>=20
> What I'm wondering is that. Can x86 core and others which are using that =
chip
> utilize (some of) the functions from the library?

Essentially we just need a regmap to register the device to the system
via devm_i8254_regmap_register(), so theoretically it would be possible
to load this driver for the integrated 8254 interface used by x86 core.
The big caveat however is that the Counter subsystem currently lacks an
in-kernel API, so registering that device would just expose the
userspace Counter sysfs and chrdev interfaces.

I suppose the interest is whether we could use the configuration
functionality of the Counter subsystem to abstract some of the hardcoded
routines and magic numbers in places like drivers/clocksource/i8253.c
and similar. Right now we wouldn't be able to do so, but perhaps in the
future if an in-kernel API is developed for the Counter subsystem then
it would be possible.

An interesting side-note about compatibility: the Intel 8253 counting
behavior differs subtly from the Intel 8254 in certain situations. For
example, suppose odd counts in Mode 3: the Intel 8253 will load the
initial count directly [0] whereas the Intel 8254 loads the initial
count minus one (an even number) [1]. This results in different maximums
and minimums: for example if the initial count is 5, the Intel 8253 will
report a maximum count of 5 and a minimum count of 2 (counting 5->4->2),
whereas the Intel 8254 will report a maximum count of 4 and a minimum
count of 0 (counting 4->2->0); same square wave is produced, but
different count values are reported.

William Breathitt Gray

[0] https://www.alldatasheet.com/datasheet-pdf/pdf/66098/INTEL/8253.html
[1] https://www.alldatasheet.com/datasheet-pdf/pdf/66099/INTEL/8254.html

--NvvVxlDlF1weS4K3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZGuWPAAKCRC1SFbKvhIj
K9PsAP4n1cxwbsYLZf/MIbk2dVforCvX6hCn6uUZ6VrjRLmMFwD+N7PXz5gPyMxD
+q60KzmvuQwM5IhnemlmBSDCsrLDoA0=
=wQFD
-----END PGP SIGNATURE-----

--NvvVxlDlF1weS4K3--
