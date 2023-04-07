Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D766DB0E2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 18:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjDGQtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 12:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDGQtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 12:49:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1CC55B4;
        Fri,  7 Apr 2023 09:49:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 693CF6491C;
        Fri,  7 Apr 2023 16:49:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32574C433D2;
        Fri,  7 Apr 2023 16:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680886159;
        bh=4HKBIPFhPPDgU4aF8D6qWLYO5fCK5p9eE9TdUcW49Uc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jXndUwOuLAonw/q6xTYjCQKFR8BTA7BaKmKRUXwxHp5FHJ/mjpYl+3R0R4nEdJug4
         iUf2I/5o40UoMDkePZfChX5rE5zg2ZwYb4CVT2Z1F7U2MFvcLJ+ZySgBN0zSpyJddz
         sUxtNXIiZqw9W1phzZ7L5zkMWUayysyPuMuLKm29Nr4aaV4GfQ7SLRlXkEpCu8xDCM
         Ut/61nuqMJQMFIR5BCFRJGKTBgWAJ/HPP7OJwON4cpVFFpBuHczOVF4UnaXvcHWd7E
         BJw4MW1ZEqaNlCiOKEvtrDDXfo7MuGAvtQOSvEQ0Tqctvh3lC9T6r21FbJ5LDG/80W
         MAnDGIn5l6NQg==
Date:   Fri, 7 Apr 2023 18:04:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Patrik =?UTF-8?B?RGFobHN0csO2bQ==?= <risca@dalakolonin.se>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        pgoudagunta@nvidia.com, hns@goldelico.com, lars@metafoo.de,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH v3 0/7] iio: adc: palmas_gpadc: add iio events
Message-ID: <20230407180435.048a8636@jic23-huawei>
In-Reply-To: <20230405212233.4167986-1-risca@dalakolonin.se>
References: <20230405212233.4167986-1-risca@dalakolonin.se>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  5 Apr 2023 23:22:26 +0200
Patrik Dahlstr=C3=B6m <risca@dalakolonin.se> wrote:

> This series is based on linux-next/master [1] and [2].
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
> found at [3].
>=20
> V2 -> V3:
> * Rebased to linux-next.

As per reply to the earlier thread.  Don't base on linux-next.
It can be very unstable though not so much later in a cycle like this.

If there isn't a lot of churn going on in the driver, fine to base on
previous release kernel or rc1 (good to say if it is an rc1)

If there is churn underway (which is true here) then iio/togreg + extra
patches lists that need to be applied listed in this cover letter.

I'm also fine with you just adding the devm patch to this series as
the first patch.

Jonathan



> * Avoid reconfiguring events on error and when old =3D=3D new value.
> V1 -> V2:
> * Begin by removing adc_wakeupX_data instead of doing it last.
> * Split changes in smaller patches
>=20
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> [2] https://lore.kernel.org/linux-iio/20230318163039.56115-1-jic23@kernel=
.org/
> [3] https://github.com/Risca/pyra_vol_mon
>=20
> Patrik Dahlstr=C3=B6m (7):
>   iio: adc: palmas: remove adc_wakeupX_data
>   iio: adc: palmas: replace "wakeup" with "event"
>   iio: adc: palmas: use iio_event_direction for threshold polarity
>   iio: adc: palmas: move eventX_enable into palmas_adc_event
>   iio: adc: palmas: always reset events on unload
>   iio: adc: palmas: add support for iio threshold events
>   iio: adc: palmas: don't alter event config on suspend/resume
>=20
>  drivers/iio/adc/palmas_gpadc.c | 559 +++++++++++++++++++++++++++------
>  include/linux/mfd/palmas.h     |   8 -
>  2 files changed, 464 insertions(+), 103 deletions(-)
>=20
>=20
> base-commit: 8417c8f5007bf4567ccffda850a3157c7d905f67
> prerequisite-patch-id: b0418c707db13f514400956596e9ebe91c25bba0

