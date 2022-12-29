Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14069659097
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 19:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbiL2SyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 13:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiL2SyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 13:54:12 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023B413F8C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 10:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672340051; x=1703876051;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZPpoBY7AKspOfE/PKttPWIy3lT2+S2GUym63dW2u1Bk=;
  b=chtdHdEnTs5FtmF/Dcuc1GgqHzEY0DU4CTBIsG3m/LCdjh1ivflNEyur
   XwfJIbeSt+egm5QJ4cDIMPBDzhsWcIF5guZhpbu8y1YZihwejoJyWOjEE
   6Dz7K04du+UYAiNOrwo9qLpfCMJNRTNXHOUiB73bY5SCGOLWvyMzu1lZE
   eZWmG9Vg/pIKfrqF4v//NNECJTrO03r9o6EmgxF0AFdlKiMiGQvJ3g/87
   RfhE5Gmuxmh9K5Umef9iXftHVDvW74lNcM2wCTdXjlMiYLJuwaEyfrEvY
   y5j/w2QyutcDVcXPX31MosV1XyiEKqRqpPmt3zuQV7eNwraGzm/naGJn+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="323081026"
X-IronPort-AV: E=Sophos;i="5.96,285,1665471600"; 
   d="scan'208";a="323081026"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 10:54:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="722137843"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="722137843"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga004.fm.intel.com with ESMTP; 29 Dec 2022 10:54:09 -0800
Date:   Thu, 29 Dec 2022 11:02:49 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
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
        Tim Chen <tim.c.chen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v2 5/7] x86/sched: Remove SD_ASYM_PACKING from the "SMT"
 domain
Message-ID: <20221229190249.GA14462@ranerica-svr.sc.intel.com>
References: <20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com>
 <20221122203532.15013-6-ricardo.neri-calderon@linux.intel.com>
 <Y5IKuJTjE6Pjrw9I@arm.com>
 <20221214165900.GA972@ranerica-svr.sc.intel.com>
 <xhsmhwn6s62b5.mognet@vschneid.remote.csb>
 <20221220004238.GB23844@ranerica-svr.sc.intel.com>
 <xhsmhr0wre5rg.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhr0wre5rg.mognet@vschneid.remote.csb>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 04:56:51PM +0000, Valentin Schneider wrote:
> On 19/12/22 16:42, Ricardo Neri wrote:
> > On Thu, Dec 15, 2022 at 04:48:14PM +0000, Valentin Schneider wrote:
> >> With that said, so far all but one flag (SD_PREFER_SIBLING, and that's
> >> because of big.LITTLE woes) follow the SDF_SHARED_{CHILD, PARENT} pattern,
> >> if SD_ASYM_PACKING no longer does then we need to think whether we're
> >> trying to make it do funky things.
> >
> > My thesis is that x86 does not need the SD_ASYM_PACKING flag at the SMT
> > level because all SMT siblings are identical. There are cores of higher
> > priority at the "MC" level (maybe in the future at the "CLS" level).
> >
> > Power7 is fine because it only uses SD_ASYM_PACKING at the SMT level.
> >
> 
> So with what I groked from your series, I agree with you, x86 shouldn't
> need it at SMT level.
> 
> What about the below?
> 
> ---
> 
> diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
> index 57bde66d95f7a..8dc16942135b4 100644
> --- a/include/linux/sched/sd_flags.h
> +++ b/include/linux/sched/sd_flags.h
> @@ -132,12 +132,12 @@ SD_FLAG(SD_SERIALIZE, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
>  /*
>   * Place busy tasks earlier in the domain
>   *
> - * SHARED_CHILD: Usually set on the SMT level. Technically could be set further
> - *               up, but currently assumed to be set from the base domain
> - *               upwards (see update_top_cache_domain()).
> + * SHARED_PARENT: Usually set on the SMT level. Can be set further up if all
> + *                siblings of an SMT core are identical, but SMT cores themselves
> + *                have different priorites.
>   * NEEDS_GROUPS: Load balancing flag.
>   */
> -SD_FLAG(SD_ASYM_PACKING, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
> +SD_FLAG(SD_ASYM_PACKING, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)

But this would not work for Power7. It only has SD_ASYM_PACKING in the SMT
sched domain. Must it have either of these flags?

In Power7 SMT siblings have the different priority but, IIUC, physical
cores are identical.

It seems to me that asym_packing is specific to a domain.

Thanks and BR,
Ricardo
