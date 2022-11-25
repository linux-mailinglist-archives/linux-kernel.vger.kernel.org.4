Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CE0638B59
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 14:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiKYNhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 08:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiKYNhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 08:37:11 -0500
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDE4275E0;
        Fri, 25 Nov 2022 05:37:07 -0800 (PST)
Received: by mail-qv1-f42.google.com with SMTP id h10so2665244qvq.7;
        Fri, 25 Nov 2022 05:37:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H/q4ORqj+1WvrsL5OQMUArcB5WYASWCSO5oYKs9uTXQ=;
        b=57MI5A6zq3KL6LrFFfWBn+ZZLbh9Z0JF1LK1llzqDNtnwFTGPgwqqIhUSvVV7enwPo
         6DjIh78mmWACFrqZb/0M1XIhxzDUWkki0VcsSFtrRkRnxNogAXeTvqO9M6zDtO4UgTBL
         S4d0gc00M6pWgmWznvUxWYpcV3lt179cgAMeAkqQNz1rODh+YWJeBeUiASXyQIGxu0xc
         vXkGUgmhygWSJwWn3LAU/rdo/IISdJyN6U7Rw8AIs/SlA8MrTZCepElJH4ssZnxCl6zr
         K8lBcbvjHKpSmqB/0DGs4sNg+gE1mMvZ/vwQyxEs1pgsIzI41bugHW74Nk/vzPtGy2Mn
         JE+g==
X-Gm-Message-State: ANoB5pmmvG0UlJknjzgLG8lBdN9UEA1BNqj8ihlX6aXo5gy1Lvxmmfc7
        iNypP3uJobbwysAWdMPrxSShxakMXZBrGy/g3AI=
X-Google-Smtp-Source: AA0mqf4qDQlLIeoh8DcVGtZQFSffGK8i6e+msSpzdQdejg0WFVl6Pp0fk/2ioPjHZ+7aC2QnfKGDre7Wk+BSiy+qdn8=
X-Received: by 2002:a0c:c589:0:b0:4b1:a9ac:21de with SMTP id
 a9-20020a0cc589000000b004b1a9ac21demr17018211qvj.119.1669383426997; Fri, 25
 Nov 2022 05:37:06 -0800 (PST)
MIME-Version: 1.0
References: <20221105174225.28673-1-rui.zhang@intel.com> <20221105174225.28673-2-rui.zhang@intel.com>
 <CAJZ5v0gPOUQDb8c_pVYjzBvU3e3U9JoLhJy5vRBF4h2=zvaHHw@mail.gmail.com> <5ed329f894bc81f5375303a69c07dee16630503e.camel@intel.com>
In-Reply-To: <5ed329f894bc81f5375303a69c07dee16630503e.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Nov 2022 14:36:53 +0100
Message-ID: <CAJZ5v0gWwqtqezkBapqK4RbefOT2q7R7pWiTb8E4AbptFu7tAg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] cpuidle: ladder: Tune promotion/demotion threshold
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, rjw@rjwysocki.net,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 7:39 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> Hi, Rafael,
>
> thanks for reviewing the patch series.
>
> On Wed, 2022-11-23 at 18:50 +0100, Rafael J. Wysocki wrote:
> > On Sat, Nov 5, 2022 at 6:40 PM Zhang Rui <rui.zhang@intel.com> wrote:
> > > After fixing the bogus comparison between u64 and s64, the ladder
> > > governor stops making promotion decisions errornously.
> > >
> > > However, after this, it is found that the ladder governor demotes
> > > much
> > > easier than promotes.
> >
> > "After fixing an error related to using signed and unsigned integers
> > in the ladder governor in a previous patch, that governor turns out
> > to
> > demote much easier than promote"
> >
> > > Below is captured using turbostat after a 30 seconds runtime idle,
> > >
> > > Without previous patch,
> > > Busy%   IRQ     POLL    C1      C1E     C3      C6      C7s     C8
> > >      C9      C10     CPU%c1  CPU%c3  CPU%c6  CPU%c7  PkgWatt
> > > 0.30    2373    0       0       0       4       9       25      122
> > >      326     2857    0.36    0.04    0.57    98.73   1.48
> >
> > Why is the above relevant?
>
> Just for comparison purpose.
> For a pure idle scenario (Busy% < 0.5), with ladder governor, we used
> to have 99% CPU%c7, but now, with patch 1/3,
>
> CPU%c1  CPU%c3  CPU%c6  CPU%c7
> 34.18   16.21   17.69   31.51
> This does not look like the correct behavior for any cpuidle governor.

It all depends on what the design goal was and I don't really know
that in this particular case.

It looks like the plan was to make it promote less often than demote
or the counts would have been chosen differently.

> >
> > > With previous patch,
> > > Busy%   IRQ     POLL    C1      C1E     C3      C6      C7s     C8
> > >      C9      C10     CPU%c1  CPU%c3  CPU%c6  CPU%c7  PkgWatt
> > > 0.42    3071    0       771     838     447     327     336     382
> > >      299     344     34.18   16.21   17.69   31.51   2.00
> > >
> > > And this is caused by the imbalanced
> > > PROMOTION_COUNT/DEMOTION_COUNT.
> >
> > I would explain why/how the imbalanced PROMOTION_COUNT/DEMOTION_COUNT
> > imbalance causes this.
>
> sure, how about something below.
>
> The PROMOTION_COUNT/DEMOTION_COUNT are used as the threshold between
> the ladder governor detects it "should promote/demote", and the ladder
> governor does a real promotion/demotion.
>
> Currently, PROMOTION_COUNT is set to 4 and DEMOTION_COUNT is set to 1.
> This means that the ladder governor does real demotion immediately when
> it "should demote", but it does real promotion only if it "should
> promote" 4 times in a row, without a single "should demote" occur in
> between.
>
> As a result, this lower the chance to do real promotion and the ladder
> governor is more likely to choose a shallower state.

Sounds good and now the question is what's the behavior expected by
users.  Do we have any data?

> >
> > I guess more residency in the deeper idle state is expected?  Or
> > desired??
> >
> > > With this patch,
> > > Busy%   IRQ     POLL    C1      C1E     C3      C6      C7s     C8
> > >      C9      C10     CPU%c1  CPU%c3  CPU%c6  CPU%c7  PkgWatt
> > > 0.39    2436    0       1       72      177     51      194     243
> > >      799     1883    0.50    0.32    0.35    98.45   1.53
> > >
> > > Note that this is an experimental patch to illustrate the problem,
> > > and it is checked with idle scenario only for now.
> > > I will try to evaluate with more scenarios, and if someone can help
> > > evaluate with more scenarios at the same time and provide data for
> > > the
> > > benefit with different PROMOTION_COUNT/DEMOTION_COUNT values, that
> > > would be great.
> >
> > So yes, this requires more work.
> >
> > Overall, I think that you are concerned that the previous change
> > might
> > be regarded as a regression and are trying to compensate for it with
> > a
> > PROMOTION_COUNT/DEMOTION_COUNT change.
>
> Exactly.
>
> > I'm not sure I can agree with that approach, because the shallower
> > idle states might be preferred by the original ladder design
> > intentionally, for performance reasons.
> >
> hmmm, even if there is only 30% c7/c8/c9/c10 residency in a pure idle
> scenario?

Yes, even in that case.  All boils down to the question regarding user
expectations.

> And further more, since the imbalanced PROMOTION_COUNT/DEMOTION_COUNT
> and the unsigned/signed integers problem are both there since the first
> day the ladder governor was introduced, commit 4f86d3a8e297 ("cpuidle:
> consolidate 2.6.22 cpuidle branch into one patch"),
>
> my guess is that
>
> the unsigned/signed integers problem introduces a lot of pseudo
> promotions, and the PROMOTION_COUNT/DEMOTION_COUNT is introduced to
> workaround this so that the ladder governor doesn't get stuck at deep
> idle state.

That may be a good guess, so I would add it to the changelog of the patch.

> I don't have a solid proof for this. But at least for the pure idle
> scenario, I don't think 30% deep idle residency is the right behavior,
> and it needs to be tuned anyway.

Well, have you checked what happens if the counts are set to the same
value, e.g. 2?
