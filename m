Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5C8731B60
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239243AbjFOO3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345067AbjFOO3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:29:11 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED210294E;
        Thu, 15 Jun 2023 07:29:08 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686839347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6dohD9hmjDXwfIGxi/7uonpAgLAMNIKziVj5v5vR8Ds=;
        b=kNzPsVhPJjzzIkFDe6FezelKmnwJxOs2lNxdqTggocCV0+4FGt8FIbbXG7naDR6hxaum5U
        vWOg2fqN16lRuVuaGlIp53CG32Tv5TbPXZWWyfsw4zJcEMx15KOLttBNXJQktw5xC5V8u9
        KX2BG9/eAbxVvcWaec0L1iRW74TiUU7FSdAyRoBFUOBs5JECPA9u/57had7I5nRqIfyBNT
        lt6jbf/qpLtLdeHSb6o3I9FeV3h3B4DqeREh1E1+TbgaEt5n3HVEMBeMW3UgFoudGJeoUg
        rVn7PrnbhWi23SX52jAe0a6J62LZUXoRmOdbwSuj0LAX2hNIVI7glcBkJ93pYw==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F3C3FE0004;
        Thu, 15 Jun 2023 14:29:05 +0000 (UTC)
Date:   Thu, 15 Jun 2023 16:29:05 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: Re: [PATCH 2/2] power: reset: at91-reset: add sysfs interface to
 the power on reason
Message-ID: <20230615162905.71e1443d@xps-13>
In-Reply-To: <20230609233659.tduea4ls5raaf76e@mercury.elektranox.org>
References: <20230609143912.849995-1-miquel.raynal@bootlin.com>
        <20230609143912.849995-3-miquel.raynal@bootlin.com>
        <20230609233659.tduea4ls5raaf76e@mercury.elektranox.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

sebastian.reichel@collabora.com wrote on Sat, 10 Jun 2023 01:36:59
+0200:

> Hi,
>=20
> On Fri, Jun 09, 2023 at 04:39:12PM +0200, Miquel Raynal wrote:
> > From: Kamel Bouhara <kamel.bouhara@bootlin.com>
> >=20
> > Introduce a list of generic reset sources and use them to export the
> > power on reason through sysfs. Update the ABI documentation to describe
> > this new interface.
> >=20
> > Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> > Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> > [Miquel Raynal: Follow-up on Kamel's work, 4 years later]
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  .../testing/sysfs-platform-power-on-reason    | 10 +++++
> >  drivers/power/reset/at91-reset.c              | 42 +++++++++++++------
> >  include/linux/power/power_on_reason.h         | 19 +++++++++
> >  3 files changed, 59 insertions(+), 12 deletions(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-platform-power-on-r=
eason
> >  create mode 100644 include/linux/power/power_on_reason.h
> >=20
> > diff --git a/Documentation/ABI/testing/sysfs-platform-power-on-reason b=
/Documentation/ABI/testing/sysfs-platform-power-on-reason
> > new file mode 100644
> > index 000000000000..12020d017543
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-platform-power-on-reason
> > @@ -0,0 +1,10 @@
> > +What:		/sys/devices/platform/.../power_on_reason
> > +Date:		October 2019
> > +KernelVersion:	5.4 =20
>=20
> That needs to be updated :)

/o\

>=20
> > +Contact:	Kamel Bouhara <kamel.bouhara@bootlin.com>
> > +Description:	This file shows system power on reason. Possible sources =
are:
> > +		General system power-on, RTC wakeup, watchdog timeout, software
> > +		reset, user pressed reset button, CPU clock failure, oscillator
> > +		failure, low power mode exit, unknown.
> > +
> > +		The file is read only. =20
>=20
> This should list the exact strings generated by the kernel. They are
> ABI. Also it should be mentioned, that the list might be extended in
> the future.

Ah, ok, sure.

>=20
> > diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at9=
1-reset.c =20
>=20
> [...]
>=20
> > diff --git a/include/linux/power/power_on_reason.h b/include/linux/powe=
r/power_on_reason.h
> > new file mode 100644
> > index 000000000000..4b92eb0519c4
> > --- /dev/null
> > +++ b/include/linux/power/power_on_reason.h
> > @@ -0,0 +1,19 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Author: Kamel Bouhra <kamel.bouhara@bootlin.com>
> > + */
> > +
> > +#ifndef POWER_ON_REASON_H
> > +#define POWER_ON_REASON_H
> > +
> > +#define POWER_ON_REASON_GENERAL "general" =20
>=20
> What's the difference between "general" and "unknown"?

This reset value is returned when the reset controller detects rising
power rails. It is basically a "I just plugged the power connector"
situation.

Maybe I can rename it:

#define POWER_ON_REASON_REGULAR "regular power-up"

?

The "unknown" situation is more like a "it does not match what I
expect/know". Might be because support for a new reason was added to
another SoC where these enums would be used but not added to the driver
(yet).

Questioning the low-power situation remark you made below, we could
also imagine that, under certain brownout conditions, where the status
register might somehow be corrupted (assuming if this happens, the
other reasons will not appear), we might want to return that "unknown"
reason which sounds more like a software thing for handling default
case statements.

> > +#define POWER_ON_REASON_RTC "RTC wakeup"
> > +#define POWER_ON_REASON_WATCHDOG "watchdog timeout"
> > +#define POWER_ON_REASON_SOFTWARE "software" =20
>=20
> "software reset"

Yes.

>=20
> > +#define POWER_ON_REASON_USER "user" =20
>=20
> user is quite confusing. This should be something like
>=20
> #define POWER_ON_REASON_RST_BTN "reset button"

Agreed. Maybe even "reset button action" so it fits better the "Starting
after %s" string, like the other reasons.

>=20
> > +#define POWER_ON_REASON_CPU_FAIL "CPU clock failure" =20
>=20
> POWER_ON_REASON_CPU_CLK_FAIL
>=20
> > +#define POWER_ON_REASON_XTAL_FAIL "crystal oscillator failure"
> > +#define POWER_ON_REASON_LOW_POWER "low power exit" =20
>=20
> when is this reported?

I am currently using a Sama5d3 where this reason does not exist, but
given how are defined the other reasons, I would assume that the reset
controller might be able to monitor the power rails, and report this
condition upon a short brownout, like: "there is temporarily not enough
power =3D> CPU reset", but in the mean time, the capacitors allowed the
hardware to retain that information and this does not appear like a
regular power up situation. Just guessing, I did not find yet a proper
explanation.

Anyhow, I will change the string to "low-power condition" which sounds
better IMHO.

> > +#define POWER_ON_REASON_UNKNOWN "unknown"

And here "unknown reason"

> > +
> > +#endif /* POWER_ON_REASON_H */ =20
>=20
> Greetings,
>=20
> -- Sebastian

Thanks,
Miqu=C3=A8l
