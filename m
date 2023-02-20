Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC4669CA03
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 12:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbjBTLkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 06:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjBTLkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 06:40:22 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC271A96B;
        Mon, 20 Feb 2023 03:40:18 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id cq23so3203939edb.1;
        Mon, 20 Feb 2023 03:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VRCEwvwi2KzPnPQXYXOatI2EQlUGZQ2IotXh1B453Y=;
        b=YYgFYoQN8cskpSp1FCzyfaPDlY82tlp3k96AIY0b80XP+OFZGPV6Jk+d9KlkPMwDzz
         1Qw1eBFwYSGycbxgkViUM/4g3JCpJNKOc3n7x62zPBsl7Cv0gnR9c+1I92Z5jEQGlF1k
         YM89egyppyCFf8078jBpwYZ2wLc8x8Tw2pG29NzshjZccK1QNraV2j2w8vsCfCD3fkLO
         3XLmGowAbxB8wWTpLwHjEPEJySq09UiyUGNP2lVuO+K7RbMsKv8VhC/5tT6tzb8PkHO4
         +/gg6jQj+fKzWJKULoqgqDFhn/ifzquqCVwE+d45dsT2w2CF/6oNC0SDA+f7/vj4n70O
         K01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7VRCEwvwi2KzPnPQXYXOatI2EQlUGZQ2IotXh1B453Y=;
        b=uZzqzS6LyXuT+t65PmyEfgw4MJWu27TkgCN56GCxZ4p3tLskYWwRjdn/u4nsAYcKvF
         LdSSfQEucri6nqTEIu2aPrMdQhREQEXFIoKbjbXFsClpKptOGl4/toHDG/OlAElyAS4y
         NY6aoS87oWln2GwrnHCqFkFnvb5jtgDwF1IpgXAOedzmKF09fIURAVmcNizcjQMHAoRn
         XHnag+9qQwsOAOgNHCqlkyow7Txy1OI6VSPeV1nh1CtFmKctDAb61DsbO/qRlNcMK+kx
         GhV7hSiDRwBv6mcb+RhkdSYpDTBFAPQ9xA6giLIj7MST0VKqCyNi4BNq1OffUdZRbHzr
         3KLg==
X-Gm-Message-State: AO0yUKXCBfFpMavePpkR6OGODawY6jeBOJrys7XW8Crsmx9OT81SWS/e
        LelUDzVLhqzjZqIo/LjteKQLKb6iZl4=
X-Google-Smtp-Source: AK7set9Uqr1PmUDK49C/r7AJu01IIDDmMlV9UNtrTMl9BG5JWtjbEh6hMUz03a56Cu9/r29IeIe+BA==
X-Received: by 2002:a17:906:86d4:b0:87b:3d29:2982 with SMTP id j20-20020a17090686d400b0087b3d292982mr9049349ejy.11.1676893216544;
        Mon, 20 Feb 2023 03:40:16 -0800 (PST)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id e9-20020a170906374900b008cb7473e488sm1968726ejc.12.2023.02.20.03.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 03:40:16 -0800 (PST)
Date:   Mon, 20 Feb 2023 12:40:14 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Angelo Compagnucci <angelo.compagnucci@gmail.com>
Cc:     Angelo Compagnucci <angelo@amarulasolutions.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:GENERIC PWM SERVO DRIVER" <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] misc: servo-pwm: driver for controlling servo
 motors via PWM
Message-ID: <Y/NcHjpet0DxLJrl@orome>
References: <20230217161038.3130053-1-angelo@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IrcY/ZtmnJ+P8XWD"
Content-Disposition: inline
In-Reply-To: <20230217161038.3130053-1-angelo@amarulasolutions.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IrcY/ZtmnJ+P8XWD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 17, 2023 at 05:10:35PM +0100, Angelo Compagnucci wrote:
> This patch adds a simple driver to control servo motor position via
> PWM signal.
> The driver allows to set the angle from userspace, while min/max
> positions duty cycle and the motor degrees aperture are defined in
> the dts.
>=20
> Signed-off-by: Angelo Compagnucci <angelo@amarulasolutions.com>
> ---
> v2:
> * Driver mostly rewritten for kernel 6.2
> v3:
> * Fixed sysfs_emit (greg k-h)
>=20
>  MAINTAINERS              |   6 ++
>  drivers/misc/Kconfig     |  11 +++
>  drivers/misc/Makefile    |   1 +
>  drivers/misc/servo-pwm.c | 149 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 167 insertions(+)
>  create mode 100644 drivers/misc/servo-pwm.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 39ff1a717625..8f4af64deb1b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8737,6 +8737,12 @@ F:	Documentation/devicetree/bindings/power/power?d=
omain*
>  F:	drivers/base/power/domain*.c
>  F:	include/linux/pm_domain.h
> =20
> +GENERIC PWM SERVO DRIVER
> +M:	"Angelo Compagnucci" <angelo@amarulasolutions.com>
> +L:	linux-pwm@vger.kernel.org
> +S:	Maintained
> +F:	drivers/misc/servo-pwm.c
> +
>  GENERIC RESISTIVE TOUCHSCREEN ADC DRIVER
>  M:	Eugen Hristev <eugen.hristev@microchip.com>
>  L:	linux-input@vger.kernel.org
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 9947b7892bd5..8a74087149ac 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -518,6 +518,17 @@ config VCPU_STALL_DETECTOR
> =20
>  	  If you do not intend to run this kernel as a guest, say N.
> =20
> +config SERVO_PWM
> +	tristate "Servo motor positioning"
> +	depends on PWM
> +	help
> +	  Driver to control generic servo motor positioning.
> +	  Writing to the "angle" device attribute, the motor will move to
> +	  the angle position.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called servo-pwm.
> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 87b54a4a4422..936629b648a9 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -64,3 +64,4 @@ obj-$(CONFIG_HI6421V600_IRQ)	+=3D hi6421v600-irq.o
>  obj-$(CONFIG_OPEN_DICE)		+=3D open-dice.o
>  obj-$(CONFIG_GP_PCI1XXXX)	+=3D mchp_pci1xxxx/
>  obj-$(CONFIG_VCPU_STALL_DETECTOR)	+=3D vcpu_stall_detector.o
> +obj-$(CONFIG_SERVO_PWM)	+=3D servo-pwm.o
> diff --git a/drivers/misc/servo-pwm.c b/drivers/misc/servo-pwm.c
> new file mode 100644
> index 000000000000..1303ddda8d07
> --- /dev/null
> +++ b/drivers/misc/servo-pwm.c
> @@ -0,0 +1,149 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2023 Angelo Compagnucci <angelo@amarulasolutions.com>
> + * servo-pwm.c - driver for controlling servo motors via pwm.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/err.h>
> +#include <linux/pwm.h>
> +
> +#define DEFAULT_DUTY_MIN	500000
> +#define DEFAULT_DUTY_MAX	2500000
> +#define DEFAULT_DEGREES		175
> +#define DEFAULT_ANGLE		0
> +
> +struct servo_pwm_data {
> +	u32 duty_min;
> +	u32 duty_max;
> +	u32 degrees;
> +	u32 angle;
> +
> +	struct mutex lock;
> +	struct pwm_device *pwm;
> +	struct pwm_state pwmstate;
> +};
> +
> +static int servo_pwm_set(struct servo_pwm_data *data, int val)
> +{
> +	u64 new_duty =3D (((data->duty_max - data->duty_min) /
> +			data->degrees) * val) + data->duty_min;

This one formula is basically the only thing that this driver adds. The
remaining 150+ lines are essentially boilerplate to expose the "angle"
property via sysfs.

We can already do everything that this driver does via the PWM sysfs, so
I wonder if we really need this.

Also, how are other aspects of the motor (such as velocity) controlled?
Wouldn't you want to expose these other controls as well?

Thierry

--IrcY/ZtmnJ+P8XWD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmPzXBwACgkQ3SOs138+
s6Ggdw/+KeNkMeFH4jH8So1hgLn8V0bv4fGqFzXhcZ6E46RLb1p8ZIBQ9Wt0YN09
JORAgEv7+RQJtpeFSLjzHn5jJp1zWFNq2nWYHQj51SfhvvkEcJSSH/Sf4N/npo/g
Nc72gehTbOh7KCk1NL5bvlCm6hEwCpcJDJ29GZQahzpK9dMQZUEnH3W6D+YO7Gwu
e9/JLefgoj5CCaMaXkNjXsbijkmwP5uGjBe1Xzj8BQMWv0180dJ+ziTIM55BMNue
4B1bTaUF75DqXkASsIMYRXBSCdtimtkJJLkjFUR55Ela5y/7OvbLWdqjxVOiP1xS
YANqrZP5nRCWyZ+eDrtYFGIKWvn6v64sNd7qY9oBUtCxK0YZ7fEEfN02daDkjavg
K6rSUu/rxmS/9ezNw/GRud622kJ9lP14fDaiCgd91Djg44d6Olddg6bT1p19eIGZ
rYMpQjC6yclSzfOfWgcuCFuw7G1ixRqDuEADZMpe5xwFp89JsDK6adlM//spcU3o
5HIdtqjDQTcOMKN+SVihAV41JiFb1EGOHYs6imcL/LCTyNO5JUNSORetbHGnQPkE
ESKsr2mslqMGQzSLXZQEPkGPJCvTgEC7Nbl7he1+TcWBQaVBcsNEhX9dM9FIO64K
E89LMnhqjz7+/qoXNXm1eKhWfOeEBGfwDyz83Hi/uhkYJyApP6o=
=LLou
-----END PGP SIGNATURE-----

--IrcY/ZtmnJ+P8XWD--
