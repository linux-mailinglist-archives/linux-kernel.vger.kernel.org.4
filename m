Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9939E6D022B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjC3Kx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjC3Kxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:53:54 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2F64C2F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 03:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680173633; x=1711709633;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=/a2NUyQvjACpQ05kbhWwDQBqs0dGUOck0k692foQm/k=;
  b=RljzMu/RZkHzBbdI5hVRMg0edt12gI3DcLsIi3T91okiRtlfYTwiYLKu
   +D3y8KAUHhLum0z3UhHwQchCAJRx0gQPPCkXAAco8P2wCHmojSJk2AE15
   JsIhOY9fXO1cZZ7BspJJZTA5rfUqYkdvv4gEcov6eEB3hD9J0Dk54fXoc
   f9nNm/c7PcdSYL4FKwoy2PpFwq7YtCb9MBZtfO17X7zaKea0ig78fEbAG
   VvbEVMpSJJUKqpuK0XXw66yN+tLH6TGeBoEO+nLPsVrVLy1reqIvmwxYu
   ASQ3HFIuBnywz39/se6g6fTtW5M1otHyMUX7UZBElAlD9NjwI5Kxsk43B
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="329628463"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="329628463"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 03:53:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="1014392291"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="1014392291"
Received: from unknown (HELO localhost) ([10.237.66.160])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 03:53:49 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     David Gow <davidgow@google.com>,
        =?utf-8?Q?Lu=C3=ADs?= Mendes <luis.p.mendes@gmail.com>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?utf-8?Q?Ma=C3=ADra?= Canal <mairacanal@riseup.net>,
        Arthur Grillo <arthurgrillo@riseup.net>
Cc:     dri-devel@lists.freedesktop.org, David Gow <davidgow@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm: buddy_allocator: Fix buddy allocator init on
 32-bit systems
In-Reply-To: <20230329065532.2122295-1-davidgow@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230329065532.2122295-1-davidgow@google.com>
Date:   Thu, 30 Mar 2023 13:53:47 +0300
Message-ID: <878rfe4iis.fsf@intel.com>
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

On Wed, 29 Mar 2023, David Gow <davidgow@google.com> wrote:
> The drm buddy allocator tests were broken on 32-bit systems, as
> rounddown_pow_of_two() takes a long, and the buddy allocator handles
> 64-bit sizes even on 32-bit systems.
>
> This can be reproduced with the drm_buddy_allocator KUnit tests on i386:
> 	./tools/testing/kunit/kunit.py run --arch i386 \
> 	--kunitconfig ./drivers/gpu/drm/tests drm_buddy
>
> (It results in kernel BUG_ON() when too many blocks are created, due to
> the block size being too small.)
>
> This was independently uncovered (and fixed) by Lu=C3=ADs Mendes, whose p=
atch
> added a new u64 variant of rounddown_pow_of_two(). This version instead
> recalculates the size based on the order.
>
> Reported-by: Lu=C3=ADs Mendes <luis.p.mendes@gmail.com>
> Link: https://lore.kernel.org/lkml/CAEzXK1oghXAB_KpKpm=3D-CviDQbNaH0qfgYT=
SSjZgvvyj4U78AA@mail.gmail.com/T/
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>  drivers/gpu/drm/drm_buddy.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
> index 3d1f50f481cf..7098f125b54a 100644
> --- a/drivers/gpu/drm/drm_buddy.c
> +++ b/drivers/gpu/drm/drm_buddy.c
> @@ -146,8 +146,8 @@ int drm_buddy_init(struct drm_buddy *mm, u64 size, u6=
4 chunk_size)
>  		unsigned int order;
>  		u64 root_size;
>=20=20
> -		root_size =3D rounddown_pow_of_two(size);
> -		order =3D ilog2(root_size) - ilog2(chunk_size);
> +		order =3D ilog2(size) - ilog2(chunk_size);
> +		root_size =3D chunk_size << order;

Just noticed near the beginning of the function there's also:

	if (!is_power_of_2(chunk_size))
		return -EINVAL;

which is also wrong for 32-bit.


BR,
Jani.


>=20=20
>  		root =3D drm_block_alloc(mm, NULL, order, offset);
>  		if (!root)

--=20
Jani Nikula, Intel Open Source Graphics Center
