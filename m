Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53692628506
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237237AbiKNQWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237153AbiKNQWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:22:11 -0500
Received: from box.opentheblackbox.net (box.opentheblackbox.net [IPv6:2600:3c02::f03c:92ff:fee2:82bc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91994193C8;
        Mon, 14 Nov 2022 08:22:05 -0800 (PST)
Received: from authenticated-user (box.opentheblackbox.net [172.105.151.37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.opentheblackbox.net (Postfix) with ESMTPSA id E1A073EA78;
        Mon, 14 Nov 2022 11:22:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pgazz.com; s=mail;
        t=1668442922; bh=qHRVe8UNKhSLq++XhwUphLg7th/rtsdhXo5UWemDGtM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eehuAXb7LSPfb15fsCxObXCXb3Q9zHNcpZk9E/3mQDkGi8k+rY9fcfI1FbDKziXNp
         dierxxnjDXwRkB+XXV0jJSlK0WKGsETuLGwEMOq4ttb07oVHpqlcjr22nGRWj3VBwu
         fwHoAzazP7M0Ohjero2L6ze/vOYbSCTnBQjA+dpVACoWEjzgVynvhWEbq3oTeXIo53
         qRPKMRJuR0GmFRY6p7ccgFM6G7vqaVie0sw55A9Hq9dUmcy4JmOOTSVCWPb/kaDbFU
         z2vbP3nEvS7KiXrtO36Exl/yJKUAZfmiTiRHSruEMdarrp+FzvP9Bo2b/eBJT+qy9Y
         HjYgDMMcTjlZg==
Date:   Mon, 14 Nov 2022 11:22:00 -0500
From:   Paul Gazzillo <paul@pgazz.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1]: iio: light: rpr0521: add missing Kconfig
 dependencies
Message-ID: <20221114162200.2f2meir7adrouo35@device>
References: <20221110144448.wexu6neb67krqhla@device>
 <20221110214729.ls5ixav5kxpeftk7@device>
 <Y24xOvNVsuLsbBXX@smile.fi.intel.com>
 <20221111152539.srpn3ng3erutka4u@device>
 <20221112173748.70534b77@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221112173748.70534b77@jic23-huawei>
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,RCVD_IN_XBL,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/2022, Jonathan Cameron wrote:
> On Fri, 11 Nov 2022 10:25:39 -0500
> Paul Gazzillo <paul@pgazz.com> wrote:
> 
> > On 11/11/2022, Andy Shevchenko wrote:
> > > On Thu, Nov 10, 2022 at 04:47:29PM -0500, Paul Gazzillo wrote:  
> > > > Fix an implicit declaration of function error for rpr0521 under some configs
> > > > 
> > > > When CONFIG_RPR0521 is enabled without CONFIG_IIO_TRIGGERED_BUFFER,
> > > > the build results in "implicit declaration of function" errors, e.g.,
> > > >   drivers/iio/light/rpr0521.c:434:3: error: implicit declaration of function
> > > >            'iio_trigger_poll_chained' [-Werror=implicit-function-declaration]
> > > >     434 |   iio_trigger_poll_chained(data->drdy_trigger0);
> > > >         |   ^~~~~~~~~~~~~~~~~~~~~~~~
> > > > 
> > > > This fix adds select dependencies to RPR0521's configuration declaration.
> > > > 
> > > > Signed-off-by: Paul Gazzillo <paul@pgazz.com>
> > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=216678  
> > > 
> > > No need to create a bugzilla report on such tiny issues that do actually not
> > > affect the working configurations.  
> > 
> > Understood.  Thanks for your help!
> 
> I wonder why it has taken so long for this build issue to get reported?
>

There seem to be lots of combinations of configuration options that
don't get tested or even built (understandably, given the enormous
number of options), leaving Kconfig with an incomplete picture of
dependencies.  There's just too many to test, though if users are only
using some predefined .config files (or testers are using only
allyesconfig) they may not encounter these corner cases that slip
through Kconfig (and maybe these cases aren't really very high
impact).  Our team's been researching how to better test across
configurations; one of our tools for finding unmet Kconfig dependency
bugs (kismet) is now being run by Intel's kernel test robot, but we're
also working on how to improve run-time testing as well, and I ran
across a configuration that triggered this build error.  In case
you're interested, here's our current tooling:
    https://github.com/paulgazz/kmax
Let me know if you have any related painpoints that this work might
help with.  I work in academia with funding that encourages
open-sourcing the results, so it's great to have real-world problems
that can provide a tangible benefit.

> Ah well. This is missing a fixes tag. I added
> Fixes: e12ffd241c00 ("iio: light: rpr0521 triggered buffer")

Thank you!

> 
> Applied to the fixes-togreg branch of iio.git.
>
> Thanks,
> 
> Jonathan
> 
> 
> 
> > 
> > > 
> > > FWIW,
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > >   
> > > > ---
> > > > V1 -> V2: Cleaned up commit message per reviewer comments and added link
> > > >           to bug report.
> > > > 
> > > >  drivers/iio/light/Kconfig | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > > 
> > > > diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> > > > index 7cf6e8490123..0d4447df7200 100644
> > > > --- a/drivers/iio/light/Kconfig
> > > > +++ b/drivers/iio/light/Kconfig
> > > > @@ -293,6 +293,8 @@ config RPR0521
> > > >  	tristate "ROHM RPR0521 ALS and proximity sensor driver"
> > > >  	depends on I2C
> > > >  	select REGMAP_I2C
> > > > +	select IIO_BUFFER
> > > > +	select IIO_TRIGGERED_BUFFER
> > > >  	help
> > > >  	  Say Y here if you want to build support for ROHM's RPR0521
> > > >  	  ambient light and proximity sensor device.
> > > > -- 
> > > > 2.25.1  
> > > 
> > > -- 
> > > With Best Regards,
> > > Andy Shevchenko  
> > 
> > Best,
> > Paul
