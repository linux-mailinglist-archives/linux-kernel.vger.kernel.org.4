Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4401972A765
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 03:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjFJBUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 21:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFJBUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 21:20:33 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7640D30EC
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 18:20:31 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-53f7bef98b7so1260875a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 18:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686360031; x=1688952031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D/bmegFESSAApCqDdnEAielRRibxjNBPRiCDE3DA8lw=;
        b=jHvDFR6kYXh80JC9eULwl/zj2STmYAFAzkKnqYanBcQbBWj3dJR4+WCBJwkT6urS6W
         ZUYLCx3ciSA4O9SBVHHS3g6y9xEvFIGPz4vcn7JTJ/Mz58nNYzNWPriO5i9tUAfbG1Yz
         67e8naAZpbw9Z72It+NJPyxmumb2GF5AyF3T+VqxAQH7LHxBv3Pl4kvco61vT7UYOYdc
         hgjD63VDsdDkfcWhT+cA+iO1COLHX64ALZvkY7u+WuzOZUAbgguPP8o5c722RpqVyW7h
         wP5pXhcznBo5EwjuhttHpyPtedKhNcO0d9VxG4Hu9ld9QIx06kqLzFQYXzIy5TpSmrkG
         v18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686360031; x=1688952031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/bmegFESSAApCqDdnEAielRRibxjNBPRiCDE3DA8lw=;
        b=dQ67NxE7pi362f0WxkYBlDI1Y3tHvTombK26+QRrkRxS5d7aA8NXd/eFb5rPBh+SES
         FblFaL1pVXpPcr1+3M+i2pnj0c2qEVKCpeAf6Oy8AxDIQeuvFmKY7I0nzzHGIUXwiBOC
         FRukDe9+O+ZZzYiBMY8DT6PVzBPJqazNT5f7bd3QiX0qq02MaTh8l46fZvtrLi85WHDH
         qveJr8DF09obWMR2ueWmOv8YGKusjSukGF2z7hraI5S1ZPqdxfRlwEMHkz4pqG3NmqZF
         xt+8GYpifob1e1DDtDo0jwtF1gNqJ0xMPI0vF5rx8hUcsdMpayt3p9dPmouDAvoRSnnb
         1QlA==
X-Gm-Message-State: AC+VfDwYdj80JpuMB79BsaAseIz0sHRifGHbHyAsMa+BDSK981nyv45y
        RnsZFv1V/zRJ++zw573Qbbm2oQ==
X-Google-Smtp-Source: ACHHUZ4KBSke2iBZa+MPXMvoq9+3zaH1aAi/q3pr2imUy5kacQKczoOET10wqb7HLcOz675SNucZ7Q==
X-Received: by 2002:a05:6a20:7350:b0:10d:5430:c8d6 with SMTP id v16-20020a056a20735000b0010d5430c8d6mr3682430pzc.0.1686360030640;
        Fri, 09 Jun 2023 18:20:30 -0700 (PDT)
Received: from leoy-huanghe ([156.59.39.102])
        by smtp.gmail.com with ESMTPSA id u21-20020a656715000000b00476d1385265sm3198809pgf.25.2023.06.09.18.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 18:20:30 -0700 (PDT)
Date:   Sat, 10 Jun 2023 09:20:20 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, denik@chromium.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] perf cs-etm: Use previous thread for branch sample
 source IP
Message-ID: <20230610012020.GA174906@leoy-huanghe>
References: <20230524131958.2139331-1-james.clark@arm.com>
 <20230524131958.2139331-3-james.clark@arm.com>
 <20230527090635.GB886420@leoy-yangtze.lan>
 <630ab636-107d-4b12-5454-2ee91ad43543@arm.com>
 <1e7aa657-6d1e-9e7c-95cb-b32d307abe93@arm.com>
 <20230608102555.GB123723@leoy-huanghe>
 <2e075792-7af8-209b-082b-48d687387463@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e075792-7af8-209b-082b-48d687387463@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 12:00:27PM +0100, James Clark wrote:
> On 08/06/2023 11:25, Leo Yan wrote:
> > On Thu, Jun 08, 2023 at 10:34:42AM +0100, James Clark wrote:

[...]

> >>>>> @@ -616,6 +618,8 @@ static void cs_etm__packet_swap(struct cs_etm_auxtrace *etm,
> >>>>>  		tmp = tidq->packet;
> >>>>>  		tidq->packet = tidq->prev_packet;
> >>>>>  		tidq->prev_packet = tmp;
> >>>>> +		thread__put(tidq->prev_thread);
> >>>>> +		tidq->prev_thread = thread__get(tidq->thread);
> >>>>
> >>>> Maybe cs_etm__packet_swap() is not the best place to update
> >>>> "tidq->prev_thread", since swapping packet doesn't mean it's necessarily
> >>>> thread switching; can we move this change into the cs_etm__set_thread()?
> >>>>
> >>>
> >>> Yeah that might make more sense. I can move it there if we decide to
> >>> keep this change.
> >>>
> >>
> >> Unfortunately I don't think I can make this change. It seems like
> >> putting the previous thread swap in  cs_etm__set_thread() has different
> >> semantics to keeping all the swaps together in cs_etm__packet_swap().
> > 
> > Thanks for trying this.
> > 
> >> This is because if you swap the thread in cs_etm__packet_swap() the
> >> previous packet and next packet can have the _same_ thread if there
> >> happened to be no change. However if you only swap previous thread in
> >> cs_etm__set_thread(), that means that the previous thread is always
> >> different to the next one. This has a huge difference on the decoding
> >> because two adjacent packets on the same thread will say they branched
> >> from the previous thread that ran, not the previous thread on the
> >> previous packet.
> > 
> > Seems to me, this is a synchronization issue between the field
> > 'tidq->prev_thread' and 'tidq->prev_packet'.
> > 
> > It's still hard for me to understand "two adjacent packets on the same
> > thread will say they branched from the previous thread that ran", IIUC,
> > even we move thread swapping into cs_etm__set_thread(), if the two
> > adjacent packets are in the same thread context, we can skip to update
> > fields 'tidq->prev_thread' and 'tidq->prev_packet'.
> > 
> > So I am curious if below cs_etm__set_thread() works or not?
> > 
> > static void cs_etm__set_thread(struct cs_etm_auxtrace *etm,
> > 			       struct cs_etm_traceid_queue *tidq, pid_t tid)
> > {
> > 	struct machine *machine = &etm->session->machines.host;
> > 
> > 	/* No context switching, bail out */
> > 	if ((tidq->thread->tid != tid)
> > 		return;
> > 
> > 	/* If tid is -1, we simply use idle thread context */
> > 	if (tid == -1)
> > 		goto find_idle_thread;
> > 
> > 	/*
> > 	 * The new incoming tid is different from current thread,
> > 	 * so it's to switch to the next thread context.
> > 	 */
> > 
> > 	/* Swap thread contexts */
> > 	thread__put(tidq->prev_thread);
> > 	tidq->prev_thread = thread__get(tidq->thread);
> > 
> > 	/* Find thread context for new tid */
> > 	thread__zput(tidq->thread);
> > 	tidq->thread = machine__find_thread(machine, -1, tid);
> > 
> > find_idle_thread:
> > 	/* Couldn't find a known thread */
> > 	if (!tidq->thread)
> > 		tidq->thread = machine__idle_thread(machine);
> > }
> > 
> 
> I tried this change but I still don't think it's giving the right
> results. Tracking previous thread in cs_etm__set_thread() changes the
> semantics of being "the thread for the previous packet" to being "the
> previous different thread of an unknown old packet". If you imagine the
> packets and thread changes are like this (where <d> is a discontinuity
> packet):
> 
>     <--thread 1--> <--thread 2-------------------> <------thread 3-->
> <d> <--packet 1--> <d> <--packet 2--> <packet 3--> <d> <--packet 4-->
> 
> Branches are generated using the last IP of the previous packet, and the
> first IP of the next packet, ignoring everything in between as they are
> just sequential instructions.
> 
> So assuming there are discontinuity packets between the thread switches
> we should get:
> 
>   thread 1 branches from packet 1 to 0x0
>   thread 2 branches from 0x0 to packet 2
>   thread 2 branches from packet 2 to packet 3
>   thread 2 branches from packet 3 to 0x0
>   thread 3 branches from 0x0 to packet 4
> 
> By tracking the previous thread for each packet, packet 2 and 3 stay in
> thread 2.
> 
> If we track the previous thread instead, then both packet 2 and 3 would
> continue to look like they branch from thread 1 like this:
> 
>   thread ? branches from packet 1 to 0x0
>   thread 1 branches from 0x0 to packet 2
>   thread 1 branches from packet 2 to packet 3
>   thread 1 branches from packet 3 to 0x0
>   thread 2 branches from 0x0 to packet 4

Thanks a lot for writing very details, James!

Now it's much clear for me to understand the issue.

> Everything gets shifted back by 1 thread. I don't see the issue of
> keeping all the swap stuff together in one place. Maybe there is an
> issue with the naming of prev_thread? It's not really the previous
> thread, it's the previous _packets_ thread. It might be the same thread
> as the current one if there was no switch:

Agreed.  It makes sense for me to rename the thread variable as
"prev_packet_thread", this would be better for reflecting the purpose.

Here you are trying to change how to track thread contexts: rather than
tracking thread context as a global variable and sharing it cross packets,
we track the thread context as an associated info for every packet to
avoid any mismatching between packets and threads (e.g. caused by
discontinuity packets).

My feeling is this part would be a bit difficult for maintenance, maybe
you could add a comment when spin a new patch?  Thanks!

Leo

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index ca01109c3fc4..f3c73c86010a 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -86,8 +86,8 @@ struct cs_etm_traceid_queue {
>         size_t last_branch_pos;
>         union perf_event *event_buf;
>         struct thread *thread;
> -       struct thread *prev_thread;
> -       ocsd_ex_level prev_el;
> +       struct thread *prev_packet_thread;
> +       ocsd_ex_level prev_packet_el;
>         ocsd_ex_level el;
>         struct branch_stack *last_branch;
> 
> > Thanks,
> > Leo
