Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E132F6C6D78
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjCWQ2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjCWQ2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:28:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE28C1A498
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679588922; x=1711124922;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=uNtkVqsPMrq+9BL76Z9qizfyprY+wSNP/YTwzvwm4UY=;
  b=PEufSvr7pxh1ysvMCFzTKH0W8bpuUhtkn124YTlw8YViHO4wKHjVXS9N
   tOK1d1giSVophofrC4WCOXiPmJIQvojnHoWS0d9+WPWJr0uRcaC+VQ1vH
   IDAeDt4mrL1VX5QNOP1wq5m3sLhtJpXLfyzehZInk56P++pryvdmAP+Ws
   Lyfeszkwhy98di9xwxSNpzsVoVVgPWXgXuLDr6CASdX217zZbGNjk8apR
   iksb+572l2KZ3z9Yq1ySoRsvy02Sunv9d6BrXMsLuYsgkNMlpSQ5Upfe7
   E3d9/yCTMLs94lorlRmZuhPDRy8pU9dyHJX0mHEkUCFso6tU/6aTjzyMu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="404451254"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="404451254"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 09:26:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="675768401"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="675768401"
Received: from jball6-mobl.amr.corp.intel.com (HELO [10.209.105.116]) ([10.209.105.116])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 09:26:50 -0700
Message-ID: <41a01b03-26f9-a9ae-d8f7-6b0eeb941cf5@intel.com>
Date:   Thu, 23 Mar 2023 09:26:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4] x86/platform/uv: UV support for sub-NUMA clustering
Content-Language: en-US
To:     Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <20230224225904.2618624-1-steve.wahl@hpe.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230224225904.2618624-1-steve.wahl@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/23 14:59, Steve Wahl wrote:
> +			if (np) {
> +				s = ((i * 64) + __ffs(np)) & s_mask;
> +				if (sock_min > s)
> +					sock_min = s;
> +				s = ((i * 64) + __fls(np)) & s_mask;
> +				if (sock_max < s)
> +					sock_max = s;
> +			}
>  		}
>  	}
>  	if (UVH_NODE_PRESENT_0) {
>  		np = uv_read_local_mmr(UVH_NODE_PRESENT_0);
>  		pr_info("UV: NODE_PRESENT_0 = 0x%016lx\n", np);
> -		uv_pb += hweight64(np);
> +		if (np) {
> +			s = __ffs(np) & s_mask;
> +			if (sock_min > s)
> +				sock_min = s;
> +			s = __fls(np) & s_mask;
> +			if (sock_max < s)
> +				sock_max = s;
> +		}
>  	}
>  	if (UVH_NODE_PRESENT_1) {
>  		np = uv_read_local_mmr(UVH_NODE_PRESENT_1);
>  		pr_info("UV: NODE_PRESENT_1 = 0x%016lx\n", np);
> -		uv_pb += hweight64(np);
> +		if (np) {
> +			s = (64 + __ffs(np)) & s_mask;
> +			if (sock_min > s)
> +				sock_min = s;
> +			s = (64 + __fls(np)) & s_mask;
> +			if (sock_max < s)
> +				sock_max = s;
> +		}
> +	}

I guess this patch is modifying code that very few people care about.
But, this is kinda a mess.  This patch does a *TON* of different things
and makes almost no effort to refactor the code before diving into the
changes.

I quoted the above text because whatever that code is doing, it's
gloriously uncommented.  That kind of thing demands a helper even if
it's just used once so that a read can have _some_ idea what it's doing
logically.

Could you please take another pass at this?  I think it demands to be
broken up into at _least_ 5-10 individual patches.

For instance, you could introduce and use uv_pnode_to_socket() in one patch.

Or this:

> -		nasid_mask = UVH_RH_GAM_MMIOH_OVERLAY_CONFIG0_BASE_MASK;
> +		nasid_mask =
> +			is_uv(UV4A) ? UV4AH_RH_GAM_MMIOH_REDIRECT_CONFIG0_NASID_MASK :
> +			is_uv(UV4)  ? UV4H_RH_GAM_MMIOH_REDIRECT_CONFIG0_NASID_MASK :
> +			UV3H_RH_GAM_MMIOH_REDIRECT_CONFIG0_NASID_MASK;
>  		n = UVH_RH_GAM_MMIOH_REDIRECT_CONFIG0_DEPTH;
>  		min_nasid = min_pnode * 2;
>  		max_nasid = max_pnode * 2;
> @@ -1046,7 +1050,10 @@ static void __init calc_mmioh_map(enum mmioh_arch index,
>  		break;
>  	case UVX_MMIOH1:
>  		mmr = UVH_RH_GAM_MMIOH_REDIRECT_CONFIG1;
> -		nasid_mask = UVH_RH_GAM_MMIOH_OVERLAY_CONFIG1_BASE_MASK;
> +		nasid_mask =
> +			is_uv(UV4A) ? UV4AH_RH_GAM_MMIOH_REDIRECT_CONFIG0_NASID_MASK :
> +			is_uv(UV4)  ? UV4H_RH_GAM_MMIOH_REDIRECT_CONFIG1_NASID_MASK :
> +			UV3H_RH_GAM_MMIOH_REDIRECT_CONFIG1_NASID_MASK;

That could use a helper to reduce the duplication and add clarity and be
done in a separate patch.
