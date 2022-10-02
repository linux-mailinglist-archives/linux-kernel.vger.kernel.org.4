Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51535F25F6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 00:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiJBW17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 18:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJBW1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 18:27:51 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED63386A1
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 15:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664749670; x=1696285670;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TSDggt/99x9ixInI7zumbE5IwAvMHd8AzIldWjkqUfs=;
  b=RZbGBdpytc73AZzAwn3Emi2r6S/3P+mDHB5mplpAdk/wasbArvk7GJGG
   eX02mf9/hH3TvqFFoPSNIuWVg8i8c1WYxoI/28wCUWAC+hqTFnmMzqdvb
   WLouwhmnNZtfMOkaS/zJ9fc0YvLILKxteRH8S8BSIOrVqzBmNrC3VD73B
   lUGpc2WIV9FMXqcJXcd/VCKlnQXecpzhBn2LqVGSpNETsl9CFahFI3T5t
   VLNNY/sT+eaflt3rj+BDcSDllk7fye3CH8JTqExHBlnqtO1yKYAw/vkJY
   F+jg5YvNJEJ79O7BEHemWMVZOaJfr873nymzYIt2muTtXtvpkskJeJJkG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="304001394"
X-IronPort-AV: E=Sophos;i="5.93,363,1654585200"; 
   d="scan'208";a="304001394"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2022 15:27:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="952143147"
X-IronPort-AV: E=Sophos;i="5.93,363,1654585200"; 
   d="scan'208";a="952143147"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga005.fm.intel.com with ESMTP; 02 Oct 2022 15:27:49 -0700
Date:   Sun, 2 Oct 2022 15:34:13 -0700
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
Subject: Re: [RFC PATCH 22/23] x86/hreset: Configure history reset
Message-ID: <20221002223413.GA17697@ranerica-svr.sc.intel.com>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-23-ricardo.neri-calderon@linux.intel.com>
 <YzLmr/vmYZozeUKm@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzLmr/vmYZozeUKm@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 02:03:59PM +0200, Peter Zijlstra wrote:
> On Fri, Sep 09, 2022 at 04:12:04PM -0700, Ricardo Neri wrote:
> 
> > +static u32 hardware_history_features __read_mostly;
> 
> __ro_after_init ?

Yes! You are correct. the HRESET features are only set once.

Thanks and BR,
Ricardo
