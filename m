Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D13F66DDDD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 13:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236689AbjAQMki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 07:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236828AbjAQMkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 07:40:25 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C342B36FEA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 04:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673959218; x=1705495218;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kcEbyOQGZ2DTVE9gm1HZOV1vu1SPkaZannL8NC6xxqY=;
  b=J8A1sCaTTTx8RjlWoD7n3qlFKdh0lW82goGSFj2NXj7Wgt0jHjAHlPhE
   4anXk9pm4l2V1rUPyiLBwW+NRoDPi99b0O7/Dpx0/sD3Uwd0IcDMb4rbp
   noEQeoPCtlWqJfYoK3POMN5ixWRUUEw3SL+BUI2CpvOCKK6dlJYPX83s+
   oSu/wo+oSyb17uZwT4trkTNLqZqXTiF6nHoU6Bxh8sSJCLrZ5bGIUxANO
   6Il0W4CH64KPAQloSs3tduH2dr98gjCCLmWjNAyExEuOU3oLT9QYhQmvA
   vJgerLcQXQOL0/EZdT2FxPphNVIRH/8cOPhfd7aLOs9TFjv6bBjS/ZMjd
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="326753306"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="326753306"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 04:40:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="904634374"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="904634374"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jan 2023 04:40:17 -0800
Date:   Tue, 17 Jan 2023 04:49:28 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
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
Subject: Re: [PATCH v2 1/7] sched/fair: Generalize asym_packing logic for SMT
 local sched group
Message-ID: <20230117124928.GA5559@ranerica-svr.sc.intel.com>
References: <20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com>
 <20221122203532.15013-2-ricardo.neri-calderon@linux.intel.com>
 <xhsmhv8m3e5sx.mognet@vschneid.remote.csb>
 <20221229040003.GA11497@ranerica-svr.sc.intel.com>
 <xhsmhsfghcb20.mognet@vschneid.remote.csb>
 <20230113190226.GA1379@ranerica-svr.sc.intel.com>
 <20230116040529.GA16654@ranerica-svr.sc.intel.com>
 <xhsmhtu0qi9h1.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhtu0qi9h1.mognet@vschneid.remote.csb>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 07:07:54PM +0000, Valentin Schneider wrote:
> On 15/01/23 20:05, Ricardo Neri wrote:
> >> >
> >> > It should be set on any topology level below the NUMA ones, we do remove it
> >> > on SD_ASYM_CPUCAPACITY levels because this used to interfere with misfit
> >> > balancing (it would override the group_type), things are a bit different
> >> > since Vincent's rewrite of load_balance() but I think we still want it off
> >> > there.
> >
> > Your comment got me thinking. Whose child sched domain wants prefer_sibling?
> > It sounds to me that is busiest's. I could not think of any reason of *having*
> > to use the flags of the local group.
> >
> 
> Hm, given that on systems without SD_ASYM_CPUCAPACITY, SD_PREFER_SIBLING is
> set all the way from SMT up to the last !NUMA domain, should we just get
> rid of the child/parent weirdness of SD_PREFER_SIBLING and stick with the
> flags we are given at the level we're balancing at?
> 
> i.e.
> 
>         sds->prefer_sibling = env->sd & SD_PREFER_SIBLING;

Agreed. This would also make the code easier to understand. It should not change
the current behavior either; except (i.e., fix) for the busiest->group_weight = 2
vs local->group_weight = 1 I raised.

> 
> Unless I'm reading this wrong, this also eliminates the effect of
> SD_PREFER_SIBLING on the first NUMA level - DIE level has SD_PREFER_SIBLING
> set, but we don't necessarily want to evenly spread things out when accross
> NUMA nodes.

Agreed.

> 
> 
> > We can use the flags of the sched group (as per 16d364ba6ef2 ("sched/topology:
> > Introduce sched_group::flags"), these are the flags of the child domain).
> >
> > The patch below works for me and I don't have to even the number of busy CPUs.
> > It should not interfere with misfit balancing either:
> >
> 
> We remove that flag on systems where misfit balancing happens anyway, so
> that's safe vs. SD_PREFER_SIBLING.

Then all looks good with your suggestion. I'll include a patch in my series.

Thanks and BR,
Ricardo
