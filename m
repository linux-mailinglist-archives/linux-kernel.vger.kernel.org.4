Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446155ECF80
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 23:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbiI0VtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 17:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiI0VtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 17:49:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40E110C783;
        Tue, 27 Sep 2022 14:49:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C682861BA3;
        Tue, 27 Sep 2022 21:49:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36DAFC433C1;
        Tue, 27 Sep 2022 21:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664315352;
        bh=hIZZloxV/4NVdAyWJk4xcqHzdlPe7zVqfPE8pJG0+yk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VMOjYItNT9og7Wz978rlllZaeepZnjlROtCLYQ3Y2XytYxPigy5phFMnIYV3ITtYO
         dZIuW2KaapxjfXPumqQBEPFSuXxVk4j2Dz6CGJhkuiuTs2QchcjPuCle/NDE5rwRf/
         9uR1mi8VkIjmE7HKjbrJXXBiw2jZ9dzfdcvnOpBZc4Egmtse33Mq7Mv+9KmoXzNaSc
         TxFqI7C4GlRq/UCQ4W/nZWY5B0mowW6a2aFx73/OkA2JSoR254zhzdqg3SQwK21YGf
         NuMB6OPLAdkBqv2aDa2egqI+bNTi7yMslRRt/klv/jo2EFrulFbsjPR+8Co3dFBy2q
         AuNq2ny6vZ8oQ==
Date:   Tue, 27 Sep 2022 17:49:09 -0400
From:   William Breathitt Gray <wbg@kernel.org>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     william.gray@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mranostay@ti.com
Subject: Re: [PATCH v9 0/4] ECAP support on TI AM62x SoC
Message-ID: <YzNv1c1NyUv7xKVT@ishi>
References: <20220923142437.271328-1-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OgNSUDtuiixoyean"
Content-Disposition: inline
In-Reply-To: <20220923142437.271328-1-jpanis@baylibre.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OgNSUDtuiixoyean
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 23, 2022 at 04:24:33PM +0200, Julien Panis wrote:
> The Enhanced Capture (ECAP) module can be used to timestamp events
> detected on signal input pin. It can be used for time measurements
> of pulse train signals.
>=20
> ECAP module includes 4 timestamp capture registers. For all 4 sequenced
> timestamp capture events (0->1->2->3->0->...), edge polarity (falling/ris=
ing
> edge) can be selected.
>=20
> This driver leverages counter subsystem to :
> - select edge polarity for all 4 capture events (event mode)
> - log timestamps for each capture event
> Event polarity, and CAP0/1/2/3 timestamps give all the information
> about the input pulse train. Further information can easily be computed :
> period and/or duty cycle if frequency is constant, elapsed time between
> pulses, etc...
>=20
> This patchset must be applied on top of the following counter subsystem p=
atchset :
> https://lore.kernel.org/all/cover.1663693757.git.william.gray@linaro.org/
>=20
> Modifications since v8 :
> 	- Add documentation to private driver structure
> 	- Add mutex to prevent IO race conditions
> 	- Stop counter before disabling interrupts in ecap_cnt_capture_disable()=
 function
> 	- Remove returning of status in ecap_cnt_count_get/set_val() functions
> 	- Remove unnecessary 'return -EBUSY' in all callbacks
> 	- Remove unnecessary '.id =3D 0' in ecap_cnt_counts[]
> 	- Modify driver info in MAINTAINER file
>=20
> Userspace commands :
> 	### CLOCK SIGNAL ###
> 	cd /sys/bus/counter/devices/counter0/signal0
>=20
> 	# Get frequency
> 	cat frequency
>=20
> 	### INPUT SIGNAL ###
> 	cd /sys/bus/counter/devices/counter0/signal1
>=20
> 	# Get polarity for each capture event
> 	cat polarity0
> 	cat polarity1
> 	cat polarity2
> 	cat polarity3
>=20
> 	# Set polarity for each capture event
> 	echo positive > polarity0
> 	echo negative > polarity1
> 	echo positive > polarity2
> 	echo negative > polarity3
>=20
> 	### COUNT ###
> 	cd /sys/bus/counter/devices/counter0/count0
>=20
> 	# Get ceiling (counter max value)
> 	cat ceiling
>=20
> 	# Reset number of overflows & current timebase counter value
> 	echo 0 > num_overflows
> 	echo 0 > count
>=20
> 	# Run ECAP
> 	echo 1 > enable
>=20
> 	# Get number of overflows & current timebase counter value
> 	cat num_overflows
> 	cat count
>=20
> 	# Get captured timestamps
> 	cat capture0
> 	cat capture1
> 	cat capture2
> 	cat capture3
>=20
> 	# Note that counter watches can also be used to get
> 	# data from userspace application
> 	# -> see tools/counter/counter_example.c
>=20
> 	# Pause ECAP
> 	echo 0 > enable
>=20
> Julien Panis (4):
>   dt-bindings: counter: add ti,am62-ecap-capture.yaml
>   Documentation: ABI: sysfs-bus-counter: add frequency & num_overflows
>     items
>   counter: ti-ecap-capture: capture driver support for ECAP
>   MAINTAINERS: add TI ECAP driver info
>=20
>  Documentation/ABI/testing/sysfs-bus-counter   |  14 +
>  .../counter/ti,am62-ecap-capture.yaml         |  61 ++
>  MAINTAINERS                                   |   9 +
>  drivers/counter/Kconfig                       |  15 +
>  drivers/counter/Makefile                      |   1 +
>  drivers/counter/ti-ecap-capture.c             | 614 ++++++++++++++++++
>  6 files changed, 714 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/counter/ti,am62-eca=
p-capture.yaml
>  create mode 100644 drivers/counter/ti-ecap-capture.c
>=20
> --=20
> 2.37.3

Queued for counter-next with a minor context adjustment for
sysfs-bus-counter changes.

Thanks,

William Breathitt Gray

--OgNSUDtuiixoyean
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYzNv1QAKCRC1SFbKvhIj
KxxzAPsGsMhJL0tIsWdHhCHmfqbuV/FWDAIsiBqAyCIJko39jAD8CANWEJ7SWUvy
WXSa1cYdyoNSfp7TXgS2TbDpHa0Hzg8=
=NSgI
-----END PGP SIGNATURE-----

--OgNSUDtuiixoyean--
