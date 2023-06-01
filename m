Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AA871F187
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 20:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjFASPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 14:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjFASPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 14:15:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2891B6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 11:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685643250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yAXWvO+rbRz76kR38MiqP2PBm7rvHKr57C2NYNrSHKM=;
        b=BMT5YOrvYoUzA4f+DDLwKyWvBGfpDx/C7S1rX8UW9qF4S7MJJjy659891fQEXQy/MMPje1
        EDRf0mGsPb/E/3D4s5voqmtk99Xo5iv4d+9H0n9E4z8LY+mYRewcooUKAHTmefhUpedgkn
        2lC+YnrPRNSHW8pPg71ogjf3LaSCuKc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-ZbWf3b_NOsSE21DsYMy7wA-1; Thu, 01 Jun 2023 14:14:08 -0400
X-MC-Unique: ZbWf3b_NOsSE21DsYMy7wA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A6ACA1C01EAB;
        Thu,  1 Jun 2023 18:14:06 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C67B14171BB;
        Thu,  1 Jun 2023 18:14:06 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 2647440155719; Thu,  1 Jun 2023 15:13:49 -0300 (-03)
Date:   Thu, 1 Jun 2023 15:13:49 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 3/4] workqueue: add schedule_on_each_cpumask helper
Message-ID: <ZHjf3Y99VuC51Ipr@tpad>
References: <20230530145234.968927611@redhat.com>
 <20230530145335.930262644@redhat.com>
 <20230530130947.37edbab6b672bfce6f481295@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530130947.37edbab6b672bfce6f481295@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 01:09:47PM -0700, Andrew Morton wrote:
> On Tue, 30 May 2023 11:52:37 -0300 Marcelo Tosatti <mtosatti@redhat.com> wrote:
> 
> > Add a schedule_on_each_cpumask function, equivalent to
> > schedule_on_each_cpu but accepting a cpumask to operate.
> > 
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
> Should we check here that the cpu is still online?
> 
> > +		struct work_struct *work = per_cpu_ptr(works, cpu);
> > +
> > +		INIT_WORK(work, func);
> > +		schedule_work_on(cpu, work);
> > +	}
> > +
> > +	for_each_cpu(cpu, effmask)
> > +		flush_work(per_cpu_ptr(works, cpu));
> > +
> > +	cpus_read_unlock();
> > +	free_percpu(works);
> > +	free_cpumask_var(effmask);
> > +	return 0;
> > +}
> > +
> >  /**
> >   * execute_in_process_context - reliably execute the routine with user context
> >   * @fn:		the function to execute
> > --- linux-vmstat-remote.orig/include/linux/workqueue.h
> > +++ linux-vmstat-remote/include/linux/workqueue.h
> > @@ -450,6 +450,7 @@ extern void __flush_workqueue(struct wor
> >  extern void drain_workqueue(struct workqueue_struct *wq);
> >  
> >  extern int schedule_on_each_cpu(work_func_t func);
> > +extern int schedule_on_each_cpumask(work_func_t func, cpumask_t *cpumask);
> 
> May as well make schedule_on_each_cpu() call
> schedule_on_each_cpumask()?  Save a bit of text, and they're hardly
> performance-critical to that extent.

Agree, will wait for Michal's review before resending -v2.


workqueue: add schedule_on_each_cpumask helper

Add a schedule_on_each_cpumask function, equivalent to
schedule_on_each_cpu but accepting a cpumask to operate.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---

v2: - cpu_online_mask reference should happen with cpus_read_lock held	(Andrew Morton)
    - have schedule_on_each_cpu call _cpumask variant			(Andrew Morton)

Index: linux-vmstat-remote/kernel/workqueue.c
===================================================================
--- linux-vmstat-remote.orig/kernel/workqueue.c
+++ linux-vmstat-remote/kernel/workqueue.c
@@ -3431,27 +3431,56 @@ EXPORT_SYMBOL(cancel_delayed_work_sync);
  */
 int schedule_on_each_cpu(work_func_t func)
 {
+	return schedule_on_each_cpumask(func, cpu_possible_mask);
+}
+
+
+/**
+ * schedule_on_each_cpumask - execute a function synchronously on each
+ * CPU in "cpumask", for those which are online.
+ *
+ * @func: the function to call
+ * @mask: the CPUs which to call function on
+ *
+ * schedule_on_each_cpu() executes @func on each specified CPU that is online,
+ * using the system workqueue and blocks until all such CPUs have completed.
+ * schedule_on_each_cpu() is very slow.
+ *
+ * Return:
+ * 0 on success, -errno on failure.
+ */
+int schedule_on_each_cpumask(work_func_t func, cpumask_t *cpumask)
+{
 	int cpu;
 	struct work_struct __percpu *works;
+	cpumask_var_t effmask;
 
 	works = alloc_percpu(struct work_struct);
 	if (!works)
 		return -ENOMEM;
 
+	if (!alloc_cpumask_var(&effmask, GFP_KERNEL)) {
+		free_percpu(works);
+		return -ENOMEM;
+	}
+
 	cpus_read_lock();
 
-	for_each_online_cpu(cpu) {
+	cpumask_and(effmask, cpumask, cpu_online_mask);
+
+	for_each_cpu(cpu, effmask) {
 		struct work_struct *work = per_cpu_ptr(works, cpu);
 
 		INIT_WORK(work, func);
 		schedule_work_on(cpu, work);
 	}
 
-	for_each_online_cpu(cpu)
+	for_each_cpu(cpu, effmask)
 		flush_work(per_cpu_ptr(works, cpu));
 
 	cpus_read_unlock();
 	free_percpu(works);
+	free_cpumask_var(effmask);
 	return 0;
 }
 
Index: linux-vmstat-remote/include/linux/workqueue.h
===================================================================
--- linux-vmstat-remote.orig/include/linux/workqueue.h
+++ linux-vmstat-remote/include/linux/workqueue.h
@@ -450,6 +450,7 @@ extern void __flush_workqueue(struct wor
 extern void drain_workqueue(struct workqueue_struct *wq);
 
 extern int schedule_on_each_cpu(work_func_t func);
+extern int schedule_on_each_cpumask(work_func_t func, cpumask_t *cpumask);
 
 int execute_in_process_context(work_func_t fn, struct execute_work *);
 

