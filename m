Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8566E69CA1E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 12:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjBTLqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 06:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjBTLql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 06:46:41 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D2613D7C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 03:46:39 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1720600a5f0so1150643fac.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 03:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vPbo+yIARbT7jgf8IQnkjprl/MVbtyH8usepXrQBeJI=;
        b=CPDcHaLEgeyaQO+4EHsg5O4TIVOU9SyomTQIcWyPyrv+INuZ3eapVql/EQv8eKlzoY
         f1J5nfMgsXNtk1tJIqRfnEgbXPb6JkOUruEEqO3C3wwEOU4BJpdjN5yB8VS8ka54GpaC
         5goGHDlHVmE0bLEjw6etGbk1SZ02qW4TkH9NQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vPbo+yIARbT7jgf8IQnkjprl/MVbtyH8usepXrQBeJI=;
        b=618KyeGs8mgK7s/0ELiWlj+tvhLBuzaTOePHsk1DJIHGeg11gTNDQ+yywN5zPLie/J
         wTHdnGeXmv1S7dHHgPdCuQ3jq434n1viUH2u5+wPQxVvE6BNe97OrRQY8m6k86gTQIzN
         I4XTjtIg3RcueZw+vAJNbwMjTsevVNinwsYj9z3HnSuiY/2QH+Ld4LbZyAei5UHRVAC+
         ANQalSdRmsZj8o0nmVO8sZ4ruZ+0HBHoMj+ObkaVhHKISyOH00Ckuax5iqTWbXmhKqZu
         R1j7UAswV9rGY2lC8a/ItFpX4md/r2R27LLh9F0D2MkYCa+NTScg3KO8eEFoNIWvBVK1
         Uv+A==
X-Gm-Message-State: AO0yUKX2DwSdGPj4rsy685bTaWIyi0/mbjUEp5lNkYHtXZgU4mC5b05A
        sQWkCdB6XhbL+PpzMRKUwdybC0xEqp6PbQLXoZd5eSrIzh5A3yAL
X-Google-Smtp-Source: AK7set9RP37kgFyzY6MRlT3RDTJn3/SaIqePohqPE15TE2VUDNda5IF9jZXIfDH9EIvjtg+PB/MCXKWvcPjVVThCf8w=
X-Received: by 2002:a05:6871:b12:b0:16e:5f2d:2e55 with SMTP id
 fq18-20020a0568710b1200b0016e5f2d2e55mr1034864oab.9.1676893598440; Mon, 20
 Feb 2023 03:46:38 -0800 (PST)
MIME-Version: 1.0
References: <20230217161038.3130053-1-angelo@amarulasolutions.com> <Y/NcHjpet0DxLJrl@orome>
In-Reply-To: <Y/NcHjpet0DxLJrl@orome>
From:   Angelo Compagnucci <angelo@amarulasolutions.com>
Date:   Mon, 20 Feb 2023 12:46:02 +0100
Message-ID: <CA+_SqVbs0O5aS8pjAutNY21SxXM=EWiWKunH=-0N9VxMNFKtjQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] misc: servo-pwm: driver for controlling servo
 motors via PWM
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:GENERIC PWM SERVO DRIVER" <linux-pwm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 12:40 PM Thierry Reding
<thierry.reding@gmail.com> wrote:
>
> On Fri, Feb 17, 2023 at 05:10:35PM +0100, Angelo Compagnucci wrote:
> > This patch adds a simple driver to control servo motor position via
> > PWM signal.
> > The driver allows to set the angle from userspace, while min/max
> > positions duty cycle and the motor degrees aperture are defined in
> > the dts.
> >
> > Signed-off-by: Angelo Compagnucci <angelo@amarulasolutions.com>
> > ---
> > v2:
> > * Driver mostly rewritten for kernel 6.2
> > v3:
> > * Fixed sysfs_emit (greg k-h)
> >
> >  MAINTAINERS              |   6 ++
> >  drivers/misc/Kconfig     |  11 +++
> >  drivers/misc/Makefile    |   1 +
> >  drivers/misc/servo-pwm.c | 149 +++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 167 insertions(+)
> >  create mode 100644 drivers/misc/servo-pwm.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 39ff1a717625..8f4af64deb1b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8737,6 +8737,12 @@ F:     Documentation/devicetree/bindings/power/power?domain*
> >  F:   drivers/base/power/domain*.c
> >  F:   include/linux/pm_domain.h
> >
> > +GENERIC PWM SERVO DRIVER
> > +M:   "Angelo Compagnucci" <angelo@amarulasolutions.com>
> > +L:   linux-pwm@vger.kernel.org
> > +S:   Maintained
> > +F:   drivers/misc/servo-pwm.c
> > +
> >  GENERIC RESISTIVE TOUCHSCREEN ADC DRIVER
> >  M:   Eugen Hristev <eugen.hristev@microchip.com>
> >  L:   linux-input@vger.kernel.org
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > index 9947b7892bd5..8a74087149ac 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -518,6 +518,17 @@ config VCPU_STALL_DETECTOR
> >
> >         If you do not intend to run this kernel as a guest, say N.
> >
> > +config SERVO_PWM
> > +     tristate "Servo motor positioning"
> > +     depends on PWM
> > +     help
> > +       Driver to control generic servo motor positioning.
> > +       Writing to the "angle" device attribute, the motor will move to
> > +       the angle position.
> > +
> > +       To compile this driver as a module, choose M here: the module
> > +       will be called servo-pwm.
> > +
> >  source "drivers/misc/c2port/Kconfig"
> >  source "drivers/misc/eeprom/Kconfig"
> >  source "drivers/misc/cb710/Kconfig"
> > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> > index 87b54a4a4422..936629b648a9 100644
> > --- a/drivers/misc/Makefile
> > +++ b/drivers/misc/Makefile
> > @@ -64,3 +64,4 @@ obj-$(CONFIG_HI6421V600_IRQ)        += hi6421v600-irq.o
> >  obj-$(CONFIG_OPEN_DICE)              += open-dice.o
> >  obj-$(CONFIG_GP_PCI1XXXX)    += mchp_pci1xxxx/
> >  obj-$(CONFIG_VCPU_STALL_DETECTOR)    += vcpu_stall_detector.o
> > +obj-$(CONFIG_SERVO_PWM)      += servo-pwm.o
> > diff --git a/drivers/misc/servo-pwm.c b/drivers/misc/servo-pwm.c
> > new file mode 100644
> > index 000000000000..1303ddda8d07
> > --- /dev/null
> > +++ b/drivers/misc/servo-pwm.c
> > @@ -0,0 +1,149 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2023 Angelo Compagnucci <angelo@amarulasolutions.com>
> > + * servo-pwm.c - driver for controlling servo motors via pwm.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/err.h>
> > +#include <linux/pwm.h>
> > +
> > +#define DEFAULT_DUTY_MIN     500000
> > +#define DEFAULT_DUTY_MAX     2500000
> > +#define DEFAULT_DEGREES              175
> > +#define DEFAULT_ANGLE                0
> > +
> > +struct servo_pwm_data {
> > +     u32 duty_min;
> > +     u32 duty_max;
> > +     u32 degrees;
> > +     u32 angle;
> > +
> > +     struct mutex lock;
> > +     struct pwm_device *pwm;
> > +     struct pwm_state pwmstate;
> > +};
> > +
> > +static int servo_pwm_set(struct servo_pwm_data *data, int val)
> > +{
> > +     u64 new_duty = (((data->duty_max - data->duty_min) /
> > +                     data->degrees) * val) + data->duty_min;
>
> This one formula is basically the only thing that this driver adds. The
> remaining 150+ lines are essentially boilerplate to expose the "angle"
> property via sysfs.
>
> We can already do everything that this driver does via the PWM sysfs, so
> I wonder if we really need this.

That's true, but anyway it's a big improvement over writing each one
of the servo parameters inside the sysfs one by one.
Moreover, it makes easier to handle a product based on several servo motors.

> Also, how are other aspects of the motor (such as velocity) controlled?
> Wouldn't you want to expose these other controls as well?

As far as I can tell, a basic servo motor only offers a way to change
the angle through PWM duty cycle.
The speed is controlled by the driver inside the motor: the bigger is
the angle, the faster it moves.

There are more complex servos out there, but they don't use plain
simple PWM like those, they usually use some sort of more complex
digital protocol on busses like I2C, SPI, DMX.

>
> Thierry



-- 

Angelo Compagnucci

Software Engineer

angelo@amarulasolutions.com
__________________________________
Amarula Solutions SRL

Via le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 (0)42 243 5310
info@amarulasolutions.com

www.amarulasolutions.com

[`as] https://www.amarulasolutions.com|
