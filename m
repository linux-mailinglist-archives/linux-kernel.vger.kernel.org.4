Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A3E6F2A09
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 19:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjD3Rd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 13:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjD3Rd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 13:33:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BCC1997;
        Sun, 30 Apr 2023 10:33:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15E9E60A13;
        Sun, 30 Apr 2023 17:33:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F898C433EF;
        Sun, 30 Apr 2023 17:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682876005;
        bh=mkQd6O4/NjbRSNzKMaOfHfxVB9rNFA/CVT9aoKQ1vbI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m7lYUB+clkFy3hIjjeMollPnupVQMhpQsLBgrDsTvP30eDVSCRtqzoKzYEY/4dvOq
         qlvO1s0H6bKN54pqxF6MTXksXxasy0iWPrqTzueyTnDkPFb7B35yGDd0alJ6OK0/yw
         nJjYnW+74lCa/W0Dyqe9UjQSaDxa8jPLdq1uSGcj/wNzMnYviq6nshM2gH2RmT0+qt
         hNwdD93HiCEjE3/mCD44QnIm2UDj7RQgQSvxJyE3miwUnD5qIeIRgClUGC876YQh+J
         S0jDGqn+sylJKTBLlAJBfvcRt+iTZ6VVO2Ci3Ecaz3N6980cjP1+0veUi2xc1YyPiO
         ovdOVCeZjIhcQ==
Date:   Sun, 30 Apr 2023 18:49:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     Andi Shyti <andi.shyti@kernel.org>, mazziesaccount@gmail.com,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 5/7] iio: accel: kionix-kx022a: Refactor driver and
 add chip_info structure
Message-ID: <20230430184910.48d6c1b4@jic23-huawei>
In-Reply-To: <ZE0WopTBS8S08tjX@carbian>
References: <cover.1682373451.git.mehdi.djait.k@gmail.com>
        <bf0269aff66483f2323914170707203749b33f0f.1682373451.git.mehdi.djait.k@gmail.com>
        <20230425155734.ywdle4pv6y2wjk2s@intel.intel>
        <ZE0WopTBS8S08tjX@carbian>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
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

On Sat, 29 Apr 2023 15:07:46 +0200
Mehdi Djait <mehdi.djait.k@gmail.com> wrote:

> Hi Andi,
> 
> Thank you for the review.
> 
> On Tue, Apr 25, 2023 at 05:57:34PM +0200, Andi Shyti wrote:
> > Hi Mehdi,
> > 
> > On Tue, Apr 25, 2023 at 12:22:25AM +0200, Mehdi Djait wrote:  
> > > Add the chip_info structure to the driver's private data to hold all
> > > the device specific infos.
> > > Refactor the kx022a driver implementation to make it more generic and
> > > extensible.  
> > 
> > Could you please split this in different patches? Add id in one
> > patch and refactor in a different patch. Please, also the
> > refactorings need to be split.
> > 
> > I see here that this is a general code cleanup, plus some other
> > stuff.  
> 
> Looking at the diff and considering the comments from Jonathan in the
> previous versions, the only thing that can separated from this patch
> would be the changes related to:
> -#define KX022A_ACCEL_CHAN(axis, index)				\
> +#define KX022A_ACCEL_CHAN(axis, reg, index)			\
> 
> > 
> > [...]
> >   
> > > @@ -22,22 +23,28 @@ static int kx022a_spi_probe(struct spi_device *spi)
> > >  		return -EINVAL;
> > >  	}
> > >  
> > > -	regmap = devm_regmap_init_spi(spi, &kx022a_regmap);
> > > +	chip_info = device_get_match_data(&spi->dev);
> > > +	if (!chip_info) {
> > > +		const struct spi_device_id *id = spi_get_device_id(spi);
> > > +		chip_info = (const struct kx022a_chip_info *)id->driver_data;  
> > 
> > you don't need the cast here... if you don't find it messy, I
> > wouldn't mind this form... some hate it, I find it easier to
> > read:
> > 
> > 	chip_info = spi_get_device_id(spi)->driver_data;
> > 
> > your choice.  
> 
> I don't really have any strong opinion about this other than keeping the
> same style used in iio drivers
> 
> Again thank you for the review

I'm fairly sure the cast is needed because driver_data is (via defines)
an unsigned long, which you cannot implicitly cast to a pointer without
various warnings being generated.

Jonathan

> 
> --
> Kind Regards
> Mehdi Djait
> 

