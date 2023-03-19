Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF706C02FE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 17:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjCSQIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 12:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjCSQHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 12:07:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0761DBA3;
        Sun, 19 Mar 2023 09:07:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 273E961085;
        Sun, 19 Mar 2023 16:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C33C433D2;
        Sun, 19 Mar 2023 16:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679242033;
        bh=P7bbJX36lPIR7yaBb2uG4GtPhVToyN0Jes7PnkyVOKg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RzU8Pn/aIzLsAzR9FxTrg7zjBZc/cka+x1MhIaf0lMYWVt4BoGWbb9cKrI0sUn8Ko
         mcTwANEdYJr9JCKDwAH0G0TKPSmbts903CZMiuQOiXcSm1d9QLnF1bNA7LaL37T/Cv
         u4ciGPjvcH3WyDUzTAGhZPzk6UNw+QiPJq8ELvPF+qPdUSwAq0Ftuj2chCiSl5+RoC
         Pp37xxURjBgqxUdcz/F/w70WIRvKCiJ9YsM/yS25AmYb9KHLggGCGATdxWbCXwfSlw
         S8dJWFjvFHpJdK2ryZYRBEpitGTkrNhArSIzIP0pl3NRUmxqVoftpdVsW98uhM7vTO
         +NrM/aXUHBqoQ==
Date:   Sun, 19 Mar 2023 16:22:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     mazziesaccount@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: accel: Add support for Kionix/ROHM KX132
 accelerometer
Message-ID: <20230319162207.77ef0686@jic23-huawei>
In-Reply-To: <6f31fe7dbd142c01315891f6868ff75f7d7cde32.1679009443.git.mehdi.djait.k@gmail.com>
References: <cover.1679009443.git.mehdi.djait.k@gmail.com>
        <6f31fe7dbd142c01315891f6868ff75f7d7cde32.1679009443.git.mehdi.djait.k@gmail.com>
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

On Fri, 17 Mar 2023 00:48:37 +0100
Mehdi Djait <mehdi.djait.k@gmail.com> wrote:

> Add support for the basic accelerometer features such as getting the
> acceleration data via IIO. (raw reads, triggered buffer [data-ready] or
> using the WMI IRQ).
> 
> Datasheet: https://kionixfs.azureedge.net/en/document/KX132-1211-Technical-Reference-Manual-Rev-5.0.pdf
> Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>

Nothing much specific to this patch, most changes will be as a result
of bringing this inline with the changes suggested for patch 2.

thanks,

Jonathan

> ---
>  drivers/iio/accel/kionix-kx022a-i2c.c |   2 +
>  drivers/iio/accel/kionix-kx022a-spi.c |   2 +
>  drivers/iio/accel/kionix-kx022a.c     | 126 ++++++++++++++++++++++++++
>  drivers/iio/accel/kionix-kx022a.h     |  53 +++++++++++
>  4 files changed, 183 insertions(+)
> 
> diff --git a/drivers/iio/accel/kionix-kx022a-i2c.c b/drivers/iio/accel/kionix-kx022a-i2c.c
> index 21c4c0ae1a68..f9b2383c43f1 100644
> --- a/drivers/iio/accel/kionix-kx022a-i2c.c
> +++ b/drivers/iio/accel/kionix-kx022a-i2c.c
> @@ -38,12 +38,14 @@ static int kx022a_i2c_probe(struct i2c_client *i2c)
>  
>  static const struct i2c_device_id kx022a_i2c_id[] = {
>  	{ .name = "kx022a", .driver_data = (kernel_ulong_t)&kx_chip_info[KX022A] },
> +	{ .name = "kx132",  .driver_data = (kernel_ulong_t)&kx_chip_info[KX132] },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, kx022a_i2c_id);
>  
>  static const struct of_device_id kx022a_of_match[] = {
>  	{ .compatible = "kionix,kx022a", .data = &kx_chip_info[KX022A] },
> +	{ .compatible = "kionix,kx132",  .data = &kx_chip_info[KX132] },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, kx022a_of_match);
> diff --git a/drivers/iio/accel/kionix-kx022a-spi.c b/drivers/iio/accel/kionix-kx022a-spi.c
> index ec076af0f261..86a10d6d33ff 100644
> --- a/drivers/iio/accel/kionix-kx022a-spi.c
> +++ b/drivers/iio/accel/kionix-kx022a-spi.c
> @@ -38,12 +38,14 @@ static int kx022a_spi_probe(struct spi_device *spi)
>  
>  static const struct spi_device_id kx022a_spi_id[] = {
>  	{ .name = "kx022a", .driver_data = (kernel_ulong_t)&kx_chip_info[KX022A] },
> +	{ .name = "kx132",  .driver_data = (kernel_ulong_t)&kx_chip_info[KX132] },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, kx022a_spi_id);
>  
>  static const struct of_device_id kx022a_of_match[] = {
>  	{ .compatible = "kionix,kx022a", .data = &kx_chip_info[KX022A] },
> +	{ .compatible = "kionix,kx132",  .data = &kx_chip_info[KX132] },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, kx022a_of_match);
> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> index 27e8642aa8f5..3cacec99f792 100644
> --- a/drivers/iio/accel/kionix-kx022a.c
> +++ b/drivers/iio/accel/kionix-kx022a.c
> @@ -128,6 +128,101 @@ static const struct regmap_config kx022a_regmap_config = {
>  	.cache_type = REGCACHE_RBTREE,
>  };
>  
> +/* Regmap configs kx132 */
> +static const struct regmap_range kx132_volatile_ranges[] = {
> +	{
> +		.range_min = KX132_REG_XADP_L,
> +		.range_max = KX132_REG_COTR,
> +	}, {
> +		.range_min = KX132_REG_TSCP,
> +		.range_max = KX132_REG_INT_REL,
> +	}, {
> +		/* The reset bit will be cleared by sensor */
> +		.range_min = KX132_REG_CNTL2,
> +		.range_max = KX132_REG_CNTL2,
> +	}, {
> +		.range_min = KX132_REG_BUF_STATUS_1,
> +		.range_max = KX132_REG_BUF_READ,
> +	},
> +};
> +
> +static const struct regmap_access_table kx132_volatile_regs = {
> +	.yes_ranges = &kx132_volatile_ranges[0],
> +	.n_yes_ranges = ARRAY_SIZE(kx132_volatile_ranges),
> +};
> +
> +static const struct regmap_range kx132_precious_ranges[] = {
> +	{
> +		.range_min = KX132_REG_INT_REL,
> +		.range_max = KX132_REG_INT_REL,
> +	},
> +};
> +
> +static const struct regmap_access_table kx132_precious_regs = {
> +	.yes_ranges = &kx132_precious_ranges[0],
> +	.n_yes_ranges = ARRAY_SIZE(kx132_precious_ranges),
> +};
> +
> +static const struct regmap_range kx132_read_only_ranges[] = {
> +	{
> +		.range_min = KX132_REG_XADP_L,
> +		.range_max = KX132_REG_INT_REL,
> +	}, {
> +		.range_min = KX132_REG_BUF_STATUS_1,
> +		.range_max = KX132_REG_BUF_STATUS_2,
> +	}, {
> +		.range_min = KX132_REG_BUF_READ,
> +		.range_max = KX132_REG_BUF_READ,
> +	},
> +};
> +
> +static const struct regmap_access_table kx132_ro_regs = {
> +	.no_ranges = &kx132_read_only_ranges[0],
> +	.n_no_ranges = ARRAY_SIZE(kx132_read_only_ranges),
> +};
> +
> +static const struct regmap_range kx132_write_only_ranges[] = {
> +	{
> +		.range_min = KX132_REG_MAN_WAKE,
> +		.range_max = KX132_REG_MAN_WAKE,
> +	}, {
> +		.range_min = KX132_REG_SELF_TEST,
> +		.range_max = KX132_REG_SELF_TEST,
> +	}, {
> +		.range_min = KX132_REG_BUF_CLEAR,
> +		.range_max = KX132_REG_BUF_CLEAR,
> +	},
> +};
> +
> +static const struct regmap_access_table kx132_wo_regs = {
> +	.no_ranges = &kx132_write_only_ranges[0],
> +	.n_no_ranges = ARRAY_SIZE(kx132_write_only_ranges),
> +};
> +
> +static const struct regmap_range kx132_noinc_read_ranges[] = {
> +	{
> +		.range_min = KX132_REG_BUF_READ,
> +		.range_max = KX132_REG_BUF_READ,
> +	},
> +};
> +
> +static const struct regmap_access_table kx132_nir_regs = {
> +	.yes_ranges = &kx132_noinc_read_ranges[0],
> +	.n_yes_ranges = ARRAY_SIZE(kx132_noinc_read_ranges),
> +};
> +
> +static const struct regmap_config kx132_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.volatile_table = &kx132_volatile_regs,
> +	.rd_table = &kx132_wo_regs,
> +	.wr_table = &kx132_ro_regs,
> +	.rd_noinc_table = &kx132_nir_regs,
> +	.precious_table = &kx132_precious_regs,
> +	.max_register = KX132_MAX_REGISTER,
> +	.cache_type = REGCACHE_RBTREE,
> +};
> +
>  static const struct iio_mount_matrix *
>  kx022a_get_mount_matrix(const struct iio_dev *idev,
>  			const struct iio_chan_spec *chan)
> @@ -175,6 +270,13 @@ static const struct iio_chan_spec kx022a_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(3),
>  };
>  
> +static const struct iio_chan_spec kx132_channels[] = {
> +	KX022A_ACCEL_CHAN(X, 0, KX132),
> +	KX022A_ACCEL_CHAN(Y, 1, KX132),
> +	KX022A_ACCEL_CHAN(Z, 2, KX132),
> +	IIO_CHAN_SOFT_TIMESTAMP(3),
> +};
> +
>  /*
>   * The sensor HW can support ODR up to 1600 Hz, which is beyond what most of the
>   * Linux CPUs can handle without dropping samples. Also, the low power mode is
> @@ -249,6 +351,30 @@ const struct kx022a_chip_info kx_chip_info[] = {
>  		.inc6		  = KX022A_REG_INC6,
>  		.xout_l		  = KX022A_REG_XOUT_L,
>  	},
> +	[KX132] = {
> +		.name		  = "kx132",
> +		.type		  = KX132,
> +		.regmap_config	  = &kx132_regmap_config,
> +		.channels	  = kx132_channels,
> +		.num_channels	  = ARRAY_SIZE(kx132_channels),
> +		.fifo_length	  = KX132_FIFO_LENGTH,
> +		.who		  = KX132_REG_WHO,
> +		.id		  = KX132_ID,
> +		.cntl		  = KX132_REG_CNTL,
> +		.cntl2		  = KX132_REG_CNTL2,
> +		.odcntl		  = KX132_REG_ODCNTL,
> +		.buf_cntl1	  = KX132_REG_BUF_CNTL1,
> +		.buf_cntl2	  = KX132_REG_BUF_CNTL2,
> +		.buf_clear	  = KX132_REG_BUF_CLEAR,
> +		.buf_status1	  = KX132_REG_BUF_STATUS_1,
> +		.buf_smp_lvl_mask = KX132_MASK_BUF_SMP_LVL,
> +		.buf_read	  = KX132_REG_BUF_READ,
> +		.inc1		  = KX132_REG_INC1,
> +		.inc4		  = KX132_REG_INC4,
> +		.inc5		  = KX132_REG_INC5,
> +		.inc6		  = KX132_REG_INC6,
> +		.xout_l		  = KX132_REG_XOUT_L,
> +	},
>  };
>  EXPORT_SYMBOL_NS_GPL(kx_chip_info, IIO_KX022A);
>  
> diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-kx022a.h
> index 3bb40e9f5613..7e43bdb37156 100644
> --- a/drivers/iio/accel/kionix-kx022a.h
> +++ b/drivers/iio/accel/kionix-kx022a.h
> @@ -90,8 +90,61 @@
>  #define KX022A_REG_SELF_TEST	0x60
>  #define KX022A_MAX_REGISTER	0x60
>  
> +

Push these down into the c file.

> +#define KX132_REG_WHO		0x13
> +#define KX132_ID		0x3d
> +
> +#define KX132_FIFO_LENGTH	86
> +
> +#define KX132_REG_CNTL2		0x1c
> +#define KX132_REG_CNTL		0x1b
> +#define KX132_MASK_RES		BIT(6)
> +#define KX132_GSEL_2		0x0
> +#define KX132_GSEL_4		BIT(3)
> +#define KX132_GSEL_8		BIT(4)
> +#define KX132_GSEL_16		GENMASK(4, 3)
> +
> +#define KX132_REG_INS2		0x17
> +#define KX132_MASK_INS2_WMI	BIT(5)
> +
> +#define KX132_REG_XADP_L	0x02
> +#define KX132_REG_XOUT_L	0x08
> +#define KX132_REG_YOUT_L	0x0a
> +#define KX132_REG_ZOUT_L	0x0c
> +#define KX132_REG_COTR		0x12
> +#define KX132_REG_TSCP		0x14
> +#define KX132_REG_INT_REL	0x1a
> +
> +#define KX132_REG_ODCNTL	0x21
> +
> +#define KX132_REG_BTS_WUF_TH	0x4a
> +#define KX132_REG_MAN_WAKE	0x4d
> +
> +#define KX132_REG_BUF_CNTL1	0x5e
> +#define KX132_REG_BUF_CNTL2	0x5f
> +#define KX132_REG_BUF_STATUS_1	0x60
> +#define KX132_REG_BUF_STATUS_2	0x61
> +#define KX132_MASK_BUF_SMP_LVL	GENMASK(9, 0)
> +#define KX132_REG_BUF_CLEAR	0x62
> +#define KX132_REG_BUF_READ	0x63
> +#define KX132_ODR_SHIFT		3
> +#define KX132_FIFO_MAX_WMI_TH	86
> +
> +#define KX132_REG_INC1		0x22
> +#define KX132_REG_INC5		0x26
> +#define KX132_REG_INC6		0x27
> +#define KX132_IPOL_LOW		0
> +#define KX132_IPOL_HIGH		KX_MASK_IPOL
> +#define KX132_ITYP_PULSE	KX_MASK_ITYP
> +
> +#define KX132_REG_INC4		0x25
> +
> +#define KX132_REG_SELF_TEST	0x5d
> +#define KX132_MAX_REGISTER	0x76
> +
>  enum kx022a_device_type {
>  	KX022A,
> +	KX132,
As mentioned in previous review, I think this would be neater
done by just exporting the chip_info structures directly rather than
putting them in an array.

>  };
>  
>  enum {

