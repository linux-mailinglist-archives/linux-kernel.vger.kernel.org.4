Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6165F1F57
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 22:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiJAU0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 16:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiJAU0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 16:26:22 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD0A41995
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 13:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664655980; x=1696191980;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1mEVKTYWv5eS2CDrFkoAREIRnT6Os4xXgAOTnYNfDFI=;
  b=gKlIyp7yhm+ARGuFAnyaPYAhOVNI0MiY9sjPzU2hLv0KM6bB0+cXch2h
   9S0XdmwJNYCEKqFtrTeE3k8JjX2nCo7uYzBrEgvrrcrgjjAWoGIXyc7nW
   JeChIr6hFY9z0RCD7LrqaXYE8WobZUkymfLbVCIH9LRfwgVtaBV2F5ay4
   AWSdRls2VR95YcFgmVKAnTbXCfvsbnnTMDUZzJHNmBfN7/Ub0xIzMJcSA
   03C+LdtZTJ/jPWEFsv3CeYooIy5JFv9k0NPYtAltUn6ZhKrcY/LPiQXrV
   g1LDAXnPaqvjNW3ldhNRt2fHgj3H65trTr48zVyneR3Dhjqj3wgt9hik1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10487"; a="364259106"
X-IronPort-AV: E=Sophos;i="5.93,361,1654585200"; 
   d="scan'208";a="364259106"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2022 13:26:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10487"; a="727286257"
X-IronPort-AV: E=Sophos;i="5.93,361,1654585200"; 
   d="scan'208";a="727286257"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga002.fm.intel.com with ESMTP; 01 Oct 2022 13:26:19 -0700
Date:   Sat, 1 Oct 2022 13:32:41 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
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
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [RFC PATCH 03/23] sched/core: Initialize the class of a new task
Message-ID: <20221001203241.GA14536@ranerica-svr.sc.intel.com>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-4-ricardo.neri-calderon@linux.intel.com>
 <YzG92YDyBK/0W+5u@google.com>
 <YzL053SxqWUimANi@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzL053SxqWUimANi@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 03:04:39PM +0200, Peter Zijlstra wrote:
> On Mon, Sep 26, 2022 at 02:57:29PM +0000, Joel Fernandes wrote:
> 
> > > +#ifdef CONFIG_SCHED_TASK_CLASSES
> > > +	p->class			= TASK_CLASS_UNCLASSIFIED;
> > > +#endif
> > 
> > I find the term 'class' very broad and unclear what kind of class (without
> > further reading). So I am worried about how this generic term usage plays
> > with Linux source code in the long-term (like what if someone else comes up
> > with a usage of term 'class' that is unrelated to IPC.)
> 
> However much I like making a pain for people using C++ to compile the
> kernel, I do think ipcc might be better here
> (instructions_per_cycle_class for those of the novel per identifier
> school of thought).

Sure, I will use ippc
> 
> > To that end, I was wondering if it could be renamed to p->ipc_class, and
> > CONFIG_SCHED_TASK_IPC_CLASSES, or something.
> 
> Can we *please* shorten those thing instead of writing a novel?
> CONFIG_SCHED_IPC_CLASS works just as well, no? Or TASK_IPC, whatever.

... and avoid the novel-style identifiers :) .

Thanks and BR,
Ricardo
