Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318A573A0D0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjFVMZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjFVMZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:25:30 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E41A1BD1;
        Thu, 22 Jun 2023 05:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687436728; x=1718972728;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tG380jqTzpNo5ZL67fT6Js9jxrrZXcN1PKFqveEdQic=;
  b=NwlDBMGJtP4UTso7TepQ6RuMNbRNHor2XrhcBRH5CjZe2h13L1m8mKeI
   VHceSe+gPQeAn/yS4aoVO04eDF2CnF15Ed8yPd9UpgSYp1ww8he3AE21y
   wKtIpIk9i8p+NO5QmNLnun6VLoOoBA3lBXSEzFUW8yqOuheu1/uwpnNUW
   hP1TBSCi5qkzJ33P/dWe6RJLoUM8LuvK2bgcoouGTPTkyDMEJncdlPuiP
   Yn3/WLWlsST+yqxulS4zsG0Txq40eaKV9SIsN+PB8t/znDuWg1E50VUsq
   recAFNrWrRq3yTgy7ota/NcuI47fWWIl2rALde/cKZa2tT+d3vc30Hp+b
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="360489581"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="360489581"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 05:25:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="839028370"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="839028370"
Received: from nirmoyda-mobl.ger.corp.intel.com (HELO [10.249.46.93]) ([10.249.46.93])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 05:25:25 -0700
Message-ID: <a7c5f3e4-03ae-1420-6d10-cd0196ee509f@linux.intel.com>
Date:   Thu, 22 Jun 2023 14:25:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/4] drm/ttm: Don't leak a resource on swapout move error
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>, intel-xe@lists.freedesktop.org
Cc:     =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20230622101412.78426-1-thomas.hellstrom@linux.intel.com>
 <20230622101412.78426-5-thomas.hellstrom@linux.intel.com>
From:   Nirmoy Das <nirmoy.das@linux.intel.com>
In-Reply-To: <20230622101412.78426-5-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/22/2023 12:14 PM, Thomas Hellström wrote:
> If moving the bo to system for swapout failed, we were leaking
> a resource. Fix.
>
> Fixes: bfa3357ef9ab ("drm/ttm: allocate resource object instead of embedding it v2")
> Cc: Christian König <christian.koenig@amd.com>
> Cc: "Christian König" <ckoenig.leichtzumerken@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v5.14+
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
> ---
>   drivers/gpu/drm/ttm/ttm_bo.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 89530f2a027f..d737ddd7f4c0 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -1166,6 +1166,7 @@ int ttm_bo_swapout(struct ttm_buffer_object *bo, struct ttm_operation_ctx *ctx,
>   		ret = ttm_bo_handle_move_mem(bo, evict_mem, true, ctx, &hop);
>   		if (unlikely(ret != 0)) {
>   			WARN(ret == -EMULTIHOP, "Unexpected multihop in swaput - likely driver bug.\n");
> +			ttm_resource_free(bo, &evict_mem);
>   			goto out;
>   		}
>   	}
