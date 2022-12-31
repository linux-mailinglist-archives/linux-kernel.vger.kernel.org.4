Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D8F65A507
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 15:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiLaOcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 09:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiLaOcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 09:32:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01095F4D;
        Sat, 31 Dec 2022 06:32:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90BB4B8074C;
        Sat, 31 Dec 2022 14:32:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4931DC433D2;
        Sat, 31 Dec 2022 14:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672497159;
        bh=MP5Y9V4XRfuEEV4O27iMkporMWBEUSDCBHNGenZ/zFo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X+8LVvji7s2e/Ba+WgxQm0PpYCDZQuqBLSaTED7r7ArgiZOMmex1gotxZBi4WOKa7
         y6IrQnF55BqOYnIjjzRD+Kq48ji1qLa1wIKqCH6ogDoT18NxkdJlKybWqZmSM4Vxn5
         HNvpQk5hJYt38ijy0z8D+vFgvjTMRZzEdYFT8i4bhz/Kb39dhKQjjmBp7IznD9kdj1
         VptgUrSeOOLfmWrjtru0RnPf3r0FBbTGqAT4eBegpTtpAygWSG6OlOLQXN/AQnctj4
         JXwEz0BqfclfSUAnyd6f4IbJt/SOkcQe2HD+yC97g0XyUi81crpqMUZdjj6/TpWaC1
         TBZQjS5M2O2VQ==
Date:   Sat, 31 Dec 2022 14:45:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/2] iio: adc: ti-adc128s052: Switch to use
 spi_get_device_match_data()
Message-ID: <20221231144558.44720f4d@jic23-huawei>
In-Reply-To: <Y6wTmapfACknDKO8@smile.fi.intel.com>
References: <20221214114944.83790-1-andriy.shevchenko@linux.intel.com>
        <20221223152242.2ee926eb@jic23-huawei>
        <20221223154450.458771b8@jic23-huawei>
        <Y6wTmapfACknDKO8@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
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

On Wed, 28 Dec 2022 11:59:53 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Dec 23, 2022 at 03:44:50PM +0000, Jonathan Cameron wrote:
> > On Fri, 23 Dec 2022 15:22:42 +0000
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >   
> > > On Wed, 14 Dec 2022 13:49:43 +0200
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > >   
> > > > The spi_get_device_match_data() helps to get driver data from the
> > > > firmware node or SPI ID table. Use it instead of open coding.
> > > > 
> > > > While at it, switch ID tables to provide an acrual pointers to
> > > > the configuration data.
> > > > 
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > ---
> > > > 
> > > > Requires aea672d054a2 ("spi: Introduce spi_get_device_match_data()
> > > > helper") which is part of upstream as of today.    
> > > 
> > > I rebased to get that (will rebase again on rc1).
> > > 
> > > Applied to the togreg branch of iio.git and pushed out as testing
> > > to keep 0-day busy over my holidays.  
> > 
> > I take it back...  Build test failed...  
> 
> As comment on the first patch stays this requires an SPI core patch, which is
> now the part of the v6.2-rc1.
> 
> Can you reapply it taking the above into consideration?
>

I should have been more specific though I do mention rebasing to get the
patch above.. Doesn't build with it.

Signature of spi_get_device_match_data is:
extern const void *
spi_get_device_match_data(const struct spi_device *sdev);

and you are passing it a struct device * which rather implies you didn't
successfully build test this.

Jonathan
