Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696E55F5E6F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 03:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJFBoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 21:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJFBoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 21:44:03 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B5C7F08F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 18:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665020642; x=1696556642;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CneSLw/fFoLPlSnTLl0TJU6+uM4dil9z5AcF2EVouV8=;
  b=GlgVJY+H7BthealhunNNbqrgfg0nKOGCxPdh8ml8X5kX8i387Z2AOqsE
   UIBeoo2d8lDgp+BZrSgf1s7q23+KyQbtsM6M2LU2NqUykuhv+4i7ctooJ
   oN7JwUmL+PrfGJm949UQH/IvP2WP/6VatiZrmwWfTqUwgZCafG+hqhzsw
   LIVtEawGgEfeYhXqCRJPZJGnvjl9gU/eQ1O9ubvuRcAydbLH5QtaeZNLS
   ZjEPKjVMaY3T7OCRvuXRMXz+iZp0PnrS/vq7Hq+VrMEf/10fOu19QYtLs
   LT2Blo8XdVuheFXESd7JJDibLkcpqQJJ6Mymy320CG3ycb2Kcxsba9k06
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="367445634"
X-IronPort-AV: E=Sophos;i="5.95,162,1661842800"; 
   d="scan'208";a="367445634"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 18:44:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="626823519"
X-IronPort-AV: E=Sophos;i="5.95,162,1661842800"; 
   d="scan'208";a="626823519"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga007.fm.intel.com with ESMTP; 05 Oct 2022 18:44:01 -0700
Date:   Wed, 5 Oct 2022 18:50:30 -0700
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
Subject: Re: [RFC PATCH 17/23] thermal: intel: hfi: Enable the Intel Thread
 Director
Message-ID: <20221006015030.GC29251@ranerica-svr.sc.intel.com>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-18-ricardo.neri-calderon@linux.intel.com>
 <YzLl5+yMUrrGiphr@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzLl5+yMUrrGiphr@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 02:00:39PM +0200, Peter Zijlstra wrote:
> On Fri, Sep 09, 2022 at 04:11:59PM -0700, Ricardo Neri wrote:
> 
> > +config INTEL_THREAD_DIRECTOR
> > +	bool "Intel Thread Director"
> > +	depends on INTEL_HFI_THERMAL
> > +	depends on SMP
> > +	select SCHED_TASK_CLASSES
> > +	help
> > +	  Select this option to enable the Intel Thread Director. If selected,
> > +	  hardware classifies tasks based on the type of instructions they
> > +	  execute. It also provides performance capabilities for each class of
> > +	  task. On hybrid processors, the scheduler uses this data to place
> > +	  tasks of classes of higher performance on higher-performnance CPUs.
> 
> Do we really need yet another CONFIG symbol for all this!? AFAICT this
> Thread Director crud simply extends the HFI table and doesn't actually
> carry that much code with it.
> 
> Best to always have it on when HFI is on, no?

I decided to add CONFIG_INTEL_THREAD_DIRECTOR mainly to select CONFIG_IPC_
CLASS and have the needed members of task_struct only when needed. Legacy,
classless, HFI can work with the Thread Director part on some processors
(e.g., Sapphire Rapids or, FWIW, Lakefield).

I could get rid of CONFIG_INTEL_THREAD_DIRECTOR and instead wrap the Thread
Director code in an #ifdef(CONFIG_IPC_CLASS) block instead.

Thanks and BR,
Ricardo
