Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3D5629A93
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiKONeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiKONe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:34:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617DE1DDDE;
        Tue, 15 Nov 2022 05:33:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1AA26176A;
        Tue, 15 Nov 2022 13:33:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB270C433C1;
        Tue, 15 Nov 2022 13:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668519191;
        bh=mR9plcKrNA/wfDmDB3SXakAySGJldH9p8408Zaze/3g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BQ/JrSk/D6MW7B7Q9BC+1PrE75f7ILR7klhagJxbu7xyvhOwzDG1LS+J3p0blU8h3
         8tBUupBmKwdXPUn62jRiHOqImHtAp+gMAQi1hBfHHdSP348hWq+J+xUarqIS+6Vtyb
         EdLo5etjEtcgGousJFgPcJ1ZDtP6wk3Wnb3QrLnEIysPYdEmosUz3HxVE9FijhKdh/
         RBSF2KqoUSiXVSpObKf0ESdA51d/nqxar2vfQjnLCkyBVbhpjL8LMDZGjs59ikcoD3
         YjM2aIMmxCiPyJyDZkHW+pJh4UCNzFCL/9yNBqW5z5FxVLavrRlb70vlPaxk7ysLzQ
         rX1FjmvZSNLlg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3F18F4034E; Tue, 15 Nov 2022 10:33:09 -0300 (-03)
Date:   Tue, 15 Nov 2022 10:33:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>,
        Kang Minchul <tegongkang@gmail.com>
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
Subject: Re: [PATCH v3 06/10] perf list: Simplify cache event printing
Message-ID: <Y3OVFZU8J2iCXAre@kernel.org>
References: <20221114210723.2749751-1-irogers@google.com>
 <20221114210723.2749751-7-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114210723.2749751-7-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 14, 2022 at 01:07:19PM -0800, Ian Rogers escreveu:
> The current code computes an array of cache names then sorts and
> prints them. Use a strlist to create a list of names that is
> sorted. Keep the hybrid names, it is unclear how to generalize it, but
> drop the computation of evt_pmus that is never used.

> +++ b/tools/perf/util/print-events.c
> @@ -206,137 +206,59 @@ void print_sdt_events(const char *subsys_glob, const char *event_glob,
>  
>  int print_hwcache_events(const char *event_glob, bool name_only)
>  {
> -
> -				if ((hybrid_supported == 0) ||
> -				    (hybrid_supported == npmus)) {
> -					evt_list[evt_i] = strdup(name);
> -					if (npmus > 0) {
> -						for (j = 0; j < npmus; j++)
> -							zfree(&evt_pmus[j]);
> -					}

Fixed up clash with cf9f67b36303de65 ("perf print-events: Remove redundant comparison with zero").

- Arnaldo

