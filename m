Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7386BB7DE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 16:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjCOPcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 11:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjCOPcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 11:32:41 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C641C7D2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 08:32:39 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id ja10so10778238plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 08:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678894359;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6z53DlACdBYoLgRE/3dAWs5dNHWwt++Kl0ejvvpAYg8=;
        b=q9kDDxc7ZR/tTs1XZmZm4xHWK0ltbRIRDxBRfzEkXUKbHmDrt3oiWzvYRAN0z621Ly
         RO/QF9mZ18jSweAy5aOVtKhr0xKp6TV1HHes4bUv1hV8UuVMwq8900Mx0JULnchFb9Q8
         PHAnnRVTaLhRn1MzeKZpJjxbmaOVfXkOUFn7oro/fo7Ndkn6mQ9m5j9Wpf3ntz6VVWP1
         HHvW4M02DPc3/a3TvsF4/jOZeYqb9irJvlZv1c6AuxAWoIVC+GZSyxmkPvtgPk+5HD4z
         cp0eQO9vIYLofi5UGd5qBarFsRu24rrb2irT//64dHSRvHc9I3xbsfBjosXdgPP1rTWJ
         xSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678894359;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6z53DlACdBYoLgRE/3dAWs5dNHWwt++Kl0ejvvpAYg8=;
        b=nUnmPr+bGUViI8OkIijItsnlmCll5uFcEoNYu2cvLlnDRdrPZrTEisD03CytZIxwJr
         fDljmGNRL7by7liGdhpFR3qQP28SjcM5AXm4otcmB8CmSGrmF9BqzGnlghm6mrQ6aA8+
         TyhP6vk2VFDbXsLtLkUsjO0UW4dnPiyEp/hw916RuHEKYUIZD7V6VibiFuAu8lEiE5ar
         kDTcR6CwF8qxv5HPjj22z5Cs0WkAe7gVZHpq6FMWc9sQd463nf1jRh8YQvvb2CJj8c3e
         ad4EMTlrw+/iaR90rF7eVv0DjT3fzz910DmXCBLmZ01huMhIBcmypGTY9+IHaCjvW80b
         DtAQ==
X-Gm-Message-State: AO0yUKVBgwx9uCR8HOvKTGlpr8DN1jiQvjjODaad9QxEKl6ZQN24oEDT
        4pekvCfDG9WK+iVH75ttYfWTXmPqXlg6zNk7PTEPEQ==
X-Google-Smtp-Source: AK7set+qFi249tqArQ/gOrsUQXdoIDszcsODmi0WqPs2v9WGXcH413BdYJBeKhHGiIFLpnVaLCqO84aRZT7zQg7+RKo=
X-Received: by 2002:a17:903:1103:b0:19f:2554:2886 with SMTP id
 n3-20020a170903110300b0019f25542886mr29710plh.0.1678894359332; Wed, 15 Mar
 2023 08:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAKfTPtAf5RrzZRSHtfK+r3QvnFQ-oM3+rJ-z5SB8T4+nUv1aQw@mail.gmail.com>
 <20230309142825.GB273121@hirez.programming.kicks-ass.net> <ZAnvCGdlOrWbIC/o@hirez.programming.kicks-ass.net>
 <CAKfTPtADUas2QHZCQyu0ad-JTKRQ=PcsB=o7+PuJNVxHwAzkCQ@mail.gmail.com>
 <ZAs+zV0o9ShO7nLT@vingu-book> <02a08042-e7c4-464d-bc20-9ec4ccdab1ff@arm.com>
 <8c093661-7431-00d8-d703-b8f7a7c8e747@arm.com> <CAKfTPtBw9SJxVBcN1qff7jRzE81kXSjbc-rXD6goEBFiXEwbyg@mail.gmail.com>
 <20230314120726.GG1845660@hirez.programming.kicks-ass.net>
 <CAKfTPtBHocw4N-YMHeqfMj78Ro=aF8sJPanxVCN=tM70hr6r8g@mail.gmail.com>
 <20230314171607.GN2017917@hirez.programming.kicks-ass.net>
 <CAKfTPtBurhAxcykDWQHoSZ0aiokgK4jhamdh-F29643cL1jVsw@mail.gmail.com>
 <CAKfTPtCra1QV32w1MZQY2SHVDv58m2MT2QwpHu0huJJ3B1wcCA@mail.gmail.com>
 <5527ad0e-0f6d-fb4c-7505-a1c80192ed3b@arm.com> <CAKfTPtDfnersgtWQy7Qxq1x1Y6BZP-6K95gcQB1Mi0RaU3TpYg@mail.gmail.com>
 <b2ded6d7-6516-d193-cb23-1609aa03d324@arm.com>
In-Reply-To: <b2ded6d7-6516-d193-cb23-1609aa03d324@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 15 Mar 2023 16:32:27 +0100
Message-ID: <CAKfTPtBL2nXB02bByX0_CWv7YHyvJeLzwm1hVnaEPUDy8vH=BQ@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        rkagan@amazon.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2023 at 14:36, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 15/03/2023 11:21, Vincent Guittot wrote:
> > On Wed, 15 Mar 2023 at 11:15, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>
> >> On 15/03/2023 09:42, Vincent Guittot wrote:
> >>> On Wed, 15 Mar 2023 at 08:18, Vincent Guittot
> >>> <vincent.guittot@linaro.org> wrote:
> >>>>
> >>>> On Tue, 14 Mar 2023 at 18:16, Peter Zijlstra <peterz@infradead.org> wrote:
> >>>>>
> >>>>> On Tue, Mar 14, 2023 at 02:24:37PM +0100, Vincent Guittot wrote:
> >>>>>
>
> [...]
>
> >> Isn't there an issue with this approach on asymmetric CPU capacity systems?
> >>
> >> We do a sync_entity_load_avg() in select_task_rq_fair()
> >> (find_energy_efficient_cpu() for EAS and select_idle_sibling() for CAS)
> >> to sync cfs_rq and se.
> >
> > ah yes, I forgot this point.
> > That being said, is it a valid problem for EAS based system ? I mean
> > we are trying to fix a vruntime comparison overflow that can happen
> > with a very long sleeping task (around 200 days) while only a very low
> > weight entity is always running  during those 200 days.
>
> True. Definitively very unlikely. But it's not only EAS, any asymmetric
> CPU capacity wakeup wouldn't have this check in this case.
>
> This dependency between sync_entity_load_avg() and the overflow
> detection would be very hard to spot though (in case
> sync_entity_load_avg() would get introduced in more common wakeup paths
> later).

fair enough
