Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BE860012C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 18:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiJPQRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 12:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiJPQQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 12:16:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7FB37F8D;
        Sun, 16 Oct 2022 09:16:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67E7460C22;
        Sun, 16 Oct 2022 16:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893DBC43146;
        Sun, 16 Oct 2022 16:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665937007;
        bh=AoFZOOk73OQEEgbSxMRwKb8dB7E4pU4x1ZZzcpz/iA0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mHAv9A1jLI+YcaPDhCzBURaFJWTh0slqyEZINdoK+kHPbT86bnlwXu4XzzI7G5NmI
         OzTczyJm0+zzNv0B/VbE9YujvqWgLVFkvoBG2xkGobY4T7ChFr6CBLGTkwe1KfuNTs
         5BEl5G7QPpPfjjnroCBEyvPHlOSNJRbsWM/UzEaqpGJ62zcX+XsH/ibX6DXMN4gydU
         Q63DnfUfJKf8NERSl6JOWBMClmXhMHc9WeWJjS0nUmot/N5txNuvl7P2aq5IHUnGrT
         qeYpsVED2qmQDrRbuNGI05vMeMveDZQyX0AsST3p2ID4yJZZu/HU7/Lb9bZwvSZtbB
         QiQh7AiHgDkDw==
Date:   Sun, 16 Oct 2022 17:17:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Lazar <alazar@startmail.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 12/14] iio: max1241: simplify using
 devm_regulator_get_enable()
Message-ID: <20221016171716.2817fad3@jic23-huawei>
In-Reply-To: <f8eaa7ce-8f33-b561-a9e1-a007f704af14@startmail.com>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
        <7c759bf6c06e72ae70bffeebc1939d9903427278.1660934107.git.mazziesaccount@gmail.com>
        <f8eaa7ce-8f33-b561-a9e1-a007f704af14@startmail.com>
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

On Fri, 19 Aug 2022 22:58:45 +0300
Alexandru Lazar <alazar@startmail.com> wrote:

> Heya,
> 
> I don't have the hardware at hand (long story, lots of smoke), so all I 
> can do for this patch at the moment is:
> 
> Acked-by: Alexandru Lazar <alazar@startmail.com>
> 
> That being said, IIRC the MAX1241 has no special requirements in this 
> regard, so if other SPI devices work, this one ought to work as well. If 
> anyone's concerned, I can test it, but probably not sooner than a week 
> or so :-(.
> 
> FWIW I really like this, the straightforward regulator boilerplate 
> always felt a tad wrong.
> 
> All the best,
> Alex

Now the dependencies are upstream... Applied to the togreg branch of
iio.git and pushed out as testing so that 0-day can play with it and
because I plan to rebase that tree on rc1 sometime shortly.

Jonathan

> 
> On 8/19/2022 10:20 PM, Matti Vaittinen wrote:
> > Drop open-coded pattern: 'devm_regulator_get(), regulator_enable(),
> > add_action_or_reset(regulator_disable)' and use the
> > devm_regulator_get_enable() and drop the pointer to the regulator.
> > This simplifies code and makes it less tempting to add manual control
> > for the regulator which is also controlled by devm.
> > 
> > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > 
> > ---
> > v2 => v3:
> > New patch
> > ---
> >   drivers/iio/adc/max1241.c | 28 +++-------------------------
> >   1 file changed, 3 insertions(+), 25 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/max1241.c b/drivers/iio/adc/max1241.c
> > index a815ad1f6913..500bb09ab19b 100644
> > --- a/drivers/iio/adc/max1241.c
> > +++ b/drivers/iio/adc/max1241.c
> > @@ -22,7 +22,6 @@ enum max1241_id {
> >   struct max1241 {
> >   	struct spi_device *spi;
> >   	struct mutex lock;
> > -	struct regulator *vdd;
> >   	struct regulator *vref;
> >   	struct gpio_desc *shutdown;
> >   
> > @@ -110,17 +109,6 @@ static const struct iio_info max1241_info = {
> >   	.read_raw = max1241_read_raw,
> >   };
> >   
> > -static void max1241_disable_vdd_action(void *data)
> > -{
> > -	struct max1241 *adc = data;
> > -	struct device *dev = &adc->spi->dev;
> > -	int err;
> > -
> > -	err = regulator_disable(adc->vdd);
> > -	if (err)
> > -		dev_err(dev, "could not disable vdd regulator.\n");
> > -}
> > -
> >   static void max1241_disable_vref_action(void *data)
> >   {
> >   	struct max1241 *adc = data;
> > @@ -147,20 +135,10 @@ static int max1241_probe(struct spi_device *spi)
> >   	adc->spi = spi;
> >   	mutex_init(&adc->lock);
> >   
> > -	adc->vdd = devm_regulator_get(dev, "vdd");
> > -	if (IS_ERR(adc->vdd))
> > -		return dev_err_probe(dev, PTR_ERR(adc->vdd),
> > -				     "failed to get vdd regulator\n");
> > -
> > -	ret = regulator_enable(adc->vdd);
> > +	ret = devm_regulator_get_enable(dev, "vdd");
> >   	if (ret)
> > -		return ret;
> > -
> > -	ret = devm_add_action_or_reset(dev, max1241_disable_vdd_action, adc);
> > -	if (ret) {
> > -		dev_err(dev, "could not set up vdd regulator cleanup action\n");
> > -		return ret;
> > -	}
> > +		return dev_err_probe(dev, ret,
> > +				     "failed to get/enable vdd regulator\n");
> >   
> >   	adc->vref = devm_regulator_get(dev, "vref");
> >   	if (IS_ERR(adc->vref))  

