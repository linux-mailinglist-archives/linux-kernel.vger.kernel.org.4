Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5EE7342B8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 19:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346334AbjFQRmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 13:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjFQRmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 13:42:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD304B2;
        Sat, 17 Jun 2023 10:42:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7223661191;
        Sat, 17 Jun 2023 17:42:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8133C433C8;
        Sat, 17 Jun 2023 17:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687023751;
        bh=v1w7IgjTyIRIpWfJqtbFcmG8AX0rS71G6iGgqf6oZgc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tpj7glSMKVEgkv5Zp0h9t+gFIyMECcjE8yd4g03TIKnD9ezc7ZlsWmaAcq3nJhuwa
         h/spBKln7Bi020Uo1p2UZCnn5RIdSaPQhhv+L+83hxAijVxpaBSmB5KYkaw9kNJbpK
         431U5SaJ6yTtn2JwItbltWxWG0VNn4p9KfGb3IXAXS3ZUq7ePOivZFYRXuCC5EXJiH
         CzvGK0sbvwCuYOlM0TOI8eQpOa2k2mt2BhXSOBNL9AbHs/n7UPFIOeMSEtM/Zagrt1
         PPcZ3W/3yLKwMkHRt+IcfQH2D80eEgGcQxlvz2yAyTomSd/s1Jv4kDyiHofV/vRd2t
         0PdySRWvL376Q==
Date:   Sat, 17 Jun 2023 18:42:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 05/13] iio: inkern: Remove the 'unused' variable
 usage in iio_channel_read_max()
Message-ID: <20230617184222.7cb6870d@jic23-huawei>
In-Reply-To: <20230615152631.224529-6-herve.codina@bootlin.com>
References: <20230615152631.224529-1-herve.codina@bootlin.com>
        <20230615152631.224529-6-herve.codina@bootlin.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jun 2023 17:26:23 +0200
Herve Codina <herve.codina@bootlin.com> wrote:

> The code uses a local variable to initialize a null pointer in order to
> avoid accessing this null pointer later on.
> 
> Simply removed the 'unused' variable and check for the null pointer just
> before accessing it.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

A this series has grown more changes in IIO over time....
Hopefully who ever takes it can provide an immutable branch to make
it easy to avoid any dependency issues for other work in IIO.

Thanks,

Jonathan

> ---
>  drivers/iio/inkern.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index f738db9a0c04..ce537b4ca6ca 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -849,14 +849,10 @@ static int iio_channel_read_max(struct iio_channel *chan,
>  				int *val, int *val2, int *type,
>  				enum iio_chan_info_enum info)
>  {
> -	int unused;
>  	const int *vals;
>  	int length;
>  	int ret;
>  
> -	if (!val2)
> -		val2 = &unused;
> -
>  	ret = iio_channel_read_avail(chan, &vals, type, &length, info);
>  	if (ret < 0)
>  		return ret;
> @@ -869,7 +865,8 @@ static int iio_channel_read_max(struct iio_channel *chan,
>  			break;
>  		default:
>  			*val = vals[4];
> -			*val2 = vals[5];
> +			if (val2)
> +				*val2 = vals[5];
>  		}
>  		return 0;
>  

