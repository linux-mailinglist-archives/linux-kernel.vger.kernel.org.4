Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D61692950
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 22:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbjBJVdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 16:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbjBJVdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 16:33:10 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F04B81CE0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 13:33:08 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso11328312pjj.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 13:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1676064787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jaTG/YcqsKJ9eLC7Ck7BS82uy6FuCF4UlYVuMNR2PIo=;
        b=ovv8F9kPWpy3fWu/qxCH1rfmW9ce/EUvJBy4giAcgUPwM0AW/RfpAQ/bBHt6+uLPeH
         wJH/LAudN9cJrTeJX1BpcUtgeMS8qgzYd7JXfE7fgTPgNafSGMN8um6j7OVbfTyFPA8Q
         vPAYZR4woLvZEYRjoo7gHYt9rURikUxgnqn62AsGDaLKjA0lm2PQtI9/arhkDGAD5+mO
         dqjkQBFgxaq5je73WYZVxOzuVAjXdjlpc2ajQ5kXQ/3GekQuQzvVEaSMOHBrWcUnLca+
         SbsoRQQw4WTHSFi7McCtDNJpreIbZPrW7bvpsfTy7GwOzw4u/Mhvt8B2iZoy/OwxAKpC
         7cIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676064787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jaTG/YcqsKJ9eLC7Ck7BS82uy6FuCF4UlYVuMNR2PIo=;
        b=c+7cu+fBrgtYJzDZaH+0gsP5ORnMIMcczUotouaKIXVQRwgdanDtLznWSRdwVMYTnt
         U3FcLUdDa8YQdFaET63Sui4auMG+wsXgb89+FSeXUfqTIgAg06KhfljGLwACAd5XB/3b
         srJyixkG9n3ixHSnyOcEV4XR25VYGZlYKDWOtRSo/DqbvYCTll/Fvj3AHorrFzrkMJ8d
         bMolWP0kzpSEV5z2Dwm2bRK4iHyFaXnTbFfrCIdMveen5c8MtBIWXoR7M7IP+CatQU9C
         DKSC7HxNgn/wx7iv3TLyZBMMcuPwSQ3u7Nsluv4+ZXgNpepwVf+Zv4RFo+kkH4zZRQ+N
         lLvA==
X-Gm-Message-State: AO0yUKWbzbgomkgq/oE8Mw+Q3NXdEnNi/yARdj2qtrigqPRT6/HSIIgD
        /iMn59JgCFmFs6CcjtuQM/h8dOM5ODenW6fc2rIL3w==
X-Google-Smtp-Source: AK7set/i+ziIBOrTHEBeRDeI5Q8Vmjlc2a67ZKq8/hQ/Q4dBB5gNS3XuPRY8G0QEZEhJ/9weK2lbbDtC4Nf8A4Pw4IE=
X-Received: by 2002:a17:902:ea0e:b0:196:64bf:ed7a with SMTP id
 s14-20020a170902ea0e00b0019664bfed7amr3941916plg.29.1676064787017; Fri, 10
 Feb 2023 13:33:07 -0800 (PST)
MIME-Version: 1.0
References: <20230207014207.1678715-1-saravanak@google.com>
 <20230210101333.h2e7hcl3ylsoh6fy@skbuf> <CAGETcx_SQJ1q_f8r+zKATF-EEb0P-T_ot15AQ1x1Vc_3h=XfCw@mail.gmail.com>
 <20230210210804.vdyfrog5nq6hrxi5@skbuf>
In-Reply-To: <20230210210804.vdyfrog5nq6hrxi5@skbuf>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 10 Feb 2023 13:32:30 -0800
Message-ID: <CAGETcx-OFh6s8zxQUVb29VKOfaD7GpY=E_KQvVMQ=h7kp_sZGw@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] fw_devlink improvements
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Abel Vesa <abel.vesa@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maxim Kiselev <bigunclemax@gmail.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Jean-Philippe Brucker <jpb@kernel.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 1:08 PM Vladimir Oltean <vladimir.oltean@nxp.com> w=
rote:
>
> On Fri, Feb 10, 2023 at 11:27:11AM -0800, Saravana Kannan wrote:
> > On Fri, Feb 10, 2023 at 2:13 AM Vladimir Oltean <vladimir.oltean@nxp.co=
m> wrote:
> > >
> > > Hi Saravana,
> > >
> > > On Mon, Feb 06, 2023 at 05:41:52PM -0800, Saravana Kannan wrote:
> > > > Vladimir,
> > > >
> > > > Ccing you because DSA's and fw_devlink have known/existing problems
> > > > (still in my TODOs to fix). But I want to make sure this series doe=
sn't
> > > > cause additional problems for DSA.
> > > >
> > > > All,
> > > >
> > > > This patch series improves fw_devlink in the following ways:
> > > >
> > > > 1. It no longer cares about a fwnode having a "compatible" property=
. It
> > > >    figures this out more dynamically. The only expectation is that
> > > >    fwnodes that are converted to devices actually get probed by a d=
river
> > > >    for the dependencies to be enforced correctly.
> > > >
> > > > 2. Finer grained dependency tracking. fw_devlink will now create de=
vice
> > > >    links from the consumer to the actual resource's device (if it h=
as one,
> > > >    Eg: gpio_device) instead of the parent supplier device. This imp=
roves
> > > >    things like async suspend/resume ordering, potentially remove th=
e need
> > > >    for frameworks to create device links, more parallelized async p=
robing,
> > > >    and better sync_state() tracking.
> > > >
> > > > 3. Handle hardware/software quirks where a child firmware node gets
> > > >    populated as a device before its parent firmware node AND actual=
ly
> > > >    supplies a non-optional resource to the parent firmware node's
> > > >    device.
> > > >
> > > > 4. Way more robust at cycle handling (see patch for the insane case=
s).
> > > >
> > > > 5. Stops depending on OF_POPULATED to figure out some corner cases.
> > > >
> > > > 6. Simplifies the work that needs to be done by the firmware specif=
ic
> > > >    code.
> > > >
> > > > The v3 series has gone through my usual testing on my end and looks=
 good
> > > > to me.
> > >
> > > Booted on an NXP LS1028A (arch/arm64/boot/dts/freescale/fsl-ls1028a-r=
db.dts)
> > > and a Turris MOX (arch/arm64/boot/dts/marvell/armada-3720-turris-mox.=
dts)
> > > with no observed regressions.
> >
> > Thanks for testing Vladimir!
> >
> > > Is there something specific you would like
> > > me to test?
> >
> > Not really, I just want to make sure the common DSA architectures
> > don't hit any regression. In the hardware you tested, are there cases
> > of PHYs where the supplier is the parent MDIO? I remember that being
> > the only case where I needed special casing
> > (FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD) in fw_devlink -- so it'll be
> > good to make sure I didn't accidentally break anything there.
> >
> > -Saravana
>
> Yes and no (I never had a system which depended on FWNODE_FLAG_NEEDS_CHIL=
D_BOUND_ON_ADD).
>
> Yes, because well, yes, in arch/arm64/boot/dts/marvell/armada-3720-turris=
-mox.dts,
> the PHYs will depend on interrupts provided by their (parent) switch. How=
ever this
> is not explicit in the device tree. To make it explicit, one would need t=
o add:
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arc=
h/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> index cd0988317623..d789cda49e35 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts

-----8<---- Snipped DT diff -----

> However, as I had explained in one of the first discussions here:
> https://lore.kernel.org/netdev/20210901012826.iuy2bhvkrgahhrl7@skbuf/
>
> it was always hit-or-miss whether the above device tree had an issue
> with fw_devlink or not: it depended on how the driver was written (and
> the mv88e6xxx switch driver was tricking the fw_devlink logic from that
> time to drop the device links because of an unrelated -EPROBE_DEFER).

Yeah, I never forgot this issue. That's why I used "additional" in my
cover letter :)

So far I've not needed to change fw_devlink in a way that'd break this
unintentional "tricky behavior" but I might be coming up to that wall
soon. So this reply is becoming more relevant to me:
https://lore.kernel.org/lkml/CAGETcx8De_qm9hVtK5CznfWke9nmOfV8OcvAW6kmwyeb7=
APr=3Dg@mail.gmail.com/

Not sure if you've had a chance to read or think about it.

> What I had done to "untrick" fw_devlink so that I could see the issue
> (which was originally reported by Alvin =C5=A0ipraga) was to modify the
> mv88e6xxx driver, and change the placement of mv88e6xxx_mdios_register()
> to a point after which we will never hit -EPROBE_DEFER (from driver probe=
()
> to the dsa_switch_ops :: setup() method):
>
> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx=
/chip.c
> index 0a5d6c7bb128..48650465660d 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c

-----8<---- snipped

> After applying both of the above changes on top of yours, I confirm that
> the PHYs on the mv88e6xxx on Turris MOX still probe with their specific
> PHY driver rather than the generic one, and with interrupts (not poll mod=
e):
>
-----8<---- snipped

>
> even though I am seeing these error messages earlier in the boot process =
(maybe this is something to look into):
>
> [    0.910219] mdio_bus d0032004.mdio-mii:10: Failed to create device lin=
k with d0032004.mdio-mii:10

-----8<---- snipped

> [    0.943879] mv88e6085 d0032004.mdio-mii:12: switch 0x1900 detected: Ma=
rvell 88E6190, revision 1
>
>
> If _on top_ of all the above, I also remove the logic that sets FWNODE_FL=
AG_NEEDS_CHILD_BOUND_ON_ADD:

> then *finally* I get something approximating Alvin's reported issue.
> In my case, one switch out of 3 gets its PHYs bound to the Generic PHY
> driver (why not all is a story for another time):

-----8<---- snipped

> So I guess that FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD does something.

Thanks for the extensive effort into testing this!

-Saravana
