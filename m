Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AFA5FD5FF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 10:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiJMIMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 04:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiJMIMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 04:12:44 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D3AD2CD7;
        Thu, 13 Oct 2022 01:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665648762; x=1697184762;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=7n7bm9cEbwpAcQHLjxyNJZugoRkYPQp3Pb3ATCfFMcw=;
  b=VtCrKD8iV80UN99qVOUOC3BWMzIqADiXbPYZA4qdJsSiW+vbEylG3NJC
   bGWI9Uq3mWfjuQnB7B9Kuwcl2soGPhyF0OdCl6PoPt78x/Q8xSrYRzeke
   bUMP+k/qvcLUNbAKtJs6vri3xQZJifkb98AimhnyxKz4b7DfXnThPjBjm
   UVTeG35/7k2O+8qF0tl+jw6Vq+FJzM/q94EQb6XQmioibS21WNL+trIaA
   yK7cH+1V0ZDN8W24wvD7Rz3zyZwb/VBvJm+NSk4MzNwMSQsWURTXttbJ+
   wdslmJfW87VzcZStOMVrruNdrte2XsTX8sMDAjW3Bu6d4dtmySH66MdCt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="303756749"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="303756749"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 01:12:29 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="769524814"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="769524814"
Received: from ndenisov-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.41.197])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 01:12:21 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>, keescook@chromium.org
Cc:     luc.vanoostenryck@gmail.com, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com, dlatypov@google.com,
        vitor@massaru.org, gustavoars@kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com, airlied@linux.ie, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-sparse@vger.kernel.org,
        arnd@kernel.org
Subject: Re: [PATCH v3] overflow: Introduce overflows_type() and
 castable_to_type()
In-Reply-To: <20221013064956.1548741-1-gwan-gyeong.mun@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220926191109.1803094-1-keescook@chromium.org>
 <20221013064956.1548741-1-gwan-gyeong.mun@intel.com>
Date:   Thu, 13 Oct 2022 11:12:29 +0300
Message-ID: <87zge0rvki.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Oct 2022, Gwan-gyeong Mun <gwan-gyeong.mun@intel.com> wrote:
> diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
> index 0d98c9bc75da..44da9d190057 100644
> --- a/lib/overflow_kunit.c
> +++ b/lib/overflow_kunit.c
> @@ -16,6 +16,11 @@
>  #include <linux/types.h>
>  #include <linux/vmalloc.h>
>  
> +/* We're expecting to do a lot of "always true" or "always false" tests. */
> +#ifdef CONFIG_CC_IS_CLANG
> +#pragma clang diagnostic ignored "-Wtautological-constant-out-of-range-compare"
> +#endif

I thought #pragma was discouraged. I didn't try this, but would
something like this work in the Makefile instead:

CFLAGS_overflow_kunit.o = $(call cc-disable-warning, tautological-constant-out-of-range-compare)

Sorry for not noticing before. If you all think pragma is fine, sorry
for the noise.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
