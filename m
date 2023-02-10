Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341356915AD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 01:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjBJAhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 19:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjBJAhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 19:37:12 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E377095E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 16:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675989401; x=1707525401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GBLao6NE/SGSwkVRdGz+EqF+VC4oUdgalsbEcOSG9sM=;
  b=RujB3omMHyN6h00KRwsuBoQwZ/FNlqadQW5gV91AO5ammcn+eHFzxUvR
   eq+IQtnImvDiliIieT/lVIT7BsmkXpjXLam1PovGPdGgrnUzSpQiAcUmX
   aQ7XrannDl2ocFATXpvXPWOjCaJkvnoasG4t8F5LoL1ccER18mk6M9RB4
   LCwCt4mSLgOlAdhhgp37QyNVS0DRWYYrh8Z2jEaskqqQBWuutQSkKNcUV
   UGpXA/MKEgdLicaCykdfBBqQkLcdNaH+AQSG0pwwK6NTDbgwMYx6iAsmX
   hSxqM3xi2oKTmlH502Mu0eDvAPjQMpsHV/7fz0hiw9OG5kNooqx78RLd2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="310656321"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="310656321"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 16:33:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="736556385"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="736556385"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga004.fm.intel.com with ESMTP; 09 Feb 2023 16:33:49 -0800
Date:   Thu, 9 Feb 2023 16:43:33 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
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
Subject: Re: [PATCH v3 04/10] sched/fair: Let low-priority cores help
 high-priority busy SMT cores
Message-ID: <20230210004333.GA6166@ranerica-svr.sc.intel.com>
References: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
 <20230207045838.11243-5-ricardo.neri-calderon@linux.intel.com>
 <CAKfTPtB_YR8e6fcx3Un0vTeJR4EJS9sOXG=wLb8rZeM5Ub4yyA@mail.gmail.com>
 <Y+TexehP3140vxBu@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+TexehP3140vxBu@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 12:53:41PM +0100, Peter Zijlstra wrote:
> On Wed, Feb 08, 2023 at 08:56:32AM +0100, Vincent Guittot wrote:
> 
> > > +                       if (env->sd->flags & SD_SHARE_CPUCAPACITY ||
> > > +                           (!(env->sd->flags & SD_SHARE_CPUCAPACITY) && is_core_idle(i)))
> > 
> > This 2nd if could be merged with the upper one
> 
> Wasn't this exact same condition used in the previous patch as well?
> Does it wants to be a helper perhaps?

Patch 3 focuses on the destination CPU: make sure that it and its SMT
siblings are idle before attempting to do asym_packing balance.

This patch focuses on the busiest group: if the busiest group is an SMT
core with more than one busy sibling, help it even if it has higher
priority.
