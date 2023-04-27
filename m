Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133D06F07B7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243824AbjD0Ov6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjD0Ov4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:51:56 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56454C5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 07:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682607115; x=1714143115;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=h2wDgROToYLVjyarVVgYuJhEUBJ2W62ONlj3SIeylx4=;
  b=GSMd9aUt/EjOTl20v52rIPeOq/BTrKIHXfMIkm4udPl4HaUYOk04AQbr
   xP4ghSlZE+yGVfwlDGYNn3bW/58AjLRdYqqvlNLyF/MmjIZbzDLxFWrt9
   Viq8jq34wihyvlYpCejEebEBZ2nJvz3NQfM4yRtPR/jMz55D4+zIpmP8R
   cqGLfhytt3BrLda8yqlt+YS9yjKkQyYauUubWaiSH15epqhJbp8gsi4lM
   yqjpCy3FOQ3qVyHNFz624j+UhZd9sdKEZTAcm7I4fZJMRgAb7+hgrGTy3
   i8aMUBNdfqzFWAMA0luAvXV+6fWuFZKvkNzXodnRUY2N6a+1Y773Alehu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="327787144"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="327787144"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 07:51:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="671812009"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="671812009"
Received: from mmaiores-mobl.ger.corp.intel.com ([10.251.215.69])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 07:51:48 -0700
Date:   Thu, 27 Apr 2023 17:51:46 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     James Morse <james.morse@arm.com>
cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com
Subject: Re: [PATCH v3 18/19] x86/resctrl: Add cpu offline callback for
 resctrl work
In-Reply-To: <e965ab8e-5277-d2c2-5174-2159f050a19f@arm.com>
Message-ID: <3a8a355-5d51-3c4-dd3b-21f1fb112ce6@linux.intel.com>
References: <20230320172620.18254-1-james.morse@arm.com> <20230320172620.18254-19-james.morse@arm.com> <988232ec-988f-5d12-eacb-8095d8c01eb6@linux.intel.com> <e965ab8e-5277-d2c2-5174-2159f050a19f@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1861291232-1682607114=:1971"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1861291232-1682607114=:1971
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 27 Apr 2023, James Morse wrote:

> Hi Ilpo,
> 
> On 21/03/2023 15:32, Ilpo Järvinen wrote:
> > On Mon, 20 Mar 2023, James Morse wrote:
> > 
> >> The resctrl architecture specific code may need to free a domain when
> >> a CPU goes offline, it also needs to reset the CPUs PQR_ASSOC register.
> >> The resctrl filesystem code needs to move the overflow and limbo work
> >> to run on a different CPU, and clear this CPU from the cpu_mask of
> >> control and monitor groups.
> >>
> >> Currently this is all done in core.c and called from
> >> resctrl_offline_cpu(), making the split between architecture and
> >> filesystem code unclear.
> >>
> >> Move the filesystem work into a filesystem helper called
> >> resctrl_offline_cpu(), and rename the one in core.c
> >> resctrl_arch_offline_cpu().
> >>
> >> The rdtgroup_mutex is unlocked and locked again in the call in
> >> preparation for changing the locking rules for the architecture
> >> code.
> >>
> >> resctrl_offline_cpu() is called before any of the resource/domains
> >> are updated, and makes use of the exclude_cpu feature that was
> >> previously added.
> 
> >> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> >> index aafe4b74587c..4e5fc89dab6d 100644
> >> --- a/arch/x86/kernel/cpu/resctrl/core.c
> >> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> >> @@ -578,22 +578,6 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
> >>  
> >>  		return;
> >>  	}
> >> -
> >> -	if (r == &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl) {
> >> -		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
> >> -			cancel_delayed_work(&d->mbm_over);
> >> -			/*
> >> -			 * exclude_cpu=-1 as this CPU has already been removed
> >> -			 * by cpumask_clear_cpu()d
> >> -			 */
> > 
> > This was added in 17/19 and now removed (not moved) in 18/19. Please avoid 
> > such back-and-forth churn.
> 
> This is the cost of making small incremental changes that should be easier to review.
> The intermediate step was a little odd, so came with a comment. (I normally mark those as
> 'temporary', but didn't bother this time as they are adjacent patches)

Why not mention the oddity at the end of changelog then? That keeps the 
diffs clean of temporary comments.

> If you'd prefer, I can merge these patches together... but from 
> Reinette's feedback its likely I'll split them up even more.

I don't prefer merging.

-- 
 i.

--8323329-1861291232-1682607114=:1971--
