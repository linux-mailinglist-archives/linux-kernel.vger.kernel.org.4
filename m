Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259E96A1DBA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 15:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjBXOrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 09:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjBXOrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 09:47:12 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4E71969B;
        Fri, 24 Feb 2023 06:47:10 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 508C31BF216;
        Fri, 24 Feb 2023 14:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1677250028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aWv+kfdyaYpBlMRNF5wJ4HLH0v6plsoypADEcu849B4=;
        b=MsVKKP9jVxY3uQ2Q4aPuN/MSe1VNw9S1geSWLq6uAvHXcaj6yRNCoib09WYlqSMMsSb4eJ
        n2sFVJ0bUy9n42i0ISeG+QBIzGHa3qM2J/vGQ7DqyAz2OVnmSddtgLOF4pWz3kCki+e6U8
        uQshrcJ29UmYb2M19bjxie2Opbyd1dVdB3gFjOOc6M2TNJGJxZOG5cRNCgW27KpVms9Dj9
        TdrcDobJk2iGCnTSKLGvFiZ0akXSraFd/cxQUirnD/UuWwMngz6fFlaAJGTirL3iEIpWY8
        DWNTxlqDnm2HtxR6G+xU7bwU0Eua8rDt/fMl3S1uiu4dM2DD08RmWLjmCbJsAg==
Date:   Fri, 24 Feb 2023 15:46:59 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Maxim Kiselev <bigunclemax@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        abel.vesa@linaro.org, alexander.stein@ew.tq-group.com,
        andriy.shevchenko@linux.intel.com, brgl@bgdev.pl,
        colin.foster@in-advantage.com, cristian.marussi@arm.com,
        devicetree@vger.kernel.org, dianders@chromium.org,
        djrscally@gmail.com, dmitry.baryshkov@linaro.org,
        festevam@gmail.com, fido_max@inbox.ru, frowand.list@gmail.com,
        geert+renesas@glider.be, geert@linux-m68k.org,
        gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
        jpb@kernel.org, jstultz@google.com, kernel-team@android.com,
        kernel@pengutronix.de, lenb@kernel.org, linus.walleij@linaro.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux@roeck-us.net, lkft@linaro.org, luca.weiss@fairphone.com,
        magnus.damm@gmail.com, martin.kepplinger@puri.sm, maz@kernel.org,
        rafael@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        sakari.ailus@linux.intel.com, shawnguo@kernel.org,
        tglx@linutronix.de, tony@atomide.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 00/11] fw_devlink improvements
Message-ID: <20230224154659.432a4d4c@xps-13>
In-Reply-To: <CAGETcx-0VboaAeoa+_AqDtrDj6v6ZytFj6pU-FVyAu-pk-hG6A@mail.gmail.com>
References: <20230127001141.407071-1-saravanak@google.com>
        <20230130085542.38546-1-naresh.kamboju@linaro.org>
        <CAGETcx_411fVxsM-ZMK7j2Bvkmi2TKPbzSuD+03M3cb7WKHfJw@mail.gmail.com>
        <20230131101813.goaoy32qvrowvyyb@bogus>
        <CALHCpMijXAgQx2qq8g8zdq=6AHwP+g5WVBjjry=v+dKEq9KDLw@mail.gmail.com>
        <CAGETcx_UvW819m1Y-QU_ySB1nG_RegKKT06=YjkK=C_qjbAySw@mail.gmail.com>
        <CALHCpMha_1nXt4rUe+A184XSWpyNk0_PkYjWZ+tUN7BJWqENLA@mail.gmail.com>
        <CAGETcx_uri6exkv1Jkzmc4PyEam9yjuH2H1zrq4LYNtJ+XDMWw@mail.gmail.com>
        <20230206103912.7db5ed72@xps-13>
        <CAGETcx-0VboaAeoa+_AqDtrDj6v6ZytFj6pU-FVyAu-pk-hG6A@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

> > > > > So, can you please retest config 1 with all pr_debug and dev_dbg =
in
> > > > > drivers/core/base.c changed to the _info variants? And then share=
 the
> > > > > kernel log from the beginning of boot? Maybe attach it to the ema=
il so
> > > > > it doesn't get word wrapped by your email client. And please poin=
t me
> > > > > to the .dts that corresponds to your board. Without that, I can't
> > > > > debug much. =20
> > > >
> > > > Ok, I retested config 1 with all _debug logs changed to the _info. I
> > > > added the kernel log and the dts file to the attachment of this ema=
il. =20
> > >
> > > Ah, so your device is not supported/present upstream? Even though it's
> > > not upstream, I'll help fix this because it should fix what I believe
> > > are unreported issues in upstream.
> > >
> > > Ok I know why configs 1 - 4 behaved the way they did and why my test
> > > patch didn't help.
> > >
> > > After staring at mtd/nvmem code for a few hours I think mtd/nvmem
> > > interaction is kind of a mess. =20
> >
> > nvmem is a recent subsystem but mtd carries a lot of legacy stuff we
> > cannot really re-wire without breaking users, so nvmem on top of mtd
> > of course inherit from the fragile designs in place. =20
>=20
> Thanks for the context. Yeah, I figured. That's why I explicitly
> limited my comment to "interaction". Although, I'd love to see the MTD
> parsers all be converted to proper drivers that probe. MTD is
> essentially repeating the driver matching logic. I think it can be
> cleaned up to move to proper drivers and still not break backward
> compatibility. Not saying it'll be trivial, but it should be possible.
> Ironically MTD uses mtd_class but has real drivers that work on the
> device (compared to nvmem_bus below).
>=20
> > > mtd core creates "partition" platform
> > > devices (including for nvmem-cells) that are probed by drivers in
> > > drivers/nvmem. However, there's no driver for "nvmem-cells" partition
> > > platform device. However, the nvmem core creates nvmem_device when
> > > nvmem_register() is called by MTD or these partition platform devices
> > > created by MTD. But these nvmem_devices are added to a nvmem_bus but
> > > the bus has no means to even register a driver (it should really be a
> > > nvmem_class and not nvmem_bus). =20
> >
> > Srinivas, do you think we could change this? =20
>=20
> Yeah, this part gets a bit tricky. It depends on whether the sysfs
> files for nvmem devices is considered an ABI. Changing from bus to
> class would change the sysfs path for nvmem devices from:
> /sys/class/nvmem to /sys/bus/nvmem

Ok, so this is a no :)

> > > And the nvmem_device sometimes points
> > > to the DT node of the MTD device or sometimes the partition platform
> > > devices or maybe no DT node at all. =20
> >
> > I guess this comes from the fact that this is not strongly defined in
> > mtd and depends on the situation (not mentioning 20 years of history
> > there as well). "mtd" is a bit inconsistent on what it means. Older
> > designs mixed: controllers, ECC engines when relevant and memories;
> > while these three components are completely separated. Hence
> > sometimes the mtd device ends up being the top level controller,
> > sometimes it's just one partition...
> >
> > But I'm surprised not all of them point to a DT node. Could you show us
> > an example? Because that might likely be unexpected (or perhaps I am
> > missing something). =20
>=20
> Well, the logic that sets the DT node for nvmem_device is like so:
>=20
>         if (config->of_node)
>                 nvmem->dev.of_node =3D config->of_node;
>         else if (!config->no_of_node)
>                 nvmem->dev.of_node =3D config->dev->of_node;
>=20
> So there's definitely a path (where both if's could be false) where
> the DT node will not get set. I don't know if that path is possible
> with the existing users of nvmem_register(), but it's definitely
> possible.

It's an actual path. I just checked more in details, this is the change
from 2018 which uses the no_of_node flag:
c4dfa25ab307 ("mtd: add support for reading MTD devices via the nvmem API")

It basically allows any mtd device to be accessible (read-only) through
nvmem. So mtd partitions or such which are not described in the DT may
just be accessed through nvmem (that is my current understanding).

There was later a patch in 2021 which prevented this flag to be
automatically set, so that if partitions (well, mtd devices in general)
were described in the DT, they would provide a valid of_node in order
to be used as cell providers (again, my understanding):
658c4448bbbf ("mtd: core: add nvmem-cells compatible to parse mtd as nvmem =
cells")

But I guess the major problem comes from the nvmem-cell compatible. I
am wondering if it would make sense to kind of transpose the meaning of
this compatible into a property. But, well, backward compatibility
would still be a problem I guess...

> > > So it's a mess of multiple devices pointing to the same DT node with
> > > no clear way to identify which ones will point to a DT node and which
> > > ones will probe and which ones won't. In the future, we shouldn't
> > > allow adding new compatible strings for partitions for which we don't
> > > plan on adding nvmem drivers.
> > >
> > > Can you give the patch at the end of the email a shot? It should fix
> > > the issue with this series and without this series. It just avoids
> > > this whole mess by not creating useless platform device for
> > > nvmem-cells compatible DT nodes. =20
> >
> > Thanks a lot for your help. =20
>=20
> No problem. I want fw_devlink to work for everyone.
>=20

Thanks,
Miqu=C3=A8l
