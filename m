Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572D35E546C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 22:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbiIUUTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 16:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiIUUTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 16:19:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E79A50D7;
        Wed, 21 Sep 2022 13:19:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6327B832C2;
        Wed, 21 Sep 2022 20:19:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DF7C43142;
        Wed, 21 Sep 2022 20:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663791556;
        bh=l/tGrC21hOYmbZIw5FVoJaDoBMAp3AosMBxKOEqX4Aw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TXGhwHMHRDSvFjCwPVD4RDpZEn6bQqmtPYCxjdgZHaySqQmWABLu73wq9Jh5NgDG/
         M5rzxER1iv9bzbXGmQ/Nsh5efyS6nNPRMzOH5H46fKW+7CuA1zYIhxwPWRFVyV9sHy
         Jm5gWr7excwpO2axLhQQoF8cftIkPxmQ+VuhVlkznq6Y9og0V1NcI3ndThrOwMG+a0
         yNW4J7160ovTz0jzEG/1HyuPGaaTGZk237Q0wrfFmcPrSI64ZkcXc8Gjb7K6qwMa1y
         4gRR+wQtvo1M5KApqQ9126z0242D9CA4Ba9yrAa23+uLXtID7+eRGYgXWZZS9W3gnf
         uqlcKglVO1goA==
Date:   Wed, 21 Sep 2022 21:19:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Crt Mori <cmo@melexis.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 1/3] iio: temperature: mlx90632 Add runtime
 powermanagement modes
Message-ID: <20220921211923.237453b2@jic23-huawei>
In-Reply-To: <CAKv63uvDNbwn=Jb9Ee0fhSEBPJx94ckZTRCTQw7PfAH4UdN2Dg@mail.gmail.com>
References: <cover.1663577091.git.cmo@melexis.com>
        <dadcba138c48286944cc03563967de9b4daddaaa.1663577091.git.cmo@melexis.com>
        <20220919172420.1a6fd52f@jic23-huawei>
        <CAKv63usAjTh9b-HuVdikbtdPKeyFYPy0kENQpkGo6jWXkE_Quw@mail.gmail.com>
        <20220919183048.00c68a04@jic23-huawei>
        <CAKv63uvDNbwn=Jb9Ee0fhSEBPJx94ckZTRCTQw7PfAH4UdN2Dg@mail.gmail.com>
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

On Mon, 19 Sep 2022 19:59:47 +0200
Crt Mori <cmo@melexis.com> wrote:

> On Mon, 19 Sept 2022 at 19:30, Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Mon, 19 Sep 2022 19:09:13 +0200
> > Crt Mori <cmo@melexis.com> wrote:
> >  
> > > On Mon, 19 Sept 2022 at 18:24, Jonathan Cameron <jic23@kernel.org> wrote:  
> > > >
> > > > On Mon, 19 Sep 2022 10:48:16 +0200
> > > > cmo@melexis.com wrote:
> > > >  
> > > > > From: Crt Mori <cmo@melexis.com>
> > > > >
> > > > > measurements in lower power mode (SLEEP_STEP), with the lowest refresh
> > > > > rate (2 seconds).  
> > > > Hi Crt,
> > > >
> > > > I'm a little nervous about one change in the flow from earlier versions.
> > > > I'm assuming you are sure it is always fine though!
> > > >
> > > > Previously before calling the _sleep() in remove we ensured the device
> > > > was powered up. Now that's no longer true. If runtime pm has it in
> > > > a low power state it will remain in that state at the point where we call
> > > > _sleep().
> > > >
> > > > One note/question on original code...  Why bother marking regcache dirty when
> > > > we are going down anyway?  It's not wrong as such, just probably not
> > > > that useful unless I'm missing something.  Same in the *_wakeup()
> > > > that puts the cache back but is only called in probe now.  
> > >
> > > Previously when powered on the device the cache was not updated  
> >
> > ah. Got it.  Doing this makes sense if we don't provide the default register
> > values as there is nothing else to get them from.
> >
> > However, I think the regmap core does this for us if defaults are not provided:
> > https://elixir.bootlin.com/linux/v6.0-rc5/source/drivers/base/regmap/regcache.c#L180
> >
> > Does that not work here for some reason?  If so add a comment.  
> 
> It did not work in past, but I can make a few tests and file a bug
> later on if indeed we should not need to mark cache refresh at
> startup. I would here keep it as it was, because I remember having a
> big headache trying to figure out what I was missing with regmap_read
> conversion (I remember I started with simple i2c reads).

I'd definitely like to understand if there is a problem here as it would
effect a load of other devices.

> 
> >
> > We do need the dance in the suspend and resume though as regcache code has no
> > way to know if the values are retained or not so we have to let it know.
> >  
> > >, so I
> > > added the marking of regcache at wakeup and saw that the same thing
> > > happens when in resume after powering on. I should keep this
> > > assumption still, so I will re-add the wakeup to resume (not runtime
> > > resume). I did not test this part as I focused on runtime resume so
> > > thanks for noticing.
> > >  
> > > >
> > > > Which then raises question of why we don't need to deal with the regcache
> > > > any more when we turn power off in suspend?
> > > >  
> > >
> > > It just did not work properly without this. Not correct EEPROM
> > > coefficients were used for calculations.
> > >  
> > > > So either we need a statement of why the register state is maintained,
> > > > or add the maintenance for that.  Also probably makes sense to drop
> > > > the left over maintenance from the probe() and remove() (via devm) paths.
> > > >  
> > > I thought I did that by completely removing _remove() and using
> > > devm_actions for cleanup. Do you see a spot I missed?
> > >  
> >
> > I don't think marking the regcache dirty in remove (via the _sleep() call)
> > does anything useful.  On fresh probe of the driver, we get a new regcache which
> > we can then sync as you are doing - so no point in marking the one we are about
> > to delete as dirty that I can see.
> >  
> 
> So you would rather that I make a new function which basically will be
> a wrapper around mlx90632_pwr_set_sleep_step (as I don't want to
> change that function to return nothing and take a void pointer)
> instead of using mlx90632_sleep in remove (beside using it in
> pm_suspend after this change)?

yes - it would indeed be something like you describe.

> 
> >  
> > > > Jonathan
> > > >  
> > > > >
> > > > > -static int __maybe_unused mlx90632_pm_resume(struct device *dev)
> > > > > +static int mlx90632_pm_resume(struct device *dev)
> > > > >  {
> > > > > -     struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> > > > > -     struct mlx90632_data *data = iio_priv(indio_dev);
> > > > > +     struct mlx90632_data *data = iio_priv(dev_get_drvdata(dev));
> > > > > +
> > > > > +     return mlx90632_enable_regulator(data);
> > > > > +}
> > > > > +
> > > > > +static int mlx90632_pm_runtime_suspend(struct device *dev)
> > > > > +{
> > > > > +     struct mlx90632_data *data = iio_priv(dev_get_drvdata(dev));
> > > > >
> > > > > -     return mlx90632_wakeup(data);  
> > > > Previously we called wakeup here which writes the regcache back to
> > > > the device. Now I'm not seeing that happening anywhere in new code.
> > > > Why is it not needed?
> > > >  
> > > I had the same question before, why cache was needed to be marked
> > > dirty, but without it, CPU did not properly obtain the calculation
> > > coefficients. What happens now is that we are in step_sleep mode so
> > > measurements are triggered and it also takes the 2 seconds before they
> > > are updated. I did not check the line with scope, but I have yet to
> > > see the strange temperature output which would indicate that not
> > > proper EEPROM data is used. But I did focus on sleep mostly, so deeper
> > > sleep I did not retest.  
> >
> > I'd hope runtime pm doesn't need the dance with the cache as the
> > values should be retained.  It's the deeper sleep that is where I'd
> > see potential problems as you observed.  
> 
> You are correct - runtime_pm never needed any of the cache stuff.
> 
> >
> > Jonathan
> >  
> > >  
> > > > > +     return mlx90632_pwr_set_sleep_step(data->regmap);
> > > > >  }  
> > > >  
> >  

