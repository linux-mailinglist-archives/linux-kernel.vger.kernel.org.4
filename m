Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662CD743F88
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbjF3QPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbjF3QPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:15:06 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013BA3C21
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:15:04 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-401d1d967beso319961cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688141704; x=1690733704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiUGGvDdS8R3PBD2YgZ3X8YTYgPrxBI5qP1K5GVjXY0=;
        b=Xt8EqydTvWQR4hXsuzv+L3+naFxfOmMeXzeodf+m1VjRPytSV2y6xl4wx2mYRVD0du
         5A8K6oCZgXZ8mgVSK2AoyjmCfaUlgq5xNJQuIWRHOn7wbFP2lSy/e95M6cBOGYeKqIGi
         IirfYPpe67RjPz+UfUjWn2AQ9nGm5FpMrxIG4xvyRbo0lQK+YO8zembpl5r5drKDRT76
         jmLHylxBF4kC3c2ldIanf8hZ2b5oDkYuH2uCGvWpeMLVgQg1so2u1Hz4XplZc4D54w+L
         hT/0dr/+xCxQH+egfMiFncJWDu3CdJ0z0ozwZOOQX24Q9WfnueWjkUmnkLWooYfLBMqS
         Qp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688141704; x=1690733704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yiUGGvDdS8R3PBD2YgZ3X8YTYgPrxBI5qP1K5GVjXY0=;
        b=CANr2PbZmw9PkvS5pVEI75ZkKJF4jB9TDniKc1OWCzid3edi8RV4ZlWGXRFXFnU+7Z
         xfT5d28+sMy7+ZDqp2gN8eKwThw0JVrVf+nybduliZCTsJzs60JISv1DvY8GcKgE+vY5
         fmg1n7dwIfm0OXGAOx0ipbD2AtgdzU/4ADlOB4zE1sEVVYMaokzewP3O1yJM6GpukPWU
         LRirNwkSa1kNsDEVeSK1k6WAYa8T9iPRU15d+TsrtY1aGMd4LMgPBoQi15xjddNe3Luh
         xG2ZhYFK8/KHWjRyGwu5/jEN4KBB0vB7O6b9Y9C9EkbWgwpKsmv5HWoi4sMulEESWLde
         7phA==
X-Gm-Message-State: AC+VfDxVyc0n03qWCfYi5zSiUZjHqQc0LXlZZPffqf6tvjIBj5v0gnx/
        sR8I2Sg4xtmHruKJYzmK2Z57PJeB8i1Dd93j6l8dzQ==
X-Google-Smtp-Source: ACHHUZ6qvWQi3kNZGdcC+YAc4jK08c5yKsTf+VhsbWIHah/vsUZQqiIcOLrx14G4bqQg0c3SRJIAJkHdrlJahF74cRQ=
X-Received: by 2002:ac8:4e46:0:b0:3f8:5b2:aeec with SMTP id
 e6-20020ac84e46000000b003f805b2aeecmr847953qtw.20.1688141703923; Fri, 30 Jun
 2023 09:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230628200141.2739587-1-namhyung@kernel.org> <20230628200141.2739587-5-namhyung@kernel.org>
In-Reply-To: <20230628200141.2739587-5-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 30 Jun 2023 09:14:51 -0700
Message-ID: <CAP-5=fVMVuj2Y-ShYZwH-hetoN5ySxJfaZDJ0g29MiZ2kBpnfQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] perf test: Test perf lock contention CSV output
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 1:01=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> To verify CSV output, just check the number of separators (",") using
> the tr and wc commands like this.
>
>   grep -v "^#" ${result} | tr -d -c | wc -c
>
> Now it expects 6 columns (and 5 separators) in the output, but it may
> be changed later so count the field in the header first and compare it
> to the actual output lines.
>
>   $ cat ${result}
>   # output: contended, total wait, max wait, avg wait, type, caller
>   1, 28787, 28787, 28787, spinlock, raw_spin_rq_lock_nested+0x1b
>
> The test looks like below now:
>
>   $ sudo ./perf test -v contention
>    86: kernel lock contention analysis test                            :
>   --- start ---
>   test child forked, pid 2705822
>   Testing perf lock record and perf lock contention
>   Testing perf lock contention --use-bpf
>   Testing perf lock record and perf lock contention at the same time
>   Testing perf lock contention --threads
>   Testing perf lock contention --lock-addr
>   Testing perf lock contention --type-filter (w/ spinlock)
>   Testing perf lock contention --lock-filter (w/ tasklist_lock)
>   Testing perf lock contention --callstack-filter (w/ unix_stream)
>   Testing perf lock contention --callstack-filter with task aggregation
>   Testing perf lock contention CSV output
>   test child finished with 0
>   ---- end ----
>   kernel lock contention analysis test: Ok
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/lock_contention.sh | 36 +++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/tools/perf/tests/shell/lock_contention.sh b/tools/perf/tests=
/shell/lock_contention.sh
> index f2cc187b6186..4a194420416e 100755
> --- a/tools/perf/tests/shell/lock_contention.sh
> +++ b/tools/perf/tests/shell/lock_contention.sh
> @@ -233,6 +233,41 @@ test_aggr_task_stack_filter()
>         fi
>  }
>
> +test_csv_output()
> +{
> +       echo "Testing perf lock contention CSV output"
> +       perf lock contention -i ${perfdata} -E 1 -x , --output ${result}
> +       # count the number of commas in the header
> +       # it should have 5: contended, total-wait, max-wait, avg-wait, ty=
pe, caller
> +       header=3D$(grep "# output:" ${result} | tr -d -c , | wc -c)
> +       if [ "${header}" !=3D "5" ]; then
> +               echo "[Fail] Recorded result does not have enough output =
columns: ${header} !=3D 5"
> +               err=3D1
> +               exit
> +       fi
> +       # count the number of commas in the output
> +       output=3D$(grep -v "^#" ${result} | tr -d -c , | wc -c)
> +       if [ "${header}" !=3D "${output}" ]; then
> +               echo "[Fail] Recorded result does not match the number of=
 commas: ${header} !=3D ${output}"
> +               err=3D1
> +               exit
> +       fi
> +
> +       if ! perf lock con -b true > /dev/null 2>&1 ; then
> +               echo "[Skip] No BPF support"
> +               return
> +       fi
> +
> +       # the perf lock contention output goes to the stderr
> +       perf lock con -a -b -E 1 -x , --output ${result} -- perf bench sc=
hed messaging > /dev/null 2>&1
> +       output=3D$(grep -v "^#" ${result} | tr -d -c , | wc -c)
> +       if [ "${header}" !=3D "${output}" ]; then
> +               echo "[Fail] BPF result does not match the number of comm=
as: ${header} !=3D ${output}"
> +               err=3D1
> +               exit
> +       fi
> +}
> +
>  check
>
>  test_record
> @@ -244,5 +279,6 @@ test_type_filter
>  test_lock_filter
>  test_stack_filter
>  test_aggr_task_stack_filter
> +test_csv_output
>
>  exit ${err}
> --
> 2.41.0.255.g8b1d071c50-goog
>
