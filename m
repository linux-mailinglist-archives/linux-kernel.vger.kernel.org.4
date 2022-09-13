Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60EB65B6C26
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 13:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiIMLDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 07:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbiIMLDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 07:03:38 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AC4580B2;
        Tue, 13 Sep 2022 04:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663067016; x=1694603016;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RlRFv9tcot/tQwfhzKboadhEcrQNg8scVcikCi9xRI0=;
  b=M2smG6H0MVIsfgUrchUOpP1PEzFj2sJXjGihlX7dVvJo9ZcelfLK4RV8
   cPSk/0pb8xpaFfFneQaBDm6QqM5JWL1tgKlExaUOSLYe8U6e8tOTjoqGz
   vd8DlWmrV1ilBKrwcr9YUPi96sZ2J759YWTBmmgncEMM9xm+ZFKaI4BLb
   iFtQWTGy7cY5ym/Uf+Cy6rz7P6BcJP+vJsHZRzPYfcYtdQIWrLDws27ei
   zZUYK8VCI1jxCuXGphtj2ipZoUDz9Wqju6jklSr4BjuEjQ3qxprNSW7vW
   BnDK+ZnJEde17f3vb+3yW9hcnQbLeVotCU3RF+Tw2+EtNx+5zexRQYxmV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="324352280"
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="324352280"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 04:03:34 -0700
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="678521328"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.59.98])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 04:03:31 -0700
Message-ID: <f69ccb77-b60a-c901-3bec-5b8d1a518043@intel.com>
Date:   Tue, 13 Sep 2022 14:03:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 5/6] perf test: Add target workload test in perf record
 tests
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
 <20220907064645.1197894-6-namhyung@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220907064645.1197894-6-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/09/22 09:46, Namhyung Kim wrote:
> Add a subtest which profiles the given workload on the command line.
> As it's a minimal requirement, test should run ok so it doesn't skip
> the test even if it failed to run the perf record.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/shell/record.sh | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index bd4ef60948bd..ff66e58f3a26 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -167,11 +167,42 @@ test_system_wide() {
>    echo "Basic --system-wide mode test [Success]"
>  }
>  
> +test_workload() {
> +  echo "Basic target workload test"
> +  if ! perf record ${testopt} -o ${perfdata} ${testprog} 2> /dev/null
> +  then
> +    echo "Workload record [Failed record]"
> +    err=1
> +    return
> +  fi
> +  if ! perf report -i ${perfdata} -q | egrep -q ${testsym}
> +  then
> +    echo "Workload record [Failed missing output]"
> +    err=1
> +    return
> +  fi
> +  if ! perf record -e cpu-clock,cs --threads=package ${testopt} \
> +    -o ${perfdata} ${testprog} 2> /dev/null
> +  then
> +    echo "Workload record [Failed recording with threads]"
> +    err=1
> +    return
> +  fi
> +  if ! perf report -i ${perfdata} -q | egrep -q ${testsym}
> +  then
> +    echo "Workload record [Failed missing output]"

When testing, this was happening always until changing the delay
from 3 to 1 ms.  It might be a bit racy to work consistently on
different machines.

Another approach is to wait for threads to appear in /proc/N/task
like wait_for_threads() here:

	https://lore.kernel.org/linux-perf-users/20220912083412.7058-12-adrian.hunter@intel.com/T/#u


> +    err=1
> +    return
> +  fi
> +  echo "Basic target workload test [Success]"
> +}
> +
>  build_test_program
>  
>  test_per_thread
>  test_register_capture
>  test_system_wide
> +test_workload
>  
>  cleanup
>  exit $err

