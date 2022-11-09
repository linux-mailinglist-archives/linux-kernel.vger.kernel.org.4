Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B09162319F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 18:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbiKIRkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 12:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiKIRkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:40:08 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CBFFCF7;
        Wed,  9 Nov 2022 09:40:07 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id k2so48821340ejr.2;
        Wed, 09 Nov 2022 09:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fS35qcO+3i+yhgDgBY53vbObhAkvDaFM3P89fHFHH9w=;
        b=VmPlQ8XxPbRAjyiuyAV7Ol91xALQXQUcdVYb9y6teAiErG0FMloo8tViVc+H9vgcvD
         GTqU7y8E5zDQXVGAeq39o94z+qP+b+ytThDTjNQgGRl7sYhKtjFEZTXKeXZClCm8EryQ
         bqRZfQc0qWNNWebO546uFSgyCdvNadjb7lvwOLackyj2twAnIYzeeg2XC7T8D7ymkTWN
         0vf8aSlifrq6t0zUg7Abl2HGo7PEdvcnHeoH1HCBIoSBugyepc1cEvLx4JOFBSkxd5K7
         hBEsb+Cbk8nr8OOHnPWOiKxa0o7RlfV/64XtjCE67rh3cITZWodyblFx2TbnkS2NTAH2
         u4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fS35qcO+3i+yhgDgBY53vbObhAkvDaFM3P89fHFHH9w=;
        b=C9CnFsvhaTbb2aUEXXGyDRGeyNCq7eHp6KGLkMwgsjVQnfi2T/06kL1QdZjx8YcAk0
         lPRcUvtYmYGvk7JLuhvTls4l2dCDzZzrcBZnW7yQfM/W6aTC52Us2tmgHQatF1nEZ9TX
         FpxWT7evsojTGxpMrCRM0lHm66cFGaMxM51BmLHwtZ4TUEN8sb+mCioMUJKoaVpUeglc
         d3tya8aOyQp7S6qH8sjpbQBVGJhSYMGb7Bfek8fz9636O+qxxLooUfgpHUdw9MyzVyt8
         hBs77GeStlJWTO0I3G/trXGzCl4kd2LnVmecPA2YrbEpEdpnv8a3QtwGmvTsCfRlHHN0
         tbzg==
X-Gm-Message-State: ANoB5plMMS9UdVo3SNe97OP5a0rPzjQp1c8Nh1AxCmqEYmiYIsYd9PvG
        iKNwpkehJupXbfalmPQ05kLnKDyoRcg=
X-Google-Smtp-Source: AA0mqf4EqGjkNVg2cvyJugGf0H/v8jUfhqn2abLvKNW8GivQKU2zdRsA1XO+uz+uTHNu+/Rkv7s/9w==
X-Received: by 2002:a17:907:1ca7:b0:7ad:9227:5288 with SMTP id nb39-20020a1709071ca700b007ad92275288mr5895265ejc.62.1668015605391;
        Wed, 09 Nov 2022 09:40:05 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id w19-20020a1709064a1300b007ad9adabcd4sm6057348eju.213.2022.11.09.09.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 09:40:04 -0800 (PST)
Date:   Wed, 9 Nov 2022 18:40:02 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 0/6] pinctrl: intel: Enable PWM optional feature
Message-ID: <Y2vl8qXwGOXaky/a@orome>
References: <20221108142226.63161-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pOi3QDJEMNTlIz2b"
Content-Disposition: inline
In-Reply-To: <20221108142226.63161-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pOi3QDJEMNTlIz2b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 08, 2022 at 04:22:20PM +0200, Andy Shevchenko wrote:
> This is a continuation of the previously applied PWM LPSS cleanup series.
> Now, we would like to enable PWM optional feature that may be embedded
> into Intel pin control IPs (starting from Sky Lake platforms).
>=20
> I would like to route this via Intel pin control tree with issuing
> an immutable branch for both PINCTRL and PWM subsystems, but I'm
> open for other suggestions.

I don't have any objections for this to go through the Intel tree as
long as Uwe is happy with this. Most of this is just reworking existing
things and the stub additions look good to me, so:

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--pOi3QDJEMNTlIz2b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNr5fAACgkQ3SOs138+
s6EXTBAAhbQKYq85APX7HgdxOftsNMR6LQ7jXDMabYNTZgOvOk3E1B/jvMyaibfM
pnQHQ/k/1WC4BUCZhdf9jl4ZOdeeo5P3M1UopeBuN0/yxnGteomPg8NIH+ZoaHEw
4YYE5pI2m50VnvmwUk+9lv3Tq3reueRpgm7d1DL2ZwulSOiYZW5O3aDcOl2xBQ21
Rf+TkP6ViLuLAuf34JGvPiPYJ0lvt7wbznKv2GfuNM8rULEwpFs4NOG/xsRh4DCg
BZzGGiz6G08WOF69/yrmCujoOs0kI9ngTejdGffyrrnxCf9o/8sI6EaXrI8Csfbz
nks7ylQnamqPnlmUMMfpvbaNHnH6iYBUZZlAsxd+uNsBTbdPcuVHsmlGX1TlMcCR
426mqg4OBD7biUdvMfyeWlS/RLguYZ8REiYrMAXHY6kcnrRgq75fbOtszeOZiNdA
BB6nTaOVFC/WwNAzR0AyZg04Yf0iT+tncgC5G0H09NDt9VIq2mzQH8knKDslSWou
Ouh/ONk3LP2+9V4DkY9T56Gv+Ta2AsEWm2JyRDgCCQ6Cr4ZdwQmHFrOzKzaKsdjH
rzczXgnNZnPjHulo65ELLVCDIEosSROWUUQDBDtOFbdsj/GLWSZ+wepE/Tq/Q24A
ai5FKWk4EQWCAYCnw9HejACdRGK5C76rtThsz59Fkd3JjCpY5jA=
=aEKE
-----END PGP SIGNATURE-----

--pOi3QDJEMNTlIz2b--
