Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26336D310A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 15:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjDAN27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 09:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDAN25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 09:28:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F365191E8;
        Sat,  1 Apr 2023 06:28:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE373B80B44;
        Sat,  1 Apr 2023 13:28:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BFEC433D2;
        Sat,  1 Apr 2023 13:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680355733;
        bh=KxIxO2rX4jgSyw7YWBdw4thzcSm2syNW7lLThjvV2/U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UALVWdYP/UrjTlffE6f8A4f57Im6qpUvw1zBGPu9fURCDB+Z56aG5OWJ7N3BTHb4K
         Eb/msTIsIUhCBTW4qHPvqxFgK5CIkT4hHl74DMdsAQrc48pMVRL94yrGFxGzaUHDi0
         zEAqsmzDxtb+NfSd9LlftiaXX/dlF/eM9W+llL6Xsrm0OB3lgZtvtUHopkL1l0b+u3
         bO1KrI3Zr3qM/rUwtZSB24G3Em+ek+QpqlVHqaXSgfCKPMF4vIlM/XAzTtmNIQ127p
         AiuxvNPGTdnV4u3d9yHLe75q73xBKGO6eyCgRiorAAVtiukrpbZRqItaEc1BrGSCPw
         WJ1WE96FtyX+w==
Date:   Sat, 1 Apr 2023 14:44:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Lee Jones <lee@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: max597x: Add support for max597x
Message-ID: <20230401144402.42a3959c@jic23-huawei>
In-Reply-To: <4188a480-15dd-0e17-b3e9-7572eee3ea0c@9elements.com>
References: <20230323194550.1914725-1-Naresh.Solanki@9elements.com>
        <20230325193640.3dc8b330@jic23-huawei>
        <4188a480-15dd-0e17-b3e9-7572eee3ea0c@9elements.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2023 00:14:16 +0530
Naresh Solanki <naresh.solanki@9elements.com> wrote:

> Hi,
> 
> On 26-03-2023 01:06 am, Jonathan Cameron wrote:
> > On Thu, 23 Mar 2023 20:45:48 +0100
> > Naresh Solanki <naresh.solanki@9elements.com> wrote:
> >   
> >> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> >>
> >> max597x has 10bit ADC for voltage & current monitoring.
> >> Use iio framework to expose the same in sysfs.
> >>
> >> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> >> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>  
> > 
> > I'm not a fan of wild cards in driver names. This doesn't
> > for example support the max5974, max5971 etc
> > 
> > Much better to name it after one of the supported parts.
> > Obviously can't do much about the mfd driver now, but I'd prefer
> > not to carry that through to the IIO driver if possible.
> > 
> > One concern I have here is that from the max5978 datasheet I see
> > this device supports features that are very much directed at hwmon
> > type usecases.  In particular warning and critical threshold detection.
> > We don't support multiple thresholds (in same direction) for a single
> > channel via IIO.  If you want those features in the future you may want
> > to consider using the hwmon subsystem.
> > 
> > We tend to be flexible with devices that sit near the boundary of IIO
> > and hwmon because we can bridge many of the features using the iio-hwmon
> > bridge driver.  That doesn't work for more complex event handling and
> > I suspect some of the other features this device provides.  
> I believe it is the most appropriate approach for our use case at the 
> moment. If we decide to incorporate more complex event handling or need 
> to support multiple thresholds in the future, we will definitely 
> consider using the hwmon subsystem. Thank for your input.

It's not easy to move a driver (because of need to maintain ABI compatibility
in most cases).  Hence I'd suggest at least CCing the hwmon list and maintainers
on future versions with a cover letter than explains your reasoning on why
this particular support should use IIO.


> > 
> >   
> >> +
> >> +static int max597x_iio_read_raw(struct iio_dev *iio_dev,
> >> +				struct iio_chan_spec const *chan,
> >> +				int *val, int *val2, long info)
> >> +{
> >> +	int ret;
> >> +	struct max597x_iio *data = iio_priv(iio_dev);
> >> +	unsigned int reg_l, reg_h;
> >> +
> >> +	switch (info) {
> >> +	case IIO_CHAN_INFO_RAW:
> >> +		ret = regmap_read(data->regmap, chan->address, &reg_l);
> >> +		if (ret < 0)
> >> +			return ret;
> >> +		ret = regmap_read(data->regmap, chan->address - 1, &reg_h);
> >> +		if (ret < 0)
> >> +			return ret;
> >> +		*val = (reg_h << 2) | (reg_l & 3);  
> > 
> > I replied late to previous patch, but I'd prefer to see a bulk read if
> > possible.  It might ensure a matched pair, or if not reduce the chance of
> > tearing (when reg_l & 3 transitions from 3 to 0 for example and
> > reg_h & 1 is going from 0 to 1)
> > 
> > You could try a repeated read if the sampling rate is fairly low as
> > simply getting same high bits on either side of the low bit read is probably
> > enough to say tearing didn't happen.  
> Yes. will use something like:
> 		ret = regmap_bulk_read(data->regmap, chan->address - 1, &reg_l, 2);
> 		if (ret < 0)
> 			return ret;
> 		reg_h = reg_l & 0xff;
> 		reg_l = (reg_l >> 8) & 0xff;
> 		*val = (reg_h << 2) | (reg_l & 3);
As you are going to handle them as separate registers (which makes sense under the
circumstances) read into a u8 regs[2] then express this as the following which also
deals with endian issues by make the registering ordering explicit.
*val = (reg[0] << 2) | (reg[1] & 3);

Thanks,

Jonathan
