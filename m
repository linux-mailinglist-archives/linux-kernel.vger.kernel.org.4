Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B0F6E3298
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 18:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjDOQzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 12:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjDOQzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 12:55:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622E83A9A;
        Sat, 15 Apr 2023 09:55:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A45FD61251;
        Sat, 15 Apr 2023 16:55:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9502C433EF;
        Sat, 15 Apr 2023 16:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681577719;
        bh=J1Or7isc1IonO7C+pDrSjgRe4YEyGUsI4XoPAcGeGa0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JhuluvLlr8i7EvJAXzolhBBn3tIjLuagNPHwQO1Mlvmf9Wz+ydTaULQX6+hQAtigG
         ZUWANqN139+qh7HoA9OdKQGgz6l5Mhh4YAaJrbKJ6okMJA0vnlh0G5zaVoBhxWT2CQ
         Uw4IootU+VfT5sqqLmnUrG+5aDLmixYqB1q5hoHkMzyRmdHQI3xJ6EJXnKXbkQPDXN
         4SSHI3rz4gcIZK692XypCORMfT69QFJkyCk3pSITPGOcSFuj8ThBvOqn8KgR8qk+VE
         GiWLhd93aSU5hck1IxDZwcnq0d1sUCAbOM4XegpADEmk2Sy5AUyaCX3JzjkiwCljwp
         WosT3aKhegWhg==
Date:   Sat, 15 Apr 2023 17:55:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marius Hoch <mail@mariushoch.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 4/6] iio: st_sensors: Add ACPI support for lsm303d to
 the LSM9DS0 IMU driver
Message-ID: <20230415175520.65adfc60@jic23-huawei>
In-Reply-To: <20230413024013.450165-5-mail@mariushoch.de>
References: <20230413024013.450165-1-mail@mariushoch.de>
        <20230413024013.450165-5-mail@mariushoch.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Apr 2023 04:40:11 +0200
Marius Hoch <mail@mariushoch.de> wrote:

> The lsm303d can be found as ACCL0001 on various Lenovo devices,
> including the Lenovo Yoga Tablet 2 1051-F, where I tested this
> patch.
> 
> Signed-off-by: Marius Hoch <mail@mariushoch.de>
> ---
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c | 10 ++++++++++
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c | 10 ++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
> index 64fa77d302e2..79be8d28d965 100644
> --- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
> +++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
> @@ -12,6 +12,7 @@
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/regmap.h>
> +#include <linux/acpi.h>
>  
>  #include <linux/iio/common/st_sensors_i2c.h>
>  
> @@ -37,6 +38,14 @@ static const struct i2c_device_id st_lsm9ds0_id_table[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, st_lsm9ds0_id_table);
>  
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id st_lsm9ds0_acpi_match[] = {
> +	{"ACCL0001", (kernel_ulong_t)LSM303D_IMU_DEV_NAME},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, st_lsm9ds0_acpi_match);
> +#endif

The table is tiny so I'd prefer dropping the complexity of ifdefs
and getting rid of the ACPI_PTR() below. Just assign the pointer
unconditionally.

Rest of the series looks good to me

Thanks,

Jonathan

> +
>  static const struct regmap_config st_lsm9ds0_regmap_config = {
>  	.reg_bits	= 8,
>  	.val_bits	= 8,
> @@ -73,6 +82,7 @@ static struct i2c_driver st_lsm9ds0_driver = {
>  	.driver = {
>  		.name = "st-lsm9ds0-i2c",
>  		.of_match_table = st_lsm9ds0_of_match,
> +		.acpi_match_table = ACPI_PTR(st_lsm9ds0_acpi_match),
>  	},
>  	.probe_new = st_lsm9ds0_i2c_probe,
>  	.id_table = st_lsm9ds0_id_table,
> diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
> index 997b5ff792be..27c5d99ce0e3 100644
> --- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
> +++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
> @@ -12,6 +12,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/regmap.h>
>  #include <linux/spi/spi.h>
> +#include <linux/acpi.h>
>  
>  #include <linux/iio/common/st_sensors_spi.h>
>  
> @@ -37,6 +38,14 @@ static const struct spi_device_id st_lsm9ds0_id_table[] = {
>  };
>  MODULE_DEVICE_TABLE(spi, st_lsm9ds0_id_table);
>  
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id st_lsm9ds0_acpi_match[] = {
> +	{"ACCL0001", (kernel_ulong_t)LSM303D_IMU_DEV_NAME},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, st_lsm9ds0_acpi_match);
> +#endif
> +
>  static const struct regmap_config st_lsm9ds0_regmap_config = {
>  	.reg_bits	= 8,
>  	.val_bits	= 8,
> @@ -72,6 +81,7 @@ static struct spi_driver st_lsm9ds0_driver = {
>  	.driver = {
>  		.name = "st-lsm9ds0-spi",
>  		.of_match_table = st_lsm9ds0_of_match,
> +		.acpi_match_table = ACPI_PTR(st_lsm9ds0_acpi_match),
>  	},
>  	.probe = st_lsm9ds0_spi_probe,
>  	.id_table = st_lsm9ds0_id_table,

