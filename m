Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CA76BFB78
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 17:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjCRQPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 12:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCRQPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 12:15:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429641BAD0;
        Sat, 18 Mar 2023 09:15:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3609B8087F;
        Sat, 18 Mar 2023 16:15:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFFFC433D2;
        Sat, 18 Mar 2023 16:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679156139;
        bh=VEh2PQWcLzHPxXFhgiyyzgHYLQpKVw5kHPz0m3ngPY0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G+s0dCzmhM631ZAjtFuYzDFYcUeqCHyysA//K3mOiXafiqamcaBLG4n9GaCjXbTx1
         Gz4FBvfMazeKO674bVpNtOMNHfO61UFJRG9fG47jgif//2HAGAyyfg7RmzBv3W1Bxe
         EYCUDfjcA5DmmmOamXSzZ9Wq24lIa+WrRepwtVgQoICe6AkyluHe/4ZP6KsmmZ3+N2
         vBcq6jMNcztDLf+LYC83Wkb3381KVtR81QSK3auG1UqD6LMQadk2Fg82ZPCZwseCNL
         Xge0Fk7gFXEXLzLG5QX3Olddr6zfxndVgH03oki3m6Jx07im8tgKPEhT7Wd3RD2QXV
         PYbmSVmQWt99A==
Date:   Sat, 18 Mar 2023 16:30:33 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Patrik =?UTF-8?B?RGFobHN0csO2bQ==?= <risca@dalakolonin.se>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, hns@goldelico.com
Subject: Re: [PATCH] iio: adc: palmas_gpadc: fix NULL dereference on rmmod
Message-ID: <20230318163033.161d6fd5@jic23-huawei>
In-Reply-To: <20230313205029.1881745-1-risca@dalakolonin.se>
References: <20230313205029.1881745-1-risca@dalakolonin.se>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
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

On Mon, 13 Mar 2023 21:50:29 +0100
Patrik Dahlstr=C3=B6m <risca@dalakolonin.se> wrote:

> Calling dev_to_iio_dev() on a platform device pointer is undefined and
> will make adc NULL.
>=20
> Signed-off-by: Patrik Dahlstr=C3=B6m <risca@dalakolonin.se>

Hi Patrik,

Looks good so applied to the fixes-togreg branch of iio.git.

Whilst we are here, this would be a trivial driver to take fully device
managed.  The only slightly messy bit is that it would need
a devm_add_action_or_reset() + custom callback to handle the
device_wakeup_enable().

On the off chance you can test it I'll send a patch in a few mins.
Note that will depend on this one going up stream first and that
I haven't done more than build test it.

Thanks,

Jonathan


> ---
>  drivers/iio/adc/palmas_gpadc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpad=
c.c
> index 61e80bf3d05e..6db6f3bc768a 100644
> --- a/drivers/iio/adc/palmas_gpadc.c
> +++ b/drivers/iio/adc/palmas_gpadc.c
> @@ -638,7 +638,7 @@ static int palmas_gpadc_probe(struct platform_device =
*pdev)
> =20
>  static int palmas_gpadc_remove(struct platform_device *pdev)
>  {
> -	struct iio_dev *indio_dev =3D dev_to_iio_dev(&pdev->dev);
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(&pdev->dev);
>  	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
> =20
>  	if (adc->wakeup1_enable || adc->wakeup2_enable)

