Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D48C72D551
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 02:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238257AbjFMAEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 20:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjFMAEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 20:04:36 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3574171A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 17:04:34 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3f9d619103dso63921cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 17:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686614674; x=1689206674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFJb2DYUH4SPc/Q+szSqLA/RcQwAqBDcfYRno+8pMbs=;
        b=qVHT92ewJyouaKu6MMLoTf39mDMIZMOAjBtx0r7Jpbqsr3ldbcktmvTft9a5QCGjde
         vWS5CAJ4iUqojEq/8qIYpx+m1sF0a1hPNA75rzxp9buSPrUX4ARPJ2Og6xS3GTloDqsj
         AFQBbSTeojJHas0T0aGzDBfqctU3jxn+U1JhxWREccfGwEIl+LqNrZXQxoC5mzPsw2DE
         egLEnHH5iFUzlQHUpU4df6W+KK/lLzfKk2bj+KII22cyiA+1R1v+AJ5+J83mRrnrU58a
         MDVpW7Y9qwOBiWFVG7eovI5AjG1p3ZnEX9zrvRMo6mkSimwQDd5tnNogQg+qbRz8eiqX
         ybSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686614674; x=1689206674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFJb2DYUH4SPc/Q+szSqLA/RcQwAqBDcfYRno+8pMbs=;
        b=FxWpwTnfLOGSTSgSn9X/FbeSYutZ4J0Cvg+Q/Vur0B974OIJuWhOJCJOc4pYKnSGaW
         v9GoGQEA+HbJ/V0P4YXk53NaNQqnGbNVLUz37leDY4QbzRV+/7RaW0nBSSPsLN+18RZL
         2rYPGh/2jwwQSPzFnG3fVXY3Z5iNhbqGzV8kDHzsFWiLpHeHMDENzx2JUJ3TZ69VutAz
         JnvBO839yH3JXFLHZTYMgtt0DDEnDzwbJLgibDxZGdDn3+RXproo5a0RIAbAShPMuBDj
         6ECNdGfw9WXtnd0KxWO3qDAds5H+ZG728GkpEctnDT8jzNNDQ237rN1rj5k4WIHVOWoW
         wBtw==
X-Gm-Message-State: AC+VfDwA9sUW5Yl978F5RlZPRU+GyyPS5iPwBkitIVFSyO8VaZjekmzb
        +6vDz6XkPBr82Tj9Jo+2pKDrx0m85YdewdF2KPRhvQ==
X-Google-Smtp-Source: ACHHUZ6fIxnK/WgFoSTz0SP44PqYLAX1txVLnPtVREFcGCbCCxdcCF0KcpSDb4x58o/UgMZja+eg3H706VCHFM601Wg=
X-Received: by 2002:a05:622a:100c:b0:3ef:3361:75d5 with SMTP id
 d12-20020a05622a100c00b003ef336175d5mr1249qte.11.1686614673886; Mon, 12 Jun
 2023 17:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230609162625.100897-1-weilin.wang@intel.com>
In-Reply-To: <20230609162625.100897-1-weilin.wang@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 12 Jun 2023 17:04:22 -0700
Message-ID: <CAP-5=fVixzBLLiWnim8x6qcDOKH7uVfEWojTCP_H531Fhy7j-g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add metric value validation test
To:     Weilin Wang <weilin.wang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 9, 2023 at 9:26=E2=80=AFAM Weilin Wang <weilin.wang@intel.com> =
wrote:
>
> This is the second version of metric value validation tests.
>
> We made the following changes from v1 to v2:
>  - Add python setting check [Ian]
>  - Skip non-Intel architectures [Ian]
>  - Rename allowlist to skiplist [Ian]
>
> v1: https://lore.kernel.org/lkml/20230606202421.2628401-1-weilin.wang@int=
el.com/

Thanks Weilin,

when I try the test on my Tigerlake laptop I encounter an error:

```
$ sudo perf test 105 -vv
05: perf metrics value validation                                   :
--- start ---
test child forked, pid 1258192
Launch python validation script
./tools/perf/tests/shell/lib/perf_metric_validation.py
Output will be stored in: /tmp/__perf_test.program.J2u5c
Starting perf collection
Long workload: perf bench futex hash -r 2 -s
perf stat -j -M tma_mixing_vectors -a true
...
perf stat -j -M tma_retiring,tma_light_operations,tma_heavy_operations
-a perf bench futex hash -r 2
-s
# Running 'futex/hash' benchmark:
Run summary [PID 1258651]: 8 threads, each operating on 1024 [private]
futexes for 2 secs.

Averaged 953280 operations/sec (+- 1.07%), total secs =3D 2
Traceback (most recent call last):
 File "/home/irogers/kernel.org/./tools/perf/tests/shell/lib/perf_metric_va=
lidation.py",
line 571,
in <module>
   sys.exit(main())
            ^^^^^^
 File "/home/irogers/kernel.org/./tools/perf/tests/shell/lib/perf_metric_va=
lidation.py",
line 564,
in main
   ret =3D validator.test()
         ^^^^^^^^^^^^^^^^
 File "/home/irogers/kernel.org/./tools/perf/tests/shell/lib/perf_metric_va=
lidation.py",
line 522,
in test
   self.pos_val_test()
 File "/home/irogers/kernel.org/./tools/perf/tests/shell/lib/perf_metric_va=
lidation.py",
line 152,
in pos_val_test
   if val < 0:
      ^^^^^^^
TypeError: '<' not supported between instances of 'str' and 'int'
test child finished with -1
---- end ----
perf metrics value validation: FAILED!
```

Could you take a look?

Thanks,
Ian

> Weilin Wang (3):
>   perf test: Add metric value validation test
>   perf test: Add skip list for metrics known would fail
>   perf test: Rerun failed metrics with longer workload
>
>  .../tests/shell/lib/perf_metric_validation.py | 574 ++++++++++++++++++
>  .../lib/perf_metric_validation_rules.json     | 398 ++++++++++++
>  tools/perf/tests/shell/stat_metrics_values.sh |  30 +
>  3 files changed, 1002 insertions(+)
>  create mode 100644 tools/perf/tests/shell/lib/perf_metric_validation.py
>  create mode 100644 tools/perf/tests/shell/lib/perf_metric_validation_rul=
es.json
>  create mode 100755 tools/perf/tests/shell/stat_metrics_values.sh
>
>
> base-commit: 7cdda6998ee55140e64894e25048df7157344fc9
> --
> 2.39.1
>
