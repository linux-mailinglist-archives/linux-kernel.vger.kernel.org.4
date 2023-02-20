Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B6169CB6B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 13:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjBTMwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 07:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjBTMwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 07:52:21 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242BB40CD
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 04:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676897517; x=1708433517;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=967pb3bxs0YkCizJHi05UwZ2dIQOSUkl3uF0lxY+PxU=;
  b=kzndUl8qz6WdevV/5U0bczJKPd0yFLVg2mZODgWv3rQHF3E2PmXAjSLl
   PUpjyMqwF7eQ+Js8UgRpPK+/rn2lu1c1wr4fff1vplATTyomLdlwL+d2P
   fYImmJuiefKfoFBc2TIMilZ+wGK13/lItgOuYz3weY/gLai7qpkJGrzWY
   JW1x8ikvT1mrnR9415srKlbUx17cnE6zqcbx3qShixaDe58JVtL2dPQVp
   IDp64VbWSR0dpXdBtQ8mbrG0OijSS9nqiVozvxmIzSa1S/tXoTLd5mDlP
   FtwK5WqYNlAyXUgolo2V71XnOYcXs5DoturQo4IzjVdLWq+JBndupEgkc
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="334592880"
X-IronPort-AV: E=Sophos;i="5.97,312,1669104000"; 
   d="scan'208";a="334592880"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 04:51:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="845314765"
X-IronPort-AV: E=Sophos;i="5.97,312,1669104000"; 
   d="scan'208";a="845314765"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga005.jf.intel.com with ESMTP; 20 Feb 2023 04:51:34 -0800
Received: from [10.249.130.22] (mwajdecz-MOBL.ger.corp.intel.com [10.249.130.22])
        by irvmail002.ir.intel.com (Postfix) with ESMTP id 133D837E14;
        Mon, 20 Feb 2023 12:51:32 +0000 (GMT)
Message-ID: <540d63d2-88ca-9d46-ffe6-4436026d0107@intel.com>
Date:   Mon, 20 Feb 2023 13:51:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH] drm/i915/guc: avoid FIELD_PREP warning
To:     Arnd Bergmann <arnd@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthew Brost <matthew.brost@intel.com>,
        John Harrison <John.C.Harrison@Intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230217124724.1324126-1-arnd@kernel.org>
Content-Language: en-US
From:   Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <20230217124724.1324126-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
>     inlined from '__guc_context_set_prio.isra.67' at drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:3292:3,
>     inlined from 'guc_context_set_prio' at drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:3320:2:
> include/linux/compiler_types.h:399:38: error: call to '__compiletime_assert_631' declared with attribute error: FIELD_PREP: mask is not constant
>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>                                       ^
> ...
> drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:2422:3: note: in expansion of macro 'FIELD_PREP'
>    FIELD_PREP(GUC_KLV_0_KEY, GUC_CONTEXT_POLICIES_KLV_ID_##id) | \
>    ^~~~~~~~~~
> 
> Make sure that GUC_KLV_0_KEY is an unsigned value to avoid the warning.
> 
> Fixes: 77b6f79df66e ("drm/i915/guc: Update to GuC version 69.0.3")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Michal Wajdeczko <michal.wajdeczko@intel.com>

> ---
>  drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h b/drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h
> index 58012edd4eb0..4f4f53c42a9c 100644
> --- a/drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h
> +++ b/drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h
> @@ -29,9 +29,9 @@
>   */
>  
>  #define GUC_KLV_LEN_MIN				1u
> -#define GUC_KLV_0_KEY				(0xffff << 16)
> -#define GUC_KLV_0_LEN				(0xffff << 0)
> -#define GUC_KLV_n_VALUE				(0xffffffff << 0)
> +#define GUC_KLV_0_KEY				(0xffffu << 16)
> +#define GUC_KLV_0_LEN				(0xffffu << 0)
> +#define GUC_KLV_n_VALUE				(0xffffffffu << 0)
>  
>  /**
>   * DOC: GuC Self Config KLVs
