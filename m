Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BEC6DBBF3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 17:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjDHPg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 11:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjDHPg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 11:36:27 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C563EBDFB;
        Sat,  8 Apr 2023 08:36:25 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id h24so1351999plr.1;
        Sat, 08 Apr 2023 08:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680968185; x=1683560185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f5t3AuDYeankzi6hnhNs+aHg6q95No4+4bEk6pENF0Y=;
        b=C+YUX5zusn1dVa9qof4WQPQuMIHS7lI3S5bdu7dI3qOBWTFtPsktKhsJY6B8n3Sju5
         Lz74r/IwP5He8AP/z+aBrY0l6hjJTFpncGpwf4zb4468mSV+p1Hd9LEXvEaj9RhHxfWN
         HTVVqwdFg2U+5+n6gEvckqB6In76Yyfin1Xd8Oq2ErIz/GUHxuXn38dUWbYOdmLuAZvw
         B8jFnVy+o9jeAi0yYZQscUtEU99bLXkrgBT4P4cnTNtdm9Lf7+3kjR7GMmGiepg4yFuq
         uo0CVKFYtynX7K7DUjvlbJesCQOAPOs+yUl7yaNM1so8O+dSQm76mrhHIUcV0geILUQl
         ArtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680968185; x=1683560185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5t3AuDYeankzi6hnhNs+aHg6q95No4+4bEk6pENF0Y=;
        b=MbL1Kch0SBs70ze9NB+PgoJuCo8+Hq6GweAxQKOL1GehE7+CCPJm3jd77DhpLoZl63
         8KMUPn7kTjXY7qAPrx0NGFQwsaL/NJxx+IkCqUflI216f5LQG9ZDvua6BxVxhTej/ofl
         5vA2Y2N6EHu9JeUg/A5q5DmcsGbqJcRr8YxMyFxXmLVEqHV17UTo5kafbaCp0TalOM+q
         UxzpGipBKykSPjoIj3ssXq4uIpztkDFa5OhHCHyDUpLsUYLdJrmCImdK7c1fmSk9Z2v7
         cA1gUWnIAk2Ltcws5Pb5dnpcNEN10Rb0DQUUjeztDYt4vRSU6RzVzEORL+Stgs5k8kmK
         yneQ==
X-Gm-Message-State: AAQBX9e0HdY3LwpXEUpPrcef2WG97W1G8lIgiAr6U2pfY3NnCAMlKMki
        IqN7JHkGwRNTeeX5kP3bUVEmdOyv0Wc=
X-Google-Smtp-Source: AKy350ZWZhZXxy91AQ5uHFcuvy0B45VlYPZ4Vph09MaCSI++TffO9x6BpQAiYEl4ehCZB+qnUxHPFA==
X-Received: by 2002:a17:90b:4c0a:b0:244:af8c:295e with SMTP id na10-20020a17090b4c0a00b00244af8c295emr7295429pjb.26.1680968185200;
        Sat, 08 Apr 2023 08:36:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r5-20020a17090b050500b0023b3a9fa603sm6291700pjz.55.2023.04.08.08.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 08:36:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 8 Apr 2023 08:36:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Cc:     robh+dt@kernel.org, jdelvare@suse.com,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/5] hwmon: (pmbus/acbel-fsg032) Add Acbel power supply
Message-ID: <e8b3489a-8386-4557-8f28-3465bd1589d0@roeck-us.net>
References: <20230322114623.2278920-1-lakshmiy@us.ibm.com>
 <20230322114623.2278920-4-lakshmiy@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322114623.2278920-4-lakshmiy@us.ibm.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 06:46:21AM -0500, Lakshmi Yadlapati wrote:
> Add the driver to support ACBEL FSG032 power supply.
> 
> Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
> ---
>  drivers/hwmon/pmbus/Kconfig        |  9 +++
>  drivers/hwmon/pmbus/Makefile       |  1 +
>  drivers/hwmon/pmbus/acbel-fsg032.c | 96 ++++++++++++++++++++++++++++++
>  3 files changed, 106 insertions(+)
>  create mode 100644 drivers/hwmon/pmbus/acbel-fsg032.c
> 
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 59d9a7430499..270b6336b76d 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -27,6 +27,15 @@ config SENSORS_PMBUS
>  	  This driver can also be built as a module. If so, the module will
>  	  be called pmbus.
>  
> +config SENSORS_ACBEL_FSG032
> +	tristate "ACBEL FSG032 Power Supply"
> +	help
> +	  If you say yes here you get hardware monitoring support for the ACBEL
> +	  FSG032 Power Supply.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called acbel-fsg032.
> +
>  config SENSORS_ADM1266
>  	tristate "Analog Devices ADM1266 Sequencer"
>  	select CRC8
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 3ae019916267..84ee960a6c2d 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -5,6 +5,7 @@
>  
>  obj-$(CONFIG_PMBUS)		+= pmbus_core.o
>  obj-$(CONFIG_SENSORS_PMBUS)	+= pmbus.o
> +obj-$(CONFIG_SENSORS_ACBEL_FSG032) += acbel-fsg032.o
>  obj-$(CONFIG_SENSORS_ADM1266)	+= adm1266.o
>  obj-$(CONFIG_SENSORS_ADM1275)	+= adm1275.o
>  obj-$(CONFIG_SENSORS_BEL_PFE)	+= bel-pfe.o
> diff --git a/drivers/hwmon/pmbus/acbel-fsg032.c b/drivers/hwmon/pmbus/acbel-fsg032.c
> new file mode 100644
> index 000000000000..7bfa0bf048db
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/acbel-fsg032.c
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright 2023 IBM Corp.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/fs.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/pmbus.h>
> +#include <linux/hwmon-sysfs.h>
> +#include "pmbus.h"
> +
> +struct acbel_fsg032 {
> +	struct i2c_client *client;
> +};

Not used anywhere and pointless.

> +
> +static const struct i2c_device_id acbel_fsg032_id[] = {
> +	{ "acbel_fsg032" },
> +	{}
> +};
> +
> +static struct pmbus_driver_info acbel_fsg032_info = {
> +	.pages = 1,
> +	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN | PMBUS_HAVE_PIN |
> +		   PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT | PMBUS_HAVE_POUT |
> +		   PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3 |
> +		   PMBUS_HAVE_FAN12 | PMBUS_HAVE_STATUS_VOUT |
> +		   PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_TEMP |
> +		   PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_FAN12,
> +};
> +
> +static int acbel_fsg032_probe(struct i2c_client *client)
> +{
> +	struct acbel_fsg032 *psu;
> +	u8 buf[I2C_SMBUS_BLOCK_MAX + 1];
> +	struct device *dev = &client->dev;
> +	int rc;
> +
> +	rc = i2c_smbus_read_block_data(client, PMBUS_MFR_ID, buf);
> +	if (rc < 0) {
> +		dev_err(dev, "Failed to read PMBUS_MFR_ID\n");
> +		return rc;
> +	}
> +	if (strncmp(buf, "ACBEL", 5)) {
> +		buf[rc] = '\0';
> +		dev_err(dev, "Manufacturer '%s' not supported\n", buf);
> +		return -ENODEV;
> +	}
> +
> +	rc = i2c_smbus_read_block_data(client, PMBUS_MFR_MODEL, buf);
> +	if (rc < 0) {
> +		dev_err(dev, "Failed to read PMBUS_MFR_MODEL\n");
> +		return rc;
> +	}
> +
> +	if (strncmp(buf, "FSG032", 6)) {
> +		buf[rc] = '\0';
> +		dev_err(dev, "Model '%s' not supported\n", buf);
> +		return -ENODEV;
> +	}
> +
> +	rc = pmbus_do_probe(client, &acbel_fsg032_info);
> +	if (rc)
> +		return rc;
> +	/*
> +         * Don't fail the probe if there isn't enough memory for debugfs.
> +         */
> +	psu = devm_kzalloc(&client->dev, sizeof(*psu), GFP_KERNEL);
> +	if (!psu)
> +		return 0;

'psu is not used anywhere and allocating it is pointless. I am quite sure
that I did bring that up before.

Guenter
