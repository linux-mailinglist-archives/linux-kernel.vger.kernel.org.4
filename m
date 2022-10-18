Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D8960212B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiJRC3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiJRC3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:29:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EB294113
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666060142; x=1697596142;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m1JiaK/FEuNSd19PhWHZBeUN0AO92BjHPiKfuk8s/DE=;
  b=Br+XuIMcW6HUrDkOG3sRbtUsuUbQbDqtp+/M88oEqWhnXxKEGoFyPHZP
   Bti+tkxXxddvUJBYTKlvrf0PqR2SQR+RL0HjtZyEbGG8FgZ5pYy5v7O2L
   ur7t3EM3YRy3HU8+sk/+MockpvqCiLUHJdaM20kt5xoDGF8UuOwzqEDC5
   TMNPKifmZYqvsqhHXySIVA7V5g1zloylxo5TdMYAbV9Lc3zeU+tsCjxEE
   cCzfu5D9DoAuKPnGuOm6YDL8RrPuiOAiqgMTIMsWLjfKZn9WKqh2MKlf4
   6hiX2+vgs/fu4MEOL5Etw9FalVRDz5R3I0VP9TmCVHTI40gnb6ClLaQVM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="392279535"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="392279535"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 19:29:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="630922430"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="630922430"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga007.fm.intel.com with ESMTP; 17 Oct 2022 19:29:01 -0700
Date:   Mon, 17 Oct 2022 19:35:27 -0700
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
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] sched/fair: Avoid unnecessary migrations within SMT
 domains
Message-ID: <20221018023527.GB23064@ranerica-svr.sc.intel.com>
References: <20220825225529.26465-1-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825225529.26465-1-ricardo.neri-calderon@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 03:55:25PM -0700, Ricardo Neri wrote:
> Intel processors that support Intel Turbo Boost Max 3.0 use asym_packing
> to assign higher priorities to CPUs with higher maximum frequencies. It
> artificially assigns, however, a lower priority to the higher-numbered
> SMT siblings to ensure that they are used last.
> 
> This results in unnecessary task migrations within the SMT domains.
> 
> On processors with a mixture of higher-frequency SMT cores and lower-
> frequency non-SMT cores (such as Intel hybrid processors), a lower-
> priority CPU pulls tasks from the higher-priority cores if more than one
> SMT sibling is busy.
> 
> Do not use different priorities for each SMT sibling. Instead, tweak the
> asym_packing load balancer to recognize SMT cores with more than one
> busy sibling and let lower-priority CPUs pull tasks.
> 
> Removing these artificial priorities avoids superfluous migrations and
> lets lower-priority cores inspect all SMT siblings for the busiest queue.

Hello. I'd like to know if there are any comments on these patches. This
patchset is a requisite for the IPC classes of tasks patchset [1].

Thanks in advance!
Ricardo

[1]. https://lore.kernel.org/lkml/20220909231205.14009-5-ricardo.neri-calderon@linux.intel.com/T/
