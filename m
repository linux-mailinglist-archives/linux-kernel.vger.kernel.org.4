Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F236F32D8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 17:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjEAP0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 11:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjEAP0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 11:26:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F301720
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 08:26:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ptVQA-0007EC-Hf; Mon, 01 May 2023 17:26:34 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ptVQ9-000O1a-2f; Mon, 01 May 2023 17:26:33 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ptVQ8-000P7k-A7; Mon, 01 May 2023 17:26:32 +0200
Date:   Mon, 1 May 2023 17:26:32 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>, mchehab@kernel.org,
        bleung@chromium.org, groeck@chromium.org,
        kevin.chiu.17802@gmail.com,
        scott_chao@wistron.corp-partner.google.com,
        zoey_wu@wistron.corp-partner.google.com,
        hellojacky0226@hotmail.com, linux-media@vger.kernel.org,
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH AUTOSEL 6.3 34/44] media: cros-ec-cec: Don't exit early
 in .remove() callback
Message-ID: <20230501152632.ccsvhl2c6ihuizcf@pengutronix.de>
References: <20230501025632.3253067-1-sashal@kernel.org>
 <20230501025632.3253067-34-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7n6mydw3ndx43nto"
Content-Disposition: inline
In-Reply-To: <20230501025632.3253067-34-sashal@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7n6mydw3ndx43nto
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Apr 30, 2023 at 10:56:22PM -0400, Sasha Levin wrote:
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> [ Upstream commit 0ff7aee24e47beb4306ce050824b54147f2fabfa ]
>=20
> Exiting early in remove without releasing all acquired resources yields
> leaks. Note that e.g. memory allocated with devm_zalloc() is freed after
> .remove() returns, even if the return code was negative.
>=20
> While blocking_notifier_chain_unregister() won't fail and so the
> change is somewhat cosmetic, platform driver's .remove callbacks are
> about to be converted to return void. To prepare that, keep the error
> message but don't return early.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

While I'm positive this change doesn't break anything, it also doesn't
fix anything and is only cosmetic (+ preparing a later change).

Unless you need it as a dependency I'd say, don't backport it for
stable.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7n6mydw3ndx43nto
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRP2icACgkQj4D7WH0S
/k70oAgAn7tp2vPVovwRlg3jKhuBdr8BCobUMxPTkbPEHGq+hDgwuQ1p+b+xkPtA
qpSKLrNcHMS0dyEfk1xoyDmtmnpb3djmOSRzKYEBui3MrOSGaVVhL0rW76LgchEw
+Wnu0m5OFMiXGSFYKLfYDJFtxdTTBjTSHqu1J+LI9o7QaEMq8cGJfs/FK89JVzZB
RglMHrsbeYwFvrz38ZjC4HkvVWahW0+iAaG0BYSEb5WloXNgFHfkZh5bsu2GCHQZ
e87YJFBrojXMtHoVN5hwebZaoHp5QSKCkTa3Vp0AW7yhdJDmRPylGk8WJx48f5tR
ue9PHkoCzMFqDh6BpkruIyDw7LSwYw==
=Sfi2
-----END PGP SIGNATURE-----

--7n6mydw3ndx43nto--
