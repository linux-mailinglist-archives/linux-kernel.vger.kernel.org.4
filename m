Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A3864C684
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 11:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237988AbiLNKGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 05:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237741AbiLNKGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 05:06:12 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D251165B2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 02:06:11 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id j16so2078604qtv.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 02:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0z0Hgcp/nIxdg/ZNL0h40rTrp1dbZAjMH86jWtEFPPU=;
        b=HNOrqqIsm6hC11lQ7rOZCb4qFQMwbH7h7Mx4LKjLl+fYrTgE4GSKW7prqFCAOwbg6p
         ykojlzRaEWZGxH7KpEENztAKlXh1DL9rlRl03PVQXIEz/2/S97Gw6Gnxw//8K7vhztTY
         lSjmN4jG3WFbV/lLAJAh1+HZpKGCDRqUrNXX2seiPqaPICoUIo204FowOHM1lMC2WCAa
         WyOBGTh/dXd8W16AGlp+eLSMk7wPwXskHQcRSP34rHOOgjVqGV+tgsD3OKZY8ES8QxgZ
         Qnb8RknnC9lwLcqiB60cTMOm1biay+uIS2xQos/41kq8XWc+4x7I7dkv/ufkV1JU/n/V
         V9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0z0Hgcp/nIxdg/ZNL0h40rTrp1dbZAjMH86jWtEFPPU=;
        b=YM/ugEM8K7Zw3ruFRbmhOv0T6NNdJ1z5c6aEwlcNjxK7XO6hdgeUDnmzWfqOPeNd5X
         KA3Vx4bDDpdPZlmH4IiLX6E+Pk3y5jPr8ku5tqYK2WEfSlSw7pg3czujz1ZD1uwPf/xD
         PC6HMjDPM0+5RsraqNU382FZQPhxppbx6OrUt/7tXEfQ0rRi8QkFw70AWoFbmY1MBDG8
         lzB9CTFk236Q9JyfQyfdPB9RLS+GEw75MXjuczFrTycEZ2skcRCKiy7eX47+8YLVI+od
         oVSNOe23me1zJA95S6nmRIEaywxsAOtG3S7r4mnQl9hx/0K8g1ofWPDHx4crFj2j3oef
         xu6w==
X-Gm-Message-State: ANoB5pk5VDa77ATSW5M6ewQKMbO/OAyJknxFIb9+yHeBNMBL7ydioooi
        SLxdGCDx8v5EcfIsKaLe7O1o1bnCKECPY0UZualVuw==
X-Google-Smtp-Source: AA0mqf4brpqKqeytpX3n4nooRhK9fsz2zUaQhLolPlLNsnu2O6TQYGseYRtXhDrcI9JuPC9IDAGcKErVvUrtvSUtMqw=
X-Received: by 2002:ac8:6641:0:b0:3a8:2bf2:333 with SMTP id
 j1-20020ac86641000000b003a82bf20333mr74720qtp.144.1671012370468; Wed, 14 Dec
 2022 02:06:10 -0800 (PST)
MIME-Version: 1.0
References: <cdcfcd64-c76f-0d2d-6653-0229c956f2bc@intel.com>
 <20221212173638.1858573-1-peternewman@google.com> <3b020456-6312-89c7-1391-06241fa0f3de@intel.com>
In-Reply-To: <3b020456-6312-89c7-1391-06241fa0f3de@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Wed, 14 Dec 2022 11:05:59 +0100
Message-ID: <CALPaoCiqp3WhtPHystc3K-xr4vmaSpzHPquY+D6AZ30Hri7hhA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] x86/resctrl: Update task closid/rmid with task_call_func()
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     bp@alien8.de, derkling@google.com, eranian@google.com,
        fenghua.yu@intel.com, hpa@zytor.com, james.morse@arm.com,
        jannh@google.com, kpsingh@google.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, x86@kernel.org
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

Hi Reinette,

On Tue, Dec 13, 2022 at 7:34 PM Reinette Chatre
<reinette.chatre@intel.com> wrote:
> On 12/12/2022 9:36 AM, Peter Newman wrote:
> > On Sat, Dec 10, 2022 at 12:54 AM Reinette Chatre <reinette.chatre@intel.com> wrote:
> >> On 12/8/2022 2:30 PM, Peter Newman wrote:
> >>> Based on this, I'll just sketch out the first scenario below and drop
> >>> (2) from the changelog. This also implies that the group update cases
> >>
> >> ok, thank you for doing that analysis.
> >>
> >>> can use a single smp_mb() to provide all the necessary ordering, because
> >>> there's a full barrier on context switch for it to pair with, so I don't
> >>> need to broadcast IPI anymore.  I don't know whether task_call_func() is
> >>
> >> This is not clear to me because rdt_move_group_tasks() seems to have the
> >> same code as shown below as vulnerable to re-ordering. Only difference
> >> is that it uses the "//false" checks to set a bit in the cpumask for a
> >> later IPI instead of an immediate IPI.
> >
> > An smp_mb() between writing the new task_struct::{closid,rmid} and
> > calling task_curr() would prevent the reordering I described, but I
> > was worried about the cost of executing a full barrier for every
> > matching task.
>
> So for moving a single task the solution may just be to change
> the current barrier() to smp_mb()?

Yes, that's a simpler change, so I'll just do that instead.

>
> >
> > I tried something like this:
> >
> > for_each_process_thread(p, t) {
> >       if (!from || is_closid_match(t, from) ||
> >           is_rmid_match(t, from)) {
> >               WRITE_ONCE(t->closid, to->closid);
> >               WRITE_ONCE(t->rmid, to->mon.rmid);
> >               /* group moves are serialized by rdt */
> >               t->resctrl_dirty = true;
> >       }
> > }
> > if (IS_ENABLED(CONFIG_SMP) && mask) {
> >       /* Order t->{closid,rmid} stores before loads in task_curr() */
> >       smp_mb();
> >       for_each_process_thread(p, t) {
> >               if (t->resctrl_dirty) {
> >                       if (task_curr(t))
> >                               cpumask_set_cpu(task_cpu(t), mask);
> >                       t->resctrl_dirty = false;
> >               }
> >       }
> > }
> >
>
> struct task_struct would not welcome a new member dedicated to resctrl's
> rare use for convenience. Another option may be to use a flag within
> the variables themselves but that seems like significant complication
> (flag need to be dealt with during scheduling) for which the benefit
> is not clear to me. I would prefer that we start with the simplest
> solution first (I see that as IPI to all CPUs). The changelog needs clear
> description of the problem needing to be solved and the solution chosen, noting
> the tradeoffs with other possible solutions. You can submit that, as an RFC
> if the "IPI to all CPUs" remains a concern, after which we can bring that
> submission to the attention of the experts who would have needed information then
> to point us in the right direction.

To be complete, I did the benchmark again with the simple addition of
an smp_mb() on every iteration with a matching CLOSID/RMID and found
that it didn't result in a substantial performance impact. (1.57ms
-> 1.65ms).

This isn't as significant as the 2x slowdown I saw when using
task_call_func(), so maybe task_call_func() is just really expensive.
That's more reason to just upgrade the barrier in the single-task move
case.

While I agree with your points on the IPI broadcast, it seems like a
discussion I would prefer to just avoid given these measurements.

-Peter
