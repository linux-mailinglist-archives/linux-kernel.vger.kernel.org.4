Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE645B9586
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 09:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiIOHjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 03:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiIOHjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:39:39 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCD9DF99
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 00:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663227578; x=1694763578;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=qT4pK26WhnKxnisAOU+dg9Nial+Fkme5ipurw767x5k=;
  b=IeXPL+g6LkiE3ky06mbajqHhnyRl+evOsBJwu8Q2cFB5DDLdesShFKsF
   G6SOMMUrwmoNYdTx02L18Vx1QVQdXA/r9ofnxm/VPilluqsP+f/LKSlCx
   8F+BcdkzBHbCnZ2xVzIiVPhEeiRRhuFBt9MFqyG3V1MW0jLJMOzzWKyor
   zWV0MvLcFIdDNjhNXvDXslokqOJBwYlxOQGdNkXMrtgb91zglhblFnT5W
   l6iPNY/LIiAhOFyB+XZhbFRvKmaSyMv3e6KXvy6iUcwwYFU18PX+5BSvl
   Vj+1tb2kvUbVVtFXdbItc0nFby4vPvUEWP50JMe8CJmrOqc8ChemNEoGh
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="384932868"
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="384932868"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 00:39:38 -0700
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="685618048"
Received: from edgarisx-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.58.204])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 00:39:33 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Nathan Huckleberry <nhuck@google.com>
Cc:     Dan Carpenter <error27@gmail.com>, llvm@lists.linux.dev,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915: Fix return type of mode_valid function hook
In-Reply-To: <YyEP7W/yZAyhNtTX@dev-arch.thelio-3990X>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220913205531.155046-1-nhuck@google.com>
 <YyEP7W/yZAyhNtTX@dev-arch.thelio-3990X>
Date:   Thu, 15 Sep 2022 10:39:26 +0300
Message-ID: <87v8pp13yp.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2022, Nathan Chancellor <nathan@kernel.org> wrote:
> On Tue, Sep 13, 2022 at 01:55:27PM -0700, Nathan Huckleberry wrote:
>> All of the functions used for intel_dvo_dev_ops.mode_valid have a return
>> type of enum drm_mode_status, but the mode_valid field in the struct
>> definition has a return type of int.
>> 
>> The mismatched return type breaks forward edge kCFI since the underlying
>> function definitions do not match the function hook definition.
>> 
>> The return type of the mode_valid field should be changed from int to
>> enum drm_mode_status.
>> 
>> Reported-by: Dan Carpenter <error27@gmail.com>
>> Link: https://github.com/ClangBuiltLinux/linux/issues/1703
>> Cc: llvm@lists.linux.dev
>> Signed-off-by: Nathan Huckleberry <nhuck@google.com>
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Thanks for the patch and reviews, pushed to drm-intel-next.

BR,
Jani.

>
>> ---
>>  drivers/gpu/drm/i915/display/intel_dvo_dev.h | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/i915/display/intel_dvo_dev.h b/drivers/gpu/drm/i915/display/intel_dvo_dev.h
>> index d96c3cc46e50..50205f064d93 100644
>> --- a/drivers/gpu/drm/i915/display/intel_dvo_dev.h
>> +++ b/drivers/gpu/drm/i915/display/intel_dvo_dev.h
>> @@ -75,8 +75,8 @@ struct intel_dvo_dev_ops {
>>  	 *
>>  	 * \return MODE_OK if the mode is valid, or another MODE_* otherwise.
>>  	 */
>> -	int (*mode_valid)(struct intel_dvo_device *dvo,
>> -			  struct drm_display_mode *mode);
>> +	enum drm_mode_status (*mode_valid)(struct intel_dvo_device *dvo,
>> +					   struct drm_display_mode *mode);
>>  
>>  	/*
>>  	 * Callback for preparing mode changes on an output
>> -- 
>> 2.37.2.789.g6183377224-goog
>> 

-- 
Jani Nikula, Intel Open Source Graphics Center
