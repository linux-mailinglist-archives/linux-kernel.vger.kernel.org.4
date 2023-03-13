Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB946B783E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjCMM7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjCMM65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:58:57 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1F95F21F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 05:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678712313; x=1710248313;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ifT8MX/bTD4Q1Z8VwFAcGqEIMYqX8jDuQXznu8H2bjU=;
  b=P67Et3K/fIEf9IwywD7dPID5LMv2CYDq7KJIhOHTfb5cPyrLYpcH9h+y
   U6ca/p5B0i5991YhrkKK7MM9swpSKAdmjdRf1tar7HcVyn/uqbD+XKBu/
   rycQHDD8NzN7Cp7kc8IxTrdYS2XalDdeIO8v/2R4ly5piqkcJyLxOKwos
   mUrgMPG3DteFklC0IQBKWM3vPvMQMxuHsyCUgWKjUa1aSbkQ7EwoJSItA
   5HA739VDDi4uqKp7ahn1YBDCW4N28fswSbdSnfr3h9NUw3SCA0gM8PUeg
   Uszg56oGelEYSZuQU3ft8ocs7JNqlTT062EE4nfaTY54TDME9yPkfubzP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="364799727"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400"; 
   d="scan'208";a="364799727"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 05:58:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="655964202"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="655964202"
Received: from nirmoyda-mobl.ger.corp.intel.com (HELO [10.252.33.220]) ([10.252.33.220])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 05:58:29 -0700
Message-ID: <9c7f3d9d-5ee7-1237-8dfa-4a0699659615@linux.intel.com>
Date:   Mon, 13 Mar 2023 13:58:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v6 1/2] drm/i915/gt: introduce vm->scratch_range callback
Content-Language: en-US
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Chris Wilson <chris.p.wilson@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>
References: <20230308-guard_error_capture-v6-0-1b5f31422563@intel.com>
 <20230308-guard_error_capture-v6-1-1b5f31422563@intel.com>
From:   "Das, Nirmoy" <nirmoy.das@linux.intel.com>
In-Reply-To: <20230308-guard_error_capture-v6-1-1b5f31422563@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/10/2023 10:23 AM, Andrzej Hajda wrote:
> The callback will be responsible for setting scratch page PTEs for
> specified range. In contrast to clear_range it cannot be optimized to nop.
> It will be used by code adding guard pages.
>
> Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
> ---
>   drivers/gpu/drm/i915/gt/intel_ggtt.c      | 23 +++++++++++++++++++++++
>   drivers/gpu/drm/i915/gt/intel_ggtt_gmch.c |  1 +
>   drivers/gpu/drm/i915/gt/intel_gtt.h       |  2 ++
>   3 files changed, 26 insertions(+)
>
> diff --git a/drivers/gpu/drm/i915/gt/intel_ggtt.c b/drivers/gpu/drm/i915/gt/intel_ggtt.c
> index 842e69c7b21e49..38e6f0b207fe0c 100644
> --- a/drivers/gpu/drm/i915/gt/intel_ggtt.c
> +++ b/drivers/gpu/drm/i915/gt/intel_ggtt.c
> @@ -291,6 +291,27 @@ static void gen8_ggtt_insert_entries(struct i915_address_space *vm,
>   	ggtt->invalidate(ggtt);
>   }
>   
> +static void gen8_ggtt_clear_range(struct i915_address_space *vm,
> +				  u64 start, u64 length)
> +{
> +	struct i915_ggtt *ggtt = i915_vm_to_ggtt(vm);
> +	unsigned int first_entry = start / I915_GTT_PAGE_SIZE;
> +	unsigned int num_entries = length / I915_GTT_PAGE_SIZE;
> +	const gen8_pte_t scratch_pte = vm->scratch[0]->encode;
> +	gen8_pte_t __iomem *gtt_base =
> +		(gen8_pte_t __iomem *)ggtt->gsm + first_entry;
> +	const int max_entries = ggtt_total_entries(ggtt) - first_entry;
> +	int i;
> +
> +	if (WARN(num_entries > max_entries,
> +		"First entry = %d; Num entries = %d (max=%d)\n",
> +		first_entry, num_entries, max_entries))
> +		num_entries = max_entries;
> +
> +	for (i = 0; i < num_entries; i++)
> +		gen8_set_pte(&gtt_base[i], scratch_pte);
> +}
> +
>   static void gen6_ggtt_insert_page(struct i915_address_space *vm,
>   				  dma_addr_t addr,
>   				  u64 offset,
> @@ -919,6 +940,7 @@ static int gen8_gmch_probe(struct i915_ggtt *ggtt)
>   	ggtt->vm.cleanup = gen6_gmch_remove;
>   	ggtt->vm.insert_page = gen8_ggtt_insert_page;
>   	ggtt->vm.clear_range = nop_clear_range;
> +	ggtt->vm.scratch_range = gen8_ggtt_clear_range;
>   
>   	ggtt->vm.insert_entries = gen8_ggtt_insert_entries;
>   
> @@ -1082,6 +1104,7 @@ static int gen6_gmch_probe(struct i915_ggtt *ggtt)
>   	ggtt->vm.clear_range = nop_clear_range;
>   	if (!HAS_FULL_PPGTT(i915))
>   		ggtt->vm.clear_range = gen6_ggtt_clear_range;
> +	ggtt->vm.scratch_range = gen6_ggtt_clear_range;
>   	ggtt->vm.insert_page = gen6_ggtt_insert_page;
>   	ggtt->vm.insert_entries = gen6_ggtt_insert_entries;
>   	ggtt->vm.cleanup = gen6_gmch_remove;
> diff --git a/drivers/gpu/drm/i915/gt/intel_ggtt_gmch.c b/drivers/gpu/drm/i915/gt/intel_ggtt_gmch.c
> index 77c793812eb46a..d6a74ae2527bd9 100644
> --- a/drivers/gpu/drm/i915/gt/intel_ggtt_gmch.c
> +++ b/drivers/gpu/drm/i915/gt/intel_ggtt_gmch.c
> @@ -102,6 +102,7 @@ int intel_ggtt_gmch_probe(struct i915_ggtt *ggtt)
>   	ggtt->vm.insert_page = gmch_ggtt_insert_page;
>   	ggtt->vm.insert_entries = gmch_ggtt_insert_entries;
>   	ggtt->vm.clear_range = gmch_ggtt_clear_range;
> +	ggtt->vm.scratch_range = gmch_ggtt_clear_range;
>   	ggtt->vm.cleanup = gmch_ggtt_remove;
>   
>   	ggtt->invalidate = gmch_ggtt_invalidate;
> diff --git a/drivers/gpu/drm/i915/gt/intel_gtt.h b/drivers/gpu/drm/i915/gt/intel_gtt.h
> index 5a775310d3fcb5..69ce55f517f567 100644
> --- a/drivers/gpu/drm/i915/gt/intel_gtt.h
> +++ b/drivers/gpu/drm/i915/gt/intel_gtt.h
> @@ -298,6 +298,8 @@ struct i915_address_space {
>   				  u64 start, u64 length);
>   	void (*clear_range)(struct i915_address_space *vm,
>   			    u64 start, u64 length);
> +	void (*scratch_range)(struct i915_address_space *vm,
> +			      u64 start, u64 length);
>   	void (*insert_page)(struct i915_address_space *vm,
>   			    dma_addr_t addr,
>   			    u64 offset,
>
