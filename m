Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CD96C5C44
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 02:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjCWBr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 21:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCWBrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 21:47:25 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7332D45
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 18:47:24 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id f5-20020a4ad805000000b005399cfd276bso2635979oov.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 18:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679536043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lK7QVFfOQBKFYTRiRkRUQTZo9g0ScVlTvvUuZwddc2Q=;
        b=EeLkLvkG1Pnry2U6usWKyJsdt4p+JLbPDzy0jif8flMd9H8MCtfTsSb1Yh7QtBELzf
         HeBZXCaLX9RBZaJWf+rRe6aF8cfAFESqoviS19b5sCZjplMskwL7XHTRjG3J4tulYkKB
         +etVtfiTM6VhFcvmi6ZhpZWRjjoPMBMNTrdN9wgRG+LVZpRXZzpkiv2spKvvsBlP6Nux
         sCFyWF5/yPMiYS5HEEgi68eEHxNv6/8+3v7kPixtGk5uInuQTNKE1gJdjuDhZMQqsXwX
         /313w7h8im+bPeGpVY8z3Y+LoixTivrn5leHRGLDN1N+Fvv9U5Ff5i2CFd5h0Vt+huMy
         hDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679536043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lK7QVFfOQBKFYTRiRkRUQTZo9g0ScVlTvvUuZwddc2Q=;
        b=YjWk99nIkCdME37iuUfj/iV+rxD5/1CKvLQihsb3kFK+K44XaTkj+52YlCKS7LBoWi
         Oo7ck9f8UjytXUpOLtbORwtzfbUasVRyJ4HKagOSrS79RbvTkP124dBvXs+Iks0heSTO
         uD5aQ8GIzh5ly3YNqngGfbZHkmvpbbQ3LLtsVB6GuDqwPfxXyWAXXgSr+wpv5/AZ+Dhz
         IU596TsKFzkS4ijyWGrABnYErzLZtBmdnfx23nFkbfhQHT2YlXqS5OW4Iuk/hgPv9Ho/
         0aeS3Pi60yRkpnNXE1INGrjRG/Gwe0uf8OEqhWd2cPwjP8r7SB84CuPoyFbQIl2po0wq
         2JGQ==
X-Gm-Message-State: AO0yUKVVib7RFazol4R6spxwRowRIIlJzPPBsBbi8qPj4YHDmEuO94/w
        sJPHKVDUAsjsDe+66W0LJYKJ/DnGLkgJya9QwD9SUg==
X-Google-Smtp-Source: AK7set+3xXLR1dgb32hph+I0pKJcJFERnSJJsKR/987fHU1xyfNHT6K9h9Yixp0+k9uwNLyHyRcLpg==
X-Received: by 2002:a4a:94a1:0:b0:536:a447:b270 with SMTP id k30-20020a4a94a1000000b00536a447b270mr2280976ooi.6.1679536043550;
        Wed, 22 Mar 2023 18:47:23 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id f12-20020a4a890c000000b0053a7aaa85a0sm5376988ooi.0.2023.03.22.18.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 18:47:22 -0700 (PDT)
Date:   Wed, 22 Mar 2023 15:50:00 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the gpio-brgl tree
Message-ID: <ZBtb6ML7FmMZ6uQ3@fedora>
References: <20230323122913.4f0410b8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="swKWi4Hlp6vhftZ+"
Content-Disposition: inline
In-Reply-To: <20230323122913.4f0410b8@canb.auug.org.au>
X-Spam-Status: No, score=0.9 required=5.0 tests=DATE_IN_PAST_03_06,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--swKWi4Hlp6vhftZ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 23, 2023 at 12:29:13PM +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> After merging the gpio-brgl tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> drivers/gpio/gpio-pci-idio-16.c:32:30: error: field 'state' has incomplet=
e type
>    32 |         struct idio_16_state state;
>       |                              ^~~~~
> drivers/gpio/gpio-pci-idio-16.c: In function 'idio_16_gpio_get_direction':
> drivers/gpio/gpio-pci-idio-16.c:39:13: error: implicit declaration of fun=
ction 'idio_16_get_direction'; did you mean 'idio_16_gpio_get_direction'? [=
-Werror=3Dimplicit-function-declaration]
>    39 |         if (idio_16_get_direction(offset))
>       |             ^~~~~~~~~~~~~~~~~~~~~
>       |             idio_16_gpio_get_direction
> drivers/gpio/gpio-pci-idio-16.c: In function 'idio_16_gpio_get':
> drivers/gpio/gpio-pci-idio-16.c:62:16: error: implicit declaration of fun=
ction 'idio_16_get'; did you mean 'idio_16_gpio_get'? [-Werror=3Dimplicit-f=
unction-declaration]
>    62 |         return idio_16_get(idio16gpio->reg, &idio16gpio->state, o=
ffset);
>       |                ^~~~~~~~~~~
>       |                idio_16_gpio_get
> drivers/gpio/gpio-pci-idio-16.c: In function 'idio_16_gpio_get_multiple':
> drivers/gpio/gpio-pci-idio-16.c:70:9: error: implicit declaration of func=
tion 'idio_16_get_multiple'; did you mean 'idio_16_gpio_get_multiple'? [-We=
rror=3Dimplicit-function-declaration]
>    70 |         idio_16_get_multiple(idio16gpio->reg, &idio16gpio->state,=
 mask, bits);
>       |         ^~~~~~~~~~~~~~~~~~~~
>       |         idio_16_gpio_get_multiple
> drivers/gpio/gpio-pci-idio-16.c: In function 'idio_16_gpio_set':
> drivers/gpio/gpio-pci-idio-16.c:79:9: error: implicit declaration of func=
tion 'idio_16_set'; did you mean 'idio_16_gpio_set'? [-Werror=3Dimplicit-fu=
nction-declaration]
>    79 |         idio_16_set(idio16gpio->reg, &idio16gpio->state, offset, =
value);
>       |         ^~~~~~~~~~~
>       |         idio_16_gpio_set
> drivers/gpio/gpio-pci-idio-16.c: In function 'idio_16_gpio_set_multiple':
> drivers/gpio/gpio-pci-idio-16.c:87:9: error: implicit declaration of func=
tion 'idio_16_set_multiple'; did you mean 'idio_16_gpio_set_multiple'? [-We=
rror=3Dimplicit-function-declaration]
>    87 |         idio_16_set_multiple(idio16gpio->reg, &idio16gpio->state,=
 mask, bits);
>       |         ^~~~~~~~~~~~~~~~~~~~
>       |         idio_16_gpio_set_multiple
> drivers/gpio/gpio-pci-idio-16.c: In function 'idio_16_irq_mask':
> drivers/gpio/gpio-pci-idio-16.c:106:45: error: invalid use of undefined t=
ype 'struct idio_16'
>   106 |                 iowrite8(0, &idio16gpio->reg->irq_ctl);
>       |                                             ^~
> drivers/gpio/gpio-pci-idio-16.c: In function 'idio_16_irq_unmask':
> drivers/gpio/gpio-pci-idio-16.c:129:41: error: invalid use of undefined t=
ype 'struct idio_16'
>   129 |                 ioread8(&idio16gpio->reg->irq_ctl);
>       |                                         ^~
> drivers/gpio/gpio-pci-idio-16.c: In function 'idio_16_irq_handler':
> drivers/gpio/gpio-pci-idio-16.c:164:46: error: invalid use of undefined t=
ype 'struct idio_16'
>   164 |         irq_status =3D ioread8(&idio16gpio->reg->irq_status);
>       |                                              ^~
> drivers/gpio/gpio-pci-idio-16.c:178:37: error: invalid use of undefined t=
ype 'struct idio_16'
>   178 |         iowrite8(0, &idio16gpio->reg->in0_7);
>       |                                     ^~
> drivers/gpio/gpio-pci-idio-16.c: In function 'idio_16_irq_init_hw':
> drivers/gpio/gpio-pci-idio-16.c:198:37: error: invalid use of undefined t=
ype 'struct idio_16'
>   198 |         iowrite8(0, &idio16gpio->reg->irq_ctl);
>       |                                     ^~
> drivers/gpio/gpio-pci-idio-16.c:199:37: error: invalid use of undefined t=
ype 'struct idio_16'
>   199 |         iowrite8(0, &idio16gpio->reg->in0_7);
>       |                                     ^~
> drivers/gpio/gpio-pci-idio-16.c: In function 'idio_16_probe':
> drivers/gpio/gpio-pci-idio-16.c:232:37: error: invalid use of undefined t=
ype 'struct idio_16'
>   232 |         iowrite8(0, &idio16gpio->reg->filter_ctl);
>       |                                     ^~
> drivers/gpio/gpio-pci-idio-16.c:248:9: error: implicit declaration of fun=
ction 'idio_16_state_init'; did you mean 'file_ra_state_init'? [-Werror=3Di=
mplicit-function-declaration]
>   248 |         idio_16_state_init(&idio16gpio->state);
>       |         ^~~~~~~~~~~~~~~~~~
>       |         file_ra_state_init
> drivers/gpio/gpio-pci-idio-16.c: In function 'idio_16_gpio_get':
> drivers/gpio/gpio-pci-idio-16.c:63:1: error: control reaches end of non-v=
oid function [-Werror=3Dreturn-type]
>    63 | }
>       | ^
>=20
> Caused by commit
>=20
>   473b79057bbd ("gpio: idio-16: Remove unused legacy interface")
>=20
> I have used the gpio-brgl tree from next-20230322 for today.
>=20
> --=20
> Cheers,
> Stephen Rothwell

Commit 473b79057bbd shouldn't be merged until all of the IDIO-16 legacy
interface is first removed.

Bart, would you revert all of the "Migrate IDIO-16 GPIO drivers to
regmap API" patches [0]? That patchset needs to be revised anyway to
prevent conflicts with the handle_mask_sync() API change [1]; I'll
submit a v3 later this week that resolves the incompatibilies and
rebase on the latest gpio/for-next.

William Breathitt Gray

[0] https://lore.kernel.org/all/cover.1677515341.git.william.gray@linaro.or=
g/
[1] https://lore.kernel.org/all/cover.1679323449.git.william.gray@linaro.or=
g/

--swKWi4Hlp6vhftZ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZBtb6AAKCRC1SFbKvhIj
K4NCAQCqLDrnXwSgH7e8UiVOm13v/dU+QyDRY6iFiL2k7CupWwEAw/vXToO6FJov
2fmlH+ZUqaTfPr4iLpdwwXhWPdMBeAw=
=EHEJ
-----END PGP SIGNATURE-----

--swKWi4Hlp6vhftZ+--
