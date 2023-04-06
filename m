Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51576DA27F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238860AbjDFUTm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 Apr 2023 16:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDFUTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:19:40 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46FC7290;
        Thu,  6 Apr 2023 13:19:39 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id y85so17886978iof.13;
        Thu, 06 Apr 2023 13:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680812379; x=1683404379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nESQtirJO8CnkmAWwnoB9wxgSmn5LL1wtbLJ271b460=;
        b=HAxnov6VD9KKKw73bkCs6iO05nF1ORU+iYTcA1lhEcos/aFLsBthdUfiLjCF2yDsRS
         Sehm96d8/ViCbXerOYUtCd1O069flz3CCAyizPeXxND9POnWr11HaCRW5ZLluusrcy7y
         ZuUl/B4cyUhTCHeDmB/XdDPnGzC3VIwNI4ybWFDsFrN4hVu4HOMOaksS9znbkdakG50l
         fWSXXWQ6+pA6+IxR+UWzuG9hbwY9SfKjMGmLGZDYXS1bvqqXL583nvkfV3Hj/5Y/qPCj
         2OzxwuxYwslS3dA034uRIbBGLim0j5a4c8nEa5KD2B9iTEf0/vIjMbKTVK1lUx1PvYZJ
         nhQQ==
X-Gm-Message-State: AAQBX9fGx/TIYUaE2nMFxg5TYIoPXvOD3rfOlu9naSIbg1JkwPvl+X/n
        j+ucJZtC4toSBBtvPNxn1hRAWiJWkzHSys4muwE=
X-Google-Smtp-Source: AKy350ai3CtZYHn2GaFYLBDkXcXK6r139tun33xwvHVzEV/Kvs3TE/BVNbiWZyixfD6wr6rj3qHn9dyWLDvsXJf6+1A=
X-Received: by 2002:a6b:6f0b:0:b0:75c:9437:6374 with SMTP id
 k11-20020a6b6f0b000000b0075c94376374mr60475ioc.4.1680812378848; Thu, 06 Apr
 2023 13:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230406065224.2553640-1-irogers@google.com> <20230406065224.2553640-2-irogers@google.com>
In-Reply-To: <20230406065224.2553640-2-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 6 Apr 2023 13:19:26 -0700
Message-ID: <CAM9d7chYiGavgXtWOgzQhhts3ytpePz2QVhB3Zag7yN2Ah_L8A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] perf pmu: Fix a few potential fd leaks
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        German Gomez <german.gomez@arm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 5, 2023 at 11:53 PM Ian Rogers <irogers@google.com> wrote:
>
> Ensure fd is closed on error paths.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/util/pmu.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 96ef317bac41..9eedbfc9e863 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -494,9 +494,13 @@ static int pmu_aliases_parse(int dirfd, struct list_head *head)
>                         continue;
>
>                 fd = openat(dirfd, name, O_RDONLY);
> +               if (fd == -1) {
> +                       pr_debug("Cannot open %s\n", name);
> +                       continue;
> +               }
>                 file = fdopen(fd, "r");
>                 if (!file) {
> -                       pr_debug("Cannot open %s\n", name);
> +                       close(fd);
>                         continue;
>                 }
>
> @@ -1882,9 +1886,13 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
>                         continue;
>
>                 fd = openat(caps_fd, name, O_RDONLY);
> +               if (fd == -1)
> +                       continue;
>                 file = fdopen(fd, "r");
> -               if (!file)
> +               if (!file) {
> +                       close(fd);
>                         continue;
> +               }
>
>                 if (!fgets(value, sizeof(value), file) ||
>                     (perf_pmu__new_caps(&pmu->caps, name, value) < 0)) {
> --
> 2.40.0.348.gf938b09366-goog
>
