Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2240D5B6C5E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 13:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbiIML2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 07:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiIML2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 07:28:08 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215BC140D5;
        Tue, 13 Sep 2022 04:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663068488; x=1694604488;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lFJSry97VcpEHk7tQe7VqaRgwuUpn7inJZ/bt4fPAyY=;
  b=eOsv09eI26uHCHXin+jBIJr2tH45UmdO6NATgZlpstv7dzl/zsPuimx8
   7//YaVldI+QxB2/4z0oLN9dC2txTXR8Qsd836PUVZxUQbbCFyRR5T3o4y
   9AZj5IVcV/i+0SkBZ8SjLUBnkIqNApf9/Wv7axCrSYQmQDDvLZDkRfCzP
   BrgdBk2RLSs8183nYZJlQbWAPubyUWIA+Dyc3Gnr2yQkXzp6009ma9JPo
   5jsk1S2Wsgv8Ppt0f13ECWSoUMpYNIg1F3mwlIEG2IlO50oKcD4DChqUS
   a5/j0UjlzFEiQVd5jtYy4WeHQrHSPM/dYnWAkLcTdPPnrYmNBfoYPt4iA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="295703890"
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="295703890"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 04:28:07 -0700
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="678527823"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.59.98])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 04:28:05 -0700
Message-ID: <756848e6-19a4-d4f0-00b3-b6c945ac8dda@intel.com>
Date:   Tue, 13 Sep 2022 14:28:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 6/6] perf test: Do not set TEST_SKIP for record subtests
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
References: <20220907064645.1197894-1-namhyung@kernel.org>
 <20220907064645.1197894-7-namhyung@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220907064645.1197894-7-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/09/22 09:46, Namhyung Kim wrote:
> It now has 4 sub tests and one of them should run at least.
> But once TEST_SKIP (= 2) return value is set, it won't be overwritten
> unless there's a failure.  I think we should return success when one
> or more tested are skipped but the remaining subtests are passed.
> 
> So update the test code not to set the err variable when it skips
> the test.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

I tend to agree that the perf's default event should work.

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>


> ---
>  tools/perf/tests/shell/record.sh | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index ff66e58f3a26..487981767455 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -72,10 +72,6 @@ test_per_thread() {
>    if ! perf record -o /dev/null --quiet ${testprog} 2> /dev/null
>    then
>      echo "Per-thread record [Skipped event not supported]"
> -    if [ $err -ne 1 ]
> -    then
> -      err=2
> -    fi
>      return
>    fi
>    if ! perf record --per-thread ${testopt} -o ${perfdata} ${testprog} 2> /dev/null
> @@ -111,10 +107,6 @@ test_register_capture() {
>    if ! perf list | egrep -q 'br_inst_retired.near_call'
>    then
>      echo "Register capture test [Skipped missing event]"
> -    if [ $err -ne 1 ]
> -    then
> -      err=2
> -    fi
>      return
>    fi
>    if ! perf record --intr-regs=\? 2>&1 | egrep -q 'available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10 R11 R12 R13 R14 R15'
> @@ -139,10 +131,6 @@ test_system_wide() {
>    if ! perf record -aB --synth=no ${testopt} -o ${perfdata} ${testprog} 2> /dev/null
>    then
>      echo "System-wide record [Skipped not supported]"
> -    if [ $err -ne 1 ]
> -    then
> -      err=2
> -    fi
>      return
>    fi
>    if ! perf report -i ${perfdata} -q | egrep -q ${testsym}

