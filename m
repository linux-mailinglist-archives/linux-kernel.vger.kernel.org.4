Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F286A501D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 01:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjB1AXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 19:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjB1AXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 19:23:50 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14AA1E2AB;
        Mon, 27 Feb 2023 16:23:49 -0800 (PST)
Received: from mercury (unknown [185.209.196.169])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 92CB36602E18;
        Tue, 28 Feb 2023 00:23:47 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677543827;
        bh=oXEKOn7iMMnzaNsM9g/DYP00/n/Evw8fsCYa7aws5ew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qi0ckDoYnH2gAEc+stFHGjNuCKUsaKIKcaEkgesjYDcAACjpmluRVnwDC5rlYpWQk
         Jc6FJySkLPRHVVtS0vkOFXZwPB52UXDH/X3ReTH9FMgov/zAwRurq4naLNAKyoDnxk
         Zv2eWn4MNV2ZXJWluNm6PeRg7BNlYI0ri71BW5pFqi1UqTC1JPc6hV8+NJM0fUFvo9
         mXrJoPKLBBMjnLoeLk4Ctry5hOkIkTnVMp0UwJBP7yo1oUUFAXI0e0AawdE/YA0AOo
         1RFO3OKXWxjJMXJ/gLxe95M127+O99n/3woA/mi3u4A1bbM0CQFXie3TFo9Ky9lLv7
         +L9fknQQN159g==
Received: by mercury (Postfix, from userid 1000)
        id 4625D1061609; Tue, 28 Feb 2023 01:23:45 +0100 (CET)
Date:   Tue, 28 Feb 2023 01:23:45 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>
Cc:     Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@google.com
Subject: Re: [RESEND 1/2] power_supply: Register cooling device outside of
 probe
Message-ID: <20230228002345.625uaporcmcf7kfx@mercury.elektranox.org>
References: <20220531183054.6476-1-quic_manafm@quicinc.com>
 <20220609221224.t5k7i4w4dfjza5xc@mercury.elektranox.org>
 <fd372789-d39e-08f9-ae44-7702733155ae@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xx2ed7bvmhyopstz"
Content-Disposition: inline
In-Reply-To: <fd372789-d39e-08f9-ae44-7702733155ae@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xx2ed7bvmhyopstz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 27, 2023 at 01:46:52PM -0800, Subbaraman Narayanamurthy wrote:
> On 6/9/22 3:12 PM, Sebastian Reichel wrote:
> > Hi,
> >
> > On Wed, Jun 01, 2022 at 12:00:53AM +0530, Manaf Meethalavalappu Palliku=
nhi wrote:
> >> Registering the cooling device from the probe can result in the
> >> execution of get_property() function before it gets initialized.
> >>
> >> To avoid this, register the cooling device from a workqueue
> >> instead of registering in the probe.
> >>
> >> Signed-off-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.c=
om>
> >> ---
> > This removes error handling from the psy_register_cooler() call, so
> > it introduces a new potential problem. If power_supply_get_property()
> > is called to early -EAGAIN is returned. So can you elaborate the problem
> > that you are seeing with the current code?
> >
> > -- Sebastian
>=20
> When the device boots up with all the vendor modules getting loaded,=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
> here is what we're seeing when booting up with 6.1.11 recently. First=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0
> log is printed with adding a pr_err() in __power_supply_register().=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0
> [=A0=A0=A0 7.008938][=A0 T682] power_supply battery: psy_register_cooler =
failed, rc=3D-11
> [=A0=A0=A0 7.030941][=A0 T682] qti_battery_charger: probe of qcom,battery=
_charger failed with error -11
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0
> Here, our downstream qti_battery_charger driver exposes the following=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0
> power supply properties POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT and=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
> POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX under a power supply device.=
=A0=A0=A0=A0=A0=A0=A0=A0
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0
> This is happening because of the following call sequence,=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0
> battery_chg_probe() ->=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
> =A0 power_supply_register() ->=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
> =A0=A0=A0 psy_register_cooler() ->=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
> =A0=A0=A0=A0=A0 thermal_cooling_device_register() ->=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0
> =A0=A0=A0=A0=A0=A0=A0 cdev->ops->get_max_state() ->=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
> =A0=A0=A0=A0=A0=A0=A0=A0=A0 ps_get_max_charge_cntl_limit() ->=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 power_supply_get_property()=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0
> ends up calling power_supply_get_property() to read CHARGE_CONTROL_LIMIT=
=A0=A0=A0=A0=A0=A0=A0
> property.=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0
> However, it returns -EAGAIN because psy->initialized is set to true=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
> later after psy_register_cooler() succeeds. So, this ends up in a=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
> driver probe failure forever.

This should be solved in 6.3:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/d=
rivers/power/supply/power_supply_core.c?id=3Dc85c191694cb1cf290b11059b3d2de=
8a2732ffd0

-- Sebastian

--xx2ed7bvmhyopstz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmP9SY4ACgkQ2O7X88g7
+poV0w//UsUh2QE6JW/3M0lLBH/6QBcjOvQJ/udor30sabFMNOZ39IeAT5PiuiwS
QBbu6PvAo67bCgVq6bBGC6T+8wxDm2MIbizC/J/o5Sz9/yFikgElT7uB//Zh8h6n
hHvEENwQFbzyd9HQXlQnm4jmKDEQJd5btiImMJz9/VnUU3f1pwIXPCr7uOaQZ77z
1YaySP5CgM1s3QMVW8HnYsCct+9r82es110B/oy6y79qJIUAosKe8/O9YJ+pfrkI
MBtjNuEnz8DRsysn3MYn6wRDb3xejLsZTSJrAB6q/cSRJtlcBQEnUcs4Bsxpl0mh
IfB/CBuvCF0SHVbXTH9hnPCixiR0x2FYMtFtrkbpCpNEjOjpnj65Ioy/QaAMNWrD
QhnNgqIA+ubFCNxvDAINekRZa58AvZjLOld0vVB5l+arAelznpek07L2N04E8Ge2
L6xY6XEEGinLtGiyeG7LKh5WMayu+WfHwQmwJ4RqlX8iAhfe8R238dp683H+2ySs
ickGBck62flgscnG9T3vJMCnSLOdENRNKoYEIxfMdMSxNnQJVyjDY3B7XRVb3gXC
J6uoPF3eblbYKO77M7EDuTyOXVHFDFJ4TaXGfodji5qdRgZ6Q7Ac26GIjQOeEiHL
se8ZZIZc/cN+AA5/Q28sqqTvg/beAnrRrvHs1uMOMaZxM++EXj4=
=8kww
-----END PGP SIGNATURE-----

--xx2ed7bvmhyopstz--
