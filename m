Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60765FFB3B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 18:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJOQfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 12:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiJOQfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 12:35:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652AC3DBE1;
        Sat, 15 Oct 2022 09:35:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0978B80917;
        Sat, 15 Oct 2022 16:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8562C433C1;
        Sat, 15 Oct 2022 16:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665851718;
        bh=zVHCc6/1Q9R11ugbfMvUl3mKQW5UvyeO+jYzbCq0HD4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j/YqUt7M95etBzTRmEFEBOcfZ4mt2YNB9fqbcxic4wq9tmkjhyOzonCxAnIVzzI8Y
         UycMPMtER9MnfI4u1hk6FPDe8MpkEtNLMuoh+0gD+Wb5Hkyop0swCO/o3jH4ZQG12Z
         fVeIzTnIAduRkbVzClJSWe7S10EsPgzngZz0OJMm41lYg/udlNRASFNfZc67nDzuMX
         /RbaCcjZn/bXyeSzjLgBtNfa95E4Icx0vsl/dCgTRbENDJ46YLI2ggsLK5FgBlbaa5
         kmY/iTCIL8hc7J5KtoE4frOaD/1jP189ReHJyuLFLzVu/pHJV286/isV/EEsldZjFi
         WRiv9SF23JPig==
Date:   Sat, 15 Oct 2022 17:35:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Cosmin Tanislav <demonsingur@gmail.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH 1/3] iio: temperature: ltc2983: allocate iio channels
 once
Message-ID: <20221015173543.4b3f6d5d@jic23-huawei>
In-Reply-To: <20221014161824.00001ca2@huawei.com>
References: <20221014123724.1401011-1-demonsingur@gmail.com>
        <20221014123724.1401011-2-demonsingur@gmail.com>
        <20221014151123.00003268@huawei.com>
        <20221014161824.00001ca2@huawei.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Oct 2022 16:18:24 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Fri, 14 Oct 2022 15:11:47 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > On Fri, 14 Oct 2022 15:37:22 +0300
> > Cosmin Tanislav <demonsingur@gmail.com> wrote:
> >   
> > > From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> > > 
> > > Currently, every time the device wakes up from sleep, the
> > > iio_chan array is reallocated, leaking the previous one
> > > until the device is removed (basically never).
> > > 
> > > Move the allocation to the probe function to avoid this.
> > > 
> > > Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>    
> > Hi Cosmin,
> > 
> > Please give a fixes tag for this one as we'll definitely want to
> > backport it.
> > 
> > Reply to this patch is fine as b4 will pick it up like any other tag.  
> Fixes: f110f3188e563 ("iio: temperature: Add support for LTC2983")
> 
> (from direct mail)
> 
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> >   
> > > ---
> > >  drivers/iio/temperature/ltc2983.c | 13 ++++++-------
> > >  1 file changed, 6 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
> > > index b652d2b39bcf..a60ccf183687 100644
> > > --- a/drivers/iio/temperature/ltc2983.c
> > > +++ b/drivers/iio/temperature/ltc2983.c
> > > @@ -1385,13 +1385,6 @@ static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
> > >  		return ret;
> > >  	}
> > >  
> > > -	st->iio_chan = devm_kzalloc(&st->spi->dev,
> > > -				    st->iio_channels * sizeof(*st->iio_chan),
> > > -				    GFP_KERNEL);
> > > -
> > > -	if (!st->iio_chan)
> > > -		return -ENOMEM;
> > > -
> > >  	ret = regmap_update_bits(st->regmap, LTC2983_GLOBAL_CONFIG_REG,
> > >  				 LTC2983_NOTCH_FREQ_MASK,
> > >  				 LTC2983_NOTCH_FREQ(st->filter_notch_freq));
> > > @@ -1514,6 +1507,12 @@ static int ltc2983_probe(struct spi_device *spi)
> > >  		gpiod_set_value_cansleep(gpio, 0);
> > >  	}
> > >  
> > > +	st->iio_chan = devm_kzalloc(&spi->dev,
> > > +				    st->iio_channels * sizeof(*st->iio_chan),
> > > +				    GFP_KERNEL);
> > > +	if (!st->iio_chan)
> > > +		return -ENOMEM;
> > > +
> > >  	ret = ltc2983_setup(st, true);
> > >  	if (ret)
> > >  		return ret;    
> > 
> >   
> 

