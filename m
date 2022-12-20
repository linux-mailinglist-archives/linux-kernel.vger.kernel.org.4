Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3526651732
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 01:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbiLTAeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 19:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiLTAeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 19:34:16 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43760E00C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 16:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671496456; x=1703032456;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ds2VUAVfoNYlAJRfWxqUWz0p9Aqt0zDG8ziPAIf7zkI=;
  b=dI7rGZPOG3n68k5c0oHWCi+FBmpTpbIrWDqOt1cE9jtishLQTvME009c
   Q9+nLU8nGBdq44tDP05foI7P0asFD9gp3EAPKy9zoJ0oELa6n3UzDw2Ap
   CZcnV+yH/NpiQXTn0dHgYEZZwU0RDapPXRmNY7tcS4tPZIy6gFtYKpadl
   8gekCDT47uSZVpTIuQz7kXl8n83LSCn+FEVoFxlFekHA/mj+66QEr5oOJ
   tb4bf5N/YUG9yo/3GBih/6YhwTgxWpoR3H0YAm9q2/ee+69g3gxRqHsoQ
   0Ki6HgtegGy/ldA4zKdieZoWmxJmZ19TzIJmYMiQGvLAGUVFzjSEBpTW9
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="299829682"
X-IronPort-AV: E=Sophos;i="5.96,258,1665471600"; 
   d="scan'208";a="299829682"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 16:34:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="825032765"
X-IronPort-AV: E=Sophos;i="5.96,258,1665471600"; 
   d="scan'208";a="825032765"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 19 Dec 2022 16:34:12 -0800
Date:   Mon, 19 Dec 2022 16:42:38 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
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
        Tim Chen <tim.c.chen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v2 5/7] x86/sched: Remove SD_ASYM_PACKING from the "SMT"
 domain
Message-ID: <20221220004238.GB23844@ranerica-svr.sc.intel.com>
References: <20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com>
 <20221122203532.15013-6-ricardo.neri-calderon@linux.intel.com>
 <Y5IKuJTjE6Pjrw9I@arm.com>
 <20221214165900.GA972@ranerica-svr.sc.intel.com>
 <xhsmhwn6s62b5.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhwn6s62b5.mognet@vschneid.remote.csb>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 04:48:14PM +0000, Valentin Schneider wrote:
> On 14/12/22 08:59, Ricardo Neri wrote:
> > On Thu, Dec 08, 2022 at 04:03:04PM +0000, Ionela Voinescu wrote:
> >> Based on:
> >>
> >> kernel/sched/topology.c:
> >> sd = highest_flag_domain(cpu, SD_ASYM_PACKING);
> >> rcu_assign_pointer(per_cpu(sd_asym_packing, cpu), sd);
> >>
> >> and described at:
> >>
> >> include/linux/sched/sd_flags.h:
> >> /*
> >>  * Place busy tasks earlier in the domain
> >>  *
> >>  * SHARED_CHILD: Usually set on the SMT level. Technically could be set further
> >>  *               up, but currently assumed to be set from the base domain
> >>  *               upwards (see update_top_cache_domain()).
> >>  * NEEDS_GROUPS: Load balancing flag.
> >>  */
> >> SD_FLAG(SD_ASYM_PACKING, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
> >>
> >> doesn't your change result in sd_asym_packing being NULL?
> >
> > Yes. This is a good catch. Thanks!
> >
> 
> Nice to see those being useful :-) FYI if you run your kernel with
> CONFIG_SCHED_DEBUG=y and sched_debug on the cmdline, you should get a
> warning at boot time from the topology debug code checking assertions
> against those flags.

Thanks! I missed this warning. Indeed, it is there.
> 
> >>
> >> The SD_ASYM_PACKING flag requires all children of a domain to have it set
> >> as well. So having SMT not setting the flag, while CLUSTER and MC having
> >> set the flag would result in a broken topology, right?
> >
> > I'd say that highest_flag_domain(..., flag) requires all children to have
> > `flag`, but clearly the comment you quote allows for SD_ASYM_PACKING to
> > be located in upper domains.
> >
> > Perhaps this can be fixed with a variant of highest_flag_domain() that do
> > not require all children to have the flag?
> >
> 
> So I gave that flag SDF_SHARED_CHILD because its cached SD pointer was set
> up using highest_flag_domain(). Looking for the highest level where it is
> set matches how it is used in nohz_balancer_kick(), so you might want a new
> helper.

Right. I was thinking on a highest_flag_domain_weak() or a changing
highest_flag_domain(..., bool shared_child).

> 
> With that said, so far all but one flag (SD_PREFER_SIBLING, and that's
> because of big.LITTLE woes) follow the SDF_SHARED_{CHILD, PARENT} pattern,
> if SD_ASYM_PACKING no longer does then we need to think whether we're
> trying to make it do funky things.

My thesis is that x86 does not need the SD_ASYM_PACKING flag at the SMT
level because all SMT siblings are identical. There are cores of higher
priority at the "MC" level (maybe in the future at the "CLS" level).

Power7 is fine because it only uses SD_ASYM_PACKING at the SMT level.

> I need to look at the rest of your
> series to get an idea, that unfortunately won't be today but it's now in my
> todolist.

Thank you!

BR,
Ricardo
