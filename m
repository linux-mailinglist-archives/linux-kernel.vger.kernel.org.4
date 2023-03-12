Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFBC6B678C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 16:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjCLPg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 11:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjCLPg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 11:36:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A292343441;
        Sun, 12 Mar 2023 08:36:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3657460F2D;
        Sun, 12 Mar 2023 15:36:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE944C433EF;
        Sun, 12 Mar 2023 15:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678635410;
        bh=bBBlxMEPLUb4VCFvvJ0V/XYfNtveGw01hltB18ML8WQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CHnEGZjO+FUV0smOlfk2In/q0P64C5cm3rcy4JIYM0qL5tnqu2OH9pm7v7tzJ3Uc4
         QCschvH+X2FSTuFahen8vgMPgdrsfKSIEiavX4Fp7uvrmIUI6tNcYq5stSHvt2qLOI
         nVXvkuJJmrpZXKjXvUOqcdBgbQtNWimrfDJTlubO/l5MRifc2wKEzj77GGeB3Li6KQ
         1gW2tVhaAJXnj3ndBaIrEebXM8d6RxbKT2fsfjWw3SoXAgdH6qmR68GCqQB+5x+DUs
         UFAYYBP8zPBBxndsZJ289uDhzetB66+Bm5N5nte3LmhpNON8+D37xCnfZbrL252Do3
         O8z3rXhdtDflg==
Date:   Sun, 12 Mar 2023 15:36:55 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 5/6] iio: light: ROHM BU27034 Ambient Light Sensor
Message-ID: <20230312153655.052d5730@jic23-huawei>
In-Reply-To: <c16d372f-a122-16d6-ad08-1fbffb01d9ff@gmail.com>
References: <cover.1677750859.git.mazziesaccount@gmail.com>
        <874d59be98703bb58a98fea72138de5b94d71a52.1677750859.git.mazziesaccount@gmail.com>
        <20230304201720.2d554f07@jic23-huawei>
        <c16d372f-a122-16d6-ad08-1fbffb01d9ff@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Mar 2023 14:22:51 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 3/4/23 22:17, Jonathan Cameron wrote:
> > On Thu, 2 Mar 2023 12:58:59 +0200
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> +/*
> >> + * The BU27034 does not have interrupt or any other mechanism of triggering
> >> + * the data read when measurement has finished. Hence we poll the VALID bit in
> >> + * a thread. We will try to wake the thread BU27034_MEAS_WAIT_PREMATURE_MS
> >> + * milliseconds before the expected sampling time to prevent the drifting. Eg,
> >> + * If we constantly wake up a bit too late we would eventually skip a sample.  
> > 
> > Lazier approach would be to just sent the sampling frequency at twice the
> > expected frequency and you'll never miss a sample unless you the wake up is
> > delayed massively for some reason.  Particularly 'fresh' data might not matter
> > enough that half a cycle late is a problem.  
> 
> Hmm. Do I read this right - You suggest we drop the polling loop for 
> valid bit and just always sleep for int_time / 2 if data was not valid?

Yes.  There are costs to both methods, but the advantage here is that the chance
of being so late you miss becomes much less.

> 
> I don't know. That would probably make the time-stamps for buffered 
> results to be jumping quite a bit - especially with the longer 
> integration times.

True enough.  They are probably fairly noisy either way but this would make them
worse.

> 
> >> + * And because the sleep can't wake up _exactly_ at given time this would be
> >> + * inevitable even if the sensor clock would be perfectly phase-locked to CPU
> >> + * clock - which we can't say is the case.
> >> + *
> >> + * This is still fragile. No matter how big advance do we have, we will still
> >> + * risk of losing a sample because things can in a rainy-day skenario be
> >> + * delayed a lot. Yet, more we reserve the time for polling, more we also lose
> >> + * the performance by spending cycles polling the register. So, selecting this
> >> + * value is a balancing dance between severity of wasting CPU time and severity
> >> + * of losing samples.
> >> + *
> >> + * In most cases losing the samples is not _that_ crucial because light levels
> >> + * tend to change slowly.
> >> + */
> >> +#define BU27034_MEAS_WAIT_PREMATURE_MS	5
> >> +#define BU27034_DATA_WAIT_TIME_US	1000
> >> +#define BU27034_TOTAL_DATA_WAIT_TIME_US (BU27034_MEAS_WAIT_PREMATURE_MS * 1000)  
> >   
> >> +static const struct iio_chan_spec bu27034_channels[] = {
> >> +	{
> >> +		.type = IIO_LIGHT,
> >> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> >> +				      BIT(IIO_CHAN_INFO_SCALE),  
> > 
> > What is this scale for?  
> 
> The scale is to inform users that we return data using milli lux.
> 
> > Given the channel is computed from various different inputs, is there a
> > clear definition of how it is scaled?  What does a write to it mean?  
> 
> Nothing. writing anything else but milli lux scale fails with -EINVAL.
> 
> I guess I am doing something in an unusual way here :) Do you have a 
> suggestion for me?

Return data in lux?  Or return it as INFO_RAW - thus making it clear
that the reading is not in expected units and a conversion must be
applied by userspace.  SCALE is not applied to PROCESSED by userspace.

In the rare case where you do get SCALE and PROCESSED it's there to allow
for changes in the underlying signal measurement that are eaten up in the
computation needed to get to PROCESSED - that is they have no visible
affect (beyond range changes etc).


...

> >> +
> >> +	ret = regmap_read(regmap, BU27034_REG_SYSTEM_CONTROL, &part_id);  
> > 
> > As it's not all of the register I'd rename the temporary variable to
> > val or reg or something along those lines.  
> 
> I still like having the variable named part_id - as it makes the check 
> obvious. What I did was adding another temporary variable 'reg' and doing:
> 
> part_id = FIELD_GET(BU27034_MASK_PART_ID, reg);
> 
> and then using the part_id in if() and dev_warn().

Looks good.


Jonathan

