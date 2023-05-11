Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BC16FF54B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238271AbjEKO6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238061AbjEKO6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:58:24 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46C7187;
        Thu, 11 May 2023 07:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683817085; x=1715353085;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xcC/Z7/5lJtWD+qFNw7HuvRGj7Z3+YU6H3jp61sb/YM=;
  b=Ya6oXwD58t1H3K5YteiL8bjeHUlZhazUwtsjY+ACTk612ujrz0zmU/Ft
   +nBM+yApIGQ8i4l6Gx9XAK6ufNrL6URbKGHjbkurmAO0TZzTQ56aGNEG3
   YygphnxXfKJnWh0twfoUh/MhINdKQj3Gdw7dJ1OA3mEn0ORAg3gPKltqX
   ZxD9Ugz05/TiEDMD6HeBWJF72lOePKgGqQnkBxCeBTzM6QNnh30yx2U+N
   /r4UO7DG6vLTCIBCbw2W86tGh2CN3aFVtcNl+60X0RbMeYOPFP2RsGcuC
   FZDswAv33Th3PevAzJOUOet+0M6o/OMmcgXGZXL/IPSIvyAhfLcSUvZhx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="436854022"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="436854022"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 07:55:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="650220286"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="650220286"
Received: from ambujamp-mobl1.amr.corp.intel.com (HELO [10.212.238.119]) ([10.212.238.119])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 07:55:09 -0700
Message-ID: <28ead36b-2d9e-1a36-6f4e-04684e420260@intel.com>
Date:   Thu, 11 May 2023 07:55:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] powercap: RAPL: Add Power Limit4 support for Meteor Lake
 SoC
Content-Language: en-US
To:     Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>, rafael@kernel.org,
        srinivas.pandruvada@linux.intel.com, rui.zhang@intel.com,
        linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20230215123249.4473-1-sumeet.r.pawnikar@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230215123249.4473-1-sumeet.r.pawnikar@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/23 04:32, Sumeet Pawnikar wrote:
> diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
> index bc6adda58883..a27673706c3d 100644
> --- a/drivers/powercap/intel_rapl_msr.c
> +++ b/drivers/powercap/intel_rapl_msr.c
> @@ -143,6 +143,8 @@ static const struct x86_cpu_id pl4_support_ids[] = {
>  	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ALDERLAKE_N, X86_FEATURE_ANY },
>  	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_RAPTORLAKE, X86_FEATURE_ANY },
>  	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_RAPTORLAKE_P, X86_FEATURE_ANY },
> +	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_METEORLAKE, X86_FEATURE_ANY },
> +	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_METEORLAKE_L, X86_FEATURE_ANY },
>  	{}
>  };

Sumeet, could you _please_ go take a close look at 'struct x86_cpu_id'?

> struct x86_cpu_id {
>         __u16 vendor;
>         __u16 family;
>         __u16 model;
>         __u16 steppings;
>         __u16 feature;  /* bit index */
>         kernel_ulong_t driver_data;
> };

You might also want to very carefully count the fields in the structure.
 Which field is being initialized to X86_FEATURE_ANY?  Is it:

 a. ->feature
 b. ->steppings
 c. ->model

How could this _possibly_ work, you ask yourself?  Well, you lucked out:

#define X86_FAMILY_ANY   0
#define X86_MODEL_ANY    0
#define X86_STEPPING_ANY 0
#define X86_FEATURE_ANY  0

so, you actually accidentally *explicitly* specified a 0 for ->steppings
*AND* accidentally *implicitly* specified a 0 for ->feature.

... and you did this in at least five separate commits over four years.

Why does this matter?  Because some hapless maintainer might take your
code, copy it, and then s/X86_FEATURE_ANY/X86_FEATURE_FOO/ and then
scratch their head for an hour as to why it doesn't work.

Could you please fix this up?  As penance, you could even fix the _ANY
defines so that people can't do this accidentally any longer.
