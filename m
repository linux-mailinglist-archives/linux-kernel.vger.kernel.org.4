Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456A6632A66
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiKURIn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Nov 2022 12:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiKURIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:08:40 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397EBC8CAE;
        Mon, 21 Nov 2022 09:08:39 -0800 (PST)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NGDLG1V9Yz67Pmj;
        Tue, 22 Nov 2022 01:05:58 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 18:08:36 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 21 Nov
 2022 17:08:36 +0000
Date:   Mon, 21 Nov 2022 17:08:35 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ramona Bolboaca <ramona.bolboaca@analog.com>
CC:     <jic23@kernel.org>, <nuno.sa@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/9] iio: adis: add '__adis_enable_irq()'
 implementation
Message-ID: <20221121170835.000038d9@Huawei.com>
In-Reply-To: <20221121152717.403667-2-ramona.bolboaca@analog.com>
References: <20221121152717.403667-1-ramona.bolboaca@analog.com>
        <20221121152717.403667-2-ramona.bolboaca@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2022 17:27:09 +0200
Ramona Bolboaca <ramona.bolboaca@analog.com> wrote:

> Add '__adis_enable_irq()' implementation which is the unlocked
> version of 'adis_enable_irq()'.
> Call '__adis_enable_irq()' instead of 'adis_enable_irq()' from
> '__adis_intial_startup()' to keep the expected unlocked functionality.
> 
> Fixes: b600bd7eb3335 ("iio: adis: do not disabe IRQs in 'adis_init()'")
> Signed-off-by: Ramona Bolboaca <ramona.bolboaca@analog.com>
> Reviewed-by: Nuno Sá <nuno.sa@analog.com>

Can you add some explanation in here for 'why' this is a fix.
People need that info to decide whether they want to pick it up for
distros etc.

Jonathan

> ---
>  drivers/iio/imu/adis.c       | 28 ++++++++++------------------
>  include/linux/iio/imu/adis.h | 13 ++++++++++++-
>  2 files changed, 22 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index f7fcfd04f659..bc40240b29e2 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -270,23 +270,19 @@ EXPORT_SYMBOL_NS(adis_debugfs_reg_access, IIO_ADISLIB);
>  #endif
>  
>  /**
> - * adis_enable_irq() - Enable or disable data ready IRQ
> + * __adis_enable_irq() - Enable or disable data ready IRQ (unlocked)
>   * @adis: The adis device
>   * @enable: Whether to enable the IRQ
>   *
>   * Returns 0 on success, negative error code otherwise
>   */
> -int adis_enable_irq(struct adis *adis, bool enable)
> +int __adis_enable_irq(struct adis *adis, bool enable)
>  {
> -	int ret = 0;
> +	int ret;
>  	u16 msc;
>  
> -	mutex_lock(&adis->state_lock);
> -
> -	if (adis->data->enable_irq) {
> -		ret = adis->data->enable_irq(adis, enable);
> -		goto out_unlock;
> -	}
> +	if (adis->data->enable_irq)
> +		return adis->data->enable_irq(adis, enable);
>  
>  	if (adis->data->unmasked_drdy) {
>  		if (enable)
> @@ -294,12 +290,12 @@ int adis_enable_irq(struct adis *adis, bool enable)
>  		else
>  			disable_irq(adis->spi->irq);
>  
> -		goto out_unlock;
> +		return 0;
>  	}
>  
>  	ret = __adis_read_reg_16(adis, adis->data->msc_ctrl_reg, &msc);
>  	if (ret)
> -		goto out_unlock;
> +		return ret;
>  
>  	msc |= ADIS_MSC_CTRL_DATA_RDY_POL_HIGH;
>  	msc &= ~ADIS_MSC_CTRL_DATA_RDY_DIO2;
> @@ -308,13 +304,9 @@ int adis_enable_irq(struct adis *adis, bool enable)
>  	else
>  		msc &= ~ADIS_MSC_CTRL_DATA_RDY_EN;
>  
> -	ret = __adis_write_reg_16(adis, adis->data->msc_ctrl_reg, msc);
> -
> -out_unlock:
> -	mutex_unlock(&adis->state_lock);
> -	return ret;
> +	return __adis_write_reg_16(adis, adis->data->msc_ctrl_reg, msc);
>  }
> -EXPORT_SYMBOL_NS(adis_enable_irq, IIO_ADISLIB);
> +EXPORT_SYMBOL_NS(__adis_enable_irq, IIO_ADISLIB);
>  
>  /**
>   * __adis_check_status() - Check the device for error conditions (unlocked)
> @@ -445,7 +437,7 @@ int __adis_initial_startup(struct adis *adis)
>  	 * with 'IRQF_NO_AUTOEN' anyways.
>  	 */
>  	if (!adis->data->unmasked_drdy)
> -		adis_enable_irq(adis, false);
> +		__adis_enable_irq(adis, false);
>  
>  	if (!adis->data->prod_id_reg)
>  		return 0;
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index 515ca09764fe..d789ecf8d0c8 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -402,9 +402,20 @@ static inline int adis_update_bits_base(struct adis *adis, unsigned int reg,
>  	__adis_update_bits_base(adis, reg, mask, val, sizeof(val));	\
>  })
>  
> -int adis_enable_irq(struct adis *adis, bool enable);
> +static inline int adis_enable_irq(struct adis *adis, bool enable)
> +{
> +	int ret;
> +
> +	mutex_lock(&adis->state_lock);
> +	ret = __adis_enable_irq(adis, enable);
> +	mutex_unlock(&adis->state_lock);
> +
> +	return ret;
> +}
> +
>  int __adis_check_status(struct adis *adis);
>  int __adis_initial_startup(struct adis *adis);
> +int __adis_enable_irq(struct adis *adis, bool enable);
>  
>  static inline int adis_check_status(struct adis *adis)
>  {

