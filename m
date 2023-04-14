Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3666E21EB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 13:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjDNLTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 07:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDNLTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:19:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF9DCF
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681471099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Q6BebmPe2/qdtHTdDBDGMsvLr38IhHc0NaBD2QrMNc=;
        b=A3QDPi+kQEUNe+mmfYblsCaly0LkucTjXOmKTW6eTk7noKADb8RQgIBaSS1wHtZFFQXne1
        AsIcA/eMC4n3def2xoG02rPXYg/GH7qwbNo5xb8mJGb6Is9zAK9MXZRaDkr1YCDS+Fsmpl
        FuJCAq3wd7Ss0OLgerMA3/8hIqbFkro=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-386-KJDgE1gYMPKxtSJZ8rxr8g-1; Fri, 14 Apr 2023 07:18:14 -0400
X-MC-Unique: KJDgE1gYMPKxtSJZ8rxr8g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC7783813F4B;
        Fri, 14 Apr 2023 11:18:12 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.8.167])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4500C1121320;
        Fri, 14 Apr 2023 11:18:11 +0000 (UTC)
Date:   Fri, 14 Apr 2023 07:18:08 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, efault@gmx.de
Subject: Re: [PATCH 14/17] sched/eevdf: Better handle mixed slice length
Message-ID: <20230414111808.GA144166@lorien.usersys.redhat.com>
References: <20230328092622.062917921@infradead.org>
 <20230328110354.562078801@infradead.org>
 <CAKfTPtAkFBw5zt0+WK7dWBUE9OrbOOExG8ueUE6ogdCEQZhpXQ@mail.gmail.com>
 <20230404092936.GD284733@hirez.programming.kicks-ass.net>
 <20230404135050.GA471948@google.com>
 <20230405083543.GZ4253@hirez.programming.kicks-ass.net>
 <CAEXW_YQmG83_Yb9JgXapt9RgAs4m=fHnrOKRqfG9N_VMYcA88A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YQmG83_Yb9JgXapt9RgAs4m=fHnrOKRqfG9N_VMYcA88A@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 04:05:55PM -0400 Joel Fernandes wrote:
> On Wed, Apr 5, 2023 at 4:36 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Apr 04, 2023 at 01:50:50PM +0000, Joel Fernandes wrote:
> > > On Tue, Apr 04, 2023 at 11:29:36AM +0200, Peter Zijlstra wrote:
> >
> > > > Heh, this is actually the correct behaviour. If you have a u=1 and a
> > > > u=.5 task, you should distribute time on a 2:1 basis, eg. 67% vs 33%.
> > >
> > > Splitting like that sounds like starvation of the sleeper to me. If something
> > > sleeps a lot, it will get even less CPU time on an average than it would if
> > > there was no contention from the u=1 task.
> >
> > No, sleeping, per definition, means you're not contending for CPU. What
> > CFS does, giving them a little boost, is strictly yuck and messes with
> > latency -- because suddenly you have a task that said it wasn't
> > competing appear as if it were, but you didn't run it (how could you, it
> > wasn't there to run) -- but it still needs to catch up.
> >
> > The reason it does that, is mostly because at the time we didn't want to
> > do the whole lag thing -- it's somewhat heavy on the u64 mults and 32bit
> > computing was still a thing :/ So hacks happened.
> 
> Also you have the whole "boost tasks" that sleep a lot with CFS right?
>  Like a task handling user input sleeps a lot, but when it wakes up,
> it gets higher dynamic priority as its vruntime did not advance. I
> guess EEVDF also gets you the same thing but still messes with the CPU
> usage?
> 
> > That said; I'm starting to regret not pushing the EEVDF thing harder
> > back in 2010 when I first wrote it :/
> >
> > > And also CGroups will be even more weird than it already is in such a world,
> > > 2 different containers will not get CPU time distributed properly- say if
> > > tasks in one container sleep a lot and tasks in another container are CPU
> > > bound.
> >
> > Cgroups are an abomination anyway :-) /me runs like hell. But no, I
> > don't actually expect too much trouble there.
> 
> So, with 2 equally weighted containers, if one has a task that sleeps
> 50% of the time, and another has a 100% task, then the sleeper will
> only run 33% of the time? I can see people running containers having a
> problem with that (a customer running one container gets less CPU than
> the other.). Sorry if I missed something.
>

But the 50% sleeper is _asking_ for less CPU.  Doing 50% for each would
mean that when the sleeper task was awake it always ran, always won, to
the exclusion of any one else. (Assuming 1 CPU...)

Cheers,
Phil

> But yeah I do find the whole EEVDF idea interesting but I admit I have
> to research it more.
> 
>  - Joel
> 

-- 

