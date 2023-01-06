Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5696600EA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 14:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjAFNDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 08:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbjAFNCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 08:02:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9537071FF7
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 05:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673010089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ym1HIba5hHhgKrJESNW1DYb3f7111AlEKPxGR4GLiE4=;
        b=MaSWMtnO/NN60Zebvb4FgE0UD0WPTTqWq9U+/djrj+i137N1/XQk2kAoS9MCLdGXH+tO9d
        LL/x78B7+ZckuA1bpk6c1M6E8rPj9Bo5412UI2ilJfPix/afav8JPkzCKo0NT5AsHgOUnP
        MQIYhcXw74yRcJMq2Pco0sAdmpLsu2I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-116-6Qm0-ZbEMguIUxFUB3CBdg-1; Fri, 06 Jan 2023 08:01:25 -0500
X-MC-Unique: 6Qm0-ZbEMguIUxFUB3CBdg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B589687A9E1;
        Fri,  6 Jan 2023 13:01:24 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 33C522026D4B;
        Fri,  6 Jan 2023 13:01:24 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 1F06C401A0A0A; Fri,  6 Jan 2023 09:51:00 -0300 (-03)
Date:   Fri, 6 Jan 2023 09:51:00 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     atomlin@atomlin.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v13 3/6] mm/vmstat: manage per-CPU stats from CPU context
 when NOHZ full
Message-ID: <Y7gZNM9JHppbZ1Ed@tpad>
References: <20230105125218.031928326@redhat.com>
 <20230106001244.4463-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106001244.4463-1-hdanton@sina.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 08:12:44AM +0800, Hillf Danton wrote:
> On 05 Jan 2023 09:52:21 -0300 Marcelo Tosatti <mtosatti@redhat.com>
> > For nohz full CPUs, we'd like the per-CPU vm statistics to be
> > synchronized when userspace is executing. Otherwise, 
> > the vmstat_shepherd might queue a work item to synchronize them,
> > which is undesired intereference for isolated CPUs.
> > 
> > This means that its necessary to check for, and possibly sync,
> > the statistics when returning to userspace. This means that
> > there are now two execution contexes, on different CPUs,
> > which require awareness about each other: context switch
> > and vmstat shepherd kernel threadr.
> > 
> > To avoid the shared variables between these two contexes (which
> > would require atomic accesses), delegate the responsability
> > of statistics synchronization from vmstat_shepherd to local CPU
> > context, for nohz_full CPUs.
> > 
> > Do that by queueing a delayed work when marking per-CPU vmstat dirty.
> > 
> > When returning to userspace, fold the stats and cancel the delayed work.
> > 
> > When entering idle, only fold the stats.
> > 
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > ---
> >  include/linux/vmstat.h   |    4 ++--
> >  kernel/time/tick-sched.c |    2 +-
> >  mm/vmstat.c              |   41 ++++++++++++++++++++++++++++++++---------
> >  3 files changed, 35 insertions(+), 12 deletions(-)
> > 
> > Index: linux-2.6/mm/vmstat.c
> > ===================================================================
> > --- linux-2.6.orig/mm/vmstat.c
> > +++ linux-2.6/mm/vmstat.c
> > @@ -28,6 +28,7 @@
> >  #include <linux/mm_inline.h>
> >  #include <linux/page_ext.h>
> >  #include <linux/page_owner.h>
> > +#include <linux/tick.h>
> >  
> >  #include "internal.h"
> >  
> > @@ -194,21 +195,57 @@ void fold_vm_numa_events(void)
> >  #endif
> >  
> >  #ifdef CONFIG_SMP
> > -static DEFINE_PER_CPU_ALIGNED(bool, vmstat_dirty);
> > +
> > +struct vmstat_dirty {
> > +	bool dirty;
> > +#ifdef CONFIG_FLUSH_WORK_ON_RESUME_USER
> > +	bool cpu_offline;
> > +#endif
> > +};
> > +
> > +static DEFINE_PER_CPU_ALIGNED(struct vmstat_dirty, vmstat_dirty_pcpu);
> > +static DEFINE_PER_CPU(struct delayed_work, vmstat_work);
> > +int sysctl_stat_interval __read_mostly = HZ;
> > +
> > +#ifdef CONFIG_FLUSH_WORK_ON_RESUME_USER
> > +static inline void vmstat_queue_local_work(void)
> > +{
> > +	bool vmstat_dirty = this_cpu_read(vmstat_dirty_pcpu.dirty);
> > +	bool cpu_offline = this_cpu_read(vmstat_dirty_pcpu.cpu_offline);
> > +	int cpu = smp_processor_id();
> > +
> > +	if (tick_nohz_full_cpu(cpu) && !vmstat_dirty) {
> > +		struct delayed_work *dw;
> > +
> > +		dw = this_cpu_ptr(&vmstat_work);
> > +		if (!delayed_work_pending(dw) && !cpu_offline) {
> > +			unsigned long delay;
> > +
> > +			delay = round_jiffies_relative(sysctl_stat_interval);
> > +			queue_delayed_work_on(cpu, mm_percpu_wq, dw, delay);
> 
> Regression wrt V12 if timer is added on the CPU that is not doing HK_TYPE_TIMER?

Before this change, the timer was managed (and queued on an isolated
CPU) by vmstat_shepherd. Now it is managed (and queued) by the local
CPU, so there is no regression.

Thanks.

