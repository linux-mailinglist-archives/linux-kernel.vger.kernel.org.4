Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8054626AC9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 18:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbiKLRZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 12:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiKLRZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 12:25:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856D317068;
        Sat, 12 Nov 2022 09:25:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F2BCB80989;
        Sat, 12 Nov 2022 17:25:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B320C433D6;
        Sat, 12 Nov 2022 17:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668273932;
        bh=cMgWmOTskVM9FmMjEvsr2shVsPl9TYAtnkLphTZ0BC8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uarGshHNITIlWc0h5kgjvtJBeWPGMPIRR2cKAgbkxkFPAx9we1ntKEwDTJ4/qxivX
         fsl2JCSgZxqmRcwaGKa0WUB8ujkkoQx/sfZmbkOs8icOyvYmQi/xncrMhfxT0Zir1A
         vBsDefOQ6Zwc1OyyNe6qWl/ZN7wrFa/ILYCeZpJ4ioqcynwi+wzmULjgIvu0K99Qzo
         DZhV4o7EnNAEZFVLgMwssLtHYNuqLxeBtg8DNYd015CWOkccAyikDFtbIma9sTaVYz
         B2LqDfd2GSMLYEO6J7QIKPU93w4fA98Tqxv5vqmwUZh+MlQbBXNnLakJk0b4fNuHOv
         kLnL7jLezlyHA==
Date:   Sat, 12 Nov 2022 17:37:48 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Paul Gazzillo <paul@pgazz.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1]: iio: light: rpr0521: add missing Kconfig
 dependencies
Message-ID: <20221112173748.70534b77@jic23-huawei>
In-Reply-To: <20221111152539.srpn3ng3erutka4u@device>
References: <20221110144448.wexu6neb67krqhla@device>
        <20221110214729.ls5ixav5kxpeftk7@device>
        <Y24xOvNVsuLsbBXX@smile.fi.intel.com>
        <20221111152539.srpn3ng3erutka4u@device>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Fri, 11 Nov 2022 10:25:39 -0500
Paul Gazzillo <paul@pgazz.com> wrote:

> On 11/11/2022, Andy Shevchenko wrote:
> > On Thu, Nov 10, 2022 at 04:47:29PM -0500, Paul Gazzillo wrote:  
> > > Fix an implicit declaration of function error for rpr0521 under some configs
> > > 
> > > When CONFIG_RPR0521 is enabled without CONFIG_IIO_TRIGGERED_BUFFER,
> > > the build results in "implicit declaration of function" errors, e.g.,
> > >   drivers/iio/light/rpr0521.c:434:3: error: implicit declaration of function
> > >            'iio_trigger_poll_chained' [-Werror=implicit-function-declaration]
> > >     434 |   iio_trigger_poll_chained(data->drdy_trigger0);
> > >         |   ^~~~~~~~~~~~~~~~~~~~~~~~
> > > 
> > > This fix adds select dependencies to RPR0521's configuration declaration.
> > > 
> > > Signed-off-by: Paul Gazzillo <paul@pgazz.com>
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=216678  
> > 
> > No need to create a bugzilla report on such tiny issues that do actually not
> > affect the working configurations.  
> 
> Understood.  Thanks for your help!

I wonder why it has taken so long for this build issue to get reported?

Ah well. This is missing a fixes tag. I added
Fixes: e12ffd241c00 ("iio: light: rpr0521 triggered buffer")

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan



> 
> > 
> > FWIW,
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >   
> > > ---
> > > V1 -> V2: Cleaned up commit message per reviewer comments and added link
> > >           to bug report.
> > > 
> > >  drivers/iio/light/Kconfig | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> > > index 7cf6e8490123..0d4447df7200 100644
> > > --- a/drivers/iio/light/Kconfig
> > > +++ b/drivers/iio/light/Kconfig
> > > @@ -293,6 +293,8 @@ config RPR0521
> > >  	tristate "ROHM RPR0521 ALS and proximity sensor driver"
> > >  	depends on I2C
> > >  	select REGMAP_I2C
> > > +	select IIO_BUFFER
> > > +	select IIO_TRIGGERED_BUFFER
> > >  	help
> > >  	  Say Y here if you want to build support for ROHM's RPR0521
> > >  	  ambient light and proximity sensor device.
> > > -- 
> > > 2.25.1  
> > 
> > -- 
> > With Best Regards,
> > Andy Shevchenko  
> 
> Best,
> Paul

