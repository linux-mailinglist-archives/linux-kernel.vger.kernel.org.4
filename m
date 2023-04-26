Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D156EF81A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 18:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241245AbjDZQGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 12:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjDZQGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 12:06:36 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157DA4EFA;
        Wed, 26 Apr 2023 09:06:35 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2472dc49239so6499378a91.1;
        Wed, 26 Apr 2023 09:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682525194; x=1685117194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmeuUjmTVHz2Yf3DbVVtEASiC3LP8S4Uh5jt1O7CKaA=;
        b=XpP1D+BavyO5pihIZh7D7K9mcD0OB78LI+QzlBwEsEZ69MrpboL7VDwvDii2ihT74z
         DB3P2X4qx9v6Rx2bMjE5SVZ4H6HHAvR+upOun8dPdTXXAkcl7nJd4lZEGzW0tdau3M76
         VbL4TwNVbA+1TZFDoLnRrX4HUQUE3fNfy0JDmQdp+Fjm9ySAOCed2BACkJfrRnyGJoDd
         WW0Hm+gIX5khCx/OMuKvg+zKFMaa4rZTA5KBNzNXyvQab0CFEyzo35dpVF8VrxVm/MRj
         Gy8Kztp02DuM9qg8slGBTRLjA846XTKpHbbrydU6MCx41DSrL0skxtaLoVcO9/zv8w41
         Bc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682525194; x=1685117194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OmeuUjmTVHz2Yf3DbVVtEASiC3LP8S4Uh5jt1O7CKaA=;
        b=PjM35z3kIlnXxlmWIQQ7veDnqF/benCrNuwyEtX0lcYn4HkDBBs80NuqX61jk6BlmU
         LkCOFkZ3X6dcNO1QgtiUaAycihCw0P5GGlwJThF4s5Uk3h5wlxetKA1XQpwZQzbWAiR5
         /Z/S7IGCbZcKUMlIHFamFague7YGMFQHf9eWCPqCUNPxz/7N/V2DTUZLjKCkYru2vxlC
         FL+irKOIY0cPu7tCEXEIqSRbEcJhUm6DekfCZVIi5T1EN2aOT+9+nqTuiu5Y1e+5gSjh
         WqUOVL8q597ltd1mD/UX3gt9+B9O3oy+WLXqbNVdWAc5MFJW62Q7fZB/AQYHAOBwC0KV
         6HGA==
X-Gm-Message-State: AAQBX9cVJph7FJFh8w2r0Vt8+Qw+6Lxf2d2NkiRkb1THIr6uNq2SJsbm
        RxnLb+w9PXZSkRJVHpCxvXDvpH2xBEJujQm53HQ=
X-Google-Smtp-Source: AKy350YrZy3rlTruwcHri22uBGC5UDj9ur2CGvC1s1k0XJ3Rq5ZTdpYdXtLMgNUUas9wnuXrXBRasCNto+oXfeHg+DA=
X-Received: by 2002:a17:90a:17e4:b0:239:ea16:5b13 with SMTP id
 q91-20020a17090a17e400b00239ea165b13mr21103730pja.14.1682525194409; Wed, 26
 Apr 2023 09:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230424134748.228137-1-james.clark@arm.com>
In-Reply-To: <20230424134748.228137-1-james.clark@arm.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 26 Apr 2023 09:06:23 -0700
Message-ID: <CAHbLzkq2WCy_vf0cXNvRT8GYZpymVRHF0J22Dfbrav6+dsusGA@mail.gmail.com>
Subject: Re: [PATCH 0/7] perf: cs-etm: Fixes around timestamped and timeless decoding
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, coresight@lists.linaro.org,
        denik@google.com, Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Thanks for working on this. I tested with perf/core branch on acme
tree, it does solve the "no samples" problem.

Please feel free to add: Tested-by: Yang Shi <shy828301@gmail.com>

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
