Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C54C62BE6F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238896AbiKPMly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbiKPMls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:41:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00D264E3;
        Wed, 16 Nov 2022 04:41:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A2A861D9C;
        Wed, 16 Nov 2022 12:41:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BFCC433C1;
        Wed, 16 Nov 2022 12:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668602506;
        bh=+QffJf1vwrSa5biws9YQZuWvKi77WepE94W+OP8tWMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UtBdDPbTy4enk9E+85aqEX15Ll2dJ+oJdm/xOnS5d0HTuttPNQSOTNG7Ny7nkd9GU
         v8c6AVuspW12CNmzp+aNe7eCYmEVQ56N+qNJ/B6Z61Jdg1SLahHxzWnHEmbKDznL4c
         WMtgorBMTI3f5yFTW/PS0LZvpW55kIrxzLXeWzrBLakmGijPJp2muEjiSVSlevD++w
         s1pmAPjoggY9Vtui259Vgo3lgVv1dtyOPyRtrhUx1szqn5yeNSo/FWsXQxDRk67mBp
         J3/ymAhAs7P6qFOZIshxsrwSpCYVICW/x2ieuYDXC6pZfDI9PiGYAwIsAoxBfPxoIX
         8SkI8qdtT9ZfA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BB4E14034E; Wed, 16 Nov 2022 09:41:43 -0300 (-03)
Date:   Wed, 16 Nov 2022 09:41:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Weilin Wang <weilin.wang@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xin Gao <gaoxin@cdjrlc.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3 10/10] perf list: Add json output option
Message-ID: <Y3Tah5Ocvx6lQ4jP@kernel.org>
References: <20221114210723.2749751-1-irogers@google.com>
 <20221114210723.2749751-11-irogers@google.com>
 <Y3OX1pcclKCgbpeT@kernel.org>
 <Y3TIG7BIzltgvCPw@kernel.org>
 <Y3TK/6bBFsHxduPc@kernel.org>
 <Y3TOwYdhzURKTgyB@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y3TOwYdhzURKTgyB@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 16, 2022 at 08:51:29AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Nov 16, 2022 at 08:35:28AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Please always run 'perf test' before and after your patches and before
> > > sending it upstream.
>  
> > Running as !root on a different machine I get some other interesting
> > info:
>  
> > ⬢[acme@toolbox perf]$  perf list syscalls:sys_enter_open*
> > double free or corruption (fasttop)
> > Aborted (core dumped)
> > ⬢[acme@toolbox perf]$
> > 
> > That is:
> > 
> >         free(ps.pmu_glob);
> > 
> > 
> > at the end of cmd_list().
> 
> This plus the change to default_ps in the subsequent patch cures the
> double free, now working on the segfault.

The segfault is "cured" with:


diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 3183c0351cda6cee..5eb9ed4a5cd0ad71 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -104,7 +104,7 @@ static void default_print_event(void *ps, const char *pmu_name, const char *topi
 	if (deprecated && !print_state->deprecated)
 		return;
 
-	if (print_state->pmu_glob && !strglobmatch(pmu_name, print_state->pmu_glob))
+	if (print_state->pmu_glob && pmu_name && !strglobmatch(pmu_name, print_state->pmu_glob))
 		return;
 
 	if (print_state->event_glob &&


----------------------------

But then:

[root@five ~]# perf list syscalls:sys_enter_open* |& grep syscalls:
  syscalls:sys_enter_open                            [Tracepoint event]
  syscalls:sys_enter_open_by_handle_at               [Tracepoint event]
  syscalls:sys_enter_open_tree                       [Tracepoint event]
  syscalls:sys_enter_openat                          [Tracepoint event]
  syscalls:sys_enter_openat2                         [Tracepoint event]
[root@five ~]#

This stops working, looking into it.

- Arnaldo
