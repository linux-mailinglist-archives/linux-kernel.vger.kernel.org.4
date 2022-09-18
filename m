Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B6D5BBD7E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 12:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiIRKzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 06:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIRKzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 06:55:18 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AD211805
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 03:55:13 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id r13-20020a056830418d00b0065601df69c0so12600496otu.7
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 03:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=zvJhJH9Co1bqN2sVQ/HT2u/qwCtRPdd649kof67q2cE=;
        b=AGH6MWt+Kc42BiCUTvBplaSzqQgQhot8B1wpbVKAcGGJFk656fIfG4JuFT2iVszT71
         4qjyHNpUzYrh76fXJfr4WRjnBOFOrmmVRm6WOPd+AUmn0jjlLc6zg5m1TidykLOPv9um
         lRts63fhnnSj3KNsEX+WGCvw3YqyUUrz31qLl7YzW57voKdW9b4Dqdl+Lhz4DdqAWsE9
         9ySsHKscqGzM4v6kiSb4LMuwj2cZ+b5Awo0wE5af/d7UZa8+GuW1DGRjJe5OGaAGtS3U
         dcTUk1gZxeJYhOAIbWXu4svLRb2clqLmX8pA8UIB5n8jQiAtzGmd6iMPYtX0NX/kEWW7
         BSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zvJhJH9Co1bqN2sVQ/HT2u/qwCtRPdd649kof67q2cE=;
        b=IeP14Apo/T6RShe01xfAQ1pfVcZ192U6RyoXdC3gjQTpSt0Hj+5QN2Wb1nMpy6Aj59
         85wh6z1JeAJofB2s56ehtvOcX2aiJnSPFiptZcj9bJh2YchqFs7b2Xsiq3bILq+sgORw
         lSSr1g9/dWfKGtIOnNRHThlMhhqEPVTOHdpcYMBGbIC3K8djIwz/LPDMD7fyK5azFwus
         wljNfUt4nzr+JSfyw7mq+q0TkpeZtAp03AQttMQNqQZIvG7GRdJeFWCa2U+sdHT9YFVx
         05HcJW4aPNJH91vjc4rvPuv+YwL2hRoB4G37XhRWCh9D6nRBijRFx7+DZWn9zfpaZckf
         zg1w==
X-Gm-Message-State: ACrzQf2JA6/7/oftXWJBV6mg/DysHUHE3pExokn7tpg/YhN4z1TSjlYr
        uVjDC5QmFN/mJkUispDlOxnhriwwcEU=
X-Google-Smtp-Source: AMsMyM7dptGj49aIUEnF1IcALv6EsxiSITA6gmf5KPhKc4OTdrGyCfeY7cQ8WsvNg6QNUz0F86eEKA==
X-Received: by 2002:a05:6830:1f3a:b0:658:bcc:99e with SMTP id e26-20020a0568301f3a00b006580bcc099emr5854151oth.215.1663498513062;
        Sun, 18 Sep 2022 03:55:13 -0700 (PDT)
Received: from haolee.io ([2600:3c00::f03c:91ff:fe02:b162])
        by smtp.gmail.com with ESMTPSA id q43-20020a056871082b00b00127616039e7sm6085785oap.29.2022.09.18.03.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 03:55:12 -0700 (PDT)
Date:   Sun, 18 Sep 2022 10:55:10 +0000
From:   Hao Lee <haolee.swjtu@gmail.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] psi: fix possible missing or delayed pending event
Message-ID: <20220918105510.GA22671@haolee.io>
References: <20220914092959.GA20640@haolee.io>
 <CAJuCfpFVK3ceHy+ipSbLb0jAgE6tJAsu5=kbJEB9X4OWPnsVxA@mail.gmail.com>
 <20220917073124.GA3483@haolee.io>
 <CAJuCfpH6QVuKd-Y1qr1Rzh+hCG-HVgmWfXk9r0tsFhDijZ_ABg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpH6QVuKd-Y1qr1Rzh+hCG-HVgmWfXk9r0tsFhDijZ_ABg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2022 at 09:44:12PM -0700, Suren Baghdasaryan wrote:
> On Sat, Sep 17, 2022 at 12:31 AM Hao Lee <haolee.swjtu@gmail.com> wrote:
> >
> > On Fri, Sep 16, 2022 at 11:08:34PM -0700, Suren Baghdasaryan wrote:
> > > On Wed, Sep 14, 2022 at 2:30 AM Hao Lee <haolee.swjtu@gmail.com> wrote:
> > > >
> > > > When a pending event exists and growth is less than the threshold, the
> > > > current logic is to skip this trigger without generating event. However,
> > > > from e6df4ead85d9 ("psi: fix possible trigger missing in the window"),
> > > > our purpose is to generate event as long as pending event exists and the
> > > > rate meets the limit. This patch fixes the possible pending-event
> > > > missing or delay.
> > > >
> > > > Fixes: e6df4ead85d9 ("psi: fix possible trigger missing in the window")
> > > > Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
> > > > ---
> > > >  kernel/sched/psi.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > > > index 9711827e3..0bae4ee2b 100644
> > > > --- a/kernel/sched/psi.c
> > > > +++ b/kernel/sched/psi.c
> > > > @@ -539,7 +539,7 @@ static u64 update_triggers(struct psi_group *group, u64 now)
> > > >
> > > >                         /* Calculate growth since last update */
> > > >                         growth = window_update(&t->win, now, total[t->state]);
> > > > -                       if (growth < t->threshold)
> > > > +                       if (growth < t->threshold && !t->pending_event)
> > >
> > > I'm not sure how this additional condition changes things. Current
> > > logic is to set t->pending_event=true whenever growth exceeds the
> > > t->threshold. This patch will change this logic into setting
> > > t->pending_event=true also when t->pending_event=true.
> >
> > This is right.
> >
> > > But why would
> > > you want to set t->pending_event=true if it's already true? What am I
> > > missing?
> >
> > If I expand this if-else branch and the pending_event statement
> > to a more detailed snippet, it will be like this:
> >
> > if (growth < t->threshold && !t->pending_event) // under threshold && no pending event. Skip.
> >         continue;
> > else if (growth >= t->threshold) // above threshold. Try to generate event.
> >         t->pending_event = true;
> > else // under threshold && have pending events. Try to generate event.
> >         ; // pending_event is already true. do nothing
> >
> >
> > The original code didn't handle the `else` condition properly.
> 
> The `else` condition in your code does nothing, and that's why the
> original code does not implement a handler for that case.
> 
> > It will
> > skip the trigger when its growth is under the threshold, even though it
> > has a pending event. This patch handles this condition correctly.
> >
> > But I think assigning true to pending_event when it's already true doesn't
> > have other side effects, so I eliminate the `else if` branch. Maybe we'd
> > better make it explicit, like the above snippet? Thanks.
> 
> The new code you posted is functionally the same as the original one
> while being more verbose and IMO less readable. Unless you can explain
> the problem with the original code, I don't see any reason to change
> it.

Hi, for the original code, let's assume t->pending_event is true:
    * if new_stall is false, we will try to check event ratelimit and
      generate an event for this psi_trigger. This case is right.
    * but if new_stall is true, we will skip this psi_trigger if growth
      growth < t->threshold. I think we shouldn't skip this psi_trigger
      in this case because it has a pending event.

> 
> >
> > >
> > > >                                 continue;
> > > >
> > > >                         t->pending_event = true;
> > > > --
> > > > 2.21.0
> > > >
