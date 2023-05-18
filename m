Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF66B708611
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 18:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjERQbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 12:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjERQbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 12:31:21 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3A1B3;
        Thu, 18 May 2023 09:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684427479; x=1715963479;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WUUsMc2BhnwkTh/1UnMlHwzt6z3OUDJZykERpb42rPE=;
  b=Uuew0uNv78dYF624B5rvZZhpipLohFg7eBk8mFY7+GyvM/uDHjqG6R5A
   5Cxc7BZ79m8pxJnVfTa/eMuf5tRcEp5bHbDyW0hNXp+AU90uZPKdpfB9D
   e4Ez7P5364FwhwWZXgvzL0q27e0uAguuYLoogvJWsdPelmxFx1i7tMi8w
   7TOJ1M3BBuWEcGs6pb5x73SkfOKC6YXqIlsVPhK9TI4y3jODysxrb8TYp
   w1pXy0kODInO9Br54hPE+HTH43J/pWjATNe+J1YSn9QjxNZgIIeBJG6iT
   5PU3db+OwPx1VBTs62O6xwdxJx2HxP9MSnwekVbGiN7iOH1zxVZlBajs3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="417803672"
X-IronPort-AV: E=Sophos;i="6.00,285,1681196400"; 
   d="scan'208";a="417803672"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 09:31:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="948749658"
X-IronPort-AV: E=Sophos;i="6.00,285,1681196400"; 
   d="scan'208";a="948749658"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 18 May 2023 09:31:14 -0700
Received: from [10.209.99.208] (kliang2-mobl1.ccr.corp.intel.com [10.209.99.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 9C4555808EF;
        Thu, 18 May 2023 09:31:13 -0700 (PDT)
Message-ID: <3dca8ccf-081a-0765-b5e3-9584f9128137@linux.intel.com>
Date:   Thu, 18 May 2023 12:31:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] perf/x86/intel: Save/restore cpuc->active_pebs_data_cfg
 when using guest PEBS
Content-Language: en-US
To:     Like Xu <like.xu.linux@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230517133808.67885-1-likexu@tencent.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230517133808.67885-1-likexu@tencent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-05-17 9:38 a.m., Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> After commit b752ea0c28e3 ("perf/x86/intel/ds: Flush PEBS DS when changing
> PEBS_DATA_CFG"), the cpuc->pebs_data_cfg may save some bits that are not
> supported by real hardware, such as PEBS_UPDATE_DS_SW. This would cause
> the VMX hardware MSR switching mechanism to save/restore invalid values
> for PEBS_DATA_CFG MSR, thus crashing the host when PEBS is used for guest.

I believe we clear the SW bit when it takes effect.

+	if (cpuc->pebs_data_cfg & PEBS_UPDATE_DS_SW) {
+		cpuc->pebs_data_cfg = pebs_data_cfg;
+		pebs_update_threshold(cpuc);
+	}

I think the SW bit can only be seen in a shot period between add() and
enable(). Is it caused by a VM enter which just happens on the period?

> Fix it by using the active host value from cpuc->active_pebs_data_cfg.

I don't see a problem of using active_pebs_data_cfg, since it reflects
the current MSR setting. Just curious about how it's triggered.

> 
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Like Xu <likexu@tencent.com>
> ---

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

>  arch/x86/events/intel/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 070cc4ef2672..89b9c1cebb61 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4074,7 +4074,7 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
>  	if (x86_pmu.intel_cap.pebs_baseline) {
>  		arr[(*nr)++] = (struct perf_guest_switch_msr){
>  			.msr = MSR_PEBS_DATA_CFG,
> -			.host = cpuc->pebs_data_cfg,
> +			.host = cpuc->active_pebs_data_cfg,
>  			.guest = kvm_pmu->pebs_data_cfg,
>  		};
>  	}
