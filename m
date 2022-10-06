Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44FD5F6364
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiJFJPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbiJFJPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:15:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65442E9E1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 02:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ot4ktfeknrez+0rFTxYXifglqcTo/ZnYJl8BenTVKT8=; b=OYP1NBP+/E3tDZzycmcMtHbf8Y
        pdT7bOvfRha18Og/QcPUP1Mf/P2LothmUh1QIQ4bFBqvJrmXNsRU/Oy9C06ZIH2W+P/09DeMuW1an
        Wdsubt7zO0QTESdw7BRjirsVw4f0xo+jk/g/apg0kIDp190KQaIAj8kSQ+bxQk383Vj6zPkSjsTLT
        5aoeIGDAH/IAHX32IapsNkoSwMemIETcqc0MQyAhaQ4/nCRh0VLKxXAezAr0GP8kp3R5kD5pFOFjc
        l45cv6E3rl9nj/10JHtr/IZbJtclzeCpMS5qUQAWWkbBjzfqwzyt7CQxNumQ+ihre3xs7HIww48gR
        4CvtKaUw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ogMy0-001Cea-Ph; Thu, 06 Oct 2022 09:14:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AFA0F30017D;
        Thu,  6 Oct 2022 11:14:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8287E209D9D88; Thu,  6 Oct 2022 11:14:55 +0200 (CEST)
Date:   Thu, 6 Oct 2022 11:14:55 +0200
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
Subject: Re: [RFC PATCH 15/23] thermal: intel: hfi: Report per-cpu
 class-specific performance scores
Message-ID: <Yz6cjzrmu8HNPhhy@hirez.programming.kicks-ass.net>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-16-ricardo.neri-calderon@linux.intel.com>
 <YzLlk8NL5qkOOxzX@hirez.programming.kicks-ass.net>
 <20221005235959.GB29251@ranerica-svr.sc.intel.com>
 <Yz6XQHafjIpfkyyY@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz6XQHafjIpfkyyY@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 10:52:16AM +0200, Peter Zijlstra wrote:
> On Wed, Oct 05, 2022 at 04:59:59PM -0700, Ricardo Neri wrote:
> > On Tue, Sep 27, 2022 at 01:59:15PM +0200, Peter Zijlstra wrote:
> > > On Fri, Sep 09, 2022 at 04:11:57PM -0700, Ricardo Neri wrote:
> > > > Support the arch_get_task_class_score() interface of the scheduler. Use the
> > > > data that Intel Thread Director provides to inform the scheduler the
> > > > performance of a class of tasks when placed on a given CPU.
> > > > 
> > > 
> > > > +static void get_one_hfi_cap(struct hfi_instance *hfi_instance, s16 index,
> > > > +			    struct hfi_cpu_data *hfi_caps, int class)
> > > > +{
> > > > +	struct hfi_cpu_data *caps;
> > > > +
> > > > +	/* Find the capabilities of @cpu */
> > > > +	caps = hfi_instance->data + index * hfi_features.cpu_stride +
> > > > +	       class * hfi_features.class_stride;
> > > > +	memcpy(hfi_caps, caps, sizeof(*hfi_caps));
> > > > +}
> > > > +
> > > > +int intel_hfi_get_task_class_score(int class, int cpu)
> > > > +{
> > > > +	struct hfi_cpu_info *info = &per_cpu(hfi_cpu_info, cpu);
> > > > +	struct hfi_instance *instance;
> > > > +	struct hfi_cpu_data caps;
> > > > +	unsigned long flags;
> > > > +	int cap;
> > > > +
> > > > +	if (cpu < 0 || cpu >= nr_cpu_ids)
> > > > +		return -EINVAL;
> > > > +
> > > > +	if (class == TASK_CLASS_UNCLASSIFIED)
> > > > +		return -EINVAL;
> > > > +
> > > > +	if (class >= (int)hfi_features.nr_classes)
> > > > +		return -EINVAL;
> > > > +
> > > > +	instance = info->hfi_instance;
> > > > +	if (!instance)
> > > > +		return -ENOENT;
> > > > +
> > > > +	raw_spin_lock_irqsave(&instance->table_lock, flags);
> > > > +	get_one_hfi_cap(instance, info->index, &caps, class);
> > > > +	cap = caps.perf_cap;
> > > > +	raw_spin_unlock_irqrestore(&instance->table_lock, flags);
> > > > +
> > > > +	return cap;
> > > > +}
> > > 
> > > Does any of that data actually ever change? Isn't the class score fixed
> > > per CPU type?
> > 
> > Yes, data can change. The Intel SDM Vol 3 Section 14.6.7 states that the
> > table can be updated during runtime.
> 
> I find the SDM is often unreadable gibberish, this part doesn't dissapoint.
> 
> There's a ton of might and maybe there; what does it actually do and how
> often does it do it? Given the thermal interrupt is such a shitshow, we
> really, as in *REALLY* don't want this to happen at any frequency at
> all.
> 
> And if it barely happens, why do we care if it happens at all?

I enabled this HFI crud on my ADL (INTEL_HFI_THERMAL -- because
apparently Debian doesn't default enable this) and now I get all of _1_
interrupt during boot.

Building a kernel on that machine doesn't manage to trip another one.

TRM:          1          1          1          1          1          1          1          1          1          1          1          1          1          1          1          1          1          1          1          1          1          1          1          1   Thermal event interrupts

So yeah.. *can* change, but doesn't.
