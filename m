Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605297430AF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 00:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbjF2WkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 18:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbjF2Wj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 18:39:56 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E0A359E
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 15:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688078381; x=1719614381;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ur0LSLrGMzGqTlgNMlPlfCzPuJql2NDXTGyIc4TyJy4=;
  b=IMEAssfjZHtYrTEV5B0zkm5NeDE8HxnxCLF7T7tfQhZVnnFJC90Zp9kG
   DqDDeog4DHssgC3P2M1NUbpfpWyONcAQzjKb66WZr8OBYSFJ+AzGIuyCF
   +XjpLnWppy/O0iCjuzNWHb5AHldtM7QzlHwUaiscQnoxP7b/htSrXXAOr
   Rqq/tD+VBsMVXBNmTV7N8+c0jSwFZ5AetbU3uMg7H96WzmCFDJXhoZCxW
   NJyrsnIGLh+7qcX1KgV/kAFqxDYXbWxnM/yjMcnGR/b5Govefhp5s2Ntk
   ASb8BcTKCmA4yt03m2MAYYzwCbm/0LQltII8GUPr9c2oiQHeRgQ/XRrhI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="341834050"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="341834050"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 15:39:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="807520478"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="807520478"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 15:39:40 -0700
Date:   Thu, 29 Jun 2023 15:39:39 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "irogers@google.com" <irogers@google.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "alexey.v.bayduraev@linux.intel.com" 
        <alexey.v.bayduraev@linux.intel.com>,
        "Zhang, Tinghao" <tinghao.zhang@intel.com>
Subject: Re: [PATCH V2 1/6] perf/x86/intel: Add Grand Ridge and Sierra Forest
Message-ID: <ZJ4IK/Rybg8f05Nb@agluck-desk3>
References: <20230522113040.2329924-1-kan.liang@linux.intel.com>
 <20230522202659.GC3334667@hirez.programming.kicks-ass.net>
 <SJ1PR11MB608367DC5D25856073C86FCFFC53A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230608072420.GB998233@hirez.programming.kicks-ass.net>
 <SJ1PR11MB608366EC800DBE389EE75E0CFC50A@SJ1PR11MB6083.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB608366EC800DBE389EE75E0CFC50A@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 04:20:22PM +0000, Luck, Tony wrote:
> > Then I'm hoping their take-away is that random gibberish names don't
> > help anybody. The whole Intel naming scheme is impenetrable crap.
> 
> > > +#define INTEL_FAM6_ATOM_CRESTMONT_X  0xAF /* Sierra Forest */
> > > +#define INTEL_FAM6_ATOM_CRESTMONT    0xB6 /* Grand Ridge */
> 
> This just adds another layer of confusion. Sure, these two models are based
> on the same core. But giving the illusion that they are somehow the same will
> lead to tears before bedtime:
> 
> 1) They each took a snapshot of that core design on different dates, so there
>    are logic differences.
> 2) Feature fuses will be different
> 3) Microcode will be different
> 4) BIOS will be different
> 5) "uncore" is different, so anything implemented outside of the core
>     will be different.

This thread stalled. But the internal conversation continued. There
seems a strong argument that enough things changed when Xeon-izing
the core to go into Sierra Forest that using Crestmont will cause
confusion in more places than it helps. There seem to be some internal
folks using an entirely different name for this core (which I won't
repeat here, but some of the usual external sites have mentions of
this other name).

Can we just keep:

#define INTEL_FAM6_SIERRAFOREST_X       0xAF

and move on to more interesting things?

-Tony
