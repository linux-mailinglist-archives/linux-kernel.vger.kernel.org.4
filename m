Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8BC668911
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 02:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240564AbjAMBWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 20:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240472AbjAMBWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 20:22:17 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C215D6B6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 17:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673572936; x=1705108936;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E4YBRPtKn4LIf4pU2TyEB5QjnZETC1Inb5tOwtncOro=;
  b=aDvB/kO/Olpw2bqQcMTQTyEd8vxltdX910QXlmnm7zIFdiM66HsKXh17
   +Yptzd7pRU+pxeUWTP7pG3m6Ith9DhliOaD+zT610AzFw7KwrZ1x1/BF5
   8QnrwH3gWXrUvl0wgNfmLBVCNQ7ZBSVql4clKVCIRmqobYABVsVbRk1Dy
   rbLptkztlIYvigRiLRT30xDXiI1uTG6/M/CtMMOMvdDSgBCtHrFi5u1NO
   uCy3zs3bZcgXke75pOP9VLAQ8zBAI+eSh6Kh0hzv1CDHsGUSN5XoNHMSs
   SqjXiJXxdpHbADIh3xQ8F1mMzB7sXldXFMQoNIc4Qxhy9DlXj6vtiu/Yl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="303580248"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="303580248"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 17:22:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="608005038"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="608005038"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga003.jf.intel.com with ESMTP; 12 Jan 2023 17:22:15 -0800
Date:   Thu, 12 Jan 2023 17:31:29 -0800
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
Message-ID: <20230113013129.GA9379@ranerica-svr.sc.intel.com>
References: <20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com>
 <20221122203532.15013-6-ricardo.neri-calderon@linux.intel.com>
 <Y5IKuJTjE6Pjrw9I@arm.com>
 <20221214165900.GA972@ranerica-svr.sc.intel.com>
 <xhsmhwn6s62b5.mognet@vschneid.remote.csb>
 <20221220004238.GB23844@ranerica-svr.sc.intel.com>
 <xhsmhr0wre5rg.mognet@vschneid.remote.csb>
 <20221229190249.GA14462@ranerica-svr.sc.intel.com>
 <xhsmh1qo2dwrk.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmh1qo2dwrk.mognet@vschneid.remote.csb>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 07:17:51PM +0000, Valentin Schneider wrote:
> On 29/12/22 11:02, Ricardo Neri wrote:
> > On Thu, Dec 22, 2022 at 04:56:51PM +0000, Valentin Schneider wrote:
> >> diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
> >> index 57bde66d95f7a..8dc16942135b4 100644
> >> --- a/include/linux/sched/sd_flags.h
> >> +++ b/include/linux/sched/sd_flags.h
> >> @@ -132,12 +132,12 @@ SD_FLAG(SD_SERIALIZE, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
> >>  /*
> >>   * Place busy tasks earlier in the domain
> >>   *
> >> - * SHARED_CHILD: Usually set on the SMT level. Technically could be set further
> >> - *               up, but currently assumed to be set from the base domain
> >> - *               upwards (see update_top_cache_domain()).
> >> + * SHARED_PARENT: Usually set on the SMT level. Can be set further up if all
> >> + *                siblings of an SMT core are identical, but SMT cores themselves
> >> + *                have different priorites.
> >>   * NEEDS_GROUPS: Load balancing flag.
> >>   */
> >> -SD_FLAG(SD_ASYM_PACKING, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
> >> +SD_FLAG(SD_ASYM_PACKING, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
> >
> > But this would not work for Power7. It only has SD_ASYM_PACKING in the SMT
> > sched domain. Must it have either of these flags?
> >
> 
> It's not mandatory, but making sure SD flags conform to either of them
> means the topology debugging infra can help spot misshapen topologies...
> 
> > In Power7 SMT siblings have the different priority but, IIUC, physical
> > cores are identical.
> >
> 
> 
> ...But you're right, this doesn't work with Power7 as it would need
> SD_ASYM_PACKING all the way up the topology to conform with
> SDF_SHARED_PARENT, which clearly doesn't work with how Power7 uses
> asym_packing.
> 
> > It seems to me that asym_packing is specific to a domain.
> >
> 
> For Power7 it is, since the asymmetry is only between siblings of a given
> core. For other systems where the asymmetry is between cores, that could
> theoretically affect several levels. Consider:
> 
>   DIE [                      ]
>   MC  [          ][          ]
>   SMT [    ][    ][    ][    ]
>   CPU  0  1  2  3  4  5  6  7
>   prio 3  3  2  2  1  1  0  0
> 
> As done in your patch, here asym_packing doesn't make sense for SMT, but it
> does for MC and DIE.
> 
> Anywho, I think what this means if we should drop the SDF_SHARED_* metaflag
> for SD_ASYM_PACKING, unless we can think of a nice way to programmatically
> describe how SD_ASYM_PACKING should be set.

Perhaps it can be done by adding an extra check for sg::asym_prefer_cpu. In
the example you give, DIE does not need SD_ASYM_PACKING if asym_prefer_cpu 
all the MC sched groups of have the same priority. This would satisfy both
Power7 and x86.

This assumes that priorities are available when checking the sanity of the
topology.

Thanks and BR,
Ricardo
