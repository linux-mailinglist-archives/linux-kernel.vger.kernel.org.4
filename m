Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2423B6EA90E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 13:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjDULX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 07:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjDULXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 07:23:24 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3145844A2;
        Fri, 21 Apr 2023 04:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682076203; x=1713612203;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=74+qAqIgYF47Iz1gO9HKLYWhwUWDspIE8Lqjj6JQMno=;
  b=hL7DENgiIFf+BqHX6EiXIJ1HxRH+00Oe11R0OZQT1lqy9sHxDP8LotET
   fJ1QS7nTO0IYyBhWFFrp2rAQcqlTSOaj5HJIZ6THwIvHHDEf79a/Z46ac
   WpxWLkcvhW8fbB1/G9ksA1c79Vxf8Fc5Y0SMTdLzMrDk5N1bZZsK9YYnw
   KVdK+4+LVx0iL/I8DmBtzRw+FRv5SKY9YpnvkyhSjX5X4dt0MRTJrQb54
   uEuUi3DXrYICrxJK1P6zec7mZBgwPzVnageQQO8X4VTCH+vzfce9YJF3m
   YU6AFCpMWw0OGQo+Rmi/eT9eVUaPkx1qZ917LLd9ADVtI4eUBGBnLVHNM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="344726466"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="344726466"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 04:23:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="781575235"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="781575235"
Received: from vhavelx-mobl2.ger.corp.intel.com (HELO [10.213.192.37]) ([10.213.192.37])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 04:23:19 -0700
Message-ID: <f2a423c2-302a-024a-cf65-199f4be6caec@linux.intel.com>
Date:   Fri, 21 Apr 2023 12:23:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 5/6] drm: Add fdinfo memory stats
Content-Language: en-US
To:     Emil Velikov <emil.l.velikov@gmail.com>,
        Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christopher Healy <healych@amazon.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230412224311.23511-1-robdclark@gmail.com>
 <20230412224311.23511-6-robdclark@gmail.com>
 <CACvgo525ogS4LSZDUyaqjSqjJWj=qLRkphji5469=3obFXoMrQ@mail.gmail.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <CACvgo525ogS4LSZDUyaqjSqjJWj=qLRkphji5469=3obFXoMrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/04/2023 11:26, Emil Velikov wrote:
> On Wed, 12 Apr 2023 at 23:43, Rob Clark <robdclark@gmail.com> wrote:
> 
>> +/**
>> + * enum drm_gem_object_status - bitmask of object state for fdinfo reporting
>> + * @DRM_GEM_OBJECT_RESIDENT: object is resident in memory (ie. not unpinned)
>> + * @DRM_GEM_OBJECT_PURGEABLE: object marked as purgeable by userspace
>> + *
>> + * Bitmask of status used for fdinfo memory stats, see &drm_gem_object_funcs.status
>> + * and drm_show_fdinfo().  Note that an object can DRM_GEM_OBJECT_PURGEABLE if
>> + * it still active or not resident, in which case drm_show_fdinfo() will not
> 
> nit: s/can/can be/;s/if it still/if it is still/
> 
>> + * account for it as purgeable.  So drivers do not need to check if the buffer
>> + * is idle and resident to return this bit.  (Ie. userspace can mark a buffer
>> + * as purgeable even while it is still busy on the GPU.. it does not _actually_
>> + * become puregeable until it becomes idle.  The status gem object func does
> 
> nit: s/puregeable/purgeable/
> 
> 
> I think we want a similar note in the drm-usage-stats.rst file.
> 
> With the above the whole series is:
> Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>

Have you maybe noticed my slightly alternative proposal? (*) I am not a 
fan of putting this flavour of accounting into the core with no way to 
opt out. I think it leaves no option but to add more keys in the future 
for any driver which will not be happy with the core accounting.

*) https://patchwork.freedesktop.org/series/116581/

> Fwiw: Keeping the i915 patch as part of this series would be great.
> Sure i915_drm_client->id becomes dead code, but it's a piece one can
> live with for a release or two. Then again it's not my call to make.

Rob can take the i915 patch from my RFC too.

Regards,

Tvrtko
