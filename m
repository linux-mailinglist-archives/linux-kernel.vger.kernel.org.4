Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D526C73436B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 22:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbjFQUFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 16:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjFQUFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 16:05:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99451705;
        Sat, 17 Jun 2023 13:05:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5346160B2C;
        Sat, 17 Jun 2023 20:05:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45632C433C8;
        Sat, 17 Jun 2023 20:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687032306;
        bh=bs1M1kIjvcmJN2blNp9wB7eBOWior7iGs149ew2cJu0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AIdENEPQB8QHJzcoY2CyQYKb+U/m5G0tCVObLEB29rEwm3jG3B43UUft9JFyf1+7q
         GgN3/3SqvSG3chZ9C3u2KjFcXND4Hch6vd3s9cvJXdEJavFVqlYfTHEOoWVYLmSRsQ
         j0CQUiTy0y86Yf2M1Ms8VbesTuoC9xha4lX2YrnwTtrrTFqVi/W8oWTj1E+l5qECxT
         KCPJtvdoSD6Bc/sINxBHQ5njnDAxJ8gTccntCSUyBSs4KkJFU2ecm7Z9xJxtvm5A5f
         6uaVSBAUatmC+MsED6WwFNygPLq0pyM0o9KyJ2VZo7mJEI1hd6jRGmEIXFLB1bbcIM
         wkBIK1amhK2ig==
Date:   Sat, 17 Jun 2023 21:05:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Astrid Rost <astrid.rost@axis.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Uwe =?UTF-8?B?S2xlaW5l?= =?UTF-8?B?LUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: Re: [PATCH v6 0/8]  iio: light: vcnl4000: Add features for
 vncl4040/4200
Message-ID: <20230617210502.763ad646@jic23-huawei>
In-Reply-To: <20230613135025.2596641-1-astrid.rost@axis.com>
References: <20230613135025.2596641-1-astrid.rost@axis.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2023 15:50:16 +0200
Astrid Rost <astrid.rost@axis.com> wrote:

> Add a more complete support for vncl4040 and vcnl4200, which allows to
> change the distance of proximity detection and interrupt support for the
> illuminance sensor.
Series applied to the togreg branch of iio.git and pushed out as testing
for 0-day to see if it can find anything we missed.

Note that I don't plan another pull request this cycle, so this is now
material for 6.6 and I'll be rebasing the tree after 6.5-rc1 is out.

Thanks,

Jonathan

>=20
> Proximity functionality:
>   - Interrupt support (new on vcnl4200).
>=20
> Proximity reduce the amount of interrupts:
>   - Adaptable integration time (new on vcnl4200) - the sampling rate
>     changes according to this value.
>   - Period - interrupt is asserted if the value is above or
>     below a certain threshold.
>=20
> Proximity change the activity distance:
>   - Oversampling ratio - Amount of LED pulses per measured raw value.
>   - Calibration bias - LED current calibration of the sensor.
>=20
> Illuminance functionality:
>   - Interrupt support.
>=20
> Illuminance reduce the amount of interrupts:
>   - Adaptable integration time - the sampling rate and scale changes
>     according to this value.
>   - Period =E2=80=93 interrupt is asserted if the value is above or
>     below a certain threshold.
>=20
> changes v2:
> - [PATCH v2 3/7] Fixed calculation of al_scale.
>   Fix the value of vcnl4040 according to the data-sheet.
>   Use div_u64 for the division.
> scription for the branch
>=20
> changes v3:
> - [PATCH v3 1-3/7] Add differences between the chips as variables in
>   chip-spec.
> - [PATCH v3 4/7] Changed commit message.
> - [PATCH v3 5/7] Use period instead of debounce time. This causes some
>   calculations as the period is a time and the chip allows to set a certa=
in
>   amount of measurements above/below the threshold, before throwing an
>   interrupt.
> - [PATCH v3 6/7] Changed commit message.
>=20
> changes v4:
> - [PATCH v3 1-3/7] Fix setting correct als_it for vcnl4040.
> - [PATCH v3 5/7] Use MICRO macro.
>   Fix values greater than 1 s for the proximity period.
>=20
> changes v5:
> [PATCH v5 2/7]:
> - Calculate ps_it from ps_it_times by usinh NSEC_PER_USEC.
> [PATCH v5 3/7]:
> - Calculate als_it from ps_it_times by using NSEC_PER_USEC.
> - Store scale step factor in chip_spec.
> - Fixes sampling_rate to ns + 20 %.
> [PATCH v5 3/7 - 7/7]
> - Changed formatting.
> - Changed some variable names.
>=20
> - [PATCH v3 4/7] Changed commit message.
> - [PATCH v3 5/7] Use period instead of debounce time. This causes some
>   calculations as the period is a time and the chip allows to set a certa=
in
>   amount of measurements above/below the threshold, before throwing an
>   interrupt.
> - [PATCH v3 6/7] Changed commit message.
>=20
> changes v4:
> - [PATCH v3 1-3/7] Fix setting correct als_it for vcnl4040.
> - [PATCH v3 5/7] Use MICRO macro.
>   Fix values greater than 1 s for the proximity period.
>=20
> changes v5:
> [PATCH v5 2/7]:
> - Calculate ps_it from ps_it_times by usinh NSEC_PER_USEC.
> [PATCH v5 3/7]:
> - Calculate als_it from ps_it_times by using NSEC_PER_USEC.
> - Store scale step factor in chip_spec.
> - Fixes sampling_rate to ns + 20 %.
> [PATCH v5 3/7 - 7/7]
> - Changed formatting.
> - Changed some variable names.
>=20
> changes v6:
> Added [PATCH v6 3/8]:
> - Add switch case for IIO_PROXIMITY check.
>  [PATCH v5 1/7 - 7/7]
> - Changed formatting.
> [PATCH v5 3/7, 5/7, 6/7, 7/7]
> - Changed loop.
> - Changed some variable names.
>=20
> Astrid Rost (8):
>   [PATCH v6 1/8] iio: light: vcnl4000: Add proximity irq for vcnl4200
>   [PATCH v6 2/8] iio: light: vcnl4000: Add proximity ps_it for vcnl4200
>   [PATCH v6 3/8] iio: light: vcnl4000: Check type with switch case
>   [PATCH v6 4/8] iio: light: vcnl4000: Add als_it for vcnl4040/4200
>   [PATCH v6 5/8] iio: light: vcnl4000: add illuminance irq vcnl4040/4200
>   [PATCH v6 6/8] iio: light: vcnl4000: Add period for vcnl4040/4200
>   [PATCH v6 7/8] iio: light: vcnl4000: Add oversampling_ratio for 4040/42=
00
>   [PATCH v6 8/8] iio: light: vcnl4000: Add calibration bias for 4040/4200
>=20
>  drivers/iio/light/vcnl4000.c | 710 +++++++++++++++++++++++++++++++----
>  1 file changed, 643 insertions(+), 67 deletions(-)
>=20

