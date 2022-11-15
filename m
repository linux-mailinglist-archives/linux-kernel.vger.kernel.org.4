Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F729629B78
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiKOOEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238496AbiKOOEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:04:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152452B1B8;
        Tue, 15 Nov 2022 06:04:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0CE96179B;
        Tue, 15 Nov 2022 14:04:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02317C433D7;
        Tue, 15 Nov 2022 14:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668521075;
        bh=6Qvlg1lMg7fGpa0P20E6tpgyxeNcsHw0v3LYS/R+ins=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BuVnbGVQaBDcYpT71SQqSB0uAmvRUAFOkRj21Wbt7EacCJ0FIaRRRiQ30gUhbqYyn
         hAv9PGVP4xcMdCqQc7V/nrbje1A50Wdwg4ZES0NWj+dDNOEczihuH+lh4MPLLW2pPT
         j0zIaf/kWvZHjl14AjWvXe72W76fRd/F+/IZ2nDQDXPMd4FRCCfPONz2n3mgNVpKWP
         yYaberTyw1cGR9GUf94FnGfKGcLDp4YeslxH9PEkI64JNUDrpHv1VhAkWyeTEKfhId
         vUib+maSyDdUiqKFxtmLQGRyotiTCgRA9Xn5tflkwB3TfuYwp97lW7yUPOrXu13Yna
         nAzwfaND15YXA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B7B13407ED; Tue, 15 Nov 2022 11:04:31 -0300 (-03)
Date:   Tue, 15 Nov 2022 11:04:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCHSET 00/19] perf stat: Improve perf stat output (v1)
Message-ID: <Y3Ocb2Ie4PCx2t1X@kernel.org>
References: <20221114230227.1255976-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114230227.1255976-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 14, 2022 at 03:02:08PM -0800, Namhyung Kim escreveu:
> Hello,
> 
> I'm working on cleanup up the perf stat code.  The main focus this time
> is the display logic which has various combinations of options.
> 
> I split the code for each output mode - std, csv and json.  And then
> organize them according to the purpose like header, prefix, value,
> metric and footer.  I hope this would help maintaining the code a bit
> more.
> 
> Also I found that cgroup support is missing or insufficient.
> Specifically when --for-each-cgroup option is given, it'd have multiple
> copies of the events for those cgroups.  Then the output should group
> the result.  This is true for the normal output mode, but the metric-
> only mode didn't support it well.
> 
> With this change, I can see the per-cgroup topdown metrics like below:
> 
>   $ sudo ./perf stat -a --topdown --for-each-cgroup user.slice,system.slice sleep 3
>   nmi_watchdog enabled with topdown. May give wrong results.
>   Disable with echo 0 > /proc/sys/kernel/nmi_watchdog
> 
>    Performance counter stats for 'system wide':
> 
>                                   retiring      bad speculation   frontend bound    backend bound
>   S0-D0-C0      2  user.slice            117.3%         3.9%            47.8%           -69.1%
>   S0-D0-C1      2  user.slice            119.8%         4.1%            49.3%           -73.2%
>   S0-D0-C2      2  user.slice             24.4%         7.9%            68.4%             0.0%
>   S0-D0-C3      2  user.slice             24.0%         9.2%            91.2%           -24.4%
>   S0-D0-C0      2  system.slice           73.5%         4.0%            19.4%             3.1%
>   S0-D0-C1      2  system.slice           90.0%         5.8%            19.7%           -15.5%
>   S0-D0-C2      2  system.slice          101.2%         6.6%            33.4%           -41.1%
>   S0-D0-C3      2  system.slice           90.7%         4.9%            22.3%           -18.0%
> 
>          3.001678216 seconds time elapsed
> 
> You can get it from 'perf/stat-display-v1' branch in
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

applied locally, build testing.

- Arnaldo
 
> Thanks,
> Namhyung
> 
> Namhyung Kim (19):
>   perf stat: Clear screen only if output file is a tty
>   perf stat: Split print_running() function
>   perf stat: Split print_noise_pct() function
>   perf stat: Split print_cgroup() function
>   perf stat: Split aggr_printout() function
>   perf stat: Factor out print_counter_value() function
>   perf stat: Handle bad events in abs_printout()
>   perf stat: Add before_metric argument
>   perf stat: Align cgroup names
>   perf stat: Split print_metric_headers() function
>   perf stat: Factor out prepare_interval()
>   perf stat: Cleanup interval print alignment
>   perf stat: Remove impossible condition
>   perf stat: Rework header display
>   perf stat: Move condition to print_footer()
>   perf stat: Factor out prefix display
>   perf stat: Factor out print_metric_{begin,end}()
>   perf stat: Support --for-each-cgroup and --metric-only
>   perf stat: Add print_aggr_cgroup() for --for-each-cgroup and --topdown
> 
>  tools/perf/builtin-stat.c      |   8 +
>  tools/perf/util/stat-display.c | 996 ++++++++++++++++++++-------------
>  2 files changed, 624 insertions(+), 380 deletions(-)
> 
> 
> base-commit: 7565f9617efac0c0c8e2dbd08dbe0695d56684f5
> -- 
> 2.38.1.493.g58b659f92b-goog

-- 

- Arnaldo
