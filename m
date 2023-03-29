Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF566CD6A0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjC2Jjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjC2Jje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:39:34 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CDF2132
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 02:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680082773; x=1711618773;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=rmwWgXx9DUsDkyM6xIc9AQk1bMfFjEwuONpPcP5/qI4=;
  b=L2tBEFmCafG3bhgpX5gh7ifcpV/V+jerlBUPQTywqQKrbK3hZvqJxBWr
   3Pz+8fENPXC2g7OwbSRO6oZAgKnkM8N2irU69PuMK+Xb5Qw2wJnX3r5SV
   0QgF9hmaxyv7o43+eHe2SvsoCdQUoT+x+cgxvbBXVGDOPssX+475c/LAB
   9Wb7aWITAZTekdfGJQX0XcnfJNUJWi9UBQ2lfJUAfdfzs4Mktb4iSyhn8
   L8s43d5yBA1kgCoi1ZBrIBDpWwx65nr8/v9i02H55kG5gYiND1XIJHafO
   NTiB9wH939OU+FQjHE68HRmU0lj3CnbKPzp+EMsBW4I+vg8+9djqAcanF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="342423482"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="342423482"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 02:39:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="858419942"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="858419942"
Received: from jetten-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.51.146])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 02:39:28 -0700
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
Subject: Re: [PATCH 2/2] drm: test: Fix 32-bit issue in drm_buddy_test
In-Reply-To: <20230329065532.2122295-2-davidgow@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230329065532.2122295-1-davidgow@google.com>
 <20230329065532.2122295-2-davidgow@google.com>
Date:   Wed, 29 Mar 2023 12:39:25 +0300
Message-ID: <87lejf522a.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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
> The drm_buddy_test KUnit tests verify that returned blocks have sizes
> which are powers of two using is_power_of_2(). However, is_power_of_2()
> operations on a 'long', but the block size is a u64. So on systems where
> long is 32-bit, this can sometimes fail even on correctly sized blocks.
>
> This only reproduces randomly, as the parameters passed to the buddy
> allocator in this test are random. The seed 0xb2e06022 reproduced it
> fine here.
>
> For now, just hardcode an is_power_of_2() implementation using
> x & (x - 1).
>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>
> There are actually a couple of is_power_of_2_u64() implementations
> already around in:
> - drivers/gpu/drm/i915/i915_utils.h
> - fs/btrfs/misc.h (called is_power_of_two_u64) 
>
> So the ideal thing would be to consolidate these in one place.
>
>
> ---
>  drivers/gpu/drm/tests/drm_buddy_test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/tests/drm_buddy_test.c b/drivers/gpu/drm/tests/drm_buddy_test.c
> index f8ee714df396..09ee6f6af896 100644
> --- a/drivers/gpu/drm/tests/drm_buddy_test.c
> +++ b/drivers/gpu/drm/tests/drm_buddy_test.c
> @@ -89,7 +89,8 @@ static int check_block(struct kunit *test, struct drm_buddy *mm,
>  		err = -EINVAL;
>  	}
>  
> -	if (!is_power_of_2(block_size)) {
> +	/* We can't use is_power_of_2() for a u64 on 32-bit systems. */
> +	if (block_size & (block_size - 1)) {

Then maybe use is_power_of_2_u64() instead?

BR,
Jani.

>  		kunit_err(test, "block size not power of two\n");
>  		err = -EINVAL;
>  	}

-- 
Jani Nikula, Intel Open Source Graphics Center
