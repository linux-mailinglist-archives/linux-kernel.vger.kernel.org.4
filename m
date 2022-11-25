Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAAB638419
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 07:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiKYGjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 01:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiKYGjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 01:39:04 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA0C1D640;
        Thu, 24 Nov 2022 22:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669358343; x=1700894343;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g8/tNfSQpEaSqLn7jd8I6VHreqJZWcaZZlqFJ8fP5g0=;
  b=K4vMxonR6qMVAQDYanByaL9U3LmIqh3kvnrXje5SPI1VMeGbOsgs1dAy
   I9gb8WMqu0RxwIi1KJocXfh23kON896lCJab4q/LvNRUrQnzOZAfycde7
   2yte6nPz+Sg7eJFar2PSjv0Xi4mrcDgYzt9YkGQL9Fycr/vU5TXzz9Om3
   IsjItXVqTzpOG7Rj2w7bQfA/v9Kg6U1kDynHcfYKAFWZ3CjObGRXRA5ds
   blP43jVjdpjMik3GcIAiFaPx957M4vHYQpiRAQftlZZ+If2cNCXZEg5U8
   XU57SOvMX2vBfz7+FQk3QRABm34sDOjq73rxaGoN6HmbJxYOidtCetP9s
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="315578605"
X-IronPort-AV: E=Sophos;i="5.96,192,1665471600"; 
   d="scan'208";a="315578605"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 22:39:03 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="784846015"
X-IronPort-AV: E=Sophos;i="5.96,192,1665471600"; 
   d="scan'208";a="784846015"
Received: from zhichen2-mobl.ccr.corp.intel.com ([10.254.210.142])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 22:39:01 -0800
Message-ID: <5ed329f894bc81f5375303a69c07dee16630503e.camel@intel.com>
Subject: Re: [RFC PATCH 2/3] cpuidle: ladder: Tune promotion/demotion
 threshold
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     rjw@rjwysocki.net, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 25 Nov 2022 14:38:59 +0800
In-Reply-To: <CAJZ5v0gPOUQDb8c_pVYjzBvU3e3U9JoLhJy5vRBF4h2=zvaHHw@mail.gmail.com>
References: <20221105174225.28673-1-rui.zhang@intel.com>
         <20221105174225.28673-2-rui.zhang@intel.com>
         <CAJZ5v0gPOUQDb8c_pVYjzBvU3e3U9JoLhJy5vRBF4h2=zvaHHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rafael,

thanks for reviewing the patch series.

On Wed, 2022-11-23 at 18:50 +0100, Rafael J. Wysocki wrote:
> On Sat, Nov 5, 2022 at 6:40 PM Zhang Rui <rui.zhang@intel.com> wrote:
> > After fixing the bogus comparison between u64 and s64, the ladder
> > governor stops making promotion decisions errornously.
> > 
> > However, after this, it is found that the ladder governor demotes
> > much
> > easier than promotes.
> 
> "After fixing an error related to using signed and unsigned integers
> in the ladder governor in a previous patch, that governor turns out
> to
> demote much easier than promote"
> 
> > Below is captured using turbostat after a 30 seconds runtime idle,
> > 
> > Without previous patch,
> > Busy%   IRQ     POLL    C1      C1E     C3      C6      C7s     C8 
> >      C9      C10     CPU%c1  CPU%c3  CPU%c6  CPU%c7  PkgWatt
> > 0.30    2373    0       0       0       4       9       25      122
> >      326     2857    0.36    0.04    0.57    98.73   1.48
> 
> Why is the above relevant?

Just for comparison purpose.
For a pure idle scenario (Busy% < 0.5), with ladder governor, we used
to have 99% CPU%c7, but now, with patch 1/3,

CPU%c1  CPU%c3  CPU%c6  CPU%c7
34.18   16.21   17.69   31.51
This does not look like the correct behavior for any cpuidle governor.

> 
> > With previous patch,
> > Busy%   IRQ     POLL    C1      C1E     C3      C6      C7s     C8 
> >      C9      C10     CPU%c1  CPU%c3  CPU%c6  CPU%c7  PkgWatt
> > 0.42    3071    0       771     838     447     327     336     382
> >      299     344     34.18   16.21   17.69   31.51   2.00
> > 
> > And this is caused by the imbalanced
> > PROMOTION_COUNT/DEMOTION_COUNT.
> 
> I would explain why/how the imbalanced PROMOTION_COUNT/DEMOTION_COUNT
> imbalance causes this.

sure, how about something below.

The PROMOTION_COUNT/DEMOTION_COUNT are used as the threshold between
the ladder governor detects it "should promote/demote", and the ladder
governor does a real promotion/demotion.

Currently, PROMOTION_COUNT is set to 4 and DEMOTION_COUNT is set to 1.
This means that the ladder governor does real demotion immediately when
it "should demote", but it does real promotion only if it "should
promote" 4 times in a row, without a single "should demote" occur in
between.

As a result, this lower the chance to do real promotion and the ladder
governor is more likely to choose a shallower state. 

> 
> I guess more residency in the deeper idle state is expected?  Or
> desired??
> 
> > With this patch,
> > Busy%   IRQ     POLL    C1      C1E     C3      C6      C7s     C8 
> >      C9      C10     CPU%c1  CPU%c3  CPU%c6  CPU%c7  PkgWatt
> > 0.39    2436    0       1       72      177     51      194     243
> >      799     1883    0.50    0.32    0.35    98.45   1.53
> > 
> > Note that this is an experimental patch to illustrate the problem,
> > and it is checked with idle scenario only for now.
> > I will try to evaluate with more scenarios, and if someone can help
> > evaluate with more scenarios at the same time and provide data for
> > the
> > benefit with different PROMOTION_COUNT/DEMOTION_COUNT values, that
> > would be great.
> 
> So yes, this requires more work.
> 
> Overall, I think that you are concerned that the previous change
> might
> be regarded as a regression and are trying to compensate for it with
> a
> PROMOTION_COUNT/DEMOTION_COUNT change.

Exactly.

> I'm not sure I can agree with that approach, because the shallower
> idle states might be preferred by the original ladder design
> intentionally, for performance reasons.
> 
hmmm, even if there is only 30% c7/c8/c9/c10 residency in a pure idle
scenario?

And further more, since the imbalanced PROMOTION_COUNT/DEMOTION_COUNT
and the unsigned/signed integers problem are both there since the first
day the ladder governor was introduced, commit 4f86d3a8e297 ("cpuidle:
consolidate 2.6.22 cpuidle branch into one patch"),

my guess is that

the unsigned/signed integers problem introduces a lot of pseudo
promotions, and the PROMOTION_COUNT/DEMOTION_COUNT is introduced to
workaround this so that the ladder governor doesn't get stuck at deep
idle state.

I don't have a solid proof for this. But at least for the pure idle
scenario, I don't think 30% deep idle residency is the right behavior,
and it needs to be tuned anyway.

thanks,
rui

> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/cpuidle/governors/ladder.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cpuidle/governors/ladder.c
> > b/drivers/cpuidle/governors/ladder.c
> > index fb61118aef37..4b47aa0a4da9 100644
> > --- a/drivers/cpuidle/governors/ladder.c
> > +++ b/drivers/cpuidle/governors/ladder.c
> > @@ -20,8 +20,8 @@
> >  #include <asm/io.h>
> >  #include <linux/uaccess.h>
> > 
> > -#define PROMOTION_COUNT 4
> > -#define DEMOTION_COUNT 1
> > +#define PROMOTION_COUNT 2
> > +#define DEMOTION_COUNT 4
> > 
> >  struct ladder_device_state {
> >         struct {
> > --


