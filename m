Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DB464A754
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 19:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbiLLSm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 13:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbiLLSm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 13:42:28 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECF8192B8;
        Mon, 12 Dec 2022 10:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670870376; x=1702406376;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hOY+PVY/v4DYkDc4C97PdqkCHoMURrX76I77jZtDZkU=;
  b=lFYya4OAgY/OENhzxazfE47h5bzNBVLziOSj2NLRgcHTUFEDoIK0hNtI
   li3w9E+8SqPaBOsHLMPjk9ECDxFl0DogHFnl07xfzoBaOrrJc9qXHBuBW
   II0siSpscF95q+2X72JokC2yLGWR+VUoltf6I44Mrq/rlsp4dW0FebzLq
   0HaN4BvzUmn+I0fHbNeJA8xJ/1v/AoIR1olukVVMW4AeuM0Xt1Bm8kvDS
   fjJHXYSEHhewNjDgK7NxPowW/50RUjQypADYZBizsrD4/9Y1/85/VlsVj
   t6A7jJs1RdMOQ+Cc0ehoaoe1BvabbCHXb7dFx9ZD42KjmWDJ1VyQs2Cve
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="301350536"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="301350536"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 10:38:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="737072699"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="737072699"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Dec 2022 10:38:58 -0800
Date:   Mon, 12 Dec 2022 10:47:05 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v2 04/22] sched/core: Add user_tick as argument to
 scheduler_tick()
Message-ID: <20221212184705.GE27353@ranerica-svr.sc.intel.com>
References: <20221128132100.30253-1-ricardo.neri-calderon@linux.intel.com>
 <20221128132100.30253-5-ricardo.neri-calderon@linux.intel.com>
 <40ff1e4c-b128-c0d0-a024-e454e843ee46@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40ff1e4c-b128-c0d0-a024-e454e843ee46@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 01:21:47PM +0100, Dietmar Eggemann wrote:
> On 28/11/2022 14:20, Ricardo Neri wrote:
> > Differentiate between user and kernel ticks so that the scheduler updates
> > the IPC class of the current task during the latter.
> 
> Just to make sure ,,, 05/22 introduces `rq->curr` IPCC update during
> user_tick, i.e. the former?

Yes. Thank you for the catch!
