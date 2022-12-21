Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8328653601
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 19:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234705AbiLUSTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 13:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiLUSS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 13:18:59 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B127BC4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 10:18:58 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id g13so8031033lfv.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 10:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1762m4MjNG9Yx9WLbbrufGklAfqCEfWd39rbtpBGmv4=;
        b=rMobi02QK5YPRDhSK+c+sHPLO3V96W8UQ1koW2/7B/0ozqibl8gAssMTYqgErtzz7S
         794X5RoM+dkRcYU3w50UI3tWAN4+A9CJhPc/fdZoDTWgluyXY/4R/Kequ4xqk41uAl4c
         n1WDC5nqwcb8pii+fh6vjpK8rGZ1xeoaI4CEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1762m4MjNG9Yx9WLbbrufGklAfqCEfWd39rbtpBGmv4=;
        b=vu6T2zUHhdcnL4GYv7totjLVdtCvpUy52UeRbPF7geN2yC8G0uJIJkj1V/qNGlDBKP
         ko4HjWmwYInnL4LwICNiSCyLcdX8vyGRouX40IbNXsL2CAVVs7s5Qy0Hj/MBBIuLwUNx
         JCgsK0G9dDQNeJwm2KaxNXsHYbqsdk9cuirqIVrqPPA3TbWPWyPSohSAWEojkUI41wX7
         KlE8Jb2sIQ8I1oHIyrlnXtSL+V798I71hvWr+1oCjAqVk5LLjpZDHEoINEGYek/wX67b
         YvaOpwllcHxgiF1eLRnjsOE31yt+4iZHr4De7cBJAW1dGeYUj7QEspQmvzzRntJEXLlT
         JE8w==
X-Gm-Message-State: AFqh2kqoH+tYwCrXPsIUBPAMjuBgHLCKmFsLxWsBUmDCGzLDvufJ5UfF
        JX98z9PqIfc100KFbEMmvtTODbnsH/lusYpphJnZLDCtKC8tGJjW
X-Google-Smtp-Source: AMrXdXuINTDcRYR4N1IAAUnsWaKq2etXScrIz+bu7G+XdJJ4BRVQ/jCI1hX4Q3SjBgsAH6k4W5raAS7idbn+VYiOvjU=
X-Received: by 2002:a05:6512:15a3:b0:4bc:bdf5:f163 with SMTP id
 bp35-20020a05651215a300b004bcbdf5f163mr153179lfb.583.1671646736579; Wed, 21
 Dec 2022 10:18:56 -0800 (PST)
MIME-Version: 1.0
References: <20221220140714.GB22763@lothringen> <CA83E649-8C79-4D39-9BFE-BBEF95968B98@joelfernandes.org>
 <20221220224459.GA25175@lothringen> <CAEXW_YSAv+MzZoW9RK9H3E6DAyZH+wB=4bMy5nXTOExSwgSwAg@mail.gmail.com>
 <20221221004957.GA29021@lothringen> <20221221005858.GA29316@lothringen>
 <f4199d1f-306c-681f-8bb9-26d66ecf5121@efficios.com> <20221221121118.GA35081@lothringen>
 <edd76fa9-c7aa-9433-9ef2-42daec0ab268@efficios.com>
In-Reply-To: <edd76fa9-c7aa-9433-9ef2-42daec0ab268@efficios.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 21 Dec 2022 18:18:44 +0000
Message-ID: <CAEXW_YRk9ccJuuC95bv0rg2xBT=P8mYR2tBdot2KUFFfChZ4ow@mail.gmail.com>
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org,
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

On Wed, Dec 21, 2022 at 5:20 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2022-12-21 07:11, Frederic Weisbecker wrote:
> > On Tue, Dec 20, 2022 at 10:43:25PM -0500, Mathieu Desnoyers wrote:
> >> On 2022-12-20 19:58, Frederic Weisbecker wrote:
> >>> On Wed, Dec 21, 2022 at 01:49:57AM +0100, Frederic Weisbecker wrote:
> >>>> On Tue, Dec 20, 2022 at 07:15:00PM -0500, Joel Fernandes wrote:
> >>>>> On Tue, Dec 20, 2022 at 5:45 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> >>>>> Agreed about (1).
> >>>>>
> >>>>>> _ In (2), E pairs with the address-dependency between idx and lock_count.
> >>>>>
> >>>>> But that is not the only reason. If that was the only reason for (2),
> >>>>> then there is an smp_mb() just before the next-scan post-flip before
> >>>>> the lock counts are read.
> >>>>
> >>>> The post-flip barrier makes sure the new idx is visible on the next READER's
> >>>> turn, but it doesn't protect against the fact that "READ idx then WRITE lock[idx]"
> >>>> may appear unordered from the update side POV if there is no barrier between the
> >>>> scan and the flip.
> >>>>
> >>>> If you remove the smp_mb() from the litmus test I sent, things explode.
> >>>
> >>> Or rather, look at it the other way, if there is no barrier between the lock
> >>> scan and the index flip (E), then the index flip can appear to be written before the
> >>> lock is read. Which means you may start activating the index before you finish
> >>> reading it (at least it appears that way from the readers pont of view).
> >>
> >> Considering that you can have pre-existing readers from arbitrary index
> >> appearing anywhere in the grace period (because a reader can fetch the
> >> index and be preempted for an arbitrary amount of time before incrementing
> >> the lock count), the grace period algorithm needs to deal with the fact that
> >> a newcoming reader can appear in a given index either before or after the
> >> flip.
> >
> > True but the number of preempted tasks is bound and there is a forward progress guarantee.
> >
> >> I don't see how flipping the index before or after loading the unlock/lock
> >> values would break anything (except for unlikely counter overflow situations
> >> as previously discussed).
> >
> > Forward progress guarantee.
>
> Considering a coherent cache, the store-buffer will ensure that the
> index flip eventually reaches all readers. This bounds the time during
> which readers can flood the current index, and therefore guarantees
> forward progress. AFAIK the Linux kernel does not support architectures
> with incoherent caches.
>
> So I still don't see how having the barrier before or after the index
> flip is useful for forward progress.

Even though eventually the writes on either side will make it, I think
you have little lost opportunity without the "D" memory barrier
without satisfying the store-buffer pattern. i.e. even if the idx
update was seen by the read-side, its unlock count contributions to
the now-inactive idx may not be seen.

I think that makes it slightly better for making the grace period end
sooner. I think that's what you "scan both" idea also tries to
achieve, so for that reason you should like "D" as well.

But yes it depends on how forward-progress is defined. If defined as
starvation - no the post/pref flip MBs are not helpful for that
(eventually the writes will make it). If defined as not losing an
opportunity to end the GP sooner, yes the flip-related memory barriers
does help that.

As for whether or not we need "E", that is up for debate. I am
intrigued by Frederick's litmus tests showing that it helps, because
my litmus tests don't show it.

Thanks.
