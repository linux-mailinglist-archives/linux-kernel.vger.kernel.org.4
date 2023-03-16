Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E060D6BD814
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 19:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjCPSUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 14:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjCPSUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 14:20:12 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D77D591FE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 11:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678990800; x=1710526800;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pAvg3SuZqEJ6Cl69ahM7MR7Th6gdWUEQc5iMKwqIrBY=;
  b=cIZ2nRkIbEskEoPuFNTUHYDt/UG2HGZp3ImAWWK5MwoxsX8tJu37cI3g
   AAgEJxlDLhNRPywf7a9wFKdC9TsU+gk/X28Wma04+9LgqpLChodEaapKl
   Vxh4veIXDCr3O5+dDal2lVKtJUpEV+vmH+sO5GNqEv++fxH2tjU904TF9
   BgVrK/W3sv3kzmgm4JAb9ia+zfi9yzcG3BlH29BIr+XMobw3nANJdOQL1
   vFhQLQQL/OqvvqSOtV76pC9wRI1xSBmdYmgV7kpH/IQFPT9U3DilmCFOa
   WX3W0M0LWRKv/ywpbSESBppWZ+hhzubE2ZguYqFkaTQRoHoPrRz7Htth1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="326443552"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="326443552"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 11:18:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="1009343282"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="1009343282"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.213.22.209]) ([10.213.22.209])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 11:18:53 -0700
Message-ID: <8a52b10f-0c6c-e776-df94-d5c85868f440@intel.com>
Date:   Thu, 16 Mar 2023 19:18:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [Intel-gfx] [PATCH v6 0/2] drm/i915: add guard page to
 ggtt->error_capture
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Chris Wilson <chris.p.wilson@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>
References: <20230308-guard_error_capture-v6-0-1b5f31422563@intel.com>
Content-Language: en-US
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20230308-guard_error_capture-v6-0-1b5f31422563@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.03.2023 10:23, Andrzej Hajda wrote:
> This patch tries to diminish plague of DMAR read errors present
> in CI for ADL*, RPL*, DG2 platforms, see for example [1] (grep DMAR).
> CI is usually tolerant for these errors, so the scale of the problem
> is not really visible.
> To show it I have counted lines containing DMAR read errors in dmesgs
> produced by CI for all three versions of the patch, but in contrast to v2
> I have grepped only for lines containing "PTE Read access".
> Below stats for kernel w/o patchset vs patched one.
> v1: 210 vs 0
> v2: 201 vs 0
> v3: 214 vs 0
> Apparently the patchset fixes all common PTE read errors.
> 
> Changelog:
> v2:
>      - modified commit message (I hope the diagnosis is correct),
>      - added bug checks to ensure scratch is initialized on gen3 platforms.
>        CI produces strange stacktrace for it suggesting scratch[0] is NULL,
>        to be removed after resolving the issue with gen3 platforms.
> v3:
>      - removed bug checks, replaced with gen check.
> v4:
>      - change code for scratch page insertion to support all platforms,
>      - add info in commit message there could be more similar issues
> v5:
>      - changed to patchset adding nop_clear_range related code,
>      - re-insert scratch PTEs on resume
> v6:
>      - use scratch_range
> 
> To: Jani Nikula <jani.nikula@linux.intel.com>
> To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> To: Rodrigo Vivi <rodrigo.vivi@intel.com>
> To: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
> Cc: intel-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Andi Shyti <andi.shyti@linux.intel.com>
> Cc: Chris Wilson <chris.p.wilson@linux.intel.com>
> Cc: Nirmoy Das <nirmoy.das@intel.com>
> 
> Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
> 

Queued to drm-intel-gt-next

Regards
Andrzej

> ---
> - Link to v5: https://lore.kernel.org/r/20230308-guard_error_capture-v5-0-6d1410d13540@intel.com
> 
> ---
> Andrzej Hajda (2):
>        drm/i915/gt: introduce vm->scratch_range callback
>        drm/i915: add guard page to ggtt->error_capture
> 
>   drivers/gpu/drm/i915/gt/intel_ggtt.c      | 43 ++++++++++++++++++++++++++++---
>   drivers/gpu/drm/i915/gt/intel_ggtt_gmch.c |  1 +
>   drivers/gpu/drm/i915/gt/intel_gtt.h       |  2 ++
>   3 files changed, 42 insertions(+), 4 deletions(-)
> ---
> base-commit: 3cd6c251f39c14df9ab711e3eb56e703b359ff54
> change-id: 20230308-guard_error_capture-f3f334eec85f
> 
> Best regards,

