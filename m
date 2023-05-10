Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E606FE835
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 01:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236709AbjEJXxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 19:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjEJXxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 19:53:37 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF70530CB;
        Wed, 10 May 2023 16:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683762816; x=1715298816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B8gaFsRPl8ORvNM8u4JxRsRYbbiKqqQCLApy/eIQQPI=;
  b=iYuTJh3AGWqAJIzwygUNpFP1g1/kZ68c7oiLgDHOIqKllQQI4O5WL9Pb
   IeAHJxmLAXgRrpdUDikmUCmAk2iCjmrPY2Q41qzgkP7SUeSPu4MpD4HGc
   0jt5lY7f5DaIam6t1rBdRrWenufy92JE9vV6T5BtJwUoH6wQA+5DmAUqa
   z0c+80OWt+hcxMDNneDNy63ujL0l7+48IUBexxiZYa+PU0QJcXYcQE6C2
   YnW7eHbckntNHh4bGryQTba4h4ZyAF7ikneCQ6fyiGtC/3K/Sjf2Il6TN
   h/gJRWX4IVAiWnbWOQH6wWu4Xn/CCudYCamg8gnLxfaCjkP6Q+Mr8oFq9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="413667161"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="413667161"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 16:53:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="873744960"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="873744960"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 10 May 2023 16:53:36 -0700
Date:   Wed, 10 May 2023 16:56:35 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Len Brown <len.brown@intel.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org
Subject: Re: [tip: perf/core] x86/cpu: Add helper function to get the type of
 the current hybrid CPU
Message-ID: <20230510235635.GC18514@ranerica-svr.sc.intel.com>
References: <1618237865-33448-3-git-send-email-kan.liang@linux.intel.com>
 <161891560955.29796.10811256921836669612.tip-bot2@tip-bot2>
 <55343361-d991-c157-4a88-843947aa45ff@intel.com>
 <20230510181815.GA18418@ranerica-svr.sc.intel.com>
 <25fe5313-97de-1528-e13e-f3b6286a8385@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25fe5313-97de-1528-e13e-f3b6286a8385@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 11:33:40AM -0700, Dave Hansen wrote:
> On 5/10/23 11:18, Ricardo Neri wrote:
> >> Sorry to dredge up an old thread.  But, where does this information
> >> about "If the processor is not hybrid, returns 0." come from?
> >>
> >> What is there to keep cpuid_eax(0x0000001a) from having 0x0 in those
> >> bits?  Seems to me like 0 is theoretically a valid hybrid CPU type.  Right?
> > My reasoning was that according to the Intel SDM the only valid values were
> > 0x20 and 0x40. 0 was meant to be an invalid value.
> 
> That doesn't make any sense to me really.  Just because today's SDM
> doesn't have a value doesn't mean that it becomes an invalid value tomorrow.
> 
> For instance, there's no model 0xEE today.  But that doesn't make it
> *INVALID*, it just means there's not one defined *today*.  Today's
> kernel shouldn't fall over if it runs on an model==0xEE system.

Yes, I agree. 0 may become a valid value tomorrow.

> 
> > I read the SDM again. It seems that cpuid_eax(0x0000001a) already returns
> > 0 when the leaf does not exist.
> 
> Right, but this isn't really relevant here either.  A CPU's APICID comes
> out of a leaf that can be unsupported (not exist).  That doesn't make
> APICID==0 invalid in any way.

But you always need an APICID, no? You would only need to get the CPU type
only when running on a hybrid CPU; from cpuid_eax(0x0000001a) or any other
future mechanism. Yes, I agree that is plausible to have 0 as the CPU type.

> 
> > Probably the check for X86_FEATURE_HYBRID_CPU is not needed.
> > 
> > Still, callers need to check for a valid value, IMO.
> 
> Right.  But if they're just going to check the number that comes back
> from this function, 0 can't represent an invalid value.

So maybe changing the function to return -ENOTSUP or -ENODEV on a non-hybrid
processor?
