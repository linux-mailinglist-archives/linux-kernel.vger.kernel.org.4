Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89277332B9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbjFPOAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345393AbjFPN75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:59:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D922720;
        Fri, 16 Jun 2023 06:59:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2344863272;
        Fri, 16 Jun 2023 13:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08048C433C0;
        Fri, 16 Jun 2023 13:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686923995;
        bh=gS7r5jiasHFa2ShPnNu4jMMlEMSQhNUP6kzWyo0GT10=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jM+620FTyLYA4YGcIOSYdRpdE49XQQrP/Tfjl/j4I2sWBZSTRFuL1O5267uw0G5rz
         HpdMzmwtVk9ki3XdpaCsotEuZ2flZ003mEV9AE2FKk/ORZ0WFXA3NpH0Ov34yivl6R
         gUMvD0GQgWOeyXjj+iATanjRMa6PlekOX05eOjQkLvX9zi1D0E+IWW495iiVCHPW1n
         h1IOHOvFeDHk72SE4sRRSeEZ4efwNUx5gpLg1kU3Ttgc9xGZGwEe36Oj259yju3um6
         g9jzRFJh0Lvt7S66j5utjc0sYfwVuVXYug4Zqp0cjTbD4mPbDbl0UxyupOCTYNeWQz
         9JurQbDoI556Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AB92240692; Fri, 16 Jun 2023 10:59:52 -0300 (-03)
Date:   Fri, 16 Jun 2023 10:59:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     irogers@google.com, jolsa@kernel.org, namhyung@kernel.org,
        peterz@infradead.org, james.clark@arm.com, alisaidi@amazon.com,
        leo.yan@linaro.org, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, mark.rutland@arm.com,
        maddy@linux.ibm.com, tmricht@linux.ibm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH v2.1 2/3] perf mem amd: Fix perf_pmus__num_mem_pmus()
Message-ID: <ZIxq2FBX+qBoYIRv@kernel.org>
References: <e63e6d33-6659-b63f-2716-c347aba7f525@amd.com>
 <20230615061238.2042-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615061238.2042-1-ravi.bangoria@amd.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jun 15, 2023 at 11:42:38AM +0530, Ravi Bangoria escreveu:
> perf mem/c2c on AMD internally uses IBS OP PMU, not the core PMU. Also,
> AMD platforms does not have heterogeneous PMUs.

Thanks, applied the series.

- Arnaldo
 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  tools/perf/arch/x86/util/pmu.c | 12 ++++++++++++
>  tools/perf/util/pmus.c         |  2 +-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
> index 3c0de3370d7e..65d8cdff4d5f 100644
> --- a/tools/perf/arch/x86/util/pmu.c
> +++ b/tools/perf/arch/x86/util/pmu.c
> @@ -14,6 +14,8 @@
>  #include "../../../util/intel-bts.h"
>  #include "../../../util/pmu.h"
>  #include "../../../util/fncache.h"
> +#include "../../../util/pmus.h"
> +#include "env.h"
>  
>  struct pmu_alias {
>  	char *name;
> @@ -168,3 +170,13 @@ char *pmu_find_alias_name(const char *name)
>  
>  	return __pmu_find_alias_name(name);
>  }
> +
> +int perf_pmus__num_mem_pmus(void)
> +{
> +	/* AMD uses IBS OP pmu and not a core PMU for perf mem/c2c */
> +	if (x86__is_amd_cpu())
> +		return 1;
> +
> +	/* Intel uses core pmus for perf mem/c2c */
> +	return perf_pmus__num_core_pmus();
> +}
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index 8c50ab8894b7..a2032c1b7644 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -242,7 +242,7 @@ const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str)
>  	return NULL;
>  }
>  
> -int perf_pmus__num_mem_pmus(void)
> +int __weak perf_pmus__num_mem_pmus(void)
>  {
>  	/* All core PMUs are for mem events. */
>  	return perf_pmus__num_core_pmus();
> -- 
> 2.40.1
> 

-- 

- Arnaldo
