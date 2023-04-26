Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CA66EEC9F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 05:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239066AbjDZDQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 23:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234013AbjDZDQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 23:16:29 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5DE30DA
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 20:16:28 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f1950f5628so52668435e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 20:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682478986; x=1685070986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVir08Cbf9wJskp2wop7rm5AfA4zMnJc8JlkRWqm+pY=;
        b=lcqbSU1bG+4NDu22Nfl5xbh11Rzsat+yZY+zXVIK7uSCeYcmpb1ALuZkXGpRd43C9/
         a4B4ON8ASn0+nVAgJrptnG8PaMw54nQvpwQ/Rgw/tFPUXylSWrgRYvLcnl8qsGSqMTKj
         2nm2/eXv8QIOX7us8XIKhPgJxpClghibDTNJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682478986; x=1685070986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AVir08Cbf9wJskp2wop7rm5AfA4zMnJc8JlkRWqm+pY=;
        b=Vw+/y+QDX1sToeuOmbJSvzzKJxB6F7wXQjTiHUyXjYQfKaOI6F6j73sS7JQxSUT8nN
         UIMXog4M0O2F3RqArvUEjHlG8HYlrXfP3uD6PCtie9hdnERL7dsrvKPMOuCCkzAkJist
         3QLotPchxHNs9a6izEa9wF+5kEApTBqeO5/taF8Bzl454+vLO+WIKUa7NFTytAQDcA1K
         APWHoRamt/5owtQ8q483Y9+vP20XyjcvbdkvMwwbwn502YucXuHQ08JBYsu3lcrsHQuM
         i30Vm31spl01AM6moNypWlQFIksYsBLlFE31Jiuz70EJ8fhdjhLAdvoSJDLU+Lr7FDYI
         ngyw==
X-Gm-Message-State: AAQBX9fAtyTXr0IEn8I9v2QIjzv/tqNOE7jaOx7pmBYLSZdE4xJT0Ibp
        p+dsodnux8iynFgZzKv+ADKUhjdBeKIwdQYsubEJvA==
X-Google-Smtp-Source: AKy350az8IbhcGBd7M9fx/5G0HwKYLQxJAuJVtA4T2RNIoYB9S/nrMIvwBLz99M0cEIbP+r0+2Fg1+jEkkHj/maNbYY=
X-Received: by 2002:a5d:560e:0:b0:2ef:ae66:c0e3 with SMTP id
 l14-20020a5d560e000000b002efae66c0e3mr12991855wrv.12.1682478986478; Tue, 25
 Apr 2023 20:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230424134748.228137-1-james.clark@arm.com>
In-Reply-To: <20230424134748.228137-1-james.clark@arm.com>
From:   Denis Nikitin <denik@chromium.org>
Date:   Tue, 25 Apr 2023 20:16:15 -0700
Message-ID: <CADDJ8CXxR6_SHLpeX=hxZg9SbBBQ7EoN0RySATjwaSZoK2k68g@mail.gmail.com>
Subject: Re: [PATCH 0/7] perf: cs-etm: Fixes around timestamped and timeless decoding
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, coresight@lists.linaro.org,
        shy828301@gmail.com, denik@google.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks James!

Some of the patches failed to apply on ToT.

Acked-by: Denis Nikitin <denik@chromium.org>

- Denis

On Mon, Apr 24, 2023 at 6:48=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
> The first commit contains a fix for a recently introduced regression,
> but was always a shortcoming in the Coresight code anyway.
>
> The following commits are a tidyup in preparation for the last commit,
> which is a fairly major change to the decode logic that's also
> indirectly related to the regression so I thought it would be good time
> to fix that now.
>
> Applies to perf/core (9be6ab181b7b)
>
> James Clark (7):
>   perf: cs-etm: Fix timeless decode mode detection
>   perf tools: Add util function for overriding user set config values
>   perf: cs-etm: Don't test full_auxtrace because it's always set
>   perf: cs-etm: Validate options after applying them
>   perf: cs-etm: Allow user to override timestamp and contextid settings
>   perf: cs-etm: Use bool type for boolean values
>   perf: cs-etm: Add separate decode paths for timeless and per-thread
>     modes
>
>  tools/perf/arch/arm/util/cs-etm.c             | 223 +++++++++---------
>  tools/perf/arch/arm/util/pmu.c                |   2 +
>  tools/perf/arch/arm64/util/arm-spe.c          |  26 +-
>  tools/perf/arch/x86/util/intel-pt.c           |  22 +-
>  tools/perf/tests/shell/test_arm_coresight.sh  |  24 ++
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.h |   8 +-
>  tools/perf/util/cs-etm.c                      | 200 +++++++++++-----
>  tools/perf/util/cs-etm.h                      |   6 +-
>  tools/perf/util/evsel.c                       |  29 +++
>  tools/perf/util/evsel.h                       |   3 +
>  10 files changed, 325 insertions(+), 218 deletions(-)
>
> --
> 2.34.1
>
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org
