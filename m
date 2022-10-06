Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2DB5F7162
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 00:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbiJFWt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 18:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbiJFWtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 18:49:25 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158BDB8C05
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 15:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665096565; x=1696632565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aDjej5/rJPN3I3tmGDUpLBewxj0Svrs1hq3whXtgYL0=;
  b=CaP5U3Gk4B02MevJJCabGVhP0jNb9PQebDUvnWvaTBnDF2pgxXUROPC+
   LCDt/38IiqgLXY9jkqSoWQNQAJ6VuqFWDRZ+wpiBmI10b9r0qZgqIoT2U
   VPR+rTMD4RdczW54IFGPzl4Q+KiBA6zNhygAL8QPU5eexLFLEGfnIERwK
   1GPrQjBYkcpfPC7HiY13nzH1C5fqVwWbfa4MPl5R9cAtoudnsltMqSt8t
   PeyvncEVusPHfzKO7iXFFwgtpznXBCgOXiu8mAAfMyr9zt1yP7BZIag6D
   3SCxuzxj0wr4VxZHu7Z63CfBIzOo33Oj17um93cWubjTWUwPQOQGYD42z
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="302311490"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="302311490"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 15:49:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="576012245"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="576012245"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga003.jf.intel.com with ESMTP; 06 Oct 2022 15:49:23 -0700
Date:   Thu, 6 Oct 2022 15:55:53 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
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
Subject: Re: [RFC PATCH 23/23] x86/process: Reset hardware history in context
 switch
Message-ID: <20221006225553.GB1624@ranerica-svr.sc.intel.com>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-24-ricardo.neri-calderon@linux.intel.com>
 <YzLyCD0P7MATFiVM@hirez.programming.kicks-ass.net>
 <20221003230758.GA22466@ranerica-svr.sc.intel.com>
 <Yz6TWL6zkD5Ee4/4@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz6TWL6zkD5Ee4/4@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 10:35:36AM +0200, Peter Zijlstra wrote:
> On Mon, Oct 03, 2022 at 04:07:58PM -0700, Ricardo Neri wrote:
> > On Tue, Sep 27, 2022 at 02:52:24PM +0200, Peter Zijlstra wrote:
> > > On Fri, Sep 09, 2022 at 04:12:05PM -0700, Ricardo Neri wrote:
> > > 
> > > > +void reset_hardware_history(void)
> > > > +{
> > > > +	if (!static_cpu_has(X86_FEATURE_HRESET))
> > > > +		return;
> > 
> > If I used cpu_feature_enabled(X86_FEATURE_ITD) along with the CONFIG_HFI_
> > THERMAL and its corresponding DISABLE_MASK bit the code below would be
> > compiled out.
> 
> Nobody cares about compiled out -- distro's must enable all this.

I see.

> So
> what counts is the code size, and the alternative is smaller.
> 
> > > > +
> > > > +	asm volatile("mov %0, %%eax;" __ASM_HRESET "\n" : :
> > > > +		     "r" (hardware_history_features) : "%rax");
> > > > +}
> > > 
> > > 	asm_inline volatile (ALTERNATIVE("", __ASM_HRESET, X86_FEATURE_HRESET)
> > > 			     : : "a" (hardware_history_features) : "memory");
> > 
> > Do you still prefer have implemented as an ALTERNATIVE?
> 
> Yes, look at the generated code.

I did compare the sizes of the two options as several NOPs are added at
the end. I will take your code.

Thanks and BR,
Ricardo
