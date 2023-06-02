Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23F57208A9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 19:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236814AbjFBRzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 13:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236593AbjFBRzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 13:55:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59457133
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 10:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685728458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1FZZS690xjfMOFr+rvSD+7ZzRxDt4EoNBI4Y40OmjzE=;
        b=gqgFF3akBV/5bjlmtYUE8X5WLlgSS29JMVEd7MM6ldgvIsveFFciwaqr+znb8PX1qoYWAG
        NhHA4ktcbpu3JA4AowJIqdrVyMDczlaMrO2UJ/L06zgVBt7jKsI0Xs1JnilXwm7cU4lRbm
        nNnNkeW5dr5Gg5bMUsF99NDapaMyGBI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-295-Xud-YHbHOzmT9w4kHBcvZA-1; Fri, 02 Jun 2023 13:54:13 -0400
X-MC-Unique: Xud-YHbHOzmT9w4kHBcvZA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CCDCD185A78B;
        Fri,  2 Jun 2023 17:54:12 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E71C2166B25;
        Fri,  2 Jun 2023 17:54:12 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 0D5BC4017883E; Fri,  2 Jun 2023 14:04:28 -0300 (-03)
Date:   Fri, 2 Jun 2023 14:04:28 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH 3/4] workqueue: add schedule_on_each_cpumask helper
Message-ID: <ZHohHHvtDjIJHA+a@tpad>
References: <20230530145234.968927611@redhat.com>
 <20230530145335.930262644@redhat.com>
 <ZHnI93EMp+Aq8UAA@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHnI93EMp+Aq8UAA@dhcp22.suse.cz>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 12:48:23PM +0200, Michal Hocko wrote:
> You should be CCing WQ maintainers on changes like this one (now added).
> 
> On Tue 30-05-23 11:52:37, Marcelo Tosatti wrote:
> > Add a schedule_on_each_cpumask function, equivalent to
> > schedule_on_each_cpu but accepting a cpumask to operate.
> 
> IMHO it is preferable to add a new function along with its user so that
> the usecase is more clear.
>  
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > 
> > ---
> > 
> > Index: linux-vmstat-remote/kernel/workqueue.c
> > ===================================================================
> > --- linux-vmstat-remote.orig/kernel/workqueue.c
> > +++ linux-vmstat-remote/kernel/workqueue.c
> > @@ -3455,6 +3455,56 @@ int schedule_on_each_cpu(work_func_t fun
> >  	return 0;
> >  }
> >  
> > +
> > +/**
> > + * schedule_on_each_cpumask - execute a function synchronously on each
> > + * CPU in "cpumask", for those which are online.
> > + *
> > + * @func: the function to call
> > + * @mask: the CPUs which to call function on
> > + *
> > + * schedule_on_each_cpu() executes @func on each specified CPU that is online,
> > + * using the system workqueue and blocks until all such CPUs have completed.
> > + * schedule_on_each_cpu() is very slow.
> > + *
> > + * Return:
> > + * 0 on success, -errno on failure.
> > + */
> > +int schedule_on_each_cpumask(work_func_t func, cpumask_t *cpumask)
> > +{
> > +	int cpu;
> > +	struct work_struct __percpu *works;
> > +	cpumask_var_t effmask;
> > +
> > +	works = alloc_percpu(struct work_struct);
> > +	if (!works)
> > +		return -ENOMEM;
> > +
> > +	if (!alloc_cpumask_var(&effmask, GFP_KERNEL)) {
> > +		free_percpu(works);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	cpumask_and(effmask, cpumask, cpu_online_mask);
> > +
> > +	cpus_read_lock();
> > +
> > +	for_each_cpu(cpu, effmask) {
> 
> Is the cpu_online_mask dance really necessary? 

> Why cannot you simply do for_each_online_cpu here? 

Are you suggesting to do: 

	for_each_online_cpu(cpu) {
		if cpu is not in cpumask
			continue;
		...
	}

This does not seem efficient.

> flush_work on unqueued work item should just
> return, no?

Apparently not:

commit 0e8d6a9336b487a1dd6f1991ff376e669d4c87c6
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Wed Apr 12 22:07:28 2017 +0200

    workqueue: Provide work_on_cpu_safe()
    
    work_on_cpu() is not protected against CPU hotplug. For code which requires
    to be either executed on an online CPU or to fail if the CPU is not
    available the callsite would have to protect against CPU hotplug.
    
    Provide a function which does get/put_online_cpus() around the call to
    work_on_cpu() and fails the call with -ENODEV if the target CPU is not
    online.

> Also there is no synchronization with the cpu hotplug so cpu_online_mask
> can change under your feet so this construct seem unsafe to me.

Yes, fixed by patch in response to Andrew's comment.

