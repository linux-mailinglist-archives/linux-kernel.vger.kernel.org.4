Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FE772EC48
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjFMTt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjFMTtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:49:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BEBB3;
        Tue, 13 Jun 2023 12:49:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BDEF630A1;
        Tue, 13 Jun 2023 19:49:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E76C433F0;
        Tue, 13 Jun 2023 19:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686685764;
        bh=PZv+XMCCXCRCZTRyomhmcyUv5X6MbpeqfAXOZO1XZHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fz0IA7ez5ZF4MV5aHTyCJY0Ezy31j4aPUmBxhFKQ1wpHWjr9tF3zHBamNfLTH04Kp
         KmoB6/3c2tyui1Lc6MQgfrtoglFz7TZ4qkedqG3XkCp0ZAF9h5+3JzMEcpwMQN6khf
         YVr6PHDfyRa0eyOEVkDT35axt5imHy33YzF8vMuloq/3tpHjU+2Mzs4JVHTF8JCBJ3
         +vtNzt66GOu16UxWt8d2dodtx8E5e7aaFVuIshtWAc1n9ja/3F0pSvX7N3aGcLu0nm
         qR+dYAkCRfejne3gwI2swXvXvouiKLEBYlqjo8SpE4ZUcFCGnAuNdsbhTT42ralVIZ
         yv4naYMsd+c1g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1A8E240692; Tue, 13 Jun 2023 16:49:21 -0300 (-03)
Date:   Tue, 13 Jun 2023 16:49:21 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     irogers@google.com, jolsa@kernel.org, namhyung@kernel.org,
        mark.rutland@arm.com, peterz@infradead.org,
        adrian.hunter@intel.com, kan.liang@linux.intel.com,
        james.clark@arm.com, alisaidi@amazon.com, leo.yan@linaro.org,
        maddy@linux.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, santosh.shukla@amd.com
Subject: Re: [PATCH 2/4] perf tool x86: Consolidate is_amd check into single
 function
Message-ID: <ZIjIQZwqWD/r7f0W@kernel.org>
References: <20230613095506.547-1-ravi.bangoria@amd.com>
 <20230613095506.547-3-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613095506.547-3-ravi.bangoria@amd.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 13, 2023 at 03:25:04PM +0530, Ravi Bangoria escreveu:
> There are multiple places where x86 specific code determines AMD vs
> Intel arch and acts based on that. Consolidate those checks into a
> single function.

I'm cherry picking this one now.

- Arnaldo
 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  tools/perf/arch/x86/util/Build        |  1 +
>  tools/perf/arch/x86/util/env.c        | 19 +++++++++++++++++++
>  tools/perf/arch/x86/util/env.h        |  7 +++++++
>  tools/perf/arch/x86/util/evsel.c      | 16 ++--------------
>  tools/perf/arch/x86/util/mem-events.c | 19 ++-----------------
>  5 files changed, 31 insertions(+), 31 deletions(-)
>  create mode 100644 tools/perf/arch/x86/util/env.c
>  create mode 100644 tools/perf/arch/x86/util/env.h
> 
> diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
> index 195ccfdef7aa..005907cb97d8 100644
> --- a/tools/perf/arch/x86/util/Build
> +++ b/tools/perf/arch/x86/util/Build
> @@ -10,6 +10,7 @@ perf-y += evlist.o
>  perf-y += mem-events.o
>  perf-y += evsel.o
>  perf-y += iostat.o
> +perf-y += env.o
>  
>  perf-$(CONFIG_DWARF) += dwarf-regs.o
>  perf-$(CONFIG_BPF_PROLOGUE) += dwarf-regs.o
> diff --git a/tools/perf/arch/x86/util/env.c b/tools/perf/arch/x86/util/env.c
> new file mode 100644
> index 000000000000..33b87f8ac1cc
> --- /dev/null
> +++ b/tools/perf/arch/x86/util/env.c
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "linux/string.h"
> +#include "util/env.h"
> +#include "env.h"
> +
> +bool x86__is_amd_cpu(void)
> +{
> +	struct perf_env env = { .total_mem = 0, };
> +	static int is_amd; /* 0: Uninitialized, 1: Yes, -1: No */
> +
> +	if (is_amd)
> +		goto ret;
> +
> +	perf_env__cpuid(&env);
> +	is_amd = env.cpuid && strstarts(env.cpuid, "AuthenticAMD") ? 1 : -1;
> +
> +ret:
> +	return is_amd >= 1 ? true : false;
> +}
> diff --git a/tools/perf/arch/x86/util/env.h b/tools/perf/arch/x86/util/env.h
> new file mode 100644
> index 000000000000..d78f080b6b3f
> --- /dev/null
> +++ b/tools/perf/arch/x86/util/env.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _X86_ENV_H
> +#define _X86_ENV_H
> +
> +bool x86__is_amd_cpu(void);
> +
> +#endif /* _X86_ENV_H */
> diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
> index 25da46c8cca9..512c2d885d24 100644
> --- a/tools/perf/arch/x86/util/evsel.c
> +++ b/tools/perf/arch/x86/util/evsel.c
> @@ -8,6 +8,7 @@
>  #include "linux/string.h"
>  #include "evsel.h"
>  #include "util/debug.h"
> +#include "env.h"
>  
>  #define IBS_FETCH_L3MISSONLY   (1ULL << 59)
>  #define IBS_OP_L3MISSONLY      (1ULL << 16)
> @@ -78,23 +79,10 @@ void arch__post_evsel_config(struct evsel *evsel, struct perf_event_attr *attr)
>  {
>  	struct perf_pmu *evsel_pmu, *ibs_fetch_pmu, *ibs_op_pmu;
>  	static int warned_once;
> -	/* 0: Uninitialized, 1: Yes, -1: No */
> -	static int is_amd;
>  
> -	if (warned_once || is_amd == -1)
> +	if (warned_once || !x86__is_amd_cpu())
>  		return;
>  
> -	if (!is_amd) {
> -		struct perf_env *env = evsel__env(evsel);
> -
> -		if (!perf_env__cpuid(env) || !env->cpuid ||
> -		    !strstarts(env->cpuid, "AuthenticAMD")) {
> -			is_amd = -1;
> -			return;
> -		}
> -		is_amd = 1;
> -	}
> -
>  	evsel_pmu = evsel__find_pmu(evsel);
>  	if (!evsel_pmu)
>  		return;
> diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
> index 32879d12a8d5..a8a782bcb121 100644
> --- a/tools/perf/arch/x86/util/mem-events.c
> +++ b/tools/perf/arch/x86/util/mem-events.c
> @@ -5,6 +5,7 @@
>  #include "map_symbol.h"
>  #include "mem-events.h"
>  #include "linux/string.h"
> +#include "env.h"
>  
>  static char mem_loads_name[100];
>  static bool mem_loads_name__init;
> @@ -27,28 +28,12 @@ static struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX] = {
>  	E("mem-ldst",	"ibs_op//",	"ibs_op"),
>  };
>  
> -static int perf_mem_is_amd_cpu(void)
> -{
> -	struct perf_env env = { .total_mem = 0, };
> -
> -	perf_env__cpuid(&env);
> -	if (env.cpuid && strstarts(env.cpuid, "AuthenticAMD"))
> -		return 1;
> -	return -1;
> -}
> -
>  struct perf_mem_event *perf_mem_events__ptr(int i)
>  {
> -	/* 0: Uninitialized, 1: Yes, -1: No */
> -	static int is_amd;
> -
>  	if (i >= PERF_MEM_EVENTS__MAX)
>  		return NULL;
>  
> -	if (!is_amd)
> -		is_amd = perf_mem_is_amd_cpu();
> -
> -	if (is_amd == 1)
> +	if (x86__is_amd_cpu())
>  		return &perf_mem_events_amd[i];
>  
>  	return &perf_mem_events_intel[i];
> -- 
> 2.40.1
> 

-- 

- Arnaldo
