Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA4374F81D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 20:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjGKSsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 14:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGKSsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 14:48:30 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1591BB;
        Tue, 11 Jul 2023 11:48:29 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6b5d57d7db9so5044344a34.3;
        Tue, 11 Jul 2023 11:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689101308; x=1691693308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gu03/SCtVVcBDsZ2+gj/YtwCxilJE8tJksxSSr0pLio=;
        b=NWpaJocUhmsi0NHcxdC+xRoeqhWS61QuWM7DapD7Tfi7ZDS6ZuhkIMvrW1x/Xopa55
         rNkvuKfd7qQS01YnHgf4aWCgSefp5oZcMLnmlXiISonBProKGxgzQitPQYdkJpz/XYWi
         eahI5jb0+VY7/pMwLJNoGp41rX1rzwKjbDfVCyTM7HJ0mBHha3G5uTcVRE5QhRm54UKb
         hOH4tbXhP6PvOEYLjUdKYkC4fUfsUj/KdjJ8m+eyOLrjbAn766IGD7Sztn38atZ/jiF/
         rCCGougGYodzqMYhRSuCVQozWM8vAN+voXpmNlGItaqgwPdPcjE0Jj15SnvzdG0KEmjp
         mAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689101308; x=1691693308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gu03/SCtVVcBDsZ2+gj/YtwCxilJE8tJksxSSr0pLio=;
        b=L8sXGjw387R0PVrKjdMQNUAPRvq3R5MFjkz7I/6JhF8SpJi3SaT8ruzITNW8sD7bDV
         4+BcBEWw0J9jca7mTHLVISRrdaTVW8RfEcKHwAmik5tE0NxAtxjh10ibzZIhd9TX/4Yv
         4HzYocBPDCCOSx2CzlRbtiL6wnbDVxteK0iOtCMRBnfV1Wfvbpw5TAHiccYeNHfxfJR+
         hNc0lG3RRgFw3nEHBB0R6dxsx+6159KjFoRGs26237xxh9PJGndSbXjcGS2c9N+CcfXT
         pxiDJkAeT0keCavXr5iZTqivlWErLwawHMeQP1cI6UtHc9c82YMuh2kN+ccn9qSli7sU
         8urg==
X-Gm-Message-State: ABy/qLa3PNpB50tPaAKY3zCCFvYVptu0I73g4Ncdq/yYp5zq7RtHFTAV
        S0chGIg4Mt3N8On/o5hegzU=
X-Google-Smtp-Source: APBJJlH7f99gu6ixZlphLL9S+yFCej1SPbG1Q/Md/m4FfKJGPCCz7/pZB4oRbW7KN1xkOCm+grPv4w==
X-Received: by 2002:a05:6358:7f05:b0:135:57d0:d170 with SMTP id p5-20020a0563587f0500b0013557d0d170mr6811803rwn.11.1689101307873;
        Tue, 11 Jul 2023 11:48:27 -0700 (PDT)
Received: from j293.lan ([2400:4051:ea3:5910:5676:1078:8b85:c18f])
        by smtp.gmail.com with ESMTPSA id l6-20020a637006000000b0055b07fcb6ddsm1937688pgc.72.2023.07.11.11.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 11:48:27 -0700 (PDT)
Date:   Wed, 12 Jul 2023 03:48:22 +0900
From:   Kazuki Hashimoto <kazukih0205@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Hector Martin <marcan@marcan.st>,
        Kazuki Hashimoto <kazukih0205@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cpuidle: Don't pass any values to
 cpuidle_not_available
Message-ID: <f3nt5ve3derp2kmbe5zcj3kvtozcrhsvbduxtn5yj5yqnfvztb@v2nm4zuvyzhq>
References: <20230711-cpuidle-v1-0-f391224b3140@gmail.com>
 <20230711-cpuidle-v1-1-f391224b3140@gmail.com>
 <20230711074231.GD3062772@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711074231.GD3062772@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

on oue, Jul 11, 2023 at 09:42:31AM +0200, Peter Zijlstra wrote:
> On Tue, Jul 11, 2023 at 02:54:21PM +0900, Kazuki Hashimoto wrote:
> > There's no reason to pass any values to cpuidle_not_available() as the
> > function works standalone. Since we're planning to use the function in
> > other places, make it so to avoid code duplication.
> > 
> > Signed-off-by: Kazuki Hashimoto <kazukih0205@gmail.com>
> > ---
> >  drivers/cpuidle/cpuidle.c | 6 ++++--
> >  include/linux/cpuidle.h   | 6 ++----
> >  kernel/sched/idle.c       | 2 +-
> >  3 files changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> > index 737a026ef58a..c9ba51e0fa38 100644
> > --- a/drivers/cpuidle/cpuidle.c
> > +++ b/drivers/cpuidle/cpuidle.c
> > @@ -49,9 +49,11 @@ void disable_cpuidle(void)
> >  	off = 1;
> >  }
> >  
> > -bool cpuidle_not_available(struct cpuidle_driver *drv,
> > -			   struct cpuidle_device *dev)
> > +bool cpuidle_not_available(void)
> >  {
> > +	struct cpuidle_device *dev = cpuidle_get_device();
> > +	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
> > +
> >  	return off || !initialized || !drv || !dev || !dev->enabled;
> >  }
> 
> It appears to me these are a lot of conditions to check *every* time we
> go idle -- especially since they hardly, if ever, change.
> 
> Can't cpuidle track all this in a single global variable, preferably as
> a static_key ?
I don't think so? I'll drop this one though since it adds unnecesary
overhead.

Thanks,
Kazuki
