Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67149671855
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 10:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjARJ7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 04:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjARJ5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 04:57:54 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFAA44BE1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 01:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674032856; x=1705568856;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DlLu1kd3RdoRwJ5tOhQx3lXAUHxd4RmhAiLGWWt9q9E=;
  b=Bwsk2Ta53FvOV/1dOq/DJZ1TL9JPP8TSN29mn+Z7hnud2m1oHGMhS8c3
   IdRQC7OoI3C7XrkkQDfZ3HB3RuU/V51QcXSBkog+4WxcnCvXsdgN/a5YH
   4D3gCU77VaGZ9pX67yLfwqCwPyWd/ToJ+2vHQwsGxjgIvafrslOH4YayR
   j8AqMyPjPh80Lj9apf5hkYXP9GW3OeqEAeY/dM0AWbIxzZXjsV8QmpwWE
   C0TlwXFV6gAwrRUC2oWZPZ1zHz7nQV/fxseMZs5CLOFPEG4E0RCEftTVX
   GW/w/0xZlPt7+c2T+EJ764gA3hoFWP8/Y4cajr5tXwiqnialO/oj3U337
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="387287295"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="387287295"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 01:07:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="767666271"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="767666271"
Received: from tpalli-mobl.ger.corp.intel.com (HELO intel.com) ([10.252.54.209])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 01:07:27 -0800
Date:   Wed, 18 Jan 2023 10:07:24 +0100
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>
Subject: Re: [Intel-gfx] [PATCH] drm/i915/selftest: fix
 intel_selftest_modify_policy argument types
Message-ID: <Y8e2tBUUEF5o3E8G@ashyti-mobl2.lan>
References: <20230117163743.1003219-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117163743.1003219-1-arnd@kernel.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 05:37:29PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The definition of intel_selftest_modify_policy() does not match the
> declaration, as gcc-13 points out:
> 
> drivers/gpu/drm/i915/selftests/intel_scheduler_helpers.c:29:5: error: conflicting types for 'intel_selftest_modify_policy' due to enum/integer mismatch; have 'int(struct intel_engine_cs *, struct intel_selftest_saved_policy *, u32)' {aka 'int(struct intel_engine_cs *, struct intel_selftest_saved_policy *, unsigned int)'} [-Werror=enum-int-mismatch]
>    29 | int intel_selftest_modify_policy(struct intel_engine_cs *engine,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from drivers/gpu/drm/i915/selftests/intel_scheduler_helpers.c:11:
> drivers/gpu/drm/i915/selftests/intel_scheduler_helpers.h:28:5: note: previous declaration of 'intel_selftest_modify_policy' with type 'int(struct intel_engine_cs *, struct intel_selftest_saved_policy *, enum selftest_scheduler_modify)'
>    28 | int intel_selftest_modify_policy(struct intel_engine_cs *engine,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Change the type in the definition to match.
> 
> Fixes: 617e87c05c72 ("drm/i915/selftest: Fix hangcheck self test for GuC submission")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Andi

> ---
>  drivers/gpu/drm/i915/selftests/intel_scheduler_helpers.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/selftests/intel_scheduler_helpers.c b/drivers/gpu/drm/i915/selftests/intel_scheduler_helpers.c
> index 310fb83c527e..2990dd4d4a0d 100644
> --- a/drivers/gpu/drm/i915/selftests/intel_scheduler_helpers.c
> +++ b/drivers/gpu/drm/i915/selftests/intel_scheduler_helpers.c
> @@ -28,8 +28,7 @@ struct intel_engine_cs *intel_selftest_find_any_engine(struct intel_gt *gt)
>  
>  int intel_selftest_modify_policy(struct intel_engine_cs *engine,
>  				 struct intel_selftest_saved_policy *saved,
> -				 u32 modify_type)
> -
> +				 enum selftest_scheduler_modify modify_type)
>  {
>  	int err;
>  
> -- 
> 2.39.0
