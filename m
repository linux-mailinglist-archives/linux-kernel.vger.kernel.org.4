Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDF664F443
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 23:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiLPWsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 17:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiLPWro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 17:47:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7034061D63
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 14:47:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25CE4B81E34
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 22:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87439C433F1;
        Fri, 16 Dec 2022 22:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671230841;
        bh=UDGxwodPxON5TS5sciX0FiTPylhbUIAKvOCV1p/a2JE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jXs70tcBCwjWPNomP7NvNBi3B1eykeZCZm5yr7lSDN7nkDKCJrWYXslWirlBunY5o
         IgLw4P+2fGLf+Mv24xuAeigK8vWf+Ya0M5aepznyvwnYltJOS4s0/njqsKiLrJZl91
         jiz4h1HcKPvizmjs3ByM82OAUHLkNQbr+NiKD82wpCruhAiJxvpCxNMVA4pWiKABJs
         +W0VwIeBmZB41e5Y8OUQPsmu0a6rZjmM8bcs7U9Dnyke0bar38in7WDS1OXBZYTjwS
         OVvCu5EqIVrbSZPP8jksmPmPjqRzoAgq0PlFeS7Ub+JWafEqjm+wzazzeIROQa60Ul
         IfUfoQgEDyL1Q==
Date:   Fri, 16 Dec 2022 23:47:19 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     atomlin@redhat.com, cl@linux.com, tglx@linutronix.de,
        mingo@kernel.org, peterz@infradead.org, pauld@redhat.com,
        neelx@redhat.com, oleksandr@natalenko.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v9 3/5] mm/vmstat: manage per-CPU stats from CPU context
 when NOHZ full
Message-ID: <20221216224719.GB1967978@lothringen>
References: <20221206161826.698593151@redhat.com>
 <20221206162416.474800121@redhat.com>
 <20221214133302.GA1931356@lothringen>
 <Y5yZyd0gd7M3M2+j@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5yZyd0gd7M3M2+j@tpad>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 01:16:09PM -0300, Marcelo Tosatti wrote:
> On Wed, Dec 14, 2022 at 02:33:02PM +0100, Frederic Weisbecker wrote:
> > On Tue, Dec 06, 2022 at 01:18:29PM -0300, Marcelo Tosatti wrote:
> > >  static inline void vmstat_mark_dirty(void)
> > >  {
> > > +	int cpu = smp_processor_id();
> > > +
> > > +	if (tick_nohz_full_cpu(cpu) && !this_cpu_read(vmstat_dirty)) {
> > > +		struct delayed_work *dw;
> > > +
> > > +		dw = &per_cpu(vmstat_work, cpu);
> > > +		if (!delayed_work_pending(dw)) {
> > > +			unsigned long delay;
> > > +
> > > +			delay = round_jiffies_relative(sysctl_stat_interval);
> > > +			queue_delayed_work_on(cpu, mm_percpu_wq, dw, delay);
> > 
> > Currently the vmstat_work is flushed on cpu_hotplug (CPUHP_AP_ONLINE_DYN).
> > vmstat_shepherd makes sure to not rearm it afterward. But now it looks
> > possible for the above to do that mistake?
> 
> Don't think the mistake is an issue. In case of a
> queue_delayed_work_on being called after cancel_delayed_work_sync,
> either vmstat_update executes on the local CPU, or on a
> different CPU (after the bound kworkers have been moved).

But after the CPU goes offline, its workqueue pool becomes UNBOUND. Which means
that the vmstat_update() from the offline CPU can then execute partly on CPU 0, then
gets preempted and executes halfway on CPU 1, then gets preempted and...

Having a quick look at refresh_cpu_vm_stats(), I doesn't look ready for that...

Thanks.

> 
> Each case is fine (see vmstat_update).
> 
> > > +		}
> > > +	}
> > >  	this_cpu_write(vmstat_dirty, true);
> > >  }
> > > @@ -2009,6 +2028,10 @@ static void vmstat_shepherd(struct work_
> > >  	for_each_online_cpu(cpu) {
> > >  		struct delayed_work *dw = &per_cpu(vmstat_work, cpu);
> > >  
> > > +		/* NOHZ full CPUs manage their own vmstat flushing */
> > > +		if (tick_nohz_full_cpu(smp_processor_id()))
> > 
> > It should be the remote CPU instead of the current one.
> 
> Fixed.
> 
