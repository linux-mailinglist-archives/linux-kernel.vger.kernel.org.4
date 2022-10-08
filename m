Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40555F8196
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 02:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiJHAb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 20:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiJHAb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 20:31:56 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA2368894
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 17:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665189115; x=1696725115;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MGr+5GGn31ZOVdNFuFKVoGttGiCffzSYNuG9a5ncrYY=;
  b=Kx6zg7xgfPLG2TpxAb3/SiXn484eIrxxfWxie95sS+FUfkWHXC7ynZSz
   XP3Oskw/QhafW2CemfbWOft3ApzRzHBGcVgwT/wd3jCZ/trBgzqruX9Np
   Nmfu+Fh2sUTgKJd9Ru2CWsv0tEnOuHSPYh7AYWOGTykZsProNM7juRhaL
   n+Uwa7g7UT+0XlHb0ko3l9eTQXMHq6lgi/LvwvZGw3Rdo+wVaDPlBEVht
   GDEJwz68yGQs4u5waKI2aX1/jrU/6ft2g5jpcmKLK8fUij5LOFXSE+St4
   56cEyHIqjYK63Xtg3TcOTDzoqdXwvbeHMzLs1YJLdkJt61hZarBfLcwCB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="305455512"
X-IronPort-AV: E=Sophos;i="5.95,168,1661842800"; 
   d="scan'208";a="305455512"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 17:31:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="656252829"
X-IronPort-AV: E=Sophos;i="5.95,168,1661842800"; 
   d="scan'208";a="656252829"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga008.jf.intel.com with ESMTP; 07 Oct 2022 17:31:54 -0700
Date:   Fri, 7 Oct 2022 17:38:26 -0700
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
Subject: Re: [RFC PATCH 18/23] sched/task_struct: Add helpers for task
 classification
Message-ID: <20221008003826.GA6663@ranerica-svr.sc.intel.com>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-19-ricardo.neri-calderon@linux.intel.com>
 <YzLj+Gzy6Au5Pf+F@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzLj+Gzy6Au5Pf+F@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 01:52:24PM +0200, Peter Zijlstra wrote:
> On Fri, Sep 09, 2022 at 04:12:00PM -0700, Ricardo Neri wrote:
> 
> >  #ifdef CONFIG_SCHED_TASK_CLASSES
> >  	short				class;
> > +	short				class_candidate;
> > +	char				class_debounce_counter;
> >  #endif

> 
> That's 5 bytes; is that really needed? 4 would be so much better :-)

It can probably be implemented as:

u32	class : 9,
	class_candidate : 9,
	class_debounce_counter : 14;

9 bits accommodate the 256 possible classes + 'unclassified' that the
existing hardware can support (I doubt there will ever be this many
classes). The remainder bits can be used for debouncing, or even have
some reserved for future use.

Thanks and BR,
Ricardo
