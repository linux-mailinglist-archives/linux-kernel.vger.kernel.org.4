Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7FA74D278
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjGJKAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjGJJ7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:59:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534112695
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:58:17 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qIneV-0006xt-D8; Mon, 10 Jul 2023 11:57:55 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 31B751ECD02;
        Mon, 10 Jul 2023 09:57:52 +0000 (UTC)
Date:   Mon, 10 Jul 2023 11:57:51 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Judith Mendez <jm@ti.com>
Cc:     Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Schuyler Patton <spatton@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH v10 0/2] Enable multiple MCAN on AM62x
Message-ID: <20230710-overheat-ruined-12d17707e324-mkl@pengutronix.de>
References: <20230707204714.62964-1-jm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="scrncn37d33goitk"
Content-Disposition: inline
In-Reply-To: <20230707204714.62964-1-jm@ti.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--scrncn37d33goitk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 07.07.2023 15:47:12, Judith Mendez wrote:
> On AM62x there are two MCANs in MCU domain. The MCANs in MCU domain
> were not enabled since there is no hardware interrupt routed to A53
> GIC interrupt controller. Therefore A53 Linux cannot be interrupted
> by MCU MCANs.
>=20
> This solution instantiates a hrtimer with 1 ms polling interval
> for MCAN device when there is no hardware interrupt property in
> DTB MCAN node. The hrtimer generates a recurring software interrupt
> which allows to call the isr. The isr will check if there is pending
> transaction by reading a register and proceed normally if there is.
> MCANs with hardware interrupt routed to A53 Linux will continue to
> use the hardware interrupt as expected.
>=20
> Timer polling method was tested on both classic CAN and CAN-FD
> at 125 KBPS, 250 KBPS, 1 MBPS and 2.5 MBPS with 4 MBPS bitrate
> switching.
>=20
> Letency and CPU load benchmarks were tested on 3x MCAN on AM62x.

Latency

> 1 MBPS timer polling interval is the better timer polling interval
> since it has comparable latency to hardware interrupt with the worse
> case being 1ms + CAN frame propagation time and CPU load is not
> substantial. Latency can be improved further with less than 1 ms
> polling intervals, howerver it is at the cost of CPU usage since CPU

However

> load increases at 0.5 ms.
>=20
> Note that in terms of power, enabling MCU MCANs with timer-polling
> implementation might have negative impact since we will have to wake
> up every 1 ms whether there are CAN packets pending in the RX FIFO or
> not. This might prevent the CPU from entering into deeper idle states
> for extended periods of time.
>=20
> v9:
> Link: https://lore.kernel.org/linux-can/20230419223323.20384-1-jm@ti.com/=
T/#t
>=20
> v8:
> Link: https://lore.kernel.org/linux-can/20230530224820.303619-1-jm@ti.com=
/T/#t
>=20
> v7:
> Link: https://lore.kernel.org/linux-can/20230523023749.4526-1-jm@ti.com/T=
/#t
>=20
> v6:
> Link: https://lore.kernel.org/linux-can/20230518193613.15185-1-jm@ti.com/=
T/#t
>=20
> v5:
> Link: https://lore.kernel.org/linux-can/20230510202952.27111-1-jm@ti.com/=
T/#t
>=20
> v4:
> Link: https://lore.kernel.org/linux-can/c3395692-7dbf-19b2-bd3f-31ba86fa4=
ac9@linaro.org/T/#t

The link doesn't point to v4, fixed.

> v2:
> Link: https://lore.kernel.org/linux-can/20230424195402.516-1-jm@ti.com/T/=
#t
>=20
> V1:
> Link: https://lore.kernel.org/linux-can/19d8ae7f-7b74-a869-a818-93b74d106=
709@ti.com/T/#t

Was there a v1? That link doesn't point to it, removed.

>=20
> RFC:
> Link: https://lore.kernel.org/linux-can/52a37e51-4143-9017-42ee-8d17c6702=
8e3@ti.com/T/#t

Doesn't point to RFC, fixed.

Applied to linux-can-next/testing.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--scrncn37d33goitk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmSr1hwACgkQvlAcSiqK
BOhHqwgAstPyKnj9LCXokgj8mdcICYHPuXIsk0LtOYpArWkekPcaAJgv6u4sBjlT
HhHksfmbomzyYUmbwfm3lynXBFRJoHacN8oXfiDBv6DwXVJNyGqFq77GqezyJTTv
9TNbSartJEYnRSgHuzWiVr5OzPqmCq/kL4Lv5J2OV6yjFCF8spG/bcxbt0tv6KYp
J2/24b884jYeHEKZ+2rjUiKBphXZd0A7Uo0qsjVE86hVKsuh1ng43bQ4Oj16layp
DexZYAZK4ODY+kJxVRF9upZwXFgCRs8+zef4vMOytpjPF7ctkjnaBLiuA61gfj0C
JNPBYja4NGINDjk2KyztqsnVqBGffw==
=Y7y0
-----END PGP SIGNATURE-----

--scrncn37d33goitk--
