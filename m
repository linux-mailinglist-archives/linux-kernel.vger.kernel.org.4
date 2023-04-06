Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA91B6D97CE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 15:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237695AbjDFNR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 09:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237743AbjDFNRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:17:53 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A2D8A50;
        Thu,  6 Apr 2023 06:17:48 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id 18so1315606ejo.13;
        Thu, 06 Apr 2023 06:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680787067;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STr5mxs5RV8iRWYSKMYXPKQ2lS+5JB8QNOUcHMFXDhg=;
        b=J0GukvVKQKRfWam4GDIa7AfSUSXlSx3aj45N/SAND/dvPAxwVAlFeFn2k28YiHfkwP
         spfCWsHjznApqj/UliTjMlL+bRH1jLAVUzqXtvdV0pee3/lpqmV+JeJBTUB32Uq6NdjJ
         KQK0RUoVpKiYU6mfPBQDLUfRXHpqdwP7YXyxoFL7JPSUESBvn0znThSEzdce6mGy2K98
         gCfVsO8+df6d3PAKrBYMcCgO2u3l7iCTJIjObhqeFteUR0REK80WSwCxLNP4GsIUWpzt
         7qgKXtRxJBN7l65z4OFtVFRSAfMsRFgbDxdElCyah+2aBMU+GljKW3sWQmklaNkgDCmF
         86Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680787067;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STr5mxs5RV8iRWYSKMYXPKQ2lS+5JB8QNOUcHMFXDhg=;
        b=psR2iTcmjfWXWokTLp696PfWiSxB8lyzw+S3UY6kmWuCuGMZS5gV0iNdHDkQU+RRHO
         NZ6OmayG934DHtq6eCZwgmTOqakMFhdqPowOwGlFK6Q9a3AaZAVszdv9M/sIVzQbMfh5
         XVgjRO7T4Vf9w646gIsn94U9U/tXJ64vdZ2CcXnMVeNN8UsgR8B9zTLOX8Br92p+hM2y
         1+IVIGio1EO2ovRWL/mOo8T1bfwWTcTVT9E2pk2yWhIvJzg56C5Amylahki213fTmuDz
         cpRAQVh9HK3GZIISN1U9RNZC7Pc3F6lZ1uYcapV4bFX9vZUaYMMC8YieGluAZ/uBSbvG
         uRYA==
X-Gm-Message-State: AAQBX9cYp5ox9kddH/v1jttbB0w83Qe2BmOAtOKp/L9gNt/qWWoXEj6L
        uQIZk/ZsKh7jV3C8jWwQOXQ=
X-Google-Smtp-Source: AKy350bbvL1i4GaljnmJb41yDPBIEPV2YrW8ha8fibxihrWLjWZ5ntbsQc1zFCPggGlhE02B0G4M6Q==
X-Received: by 2002:a17:906:1c49:b0:935:1565:d661 with SMTP id l9-20020a1709061c4900b009351565d661mr7225417ejg.66.1680787067367;
        Thu, 06 Apr 2023 06:17:47 -0700 (PDT)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 16-20020a170906021000b00949691d3183sm807239ejd.36.2023.04.06.06.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 06:17:46 -0700 (PDT)
Date:   Thu, 6 Apr 2023 15:17:45 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v15 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <ZC7GeXJbB9PAF0lb@orome>
References: <20230330071203.286972-1-conor.dooley@microchip.com>
 <20230330071203.286972-2-conor.dooley@microchip.com>
 <0b91dee7-6c1d-4a33-8235-8fd5d58b200e@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Wmv/6xuPkCm9WCnj"
Content-Disposition: inline
In-Reply-To: <0b91dee7-6c1d-4a33-8235-8fd5d58b200e@spud>
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


--Wmv/6xuPkCm9WCnj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 01, 2023 at 09:50:47PM +0100, Conor Dooley wrote:
> On Thu, Mar 30, 2023 at 08:12:03AM +0100, Conor Dooley wrote:
>=20
> > +	/*
> > +	 * Because 0xff is not a permitted value some error will seep into the
> > +	 * calculation of prescale as prescale grows. Specifically, this error
> > +	 * occurs where the remainder of the prescale calculation is less than
> > +	 * prescale.
> > +	 * For small values of prescale, only a handful of values will need
> > +	 * correction, but overall this applies to almost half of the valid
> > +	 * values for tmp.
> > +	 *
> > +	 * To keep the algorithm's decision making consistent, this case is
> > +	 * checked for and the simple solution is to, in these cases,
> > +	 * decrement prescale and check that the resulting value of period_st=
eps
> > +	 * is valid.
> > +	 *
> > +	 * period_steps can be computed from prescale:
> > +	 *                      period * clk_rate
> > +	 * period_steps =3D ----------------------------- - 1
> > +	 *                NSEC_PER_SEC * (prescale + 1)
> > +	 *
> > +	 */
> > +	if (tmp % (MCHPCOREPWM_PERIOD_STEPS_MAX + 1) < *prescale) {
>=20
> Hmm, looks like 32-bit doesn't like this modulus.
> I pushed things out for LKP to test before sending as I felt I'd not be
> allowed to do that operation, but got a build success email from it.
> I'm not sure why the mail wasn't sent as a reply to this, but
> <202304020410.A86IBNES-lkp@intel.com> complains:
> pwm-microchip-core.c:(.text+0x20a): undefined reference to `__aeabi_uldiv=
mod'
>=20
> I know that tmp < 65536 at this point, so if the general approach is
> fine, I can always cast it to a non 64-bit type without losing any
> information.

Since you already use some of the helpers from linux/math64.h, perhaps
you can use something like div_u64_rem() here?

Thierry

>=20
> > +		u16 smaller_prescale =3D *prescale - 1;
> > +
> > +		*period_steps =3D div_u64(tmp, smaller_prescale + 1) - 1;
> > +		if (*period_steps < 255) {
> > +			*prescale =3D smaller_prescale;
> > +
> > +			return 0;
> > +		}
> > +	}



--Wmv/6xuPkCm9WCnj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQuxnkACgkQ3SOs138+
s6FgvBAAv7hMz2KGQYKjhjDZiOF7EBFggWM0bmEOgVw8gCdcGbThvfvGS+VBsha1
6nP75xwxZIdn8mER/mAlqu2PXdaMFCzDCm75ZBBSZu9RFmAgdofBZey3Z+XQrcg8
REtkYo/szD9j9TmVmdZ2hO+zzmU+bu32/eb6KSnPKtDEIObymudlahac9stt+eI3
NOK7IMmPRLxVrKlQQ6tLXn45xd84STq1+gDLCVymKWpwD4zP+I9jOoDjsUtt/ip6
FoTg8uDeMSTWGuAcnsxZTG0pgexnOBDzeeI6l1Cq7Mv/q3dkFJpGvYL6OMOHGej9
rYu5RAIogdRq84FAeJKTfIKSxn5NGzod26NRbXr+nULTvaBx6WL6kLOrnGfgJlIP
1aNbzw+ITtG4ulJeoe5sXf7Ih5hy+trjPmxaAUqRCxn2i7IOZty+Uhb/BcBPec0R
TN9czr6YmBnyQ5SWjq0aqyJMEIfYQh0PK8tB/wbVZ5yjcsNt5cOQKoTe5lYSPPo4
5OsLIVOz8ZOv7iaYXOFIYm+Gnd4xocwxM2mKpvrCmpDWeNnE2+X5gWIsHxPOepSR
DJmnNadZShy4qAnAjNX8Ol6CBGM9ltCXWBpiD3Pqauc0IW0G/pJlw6ZmeS4ZWN24
Fj3dTjMi4PMMcbkuLNXDZvanVLJk0JvtBXauVHw1JB2KqEZ6nn4=
=EF8+
-----END PGP SIGNATURE-----

--Wmv/6xuPkCm9WCnj--
