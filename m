Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BAB5BBBB6
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 06:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiIREo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 00:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIREoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 00:44:25 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625A222BF5
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 21:44:24 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-324ec5a9e97so304613987b3.7
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 21:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=PpdIav7KnvVrlIDi5D6esH1D4zthNogIvZYH6WDsbTQ=;
        b=JY4iv6V5PTOJW1cHpuACBbprlnzxa5+/YKgKQPSoSnk46er0ZMsPZ75AjBrlywMOde
         0vJEaLVEoDbe0foNi6n8GRjuA0D+gySk8fpx+zttzSAOCMdYwqW68Nd4AyxD6QiM2Fsa
         RWyh4AAPgh/t7+Ct5dfwMqCrP+ZKSIPMIegUrDudOR8UahnhvqWB2BQs0/JEwWmEfZWf
         TOsptoxP9hcctCoPexayAcmEPzn89Bi/RgJuA60rwZbPQeSUja8vZU6pC+lc9a9tc5Im
         PbdXxLG6f6tbNdnMLkvpSpGsAKDtmBYeMUzF7V/I7YmWDHfrWy193ydOjJujCDQD5lLT
         mCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=PpdIav7KnvVrlIDi5D6esH1D4zthNogIvZYH6WDsbTQ=;
        b=IzlXjryO8OQS+12JozF7mz+kLP0AMl0mmzQkAL10i1s9jHW+FzMO+T/8f84R1PjZlU
         smkH531v4HHUlD3rugpjarorikb+wFbnnwQMtNX12Rv0I/2lDMq7v9bsc6i3cCOqDzTt
         Dvs8q9i8BR9jRgLCACcJNC1BEKfiwI27caljZujshdOLVDiZrr0SuDeBoDdl3/jdGyjT
         Ec6YuIUE/NfywW97I6SwIWrTEIsi9oAOYZy/3bhRF53ZD+sXY+RMdhE19RJmT1t5kU5N
         TiP4y7wvZNZ+SL6+GT0ICB813qAqPwO4QfnLnMB5Dx2kEIGSBwnjkdfhbWQ1/nQrAldD
         JHZQ==
X-Gm-Message-State: ACrzQf0MsWLhcrXZqDYy+X0HLk3tea33sNyohieJh+VI2+ry/GbB8FVK
        7HDV8RdyUGcozNl4ZgC8s0wsyKZANuhIqwgcNBsaDw==
X-Google-Smtp-Source: AMsMyM7ljxQwIbkeXUC+RgltQw5kmDoAVYdt0FZxTf5p3i8MXZlkT0hLh5+mob2KCojCHj+hGCGmjPx8S2wRf+vI/D0=
X-Received: by 2002:a0d:fb87:0:b0:335:db8b:416a with SMTP id
 l129-20020a0dfb87000000b00335db8b416amr9894428ywf.263.1663476263360; Sat, 17
 Sep 2022 21:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220914092959.GA20640@haolee.io> <CAJuCfpFVK3ceHy+ipSbLb0jAgE6tJAsu5=kbJEB9X4OWPnsVxA@mail.gmail.com>
 <20220917073124.GA3483@haolee.io>
In-Reply-To: <20220917073124.GA3483@haolee.io>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Sat, 17 Sep 2022 21:44:12 -0700
Message-ID: <CAJuCfpH6QVuKd-Y1qr1Rzh+hCG-HVgmWfXk9r0tsFhDijZ_ABg@mail.gmail.com>
Subject: Re: [PATCH] psi: fix possible missing or delayed pending event
To:     Hao Lee <haolee.swjtu@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2022 at 12:31 AM Hao Lee <haolee.swjtu@gmail.com> wrote:
>
> On Fri, Sep 16, 2022 at 11:08:34PM -0700, Suren Baghdasaryan wrote:
> > On Wed, Sep 14, 2022 at 2:30 AM Hao Lee <haolee.swjtu@gmail.com> wrote:
> > >
> > > When a pending event exists and growth is less than the threshold, the
> > > current logic is to skip this trigger without generating event. However,
> > > from e6df4ead85d9 ("psi: fix possible trigger missing in the window"),
> > > our purpose is to generate event as long as pending event exists and the
> > > rate meets the limit. This patch fixes the possible pending-event
> > > missing or delay.
> > >
> > > Fixes: e6df4ead85d9 ("psi: fix possible trigger missing in the window")
> > > Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
> > > ---
> > >  kernel/sched/psi.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > > index 9711827e3..0bae4ee2b 100644
> > > --- a/kernel/sched/psi.c
> > > +++ b/kernel/sched/psi.c
> > > @@ -539,7 +539,7 @@ static u64 update_triggers(struct psi_group *group, u64 now)
> > >
> > >                         /* Calculate growth since last update */
> > >                         growth = window_update(&t->win, now, total[t->state]);
> > > -                       if (growth < t->threshold)
> > > +                       if (growth < t->threshold && !t->pending_event)
> >
> > I'm not sure how this additional condition changes things. Current
> > logic is to set t->pending_event=true whenever growth exceeds the
> > t->threshold. This patch will change this logic into setting
> > t->pending_event=true also when t->pending_event=true.
>
> This is right.
>
> > But why would
> > you want to set t->pending_event=true if it's already true? What am I
> > missing?
>
> If I expand this if-else branch and the pending_event statement
> to a more detailed snippet, it will be like this:
>
> if (growth < t->threshold && !t->pending_event) // under threshold && no pending event. Skip.
>         continue;
> else if (growth >= t->threshold) // above threshold. Try to generate event.
>         t->pending_event = true;
> else // under threshold && have pending events. Try to generate event.
>         ; // pending_event is already true. do nothing
>
>
> The original code didn't handle the `else` condition properly.

The `else` condition in your code does nothing, and that's why the
original code does not implement a handler for that case.

> It will
> skip the trigger when its growth is under the threshold, even though it
> has a pending event. This patch handles this condition correctly.
>
> But I think assigning true to pending_event when it's already true doesn't
> have other side effects, so I eliminate the `else if` branch. Maybe we'd
> better make it explicit, like the above snippet? Thanks.

The new code you posted is functionally the same as the original one
while being more verbose and IMO less readable. Unless you can explain
the problem with the original code, I don't see any reason to change
it.

>
> >
> > >                                 continue;
> > >
> > >                         t->pending_event = true;
> > > --
> > > 2.21.0
> > >
