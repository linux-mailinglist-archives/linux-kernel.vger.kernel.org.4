Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C398A64C11E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 01:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237121AbiLNAXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 19:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237050AbiLNAXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 19:23:39 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C406165;
        Tue, 13 Dec 2022 16:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670977418; x=1702513418;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aSgfFdFh7+vD8IJADliquC/z7NtT93tuuNY9WQr1as8=;
  b=DjYqsIFHQUb10xg3VWrE/yhZQO/zAPEe0Fr0PlURGrgb+XYNkGzjetnw
   4eETDmoHrGePK8Ol0bxJJdMCcGJuNQQ42Dbj7fri1XyWsMRRsGbAbMihP
   wf7pj/n0O8V9Etc8eM8UfHxyboOxz38qvDXp6zdo7S9XmfQF3B253XTJl
   MCaB1fLu3XVB8qFwhGCFIhdwGBt4V4JMiJ+vvbFIJBf1WC3yOj3mQkRrZ
   /p5fzYYSn5zopqwbMjtPlDfB+Ypdx7Wvk8iWpWo2YZqFZMRnCKVUmWPNc
   tJoRq5H+J2IRQtOdWAl90kGGac1CHung/zjl0N8hs9PYE19NVwD0jxkOD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="382573166"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="382573166"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 16:23:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="642306690"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="642306690"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga007.jf.intel.com with ESMTP; 13 Dec 2022 16:23:32 -0800
Date:   Tue, 13 Dec 2022 16:31:43 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
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
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v2 06/22] sched/fair: Collect load-balancing stats for
 IPC classes
Message-ID: <20221214003143.GB30234@ranerica-svr.sc.intel.com>
References: <20221128132100.30253-1-ricardo.neri-calderon@linux.intel.com>
 <20221128132100.30253-7-ricardo.neri-calderon@linux.intel.com>
 <Y5GlTwoe5spnxBYH@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5GlTwoe5spnxBYH@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 08:50:23AM +0000, Ionela Voinescu wrote:
> Hi,
> 
> On Monday 28 Nov 2022 at 05:20:44 (-0800), Ricardo Neri wrote:
> [..]
> >  
> > +struct sg_lb_ipcc_stats {
> > +	int min_score;	/* Min(score(rq->curr->ipcc)) */
> > +	int min_ipcc;	/* Min(rq->curr->ipcc) */
> 
> Nit: this is not the minimum IPCC between the current tasks of all
> runqueues, but the IPCC specific to the task with the minimum score.

> Possibly there's not much to be done about the variable name, but the
> comment can be made more clear.

Very true. I will make the change.

Thanks and BR,
Ricardo
