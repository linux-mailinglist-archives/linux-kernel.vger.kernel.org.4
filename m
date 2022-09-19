Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955F15BD3BE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiISRbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbiISRax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:30:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554043ED50;
        Mon, 19 Sep 2022 10:30:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED1DD6120D;
        Mon, 19 Sep 2022 17:30:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4498DC433D7;
        Mon, 19 Sep 2022 17:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663608644;
        bh=J59YjmE5HZxnFi8I5AwnSftZSu1bwZZJpYWsif3Fyxg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fefVOgkiTTAJi/tfVQPjrBF7EIidq28xbT7vg9BMSNZWyBi0uU33Bj7SOpvr9UlLa
         cx4QVUKQje+ouf/cj7HQuZB0XO0d/ulnT4M5u76e6sfcqW7LacXp8wLxdi2bzxJk83
         4Rh8zlmRaWM1NS+4777KZ1fxdRpA7aKlpR/M+yWskFOlzK2oKTfRYq1B+EIBf74Kkv
         fe2sHaaj+SmTXodNafwH7BB7fkaOGNbNfV+wU750QQ6o+rN4pUK9iHw1WmqO8VLkvz
         wSKwBZHrjIGhifphaIDMNWjfpbtd3lcx2YNOjrYvhi/hohDy9IQmCJpajDXgsi6z69
         SVavFBD6sd5bg==
Date:   Mon, 19 Sep 2022 18:30:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Crt Mori <cmo@melexis.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 1/3] iio: temperature: mlx90632 Add runtime
 powermanagement modes
Message-ID: <20220919183048.00c68a04@jic23-huawei>
In-Reply-To: <CAKv63usAjTh9b-HuVdikbtdPKeyFYPy0kENQpkGo6jWXkE_Quw@mail.gmail.com>
References: <cover.1663577091.git.cmo@melexis.com>
        <dadcba138c48286944cc03563967de9b4daddaaa.1663577091.git.cmo@melexis.com>
        <20220919172420.1a6fd52f@jic23-huawei>
        <CAKv63usAjTh9b-HuVdikbtdPKeyFYPy0kENQpkGo6jWXkE_Quw@mail.gmail.com>
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

On Mon, 19 Sep 2022 19:09:13 +0200
Crt Mori <cmo@melexis.com> wrote:

> On Mon, 19 Sept 2022 at 18:24, Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Mon, 19 Sep 2022 10:48:16 +0200
> > cmo@melexis.com wrote:
> >  
> > > From: Crt Mori <cmo@melexis.com>
> > >
> > > measurements in lower power mode (SLEEP_STEP), with the lowest refresh
> > > rate (2 seconds).  
> > Hi Crt,
> >
> > I'm a little nervous about one change in the flow from earlier versions.
> > I'm assuming you are sure it is always fine though!
> >
> > Previously before calling the _sleep() in remove we ensured the device
> > was powered up. Now that's no longer true. If runtime pm has it in
> > a low power state it will remain in that state at the point where we call
> > _sleep().
> >
> > One note/question on original code...  Why bother marking regcache dirty when
> > we are going down anyway?  It's not wrong as such, just probably not
> > that useful unless I'm missing something.  Same in the *_wakeup()
> > that puts the cache back but is only called in probe now.  
> 
> Previously when powered on the device the cache was not updated

ah. Got it.  Doing this makes sense if we don't provide the default register
values as there is nothing else to get them from.

However, I think the regmap core does this for us if defaults are not provided:
https://elixir.bootlin.com/linux/v6.0-rc5/source/drivers/base/regmap/regcache.c#L180

Does that not work here for some reason?  If so add a comment.

We do need the dance in the suspend and resume though as regcache code has no
way to know if the values are retained or not so we have to let it know.

>, so I
> added the marking of regcache at wakeup and saw that the same thing
> happens when in resume after powering on. I should keep this
> assumption still, so I will re-add the wakeup to resume (not runtime
> resume). I did not test this part as I focused on runtime resume so
> thanks for noticing.
> 
> >
> > Which then raises question of why we don't need to deal with the regcache
> > any more when we turn power off in suspend?
> >  
> 
> It just did not work properly without this. Not correct EEPROM
> coefficients were used for calculations.
> 
> > So either we need a statement of why the register state is maintained,
> > or add the maintenance for that.  Also probably makes sense to drop
> > the left over maintenance from the probe() and remove() (via devm) paths.
> >  
> I thought I did that by completely removing _remove() and using
> devm_actions for cleanup. Do you see a spot I missed?
> 

I don't think marking the regcache dirty in remove (via the _sleep() call)
does anything useful.  On fresh probe of the driver, we get a new regcache which
we can then sync as you are doing - so no point in marking the one we are about
to delete as dirty that I can see.


> > Jonathan
> >  
> > >
> > > -static int __maybe_unused mlx90632_pm_resume(struct device *dev)
> > > +static int mlx90632_pm_resume(struct device *dev)
> > >  {
> > > -     struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> > > -     struct mlx90632_data *data = iio_priv(indio_dev);
> > > +     struct mlx90632_data *data = iio_priv(dev_get_drvdata(dev));
> > > +
> > > +     return mlx90632_enable_regulator(data);
> > > +}
> > > +
> > > +static int mlx90632_pm_runtime_suspend(struct device *dev)
> > > +{
> > > +     struct mlx90632_data *data = iio_priv(dev_get_drvdata(dev));
> > >
> > > -     return mlx90632_wakeup(data);  
> > Previously we called wakeup here which writes the regcache back to
> > the device. Now I'm not seeing that happening anywhere in new code.
> > Why is it not needed?
> >  
> I had the same question before, why cache was needed to be marked
> dirty, but without it, CPU did not properly obtain the calculation
> coefficients. What happens now is that we are in step_sleep mode so
> measurements are triggered and it also takes the 2 seconds before they
> are updated. I did not check the line with scope, but I have yet to
> see the strange temperature output which would indicate that not
> proper EEPROM data is used. But I did focus on sleep mostly, so deeper
> sleep I did not retest.

I'd hope runtime pm doesn't need the dance with the cache as the
values should be retained.  It's the deeper sleep that is where I'd
see potential problems as you observed.

Jonathan

> 
> > > +     return mlx90632_pwr_set_sleep_step(data->regmap);
> > >  }  
> >  

