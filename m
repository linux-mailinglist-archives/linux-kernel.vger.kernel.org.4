Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4E172F0F4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 02:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbjFNA0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 20:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjFNA0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 20:26:20 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9966E172A;
        Tue, 13 Jun 2023 17:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686702379; x=1718238379;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b7UDhenxOy+WQBPj33/WSkU/4Hiv+kSwOlsYlkmSy7I=;
  b=hImMA3Y/teTwWYIz1ZOe5TG4ATkRAh7qPmDB2vrRGf8yI5eMwcTBWBDZ
   nFnLcWrdYJl/Vxqg4a4I85grHzLoziBfZ6a9Wi9jDgbsCmutm4PXiehDg
   aUvV0dSq43kLeS3FdjGV05bjAp6C0QJNWBG8L9kJj+4JaLvaQg97sHZ3f
   OtxFNu3cRVMjVDaYR9IE2aK6yu+RCuv2Ds5v0Lt+Y8dM1RfJloH2W+dvl
   8DxyxWRxCLqXFofwB/DtVhENrNGHnOKBRzby3CqUv4ZzOygmLPj2N6g2V
   EG4lsRYpwlfjGaSICBzuTcDq0OBAtMXXU2Of5UKC+qJ5zjAEJYlWba1aA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="348139934"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="348139934"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 17:26:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="958603898"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="958603898"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga006.fm.intel.com with ESMTP; 13 Jun 2023 17:26:17 -0700
Date:   Tue, 13 Jun 2023 17:29:08 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ricardo Neri <ricardo.neri@intel.com>,
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
        Lukasz Luba <lukasz.luba@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Zhao Liu <zhao1.liu@intel.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Tim C . Chen" <tim.c.chen@intel.com>,
        Zhao Liu <zhao1.liu@linux.intel.com>
Subject: Re: [PATCH v4 06/24] sched/fair: Collect load-balancing stats for
 IPC classes
Message-ID: <20230614002908.GA7443@ranerica-svr.sc.intel.com>
References: <20230613042422.5344-1-ricardo.neri-calderon@linux.intel.com>
 <20230613042422.5344-7-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613042422.5344-7-ricardo.neri-calderon@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 09:24:04PM -0700, Ricardo Neri wrote:
> +static int rq_last_task_ipcc(int dst_cpu, struct rq *rq, unsigned short *ipcc)
> +{
> +	struct list_head *tasks = &rq->cfs_tasks;
> +	struct task_struct *p;
> +	struct rq_flags rf;
> +	int ret = -EINVAL;
> +
> +	rq_lock_irqsave(rq, &rf);
> +	if (list_empty(tasks))
> +		goto out;
> +
> +	p = list_last_entry(tasks, struct task_struct, se.group_node);
> +	if (p->flags & PF_EXITING || is_idle_task(p) ||
> +	    !cpumask_test_cpu(dst_cpu, p->cpus_ptr))
> +		goto out;
> +
> +	ret = 0;
> +	*ipcc = p->ipcc;
> +out:
> +	rq_unlock(rq, &rf);

This should be rq_unlock_irqrestore(). I will correct it in the next version.
