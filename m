Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B694961DB8D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 16:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiKEPHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 11:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiKEPHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 11:07:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ED71C5;
        Sat,  5 Nov 2022 08:06:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39714B800C1;
        Sat,  5 Nov 2022 15:06:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17CDC433D6;
        Sat,  5 Nov 2022 15:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667660815;
        bh=243tUlsrMWQnQ6yTrRx2ppdGwtQviho+Rgrz5cpgBmg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nbx0r7jOhuykxmNuvrvypApgjsTpMxzr2WXgNy5Nc03IwP1TLo7st57uB0DAAkJbi
         fIdVcz2HgeyByMGywwqU6HPj1A9aM9vm7Q33oCpxwyPQvt3vOnFhpMoWRAVv1P7MSN
         9h4WGMFU8fatBfBefBchjvICsEOwAhNooDaVIDDBB8m+50r/wBQ/bljk/yyeeh3HsW
         d45XZs39+kV+h6RBEnBYMWmzNbrU098Z78Yy0jPLUDZ9jdxozV0lN5/NGW53RpYsvH
         xdM3nBvjgELz8TwXnV28WMlWMzfW1RicNWBvaBrEYt3aZdLXYoU9ba2FgnZ5QLhaPj
         3TiHortKivllw==
Date:   Sat, 5 Nov 2022 15:06:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/8] Remove adis_initial_startup usage
Message-ID: <20221105150647.2c9cbff7@jic23-huawei>
In-Reply-To: <SJ0PR03MB677857576EF31B737F6D3DF599389@SJ0PR03MB6778.namprd03.prod.outlook.com>
References: <20221103080847.162509-1-ramona.bolboaca@analog.com>
        <SJ0PR03MB677857576EF31B737F6D3DF599389@SJ0PR03MB6778.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Nov 2022 12:35:31 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > From: Ramona Bolboaca <ramona.bolboaca@analog.com>
> > Sent: Thursday, November 3, 2022 9:09 AM
> > To: jic23@kernel.org; linux-iio@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Cc: Bolboaca, Ramona <Ramona.Bolboaca@analog.com>
> > Subject: [PATCH v2 0/8] Remove adis_initial_startup usage
> >=20
> >=20
> > Remove 'adis_initial_startup()' usage due to the fact that it leads to a
> > deadlock.
> > The same mutex is acquired twice, without releasing it, once inside
> > 'adis_initial_startup()' and once inside 'adis_enable_irq()'.
> > Instead of 'adis_initial_startup()', use '__adis_initial_startup()'.
> >=20
> > Ramona Bolboaca (8):
> >   iio: accel: adis16201: Fix deadlock in probe
> >   iio: accel: adis16209: Fix deadlock in probe
> >   iio: gyro: adis16136: Fix deadlock in probe
> >   iio: gyro: adis16260: Fix deadlock in probe
> >   iio: imu: adis16400: Fix deadlock in probe
> >   staging: iio: accel: adis16203: Fix deadlock in probe
> >   staging: iio: accel: adis16240: Fix deadlock in probe
> >   iio: imu: adis: Remove adis_initial_startup function
> >=20
> >  drivers/iio/accel/adis16201.c         |  2 +-
> >  drivers/iio/accel/adis16209.c         |  2 +-
> >  drivers/iio/gyro/adis16136.c          |  2 +-
> >  drivers/iio/gyro/adis16260.c          |  2 +-
> >  drivers/iio/imu/adis16400.c           |  2 +-
> >  drivers/staging/iio/accel/adis16203.c |  2 +-
> >  drivers/staging/iio/accel/adis16240.c |  2 +-
> >  include/linux/iio/imu/adis.h          | 12 ------------
> >  8 files changed, 7 insertions(+), 19 deletions(-)
> >  =20
>=20
> You could have placed your v2 changelog in the cover letter.
> Moreover it's the same for all patches... Anyways:=20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

This feels a little backwards.  Normally we'd expect the
outer function to take the lock and the inner call to not
do so.  Now it's fine to not take the lock here at all because
the outer function call is in probe anyway, before we reach
the point where there should be an concurrency.

I wonder if we should instead do this by having
an unlocked __adis_enable_irq() that is always called
by __adis_initial_startup().  That would be the fix that
then needs backporting.

Switching the calls from adis_initial_startup() to
__adis_initial_startup() would then just be a trivial
optimization to not take locks before they should ever matter.

This all hinges on my assumption that the lock isn't useful.
Am I right on that?

Jonathan


>=20
> - Nuno S=C3=A1

