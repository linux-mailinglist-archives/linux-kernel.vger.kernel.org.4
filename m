Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD8B702C8D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241609AbjEOMT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241798AbjEOMTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:19:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94065E55;
        Mon, 15 May 2023 05:19:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30861616F1;
        Mon, 15 May 2023 12:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62827C433D2;
        Mon, 15 May 2023 12:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684153159;
        bh=lJYX593ezg8Jg0Lmvi2e++axev1sq+IYiRfXvVn7TfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dp27vT5hIoFnezmC0EE7XmNQw06mriBQ1e+F1uQjMr8+D2tdoqAtKoIwku9aQYnQh
         DrpOfy1wcVDstW8ElQJfxnmWiDEg0/+PZtZ0F/EYQrRcr/2km/N+EbI+z8XZZItC23
         l2BQvLkGul8TF6jEJUwaDvPQa8th1kiKQ+Aucyt9lDCGegh3DqcdXa9figbrrF/Ska
         R7g0ndR6I0o9hQkdSoeutg/VL1WXJIXOx7hCch2U2FHsfJt2i5bQWuZLYZ2jJ9tbY8
         cBiyAEgBeKIckR1i8wBBfy3fV98iCZK6d9MgPsZ6KAv6eJWeAyl15DfuXVvC20fP2O
         faW26bG0d2Qeg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5BB06403B5; Mon, 15 May 2023 09:19:17 -0300 (-03)
Date:   Mon, 15 May 2023 09:19:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf test: Add cputype testing to perf stat
Message-ID: <ZGIjRWdxDkBBpMdA@kernel.org>
References: <20230513063447.464691-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230513063447.464691-1-irogers@google.com>
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

Em Fri, May 12, 2023 at 11:34:47PM -0700, Ian Rogers escreveu:
> Check a bogus PMU fails and that a known PMU succeeds. Limit to PMUs
> known cpu, cpu_atom and armv8_pmuv3_0 ones.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/stat.sh | 44 ++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
> index b154fbb15d54..3f1e67795490 100755
> --- a/tools/perf/tests/shell/stat.sh
> +++ b/tools/perf/tests/shell/stat.sh
> @@ -103,10 +103,54 @@ test_topdown_weak_groups() {
>    echo "Topdown weak groups test [Success]"
>  }
>  
> +test_cputype() {
> +  # Test --cputype argument.
> +  echo "cputype test"
> +
> +  # Bogus PMU should fail.
> +  if perf stat --cputype="123" -e instructions true > /dev/null 2>&1
> +  then
> +    echo "cputype test [Bogus PMU didn't fail]"
> +    err=1
> +    return
> +  fi
> +
> +  # Find a known PMU for cputype.
> +  pmu=""
> +  for i in cpu cpu_atom armv8_pmuv3_0
> +  do
> +    if test -d "/sys/devices/$i"
> +    then
> +      pmu="$i"
> +      break
> +    fi
> +    if perf stat -e "$i/instructions/" true > /dev/null 2>&1
> +    then
> +      pmu="$i"
> +      break
> +    fi
> +  done
> +  if test "x$pmu" = "x"
> +  then
> +    echo "cputype test [Skipped known PMU not found]"
> +    return
> +  fi
> +
> +  # Test running with cputype produces output.
> +  if ! perf stat --cputype="$pmu" -e instructions true 2>&1 | grep -E -q "instructions"
> +  then
> +    echo "cputype test [Failed count missed with given filter]"
> +    err=1
> +    return
> +  fi
> +  echo "cputype test [Success]"
> +}
> +
>  test_default_stat
>  test_stat_record_report
>  test_stat_record_script
>  test_stat_repeat_weak_groups
>  test_topdown_groups
>  test_topdown_weak_groups
> +test_cputype
>  exit $err
> -- 
> 2.40.1.606.ga4b1b128d6-goog
> 

-- 

- Arnaldo
