Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4636C5F25D9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 00:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiJBWGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 18:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJBWGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 18:06:16 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8E92AE13
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 15:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664748375; x=1696284375;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Iw4+1zqCmhUd9iqKR6cKwO7Lhbcr3uBkBIw9lF3tY7M=;
  b=JbXZ3TPTQOX9L5MxX7qEzpLkBQg9PURvkZGNZUjviRwrtCTQ0eembOEL
   8jFLPAQQ8wMbMkf/o/J6iEqi0689QHqXrVjTMlW3ISXluO0Vtr6UE9AOc
   NAjN8Q3eKX7sQBFF/mZUPM3CD46eEvqlDfcF5ddZMO3Idh+X1J1kqdOgc
   qnQHX3ujDGmXk34TpIzTjonj7NQaG12Jl27iUluMN44pfv9NAnNL5Z1CW
   zsrPodfLMB5h0j5zeOqRTYRyp6rD11BzZut4PpcaQTJwHD3K+w6g+CrZ7
   jar7vt90ZMOWrIsHOvk80AX+FTNilMDEK1loNEJyDrxGUPWn5g+g40uGA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="328904859"
X-IronPort-AV: E=Sophos;i="5.93,363,1654585200"; 
   d="scan'208";a="328904859"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2022 15:06:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="623339898"
X-IronPort-AV: E=Sophos;i="5.93,363,1654585200"; 
   d="scan'208";a="623339898"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga002.jf.intel.com with ESMTP; 02 Oct 2022 15:06:14 -0700
Date:   Sun, 2 Oct 2022 15:12:38 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
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
Subject: Re: [RFC PATCH 23/23] x86/process: Reset hardware history in context
 switch
Message-ID: <20221002221238.GB17545@ranerica-svr.sc.intel.com>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-24-ricardo.neri-calderon@linux.intel.com>
 <YzL3g9MM3QwyfRer@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzL3g9MM3QwyfRer@zn.tnic>
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

On Tue, Sep 27, 2022 at 03:15:47PM +0200, Borislav Petkov wrote:
> On Fri, Sep 09, 2022 at 04:12:05PM -0700, Ricardo Neri wrote:
> > +void reset_hardware_history(void)
> > +{
> > +	if (!static_cpu_has(X86_FEATURE_HRESET))
> 
> In your whole patchset:
> 
> 	s/static_cpu_has/cpu_feature_enabled/g

Sure I can do this, Boris. I guess this implies that I also need to add the
DISABLE_MASK bits. Othewise, IIUC, cpu_feature_enabled() falls back to
static_cpu_has().

Thanks and BR,
Ricardo
