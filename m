Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECDB732FA6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345290AbjFPLSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234871AbjFPLR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:17:58 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E65137
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686914277; x=1718450277;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SXaXEX0DfSvbMrmux/O66OLLANaDL5w3tNEEYOUNjWE=;
  b=keo7dN0AiFSFGGe48Q7f5fsEUkMgaKFjgHveWW041L/VtOqXq/1HiDQo
   fbpdgfC0UueBcNXKxHoeY3d4HD3mqRS2QPP6UW09nOwKkRbJs9ESAsz+G
   B9XMpEf1GphmBSfkHDz54Rnk5kPlXTyYwF9hnwe0JrMe2udKfPBa+DeUq
   ZYcgancDjIh7DHISdIVq3Azf25VdgBHTBkNrCfmEVS43QiX2o/ljuJdja
   CIm4bG4FrFg1Wdi1+6aRPXOFfnycKRedBBZbvG+D6SQUPlqfRn4LkcIQf
   LjQkvpAIblKesCunq8T2nNaqtUhTCPYffOSjN7TYIWrTHQJBQIzzxg11M
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="339521880"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="339521880"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 04:17:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="837012168"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="837012168"
Received: from sdonohue-mobl.ger.corp.intel.com (HELO [10.213.214.201]) ([10.213.214.201])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 04:17:53 -0700
Message-ID: <ef849277-10ef-90db-fd6c-3646599e32ba@linux.intel.com>
Date:   Fri, 16 Jun 2023 12:17:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/i915: make i915_drm_client_fdinfo() reference
 conditional again
Content-Language: en-US
To:     Andi Shyti <andi.shyti@linux.intel.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Arnd Bergmann <arnd@arndb.de>,
        Matt Roper <matthew.d.roper@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Alan Previn <alan.previn.teres.alexis@intel.com>,
        Anshuman Gupta <anshuman.gupta@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230616093158.3568480-1-arnd@kernel.org>
 <ZIw2kdx9+DCmUZUV@ashyti-mobl2.lan>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <ZIw2kdx9+DCmUZUV@ashyti-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16/06/2023 11:16, Andi Shyti wrote:
> Hi Arnd,
> 
> On Fri, Jun 16, 2023 at 11:31:47AM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> The function is only defined if CONFIG_PROC_FS is enabled:
>>
>> ld.lld: error: undefined symbol: i915_drm_client_fdinfo
>>>>> referenced by i915_driver.c
>>>>>                drivers/gpu/drm/i915/i915_driver.o:(i915_drm_driver) in archive vmlinux.a
>>
>> Use the PTR_IF() helper to make the reference NULL otherwise.
>>
>> Fixes: e894b724c316d ("drm/i915: Use the fdinfo helper")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>   drivers/gpu/drm/i915/i915_driver.c     | 2 +-
>>   drivers/gpu/drm/i915/i915_drm_client.h | 2 --
>>   2 files changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
>> index 75cbc43b326dd..0ad0c5885ec27 100644
>> --- a/drivers/gpu/drm/i915/i915_driver.c
>> +++ b/drivers/gpu/drm/i915/i915_driver.c
>> @@ -1816,7 +1816,7 @@ static const struct drm_driver i915_drm_driver = {
>>   	.open = i915_driver_open,
>>   	.lastclose = i915_driver_lastclose,
>>   	.postclose = i915_driver_postclose,
>> -	.show_fdinfo = i915_drm_client_fdinfo,
>> +	.show_fdinfo = PTR_IF(IS_ENABLED(CONFIG_PROC_FS), i915_drm_client_fdinfo),
>>   
>>   	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
>>   	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
>> diff --git a/drivers/gpu/drm/i915/i915_drm_client.h b/drivers/gpu/drm/i915/i915_drm_client.h
>> index 4c18b99e10a4e..67816c912bca1 100644
>> --- a/drivers/gpu/drm/i915/i915_drm_client.h
>> +++ b/drivers/gpu/drm/i915/i915_drm_client.h
>> @@ -47,8 +47,6 @@ static inline void i915_drm_client_put(struct i915_drm_client *client)
>>   
>>   struct i915_drm_client *i915_drm_client_alloc(void);
>>   
>> -#ifdef CONFIG_PROC_FS
>>   void i915_drm_client_fdinfo(struct drm_printer *p, struct drm_file *file);
>> -#endif
> 
> nice! This is becoming the new trend now.
> 
> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks for the fix and review! (And I got to learn about existence of 
PTR_IF too.)

Andi will you merge once green or should I?

Regards,

Tvrtko
