Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82D7702C18
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241755AbjEOL6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241606AbjEOL6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:58:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAB12699;
        Mon, 15 May 2023 04:55:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84E2A6224D;
        Mon, 15 May 2023 11:55:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74BDAC4339E;
        Mon, 15 May 2023 11:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684151719;
        bh=LM25J4KXPt/WwdGCWg9t6HOTk+4FHz+nzlXEdIACN18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ytX9itB6cmA/S/w3NnY7T9t+f3m7iFGkc9RX9/gTRkP+L2NMqoXGbWx5yM8gIDhqW
         DmwR3Ru+tm95NbuH3zNF/uB9dkKlLR4uLj0+zQz1JGxRsBmjR64nW4aIlm74xBPWaM
         ibHRNb0kzhWgcE7DVopBy0yPsVXYadJZIoXdlbDc=
Date:   Mon, 15 May 2023 13:55:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux@roeck-us.net,
        michal.simek@amd.com, Jonathan.Cameron@huawei.com,
        Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 1/4] devres: Provide krealloc_array
Message-ID: <2023051530-immunize-pony-49ef@gregkh>
References: <20230509094942.396150-1-james.clark@arm.com>
 <20230509094942.396150-2-james.clark@arm.com>
 <2023051340-sinuous-darkroom-2497@gregkh>
 <89ad5070-db72-7bf1-5d86-a89fea54e789@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89ad5070-db72-7bf1-5d86-a89fea54e789@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 08:55:33AM +0100, James Clark wrote:
> 
> 
> On 13/05/2023 12:04, Greg KH wrote:
> > On Tue, May 09, 2023 at 10:49:38AM +0100, James Clark wrote:
> >> There is no krealloc_array equivalent in devres. Users would have to
> >> do their own multiplication overflow check so provide one.
> >>
> >> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >> Signed-off-by: James Clark <james.clark@arm.com>
> >> ---
> >>  Documentation/driver-api/driver-model/devres.rst |  1 +
> >>  include/linux/device.h                           | 11 +++++++++++
> >>  2 files changed, 12 insertions(+)
> >>
> >> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
> >> index 4249eb4239e0..8be086b3f829 100644
> >> --- a/Documentation/driver-api/driver-model/devres.rst
> >> +++ b/Documentation/driver-api/driver-model/devres.rst
> >> @@ -364,6 +364,7 @@ MEM
> >>    devm_kmalloc_array()
> >>    devm_kmemdup()
> >>    devm_krealloc()
> >> +  devm_krealloc_array()
> >>    devm_kstrdup()
> >>    devm_kstrdup_const()
> >>    devm_kvasprintf()
> >> diff --git a/include/linux/device.h b/include/linux/device.h
> >> index 472dd24d4823..58f4f5948edb 100644
> >> --- a/include/linux/device.h
> >> +++ b/include/linux/device.h
> >> @@ -223,6 +223,17 @@ static inline void *devm_kcalloc(struct device *dev,
> >>  {
> >>  	return devm_kmalloc_array(dev, n, size, flags | __GFP_ZERO);
> >>  }
> >> +static inline __realloc_size(3, 4) void * __must_check
> > 
> > Shouldn't you have a blank line before this one?
> 
> I was going for consistency with the rest of this section which doesn't
> have newlines between the functions for some reason. I can add one and
> resubmit but it might look a bit out of place?

Ah, wasn't aware of that, given the lack of context.  So nevermind, it's
fine for now.

> >> +devm_krealloc_array(struct device *dev, void *p, size_t new_n, size_t new_size, gfp_t flags)
> >> +{
> >> +	size_t bytes;
> >> +
> >> +	if (unlikely(check_mul_overflow(new_n, new_size, &bytes)))
> >> +		return NULL;
> >> +
> >> +	return devm_krealloc(dev, p, bytes, flags);
> >> +}
> > 
> > I dislike how we have to keep copying the "real" functions (i.e.
> > krealloc_array) into something like this, but I can't think of a better
> > way to do it.
> > 
> 
> Maybe something could be done with some macro magic, but it would
> probably end up being worse than just copying them and would affect the
> real ones as well. So yeah I can't think of any easy gains either.

Ok, that's good.  Given a lack of objections from others, I'll just take
this through my driver core tree in a few days.

thanks,

greg k-h
