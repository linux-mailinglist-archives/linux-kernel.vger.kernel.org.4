Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0499760010C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 18:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJPQHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 12:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiJPQHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 12:07:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D20617AA0;
        Sun, 16 Oct 2022 09:07:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D903AB80C9D;
        Sun, 16 Oct 2022 16:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE592C433D6;
        Sun, 16 Oct 2022 16:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665936461;
        bh=YRah/rWkKWpnbsD1DVLNuYqENVvOWhUtpIvik3l1bOk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lD2Qzrv8NuEIb4wSSsbmumkSqXwiiWTP8CzJzRycoywEWDV6zap79dtKhgDaZU3Gy
         AeLiiY0iEXHW99tds0IDy8tb1BoV/vsdYvSe04EnQ4ZS3HcWFpMkcSPK7s5S4I99AI
         G1kSNs45U80YwV/4Ha8qh0sP7w4BdRqPTaUTRuceAd3ND49yFXi6RZ/zDyayTlmAy4
         qfnY2QqTvBCUoQzF8MS62KGvxSXJDM4oXN+/doIhp8tDIJy3ssHJerV3N8cakFqCXW
         gIlxvyapkUKSMD6GcGYAEhH6Q6Mu8zGHXVeWLaMrp5D7Kw6zewJjPInuocICGKm6m4
         vkST4xD2PJzeg==
Date:   Sun, 16 Oct 2022 17:08:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Miaoqian Lin <linmq006@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Xiang wangx <wangxiang@cdjrlc.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/14] iio: bmg160_core: Simplify using
 devm_regulator_*get_enable()
Message-ID: <20221016170808.341aa08b@jic23-huawei>
In-Reply-To: <3fd11489356b1c73a3d7b4bd9dec7e12c9fe8788.1660934107.git.mazziesaccount@gmail.com>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
        <3fd11489356b1c73a3d7b4bd9dec7e12c9fe8788.1660934107.git.mazziesaccount@gmail.com>
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

On Fri, 19 Aug 2022 22:19:31 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Use devm_regulator_bulk_get_enable() instead of open coded bulk-get,
> bulk-enable, add-action-to-disable-at-detach - pattern.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Applied with tweaks:
- patch title includes gyro:
- ordering as Andy suggested
- spaces after { and before }
> 
> ---
> v2 => v3
> Split to own patch.
> ---
>  drivers/iio/gyro/bmg160_core.c | 24 +++---------------------
>  1 file changed, 3 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
> index cedd9f02ea21..baa80980c99f 100644
> --- a/drivers/iio/gyro/bmg160_core.c
> +++ b/drivers/iio/gyro/bmg160_core.c
> @@ -93,7 +93,6 @@
>  
>  struct bmg160_data {
>  	struct regmap *regmap;
> -	struct regulator_bulk_data regulators[2];
>  	struct iio_trigger *dready_trig;
>  	struct iio_trigger *motion_trig;
>  	struct iio_mount_matrix orientation;
> @@ -1067,19 +1066,13 @@ static const char *bmg160_match_acpi_device(struct device *dev)
>  	return dev_name(dev);
>  }
>  
> -static void bmg160_disable_regulators(void *d)
> -{
> -	struct bmg160_data *data = d;
> -
> -	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
> -}
> -
>  int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
>  		      const char *name)
>  {
>  	struct bmg160_data *data;
>  	struct iio_dev *indio_dev;
>  	int ret;
> +	static const char * const regulators[] = {"vdd", "vddio"};
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>  	if (!indio_dev)
> @@ -1090,22 +1083,11 @@ int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
>  	data->irq = irq;
>  	data->regmap = regmap;
>  
> -	data->regulators[0].supply = "vdd";
> -	data->regulators[1].supply = "vddio";
> -	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(data->regulators),
> -				      data->regulators);
> +	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulators),
> +					     regulators);
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Failed to get regulators\n");
>  
> -	ret = regulator_bulk_enable(ARRAY_SIZE(data->regulators),
> -				    data->regulators);
> -	if (ret)
> -		return ret;
> -
> -	ret = devm_add_action_or_reset(dev, bmg160_disable_regulators, data);
> -	if (ret)
> -		return ret;
> -
>  	ret = iio_read_mount_matrix(dev, &data->orientation);
>  	if (ret)
>  		return ret;

