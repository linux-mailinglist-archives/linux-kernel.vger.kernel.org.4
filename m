Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1356F73432E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 20:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjFQSro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 14:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjFQSrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 14:47:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369C01BC9;
        Sat, 17 Jun 2023 11:47:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C789D60E05;
        Sat, 17 Jun 2023 18:47:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63158C433C8;
        Sat, 17 Jun 2023 18:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687027660;
        bh=m0CQFBoYmUiRYDj55FI2nrcjYhtS/rh2V9Ro9GwQUSU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y+5WsWZ+tPPpk1b+nStghKGv5I70f21sSWd9w6XAoBbBoMJcjHFZqQI7hi58NVCHj
         55pNuWpX39FmC1XmKFSe19HBs4x+n33x8mAjeAbhiXLOZihF5w07OVkTM0H4Og/uWH
         SAJ+URz7FgGqFAIFEq+L6HBUEpKl8GrLywFqxQfJgxeMZE5yCv3e5o44Os3KBFnjzK
         WKFHYJL71/ntYnY7WYVVKUa1vuhpfbURdO6rBJVmMLvmZ3VAH78vo8rnbaIvIdoXfS
         ywLDq9Juss7QT9QKax8g4aGuu6reX06sre5zqmbLQCa2y23ToEV0eLaUBPF4ppnBpF
         UA5rs0U9jb2Iw==
Date:   Sat, 17 Jun 2023 19:47:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: st_sensors: Remove some redundant includes
Message-ID: <20230617194734.5dad2f06@jic23-huawei>
In-Reply-To: <045ca726a9108325a3eaace807a264170895686c.1686600780.git.christophe.jaillet@wanadoo.fr>
References: <045ca726a9108325a3eaace807a264170895686c.1686600780.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2023 22:13:36 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> st_sensors_(i2c|spi).h already include st_sensors.h, so there is no need
> to include it explicitly.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Mostly we try to avoid implicit includes that might not be around
for ever as it makes changing internals of headers have messy side effects.
In this particular case I'd argue that the _spi.h and _i2c.h should
not be including st_sensors.h rather than the other way around.

There is nothing in those headers that uses anything from
st_sensors.h

They should probably use forward definitions of
struct iio_dev and struct spi_device etc to avoid need to include
anything at all.

Jonathan
 


> ---
>  drivers/iio/accel/st_accel_spi.c       | 1 -
>  drivers/iio/gyro/st_gyro_i2c.c         | 1 -
>  drivers/iio/gyro/st_gyro_spi.c         | 1 -
>  drivers/iio/magnetometer/st_magn_i2c.c | 1 -
>  drivers/iio/magnetometer/st_magn_spi.c | 1 -
>  drivers/iio/pressure/st_pressure_i2c.c | 1 -
>  drivers/iio/pressure/st_pressure_spi.c | 1 -
>  7 files changed, 7 deletions(-)
> 
> diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
> index f72a24f45322..ae5bf3b47209 100644
> --- a/drivers/iio/accel/st_accel_spi.c
> +++ b/drivers/iio/accel/st_accel_spi.c
> @@ -13,7 +13,6 @@
>  #include <linux/spi/spi.h>
>  #include <linux/iio/iio.h>
>  
> -#include <linux/iio/common/st_sensors.h>
>  #include <linux/iio/common/st_sensors_spi.h>
>  #include "st_accel.h"
>  
> diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
> index 5a10a3556ab0..ceebd246100c 100644
> --- a/drivers/iio/gyro/st_gyro_i2c.c
> +++ b/drivers/iio/gyro/st_gyro_i2c.c
> @@ -13,7 +13,6 @@
>  #include <linux/i2c.h>
>  #include <linux/iio/iio.h>
>  
> -#include <linux/iio/common/st_sensors.h>
>  #include <linux/iio/common/st_sensors_i2c.h>
>  #include "st_gyro.h"
>  
> diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
> index 22aaabe48e4a..afdb8dffd72d 100644
> --- a/drivers/iio/gyro/st_gyro_spi.c
> +++ b/drivers/iio/gyro/st_gyro_spi.c
> @@ -13,7 +13,6 @@
>  #include <linux/spi/spi.h>
>  #include <linux/iio/iio.h>
>  
> -#include <linux/iio/common/st_sensors.h>
>  #include <linux/iio/common/st_sensors_spi.h>
>  #include "st_gyro.h"
>  
> diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
> index 950826dd20bf..b9221794cf00 100644
> --- a/drivers/iio/magnetometer/st_magn_i2c.c
> +++ b/drivers/iio/magnetometer/st_magn_i2c.c
> @@ -13,7 +13,6 @@
>  #include <linux/i2c.h>
>  #include <linux/iio/iio.h>
>  
> -#include <linux/iio/common/st_sensors.h>
>  #include <linux/iio/common/st_sensors_i2c.h>
>  #include "st_magn.h"
>  
> diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
> index f203e1f87eec..5540500ba9fa 100644
> --- a/drivers/iio/magnetometer/st_magn_spi.c
> +++ b/drivers/iio/magnetometer/st_magn_spi.c
> @@ -13,7 +13,6 @@
>  #include <linux/spi/spi.h>
>  #include <linux/iio/iio.h>
>  
> -#include <linux/iio/common/st_sensors.h>
>  #include <linux/iio/common/st_sensors_spi.h>
>  #include "st_magn.h"
>  
> diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
> index 5101552e3f38..8ba0d1212401 100644
> --- a/drivers/iio/pressure/st_pressure_i2c.c
> +++ b/drivers/iio/pressure/st_pressure_i2c.c
> @@ -14,7 +14,6 @@
>  #include <linux/i2c.h>
>  #include <linux/iio/iio.h>
>  
> -#include <linux/iio/common/st_sensors.h>
>  #include <linux/iio/common/st_sensors_i2c.h>
>  #include "st_pressure.h"
>  
> diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
> index 25cca5ad7c55..ffa1970a5aeb 100644
> --- a/drivers/iio/pressure/st_pressure_spi.c
> +++ b/drivers/iio/pressure/st_pressure_spi.c
> @@ -13,7 +13,6 @@
>  #include <linux/spi/spi.h>
>  #include <linux/iio/iio.h>
>  
> -#include <linux/iio/common/st_sensors.h>
>  #include <linux/iio/common/st_sensors_spi.h>
>  #include "st_pressure.h"
>  

