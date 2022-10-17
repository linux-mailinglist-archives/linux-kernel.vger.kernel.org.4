Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83AF600B87
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbiJQJs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiJQJsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:48:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E36E5E30C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666000086; x=1697536086;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8avkb8niqXxOei1jYk0QQPKLA+dnwojk9iKaLNjUT+Y=;
  b=Y/7k6SqYYPvxIoCbM6Oy51dsVYAEJdbKX/5PCJKBhCAiOA3KnAGDv3G9
   DVG6p20M+aNMGYf5rSsze98c94iV9ICeelKtwzfBGXZ4H0ChdpGIqi6JA
   OHiEV1CoqBwwS2KuMMJhKLA7nCaRQIiKOxCMw6AV38QyWZpkgYWraGAqx
   5h/WwVmj5cfAaGz1prNpPaOTAkhgUh86Yh+GDLF7k5pg7Ib1ihcSoaI8C
   PWwuHSMXZtWUbRodshMR6PN27PwtXnyM0cJl1FN8wFOl1rdsQ6eo/9h02
   kWuVtiMhYNVuvgiPTbpvW3urSk6x2tApnJEjt7i4Dgs/Nmwk4wa9rcONc
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="332286070"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="332286070"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 02:48:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="753576169"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="753576169"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost) ([10.239.160.132])
  by orsmga004.jf.intel.com with ESMTP; 17 Oct 2022 02:47:59 -0700
Date:   Mon, 17 Oct 2022 17:53:34 +0800
From:   Zhao Liu <zhao1.liu@linux.intel.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthew Auld <matthew.auld@intel.com>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Zhenyu Wang <zhenyu.z.wang@intel.com>,
        Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3] x86/hyperv: Replace kmap() with kmap_local_page()
Message-ID: <Y00mHsbkoxRDtpJB@liuzhao-OptiPlex-7080>
References: <20221017093726.2070674-1-zhao1.liu@linux.intel.com>
 <20221017093726.2070674-11-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017093726.2070674-11-zhao1.liu@linux.intel.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, please ignore the last hyperv patch, I made a mistake.

Zhao

On Mon, Oct 17, 2022 at 05:37:26PM +0800, Zhao Liu wrote:
> Date: Mon, 17 Oct 2022 17:37:26 +0800
> From: Zhao Liu <zhao1.liu@linux.intel.com>
> Subject: [PATCH v3] x86/hyperv: Replace kmap() with kmap_local_page()
> X-Mailer: git-send-email 2.34.1
> 
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> kmap() is being deprecated in favor of kmap_local_page()[1].
> 
> There are two main problems with kmap(): (1) It comes with an overhead as mapping space is restricted and protected by a global lock for synchronization and (2) it also requires global TLB invalidation when the kmap's pool wraps and it might block when the mapping space is fully utilized until a slot becomes available.
> 
> With kmap_local_page() the mappings are per thread, CPU local, can take page faults, and can be called from any context (including interrupts).
> It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore, the tasks can be preempted and, when they are scheduled to run again, the kernel virtual addresses are restored and are still valid.
> 
> Since its use in hyperv/hv_init.c is safe, it should be preferred.
> 
> Therefore, replace kmap() with kmap_local_page() in hyperv/hv_init.c.
> 
> [1]: https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com
> 
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> 
> ---
> Suggested by credits.
>         Ira: Referred to his task documentation and review comments.
>         Fabio: Stole some of his boiler plate commit message.
> 
> ---
> Changelog:
> v2:
> - Fix wrong incoming parameters in kunmap_local();
> - Add Fabio as suggester since I quoted his commit message.
> 
> ---
>  arch/x86/hyperv/hv_init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 3de6d8b53367..72fe46eb183f 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -459,13 +459,13 @@ void __init hyperv_init(void)
>                 wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> 
>                 pg = vmalloc_to_page(hv_hypercall_pg);
> -               dst = kmap(pg);
> +               dst = kmap_local_page(pg);
>                 src = memremap(hypercall_msr.guest_physical_address << PAGE_SHIFT, PAGE_SIZE,
>                                 MEMREMAP_WB);
>                 BUG_ON(!(src && dst));
>                 memcpy(dst, src, HV_HYP_PAGE_SIZE);
>                 memunmap(src);
> -               kunmap(pg);
> +               kunmap_local(dst);
>         } else {
>                 hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
>                 wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> --
> 2.34.1
> 
