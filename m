Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18ADB708403
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjEROic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjEROia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:38:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C67DDB
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684420655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oVvT1YIgIkdercQ1GF7uisgHyWsRtVDV8gTqHQuqJjY=;
        b=EklGa7vU034/vTu0BhNShwpc8Xv+THpjNo0XjwVEO70sTUmnyFEtGhTbIPqSH1bbINAuPY
        IZ4nI3HgQUX1eQHasmcGJ0XfC7RjpV7hdNSLSA/HWnfLG46h2UQ8rOIkhEx8YLg2uabD0g
        4RbNbEsy6IhXXX611NRTfRZzauSYrVE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-101-kwZKZJO1NbiQg6FNzp5lEA-1; Thu, 18 May 2023 10:37:25 -0400
X-MC-Unique: kwZKZJO1NbiQg6FNzp5lEA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D3A5802A95;
        Thu, 18 May 2023 14:37:24 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.39.192.207])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E1FF40C6EC4;
        Thu, 18 May 2023 14:37:21 +0000 (UTC)
Date:   Thu, 18 May 2023 10:37:18 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH RESEND] sched/nohz: Add HRTICK_BW for using cfs bandwidth
 with nohz_full
Message-ID: <20230518143718.GC110197@lorien.usersys.redhat.com>
References: <20230518132038.3534728-1-pauld@redhat.com>
 <20230518134746.GB2860939@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518134746.GB2860939@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 03:47:46PM +0200 Peter Zijlstra wrote:
> On Thu, May 18, 2023 at 09:20:38AM -0400, Phil Auld wrote:
> > CFS bandwidth limits and NOHZ full don't play well together.  Tasks
> > can easily run well past their quotas before a remote tick does
> > accounting.  This leads to long, multi-period stalls before such
> > tasks can run again.  Use the hrtick mechanism to set a sched
> > tick to fire at remaining_runtime in the future if we are on
> > a nohz full cpu, if the task has quota and if we are likely to
> > disable the tick (nr_running == 1).  This allows for bandwidth
> > accounting before tasks go too far over quota.
> > 
> > A number of container workloads use a dynamic number of real
> > nohz tasks but also have other work that is limited which ends
> > up running on the "spare" nohz cpus.  This is an artifact of
> > having to specify nohz_full cpus at boot. Adding this hrtick
> > resolves the issue of long stalls on these tasks.
> > 
> > Add the sched_feat HRTICK_BW off by default to allow users to
> > enable this only when needed.
> 
> OMG; so because NOHZ_FULL configuration sucks, we add hacks on?
>

I suppose one could make that argument. The HRTICK mechanism is already
in place and used similarly for DL (and that also benefits nohz workloads).

I don't see NOHZ_FULL configuration getting better anytime soon, although
I think efforts are being made in that direction. 

This seemed to be a sane way to handle what are effectively conflicting
requirements.  Stalling a task to the point the host gets rebooted is
pretty painful.  Maybe if we could fail the tick_stop test in this
case that would work but that would keep all the ticks whereas this
tries to respect the request for nohz as much as possible. 

Thanks for taking a look :)

Cheers,
Phil
-- 

