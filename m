Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD1D5B9197
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 02:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiIOAWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 20:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiIOAWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 20:22:10 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C5B6C126
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 17:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663201330; x=1694737330;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DwH6r7kSYgXKu31Svcb7eDa7neWtWKabWhTS1u3DP5E=;
  b=k85wRzoLQXs9BGUDTz68vDHXfuDnD+usFjlTVohSK0Gn1S6ngkrgj1vP
   FgYdDBWKsV3idYdwx1SwllG/BYGPoU+XA8uO7aIooI53Xiq37uz5kSuiq
   Tftm91nwA9g2Cg5gidZsxoJPVO4dz23YzCyXOBmjZ4F52EM8iOBjLIBkZ
   e36uZXXUiJHEu+azZJxhnjRKxsn5nyFmYbvFIQQxa1Of25mbtOa1FTzTm
   OPheoHoTnYMcnzgDIzJksQSEAezq5y/8bw3aQ+cLdEWFZ7hSebfAKCtdW
   j1wovRClPFOjYRriXI0pQ0xc054f/gAA81cS7eGkaLtMs6Riti07ZCUv1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="299387625"
X-IronPort-AV: E=Sophos;i="5.93,316,1654585200"; 
   d="scan'208";a="299387625"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 17:22:09 -0700
X-IronPort-AV: E=Sophos;i="5.93,316,1654585200"; 
   d="scan'208";a="594599391"
Received: from schen9-mobl.amr.corp.intel.com ([10.209.26.213])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 17:22:09 -0700
Message-ID: <95bbbc9b927abf3c756e6cce810be69e85985541.camel@linux.intel.com>
Subject: Re: [PATCH v5 4/5] sched/fair: Skip SIS domain scan if fully busy
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Abel Wu <wuyun.abel@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 14 Sep 2022 17:22:09 -0700
In-Reply-To: <20220909055304.25171-5-wuyun.abel@bytedance.com>
References: <20220909055304.25171-1-wuyun.abel@bytedance.com>
         <20220909055304.25171-5-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-09-09 at 13:53 +0800, Abel Wu wrote:
> If a full domain scan failed, then no unoccupied cpus available
> and the LLC is fully busy.  In this case we'd better use cpus
> more wisely, rather than wasting it trying to find an idle cpu
> that probably not exist. The fully busy status will be cleared
> when any cpu of that LLC goes idle and everything goes back to
> normal again.
> 
> Make the has_idle_cores boolean hint more rich by turning it
> into a state machine.
> 
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>  include/linux/sched/topology.h | 35 +++++++++++++++++-
>  kernel/sched/fair.c            | 67 ++++++++++++++++++++++++++++------
>  2 files changed, 89 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index 816df6cc444e..cc6089765b64 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -77,10 +77,43 @@ extern int sched_domain_level_max;
>  
>  struct sched_group;
>  
> +/*
> + * States of the sched-domain
> + *
> + * - sd_has_icores
> + *	This state is only used in LLC domains to indicate worthy
> + *	of a full scan in SIS due to idle cores available.
> + *
> + * - sd_has_icpus
> + *	This state indicates that unoccupied (sched-idle/idle) cpus
> + *	might exist in this domain. For the LLC domains it is the
> + *	default state since these cpus are the main targets of SIS
> + *	search, and is also used as a fallback state of the other
> + *	states.
> + *
> + * - sd_is_busy
> + *	This state indicates there are no unoccupied cpus in this

Suggest reword to

.. indicates that all cpus are occupied in this ...

> + *	domain. So for LLC domains, it gives the hint on whether
> + *	we should put efforts on the SIS search or not.
> + *
> 

Tim

