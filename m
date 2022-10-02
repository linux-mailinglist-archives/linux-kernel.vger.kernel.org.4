Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2985F2588
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 23:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiJBV4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 17:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiJBV4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 17:56:08 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443F925EAF
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 14:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664747767; x=1696283767;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MHXZOslfCcDE9hrF1V4VyXXTWYMqdv0k/V1937kqx5s=;
  b=W4zeYSzFWNumjCJgO+TjlHHu1bbGRweL4hOPNejN4U8qqlFPPlLdYimK
   tjafxTROWh95j0DR1SIqeRoPyWDi3ilN7xXhgsxF2jGm0UyyTcCBZ+F85
   ldQDAX53jlbPq4rt/EyY3oeRGN0bJyqXVuaNlhvN95Ukp12S6bfaAJ6VY
   cIWhkpk8hMn7XLGHSdbNxnkIz+R/36bY6VrwHNjSxEeLYgsRTJgQMRKDl
   qEIR2kyJNBqXcCSvmY2rg87Eqe8tDICLPKPE3G6U9lqkHcu8PmnZw1fJh
   FK9thv3SylIXuVousuhZqYwV93WUpoAgNJMsEoZf5nkdgnqo9Bx1100lJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="300114512"
X-IronPort-AV: E=Sophos;i="5.93,363,1654585200"; 
   d="scan'208";a="300114512"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2022 14:56:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="574433653"
X-IronPort-AV: E=Sophos;i="5.93,363,1654585200"; 
   d="scan'208";a="574433653"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga003.jf.intel.com with ESMTP; 02 Oct 2022 14:56:06 -0700
Date:   Sun, 2 Oct 2022 15:02:29 -0700
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
Message-ID: <20221002220229.GA17545@ranerica-svr.sc.intel.com>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-24-ricardo.neri-calderon@linux.intel.com>
 <YzLySV4545F0MKSl@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzLySV4545F0MKSl@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 02:53:29PM +0200, Peter Zijlstra wrote:
> On Fri, Sep 09, 2022 at 04:12:05PM -0700, Ricardo Neri wrote:
> > Reset the classification history of the current task when switching to
> > the next task. Hardware will start anew the classification of the next
> > running task.
> 
> Please quantify the cost of this HRESET instruction.

Sure Peter. I will.

Thanks and BR,
Ricardo
