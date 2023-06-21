Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466D2738477
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjFUNJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbjFUNJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:09:17 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA37E57
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687352955; x=1718888955;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JIwUV7sBVkEdx9YjGgjh7Oj2mRt4+yqUd+BrHNFkKOo=;
  b=k3stdDjsu8RBiDIIEm50JKrxNZDVWgNmBtYCA3tT5/iJ+nNghujXKPT5
   C2pEAZFvta3dy2Zl3wfkaecLK2PTQJNnFURSJxcEzOeMvpJtIjt54x4fG
   CwT0A84QMwOszR6PtbbjfF42skUVIHPZIyT0lUj/CW/mX+5XTyjt8HmHI
   lhfNNB0REVATLHR/oYU/uiYwrPHrmHfBxs0EFZ1K15FlV9SSmm4zLSPzv
   Th8h60lneIYBZbrQYrzdvXkRIGrJKYm8E6NzbEOwgz7uwLIEcXxGuYakK
   EeiQm5itg01hE1xS+zFNGovMO7yWcMDzG3mZ3F1quOm7ejcl81yyhJaOe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="423828370"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="423828370"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 06:09:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="714478988"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="714478988"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga002.jf.intel.com with ESMTP; 21 Jun 2023 06:09:12 -0700
Date:   Wed, 21 Jun 2023 06:11:59 -0700
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
Message-ID: <20230621131159.GA23663@ranerica-svr.sc.intel.com>
References: <20230617081926.2035113-1-linmiaohe@huawei.com>
 <20230620141120.GA2016469@hirez.programming.kicks-ass.net>
 <53a9ec35-8332-755c-40ed-54315ffb0d78@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53a9ec35-8332-755c-40ed-54315ffb0d78@huawei.com>
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

On Wed, Jun 21, 2023 at 10:53:57AM +0800, Miaohe Lin wrote:
> On 2023/6/20 22:11, Peter Zijlstra wrote:
> > On Sat, Jun 17, 2023 at 04:19:26PM +0800, Miaohe Lin wrote:
> >> When sg != sd->groups, the do while loop would cause deadloop here. But
> >> that won't occur because sg is always equal to sd->groups now. Remove
> >> this unneeded do while loop.
> > 
> > This Changelog makes no sense to me.. Yes, as is the do {} while loop is
> > dead code, but it *should* have read like:
> > 
> > 	do {
> > 		sg->flags = 0;
> > 		sg = sg->next;
> > 	} while (sg != sd->groups);

Yes, I agree that this is the correct solution.

> > 
> > as I noted here:
> > 
> >   https://lore.kernel.org/all/20230523105935.GN83892@hirez.programming.kicks-ass.net/T/#u

I apologize. I missed this e-mail.

> 
> [1]
> 
> > 
> > So what this changelog should argue is how there cannot be multiple
> > groups here -- or if there can be, add the missing iteration.
> 
> [1] said:
> "
> Yes, I missed that.
> 
> That being said, the only reason for sd to be degenerate is that there
> is only 1 group. Otherwise we will keep it and degenerate parents
> instead
> "

In the section of the code in question ,`sd` now points to the parent of the
sched group being degenerated. Thus, it may have more than one group, and we should
iterate over them to clear the flags.

> 
> IOW, "sg = sg->next;" is missed intentionally in the do while{} loop to show that
> there's only 1 sched group. This looks weird to me but no persist on change the code.

Not having `sg = sg->next;` is a bug, IMO.

Thanks and BR,
Ricardo 
