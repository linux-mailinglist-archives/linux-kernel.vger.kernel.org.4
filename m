Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833F8713A9D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 18:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjE1Qjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 12:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjE1Qjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 12:39:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AAEA7;
        Sun, 28 May 2023 09:39:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E2A860E33;
        Sun, 28 May 2023 16:39:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC594C433EF;
        Sun, 28 May 2023 16:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685291971;
        bh=hBlRxGA8aRr5jwPDvWB/SpUUZb6GUXDNcRFRO2a7688=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KKUH64CCUpz8rEA2ZI8nqmf2EzeTrj5oHHd/eKj3IC54D8S2kUPF3OiN8wKWabyFf
         6QpE4pwLWAAPzyYtjDurxgWtXXbNr9IIT7NVCEV4p5fZDFhTiWA4lqPHtOJOuWpyZd
         hs/1b5kytmAdh8ktJRnamu9jy0Z7k7NhgR6R/FXST+nRDDL92ngkrKkr3lz2orFu+Y
         wqJD/AVXJgtY8gg1YyDGXBIvqBVjfZ/ni78iCJcA6m4LmxDXVlz0J8Zk6yhtXt2k5O
         AHKggUckXe9RUSFOWhy3hZV8oLYVjSRANBntrlRIPsakasCvzpH4klGoibVQOSRZ+9
         Nm4Ruiqnx9N4g==
Date:   Sun, 28 May 2023 17:55:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     mazziesaccount@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 5/7] iio: accel: kionix-kx022a: Refactor driver and
 add chip_info structure
Message-ID: <20230528175550.4e58f90f@jic23-huawei>
In-Reply-To: <de588a5a3ca311f6dc3a543bfa5cea7b590ae44c.1685109507.git.mehdi.djait.k@gmail.com>
References: <cover.1685109507.git.mehdi.djait.k@gmail.com>
        <de588a5a3ca311f6dc3a543bfa5cea7b590ae44c.1685109507.git.mehdi.djait.k@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 May 2023 16:30:46 +0200
Mehdi Djait <mehdi.djait.k@gmail.com> wrote:

> Add the chip_info structure to the driver's private data to hold all
> the device specific infos.
> Refactor the kx022a driver implementation to make it more generic and
> extensible.
> 
> Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>

Hi Mehdi,

Just one trivial comment from me about missing docs / unused element.

Thanks,

Jonathan

...

> diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-kx022a.h
> index 12424649d438..c23b6f03409e 100644
> --- a/drivers/iio/accel/kionix-kx022a.h
> +++ b/drivers/iio/accel/kionix-kx022a.h
> @@ -76,7 +76,56 @@
>  
>  struct device;
>  
> -int kx022a_probe_internal(struct device *dev);
> -extern const struct regmap_config kx022a_regmap;
> +/**
> + * struct kx022a_chip_info - Kionix accelerometer chip specific information
> + *
> + * @name:		name of the device
> + * @regmap_config:	pointer to register map configuration
> + * @channels:		pointer to iio_chan_spec array
> + * @num_channels:	number of iio_chan_spec channels
> + * @fifo_length:	number of 16-bit samples in a full buffer
> + * @who:		WHO_AM_I register
> + * @id:			WHO_AM_I register value
> + * @cntl:		control register 1
> + * @cntl2:		control register 2
> + * @odcntl:		output data control register
> + * @buf_cntl1:		buffer control register 1
> + * @buf_cntl2:		buffer control register 2
> + * @buf_clear:		buffer clear register
> + * @buf_status1:	buffer status register 1

Missing entry for buf_smp_lvl_mask.

Mind you it's also not used in this patch and only seems to be used in the
get_fifo_bytes() function in patch 7, so might not be needed at all?
If it is, then introduce it in patch 7 where we can see how it is used.

> + * @buf_read:		buffer read register
> + * @inc1:		interrupt control register 1
> + * @inc4:		interrupt control register 4
> + * @inc5:		interrupt control register 5
> + * @inc6:		interrupt control register 6
> + * @xout_l:		x-axis output least significant byte
> + */
> +struct kx022a_chip_info {
> +	const char *name;
> +	const struct regmap_config *regmap_config;
> +	const struct iio_chan_spec *channels;
> +	unsigned int num_channels;
> +	unsigned int fifo_length;
> +	u8 who;
> +	u8 id;
> +	u8 cntl;
> +	u8 cntl2;
> +	u8 odcntl;
> +	u8 buf_cntl1;
> +	u8 buf_cntl2;
> +	u8 buf_clear;
> +	u8 buf_status1;
> +	u16 buf_smp_lvl_mask;
> +	u8 buf_read;
> +	u8 inc1;
> +	u8 inc4;
> +	u8 inc5;
> +	u8 inc6;
> +	u8 xout_l;
> +};
> +
> +int kx022a_probe_internal(struct device *dev, const struct kx022a_chip_info *chip_info);
> +
> +extern const struct kx022a_chip_info kx022a_chip_info;
>  
>  #endif

