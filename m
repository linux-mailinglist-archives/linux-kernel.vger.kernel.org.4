Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE82368C134
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjBFPTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBFPS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:18:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4300D2688;
        Mon,  6 Feb 2023 07:18:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D469060F28;
        Mon,  6 Feb 2023 15:18:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426B6C433AF;
        Mon,  6 Feb 2023 15:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675696736;
        bh=t6snAmiA8jL5WTtfh345TOoJ0hKZpmGhPlbNqKUc674=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mzipr2AWMFAR6T+NAjtERt43GC+nstYbVIaAykqc1I0Ytm2LbzGkL2SnEvBR4Lnw0
         cJOoPDCu4MWQZSZwtZRU+GuQq8lN0t6iV+CS364ljYSdHyqmo244guz3qW5TAD2264
         0ZmfjDD9ipjxWJ/Mu6dvEtKxmmM8z2FqYTEMKFLvJPRo76IpQdUwHZflJy2jLZwdya
         Qu9lEFkuNTErMGfxACWETvt+vb00FbpXfHNwAyFTgFrCMgb+VyLoAlaDm1rfjO5M6A
         g1nKZHpiRdLXd2QE8yG+PQx/3QXcbgJqEjFORhEPkNJJNqmAPnl2Bf9aOZ/3R/7Vug
         8OBNwElfbd6lg==
Received: by mail-vk1-f182.google.com with SMTP id t190so6260683vkb.13;
        Mon, 06 Feb 2023 07:18:56 -0800 (PST)
X-Gm-Message-State: AO0yUKXIGIn5Q+ywBd23Xhof4LEumH09vhK3UxJulpKXp7RUW16PfDZ+
        4OjOqMPREw/FV9KjESmU/INnWboojK+SDr2BXA==
X-Google-Smtp-Source: AK7set+IxAQSTK6n6CnvuB4SYDav6xPxSMs7u6KqyPm7oYpZV3d07lbHLtC/gF7MyTiAVGTuOLibZnVtlItzu85XemE=
X-Received: by 2002:ac5:cbf8:0:b0:3d5:d30f:81c2 with SMTP id
 i24-20020ac5cbf8000000b003d5d30f81c2mr2836396vkn.14.1675696734849; Mon, 06
 Feb 2023 07:18:54 -0800 (PST)
MIME-Version: 1.0
References: <20230127001141.407071-1-saravanak@google.com> <20230130085542.38546-1-naresh.kamboju@linaro.org>
 <CAGETcx_411fVxsM-ZMK7j2Bvkmi2TKPbzSuD+03M3cb7WKHfJw@mail.gmail.com>
 <20230131101813.goaoy32qvrowvyyb@bogus> <CALHCpMijXAgQx2qq8g8zdq=6AHwP+g5WVBjjry=v+dKEq9KDLw@mail.gmail.com>
 <CAGETcx_UvW819m1Y-QU_ySB1nG_RegKKT06=YjkK=C_qjbAySw@mail.gmail.com>
 <CALHCpMha_1nXt4rUe+A184XSWpyNk0_PkYjWZ+tUN7BJWqENLA@mail.gmail.com> <CAGETcx_uri6exkv1Jkzmc4PyEam9yjuH2H1zrq4LYNtJ+XDMWw@mail.gmail.com>
In-Reply-To: <CAGETcx_uri6exkv1Jkzmc4PyEam9yjuH2H1zrq4LYNtJ+XDMWw@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 6 Feb 2023 09:18:43 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+rLZuQYn-90C1gy_uGEXiGeDNZ3OfumTFcx4pP97sXsg@mail.gmail.com>
Message-ID: <CAL_Jsq+rLZuQYn-90C1gy_uGEXiGeDNZ3OfumTFcx4pP97sXsg@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] fw_devlink improvements
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
        miquel.raynal@bootlin.com, rafael@kernel.org,
        s.hauer@pengutronix.de, sakari.ailus@linux.intel.com,
        shawnguo@kernel.org, tglx@linutronix.de, tony@atomide.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 5, 2023 at 7:33 PM Saravana Kannan <saravanak@google.com> wrote=
:
>
> On Fri, Feb 3, 2023 at 1:39 AM Maxim Kiselev <bigunclemax@gmail.com> wrot=
e:
> >
> > =D0=BF=D1=82, 3 =D1=84=D0=B5=D0=B2=D1=80. 2023 =D0=B3. =D0=B2 09:07, Sa=
ravana Kannan <saravanak@google.com>:
> > >
> > > On Thu, Feb 2, 2023 at 9:36 AM Maxim Kiselev <bigunclemax@gmail.com> =
wrote:
> > > >
> > > > Hi Saravana,
> > > >
> > > > > Can you try the patch at the end of this email under these
> > > > > configurations and tell me which ones fail vs pass? I don't need =
logs
> > > >
> > > > I did these tests and here is the results:
> > >
> > > Did you hand edit the In-Reply-To: in the header? Because in the
> > > thread you are reply to the wrong email, but the context in your emai=
l
> > > seems to be from the right email.
> > >
> > > For example, see how your reply isn't under the email you are replyin=
g
> > > to in this thread overview:
> > > https://lore.kernel.org/lkml/20230127001141.407071-1-saravanak@google=
.com/#r
> > >
> > > > 1. On top of this series - Not works
> > > > 2. Without this series    - Works
> > > > 3. On top of the series with the fwnode_dev_initialized() deleted -=
 Not works
> > > > 4. Without this series, with the fwnode_dev_initialized() deleted  =
- Works
> > > >
> > > > So your nvmem/core.c patch helps only when it is applied without th=
e series.
> > > > But despite the fact that this helps to avoid getting stuck at prob=
ing
> > > > my ethernet device, there is still regression.
> > > >
> > > > When the ethernet module is loaded it takes a lot of time to drop d=
ependency
> > > > from the nvmem-cell with mac address.
> > > >
> > > > Please look at the kernel logs below.
> > >
> > > The kernel logs below really aren't that useful for me in their
> > > current state. See more below.
> > >
> > > ---8<---- <snip> --->8----
> > >
> > > > P.S. Your nvmem patch definitely helps to avoid a device probe stuc=
k
> > > > but look like it is not best way to solve a problem which we discus=
sed
> > > > in the MTD thread.
> > > >
> > > > P.P.S. Also I don't know why your nvmem-cell patch doesn't help whe=
n it was
> > > > applied on top of this series. Maybe I missed something.
> > >
> > > Yeah, I'm not too sure if the test was done correctly. You also didn'=
t
> > > answer my question about the dts from my earlier email.
> > > https://lore.kernel.org/lkml/CAGETcx8FpmbaRm2CCwqt3BRBpgbogwP5gNB+iA5=
OEtuxWVTNLA@mail.gmail.com/#t
> > >
> > > So, can you please retest config 1 with all pr_debug and dev_dbg in
> > > drivers/core/base.c changed to the _info variants? And then share the
> > > kernel log from the beginning of boot? Maybe attach it to the email s=
o
> > > it doesn't get word wrapped by your email client. And please point me
> > > to the .dts that corresponds to your board. Without that, I can't
> > > debug much.
> > >
> > > Thanks,
> > > Saravana
> >
> > > Did you hand edit the In-Reply-To: in the header? Because in the
> > > thread you are reply to the wrong email, but the context in your emai=
l
> > > seems to be from the right email.
> >
> > Sorry for that, it seems like I accidently deleted it.
> >
> > > So, can you please retest config 1 with all pr_debug and dev_dbg in
> > > drivers/core/base.c changed to the _info variants? And then share the
> > > kernel log from the beginning of boot? Maybe attach it to the email s=
o
> > > it doesn't get word wrapped by your email client. And please point me
> > > to the .dts that corresponds to your board. Without that, I can't
> > > debug much.
> >
> > Ok, I retested config 1 with all _debug logs changed to the _info. I
> > added the kernel log and the dts file to the attachment of this email.
>
> Ah, so your device is not supported/present upstream? Even though it's
> not upstream, I'll help fix this because it should fix what I believe
> are unreported issues in upstream.
>
> Ok I know why configs 1 - 4 behaved the way they did and why my test
> patch didn't help.
>
> After staring at mtd/nvmem code for a few hours I think mtd/nvmem
> interaction is kind of a mess. mtd core creates "partition" platform
> devices (including for nvmem-cells) that are probed by drivers in
> drivers/nvmem. However, there's no driver for "nvmem-cells" partition
> platform device. However, the nvmem core creates nvmem_device when
> nvmem_register() is called by MTD or these partition platform devices
> created by MTD. But these nvmem_devices are added to a nvmem_bus but
> the bus has no means to even register a driver (it should really be a
> nvmem_class and not nvmem_bus). And the nvmem_device sometimes points
> to the DT node of the MTD device or sometimes the partition platform
> devices or maybe no DT node at all.
>
> So it's a mess of multiple devices pointing to the same DT node with
> no clear way to identify which ones will point to a DT node and which
> ones will probe and which ones won't. In the future, we shouldn't
> allow adding new compatible strings for partitions for which we don't
> plan on adding nvmem drivers.

That won't work. Having a compatible string cannot mean there must be a dri=
ver.

Rob
