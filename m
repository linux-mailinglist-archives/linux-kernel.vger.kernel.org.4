Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F1A68AC96
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 22:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbjBDVZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 16:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbjBDVZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 16:25:47 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94B413DF1
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 13:25:46 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d14so7368150wrr.9
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 13:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5QucXsCUGkAYvMM/m5+lQnUtugoTYxql3JyDPSNTCSc=;
        b=gMgnnl4uis9wwGEAHmp91wWTN6meZgAsGLuzViwo3jWh+ke27ZTYyh0hM2AFm3dmsl
         fpU/2t2R9T0+r+de/yRta7sMJaNAA+z/JUNyJp/3VGmj5nHedUDLMncJKnP7q/xSg7D3
         GmiVdUZ+I1Li+cl2Ky6bItiKKioQ6Zi9bu/ULaVFhvBTTZOdD5LmKGQ+OQ+Goec93wIG
         5npijm0lwYSo+Tf4foSxd4Y1YFt24OnkmqMk8pelStoDWhCh6h1kUecYwA1ZMPGcFm1S
         Bb6hdQcRQhh0pG2mNwUP4CFgsl8BDCnMNBuDJsTRBZHVVZZ1y5WnUqs8OyK7p0jyU4Fz
         8CEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5QucXsCUGkAYvMM/m5+lQnUtugoTYxql3JyDPSNTCSc=;
        b=g16mJqjXIIU89NFRzmUppJ7izM8ijOl2Gn5cZUK+wFr/biuJK9AGXr0dhBQznz6DXe
         aM5s4PYDDSfyPqDS3OE0in5AWndxAXpJZSoR3n4ApY2AazQTKWDxwzrYUfuPrRXJL35e
         YIIEUTVbJ92RK53xWa4/o7/sWHzkUsl9QYOqN/ChyVaAvgfKp9AsHU4abaGv9okDULyT
         25qGZ0gnBVbKOY4s9fPc91UsGNGiMYqGGJTlT/WsKvuPpwLCwaYqlklzToI2Gcl17870
         z+7fC3KPJhJ0qzHW+ovyha9rHWYHgC61LPjmFcEePPWuM20LKU85bhUC54sGCOJaNPo7
         7yww==
X-Gm-Message-State: AO0yUKV6JZqobKp43o09phDnjt+u37WYguuPRDSZ5h/8pNoCUYjUwqN+
        f56AnKPfEJ8rovru8SMQfWzC8ALtMXFN0nCwLfWj5A==
X-Google-Smtp-Source: AK7set9CbvgLfEJ2jn5/zRiDcIDRmDUMIjRHSnXWFoR7u6wNniF5tZuwENqZy7NCTcl7ArQhLKCbViMrWUHcVJ3zCEg=
X-Received: by 2002:a05:6000:16c4:b0:2c3:7ee6:e3ad with SMTP id
 h4-20020a05600016c400b002c37ee6e3admr632269wrf.289.1675545944934; Sat, 04 Feb
 2023 13:25:44 -0800 (PST)
MIME-Version: 1.0
References: <20230126233645.200509-1-irogers@google.com> <20230126233645.200509-16-irogers@google.com>
 <Y91rYT5eBOFUHsJK@kernel.org>
In-Reply-To: <Y91rYT5eBOFUHsJK@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 4 Feb 2023 13:25:31 -0800
Message-ID: <CAP-5=fVSVURfMiDQYL8LSnhGEQ4VSA4EcMvmW6pdfLEtJa7ZNw@mail.gmail.com>
Subject: Re: [PATCH v5 15/15] perf jevents: Run metric_test.py at compile-time
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandipan Das <sandipan.das@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linuxppc-dev@lists.ozlabs.org, Kajol Jain <kjain@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 3, 2023 at 12:15 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Jan 26, 2023 at 03:36:45PM -0800, Ian Rogers escreveu:
> > Add a target that generates a log file for running metric_test.py and
> > make this a dependency on generating pmu-events.c. The log output is
> > displayed if the test fails like (the test was modified to make it
> > fail):
> >
> > ```
> >   TEST    /tmp/perf/pmu-events/metric_test.log
> > F......
> > ======================================================================
> > FAIL: test_Brackets (__main__.TestMetricExpressions)
> > ----------------------------------------------------------------------
> > Traceback (most recent call last):
> >   File "tools/perf/pmu-events/metric_test.py", line 33, in test_Brackets
> >     self.assertEqual((a * b + c).ToPerfJson(), 'a * b + d')
> > AssertionError: 'a * b + c' != 'a * b + d'
> > - a * b + c
> > ?         ^
> > + a * b + d
>
> Added this:
>
> diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
> index 05806ecfc33c12a1..f533e76fb48002b7 100644
> --- a/tools/perf/.gitignore
> +++ b/tools/perf/.gitignore
> @@ -38,6 +38,7 @@ arch/*/include/generated/
>  trace/beauty/generated/
>  pmu-events/pmu-events.c
>  pmu-events/jevents
> +pmu-events/metric_test.log
>  feature/
>  libapi/
>  libbpf/
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index b7d9c42062300d04..bac9272682b759e9 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1103,6 +1103,7 @@ clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(
>                 $(OUTPUT)util/intel-pt-decoder/inat-tables.c \
>                 $(OUTPUT)tests/llvm-src-{base,kbuild,prologue,relocation}.c \
>                 $(OUTPUT)pmu-events/pmu-events.c \
> +               $(OUTPUT)pmu-events/metric_test.log \
>                 $(OUTPUT)$(fadvise_advice_array) \
>                 $(OUTPUT)$(fsconfig_arrays) \
>                 $(OUTPUT)$(fsmount_arrays) \

Acked, thanks!

Ian
