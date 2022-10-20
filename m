Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D1C606C42
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 01:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJTX5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 19:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJTX5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 19:57:38 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865AC22C837
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 16:57:36 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 186-20020a1c02c3000000b003c6c154d528so3843863wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 16:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H0mgUk8pHuNN2LGzO3jLHbR7my+DG/R2XSHZQG1d+tQ=;
        b=GQP6baGtP+EPBYErGgmNhObaaaVnkritMmDJdM4Chiw4675C3aPExwrW8lJmqArKFO
         vHhPgP6Ydefb6G0kK4nEB2vBfXaWk2jHV8yc3V1hSNqgT7JNSGV5Ic2pEXSxGBTP6gG1
         QZGVS2W4uYnxlkh8LKaEkklATW4UVT8KQpJ1Pyjgj+Vdm4X4z/h8HEQa9bV5nPTHIVsG
         PqYscwX1aCi7Jw2Ynh5yhD4y87bO1wfxKWUhqVC4bAa14GgOMOH/YORjFLOqRWPU5qJq
         dPAMBfkuw7yVAiUdEDmfXu9BSOUWgcospD9BExA1Ha2mVFXpONezTdVI0D+OQKncC/rP
         BXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H0mgUk8pHuNN2LGzO3jLHbR7my+DG/R2XSHZQG1d+tQ=;
        b=Hith6CbdmdCnEDtW/Q0xFLdx0lI86eGnDupTpBIhzqnV0ePN7wPVakKiXONVUJ7irX
         PWyhS0jck7nI5uPMvLSUlvbiG7HF9x0ZP1Q0qTrpGC2hA/W52d8qegGCPjse0Q5ginlt
         GM8imW1YRukfdgQMw3uCgTdCO5d0/faGR5uODIaDTA3kCY6QdPLFuAsvrIYSqjScKWKw
         Iy5sx3S768W4zAsS3zDVA4EP4OjojL17+og9SQetoIxFtMyKTf/RJ3wqnIgOnolzVWZI
         pZdzzPgWvS65ZahBSwVPEIZt022ZA1g/TigTbtP9KscA072uHg1JBOV6wEOBhTZlzNSn
         GXHw==
X-Gm-Message-State: ACrzQf37FhsbVBD1TXmK7922v5ULJP+CII0hpgBivGNj8V5yx3AzvJsw
        YVklX/XhJ5PrD6jYvJkzKSkJDI6ugdJP1Vab0Sra1g==
X-Google-Smtp-Source: AMsMyM6hc+nFD36eoAsIU3qJo1l4LizrOoMMzLLozBscEo9C1W0QEzcXNpB3aExEUabqsg4p5mPSyM+XP/kv/G7M/4E=
X-Received: by 2002:a05:600c:314f:b0:3c7:87f:6c7d with SMTP id
 h15-20020a05600c314f00b003c7087f6c7dmr6576761wmo.149.1666310254928; Thu, 20
 Oct 2022 16:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <20221020172643.3458767-1-namhyung@kernel.org> <20221020172643.3458767-5-namhyung@kernel.org>
In-Reply-To: <20221020172643.3458767-5-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 20 Oct 2022 16:57:23 -0700
Message-ID: <CAP-5=fVehUL0YtVcn46nLNfpNr1UQ1dOvz2FixatQiDJkU3Ppw@mail.gmail.com>
Subject: Re: [PATCH 4/8] perf test: Wait for a new thread when testing
 --per-thread record
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 10:26 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Just running the target program is not enough to test multi-thread
> target because it'd be racy perf vs target startup.  I used the
> initial delay but it cannot guarantee for perf to see the thread.
>
> Instead, use wait_for_threads helper from shell/lib/waiting.sh to make
> sure it starts the sibling thread first.  Then perf record can use -p
> option to profile the target process.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/record.sh | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index 952981481239..d1640d1daf2e 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -4,6 +4,9 @@
>
>  set -e
>
> +shelldir=$(dirname "$0")
> +. "${shelldir}"/lib/waiting.sh
> +
>  err=0
>  perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
>  testprog=$(mktemp /tmp/__perf_test.prog.XXXXXX)
> @@ -96,6 +99,30 @@ test_per_thread() {
>      err=1
>      return
>    fi
> +
> +  # run the test program in background (forever)
> +  ${testprog} 1 &
> +  TESTPID=$!
> +
> +  rm -f "${perfdata}"
> +
> +  wait_for_threads ${TESTPID} 2
> +  perf record -p "${TESTPID}" --per-thread -o "${perfdata}" sleep 1 2> /dev/null
> +  kill ${TESTPID}
> +
> +  if [ ! -e "${perfdata}" ]
> +  then
> +    echo "Per-thread record [Failed record -p]"
> +    err=1
> +    return
> +  fi
> +  if ! perf report -i "${perfdata}" -q | grep -q "${testsym}"
> +  then
> +    echo "Per-thread record [Failed -p missing output]"
> +    err=1
> +    return
> +  fi
> +
>    echo "Basic --per-thread mode test [Success]"
>  }
>
> --
> 2.38.0.135.g90850a2211-goog
>
