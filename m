Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE6F5ED83C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbiI1IvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbiI1IvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:51:11 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46027E28;
        Wed, 28 Sep 2022 01:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664355070; x=1695891070;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=eltQSsd00+eTulXtPk3YMa9SYpcWVAR8VjdLyZ6mqho=;
  b=g+PbDW6SKZlFByra2hY2STr3Dutu5gFwIa3DIE7xLwV/0xWpQwANVJl1
   MOGF1ienEmCI0MaRg3kii0Y7hAac2FOZFYEdc+Ozso1bXsh8fkfCHzR1k
   DuIzL5kqSS+fIBQwKCXpw2vFb7Ifx0kdBTXvJp8RDOMhDfCwC7oqDlZme
   IfWaRz4rQTtQ1S5jPSlUOE6z62QGWEVFr+gcCcImh3vklp9MtsPitnBdt
   KWa4S83H3uJcMa6R98SrAO//o/7Yq+42tlSW8lN55skq6JuMoiF7B7n7D
   0tQmTjdY+byTqaj06CJUaDb3u5zllaMwaoeFIY3SEhfbYrBtKlK2pyuaS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="365593509"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="365593509"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 01:51:09 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="866895387"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="866895387"
Received: from novermar-mobl.ger.corp.intel.com (HELO localhost) ([10.252.61.30])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 01:51:03 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        intel-gfx@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        mchehab@kernel.org, chris@chris-wilson.co.uk,
        matthew.auld@intel.com, thomas.hellstrom@linux.intel.com,
        nirmoy.das@intel.com, airlied@redhat.com, daniel@ffwll.ch,
        andi.shyti@linux.intel.com, andrzej.hajda@intel.com,
        keescook@chromium.org, mauro.chehab@linux.intel.com,
        linux@rasmusvillemoes.dk, vitor@massaru.org, dlatypov@google.com,
        ndesaulniers@google.com, trix@redhat.com, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org, linux-sparse@vger.kernel.org,
        nathan@kernel.org, gustavoars@kernel.org,
        luc.vanoostenryck@gmail.com
Subject: Re: [PATCH v13 5/9] drm/i915: Check for integer truncation on
 scatterlist creation
In-Reply-To: <20220928081300.101516-6-gwan-gyeong.mun@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220928081300.101516-1-gwan-gyeong.mun@intel.com>
 <20220928081300.101516-6-gwan-gyeong.mun@intel.com>
Date:   Wed, 28 Sep 2022 11:51:00 +0300
Message-ID: <87edvvzxu3.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2022, Gwan-gyeong Mun <gwan-gyeong.mun@intel.com> wrote:
> diff --git a/drivers/gpu/drm/i915/i915_scatterlist.h b/drivers/gpu/drm/i915/i915_scatterlist.h
> index 9ddb3e743a3e..1d1802beb42b 100644
> --- a/drivers/gpu/drm/i915/i915_scatterlist.h
> +++ b/drivers/gpu/drm/i915/i915_scatterlist.h
> @@ -220,4 +220,15 @@ struct i915_refct_sgt *i915_rsgt_from_buddy_resource(struct ttm_resource *res,
>  						     u64 region_start,
>  						     u32 page_alignment);
>  
> +/* Wrap scatterlist.h to sanity check for integer truncation */
> +typedef unsigned int __sg_size_t; /* see linux/scatterlist.h */
> +#define sg_alloc_table(sgt, nents, gfp) \
> +	overflows_type(nents, __sg_size_t) ? -E2BIG \
> +		: ((sg_alloc_table)(sgt, (__sg_size_t)(nents), gfp))
> +
> +#define sg_alloc_table_from_pages_segment(sgt, pages, npages, offset, size, max_segment, gfp) \
> +	overflows_type(npages, __sg_size_t) ? -E2BIG \
> +		: ((sg_alloc_table_from_pages_segment)(sgt, pages, (__sg_size_t)(npages), offset, \
> +						       size, max_segment, gfp))
> +
>  #endif

No. I don't think we should shadow sg_alloc_table() and
sg_alloc_table_from_pages_segment().

Either get this in scatterlist.h (preferred) or prefix with i915_ or
whatever to indicate it's our local thing.

i915_scatterlist.h already has too much scatterlist "namespace" abuse
that I'd rather see gone than violated more.


BR,
Jani.



-- 
Jani Nikula, Intel Open Source Graphics Center
