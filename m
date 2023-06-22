Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B13C73A32A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjFVOgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFVOgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:36:24 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087511BD1;
        Thu, 22 Jun 2023 07:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687444583; x=1718980583;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FA/5MjCEFzXtvpr658fdPTowSTrwjHH6yzPH+G8g3Fg=;
  b=HdPg4uC/oluNaqQ1q5XtKIwv1htqjV2oSQW+gyph0EnkyGLesLiiJLPY
   W/KsL5WyTgjo7pNnn0s0MvEQC6CywMQUXHGfN+llMHTuhnT2TETw1DFTt
   F++16lf7+zbJWcr2IhiJ0T2W5hBF3G3lgBc7pRP1oYgHuPG2S4dhgy+c3
   VlNNQ4PLBEKuAz+qCYPU7Um0efTZVlLP0PPM3+hG+NP/SmOGKZgmTsERj
   3GwvSgRZ6o3rAsFNBjM+aCuspP9eC0OpVgEHndPMt2zid3rt5Vx3bs3Zr
   PTygNqEe2rb6qo3h978ybwI6rOd3KAboW1wIqXZrMOx1hzcRM9J1HwZV/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="424182632"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="424182632"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 07:08:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="859451650"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="859451650"
Received: from shari19x-mobl1.gar.corp.intel.com (HELO [10.249.254.173]) ([10.249.254.173])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 07:08:35 -0700
Message-ID: <3a089ebb-7389-3d3e-beb0-13a8d64eb04d@linux.intel.com>
Date:   Thu, 22 Jun 2023 16:08:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [Intel-gfx] [PATCH 3/4] drm/ttm: Don't leak a resource on
 eviction error
Content-Language: en-US
To:     Andi Shyti <andi.shyti@linux.intel.com>
Cc:     intel-xe@lists.freedesktop.org,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Huang Rui <ray.huang@amd.com>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20230622101412.78426-1-thomas.hellstrom@linux.intel.com>
 <20230622101412.78426-4-thomas.hellstrom@linux.intel.com>
 <ZJRSyp7fT6VXpow7@ashyti-mobl2.lan>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>
In-Reply-To: <ZJRSyp7fT6VXpow7@ashyti-mobl2.lan>
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


On 6/22/23 15:55, Andi Shyti wrote:
> Hi Thomas,
>
> On Thu, Jun 22, 2023 at 12:14:11PM +0200, Thomas Hellström wrote:
>> On eviction errors other than -EMULTIHOP we were leaking a resource.
>> Fix.
>>
>> Fixes: 403797925768 ("drm/ttm: Fix multihop assert on eviction.")
>> Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Cc: Huang Rui <ray.huang@amd.com>
>> Cc: dri-devel@lists.freedesktop.org
>> Cc: <stable@vger.kernel.org> # v5.15+
>> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> ---
>>   drivers/gpu/drm/ttm/ttm_bo.c | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
>> index 615d30c4262d..89530f2a027f 100644
>> --- a/drivers/gpu/drm/ttm/ttm_bo.c
>> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
>> @@ -462,14 +462,14 @@ static int ttm_bo_evict(struct ttm_buffer_object *bo,
>>   	ret = ttm_bo_handle_move_mem(bo, evict_mem, true, ctx, &hop);
>>   	if (ret == -EMULTIHOP) {
>>   		ret = ttm_bo_bounce_temp_buffer(bo, &evict_mem, ctx, &hop);
>> -		if (ret) {
>> -			if (ret != -ERESTARTSYS && ret != -EINTR)
>> -				pr_err("Buffer eviction failed\n");
>> -			ttm_resource_free(bo, &evict_mem);
>> -			goto out;
>> -		}
>> -		/* try and move to final place now. */
>> -		goto bounce;
>> +		if (!ret)
>> +			/* try and move to final place now. */
>> +			goto bounce;
> As we are at this, can't we replace this with a while()? Goto's
> used instead of a while loop are a fist in the eye...

I'm completely OK with that. this patch already did away with one of 
them. Let's hear Christian's opinion first, though.

Thanks,

Thomas





>
> It looks even better:
>
> 	while (1) {
> 		ret = ttm_bo_handle_move_mem(bo, evict_mem, true, ctx, &hop);
> 		if (!ret)
> 			break;
>
> 		if (ret == -EMULTIHOP)
> 			ret = ttm_bo_bounce_temp_buffer(bo, &evict_mem,
> 							ctx, &hop);
>
> 		/* try again */
> 		if (!ret)
> 			continue;
>
> 		ttm_resource_free(bo, &evict_mem);
> 		if (ret != -ERESTARTSYS && ret != -EINTR)
> 			pr_err("Buffer eviction failed\n");
>
> 		break;
> 	}
>
> Andi
>
>> +	}
>> +	if (ret) {
>> +		ttm_resource_free(bo, &evict_mem);
>> +		if (ret != -ERESTARTSYS && ret != -EINTR)
>> +			pr_err("Buffer eviction failed\n");
>>   	}
>>   out:
>>   	return ret;
>> -- 
>> 2.40.1
