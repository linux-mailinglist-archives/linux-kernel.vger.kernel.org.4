Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D92C74A7E6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 01:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjGFXqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 19:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGFXqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 19:46:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8801BE1;
        Thu,  6 Jul 2023 16:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688687168; x=1720223168;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5z4OjmeZwDQyXYWW2PZs4DvSJouSgf57c25znqVWnvk=;
  b=c+CPDtpYuTK9VqKMb27hiBAFRJcav/ET714jsCBo0NTolueMg5yjmBF7
   +BigaXKn3PX/PHQFBDPUM3NfDpg2xCLJji8MGdGgFOOHkSSgoL1DZn71+
   UNfZ6/SoOwuC7lYByGXNTje2Dii1z8BFgKpAizGfThqpYZo5aAhZKK5fN
   5KrWgJ3kXAs/sMd2a7fdhTkNclZeMb6wtb0WqFoYYqL3QtuUbtUFdYuVK
   I96Oj9Je9ogt2/nFuoJTukNSSS4n+VD522q1OGqcmITMr6ankyNL2BtqR
   rByjg3GVrk+GDDvIkxGe4GbUuXA0o275hHEgn1w4zC5B5qLJXiQ9h3GjF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="344086754"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="344086754"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 16:46:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="697038151"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="697038151"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga006.jf.intel.com with ESMTP; 06 Jul 2023 16:46:06 -0700
Date:   Thu, 6 Jul 2023 16:48:50 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
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
        Valentin Schneider <vschneid@redhat.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Zhao Liu <zhao1.liu@intel.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Tim C . Chen" <tim.c.chen@intel.com>,
        Zhao Liu <zhao1.liu@linux.intel.com>
Subject: Re: [PATCH v4 07/24] sched/fair: Compute IPC class scores for load
 balancing
Message-ID: <20230706234850.GD12259@ranerica-svr.sc.intel.com>
References: <20230613042422.5344-1-ricardo.neri-calderon@linux.intel.com>
 <20230613042422.5344-8-ricardo.neri-calderon@linux.intel.com>
 <ZJQONIinvSengWa8@arm.com>
 <20230625201155.GA3902@ranerica-svr.sc.intel.com>
 <7ca035b73ebcce9fde270227a5b630b169ebdeaf.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ca035b73ebcce9fde270227a5b630b169ebdeaf.camel@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 02:01:25PM -0700, Tim Chen wrote:
> On Sun, 2023-06-25 at 13:11 -0700, Ricardo Neri wrote:
> > 
> > > > +
> > > > +	score_on_dst_cpu = arch_get_ipcc_score(sgs->min_ipcc, env->dst_cpu);
> > > > +
> > > > +	/*
> > > > +	 * Do not use IPC scores. sgs::ipcc_score_{after, before} will be zero
> > > > +	 * and not used.
> > > > +	 */
> 
> The comment is not matching the check below.  If zero
> is not used, the check should also reflect the case.

Agreed. This comment is not clear. I meant to say that returning here
has the effect of leaving the `before` and `after` scores of this group as
zero.

Since zero is the minimum possible score, this group will not be selected
during the tie breaker, unless the statistics of all other groups are also
zero.

> 
> > > > +	if (IS_ERR_VALUE(score_on_dst_cpu))
> > > > +		return;
> > > > +
> > > > +	before = sgs->sum_score;
> > > > +	after = before - sgs->min_score;
> > > 
> > 
> Tim
