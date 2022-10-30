Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6569461291F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 09:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJ3Ibn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 04:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiJ3Ibk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 04:31:40 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CD9120;
        Sun, 30 Oct 2022 01:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667118696; x=1698654696;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8vFhLuD0S36ME3HvT/tSVLmP1r1ZUW0wiXJ1NfH1yT0=;
  b=R/YHafDbL4rdypqq7VB+z7X+tN8v6UuVaRFAtuyt5JAZQfEEvDdyPZF5
   nfd0+yLXMoCInrpfbLxHGtNzRP6EA4J9xJ8WKoKcqM4maMKhv7bZOdFFa
   QG62kxt/x4D5n0OuAKcMwQLdrJcZLiWqV3moPuXx4CNTwjj4q5ZRMmA9Z
   pGxyBqNoLPMwCP3uyucQbQRoIjUGtfzmyt75U4zrpk/d+Jm11+h/rSZQu
   BLslPZV/Kz9+hwYxpg8iuNb5mctM1bqIPL2/8kbvUv2z8zCgqdKHXqp05
   XnnEcNJdXUSGTWntrz0bhwG0DAmXrvX/rXs1jlrPt2JL3uvgq5PWYm0Fm
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10515"; a="395044758"
X-IronPort-AV: E=Sophos;i="5.95,225,1661842800"; 
   d="scan'208";a="395044758"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 01:31:36 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10515"; a="722495889"
X-IronPort-AV: E=Sophos;i="5.95,225,1661842800"; 
   d="scan'208";a="722495889"
Received: from heyingjx-mobl.ccr.corp.intel.com ([10.254.215.115])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 01:31:33 -0700
Message-ID: <433dcc871ecbee4a2ddd21b3ae23be7100002149.camel@intel.com>
Subject: Re: [PATCH 2/3] perf/x86/rapl: Use standard Energy Unit for SPR
 Dram RAPL domain
From:   Zhang Rui <rui.zhang@intel.com>
To:     peterz@infradead.org, rjw@rjwysocki.net, len.brown@intel.com
Cc:     mingo@redhat.com, linux-pm@vger.kernel.org, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@linux.intel.com,
        artem.bityutskiy@linux.intel.com
Date:   Sun, 30 Oct 2022 16:31:30 +0800
In-Reply-To: <20220924054738.12076-3-rui.zhang@intel.com>
References: <20220924054738.12076-1-rui.zhang@intel.com>
         <20220924054738.12076-3-rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Peter,

Can you please consider this as tip material?
This patch series does not get merged altogether. The intel-rapl and
turbostat fixes have been merged by Rafael and Len respectively.

thanks,
rui

On Sat, 2022-09-24 at 13:47 +0800, Zhang Rui wrote:
> Intel Xeon servers used to use a fixed energy resolution (15.3uj) for
> Dram RAPL domain. But on SPR, Dram RAPL domain follows the standard
> energy resolution as described in MSR_RAPL_POWER_UNIT.
> 
> Remove the SPR Dram energy unit quirk.
> 
> Fixes: bcfd218b6679 ("perf/x86/rapl: Add support for Intel SPR
> platform")
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Tested-by: Wang Wendy <wendy.wang@intel.com>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  arch/x86/events/rapl.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index 77e3a47af5ad..7d8db681880d 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -619,12 +619,8 @@ static int rapl_check_hw_unit(struct rapl_model
> *rm)
>  	case RAPL_UNIT_QUIRK_INTEL_HSW:
>  		rapl_hw_unit[PERF_RAPL_RAM] = 16;
>  		break;
> -	/*
> -	 * SPR shares the same DRAM domain energy unit as HSW, plus it
> -	 * also has a fixed energy unit for Psys domain.
> -	 */
> +	/* SPR uses a fixed energy unit for Psys domain. */
>  	case RAPL_UNIT_QUIRK_INTEL_SPR:
> -		rapl_hw_unit[PERF_RAPL_RAM] = 16;
>  		rapl_hw_unit[PERF_RAPL_PSYS] = 0;
>  		break;
>  	default:

