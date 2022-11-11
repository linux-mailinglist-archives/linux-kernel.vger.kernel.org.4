Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A1F625E4C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiKKPZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbiKKPZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:25:47 -0500
Received: from box.opentheblackbox.net (box.opentheblackbox.net [IPv6:2600:3c02::f03c:92ff:fee2:82bc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF248F50;
        Fri, 11 Nov 2022 07:25:44 -0800 (PST)
Received: from authenticated-user (box.opentheblackbox.net [172.105.151.37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.opentheblackbox.net (Postfix) with ESMTPSA id DF6F63FA28;
        Fri, 11 Nov 2022 10:25:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pgazz.com; s=mail;
        t=1668180342; bh=orc01RZY7/0uLJvFo+O/teLRueUerCyuwfFqepX6ydU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IloGAv+1pHOilQ5jTKiH5J5hPNPvjbqnC5UXLcADo5oHCMP9lk7DtBqhcChL5xNSm
         85auyVJ+HQJxt4WJ+dpXnIOaYfLA7tmY7F3kvp0a0LYDNu8mhNt/TlARuMcasBPfMg
         CP9uASY96cEW/vyTqocl5RwvSs5G/v7ZEUBloepdvYZi5pcWkU/TPYFo5K8VFgaDfr
         Cx4SeBoWL5LPlIHCa2yCqvo0EMz41GBWtPllB2LTw6K/JSl4IM9kdU9Ya2jh9mW9Ep
         sM2OXvAsBzHqWLxMzL5ndXbzYRWv8np2o1grxj2OZeyCB1f1XmhsLjiWfYkOmhFEsN
         9577/O+qMmkMA==
Date:   Fri, 11 Nov 2022 10:25:39 -0500
From:   Paul Gazzillo <paul@pgazz.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1]: iio: light: rpr0521: add missing Kconfig
 dependencies
Message-ID: <20221111152539.srpn3ng3erutka4u@device>
References: <20221110144448.wexu6neb67krqhla@device>
 <20221110214729.ls5ixav5kxpeftk7@device>
 <Y24xOvNVsuLsbBXX@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y24xOvNVsuLsbBXX@smile.fi.intel.com>
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,RCVD_IN_XBL,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2022, Andy Shevchenko wrote:
> On Thu, Nov 10, 2022 at 04:47:29PM -0500, Paul Gazzillo wrote:
> > Fix an implicit declaration of function error for rpr0521 under some configs
> > 
> > When CONFIG_RPR0521 is enabled without CONFIG_IIO_TRIGGERED_BUFFER,
> > the build results in "implicit declaration of function" errors, e.g.,
> >   drivers/iio/light/rpr0521.c:434:3: error: implicit declaration of function
> >            'iio_trigger_poll_chained' [-Werror=implicit-function-declaration]
> >     434 |   iio_trigger_poll_chained(data->drdy_trigger0);
> >         |   ^~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > This fix adds select dependencies to RPR0521's configuration declaration.
> > 
> > Signed-off-by: Paul Gazzillo <paul@pgazz.com>
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=216678
> 
> No need to create a bugzilla report on such tiny issues that do actually not
> affect the working configurations.

Understood.  Thanks for your help!

> 
> FWIW,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> > ---
> > V1 -> V2: Cleaned up commit message per reviewer comments and added link
> >           to bug report.
> > 
> >  drivers/iio/light/Kconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> > index 7cf6e8490123..0d4447df7200 100644
> > --- a/drivers/iio/light/Kconfig
> > +++ b/drivers/iio/light/Kconfig
> > @@ -293,6 +293,8 @@ config RPR0521
> >  	tristate "ROHM RPR0521 ALS and proximity sensor driver"
> >  	depends on I2C
> >  	select REGMAP_I2C
> > +	select IIO_BUFFER
> > +	select IIO_TRIGGERED_BUFFER
> >  	help
> >  	  Say Y here if you want to build support for ROHM's RPR0521
> >  	  ambient light and proximity sensor device.
> > -- 
> > 2.25.1
> 
> -- 
> With Best Regards,
> Andy Shevchenko

Best,
Paul
