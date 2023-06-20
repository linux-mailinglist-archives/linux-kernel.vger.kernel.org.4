Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FC17375A6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 22:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjFTUIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 16:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjFTUI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:08:27 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193451731
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:08:25 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-3ff27588ba5so16705481cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687291705; x=1689883705;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pUCutehr/OfoQyOqd69wcea7Vp1DH1+F4zcA/UzVTE=;
        b=MuiZi2TvSc3VzMtC+jRWlFCZEi9gx+AOATPLTwGc2w8vCK6GD2ftw/QBb6f/9Pm+u8
         Z8WOlhwK1UFbPB1rGSJV2aGsRHSxjxeyOAT10DW6SGxX0GOV0agbpqAtgyB7kg+jvmCk
         jIanDedfw4/QJEKOCSKQDm8oPiDI14alEiExpWDONXs+wMevkVv555M7+AAKtcBenhRg
         0E7yFm4RbLUU7niNEQoQMNoNQXhGhOL5N0g5iU71P9CWVzJuHuesQrJCnFxNJNQeLSdI
         y6/ebks/np3lXYCtofbp7PwNEaMSG7y+XY7SrIURNmNip4p67nCRverm9bKqsr3TW8F8
         qNBQ==
X-Gm-Message-State: AC+VfDxBKWRx+tCjo3lpQaRhmqBGoIqPfWyJbMWOubGy9uT2HL4d2MjY
        Ht/XaLejwvWNFoB9gx+upNI=
X-Google-Smtp-Source: ACHHUZ7eRd0hX4qdo2LlkPVPfu910zo94VGD2XySyyZ+MH0R8ObKdqfSRMDOwgIJO5XZYN2ym+PV0Q==
X-Received: by 2002:a05:6214:29cc:b0:626:37fe:218c with SMTP id gh12-20020a05621429cc00b0062637fe218cmr15007981qvb.24.1687291704841;
        Tue, 20 Jun 2023 13:08:24 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:2cf0])
        by smtp.gmail.com with ESMTPSA id i7-20020a056214030700b0062ff362d87fsm1573836qvu.105.2023.06.20.13.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:08:24 -0700 (PDT)
Date:   Tue, 20 Jun 2023 15:08:22 -0500
From:   David Vernet <void@manifault.com>
To:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, joshdon@google.com,
        roman.gushchin@linux.dev, tj@kernel.org, kernel-team@meta.com
Subject: Re: [RFC PATCH 3/3] sched: Implement shared wakequeue in CFS
Message-ID: <20230620200822.GC3027191@maniforge>
References: <20230613052004.2836135-1-void@manifault.com>
 <20230613052004.2836135-4-void@manifault.com>
 <ZI/x+RkSqpct4bM3@BLR-5CG11610CF.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZI/x+RkSqpct4bM3@BLR-5CG11610CF.amd.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 11:43:13AM +0530, Gautham R. Shenoy wrote:
> Hello David,
> 
> 
> On Tue, Jun 13, 2023 at 12:20:04AM -0500, David Vernet wrote:
> [..snip..]
> 
> > +static void swqueue_enqueue(struct rq *rq, struct task_struct *p, int enq_flags)
> > +{
> > +	unsigned long flags;
> > +	struct swqueue *swqueue;
> > +	bool task_migrated = enq_flags & ENQUEUE_MIGRATED;
> > +	bool task_wakeup = enq_flags & ENQUEUE_WAKEUP;
> > +
> > +	/*
> > +	 * Only enqueue the task in the shared wakequeue if:
> > +	 *
> > +	 * - SWQUEUE is enabled
> > +	 * - The task is on the wakeup path
> > +	 * - The task wasn't purposefully migrated to the current rq by
> > +	 *   select_task_rq()
> > +	 * - The task isn't pinned to a specific CPU
> > +	 */
> > +	if (!task_wakeup || task_migrated || p->nr_cpus_allowed == 1)
> > +		return;
> 
> In select_task_rq_fair(), having determined if the target of task
> wakeup should be the task's previous CPU vs the waker's current CPU,
> we spend quite a bit of time already to determine if there is an idle
> core/CPU in the target's LLC. @rq would correspond to CPU chosen as a
> result of that scan or if no idle CPU exists, @rq corresponds to the
> target CPU determined by wake_affine_idle()/wake_affine_weight().
> 
> So if the CPU of @rq is idle here, can we not simply return here?

Hi Gautum,

Sorry, I'm not sure I'm quite following the issue you're pointing out.
We don't use swqueue if the task was migrated following
select_task_rq_fair(). That's the idea with us returning if the task was
migrated (the second conditional in that if). If I messed up that logic
somehow, it should be fixed.

> Or if the idea is to avoid the scan for an idle core/CPU in
> select_task_rq_fair(), then 

No, swqueue_enqueue() is called from enqueue_task_fair(), not
select_task_rq_fair(). If select_task_rq_fair() (which is of course
called beforehand for a waking task) found an idle core/CPU, we don't
bother using swqueue, as mentioned above.

Thanks,
David
