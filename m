Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE5B734F3E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjFSJMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFSJMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:12:00 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C7E83
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687165919; x=1718701919;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=XlJtRLxJS+pnRJUHddiRBMiJzl1tgKQnykUH5eJThvE=;
  b=QB9ECoWfNOOq4vyYLDq4n0PUqkQTHDIXfDlFFIHMh87CkMl6MF1wFe2M
   qgONc8aGtjNxuSmkkSqzWnB3rwJYEB7LO/wm/isbWnsWIm996/vsNYHvK
   biie/WcP3eNzvA4fGIFbLhcbdHDlc+eOYs1trJxdUn+IJVCR+/aoIjJBE
   7xjJUI1jlK9g0315hv6y4EUs5GTFly/GxB+rcyyngnHvNLMQfbaxIO8cF
   NzLd2ERJZdcp1GCa8z/ODoBHrE6fr9sDHNBJd5q4r+lCjMtPoov8giMJL
   bPlUt367mSiZJYN7Cq7TCEiypkP3VOt4cySCOVnO+aqOYmho/ySICrpmc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="423247768"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="423247768"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 02:11:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="691030609"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="691030609"
Received: from acarew-mobl.ger.corp.intel.com (HELO [10.213.214.207]) ([10.213.214.207])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 02:11:55 -0700
Message-ID: <cd1c813f-3bb3-1b05-9f33-03dcfd934bea@linux.intel.com>
Date:   Mon, 19 Jun 2023 10:11:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/i915: make i915_drm_client_fdinfo() reference
 conditional again
Content-Language: en-US
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
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
 <ef849277-10ef-90db-fd6c-3646599e32ba@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <ef849277-10ef-90db-fd6c-3646599e32ba@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16/06/2023 12:17, Tvrtko Ursulin wrote:
> 
> On 16/06/2023 11:16, Andi Shyti wrote:
>> Hi Arnd,
>>
>> On Fri, Jun 16, 2023 at 11:31:47AM +0200, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> The function is only defined if CONFIG_PROC_FS is enabled:
>>>
>>> ld.lld: error: undefined symbol: i915_drm_client_fdinfo
>>>>>> referenced by i915_driver.c
>>>>>>                
>>>>>> drivers/gpu/drm/i915/i915_driver.o:(i915_drm_driver) in archive 
>>>>>> vmlinux.a
>>>
>>> Use the PTR_IF() helper to make the reference NULL otherwise.
>>>
>>> Fixes: e894b724c316d ("drm/i915: Use the fdinfo helper")
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> ---
>>>   drivers/gpu/drm/i915/i915_driver.c     | 2 +-
>>>   drivers/gpu/drm/i915/i915_drm_client.h | 2 --
>>>   2 files changed, 1 insertion(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/i915/i915_driver.c 
>>> b/drivers/gpu/drm/i915/i915_driver.c
>>> index 75cbc43b326dd..0ad0c5885ec27 100644
>>> --- a/drivers/gpu/drm/i915/i915_driver.c
>>> +++ b/drivers/gpu/drm/i915/i915_driver.c
>>> @@ -1816,7 +1816,7 @@ static const struct drm_driver i915_drm_driver = {
>>>       .open = i915_driver_open,
>>>       .lastclose = i915_driver_lastclose,
>>>       .postclose = i915_driver_postclose,
>>> -    .show_fdinfo = i915_drm_client_fdinfo,
>>> +    .show_fdinfo = PTR_IF(IS_ENABLED(CONFIG_PROC_FS), 
>>> i915_drm_client_fdinfo),
>>>       .prime_handle_to_fd = drm_gem_prime_handle_to_fd,
>>>       .prime_fd_to_handle = drm_gem_prime_fd_to_handle,
>>> diff --git a/drivers/gpu/drm/i915/i915_drm_client.h 
>>> b/drivers/gpu/drm/i915/i915_drm_client.h
>>> index 4c18b99e10a4e..67816c912bca1 100644
>>> --- a/drivers/gpu/drm/i915/i915_drm_client.h
>>> +++ b/drivers/gpu/drm/i915/i915_drm_client.h
>>> @@ -47,8 +47,6 @@ static inline void i915_drm_client_put(struct 
>>> i915_drm_client *client)
>>>   struct i915_drm_client *i915_drm_client_alloc(void);
>>> -#ifdef CONFIG_PROC_FS
>>>   void i915_drm_client_fdinfo(struct drm_printer *p, struct drm_file 
>>> *file);
>>> -#endif
>>
>> nice! This is becoming the new trend now.
>>
>> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
> 
> Thanks for the fix and review! (And I got to learn about existence of 
> PTR_IF too.)
> 
> Andi will you merge once green or should I?

Pushed, thanks for the fixup and review!

Regards,

Tvrtko

