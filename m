Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200435F397B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 01:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiJCXBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 19:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiJCXBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 19:01:42 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB062ED78
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 16:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664838101; x=1696374101;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=muuANMECUEDmO+1t1SFu3tGfsruvySWM43MOZGsQRjY=;
  b=gyRrObnRKSCa/wmLAHGCsbJBCHtXlrVg+V/KKv9fQqZAPASD5hMpizwX
   8bPb2m0TIuuAVeoNqNwKwjLSTVqvool5TN2Ew/POK+KyjC2Y5fnJq8r3L
   r/p6GS3u8krjbXj7JDmphMAX+fbBFw+Nb1plZVW1mFc1uCPzjH6ro84Gp
   FweqPMtPSFhPihny+oCJgYXb8OHmV+cUF6GiIUxHFEheI9Mzbd9pNSuoV
   BdhqDx6PM/gEo3VqWlER2f+aGWd6putmiC8f7nDEDXS2coQLOzMBLYJOI
   188MjTxvd3ZYZr7rYYWh6sJzIMUFkmf5X0J20qsUFAd8LPSaJvRevL3Us
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="329181044"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="329181044"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 16:01:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="601415648"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="601415648"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga006.jf.intel.com with ESMTP; 03 Oct 2022 16:01:33 -0700
Date:   Mon, 3 Oct 2022 16:07:58 -0700
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
Message-ID: <20221003230758.GA22466@ranerica-svr.sc.intel.com>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-24-ricardo.neri-calderon@linux.intel.com>
 <YzLyCD0P7MATFiVM@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzLyCD0P7MATFiVM@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 02:52:24PM +0200, Peter Zijlstra wrote:
> On Fri, Sep 09, 2022 at 04:12:05PM -0700, Ricardo Neri wrote:
> 
> > +void reset_hardware_history(void)
> > +{
> > +	if (!static_cpu_has(X86_FEATURE_HRESET))
> > +		return;

If I used cpu_feature_enabled(X86_FEATURE_ITD) along with the CONFIG_HFI_
THERMAL and its corresponding DISABLE_MASK bit the code below would be
compiled out.

> > +
> > +	asm volatile("mov %0, %%eax;" __ASM_HRESET "\n" : :
> > +		     "r" (hardware_history_features) : "%rax");
> > +}
> 
> 	asm_inline volatile (ALTERNATIVE("", __ASM_HRESET, X86_FEATURE_HRESET)
> 			     : : "a" (hardware_history_features) : "memory");

Do you still prefer have implemented as an ALTERNATIVE?

Thanks and BR,
Ricardo
> 
