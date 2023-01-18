Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A479D6718E5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjARK0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 05:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjARKZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:25:39 -0500
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBD07D66D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 01:29:53 -0800 (PST)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 12A903F3F7;
        Wed, 18 Jan 2023 10:29:51 +0100 (CET)
Date:   Wed, 18 Jan 2023 10:29:50 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: adc: qcom-spmi-adc5: Fix the channel name
Message-ID: <20230118092950.kctzkvz5h6rzi7rp@SoMainline.org>
References: <20230117093944.72271-1-andriy.shevchenko@linux.intel.com>
 <20230117231204.fpvxryjscosg57a6@SoMainline.org>
 <Y8ejxsqeHL/pBTAY@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8ejxsqeHL/pBTAY@smile.fi.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-18 09:46:14, Andy Shevchenko wrote:
> On Wed, Jan 18, 2023 at 12:12:04AM +0100, Marijn Suijten wrote:
> > On 2023-01-17 11:39:44, Andy Shevchenko wrote:
> > > The node name can contain an address part which is not used by
> > > the driver. Cut it out before assigning the channel name.
> > 
> > This explanation doesn't cut it.  It's not that the driver "doesn't use"
> 
> Driver doesn't use it still. There is no contradiction, but I agree that
> below part is good to have in the commit message.

You can leave that in if you want but that's not the issue that I
reported/described.  Having both describes the situation in full.

> > the address part, it is that this string is propagated into the
> > userspace label, sysfs /filenames/ *and breaking ABI*.
> 
> So I will add it into v2 in case the fix works (see below).
> 
> ...
> 
> > > -	const char *name = fwnode_get_name(fwnode), *channel_name;
> > > +	const char *name, *channel_name;
> > 
> > I don't think this'll compile as name is still a pointer to const data,
> > while you're assigning (a '\0' char) to it below.
> 
> Right, it's always hard for me to compile things for ARM on x86 :-)
> Thanks for catching this up!

Thanks for sending this in regardless; as said before I rather break ABI
and clean the driver up properly (no more extend_name...) than sending a
fix like this :)

> But does this fix the issue after compilation fix?

It does, no more @xx in sysfs filenames nor label contents!

- Marijn
