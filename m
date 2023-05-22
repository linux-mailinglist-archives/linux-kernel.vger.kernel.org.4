Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7CF70BCEC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 14:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbjEVMHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 08:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbjEVMHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 08:07:43 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2758EA1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 05:07:42 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-64d24136685so2419302b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 05:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684757261; x=1687349261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rQchT/0lNTrw+8B0CuId0SUlnq7U6PVfXba1xiCz71w=;
        b=wca6fpXjHkjd3rjsv8N4x5KSOncS2a0VHpnNGtiD4rgVZBbKqmLjWnIGdun2rYA/Y8
         vff4t0nOJLv+32DDppIspgUMVPSoPyRDnYg1Nn7G2Txn94Bb87rwsF5tBn6ISb2TZphQ
         HSmIDap0oJXPdGavLiMT9AkoOT80M8S3khfihAGpad399PH5nZPUhOPGwBmfTpSMFdsD
         4OYK2K44TRvJOZDyhX2Pz1Ost8odRND3dzVNGMlKqfaVxaUu/aDVttcZ7BStvoPVb6pg
         kYOeXj3W5hETAxwn0fd/NIPW/6XUCFvuRvRY5d9Z6ZF6m0Llla+WfrPG+R+YuCYFZ15t
         /dqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684757261; x=1687349261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQchT/0lNTrw+8B0CuId0SUlnq7U6PVfXba1xiCz71w=;
        b=WoswUjzLq7/1YbG8fSwS+K2dL/kXlLTsQ2fPDwXb1IFCa4PuiHZ8XNHh2Pmucdx1E/
         7S/kidfjdPTLkFr/C85YDDRopv7yAKfDm9xTAmVKXyrUPKmaoz84riYuEjiQ4kmj+Ypt
         ch19lptVEj//rggh0YdoCvi/Lk+3+0MckGBsSpmmak8cOJWtGIEchL5GzjRa0A8k6lWb
         Y2vI0s26Eris5EH/Mr0qA/tSOU4QpbSwVvN+RgRY9V4UJSTSCn/c4yXY9uCe60ggF9Ru
         TYHUZiCTgekmiEKxqvXLAN9iOz2kYmBouC71fvZs4ri+BnIf+RcTlX9H3BHzUpQtvV9z
         Q+mA==
X-Gm-Message-State: AC+VfDxSKmTpHW6FzEpLpOqKTHu3ZM17m2IQNjQVoisu0SnMaEFC4qh0
        w6Rq7r4Eq8plAdvxnjLOtdO+Bg==
X-Google-Smtp-Source: ACHHUZ7FzhOI1oZLY82kXv7E96TdiFUnztouK0GLFhMQ6d59+neuCKyIRvk0N2kpg8Te/400FlOEsA==
X-Received: by 2002:a05:6a00:1d1d:b0:64d:5683:1977 with SMTP id a29-20020a056a001d1d00b0064d56831977mr5334494pfx.9.1684757261369;
        Mon, 22 May 2023 05:07:41 -0700 (PDT)
Received: from leoy-yangtze.lan ([107.151.177.126])
        by smtp.gmail.com with ESMTPSA id p7-20020a62ab07000000b00640defda6d2sm3980510pff.207.2023.05.22.05.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 05:07:40 -0700 (PDT)
Date:   Mon, 22 May 2023 20:07:29 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
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
Subject: Re: [PATCH v1 2/5] perf parse-regs: Introduce functions
 arch__reg_{ip|sp}()
Message-ID: <20230522120729.GB1826292@leoy-yangtze.lan>
References: <20230520025537.1811986-1-leo.yan@linaro.org>
 <20230520025537.1811986-3-leo.yan@linaro.org>
 <839836e8-9600-9249-dcdb-e29519335141@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <839836e8-9600-9249-dcdb-e29519335141@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 09:57:25AM +0100, James Clark wrote:
> 
> 
> On 20/05/2023 03:55, Leo Yan wrote:
> > Ideally, we want util/perf_regs.c to be general enough and doesn't bind
> > with specific architecture.
> > 
> > But since util/perf_regs.c uses the macros PERF_REG_IP and PERF_REG_SP
> > which are defined by architecture, thus util/perf_regs.c is dependent on
> > architecture header (see util/perf_regs.h includes "<perf_regs.h>", here
> > perf_regs.h is architecture specific header).
> > 
> > As a step to generalize util/perf_regs.c, this commit introduces weak
> > functions arch__reg_ip() and arch__reg_sp() and every architecture can
> > define their own functions; thus, util/perf_regs.c doesn't need to use
> > PERF_REG_IP and PERF_REG_SP anymore.
> > 
> > This is a preparation to get rid of architecture specific header from
> > util/perf_regs.h.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> [...]
> >  
> > -#define DWARF_MINIMAL_REGS ((1ULL << PERF_REG_IP) | (1ULL << PERF_REG_SP))
> > +#define DWARF_MINIMAL_REGS ((1ULL << arch__reg_ip()) | (1ULL << arch__reg_sp()))
> >  
> >  const char *perf_reg_name(int id, const char *arch);
> >  int perf_reg_value(u64 *valp, struct regs_dump *regs, int id);
> > diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
> > index bdccfc511b7e..f308f2ea512b 100644
> > --- a/tools/perf/util/unwind-libdw.c
> > +++ b/tools/perf/util/unwind-libdw.c
> > @@ -252,7 +252,7 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
> >  	if (!ui->dwfl)
> >  		goto out;
> >  
> > -	err = perf_reg_value(&ip, &data->user_regs, PERF_REG_IP);
> > +	err = perf_reg_value(&ip, &data->user_regs, arch__reg_ip());
> 
> Shouldn't it be more like this, because the weak symbols are a compile
> time thing and it's supposed to support cross arch unwinding at runtime
> (assuming something containing the arch from the file is passed down,
> like we did with perf_reg_name()):
> 
>   char *arch = perf_env__arch(evsel__env(evsel));
>   err = perf_reg_value(&ip, &data->user_regs, arch__reg_ip(arch));

Thanks for pointing out, James.

Agreed that we need to return the IP and SP register based on the
arch.  I will look into more details and spin for a new patch set for
this.

> Now I'm wondering how cross unwinding ever worked because I see
> libunwind also has something hard coded too:
> 
>   #define LIBUNWIND__ARCH_REG_SP PERF_REG_SP

Yeah, I also used arch__reg_sp() to replace PERF_REG_SP; but as you
suggestion, we should fix this with passing 'arch' parameter for
getting SP register based on arch.

Another important thing is to find a good test for cross unwinding.
Maybe I can use tools/perf/tests/shell/record.sh, function
test_register_capture() for testing registers, if you have any other
suggesion, please let me know.

Thanks,
Leo
