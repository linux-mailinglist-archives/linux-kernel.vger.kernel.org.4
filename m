Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303486785F1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjAWTRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjAWTRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:17:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CD140FA;
        Mon, 23 Jan 2023 11:17:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B00A60FE5;
        Mon, 23 Jan 2023 19:17:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F2FC433EF;
        Mon, 23 Jan 2023 19:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674501433;
        bh=WPTo/AYSSV3PH4rx0T+DOwWymx0lq8Uby5njTsynD3g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qIFZNkae57YPCdDiHeWgTq101KzsRoV+P2dV6cJUNu1D2ZQ402vEvlIWyw6mkvYyQ
         UaKffvML6hJ3wu0fM2fp0Xh6YKog6GAMDyYeedSYB1Awoa6Wt7GrvnSjrgxfM/XpH/
         EyCj9dEe0/Bf72NrD9R7ZFdGLieFfEgELTvlZ0FQQZIrOxBLTqz7tAf5iYms9kjrwu
         17Fh9DexQVSjGUumyhFEMXBviNypDoLvIeMsnXmCuZzHejl9Trl8PlNtXukzlKW1LW
         BmhkE2H9QotRtoDzc2stXSym2If9OHO46gHD/9U+SWP+JgeBFrycI8p3iZN/glzmGY
         p9mmm5Rv5BNRA==
Date:   Mon, 23 Jan 2023 19:30:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2 1/1] iio: adc: qcom-spmi-adc5: Fix the channel name
Message-ID: <20230123193059.27a1c1a7@jic23-huawei>
In-Reply-To: <Y853a5jr4rfrDHfd@smile.fi.intel.com>
References: <20230118100623.42255-1-andriy.shevchenko@linux.intel.com>
        <20230122172441.4f8d75f5@jic23-huawei>
        <Y853a5jr4rfrDHfd@smile.fi.intel.com>
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

On Mon, 23 Jan 2023 14:02:51 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sun, Jan 22, 2023 at 05:24:41PM +0000, Jonathan Cameron wrote:
> > On Wed, 18 Jan 2023 12:06:23 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >   
> > > The node name can contain an address part which is unused
> > > by the driver. Moreover, this string is propagated into
> > > the userspace label, sysfs filenames *and breaking ABI*.
> > > 
> > > Cut the address part out before assigning the channel name.
> > > 
> > > Fixes: 4f47a236a23d ("iio: adc: qcom-spmi-adc5: convert to device properties")
> > > Reported-by: Marijn Suijten <marijn.suijten@somainline.org>
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> > 
> > LGTM, but given it will have ABI impact, I'd like to hear from 
> > Andy, Bjorn or Konrad as maintainers and /or Dmitry as someone
> > who has touched this driver fairly recently.  
> 
> Hmm... But this is to fix the ABI breakage. It means that the previous series
> by Nuno had broken it.
Absolutely agree. I plan to take the change. The risk that someone needs
to fix up their use of the broken ABI makes it worth a little more shouting
about than if we had caught it sooner.

Jonathan

> 
> > Mostly I want to be sure they know this exists before it causes surprise.  
> 

