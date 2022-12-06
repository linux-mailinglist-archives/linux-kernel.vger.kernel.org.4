Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C46D643C8F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 06:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbiLFFDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 00:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiLFFC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 00:02:58 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E4FC74F
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 21:02:57 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 125-20020a1c0283000000b003d076ee89d6so10803307wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 21:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IsrGD/2+yn6YnOXfEO+xg404RVi2s4a4zlidgWfmgVk=;
        b=UiZHzgZXSObfsSVre4wJAPxgA5vSbx5ZmCST8nXSr9pmIvr51K8JFqrKXJOo6qLoZg
         gDY1xqAIa1KF5nLPH4it+F70g36bmSoHcEk+xtZmnwJpdlHp4nE9mjFDLf5CTRJoAQdF
         Gna0Pp6EH9D0m4Tahg93LOiTy2rgXAXhfz/5hZ3ZA29YbLulXVFguZYJY2OSDHy2y1XI
         CJuT8i9RTfDIzSdgoXO0G5YUtpBe51K9Kh0g1DSOKJP16ZtW1C3Ng/Hvgx+pJGhxbuqp
         82GIR1p6v2lOUnfxNbnnuvcx45LkgIgSuQFDHMeSPu0DXnGm/7xt057CQw4G58mI5rFZ
         /4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IsrGD/2+yn6YnOXfEO+xg404RVi2s4a4zlidgWfmgVk=;
        b=wu5/1hBxs8PvEOBHxmLy86cL82ucOGhYTbCi54j6j7qktlXOjm+EksZlKPnSwgdI2g
         C4AVAI5/bQidChq1i4DCF/Zcij7NJnC7pb6SmTPEzW7X4tjEMgBVqxuNPGOMtAtqh2cW
         STlrt21MUzyTwQHx6W1wNDeKuO9oXx3yk66YOLZaPig1k1kCA4BKKtoXibzGdJLg761n
         CE2qM4vyDFcNygn24KwPyzOSDq8ZkN0YWdW5BugLyBfGaRiaeZEZBtIWOlVF3vFqwP0H
         ALC3TsvWwoH7WU6T6eznbTQww42rDrh9xj3pjVQf0hDJYQblVmPpmFtf//JA4fdG5db/
         n0yg==
X-Gm-Message-State: ANoB5pn+G3OPNHhr7M7zJRL7e2zUQeIED4TX5uBhgK6ygLcYwE3pXN3E
        VziQyvt1xb1TFx6lFK68rVJwfN6U4S/qFY73DcMgPA==
X-Google-Smtp-Source: AA0mqf7utYozEKl0LYpUjOycw2vxoqkx+1UE8c8193GTqSi0P8ofsHRJcD31Vzb+xkbU07d0uajCZDc8MLjCUBS5/Tg=
X-Received: by 2002:a1c:7318:0:b0:3cf:cb16:f24a with SMTP id
 d24-20020a1c7318000000b003cfcb16f24amr64550760wmb.182.1670302976080; Mon, 05
 Dec 2022 21:02:56 -0800 (PST)
MIME-Version: 1.0
References: <20221206043237.12159-1-ravi.bangoria@amd.com>
In-Reply-To: <20221206043237.12159-1-ravi.bangoria@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 5 Dec 2022 21:02:43 -0800
Message-ID: <CAP-5=fXdx8aKyyw8wGA-xpOTqRFakaWYyGES3nq12of-xgM=AA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] perf test: Add event group test
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, kan.liang@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
        carsten.haitzler@arm.com, leo.yan@linaro.org, maddy@linux.ibm.com,
        kjain@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        tmricht@linux.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, santosh.shukla@amd.com
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

On Mon, Dec 5, 2022 at 8:33 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> Multiple events in a group can belong to one or more pmus, however
> there are some limitations to it. One of the limitation is, perf
> doesn't allow creating a group of events from different hw pmus.
> Write a simple test to create various combinations of hw, sw and
> uncore pmu events and verify group creation succeeds or fails as
> expected.
>
> v2: https://lore.kernel.org/r/20221129111946.409-1-ravi.bangoria@amd.com
> v2->v3:
>  - Define a set of uncore pmus that supports more than 3 events. This
>    will prevent false negative results by not picking random uncore
>    pmu. Test will be skipped if no uncore pmu found.

Acked-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> Ravi Bangoria (2):
>   perf tool: Move pmus list variable to new a file
>   perf test: Add event group test
>
>  tools/perf/tests/Build          |   1 +
>  tools/perf/tests/builtin-test.c |   1 +
>  tools/perf/tests/event_groups.c | 127 ++++++++++++++++++++++++++++++++
>  tools/perf/tests/tests.h        |   1 +
>  tools/perf/util/Build           |   1 +
>  tools/perf/util/pmu.c           |   2 +-
>  tools/perf/util/pmus.c          |   5 ++
>  tools/perf/util/pmus.h          |   9 +++
>  8 files changed, 146 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/tests/event_groups.c
>  create mode 100644 tools/perf/util/pmus.c
>  create mode 100644 tools/perf/util/pmus.h
>
> --
> 2.38.1
>
