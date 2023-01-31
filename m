Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466B6683668
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 20:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjAaTWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 14:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjAaTWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 14:22:30 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFAE17140
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:22:28 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso5274477wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7lck5IFZUPbrV5J6AbtBCAeWGEX6izFIQH+15LEmKRA=;
        b=3mi0GsH7c6haeXzLoSNBUXCZpDEVsQNhDfqH8x3AWvsrX9uuhJm4c0ocd3YSjSi1qY
         FmqiRBSw3s5FCYEfm3TX/DZ98X+onxYyAhmSUynBbDSVzmuq9zFZhAKyD+86vWKPpl8t
         YBDVE1Wu0NVQZmiUBz46yaPPGoN/Wb6jl+U0rvzVDnQj8CwyJNh1sEyxx8oGjHEtqNZT
         JlO7ugaGhSBoAISDe7Qz7d6DVDr6dJf/+mBiGKZBsbyVbNJ3KVq22VNzbXRyctHCdRcT
         QyGHs+M5KLdcKhbrvXNftSIzNQIwMzDP5FZzZvRv55ygaB0vxuJ6IPE1V2cdilE0qixV
         ZTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lck5IFZUPbrV5J6AbtBCAeWGEX6izFIQH+15LEmKRA=;
        b=yxlKqwplDXyvIbVPxcNfOVSdL5ASWwSOLqfrUxCpGFvjLT4GfRL07I62sOCAuYU7Hr
         +9cL4N6qZ9jjLtPOi6f42pcErtUjZhI/Mff/QiQsB16jetgKNrDaeG6bvwUBh3wz+Yzy
         zQkEoxZK0A2t0J2KHb7FB5LUBFx6i+xEUJZTaKjS6LAsFfmDle7fCF69JnSKlGYF3nS1
         riN0qC1TFJehQsUIoddqeURcPMqO4hlPGi++BkSXE/9ITu8tPywfNZzuwjaC0wYTTKMl
         GjTeUh5xoSaqaV03noCJbO/dYosNHV9PqOVJF6YE0csGF9BPTLm/Xm8xejvhs6KUZkIQ
         UfPA==
X-Gm-Message-State: AO0yUKWHWN07Dijy+pTwAzFsnsIix2Kxjdp0C3T1DHugYXyutUOGF2/N
        nPvq0WQXEpoak225tPMCOW1uvQ==
X-Google-Smtp-Source: AK7set/rg6S7XPKkMXG68Ldayy3X8qxCy0UHr849seJweFymOu5zUxr/pH/J8kKgwpyrO0PnFseEFQ==
X-Received: by 2002:a05:600c:3501:b0:3dc:19d1:3c1f with SMTP id h1-20020a05600c350100b003dc19d13c1fmr26533667wmq.30.1675192946660;
        Tue, 31 Jan 2023 11:22:26 -0800 (PST)
Received: from airbuntu (host86-163-35-10.range86-163.btcentralplus.com. [86.163.35.10])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c248300b003db0ad636d1sm9841357wms.28.2023.01.31.11.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 11:22:25 -0800 (PST)
Date:   Tue, 31 Jan 2023 19:22:23 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>
Subject: Re: [PATCH v2] sched: cpuset: Don't rebuild sched domains on
 suspend-resume
Message-ID: <20230131192223.jf3aydhafpmjg5z4@airbuntu>
References: <20230120194822.962958-1-qyousef@layalina.io>
 <c4c2dec6-a72b-d675-fb42-be40e384ea2c@redhat.com>
 <20230125163546.pspvigh4groiwjy7@airbuntu>
 <45e0f8ea-d229-1ae7-5c12-7f0a64c6767a@redhat.com>
 <20230130130038.2qx3pkzut6ypqdub@airbuntu>
 <253ced33-c3a8-269f-90cc-b69e66b10370@redhat.com>
 <20230130194826.rxwk4ryvpyxemflm@airbuntu>
 <17537d7f-8734-2186-b27c-f39f3110ffe5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <17537d7f-8734-2186-b27c-f39f3110ffe5@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/30/23 14:57, Waiman Long wrote:
> On 1/30/23 14:48, Qais Yousef wrote:
> > On 01/30/23 11:29, Waiman Long wrote:
> > > On 1/30/23 08:00, Qais Yousef wrote:
> > > 
> > >          just skip the call here if the condition is right? Like
> > > 
> > >                  /* rebuild sched domains if cpus_allowed has changed */
> > >                  if (cpus_updated || (force_rebuild && !cpuhp_tasks_frozen)) {
> > >                          force_rebuild = false;
> > >                          rebuild_sched_domains();
> > >                  }
> > > 
> > >          Still, we will need to confirm that cpuhp_tasks_frozen will be cleared
> > >          outside of the suspend/resume cycle.
> > > 
> > >      I think it's fine to use this variable from the cpuhp callback context only.
> > >      Which I think this cpuset workfn is considered an extension of.
> > > 
> > >      But you're right, I can't use cpuhp_tasks_frozen directly in
> > >      rebuild_root_domains() as I did in v1 because it doesn't get cleared after
> > >      calling the last _cpu_up().
> > > 
> > > That is what I suspect. So we can't use that cpuhp_tasks_frozen variable here
> > > in cpuset.
> > > 
> > >       force_rebuild will only be set after the last cpu
> > >      is brought online though - so this should happen once at the end.
> > > 
> > > Perhaps you can add another tracking variable for detecting if suspend/resume
> > > is in progress.
> > I think cpuhp_tasks_frozen is meant for that. All users who cared so far
> > belonged to the cpuhp callback. I think reading it from cpuset_hotplug_workfn()
> > is fine too as this function will only run as a consequence of the cpuhp
> > callback AFAICS. cpuset_cpu_active() takes care of not forcing a rebuild of
> > sched_domains until the last cpu becomes active - so the part of it being done
> > once at the end at resume is handled too.
> 
> Well we will have to add code to clear cpuhp_tasks_frozen at the end of
> resume then. We don't want to affect other callers unless we are sure that
> it won't affect them.

Actually I think since the cpuset_hotplug_workfn() is called later, there's
a chance to race with another cpuhp operation just after resume.

Anyway. I think we don't have to use this flag. But we'd have to better distill
the reasons of why we force_rebuild.

Your 2 new users are tripping me so far - do they handle errors where the shape
of cpuset changes? If yes, then we must take dl accounting update into
consideration for these errors.

Juri, I'd still would appreciate a confirmation from you that I'm not
understanding things completely wrong.

> 
> > 
> > It's just rebuild_sched_domains() will always assume it needs to clear and
> > rebuild deadline accounting - which is not true for suspend/resume case. But
> > now looking at other users of rebuild_sched_domains(), others might be getting
> > the hit too. For example rebuild_sched_domains_locked() is called on
> > update_relax_domain_level() which AFAIU should not impact dl accounting.
> > 
> > FWIW, I did capture a worst case scenario of 21ms because of
> > rebuild_root_domains().
> > 
> > /me thinks rebuild_root_domains() is a misleading name too as it just fixes
> > dl accounting but not rebuild the rd itself.
> > 
> > What makes sense to me now is to pass whether dl accounting requires updating
> > to rebuild_sched_domains() as an arg so that the caller can decide whether the
> > reason can affect dl accounting.
> > 
> > Or maybe pull rebuild_root_domains() out of the chain and let the caller call
> > it directly. And probably rename it to update_do_rd_accounting() or something.
> > 
> > I'll continue to dig more..
> 
> Looking forward to see that.

Another thought I had is maybe worth trying to optimize the rebuild root domain
process. Interestingly in my system there are no dl tasks but

	rebuilds_sched_domains()
	  cpuset_for_each_descendant_pre()
	    update_tasks_root_domain()
	      css_task_iter_next()
	        dl_add_task_root_domain()

seems to be going through every task in the hierarchy anyway which would
explain the slow down. We can have special variants to iterate through
hierarchies that ever seen a dl task attached to them and a special variant to
iterate through dl tasks only in a css - but I'm not sure if I'm brave enough
to go down this rabbit hole :D


Cheers

--
Qais Yousef
