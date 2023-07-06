Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE77B74A7D6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 01:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjGFXiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 19:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGFXiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 19:38:19 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511D81BE9;
        Thu,  6 Jul 2023 16:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688686698; x=1720222698;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0JKvud1PQdDP/vY9wglSJ4Q5ihblqLm8EVHVndBkp7Y=;
  b=d1jzLILO73L2R7BUXqAgjMhI0WKZe4bZ11FS102lu4ZwtmcYwTAEZ0wu
   uJ+7x54sesy4Wv+wTcNONGg5n8j9rvdrotcZBURS934ehcMzfR67TDLsS
   kPHmAjRza8/MKeSDELl3Opjy5nw+qjzVwCeXeV0aCJejOHRbuEac71dr4
   1nYgMHX/DP4SbMTNDsNG/wqOJLKFPx4DF6faMUrIqmCT4hI37BfGdMJsM
   RfUNP+7Pi4tOoSqMpQHOHL3LUb1KLYz1VgR/mdAgvIn9pdEX7s0u94cqx
   yHSIoCaqV/hEqZfI+tnXiBq61fHR6wKVGTJ0x7QFQkfg7zjUaeCADDN8d
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="348550714"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="348550714"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 16:38:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="754927658"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="754927658"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga001.jf.intel.com with ESMTP; 06 Jul 2023 16:38:15 -0700
Date:   Thu, 6 Jul 2023 16:40:59 -0700
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
Subject: Re: [PATCH v4 06/24] sched/fair: Collect load-balancing stats for
 IPC classes
Message-ID: <20230706234058.GC12259@ranerica-svr.sc.intel.com>
References: <20230613042422.5344-1-ricardo.neri-calderon@linux.intel.com>
 <20230613042422.5344-7-ricardo.neri-calderon@linux.intel.com>
 <ZJQN/KIwCUmzYoiN@arm.com>
 <20230624000121.GA32639@ranerica-svr.sc.intel.com>
 <d211d4dedd79330412e71a8b9b4b599cfe0fc80c.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d211d4dedd79330412e71a8b9b4b599cfe0fc80c.camel@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 12:52:59PM -0700, Tim Chen wrote:
> 
> > > 
> > > nit: the comment is unnecessary, and a bit misleading, IMO.
> > > 
> > > The comment says "This group will not be selected." but the only way to
> > > guarantee that here is to reset the sum_score to 0 when you find an
> > > invalid score, which I don't believe is your intention.
> > 
> > You raise an interesting point. We will call this function for each rq
> > in the sched group. Thus, if we encounter an error, the scores would be
> > incomplete. Therefore, I think that the scores should be discarded and
> > reset to 0 so that they are not used, IMO.
> 
> Since we still have other rqs to loop through, reset to 0 here does
> not guarantee that it will stay that way at the end of the loop when
> the sum could still be added to.

That is true, to discard the would need an indication that we should not
keep iterating on the runqueues of this group.

> May need a special value like -EINVAL
> and make the score a "long" to mark such case.

IIUC, unsigned longs allow to handle negative errors if you use
IS_ERR_VALUE(); but yes, it looks odd.
