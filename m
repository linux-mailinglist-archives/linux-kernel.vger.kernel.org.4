Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925986DE0FF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 18:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjDKQbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 12:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjDKQbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 12:31:03 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE13A40C8;
        Tue, 11 Apr 2023 09:31:02 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id qb20so21447677ejc.6;
        Tue, 11 Apr 2023 09:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681230661;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUtdmO5RhKKGgsshDATRStPZUG/pJBx9W7yE7kfQ97o=;
        b=iXUCz/YRwpooX0LJ2CjxCwvuEbzWNZ4HtNnVpxAgPs5447q73rfarFtpTI16t+Ac2p
         UFMl7ZjnLq1SGC0AyYt218TSgbgdzq6KsyOL7cWaLKxh7jA19hdbbj8CUx1psTTFNBjm
         APk7TbIA4ZpwvI3T91GSe9oHzuFKfdz+MiBm3suTqNF5fVoZ2X4IywASgQYKJql6H3pC
         EmseqHXl+rtQPo8F2K8rPwjiEUZzt2RctOyBypvF6jHtB+zDIPXBW6Itsq6OQjQguEt9
         0b3v/rnbFW132IRtFD78C29vbsjpA76n89ZX+5vgyk4guHEJOUzrO7b2kDhLLI/pYTlS
         nUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681230661;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUtdmO5RhKKGgsshDATRStPZUG/pJBx9W7yE7kfQ97o=;
        b=AmX75crRJEARPd47aYQkWsoJTTHQOSp6stPLEYsmzBA4SF60q1p+u8A9s3EqTeKjtP
         Rm9ePTH3JV3EHk4IsQDvlty478EWj+sBC3dzfVaXJSiP7xeC48D7Edwd90M6e5CE4BIy
         fx86tzZrrlg35/n+cuWUHFGOkgS+vKox/71QtgQZM9CtKfuoYdPN/0UDrsW0KlLl/X4p
         4EQqcSFNXcEvDH5hz+cbP6wrRlBfQiluc2ASqs861t1nW0KTczQ5TiEPrfwflb0/a0K/
         J3JHs+YukJt6eRRdH9eBkb6rwbNe2KWJOTalFmmP+xs0cRI/ZYb6xBCcgT6zcNIge31U
         bZVg==
X-Gm-Message-State: AAQBX9e+1V/UgOkox1d2q9GCBUPkm6L9feDTcXNLC701KE30N687vFj9
        eN9RK+obB+E1VKCdO04GlmQ=
X-Google-Smtp-Source: AKy350Y0D5VWkb/RTlDyKlVs1DqA2ctLjh5WfRAflgMMPA2Ussjc653GY5AnIU/MD3Zg2p/OupxyKQ==
X-Received: by 2002:a17:906:31d9:b0:931:ad32:79ed with SMTP id f25-20020a17090631d900b00931ad3279edmr11576235ejf.12.1681230660970;
        Tue, 11 Apr 2023 09:31:00 -0700 (PDT)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id qk6-20020a1709077f8600b00948fd62a53asm6305718ejc.71.2023.04.11.09.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 09:31:00 -0700 (PDT)
Date:   Tue, 11 Apr 2023 18:30:58 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Wei Ni <wni@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Johan Hovold <johan@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
Subject: Re: thermal/drivers/tegra: Getting rid of the get_thermal_instance()
 usage
Message-ID: <ZDWLQgttLR2dWbwd@orome>
References: <fa2bd92a-f2ae-a671-b537-87c0f3c03dbd@linaro.org>
 <Y9J4WAFyXyV/nqlG@orome>
 <20230210131703.GF175687@linaro.org>
 <Y+ZQC85TM+O8p8gQ@orome>
 <365c469b-22f6-fb26-1872-5e9a5079af5d@linaro.org>
 <Y+Ze4tAM6Jpszq/3@orome>
 <c93d583d-e2b8-e8dd-cc94-cd77ecb2cab1@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ufNrFSjcZLO8PioW"
Content-Disposition: inline
In-Reply-To: <c93d583d-e2b8-e8dd-cc94-cd77ecb2cab1@linaro.org>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ufNrFSjcZLO8PioW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 11, 2023 at 12:48:25PM +0200, Daniel Lezcano wrote:
>=20
> Hi Thierry,
>=20
> did you have time to look at this ?
>=20
> This driver is the only one using get_thermal_instance() and I would like=
 to
> remove this function along with the thermal_core.h inclusion in this driv=
er

Yeah, I've had work in progress patches for this for a few weeks but
haven't had the time to test these much. I'd like to take a bit longer
to test them before sending them out.

Thierry

--ufNrFSjcZLO8PioW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQ1i0IACgkQ3SOs138+
s6F09Q/8Dqyk/Wx7nPG1vPtdEdx+ms6SMJ58mkrUxY0nPHtZP9C9lvOsytfI9XpC
YVldrNNumV5zqtPAf2nJkdVLGcKCEZ6vASkDvhIRQ8l0dgNQBhLV8AqlafcC9KSd
AbvXrK44I42sFtkyONdtgoNjrAAtPINrihcMn3VLFkplqv9dj7GRgVYAHbTS7KYB
eyHz+QEHCINu2GiqUE9NcYjaPWxCp/KavY5zd/cQGotnibfJKC2z789SfcPvrN/m
1M0KsexT0kFmp+D4D+G/AsMKmadSoUWi9adQrCFaLw7GXU0hn3ih/m6Pa5RRutu1
35RwtnT9PfbWT3+F0KfNjYZFhwFiF/iFn/FUAEMQ2j3pCq8SmKXPA/bnuZMvfDVg
nHCOmI0aUZ+VaAm1SYAlQCh4KOmJQxTu1ibPEOii/G0ccC5Nx6IxMMVeuzPNt85X
YPXZbOvIB+Q1d6LdbsrP7uWEKmn68yN9Hz//r7FvSO1NS2rfbkC1Fm1OojREnKxT
7K7YvtV7WbR1XeskwAsfmaTSnGxqoSdofEpCWcYgQgTkxxlSBww0pxvcqZ8+eQ6a
MNyuDCzCCrcgHP0lrI/JlpMdS0ZUXc1lLm3m/P2aB+PjsFA/JsjBRwF3fSh+JjYD
TVBRH7QE+8gd5hmUYClgBRjMRvvuk8g6NnGiTNrvlIKVmgB+xG8=
=dsvd
-----END PGP SIGNATURE-----

--ufNrFSjcZLO8PioW--
