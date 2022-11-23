Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E37F636B31
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239943AbiKWUbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239047AbiKWUbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:31:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD19B8565;
        Wed, 23 Nov 2022 12:27:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10EF461EFA;
        Wed, 23 Nov 2022 20:27:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A32C5C433B5;
        Wed, 23 Nov 2022 20:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669235244;
        bh=gPkfbnv3qPJ9FOJmn467RGATD1PErQvKRtVe1xtGPiE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GC1/j2m85haDlVSmG14J/wxR6a6O5GE/AZG//rvBg9iWO+pZJseIvX0knZVBNpHg4
         WtLeMxrtC/5pIrA7xiGxtcNAs2ZPb3QEISfOk89/Fl5703952U9We3I5kMeAkx5Xqi
         wdQGE4akGP+k/EFXxE8bJfgiRn/w3OZALUKV9pMi25Dg9203SOFDLgqI7gbxYlKFw9
         8PEW5donjR8xsvRdIvEu5yY7vBPhFYeTBsQjRbgy+g0GNPRU6H+T8MKT9GnUfuzOml
         jdLS7JHLGQlyM7WIcT0JSPbLlva4NHz7ulQYftS/lPntpmzOfqYcrCLm5GdmiOYnFO
         9XKGfpMzyaBhg==
Date:   Wed, 23 Nov 2022 20:39:57 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ramona Bolboaca <ramona.bolboaca@analog.com>
Cc:     <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/9] iio: adis: add '__adis_enable_irq()'
 implementation
Message-ID: <20221123203957.1fc50880@jic23-huawei>
In-Reply-To: <20221122082757.449452-2-ramona.bolboaca@analog.com>
References: <20221122082757.449452-1-ramona.bolboaca@analog.com>
        <20221122082757.449452-2-ramona.bolboaca@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2022 10:27:49 +0200
Ramona Bolboaca <ramona.bolboaca@analog.com> wrote:

> Add '__adis_enable_irq()' implementation which is the unlocked
> version of 'adis_enable_irq()'.
> Call '__adis_enable_irq()' instead of 'adis_enable_irq()' from
> '__adis_intial_startup()' to keep the expected unlocked functionality.
>=20
> This fix is needed to remove a deadlock for all devices which are
> using 'adis_initial_startup()'. The deadlock occurs because the
> same mutex is acquired twice, without releasing it.
> The mutex is acquired once inside 'adis_initial_startup()', before
> calling '__adis_initial_startup()', and once inside
> 'adis_enable_irq()', which is called by '__adis_initial_startup()'.
> The deadlock is removed by calling '__adis_enable_irq()', instead of
> 'adis_enable_irq()' from within '__adis_initial_startup()'.
>=20
> Fixes: b600bd7eb3335 ("iio: adis: do not disabe IRQs in 'adis_init()'")
> Signed-off-by: Ramona Bolboaca <ramona.bolboaca@analog.com>
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Build issue in here that I've fixed up.

> ---
>  drivers/iio/imu/adis.c       | 28 ++++++++++------------------
>  include/linux/iio/imu/adis.h | 13 ++++++++++++-
>  2 files changed, 22 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index f7fcfd04f659..bc40240b29e2 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -270,23 +270,19 @@ EXPORT_SYMBOL_NS(adis_debugfs_reg_access, IIO_ADISL=
IB);
>  #endif
> =20
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
> -	int ret =3D 0;
> +	int ret;
>  	u16 msc;
> =20
> -	mutex_lock(&adis->state_lock);
> -
> -	if (adis->data->enable_irq) {
> -		ret =3D adis->data->enable_irq(adis, enable);
> -		goto out_unlock;
> -	}
> +	if (adis->data->enable_irq)
> +		return adis->data->enable_irq(adis, enable);
> =20
>  	if (adis->data->unmasked_drdy) {
>  		if (enable)
> @@ -294,12 +290,12 @@ int adis_enable_irq(struct adis *adis, bool enable)
>  		else
>  			disable_irq(adis->spi->irq);
> =20
> -		goto out_unlock;
> +		return 0;
>  	}
> =20
>  	ret =3D __adis_read_reg_16(adis, adis->data->msc_ctrl_reg, &msc);
>  	if (ret)
> -		goto out_unlock;
> +		return ret;
> =20
>  	msc |=3D ADIS_MSC_CTRL_DATA_RDY_POL_HIGH;
>  	msc &=3D ~ADIS_MSC_CTRL_DATA_RDY_DIO2;
> @@ -308,13 +304,9 @@ int adis_enable_irq(struct adis *adis, bool enable)
>  	else
>  		msc &=3D ~ADIS_MSC_CTRL_DATA_RDY_EN;
> =20
> -	ret =3D __adis_write_reg_16(adis, adis->data->msc_ctrl_reg, msc);
> -
> -out_unlock:
> -	mutex_unlock(&adis->state_lock);
> -	return ret;
> +	return __adis_write_reg_16(adis, adis->data->msc_ctrl_reg, msc);
>  }
> -EXPORT_SYMBOL_NS(adis_enable_irq, IIO_ADISLIB);
> +EXPORT_SYMBOL_NS(__adis_enable_irq, IIO_ADISLIB);
> =20
>  /**
>   * __adis_check_status() - Check the device for error conditions (unlock=
ed)
> @@ -445,7 +437,7 @@ int __adis_initial_startup(struct adis *adis)
>  	 * with 'IRQF_NO_AUTOEN' anyways.
>  	 */
>  	if (!adis->data->unmasked_drdy)
> -		adis_enable_irq(adis, false);
> +		__adis_enable_irq(adis, false);
> =20
>  	if (!adis->data->prod_id_reg)
>  		return 0;
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index 515ca09764fe..d789ecf8d0c8 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -402,9 +402,20 @@ static inline int adis_update_bits_base(struct adis =
*adis, unsigned int reg,
>  	__adis_update_bits_base(adis, reg, mask, val, sizeof(val));	\
>  })
> =20
> -int adis_enable_irq(struct adis *adis, bool enable);
> +static inline int adis_enable_irq(struct adis *adis, bool enable)
> +{
> +	int ret;
> +
> +	mutex_lock(&adis->state_lock);
> +	ret =3D __adis_enable_irq(adis, enable);
> +	mutex_unlock(&adis->state_lock);
> +
> +	return ret;
> +}
> +
>  int __adis_check_status(struct adis *adis);
>  int __adis_initial_startup(struct adis *adis);
> +int __adis_enable_irq(struct adis *adis, bool enable);

Move the above down here seeing as __adis_enable_irq() isn't
defined until this point (and that gave a bunch of build issues).

> =20
>  static inline int adis_check_status(struct adis *adis)
>  {

