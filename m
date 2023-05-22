Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A71170B830
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbjEVI6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjEVI5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:57:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2F2518F;
        Mon, 22 May 2023 01:57:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5796311FB;
        Mon, 22 May 2023 01:58:18 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 559A53F6C4;
        Mon, 22 May 2023 01:57:30 -0700 (PDT)
Message-ID: <839836e8-9600-9249-dcdb-e29519335141@arm.com>
Date:   Mon, 22 May 2023 09:57:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 2/5] perf parse-regs: Introduce functions
 arch__reg_{ip|sp}()
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>
References: <20230520025537.1811986-1-leo.yan@linaro.org>
 <20230520025537.1811986-3-leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Eric Lin <eric.lin@sifive.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Qi Liu <liuqi115@huawei.com>,
        Sandipan Das <sandipan.das@amd.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230520025537.1811986-3-leo.yan@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/05/2023 03:55, Leo Yan wrote:
> Ideally, we want util/perf_regs.c to be general enough and doesn't bind
> with specific architecture.
> 
> But since util/perf_regs.c uses the macros PERF_REG_IP and PERF_REG_SP
> which are defined by architecture, thus util/perf_regs.c is dependent on
> architecture header (see util/perf_regs.h includes "<perf_regs.h>", here
> perf_regs.h is architecture specific header).
> 
> As a step to generalize util/perf_regs.c, this commit introduces weak
> functions arch__reg_ip() and arch__reg_sp() and every architecture can
> define their own functions; thus, util/perf_regs.c doesn't need to use
> PERF_REG_IP and PERF_REG_SP anymore.
> 
> This is a preparation to get rid of architecture specific header from
> util/perf_regs.h.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
[...]
>  
> -#define DWARF_MINIMAL_REGS ((1ULL << PERF_REG_IP) | (1ULL << PERF_REG_SP))
> +#define DWARF_MINIMAL_REGS ((1ULL << arch__reg_ip()) | (1ULL << arch__reg_sp()))
>  
>  const char *perf_reg_name(int id, const char *arch);
>  int perf_reg_value(u64 *valp, struct regs_dump *regs, int id);
> diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
> index bdccfc511b7e..f308f2ea512b 100644
> --- a/tools/perf/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw.c
> @@ -252,7 +252,7 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
>  	if (!ui->dwfl)
>  		goto out;
>  
> -	err = perf_reg_value(&ip, &data->user_regs, PERF_REG_IP);
> +	err = perf_reg_value(&ip, &data->user_regs, arch__reg_ip());

Shouldn't it be more like this, because the weak symbols are a compile
time thing and it's supposed to support cross arch unwinding at runtime
(assuming something containing the arch from the file is passed down,
like we did with perf_reg_name()):

  char *arch = perf_env__arch(evsel__env(evsel));
  err = perf_reg_value(&ip, &data->user_regs, arch__reg_ip(arch));

Now I'm wondering how cross unwinding ever worked because I see
libunwind also has something hard coded too:

  #define LIBUNWIND__ARCH_REG_SP PERF_REG_SP

