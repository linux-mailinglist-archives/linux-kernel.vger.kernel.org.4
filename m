Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DDD5B896D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 15:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiINNrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 09:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiINNr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 09:47:29 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC8B75FCD
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 06:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663163243; x=1694699243;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AbbpJQRoHzCPC9FuDp2OOdePPV7CP5RMw0+tM19yp94=;
  b=fNoxgeZ3yh3Tjkofrq1Uac1pVZRyuEACPAygx84Bsdi+6Rqm9Mo7OGC4
   56CjZ56kK84RkcjTlVY8p7Mxl5EQnlV4pEZShcJS5wCVJjKga+sYg0ZLI
   ljWRP8n/j+lRFBi3y6+FBFSyiM90TMjiklHkL+FVCeJvOUv2TSSTRnnvE
   168Z4P30dNBpi8dDhcAPTNxZM1yKDmGtCs4yvoVQAjK0bS7zCR1VFH1Jm
   UBp1PWMqjy3vP/64frhSUqWwGgQY3kWG884Po/dUxPgWMOrgrou8Tq4+F
   IyRuS5APsUL/k7jsQZMr8d0D64byXxLiEsPeAZfiBSO2F5QOO7HD8z+tE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="299245682"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="299245682"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 06:47:22 -0700
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="647396551"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.213.25.8]) ([10.213.25.8])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 06:47:19 -0700
Message-ID: <acfbd345-e0e8-263c-ac7e-06d8419cdc90@intel.com>
Date:   Wed, 14 Sep 2022 15:47:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [Intel-gfx] [PATCH] drm/i915: Fix return type of mode_valid
 function hook
Content-Language: en-US
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>, llvm@lists.linux.dev,
        Dan Carpenter <error27@gmail.com>,
        David Airlie <airlied@linux.ie>, Tom Rix <trix@redhat.com>,
        intel-gfx@lists.freedesktop.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
References: <20220913205531.155046-1-nhuck@google.com>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20220913205531.155046-1-nhuck@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.09.2022 22:55, Nathan Huckleberry wrote:
> All of the functions used for intel_dvo_dev_ops.mode_valid have a return
> type of enum drm_mode_status, but the mode_valid field in the struct
> definition has a return type of int.
> 
> The mismatched return type breaks forward edge kCFI since the underlying
> function definitions do not match the function hook definition.
> 
> The return type of the mode_valid field should be changed from int to
> enum drm_mode_status.
> 
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1703
> Cc: llvm@lists.linux.dev
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>

Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>

Regards
Andrzej

> ---
>   drivers/gpu/drm/i915/display/intel_dvo_dev.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dvo_dev.h b/drivers/gpu/drm/i915/display/intel_dvo_dev.h
> index d96c3cc46e50..50205f064d93 100644
> --- a/drivers/gpu/drm/i915/display/intel_dvo_dev.h
> +++ b/drivers/gpu/drm/i915/display/intel_dvo_dev.h
> @@ -75,8 +75,8 @@ struct intel_dvo_dev_ops {
>   	 *
>   	 * \return MODE_OK if the mode is valid, or another MODE_* otherwise.
>   	 */
> -	int (*mode_valid)(struct intel_dvo_device *dvo,
> -			  struct drm_display_mode *mode);
> +	enum drm_mode_status (*mode_valid)(struct intel_dvo_device *dvo,
> +					   struct drm_display_mode *mode);
>   
>   	/*
>   	 * Callback for preparing mode changes on an output

