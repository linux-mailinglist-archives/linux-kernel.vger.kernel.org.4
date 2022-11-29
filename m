Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E04063BD47
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 10:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiK2JvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 04:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiK2JvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 04:51:00 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E193024F2D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 01:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669715459; x=1701251459;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=va4oFqeghkExL+xaPKGG+xULxrpZnJfLBRDcWTTKGUM=;
  b=HGQttzalSPnw5CEiLrCs2VF8DfzF/eGNhFR9gtzLnmAUwtoSrQyD0yXR
   oH4pcAtgSp+Bg/JCtm8C53Zkt3KKz4V9uJy/bRqdVGs5oqaQ67DH/eVHB
   m7EmHRRwiMfeQ987/Bu8vRl0/7X6CrsVxCZzvsQFJachYzCFf+PFVbEh9
   bnw+64rkoSySI11qZ8s2ahmzGoWy9qlPlC/BaJI74JTa/9XOmY6vBBD99
   A+hnkzj8+GjPR3NX+KO0cIXVsfiROG60M72UpBoyFjpUpCYHh+6l30Tjb
   /kRHiBlzpxFCrgHdnJus2sxzUJWQcYNqzydvhZqsOHIUz0DNnZSjTaXD+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="315099370"
X-IronPort-AV: E=Sophos;i="5.96,202,1665471600"; 
   d="scan'208";a="315099370"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 01:50:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="707151581"
X-IronPort-AV: E=Sophos;i="5.96,202,1665471600"; 
   d="scan'208";a="707151581"
Received: from lclaesso-mobl.ger.corp.intel.com (HELO localhost) ([10.252.53.28])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 01:50:45 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Xia Fukun <xiafukun@huawei.com>, airlied@gmail.com,
        daniel@ffwll.ch, ville.syrjala@linux.intel.com,
        lucas.demarchi@intel.com, joonas.lahtinen@linux.intel.com
Cc:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, rodrigo.vivi@intel.com,
        xiafukun@huawei.com
Subject: Re: [Intel-gfx] [PATCH] drm/i915/bios: fix a memory leak in
 generate_lfp_data_ptrs
In-Reply-To: <875yf35tx1.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20221125063428.69486-1-xiafukun@huawei.com>
 <875yf35tx1.fsf@intel.com>
Date:   Tue, 29 Nov 2022 11:50:43 +0200
Message-ID: <87fse23x8s.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Nov 2022, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> On Fri, 25 Nov 2022, Xia Fukun <xiafukun@huawei.com> wrote:
>> When (size != 0 || ptrs->lvds_ entries != 3), the program tries to
>> free() the ptrs. However, the ptrs is not created by calling kzmalloc(),
>> but is obtained by pointer offset operation.
>> This may lead to memory leaks or undefined behavior.
>
> Yeah probably worse things will happen than just leak.
>
>>
>> Fix this by replacing the arguments of kfree() with ptrs_block.
>>
>> Fixes: a87d0a847607 ("drm/i915/bios: Generate LFP data table pointers if the VBT lacks them")
>> Signed-off-by: Xia Fukun <xiafukun@huawei.com>
>
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>

And pushed to drm-intel-next, thanks for the patch.

BR,
Jani.

>
>> ---
>>  drivers/gpu/drm/i915/display/intel_bios.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/i915/display/intel_bios.c b/drivers/gpu/drm/i915/display/intel_bios.c
>> index 28bdb936cd1f..edbdb949b6ce 100644
>> --- a/drivers/gpu/drm/i915/display/intel_bios.c
>> +++ b/drivers/gpu/drm/i915/display/intel_bios.c
>> @@ -414,7 +414,7 @@ static void *generate_lfp_data_ptrs(struct drm_i915_private *i915,
>>  		ptrs->lvds_entries++;
>>  
>>  	if (size != 0 || ptrs->lvds_entries != 3) {
>> -		kfree(ptrs);
>> +		kfree(ptrs_block);
>>  		return NULL;
>>  	}

-- 
Jani Nikula, Intel Open Source Graphics Center
