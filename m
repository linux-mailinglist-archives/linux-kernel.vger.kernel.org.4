Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7237E63DD06
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiK3SVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiK3SUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:20:43 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0839C1C13A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 10:19:03 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id m14so4526906wrh.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 10:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fgu8phfMhKqBmtg33wW3nBetrVGXeqIPlKFIzQyzHSE=;
        b=ox0llSKbUV33fVKayZ94bqh6RIiowGJSjB4lHoLTXWoY2LU97rN03LY2+LpiYKjeL/
         D9jPWzVdlXrhznZlJ1aWOpRYnPrabNfPcqyIYAp9zGyo0CH14h78qgtV2gTBcHNn5kCZ
         CmSZEzdZ+qiQ05FA2vQKfm5P+yd0apR2NNeoZwq0u0DzJhBY0QOimZyXOFTZVuNqCB9+
         LAixtDEorDow7ulWNhzFJLUYMPRPhdahTbclh9FuW6JXo0TfSQA8tnS+N5ogjKSrl9RQ
         nnD6owBMqyfpv8PdVhlxbp53JfnsO43JK9aJOTJhcj/Gk7mSEgwy4t6xR6AGB2WBcw9g
         dRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fgu8phfMhKqBmtg33wW3nBetrVGXeqIPlKFIzQyzHSE=;
        b=fuUOT4E/yu+NbTcxtBEFDvW/h70XkSHoNO/6yycwoc28cu4aPAH3k5/JfiE5e+fGDU
         QumwrWh/SRQkfuboiwBOHOEU82gUu8vGoCLpMvCzJzA7p9OUgdyzNrNeUP4ouHoXQfBl
         +HU1YYJCoNW/q4wzKrUEMpJ6l+jpc7HEOHV0mQ0QwMMM2/Xg0mGn43pgwv1NSnXbLMGr
         xmXWoR5spf8xr29x/DKshfSQY0cPNz+Z9EkOI3KeOb2jYBQKmIcnO323SDWNiX0Jo+jo
         OwcxpqvJN+hd+V9kRdldY9sgxVP1EuLtQFT9kLUYNLB4QaEtqCqn9Czkk8Vb9RnpKtkC
         u+qA==
X-Gm-Message-State: ANoB5plc7M/IxvIXZsE5V8ADOnlmYwNPp+se1yeQezXtUkkOmcQ6DlZF
        Sm6q8ZKUN3d2Q1sLaHW2bi51NL9/CkXjFIt92fq2rQ==
X-Google-Smtp-Source: AA0mqf7q8VTTrzTKldEos1qVFeXlA/uLx7N/l/591H87s4Rq0SRrdvmhSWW92FWA4Hloe92km3yhOweWjeOdf68dmYk=
X-Received: by 2002:a5d:4a8c:0:b0:242:165e:7a79 with SMTP id
 o12-20020a5d4a8c000000b00242165e7a79mr10250216wrq.343.1669832341136; Wed, 30
 Nov 2022 10:19:01 -0800 (PST)
MIME-Version: 1.0
References: <20221130111521.334152-1-james.clark@arm.com>
In-Reply-To: <20221130111521.334152-1-james.clark@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 30 Nov 2022 10:18:49 -0800
Message-ID: <CAP-5=fXAhs-xgOo9GPH-w5f1QxNBCt5pdzpC5Cr7K+ovPzdgzw@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf tests: Fix "perf stat JSON output linter" test
 for new output
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 3:15 AM James Clark <james.clark@arm.com> wrote:
>
> Commit c4b41b83c250 ("perf stat: Rename "aggregate-number" to
> "cpu-count" in JSON") renamed a field, so update the tests to reflect
> this.
>
> This fixes the following failure:
>
>   $ sudo ./perf test "json output" -vvv
>    96: perf stat JSON output linter                                    :
>   --- start ---
>   test child forked, pid 327720
>   Checking json output: no args [Success]
>   Checking json output: system wide [Success]
>   Checking json output: interval [Success]
>   Checking json output: event [Success]
>   Checking json output: per thread [Success]
>   Checking json output: per node Test failed for input:
>   ...
>   Traceback (most recent call last):
>     File "./tools/perf/tests/shell/lib/perf_json_output_lint.py", line 93, in <module>
>       check_json_output(expected_items)
>     File "./tools/perf/tests/shell/lib/perf_json_output_lint.py", line 78, in check_json_output
>       raise RuntimeError(f'Unexpected key: key={key} value={value}')
>   RuntimeError: Unexpected key: key=cpu-count value=16
>   test child finished with -1
>   ---- end ----
>   perf stat JSON output linter: FAILED!
>
> Fixes: c4b41b83c250 ("perf stat: Rename "aggregate-number" to "cpu-count" in JSON")
> Signed-off-by: James Clark <james.clark@arm.com>

Namhyung mentioned reverting change c4b41b83c250, in which case
merging this would break the test again. I think the revert is better.

Thanks,
Ian

> ---
>  tools/perf/tests/shell/lib/perf_json_output_lint.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
> index d90f8d102eb9..9c073e257d33 100644
> --- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
> +++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
> @@ -54,7 +54,7 @@ def check_json_output(expected_items):
>            raise RuntimeError(f'wrong number of fields. counted {count} expected {expected_items}'
>                               f' in \'{line}\'')
>    checks = {
> -      'aggregate-number': lambda x: isfloat(x),
> +      'cpu-count': lambda x: isfloat(x),
>        'core': lambda x: True,
>        'counter-value': lambda x: is_counter_value(x),
>        'cgroup': lambda x: True,
> --
> 2.25.1
>
