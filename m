Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFBB71FFAE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbjFBKs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234204AbjFBKs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:48:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FEAC0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 03:48:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D7D671FDB1;
        Fri,  2 Jun 2023 10:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685702903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UgWJVTzmoM3MLxltAlpxs/WWqyZsaCJhRFMlwGbVEes=;
        b=FQ6O/d/U3tTFiEz360WaAHfm+gHQ4wQG0WHXQgXTGh2L1FB4LxMl6R5LopM6y9a61bhIF5
        /a6FpXDwHcqBKgNOeKnSVl/iNZC8/Iy0gwgor5Sj1tFI5pDE4oFSqGWZYXXydIThX4GMZC
        nOy0AHJjsaOqBJUsncey9mdtIgAJFCQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A95D713A2E;
        Fri,  2 Jun 2023 10:48:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id c8MPJ/fIeWSfYAAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 02 Jun 2023 10:48:23 +0000
Date:   Fri, 2 Jun 2023 12:48:23 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH 3/4] workqueue: add schedule_on_each_cpumask helper
Message-ID: <ZHnI93EMp+Aq8UAA@dhcp22.suse.cz>
References: <20230530145234.968927611@redhat.com>
 <20230530145335.930262644@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530145335.930262644@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You should be CCing WQ maintainers on changes like this one (now added).

On Tue 30-05-23 11:52:37, Marcelo Tosatti wrote:
> Add a schedule_on_each_cpumask function, equivalent to
> schedule_on_each_cpu but accepting a cpumask to operate.

IMHO it is preferable to add a new function along with its user so that
the usecase is more clear.
 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> ---
> 
> Index: linux-vmstat-remote/kernel/workqueue.c
> ===================================================================
> --- linux-vmstat-remote.orig/kernel/workqueue.c
> +++ linux-vmstat-remote/kernel/workqueue.c
> @@ -3455,6 +3455,56 @@ int schedule_on_each_cpu(work_func_t fun
>  	return 0;
>  }
>  
> +
> +/**
> + * schedule_on_each_cpumask - execute a function synchronously on each
> + * CPU in "cpumask", for those which are online.
> + *
> + * @func: the function to call
> + * @mask: the CPUs which to call function on
> + *
> + * schedule_on_each_cpu() executes @func on each specified CPU that is online,
> + * using the system workqueue and blocks until all such CPUs have completed.
> + * schedule_on_each_cpu() is very slow.
> + *
> + * Return:
> + * 0 on success, -errno on failure.
> + */
> +int schedule_on_each_cpumask(work_func_t func, cpumask_t *cpumask)
> +{
> +	int cpu;
> +	struct work_struct __percpu *works;
> +	cpumask_var_t effmask;
> +
> +	works = alloc_percpu(struct work_struct);
> +	if (!works)
> +		return -ENOMEM;
> +
> +	if (!alloc_cpumask_var(&effmask, GFP_KERNEL)) {
> +		free_percpu(works);
> +		return -ENOMEM;
> +	}
> +
> +	cpumask_and(effmask, cpumask, cpu_online_mask);
> +
> +	cpus_read_lock();
> +
> +	for_each_cpu(cpu, effmask) {

Is the cpu_online_mask dance really necessary? Why cannot you simply do
for_each_online_cpu here? flush_work on unqueued work item should just
return, no?

Also there is no synchronization with the cpu hotplug so cpu_online_mask
can change under your feet so this construct seem unsafe to me.

> +		struct work_struct *work = per_cpu_ptr(works, cpu);
> +
> +		INIT_WORK(work, func);
> +		schedule_work_on(cpu, work);
> +	}
> +
> +	for_each_cpu(cpu, effmask)
> +		flush_work(per_cpu_ptr(works, cpu));
> +
> +	cpus_read_unlock();
> +	free_percpu(works);
> +	free_cpumask_var(effmask);
> +	return 0;
> +}
> +
>  /**
>   * execute_in_process_context - reliably execute the routine with user context
>   * @fn:		the function to execute
> Index: linux-vmstat-remote/include/linux/workqueue.h
> ===================================================================
> --- linux-vmstat-remote.orig/include/linux/workqueue.h
> +++ linux-vmstat-remote/include/linux/workqueue.h
> @@ -450,6 +450,7 @@ extern void __flush_workqueue(struct wor
>  extern void drain_workqueue(struct workqueue_struct *wq);
>  
>  extern int schedule_on_each_cpu(work_func_t func);
> +extern int schedule_on_each_cpumask(work_func_t func, cpumask_t *cpumask);
>  
>  int execute_in_process_context(work_func_t fn, struct execute_work *);
>  
> 

-- 
Michal Hocko
SUSE Labs
