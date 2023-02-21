Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B5069DC79
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 10:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbjBUJBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 04:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjBUJBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 04:01:37 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F3423D82
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 01:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676970091; x=1708506091;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dsRybd/64P4CVAO5ROi9YaEUYOfOwpiLG3nNgVfeZEk=;
  b=Fk19RVgl+uJm9z48aluxfNQyDDulbkG0s4ovLRvIjIO/77HGhiB9fOd6
   qiAMOufie8jWrZVkGJmkydl0bTOXW1aZd00G4V+lXSS/t1d8PM9DDGf1N
   AC+pVoSHdDbZ1MRQ993Z6S8HU9vagnKvXjs0evlRkmgBRGPiYs2jvffbJ
   QTbcw3tCc2+9hLGCXNcZWv0ExOdmeMYjKcZC/IAnlQkPdaU2qXH+7h1/q
   2sJkzXe+Ai82f06QQFPsx88yYWhHnkREbgSaM7RqgrXO/27cmR+vKzZ/T
   LFNscJU14ys+OXnfd3wKg6q3nMI3y2HtA2Glw0EmVzMOSl9UGO+fvN6gt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="395062796"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="395062796"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 01:01:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="703957679"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="703957679"
Received: from bpop-mobl.ger.corp.intel.com (HELO [10.213.229.230]) ([10.213.229.230])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 01:01:27 -0800
Message-ID: <c5edd07d-1535-9b25-9a48-3d71e5e22b07@linux.intel.com>
Date:   Tue, 21 Feb 2023 09:01:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] drm/i915/sseu: fix max_subslices
 array-index-out-of-bounds access
Content-Language: en-US
To:     Andrea Righi <andrea.righi@canonical.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Roper, Matthew D" <matthew.d.roper@intel.com>,
        Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>
Cc:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230220171858.131416-1-andrea.righi@canonical.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20230220171858.131416-1-andrea.righi@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/02/2023 17:18, Andrea Righi wrote:
> It seems that commit bc3c5e0809ae ("drm/i915/sseu: Don't try to store EU
> mask internally in UAPI format") exposed a potential out-of-bounds
> access, reported by UBSAN as following on a laptop with a gen 11 i915
> card:
> 
>    UBSAN: array-index-out-of-bounds in drivers/gpu/drm/i915/gt/intel_sseu.c:65:27
>    index 6 is out of range for type 'u16 [6]'
>    CPU: 2 PID: 165 Comm: systemd-udevd Not tainted 6.2.0-9-generic #9-Ubuntu
>    Hardware name: Dell Inc. XPS 13 9300/077Y9N, BIOS 1.11.0 03/22/2022
>    Call Trace:
>     <TASK>
>     show_stack+0x4e/0x61
>     dump_stack_lvl+0x4a/0x6f
>     dump_stack+0x10/0x18
>     ubsan_epilogue+0x9/0x3a
>     __ubsan_handle_out_of_bounds.cold+0x42/0x47
>     gen11_compute_sseu_info+0x121/0x130 [i915]
>     intel_sseu_info_init+0x15d/0x2b0 [i915]
>     intel_gt_init_mmio+0x23/0x40 [i915]
>     i915_driver_mmio_probe+0x129/0x400 [i915]
>     ? intel_gt_probe_all+0x91/0x2e0 [i915]
>     i915_driver_probe+0xe1/0x3f0 [i915]
>     ? drm_privacy_screen_get+0x16d/0x190 [drm]
>     ? acpi_dev_found+0x64/0x80
>     i915_pci_probe+0xac/0x1b0 [i915]
>     ...
> 
> According to the definition of sseu_dev_info, eu_mask->hsw is limited to
> a maximum of GEN_MAX_SS_PER_HSW_SLICE (6) sub-slices, but
> gen11_sseu_info_init() can potentially set 8 sub-slices, in the
> !IS_JSL_EHL(gt->i915) case.
> 
> Fix this by reserving up to 8 slots for max_subslices in the eu_mask
> struct.
> 
> Reported-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>

Looks like bug was probably introduced in:

Fixes: bc3c5e0809ae ("drm/i915/sseu: Don't try to store EU mask internally in UAPI format")
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>
Cc: <stable@vger.kernel.org> # v6.0+

Adding Matt to cross-check.

Regards,

Tvrtko

> ---
>   drivers/gpu/drm/i915/gt/intel_sseu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/intel_sseu.h b/drivers/gpu/drm/i915/gt/intel_sseu.h
> index aa87d3832d60..d7e8c374f153 100644
> --- a/drivers/gpu/drm/i915/gt/intel_sseu.h
> +++ b/drivers/gpu/drm/i915/gt/intel_sseu.h
> @@ -27,7 +27,7 @@ struct drm_printer;
>    * is only relevant to pre-Xe_HP platforms (Xe_HP and beyond use the
>    * I915_MAX_SS_FUSE_BITS value below).
>    */
> -#define GEN_MAX_SS_PER_HSW_SLICE	6
> +#define GEN_MAX_SS_PER_HSW_SLICE	8
>   
>   /*
>    * Maximum number of 32-bit registers used by hardware to express the
