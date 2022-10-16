Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1CC600110
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 18:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiJPQKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 12:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiJPQKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 12:10:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3111533A3F;
        Sun, 16 Oct 2022 09:10:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA96560C1A;
        Sun, 16 Oct 2022 16:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CEB5C433C1;
        Sun, 16 Oct 2022 16:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665936650;
        bh=WW35MKrR/AqyEvrmTwfRIBE8KXiYsf7Y5w9hJYBzD1c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UrCsui1lGekvdMxkSTH4CcdR/5Wgd/J4zQ2UslJQ4Us+itzNMY88byzqH7GTjiNuZ
         hYHgckefGTtfd7ikn+lVzdSlgCpylXJkA3zlAircUrTNne93vZqnEmK3sZYD193+6R
         zI/xiPx/YIzZWOzuN5LUDbC2q9GfGfypVor53NA1jhHGbabvRrsmPVjA7Kc68pqWdT
         lMZE4SVlMvC5XqFvXZvFDUP4dUBEXfVbL7S9UyBtxOmO6JSt4NayJREi8OAstTliip
         5dv6+YQEBrOyBWBd+V4SXpFSLbfg63ElJx/tfISYU1P2fUdW4anipZvKffW6ml+REp
         cKZ/dfiL/OPoA==
Date:   Sun, 16 Oct 2022 17:11:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/14] iio: st_lsm6dsx: Simplify using
 devm_regulator_*get_enable()
Message-ID: <20221016171116.51fee259@jic23-huawei>
In-Reply-To: <876e58428cec056d51070e49eff559e2d7c23b12.1660934107.git.mazziesaccount@gmail.com>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
        <876e58428cec056d51070e49eff559e2d7c23b12.1660934107.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Aug 2022 22:19:46 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Use devm_regulator_bulk_get_enable() instead of open coded bulk-get,
> bulk-enable, add-action-to-disable-at-detach - pattern.
> 
> A functional change (which seems like a bugfix) is that if
> regulator_bulk_get fails, the enable is not attempted.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Applied with similar ordering, patch naming and spacing tweaks to earlier patches.

> 
> ---
> v2 => v3
> Split to own patch.
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  2 --
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 30 ++++----------------
>  2 files changed, 5 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index a86dd29a4738..03238c64c777 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -372,7 +372,6 @@ struct st_lsm6dsx_sensor {
>   * struct st_lsm6dsx_hw - ST IMU MEMS hw instance
>   * @dev: Pointer to instance of struct device (I2C or SPI).
>   * @regmap: Register map of the device.
> - * @regulators: VDD/VDDIO voltage regulators.
>   * @irq: Device interrupt line (I2C or SPI).
>   * @fifo_lock: Mutex to prevent concurrent access to the hw FIFO.
>   * @conf_lock: Mutex to prevent concurrent FIFO configuration update.
> @@ -395,7 +394,6 @@ struct st_lsm6dsx_sensor {
>  struct st_lsm6dsx_hw {
>  	struct device *dev;
>  	struct regmap *regmap;
> -	struct regulator_bulk_data regulators[2];
>  	int irq;
>  
>  	struct mutex fifo_lock;
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index b5e4a4113652..c328d1a36d34 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -2172,36 +2172,20 @@ static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
>  
>  static int st_lsm6dsx_init_regulators(struct device *dev)
>  {
> -	struct st_lsm6dsx_hw *hw = dev_get_drvdata(dev);
>  	int err;
> -
>  	/* vdd-vddio power regulators */
> -	hw->regulators[0].supply = "vdd";
> -	hw->regulators[1].supply = "vddio";
> -	err = devm_regulator_bulk_get(dev, ARRAY_SIZE(hw->regulators),
> -				      hw->regulators);
> -	if (err)
> -		return dev_err_probe(dev, err, "failed to get regulators\n");
> +	static const char * const regulators[] = {"vdd", "vddio"};
>  
> -	err = regulator_bulk_enable(ARRAY_SIZE(hw->regulators),
> -				    hw->regulators);
> -	if (err) {
> -		dev_err(dev, "failed to enable regulators: %d\n", err);
> -		return err;
> -	}
> +	err = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulators),
> +					     regulators);
> +	if (err)
> +		return dev_err_probe(dev, err, "failed to enable regulators\n");
>  
>  	msleep(50);
>  
>  	return 0;
>  }
>  
> -static void st_lsm6dsx_chip_uninit(void *data)
> -{
> -	struct st_lsm6dsx_hw *hw = data;
> -
> -	regulator_bulk_disable(ARRAY_SIZE(hw->regulators), hw->regulators);
> -}
> -
>  int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
>  		     struct regmap *regmap)
>  {
> @@ -2225,10 +2209,6 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
>  	if (err)
>  		return err;
>  
> -	err = devm_add_action_or_reset(dev, st_lsm6dsx_chip_uninit, hw);
> -	if (err)
> -		return err;
> -
>  	hw->buff = devm_kzalloc(dev, ST_LSM6DSX_BUFF_SIZE, GFP_KERNEL);
>  	if (!hw->buff)
>  		return -ENOMEM;

