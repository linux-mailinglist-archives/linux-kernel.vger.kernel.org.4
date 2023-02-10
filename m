Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2E2691F9B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 14:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjBJNOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 08:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjBJNOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 08:14:21 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69464DBD0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 05:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676034860; x=1707570860;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S1u5cEUA0nsv74LxPw292hCootzDxlWOkqMDRRkLa2o=;
  b=eF2AB07JtlRqgLpFNA8s7lkhai5pxzpEFBeIpi8UbY6P9SioHmOEmpHT
   tk1TsCY2AEKDIAiQDym+c54G5pb+xp65I9f6r5B5TvRYe/O+1VapuwLai
   A0yEUc1cDvZbgRHkoe1KJP+a77yiFzaSiZmuYAYdDhJjpnIeQ8qSdIIkt
   1yjftuDk4o9z2JPQFGsVq9tVbuHt1u915U1EvxXiYc1Eb8DNCV0cP+PzM
   q4+4zy/g+PgenUguKO76fE6Uq07b2PMiQOTEu1yWdNvnfEKPo0AoxTWIr
   Hb2zNUdF40NX5ZKhWzM0L1yNxhytueziWpP9oEj5biFZ5ihSPUL7NMSyL
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="331722280"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="331722280"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 05:14:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="996955218"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="996955218"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga005.fm.intel.com with ESMTP; 10 Feb 2023 05:14:19 -0800
Date:   Fri, 10 Feb 2023 05:24:04 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
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
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v3 06/10] sched/fair: Use the prefer_sibling flag of the
 current sched domain
Message-ID: <20230210132404.GB8447@ranerica-svr.sc.intel.com>
References: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
 <20230207045838.11243-7-ricardo.neri-calderon@linux.intel.com>
 <CAKfTPtAZ8sfDi1GbKSioJkszkRT6f+am5OSjKKKKv2q_4FKQFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAZ8sfDi1GbKSioJkszkRT6f+am5OSjKKKKv2q_4FKQFQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 08:48:05AM +0100, Vincent Guittot wrote:
> On Tue, 7 Feb 2023 at 05:50, Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > SD_PREFER_SIBLING is set from the SMT scheduling domain up to the first
> > non-NUMA domain (the exception is systems with SD_ASYM_CPUCAPACITY).
> >
> > Above the SMT sched domain, all domains have a child. The SD_PREFER_
> > SIBLING is honored always regardless of the scheduling domain at which the
> > load balance takes place.
> >
> > There are cases, however, in which the busiest CPU's sched domain has
> > child but the destination CPU's does not. Consider, for instance a non-SMT
> > core (or an SMT core with only one online sibling) doing load balance with
> > an SMT core at the MC level. SD_PREFER_SIBLING will not be honored. We are
> > left with a fully busy SMT core and an idle non-SMT core.
> >
> > Avoid inconsistent behavior. Use the prefer_sibling behavior at the current
> > scheduling domain, not its child.
> >
> > The NUMA sched domain does not have the SD_PREFER_SIBLING flag. Thus, we
> > will not spread load among NUMA sched groups, as desired.
> 
> This is a significant change in the behavior of the numa system. It
> would be good to get figures or confirmation that demonstrate that
> it's ok to remove prefer_sibling behavior at the 1st numa level.
> 
Thank you very much for your feedback Vincent!

You are right. It does change the behavior at the first numa level. Peter
did not like this change either. It also made things confusing for
SD_ASYM_CPUCAPACITY vs SD_PREFER_SIBLING.

I'll work in a different approach.
