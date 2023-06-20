Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6992D737672
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 23:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjFTVMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 17:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjFTVMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 17:12:20 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25451988
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:12:16 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-791b8500a21so270486241.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687295536; x=1689887536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aJopb8VA1/D5IZOn/wqbLMk8IC0K1ywAj5CnbTia8Q4=;
        b=bGzSqG/eJD+Lmz6iezEdxQ5trUo38U5xkNiY0PbVzcuIhuTlBPOFaxRF8myyfQBVEy
         lrci3tJHhzEa1bHRVr1tWpjaYPgVZxGg++G1qhDIGXT448Y2js4o1YGYDmzfvyEIlfyx
         zKkidlYu+EVQCKr7JYrNoVOuL9XlHko+olgLAHrbwdZrmdyZhArKp1IY5jLE2CFuXQlA
         DJ71DPcNpNbNQjBXC/3mhmxrUbc4t0smTOR6NyIwR3F9mOVQjjhunRjfcP73ZhYfeUD8
         Vn2FlN7F1Xqx0j0rI6JHahiCACwZthtBuJ4qaHYOj6vFioVsM6LfaSdoblno22VruJkD
         UfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687295536; x=1689887536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJopb8VA1/D5IZOn/wqbLMk8IC0K1ywAj5CnbTia8Q4=;
        b=aq3U4vDm8s3Q/z36z11pn8X10rZEmvB7jGaqF/2Du2BpUlEux5OwA016Q/rXr7wIcJ
         ygNtwSZ3tqD6UU7N4/yMxXOHlA+jgoMQMCOxKEb4GBCt1A9qcr11iPZyyVFWHD+4Py7/
         omacsSHQSYTo9kO63qugPBdCmWocNFXZKpT6FfGW9d0qVV05z5eS+Fh25dQSMQ2Of0jA
         MnfMPD9jlihDYGMEiKUws8VQFiyQOgEVyUMVYPOHTa6LsHqdC6zogNcJPkZX2VZs/NrE
         Kjr72wplQOpccw5z2iD+V82q7mnJiYH/WOaoQjm4uXjy6xokHjFAAQSVetUJ48Ygv7bC
         qPnw==
X-Gm-Message-State: AC+VfDyVf36SkJ1yHqrMa8FKwBg1E0kMQnWc9RJCaOlnp4iCErE5PxMw
        LuFOjYv9K3UGpf6Smkr9qUzEHw==
X-Google-Smtp-Source: ACHHUZ6++vAJnMilyVeqgAWY+CY3TaGCKbukUm7qekdxxXQz//Bu4esTTZYpLckXu3qzU5zIJnU5qw==
X-Received: by 2002:a67:fbc4:0:b0:43f:4779:49ce with SMTP id o4-20020a67fbc4000000b0043f477949cemr3249133vsr.3.1687295535956;
        Tue, 20 Jun 2023 14:12:15 -0700 (PDT)
Received: from fedora (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id l15-20020ab053cf000000b0078cf32c7d3dsm415147uaa.12.2023.06.20.14.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 14:12:15 -0700 (PDT)
Date:   Tue, 20 Jun 2023 17:12:13 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH] counter: Fix menuconfig "Counter support" submenu
 entries disappearance
Message-ID: <ZJIWLYtl6BEHfDZQ@fedora>
References: <20230620170159.556788-1-william.gray@linaro.org>
 <4341aa87-c3b1-b0a4-4f82-c903c3085df3@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="A4eykhRWKS+hjpBE"
Content-Disposition: inline
In-Reply-To: <4341aa87-c3b1-b0a4-4f82-c903c3085df3@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--A4eykhRWKS+hjpBE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 20, 2023 at 02:00:37PM -0700, Randy Dunlap wrote:
> Hi,
>=20
> On 6/20/23 10:01, William Breathitt Gray wrote:
> > The current placement of the I8254 Kconfig entry results in the
> > disappearance of the "Counter support" submenu items in menuconfig. Move
> > the I8254 above the menuconfig COUNTER entry to restore the intended
> > submenu behavior.
> >=20
> > Fixes: d428487471ba ("counter: i8254: Introduce the Intel 8254 interfac=
e library module")
> > Reported-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> > Closes: https://lore.kernel.org/all/32ddaa7b-53a8-d61f-d526-b545bd56133=
7@linux.intel.com/
> > Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
>=20
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
>=20
> but why is I8254 here at all? Users cannot enable it
> and nothing selects it.  Is it a WIP?
>=20
> Thanks.

There are pending patches for two drivers to use it: 104-dio-48e[^1] and
stx104[^2]. Those will be picked up in their respective subsystem trees
(by Bart and Jonathan I presume).

William Breathitt Gray

[^1]: https://lore.kernel.org/all/dc4d0d5ca6ea28eda18815df114ecb21226cb345.=
1681665189.git.william.gray@linaro.org/
[^2]: https://lore.kernel.org/all/45d35b6f6e8d51df788b2bc85c456bfd45476b1a.=
1681665189.git.william.gray@linaro.org/

--A4eykhRWKS+hjpBE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZJIWLQAKCRC1SFbKvhIj
K2MWAQDzsNnr/aAKHqCpA2oNej+hu4vXpjpf0WjWhm5mCEzCeAD/UkBzweb3tXlj
dQODjvZU4WCWV4qi/bQHZASKZizYqwU=
=CuWO
-----END PGP SIGNATURE-----

--A4eykhRWKS+hjpBE--
