Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B70B73EE97
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 00:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjFZWUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 18:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjFZWTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 18:19:47 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9BD11B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 15:19:44 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-47191280066so1177674e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 15:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687817983; x=1690409983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ufNVE0dQejfSX8wYNYRTMSSfw+pixc9c6G+EySlKjXU=;
        b=s9yPfPENqAVCBS8yJ/0syiP44/PinzWCNVUgFlXiAMw2DbEOlTVhHkttkanWHHhguD
         EfrEh4cvSbKmb/K8sVu/djsYc2swxnvVCGTXtoGlqaLPTy9aqPAfc06/hAGHB+V00tfO
         Ar8PE1TcDlDmltieL8l3xZPDc9VSmhDAvfFvs8+Rfn8iLACXROnE33OHojXHkystwXbL
         9Y9dv9NPa8R+Gc7HW5Qi9CP/1HVUvxj6NBjo9ceRZ7fmQj66fpkgk4jDrLCSro/UFGrs
         B946nFvgjLy3lNOcTWrR3E4gw4LWWpB/9bubTPj7uQbIvvN+uZAzK3fOzHH1yh/N6Wy+
         DxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687817983; x=1690409983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufNVE0dQejfSX8wYNYRTMSSfw+pixc9c6G+EySlKjXU=;
        b=AUP/+i2CywKQ0w/dMFo8a/isFXADeIbn7/0FFDwUqAuy490j8Hd4QSF1uwqQHEm/Tz
         9+snxy3dtoRyJv49A6CM08RmgUsXcqUHCwQwEqDAMivhvaFzfF78iwPlIeGnPvxd1+UW
         KM/YINM99nHMgrH5wX/Kf1f0nl1Zr2tsz13hz6MclwMULaH6dvo6SS7JXJNIsMa0im0I
         7bF7u43C/2QLQuaFPyXAj8dfJV+RKlNEW8glg8vpwSFxMbYjMqSbwdpEVM9e7eQ4DzZn
         ohhQ+wwvC2athS2+lGZk0jYdUAHc2dpWYykn+ArbomIangjkyhw6XuERNMgxX22WULoG
         mCbw==
X-Gm-Message-State: AC+VfDyIHvfrrtP5RtT0gfP3MNDEMlbE6PnHfy2Wr0vJSU8Ch8W3eDM1
        Vzi7ql8xeujzxfKo1dS4uehdBQ==
X-Google-Smtp-Source: ACHHUZ4qcZPYyWh1IiaQmhAJsjra9DikU+Fft13pk918If1PwcgaUHeACsrT15neJikmLTJxc8L5kg==
X-Received: by 2002:a1f:5744:0:b0:46e:8084:92be with SMTP id l65-20020a1f5744000000b0046e808492bemr12928526vkb.6.1687817983363;
        Mon, 26 Jun 2023 15:19:43 -0700 (PDT)
Received: from fedora (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id g200-20020a1f9dd1000000b0047cdf4481f4sm753414vke.26.2023.06.26.15.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 15:19:41 -0700 (PDT)
Date:   Mon, 26 Jun 2023 18:19:39 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-iio@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH] counter: Fix menuconfig "Counter support" submenu
 entries disappearance
Message-ID: <ZJoO++gEMiDsZioz@fedora>
References: <20230620170159.556788-1-william.gray@linaro.org>
 <4341aa87-c3b1-b0a4-4f82-c903c3085df3@infradead.org>
 <ZJIWLYtl6BEHfDZQ@fedora>
 <20230625121108.63ad5e60@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MbeZhqF2YnPwH4y0"
Content-Disposition: inline
In-Reply-To: <20230625121108.63ad5e60@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MbeZhqF2YnPwH4y0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 25, 2023 at 12:11:08PM +0100, Jonathan Cameron wrote:
> On Tue, 20 Jun 2023 17:12:13 -0400
> William Breathitt Gray <william.gray@linaro.org> wrote:
>=20
> > On Tue, Jun 20, 2023 at 02:00:37PM -0700, Randy Dunlap wrote:
> > > Hi,
> > >=20
> > > On 6/20/23 10:01, William Breathitt Gray wrote: =20
> > > > The current placement of the I8254 Kconfig entry results in the
> > > > disappearance of the "Counter support" submenu items in menuconfig.=
 Move
> > > > the I8254 above the menuconfig COUNTER entry to restore the intended
> > > > submenu behavior.
> > > >=20
> > > > Fixes: d428487471ba ("counter: i8254: Introduce the Intel 8254 inte=
rface library module")
> > > > Reported-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> > > > Closes: https://lore.kernel.org/all/32ddaa7b-53a8-d61f-d526-b545bd5=
61337@linux.intel.com/
> > > > Signed-off-by: William Breathitt Gray <william.gray@linaro.org> =20
> > >=20
> > > Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> > >=20
> > > but why is I8254 here at all? Users cannot enable it
> > > and nothing selects it.  Is it a WIP?
> > >=20
> > > Thanks. =20
> >=20
> > There are pending patches for two drivers to use it: 104-dio-48e[^1] and
> > stx104[^2]. Those will be picked up in their respective subsystem trees
> > (by Bart and Jonathan I presume).
> >=20
>=20
> I missed the IIO patch in that series. Could you resend please.
>=20
> Jonathan
>=20
> > William Breathitt Gray
> >=20
> > [^1]: https://lore.kernel.org/all/dc4d0d5ca6ea28eda18815df114ecb21226cb=
345.1681665189.git.william.gray@linaro.org/
> > [^2]: https://lore.kernel.org/all/45d35b6f6e8d51df788b2bc85c456bfd45476=
b1a.1681665189.git.william.gray@linaro.org/

I8254 is expected to land in 6.5 so I'll wait and resend the IIO patch
rebased on 6.5-rc1 once it's released in a couple weeks. That'll make
things simple for you and avoid the need for an immutable branch.

William Breathitt Gray

--MbeZhqF2YnPwH4y0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZJoO+wAKCRC1SFbKvhIj
Kx9rAQDZbMBbVF2rUgePh1g5t4gCo7byAnzWS4jz2Snc2zdWfgD+MfuIWvJ0m5eL
x8t2QKcSOHH7XkVcjbsy9XjA9WGVaAk=
=fBt7
-----END PGP SIGNATURE-----

--MbeZhqF2YnPwH4y0--
