Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEE6635B53
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236270AbiKWLLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbiKWLLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:11:07 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B792CE15
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 03:09:14 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id p81so12778699yba.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 03:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0FnC9mUX81KcvlQlOCsjsZPxeL4/ZWwU9njH2eExtxo=;
        b=Lz2iPRhCGMfGHgF4zNG3xkXhUWHpg0ZHHWa7LnmqdMDomEFp8ET8ujxuV6j7sPCYTT
         5IF44lxP9DHbg70F8/bU3OFU3sjB39HZFWIcCWFoDdSbrX2U5wie2uqFSV8CwCSAFH20
         encTEMm91agGw25aq+Bw3pd1sh4Rnd9cCHznD8KND7VKP88DiQOqr8SZPBtjYDpiG+cu
         aqQEsKgKVl18WA2eGye00dRuafEoAbyVqJTsA93BRQjY/MGiYiMrz90cWknSfrbYGZy2
         B2Qpt7tRxHvbCSxxSjVw/RKsV7FWUHrAJH57kWVGuOtglCl/lbTsvmURXEsbpH15ZyPi
         IrNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0FnC9mUX81KcvlQlOCsjsZPxeL4/ZWwU9njH2eExtxo=;
        b=BWv2JVLEr2fcHMzIfcwnXbvKkMoikgLcvbY5KMzRMM6waKg9GL03n3ZMUzMdOziDfu
         as5CGZxH0PBJ3oOBCwcqYRGNXA0Tq2A7gwU5060JmmGXGLeTfK/9cVF6UrR426cyVR9L
         EmuIpwH2FDjJODcHU5/QbJjZDDOeGt7hfCT13hINbn1KfcVwdjwYczTDuqlZwtoeZfcR
         Jr5d0OkBYJD59LYLFnewU436wOgD15ea/0ZgG0oPfbCsBs46vQdprD+j2ryQ/LsMzTrM
         mdcsPzPgTUnB6zAop0astO2vljiYEJo81bwqYTiCCOnZAqUqmPZmoKI0rD8c23wDRF6T
         afdg==
X-Gm-Message-State: ANoB5plzhDaURppMkV+rOlmH3Iz4fdZbNz98voD+TZKtE249kntx7KGe
        PRjy0HjAqlnzItS+YOmnS4SxcRP83YmXhhcOC/FZDA==
X-Google-Smtp-Source: AA0mqf48TzJwt+PkEZGXWiqg7Xt5w88uhPrOaHpl9UTdpQlEhLXJOLI+2Ueufj2olquNM2fHuGjg/Y9w6D/GzHTRwpU=
X-Received: by 2002:a25:820d:0:b0:6c4:1751:f0d1 with SMTP id
 q13-20020a25820d000000b006c41751f0d1mr24971208ybk.422.1669201753160; Wed, 23
 Nov 2022 03:09:13 -0800 (PST)
MIME-Version: 1.0
References: <20221115141953.816851-1-peternewman@google.com>
 <20221115141953.816851-2-peternewman@google.com> <54e50a9b-268f-2020-f54c-d38312489e2f@intel.com>
In-Reply-To: <54e50a9b-268f-2020-f54c-d38312489e2f@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Wed, 23 Nov 2022 12:09:02 +0100
Message-ID: <CALPaoCh9e5PB+fx2k6qBfOjduA01Rr2ZxdJFg4oocJtJ0aSYjQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] x86/resctrl: IPI all CPUs for group updates
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     fenghua.yu@intel.com, bp@alien8.de, derkling@google.com,
        eranian@google.com, hpa@zytor.com, james.morse@arm.com,
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

On Mon, Nov 21, 2022 at 10:53 PM Reinette Chatre
<reinette.chatre@intel.com> wrote:
> On 11/15/2022 6:19 AM, Peter Newman wrote:
> > To rule out needing to update a CPU when deleting an rdtgroup, we must
>
> Please do not impersonate code in changelog and comments (do not
> use "we"). This is required for resctrl changes to be considered for
> inclusion because resctrl patches are routed via the "tip" repo
> and is thus required to follow the "tip tree handbook"
> (Documentation/process/maintainer-tip.rst). Please also
> stick to a clear "context-problem-solution" changelog as is the custom
> in this area.

Thanks, I forgot about the "tip tree handbook" and was trying to
remember where the pointers about wording from the reply to the other
patch came from. Unfortunately I didn't read your replies in FIFO
order.


>
> > search the entire tasklist for group members which could be running on
> > that CPU. This needs to be done while blocking updates to the tasklist
> > to avoid leaving newly-created child tasks assigned to the old
> > CLOSID/RMID.
>
> This is not clear to me. rdt_move_group_tasks() obtains a read lock,
> read_lock(&tasklist_lock), so concurrent modifications to the tasklist
> are indeed possible. Should this perhaps be write_lock() instead?
> It sounds like the scenario you are describing may be a concern. That is,
> if a task belonging to a group that is being removed happens to
> call fork()/clone() during the move then the child may end up being
> created with old closid.

Shouldn't read_lock(&tasklist_lock) cause write_lock(&tasklist_lock) to
block?

Maybe I paraphrased too much in the explanation.


> > The cost of reliably propagating a CLOSID or RMID update to a single
> > task is higher than originally thought. The present understanding is
> > that we must obtain the task_rq_lock() on each task to ensure that it
> > observes CLOSID/RMID updates in the case that it migrates away from its
> > current CPU before the update IPI reaches it.
>
> I find this confusing since it describes why a potential solution does
> not solve a problem, neither problem nor solution is well described at this
> point.
>
> What if you switch the order of the two patches? Patch #2 provides
> the potential solution mentioned here so that may be helpful to have as
> reference in this changelog.

Yes, I will try that. The single-task and multi-task cases should be
independent enough that I can handle them in either order.


> > For now, just notify all the CPUs after updating the closid/rmid fields
>
> For now? If you anticipate changes then there should be a plan for that,
> otherwise this is the fix without further speculation.

It seems like I have to either do something to acknowledge the tradeoff,
or make a case that the negatively affected usage isn't important.
Should I assert that deleting groups while a realtime, core-isolated
application is running isn't a legitimate use case?


>
> > in impacted tasks task_structs rather than paying the cost of obtaining
> > a more precise cpu mask.
>
> s/cpu/CPU/
> It may be helpful to add that an accurate CPU mask cannot be guaranteed and
> the more tasks moved the less accurate it could be (if I understand correctly).

Ok.


> > diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > index e5a48f05e787..049971efea2f 100644
> > --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > @@ -2385,12 +2385,10 @@ static int reset_all_ctrls(struct rdt_resource *r)
> >   * Move tasks from one to the other group. If @from is NULL, then all tasks
> >   * in the systems are moved unconditionally (used for teardown).
> >   *
> > - * If @mask is not NULL the cpus on which moved tasks are running are set
> > - * in that mask so the update smp function call is restricted to affected
> > - * cpus.
> > + * Following this operation, the caller is required to update the MSRs on all
> > + * CPUs.
> >   */
>
> On x86 only one MSR needs updating, the PQR_ASSOC MSR. The above could be
> summarized as:
> "Caller should update per CPU storage and PQR_ASSOC."

Sounds good.


> [...]
>
> The fix looks good to me. I do think its motivation and description
> needs to improve to make it palatable to folks not familiar with this area.
>
> Reinette

Once again, thanks for your review. I will work on clarifying the
comments. The explanation is usually most of the work with changes like
these, which is tough to do without some feedback from an actual reader.
I've been looking at this section of code too long to be able to judge
my own explanation anymore.

-Peter
