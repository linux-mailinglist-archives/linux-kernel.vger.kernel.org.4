Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C01E738F46
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjFUSz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjFUSzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:55:04 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8F21BFA
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687373702; x=1718909702;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pf5fgctjx45R3UfviT/UvJYEIr1Ak00yCWhJ47HqjwE=;
  b=TOpbC0X+//sXWogR7mQa6iQaE9Ro2/PjlyGQvBRRvc5C3y9oij4Hwuxj
   UFmMbNT4OCxIhCYFsUMjXk1DMO9lmiNYiBAnbrYE4pG9T5VnafglprV62
   zdPUIrMeNILvRllMrDdHdz0VH0+PCl0ApsQpH2DdD/yG0CE8eGSmG8CI/
   yK5eXX6jTdzjbdMmHVqVJM7qAW3+6XTgUHd/YiMeSKxFDbYcD1tPsI8r0
   j/ji4499y4v8huZ/MGTzI3pPzX2ZELu8+itqKLU0E00XPsWwRvWAIXh3m
   A8O+toH+vGqtGg/M+mGdQb+A7vykjTO3Ce9XRR/mREM0nUKlnihlKdoR8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="360286297"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="360286297"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 11:55:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="888798351"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="888798351"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 21 Jun 2023 11:55:01 -0700
Date:   Wed, 21 Jun 2023 11:57:49 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, yu.c.chen@intel.com,
        tim.c.chen@intel.com
Subject: Re: [PATCH] sched/topology: remove unneeded do while loop in
 cpu_attach_domain()
Message-ID: <20230621185749.GA24063@ranerica-svr.sc.intel.com>
References: <20230617081926.2035113-1-linmiaohe@huawei.com>
 <20230620141120.GA2016469@hirez.programming.kicks-ass.net>
 <53a9ec35-8332-755c-40ed-54315ffb0d78@huawei.com>
 <20230621131159.GA23663@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621131159.GA23663@ranerica-svr.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 06:11:59AM -0700, Ricardo Neri wrote:
> On Wed, Jun 21, 2023 at 10:53:57AM +0800, Miaohe Lin wrote:
> > On 2023/6/20 22:11, Peter Zijlstra wrote:
> > > On Sat, Jun 17, 2023 at 04:19:26PM +0800, Miaohe Lin wrote:
> > >> When sg != sd->groups, the do while loop would cause deadloop here. But
> > >> that won't occur because sg is always equal to sd->groups now. Remove
> > >> this unneeded do while loop.
> > > 
> > > This Changelog makes no sense to me.. Yes, as is the do {} while loop is
> > > dead code, but it *should* have read like:
> > > 
> > > 	do {
> > > 		sg->flags = 0;
> > > 		sg = sg->next;
> > > 	} while (sg != sd->groups);
> 
> Yes, I agree that this is the correct solution.

I take this back. I think we should do this:

@@ -758,19 +758,14 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 		sd = sd->parent;
 		destroy_sched_domain(tmp);
 		if (sd) {
-			struct sched_group *sg = sd->groups;
-
 			/*
 			 * sched groups hold the flags of the child sched
 			 * domain for convenience. Clear such flags since
 			 * the child is being destroyed.
 			 */
-			do {
-				sg->flags = 0;
-			} while (sg != sd->groups);
+			sd->groups->flags = 0;
 
 			sd->child = NULL;
-		}
 	}
 
 	sched_domain_debug(sd, cpu);

A comment from Chenyu made got me thinking that we should only clear the
flags of the local group as viewed from the parent domain. This is because
the domain being degenerated defines the flags of such group only.

The current code does the right thing, but in a fortuitous and ugly manner.

Thanks and BR,
Ricardo
