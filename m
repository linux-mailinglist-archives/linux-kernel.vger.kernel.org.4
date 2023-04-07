Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE406DB101
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 18:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjDGQyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 12:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjDGQy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 12:54:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E721EAD25;
        Fri,  7 Apr 2023 09:54:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 797E161A2D;
        Fri,  7 Apr 2023 16:54:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D955C433A0;
        Fri,  7 Apr 2023 16:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680886465;
        bh=jzYiWqGmDKhKdoV1OI22S0EpcmnPG3H9nbZqDc6Qt9A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TQt56cfMAs9QWC2HBg7TmfJwrMnUhenKmjOfutykg+qy+1NfOxoieXqrOl7srerRC
         AQUVgX13cWClFs50qjd7+0t8+Dj95ce0EJgA+UPh/kaKWfUPzFThlI1nC2WJX/OED+
         ihGqN6UZUmIGeo9WL0siFzhqW9p8SQ/l+eHkpMxpVTJ7iXDWv31ZiDOtIqYwIzlv3F
         88GI5TIzhdyM1wyg91BbH6tkF0DzSm2QjDisI3BpIVUw+r7KoaPjnfbmthJpAz2E9w
         AtLwdPAYJK3pr7LxRusro9gr88CRjSe1cwxLTsyRZim0KVsT3FhZWG+YWGBXTChfeA
         5hwXJsBIPFjZw==
Date:   Fri, 7 Apr 2023 18:09:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Patrik =?UTF-8?B?RGFobHN0csO2bQ==?= <risca@dalakolonin.se>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        pgoudagunta@nvidia.com, hns@goldelico.com, lars@metafoo.de,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH v3 0/7] iio: adc: palmas_gpadc: add iio events
Message-ID: <20230407180941.2e79469e@jic23-huawei>
In-Reply-To: <20230407180435.048a8636@jic23-huawei>
References: <20230405212233.4167986-1-risca@dalakolonin.se>
        <20230407180435.048a8636@jic23-huawei>
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

On Fri, 7 Apr 2023 18:04:35 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed,  5 Apr 2023 23:22:26 +0200
> Patrik Dahlstr=C3=B6m <risca@dalakolonin.se> wrote:
>=20
> > This series is based on linux-next/master [1] and [2].
> >=20
> > The palmas gpadc block has support for monitoring up to 2 ADC channels
> > and issue an interrupt if they reach past a set threshold. This can be
> > configured statically with device tree today, but it only gets enabled
> > when reaching sleep mode. Also, it doesn't look like anyone is using it.
> >=20
> > Instead of this one special case, change the code so userspace can
> > configure the ADC channels to their own needs through the iio events
> > subsystem. The high and low threshold values can be set for every
> > channel, but only 2 thresholds can be enabled at a time. Trying to
> > enable more than 2 thresholds will result in an error.
> >=20
> > The configured thresholds will wake up the system from sleep mode if
> > wakeup is enabled in /sys/devices/.../power/wakeup.
> >=20
> > The old platform data was removed.
> >=20
> > Thresholds, events, and wakeup were tested on omap5-uevm board. It wakes
> > up from sleep mode when wakeup is enabled and a threshold is passed. A
> > userspace tool for monitoring events and adjusting thresholds can be
> > found at [3].
> >=20
> > V2 -> V3:
> > * Rebased to linux-next. =20
>=20
> As per reply to the earlier thread.  Don't base on linux-next.
> It can be very unstable though not so much later in a cycle like this.
>=20
> If there isn't a lot of churn going on in the driver, fine to base on
> previous release kernel or rc1 (good to say if it is an rc1)
>=20
> If there is churn underway (which is true here) then iio/togreg + extra
> patches lists that need to be applied listed in this cover letter.

Just goes to show I focused on the change log and skipped the rest :)
As you have it here is fine though change log could have mentioned the
extra patch as well even if just "Rebased to linux-next + devm patch."

In this case linux-next is close enough for this driver to the
iio/togreg tree that it doesn't matter that it shouldn't be used as a base
(no impact in this particular case I think).

Anyhow, all good. I noticed I'd misinterpreted what you'd done here
when I saw the context in one of the patches.  oops :)

Jonathan


>=20
> I'm also fine with you just adding the devm patch to this series as
> the first patch.
>=20
> Jonathan
>=20
>=20
>=20
> > * Avoid reconfiguring events on error and when old =3D=3D new value.
> > V1 -> V2:
> > * Begin by removing adc_wakeupX_data instead of doing it last.
> > * Split changes in smaller patches
> >=20
> > [1] git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> > [2] https://lore.kernel.org/linux-iio/20230318163039.56115-1-jic23@kern=
el.org/
> > [3] https://github.com/Risca/pyra_vol_mon
> >=20
> > Patrik Dahlstr=C3=B6m (7):
> >   iio: adc: palmas: remove adc_wakeupX_data
> >   iio: adc: palmas: replace "wakeup" with "event"
> >   iio: adc: palmas: use iio_event_direction for threshold polarity
> >   iio: adc: palmas: move eventX_enable into palmas_adc_event
> >   iio: adc: palmas: always reset events on unload
> >   iio: adc: palmas: add support for iio threshold events
> >   iio: adc: palmas: don't alter event config on suspend/resume
> >=20
> >  drivers/iio/adc/palmas_gpadc.c | 559 +++++++++++++++++++++++++++------
> >  include/linux/mfd/palmas.h     |   8 -
> >  2 files changed, 464 insertions(+), 103 deletions(-)
> >=20
> >=20
> > base-commit: 8417c8f5007bf4567ccffda850a3157c7d905f67
> > prerequisite-patch-id: b0418c707db13f514400956596e9ebe91c25bba0 =20
>=20

