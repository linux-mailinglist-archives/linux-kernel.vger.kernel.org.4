Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DB35EC196
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbiI0LhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbiI0LhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:37:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461CF147680
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4IM+jE9VLx0+P1Re745K602t8IJeLzHdS8BKzt/l1dY=; b=TING0qbybUhPnrUM2MhI4PBEYL
        k3CBkSTsiGn/WrQL5c0absw1BRtnQxbQRtJ2MK/Jm3snInmCaGDAofUb7d8kTvbbAa+qvWB369sc+
        QP1aGjKOGYANdV+y+z6c3CrvkuZS/m6AlGR5jYUseJGwIYTVBYrDCHPG5odBA6y+vQiVJTpKHl3pY
        LGCW2xGNcvyv8x45FcONVDJ7c29lLr7KVoh6BPuAODw94iQ6S9m+ru+4OhdP+O1vZv9zgRnO4e5bb
        QGIB1wKV4nqBF2f339d2LsbVxD60qMSsUeOSSaRT2rAEtYohMOcMrTGlP46pivT/u/EicEpNNYmoD
        6734lDaA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1od8tV-00BO04-G3; Tue, 27 Sep 2022 11:36:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2411430024D;
        Tue, 27 Sep 2022 13:36:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 012E62BDDB534; Tue, 27 Sep 2022 13:36:53 +0200 (CEST)
Date:   Tue, 27 Sep 2022 13:36:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [RFC PATCH 12/23] thermal: intel: hfi: Convert table_lock to use
 flags-handling variants
Message-ID: <YzLgVckjbAAfC7jg@hirez.programming.kicks-ass.net>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-13-ricardo.neri-calderon@linux.intel.com>
 <YzLfr49woc1PMOxO@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzLfr49woc1PMOxO@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 01:34:07PM +0200, Peter Zijlstra wrote:
> On Fri, Sep 09, 2022 at 04:11:54PM -0700, Ricardo Neri wrote:
> 
> > --- a/drivers/thermal/intel/intel_hfi.c
> > +++ b/drivers/thermal/intel/intel_hfi.c
> > @@ -175,9 +175,10 @@ static struct workqueue_struct *hfi_updates_wq;
> >  static void get_hfi_caps(struct hfi_instance *hfi_instance,
> >  			 struct thermal_genl_cpu_caps *cpu_caps)
> >  {
> > +	unsigned long flags;
> >  	int cpu, i = 0;
> >  
> > -	raw_spin_lock_irq(&hfi_instance->table_lock);
> > +	raw_spin_lock_irqsave(&hfi_instance->table_lock, flags);
> >  	for_each_cpu(cpu, hfi_instance->cpus) {
> >  		struct hfi_cpu_data *caps;
> >  		s16 index;
> 
> ^^^^ Anti-pattern alert!
> 
> Now your IRQ latency depends on nr_cpus -- which is a fair fail. The
> existing code is already pretty crap in that it has the preemption
> latency depend on nr_cpus.
> 
> While I'm here looking at the HFI stuff, did they fix that HFI interrupt
> broadcast mess already? Sending an interrupt to *all* CPUs is quite
> insane.

Anyway; given the existence of this here loop; why not have something
like:

DEFINE_PER_CPU(int, hfi_ipc_class);

	class = // extract from HFI mess
	WRITE_ONCE(per_cpu(hfi_ipc_class, cpu), class);

And then have the tick use this_cpu_read(hfi_ipc_class)? No extra
locking required.
