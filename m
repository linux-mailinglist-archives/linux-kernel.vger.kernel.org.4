Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713DF5F25F5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 00:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiJBW0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 18:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJBW0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 18:26:12 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416EF33844
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 15:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664749571; x=1696285571;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dQxO+JBC1kjt6v99c2AfXYfHeIX+L/9f4bxyQd7rQIs=;
  b=SGkqH0vCoDzMAn16PIem4hbtY/dVl1CMLISemZjYIUIJVHLAobD1PgcU
   m2IY5kbmUEMdIHGM714RrW18uZct7K1p1RLHBzvsvfO8ChHg4MsSds9Bm
   vzNBkJ6HGwfQJhdVA9UsfQ6jdGEqCcYjPnVPHedzLXLOF7bkEZ5w9ygIl
   xLnGLZ16VXafhDLkXOH/svOPfn51bz01j1wZ6Nq6uanpn6XbgIcl9cfVs
   A0d6JLN4JQGHkcXmEIvd+fChofp5AqNDVi1y5n0OVBZ3mpk9AGUisfXJZ
   SkoYnGrRwWdZoV4syAB//oXqzh/3n3v1JOLwMOHO51gqqG9xCwLaOwKpl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="388803528"
X-IronPort-AV: E=Sophos;i="5.93,363,1654585200"; 
   d="scan'208";a="388803528"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2022 15:26:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="691857913"
X-IronPort-AV: E=Sophos;i="5.93,363,1654585200"; 
   d="scan'208";a="691857913"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga004.fm.intel.com with ESMTP; 02 Oct 2022 15:26:10 -0700
Date:   Sun, 2 Oct 2022 15:32:34 -0700
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
Subject: Re: [RFC PATCH 01/23] sched/task_struct: Introduce classes of tasks
Message-ID: <20221002223234.GA17621@ranerica-svr.sc.intel.com>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-2-ricardo.neri-calderon@linux.intel.com>
 <YyHbOqoH+V6FUY68@hirez.programming.kicks-ass.net>
 <20220916144112.GA29395@ranerica-svr.sc.intel.com>
 <YzL0E/8sz1viLau7@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzL0E/8sz1viLau7@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 03:01:07PM +0200, Peter Zijlstra wrote:
> On Fri, Sep 16, 2022 at 07:41:13AM -0700, Ricardo Neri wrote:
> 
> > At least on Intel processors, class 0 is a valid class. The scheduler needs to
> > have a notion of unclassified tasks and decide how to handle them, IMO.
> > 
> > Intel processors currently support 8-bit, unsigned classes. I doubt other
> > architectures will ever support more than 256 classes. Short can handle all the
> > possible classification values and also the unclassified case.
> > 
> > On the other hand, class 0 could be the default classification unless hardware
> > classifies differently. 0 would be special and need to be documented clearly.
> > This would work for Intel processors.
> 
> You can always do: class = hw_class + 1; that makes 0 'special' and the
> hardware class can be trivially reconstructed by subtracting 1.

This makes sense to me. I will implement as you suggest.

Thanks and BR,
Ricardo
