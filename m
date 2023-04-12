Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99846DFF94
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 22:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjDLUWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 16:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDLUWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:22:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0CB5586;
        Wed, 12 Apr 2023 13:22:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 605E1633C2;
        Wed, 12 Apr 2023 20:22:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CBDC433D2;
        Wed, 12 Apr 2023 20:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681330936;
        bh=A8Ztthf5vpIeWzvIFyeemrhpgL0mny/z5Tc424nFPW8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n4Et6VbZkBD7rIBP4456XXnbgLf123tNC4vbd/ZaVbIiStGchi+gfwbWFQsQx6RzJ
         aKrL5OHYknG4E1+3B4ldpNBFYkZnRlDp2i58AkHxYCEAfNyqQKqnEai7FdvsMJOpwK
         dTFy8WNOhidzyvT10Tntb4d+FiwcHR4ozNHDZzvAwCJ2kdPuCG62Gzu4TkBbojRVND
         Vu551a29x2dT+JEk2guShMcYm+xCECfSni860X5Pax6mzEff/GEMODswLHMXCRZwgT
         tMUNv4+Ls35wYGRdDWtRH94p8Pr22j1h8+ZCZQ/9xyZJPDf39BJmem8YLkWPI84yfZ
         /W5iHLP9pvxHg==
Date:   Wed, 12 Apr 2023 21:22:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Patrik =?UTF-8?B?RGFobHN0csO2bQ==?= <risca@dalakolonin.se>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        pgoudagunta@nvidia.com, hns@goldelico.com, lars@metafoo.de,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH v4 0/9] iio: adc: palmas_gpadc: add iio events
Message-ID: <20230412212213.614c9683@jic23-huawei>
In-Reply-To: <20230408114825.824505-1-risca@dalakolonin.se>
References: <20230408114825.824505-1-risca@dalakolonin.se>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  8 Apr 2023 13:48:16 +0200
Patrik Dahlstr=C3=B6m <risca@dalakolonin.se> wrote:

Hi Patrik,

Patches 3-9 applied from this posting to the togreg branch of iio.git
which will initially be pushed out as testing so 0-day can poke at it
tomorrow.

Thanks,

Jonathan


> This series is based on iio/togreg [1] and includes one patch ("fix NULL
> dereference on rmmod") which is already in linux-next and another patch
> from Jonathan Cameron ("Take probe fully device managed") to make the
> rest of the patches apply cleanly to iio/togreg.
>=20
> The palmas gpadc block has support for monitoring up to 2 ADC channels
> and issue an interrupt if they reach past a set threshold. This can be
> configured statically with device tree today, but it only gets enabled
> when reaching sleep mode. Also, it doesn't look like anyone is using it.
>=20
> Instead of this one special case, change the code so userspace can
> configure the ADC channels to their own needs through the iio events
> subsystem. The high and low threshold values can be set for every
> channel, but only 2 thresholds can be enabled at a time. Trying to
> enable more than 2 thresholds will result in an error.
>=20
> The configured thresholds will wake up the system from sleep mode if
> wakeup is enabled in /sys/devices/.../power/wakeup.
>=20
> The old platform data was removed.
>=20
> Thresholds, events, and wakeup were tested on omap5-uevm board. It wakes
> up from sleep mode when wakeup is enabled and a threshold is passed. A
> userspace tool for monitoring events and adjusting thresholds can be
> found at [2].
>=20
> For more background and the use case for these patches, see [3].
>=20
> V3 -> V4:
> * Reabased to iio/togreg and included required patches.
> * Avoid initializing variables unnecessarily.
> * Minor cosmetic fixes to comments.
> V2 -> V3:
> * Rebased to linux-next.
> * Avoid reconfiguring events on error and when old =3D=3D new value.
> V1 -> V2:
> * Begin by removing adc_wakeupX_data instead of doing it last.
> * Split changes in smaller patches
>=20
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
> [2] https://github.com/Risca/pyra_vol_mon
> [3] https://pyra-handheld.com/boards/threads/improve-volume-wheel-daemon-=
bounty.99430/post-1711410
>=20
> Jonathan Cameron (1):
>   iio: adc: palmas: Take probe fully device managed.
>=20
> Patrik Dahlstr=C3=B6m (8):
>   iio: adc: palmas_gpadc: fix NULL dereference on rmmod
>   iio: adc: palmas: remove adc_wakeupX_data
>   iio: adc: palmas: replace "wakeup" with "event"
>   iio: adc: palmas: use iio_event_direction for threshold polarity
>   iio: adc: palmas: move eventX_enable into palmas_adc_event
>   iio: adc: palmas: always reset events on unload
>   iio: adc: palmas: add support for iio threshold events
>   iio: adc: palmas: don't alter event config on suspend/resume
>=20
>  drivers/iio/adc/palmas_gpadc.c | 616 +++++++++++++++++++++++++--------
>  include/linux/mfd/palmas.h     |   8 -
>  2 files changed, 478 insertions(+), 146 deletions(-)
>=20
>=20
> base-commit: f73df43e957a6fc705a9bd6d143585bdf1b13365

