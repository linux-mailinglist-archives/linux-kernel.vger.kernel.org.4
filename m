Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E976D02B0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjC3LMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjC3LMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:12:43 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEFC1709
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 04:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680174762; x=1711710762;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=Hlo3O44M8BngBpuXPetDOZID6/wfbPZbTYhMPgpcDcU=;
  b=Ttw/ZMvp2Z6I/jOmCs8vK7viix5fICRriL0N5EH+00lJPCpi25GHUxR/
   qe7aScHGnM0VuvzIrxKKro6iSMUG5OhlJqIs3n1MnaR5faD7vCafqwZIJ
   nGiB4vcuwCCcv/L/f1TMnnwzqabRB7cuiMPwIlKUK7jHwoMF6wO/MDOiH
   s5GKVLZTxEOa8UVvg/ajXJ7WcGpojxGpjwL5mCW4AEO/QDSWKOi4YgcoN
   ZDb+baRAPZJ6robC+m5XJD9fwRgdIQ564UQYPUV8G0UFTxyTmrtuQpamV
   4Sz4AyrUGsYBzWxO4OzWSWpwekNzBCp75pA5qO0XULrM32UR/XIAVHDwt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="368917536"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="368917536"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 04:12:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="714946982"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="714946982"
Received: from unknown (HELO localhost) ([10.237.66.160])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 04:12:20 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
        David Gow <davidgow@google.com>,
        =?utf-8?Q?Lu=C3=ADs?= Mendes <luis.p.mendes@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?utf-8?Q?Ma?= =?utf-8?Q?=C3=ADra?= Canal 
        <mairacanal@riseup.net>, Arthur Grillo <arthurgrillo@riseup.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm: buddy_allocator: Fix buddy allocator init on
 32-bit systems
In-Reply-To: <e1af591e-a183-9b22-f533-297934e15e30@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230329065532.2122295-1-davidgow@google.com>
 <878rfe4iis.fsf@intel.com> <e1af591e-a183-9b22-f533-297934e15e30@amd.com>
Date:   Thu, 30 Mar 2023 14:12:17 +0300
Message-ID: <875yai4hny.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2023, Christian K=C3=B6nig <christian.koenig@amd.com> wrote:
> Am 30.03.23 um 12:53 schrieb Jani Nikula:
>> On Wed, 29 Mar 2023, David Gow <davidgow@google.com> wrote:
>>> The drm buddy allocator tests were broken on 32-bit systems, as
>>> rounddown_pow_of_two() takes a long, and the buddy allocator handles
>>> 64-bit sizes even on 32-bit systems.
>>>
>>> This can be reproduced with the drm_buddy_allocator KUnit tests on i386:
>>> 	./tools/testing/kunit/kunit.py run --arch i386 \
>>> 	--kunitconfig ./drivers/gpu/drm/tests drm_buddy
>>>
>>> (It results in kernel BUG_ON() when too many blocks are created, due to
>>> the block size being too small.)
>>>
>>> This was independently uncovered (and fixed) by Lu=C3=ADs Mendes, whose=
 patch
>>> added a new u64 variant of rounddown_pow_of_two(). This version instead
>>> recalculates the size based on the order.
>>>
>>> Reported-by: Lu=C3=ADs Mendes <luis.p.mendes@gmail.com>
>>> Link: https://lore.kernel.org/lkml/CAEzXK1oghXAB_KpKpm=3D-CviDQbNaH0qfg=
YTSSjZgvvyj4U78AA@mail.gmail.com/T/
>>> Signed-off-by: David Gow <davidgow@google.com>
>>> ---
>>>   drivers/gpu/drm/drm_buddy.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
>>> index 3d1f50f481cf..7098f125b54a 100644
>>> --- a/drivers/gpu/drm/drm_buddy.c
>>> +++ b/drivers/gpu/drm/drm_buddy.c
>>> @@ -146,8 +146,8 @@ int drm_buddy_init(struct drm_buddy *mm, u64 size, =
u64 chunk_size)
>>>   		unsigned int order;
>>>   		u64 root_size;
>>>=20=20=20
>>> -		root_size =3D rounddown_pow_of_two(size);
>>> -		order =3D ilog2(root_size) - ilog2(chunk_size);
>>> +		order =3D ilog2(size) - ilog2(chunk_size);
>>> +		root_size =3D chunk_size << order;
>> Just noticed near the beginning of the function there's also:
>>
>> 	if (!is_power_of_2(chunk_size))
>> 		return -EINVAL;
>>
>> which is also wrong for 32-bit.
>
> Yeah, but that isn't vital. We just use u64 for the chunk_size for=20
> consistency.
>
> In reality I wouldn't except more than 256K here.

Right. It's just not pedantically correct either. ;)

is_power_of_2() is pretty scary as it is, since it just truncates.

BR,
Jani.


>
> Regards,
> Christian.
>
>>
>>
>> BR,
>> Jani.
>>
>>
>>>=20=20=20
>>>   		root =3D drm_block_alloc(mm, NULL, order, offset);
>>>   		if (!root)
>

--=20
Jani Nikula, Intel Open Source Graphics Center
