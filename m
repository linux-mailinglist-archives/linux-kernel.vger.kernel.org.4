Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1CE69AFA0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 16:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjBQPiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 10:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBQPiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 10:38:15 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF2D2DE6C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 07:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676648293; x=1708184293;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X26e8b0g6ZPM1b6qRKKlWoMgyn99l7tXNd6l77XcLs4=;
  b=RFVJ5JBLghuvKPCdUfiMa1d02OJL4T9uHZ9aPu+QsTPCEJMYTX6U7C1B
   haAPyPsfLgj0US60FI17VBTr3lrzDilKbjht03VXn9r3cEhGP6rGf0B+8
   rs571hXOMKl1Waws969vNgtXbQBp49oQGUfPElnO1tbBEUoVeyX5Ixh8L
   rEO2qk5UOq3xvjV8lCjUIvUn67/MN2edUoAWhzrjJ4d3GVicRerxtdSJL
   /Uo85AmEqD4oXaUjiOhr9YEB3FzapE9ti69EktC/ushgBUo9e+gAxNDKu
   /zq424cXvT66+DnZPlITSm9r7WajuUC1Rc0QL7y/QIy8uSyWOnlWreNo7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="394486577"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="394486577"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 07:38:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="734350979"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="734350979"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.213.3.117]) ([10.213.3.117])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 07:38:09 -0800
Message-ID: <c830e0c7-a483-aaf6-cd46-e26c8c414b6b@intel.com>
Date:   Fri, 17 Feb 2023 16:38:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [Intel-gfx] [PATCH] drm/i915/guc: avoid FIELD_PREP warning
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthew Brost <matthew.brost@intel.com>,
        John Harrison <John.C.Harrison@Intel.com>,
        Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
References: <20230217124724.1324126-1-arnd@kernel.org>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20230217124724.1324126-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.02.2023 13:46, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> With gcc-7 and earlier, there are lots of warnings like
> 
> In file included from <command-line>:0:0:
> In function '__guc_context_policy_add_priority.isra.66',
>      inlined from '__guc_context_set_prio.isra.67' at drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:3292:3,
>      inlined from 'guc_context_set_prio' at drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:3320:2:
> include/linux/compiler_types.h:399:38: error: call to '__compiletime_assert_631' declared with attribute error: FIELD_PREP: mask is not constant
>    _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>                                        ^
> ...
> drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:2422:3: note: in expansion of macro 'FIELD_PREP'
>     FIELD_PREP(GUC_KLV_0_KEY, GUC_CONTEXT_POLICIES_KLV_ID_##id) | \
>     ^~~~~~~~~~
> 
> Make sure that GUC_KLV_0_KEY is an unsigned value to avoid the warning.

Does it mean __builtin_constant_p in gcc7 returns 0 on signed constants?
I guess there should be more similar errors.

Regards
Andrzej


> 
> Fixes: 77b6f79df66e ("drm/i915/guc: Update to GuC version 69.0.3")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h b/drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h
> index 58012edd4eb0..4f4f53c42a9c 100644
> --- a/drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h
> +++ b/drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h
> @@ -29,9 +29,9 @@
>    */
>   
>   #define GUC_KLV_LEN_MIN				1u
> -#define GUC_KLV_0_KEY				(0xffff << 16)
> -#define GUC_KLV_0_LEN				(0xffff << 0)
> -#define GUC_KLV_n_VALUE				(0xffffffff << 0)
> +#define GUC_KLV_0_KEY				(0xffffu << 16)
> +#define GUC_KLV_0_LEN				(0xffffu << 0)
> +#define GUC_KLV_n_VALUE				(0xffffffffu << 0)
>   
>   /**
>    * DOC: GuC Self Config KLVs

