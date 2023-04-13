Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B59D6E076F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 09:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjDMHPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 03:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjDMHPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 03:15:16 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1945FFE
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 00:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681370115; x=1712906115;
  h=from:to:subject:in-reply-to:references:date:message-id:
   mime-version;
  bh=jypqQHoHc1mLtlBqinklOeRtPPtMmrLDMLbma0WWA0Q=;
  b=S8rtmBcKIarOqpIc9w9a6wixY0VOyVyk9COQdZzRKQNurBsL7vP2BS2E
   bIrLnIEcjQ5RfW+sj903/A4Dim5DXmt0ndxAJSH83m+bde/unmC5Xc2Ka
   h811K9zyQXnxcCoRT1ae5F8Mnma58dFDU6sR/U3xCug2CtJA2Cso3Z5f+
   eOptYvCNqwyLCSTRZK9NUb7Y+0SVhgPItrVVVDD1PFqyCnoP2ULC5YYBZ
   R2wS+dHDkFZteTS2h94wA4GZyIrEvdztsYziua9o3RZ426L5QQ4u9XDB4
   5FtTjPD6ra31cA7B6wXl1O/rMO1PSQ62ZAx8t1AldHBdOjrJkqZ2Ad4Fd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332813202"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332813202"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 00:15:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="666698005"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="666698005"
Received: from svadali-mobl1.amr.corp.intel.com (HELO localhost) ([10.252.55.23])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 00:15:09 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Cong Liu <liucong2@kylinos.cn>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthew Auld <matthew.auld@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Jonathan Cavitt <jonathan.cavitt@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915: Fix memory leaks in i915 selftests
In-Reply-To: <71ba4962-14fd-887f-1d40-31089dd1cf50@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230413031349.9026-1-liucong2@kylinos.cn>
 <71ba4962-14fd-887f-1d40-31089dd1cf50@intel.com>
Date:   Thu, 13 Apr 2023 10:15:07 +0300
Message-ID: <874jpkckxw.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Apr 2023, Andrzej Hajda <andrzej.hajda@intel.com> wrote:
> On 13.04.2023 05:13, Cong Liu wrote:

A commit message is still needed.

>> Fixes: c3bfba9a2225 ("drm/i915: Check for integer truncation on scatterlist creation")
>>

No blank line here.

BR,
Jani.

>> Signed-off-by: Cong Liu <liucong2@kylinos.cn>
>> ---
>
> Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
>
> Regards
> Andrzej
>>   drivers/gpu/drm/i915/selftests/i915_gem_gtt.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
>> index 5361ce70d3f2..154801f1c468 100644
>> --- a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
>> +++ b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
>> @@ -69,8 +69,10 @@ static int fake_get_pages(struct drm_i915_gem_object *obj)
>>   
>>   	rem = round_up(obj->base.size, BIT(31)) >> 31;
>>   	/* restricted by sg_alloc_table */
>> -	if (overflows_type(rem, unsigned int))
>> +	if (overflows_type(rem, unsigned int)) {
>> +		kfree(pages);
>>   		return -E2BIG;
>> +	}
>>   
>>   	if (sg_alloc_table(pages, rem, GFP)) {
>>   		kfree(pages);
>

-- 
Jani Nikula, Intel Open Source Graphics Center
