Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC926504CC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 22:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiLRVav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 16:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLRVas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 16:30:48 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B0625E2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 13:30:46 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id j4so11200863lfk.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 13:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5tn4rQjGQE4F2w5zAfUAbUUjhc9QUg0oaUSmUi2xx9M=;
        b=tXBlq3ZbJVtEkMb+4WNJTrayFU2u+Mp81ndpU7nJkBwkXh+yLzGGznERsG9MvuWU+H
         lvXoOXU5zt6S4c0Be95uK9at1y+DKszWLMN4EbG09R2SfixFRC2M7D3tOJOePSqtBryv
         MjMhc4Qq1yRheRk28x6YqUDf4BuaCD7+qZCP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5tn4rQjGQE4F2w5zAfUAbUUjhc9QUg0oaUSmUi2xx9M=;
        b=CysNoNtF4VCKYS6LDbJgtCoyxlTSNA82XqADk3/Sa5uHmUm0x2CcfOfLP0Mo6ar4E6
         I5RDE8yVSQzv7DybWrDjf42rerRi8XTfDMos7Fl8hMSl54EOxZ0h8BarcR9ME+7BDqJN
         +OWAfS9Mrtxn2xJvofMWKO7Y3xbPD+UjjbQdTGF+hzSZoQISRY2sPAG/kAUgtEBkQOtD
         9vX5ZYowGXiNctCCYE0b3fOyrFrGGc7mopQtf8+HCJ1q8yVlq+iuHoCY7MicQ4883KzI
         9PCnQv3zr0EgcZhisnsIuBU520HrwilIOpWBjpB89MtwpOtpQ0HX1S8fo0fqHlkI5AuE
         O/mw==
X-Gm-Message-State: ANoB5pkZt4mgEKZgd1x2G72JorHbGFPgqeZRgqpDg/zHVTrfcZRvVTyE
        kVpcxRFMavLFV70TIdbw/8Si5P/Fnt0JA0DnsLTCB4WWYdcxfbaHeP8=
X-Google-Smtp-Source: AA0mqf4GUwjr2MjyB2dINXrnDS4QDmgfXIfOhAmL7j00lduo95kzujD2CNUQuFo+ydQvOahXJtG4fvvGzc+cgGwo1g0=
X-Received: by 2002:ac2:4347:0:b0:4a4:782a:42ac with SMTP id
 o7-20020ac24347000000b004a4782a42acmr31546237lfl.468.1671399045022; Sun, 18
 Dec 2022 13:30:45 -0800 (PST)
MIME-Version: 1.0
References: <20221218191310.130904-1-joel@joelfernandes.org> <589da7c9-5fb7-5f6f-db88-ca464987997e@efficios.com>
In-Reply-To: <589da7c9-5fb7-5f6f-db88-ca464987997e@efficios.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 18 Dec 2022 16:30:33 -0500
Message-ID: <CAEXW_YQHpz3dNqW1ocqjr-e9qn09Rkg4kQ19byZORGbO18Xckg@mail.gmail.com>
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Sun, Dec 18, 2022 at 3:56 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2022-12-18 14:13, Joel Fernandes (Google) wrote:
> > Hello, I believe the pre-flip memory barrier is not required. The only reason I
> > can say to remove it, other than the possibility that it is unnecessary, is to
> > not have extra code that does not help. However, since we are issuing a fully
> > memory-barrier after the flip, I cannot say that it hurts to do it anyway.
> >
> > For this reason, please consider these patches as "informational", than a
> > "please merge". :-) Though, feel free to consider merging if you agree!
> >
> > All SRCU scenarios pass with these, with 6 hours of testing.
>
> Hi Joel,
>
> Please have a look at the comments in my side-rcu implementation [1, 2].
> It is similar to what SRCU does (per-cpu counter based grace period
> tracking), but implemented for userspace. The comments explain why this
> works without the memory barrier you identify as useless in SRCU.
>
> Following my implementation of side-rcu, I reviewed the SRCU comments
> and identified that the barrier "/* E */" appears to be useless. I even
> discussed this privately with Paul E. McKenney.
>
> My implementation and comments go further though, and skip the period
> "flip" entirely if the first pass observes that all readers (in both
> periods) are quiescent.

Actually in SRCU, the first pass scans only 1 index, then does the
flip, and the second pass scans the second index. Without doing a
flip, an index cannot be scanned for forward progress reasons because
it is still "active". So I am curious how you can skip flip and still
scan both indexes? I will dig more into your implementation to learn more.

> The most relevant comment in side-rcu is:
>
>   * The grace period completes when it observes that there are no active
>   * readers within each of the periods.
>   *
>   * The active_readers state is initially true for each period, until the
>   * grace period observes that no readers are present for each given
>   * period, at which point the active_readers state becomes false.
>
> So I agree with the clarifications you propose here, but I think we can
> improve the grace period implementation further by clarifying the SRCU
> grace period model.

Thanks a lot, I am curious how you do the "detection of no new
readers" part without globally doing some kind of synchronization. I
will dig more into your implementation to learn more.

Thanks,

 - Joel



>
> Thanks,
>
> Mathieu
>
>
> [1] https://github.com/efficios/libside/blob/master/src/rcu.h
> [2] https://github.com/efficios/libside/blob/master/src/rcu.c
>
> >
> > thanks,
> >
> >   - Joel
> >
> > Joel Fernandes (Google) (2):
> > srcu: Remove comment about prior read lock counts
> > srcu: Remove memory barrier "E" as it is not required
> >
> > kernel/rcu/srcutree.c | 10 ----------
> > 1 file changed, 10 deletions(-)
> >
> > --
> > 2.39.0.314.g84b9a713c41-goog
> >
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
>
