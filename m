Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C661C606660
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiJTQ5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJTQ5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:57:43 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C1E19ABDE
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666285061; x=1697821061;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UhRXPuUUle5UGhdesVQVt9EIRhQCZxoeTMxOb2Se27I=;
  b=Td+7BO5MRSVZpQieUMD3R9E6DNQEpf7bo/EL1N33Hgi8E1S9b2hquADu
   wuOYKMZJXf0JCztpM16X6B/tu3jk6G6UJ+VJ5+i7TbNioyc8F7EPSwA6Y
   7iVnI0Gb9fAZK7T/o52gFYaniMNymuPM0wya46WJIw4KNTa/2ynm/o3gD
   c4t7tnbKnjwM5JohPizo+tJlgBKvVV1XEIAJpGjlVBlHMUItskldCKMKG
   AUuo+0YvDRFz7MtGTnJIZRio/LTcY1jXl+CXRIBum7uE67e6fnVJaBBA5
   pb7PUJgPVVPXyzYNs1GfpK3+pdh0UMz9Y2CKKCPvMBIMyjw7qRZ3EEWhS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="305509132"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="305509132"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 09:57:41 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="734966908"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="734966908"
Received: from amancuso-mobl.amr.corp.intel.com (HELO [10.209.121.211]) ([10.209.121.211])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 09:57:40 -0700
Message-ID: <f086b776-75ad-47b1-e87a-7fb07c1cee3b@intel.com>
Date:   Thu, 20 Oct 2022 09:57:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/1] x86/fpu: Fix copy_xstate_to_uabi() to copy init
 states correctly
Content-Language: en-US
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, yuan.yao@intel.com
References: <20220824191223.1248-1-chang.seok.bae@intel.com>
 <20221018221349.4196-1-chang.seok.bae@intel.com>
 <20221018221349.4196-2-chang.seok.bae@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221018221349.4196-2-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/22 15:13, Chang S. Bae wrote:
> @@ -1141,10 +1141,14 @@ void __copy_xstate_to_uabi_buf(struct membuf to, struct fpstate *fpstate,
>  			 */
>  			pkru.pkru = pkru_val;
>  			membuf_write(&to, &pkru, sizeof(pkru));
> +		} else if (!(header.xfeatures & BIT_ULL(i))) {
> +			/*
> +			 * Every extended state component has an all zeros
> +			 * init state.
> +			 */
> +			membuf_zero(&to, xstate_sizes[i]);
>  		} else {
> -			copy_feature(header.xfeatures & BIT_ULL(i), &to,
> -				     __raw_xsave_addr(xsave, i),
> -				     __raw_xsave_addr(xinit, i),
> +			membuf_write(&to, __raw_xsave_addr(xsave, i),
>  				     xstate_sizes[i]);
>  		}

Just to add a bit more context, this is inside this loop:

        mask = fpstate->user_xfeatures;
        for_each_extended_xfeature(i, mask) {
                if (zerofrom < xstate_offsets[i])
                        membuf_zero(&to, xstate_offsets[i] - zerofrom);
		...
	}
        if (to.left)
                membuf_zero(&to, to.left);

In other words, the loop and the surrounding code already know how to
membuf_zero() any gaps in the middle or the end of the user buffer.
Would it be simpler to just adjust the 'mask' over which the loop iterates?

I think that would end up being something like:

	 mask = fpstate->user_xfeatures &
		(xsave->xfeatures | xinit->xfeatures);

Logically, that makes sense too.  We're copying out of either 'xsave' or
'xinit'.  If a feature isn't in either one of those we can't do the
copy_feature() on it.

