Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D656B6044
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 20:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjCKTjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 14:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCKTjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 14:39:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260AF497D5;
        Sat, 11 Mar 2023 11:38:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD766B801BB;
        Sat, 11 Mar 2023 19:38:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C08C4339B;
        Sat, 11 Mar 2023 19:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678563526;
        bh=6WO8g6ZvluePlqYSQy8TEnmDOkoxT5Nke9UDxraWQYk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mN/T6MAqYbgySNH7vKJ7MjBzMF9sALEmH0Uo4prq9FEB2emCj76zVFMnWxoh76qi6
         6NZmSi55zOenk4551KJDY4aNLz+URImLtmEoJovY/lvac9/qeG/BCI7mPg5+glMzXY
         1XC5u/vhoyIp8fjqrPSHs7CcfV0QhbRrRachxuiMYuB1AX0no9UWek9Nqr/BbRt9kp
         E5T9N9DBYUDyQ0WxV/QvDCmpaG3pWs7a5CVrKIJL8bdhAhRzpdUewY/zAeG1yI3l0N
         htIJDs20WOhfILJIA7TFD3xNNRp3Ly4eNDOC9yUwRnoHOiQI/ErOoEzftxdZt5wPfc
         rJbpDXRJstdXQ==
Date:   Sat, 11 Mar 2023 19:38:51 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/4] iio: light: move apds990x into proper place
Message-ID: <20230311193851.42132faf@jic23-huawei>
In-Reply-To: <20230308090219.12710-5-clamor95@gmail.com>
References: <20230308090219.12710-1-clamor95@gmail.com>
        <20230308090219.12710-5-clamor95@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  8 Mar 2023 11:02:19 +0200
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> Since now apds990x supports IIO, it should be moved here from
> misc folder.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

Hi Svyatoslav,

Could you do me a favour and reply to this thread with a copy of the
.c file that is being moved.

We will want to treat this in a similar fashion to as driver graduating
from staging and do a full review of whether it is compliant with IIO ABI
and general code style etc.  That's easier to do if everyone can
see the code in an email for reviewing!

Thanks,

Jonathan


> ---
>  drivers/iio/light/Kconfig              | 10 ++++++++++
>  drivers/iio/light/Makefile             |  1 +
>  drivers/{misc => iio/light}/apds990x.c |  0
>  drivers/misc/Kconfig                   | 10 ----------
>  drivers/misc/Makefile                  |  1 -
>  5 files changed, 11 insertions(+), 11 deletions(-)
>  rename drivers/{misc => iio/light}/apds990x.c (100%)
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 0d4447df7200..49c17eb72c73 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -73,6 +73,16 @@ config APDS9300
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called apds9300.
>  
> +config APDS990X
> +	tristate "APDS990X combined als and proximity sensors"
> +	depends on I2C
> +	help
> +	   Say Y here if you want to build a driver for Avago APDS990x
> +	   combined ambient light and proximity sensor chip.
> +
> +	   To compile this driver as a module, choose M here: the
> +	   module will be called apds990x. If unsure, say N here.
> +
>  config APDS9960
>  	tristate "Avago APDS9960 gesture/RGB/ALS/proximity sensor"
>  	select REGMAP_I2C
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index 6f23817fae6f..f1ff7934318b 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_ADUX1020)		+= adux1020.o
>  obj-$(CONFIG_AL3010)		+= al3010.o
>  obj-$(CONFIG_AL3320A)		+= al3320a.o
>  obj-$(CONFIG_APDS9300)		+= apds9300.o
> +obj-$(CONFIG_APDS990X)		+= apds990x.o
>  obj-$(CONFIG_APDS9960)		+= apds9960.o
>  obj-$(CONFIG_AS73211)		+= as73211.o
>  obj-$(CONFIG_BH1750)		+= bh1750.o
> diff --git a/drivers/misc/apds990x.c b/drivers/iio/light/apds990x.c
> similarity index 100%
> rename from drivers/misc/apds990x.c
> rename to drivers/iio/light/apds990x.c
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 9947b7892bd5..2856b6c57ca0 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -359,16 +359,6 @@ config SENSORS_BH1770
>  	   To compile this driver as a module, choose M here: the
>  	   module will be called bh1770glc. If unsure, say N here.
>  
> -config SENSORS_APDS990X
> -	 tristate "APDS990X combined als and proximity sensors"
> -	 depends on I2C
> -	help
> -	   Say Y here if you want to build a driver for Avago APDS990x
> -	   combined ambient light and proximity sensor chip.
> -
> -	   To compile this driver as a module, choose M here: the
> -	   module will be called apds990x. If unsure, say N here.
> -
>  config HMC6352
>  	tristate "Honeywell HMC6352 compass"
>  	depends on I2C
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 87b54a4a4422..3e3e510cb315 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -18,7 +18,6 @@ obj-$(CONFIG_PHANTOM)		+= phantom.o
>  obj-$(CONFIG_QCOM_COINCELL)	+= qcom-coincell.o
>  obj-$(CONFIG_QCOM_FASTRPC)	+= fastrpc.o
>  obj-$(CONFIG_SENSORS_BH1770)	+= bh1770glc.o
> -obj-$(CONFIG_SENSORS_APDS990X)	+= apds990x.o
>  obj-$(CONFIG_ENCLOSURE_SERVICES) += enclosure.o
>  obj-$(CONFIG_KGDB_TESTS)	+= kgdbts.o
>  obj-$(CONFIG_SGI_XP)		+= sgi-xp/

