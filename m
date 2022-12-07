Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419FB6453D0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 07:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiLGGHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 01:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiLGGHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 01:07:09 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E755E578F3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 22:07:08 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id bs21so26603267wrb.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 22:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1NNlelo+bGXhdIW+f+uuoPKsjyd+V452C21PX0TjzD4=;
        b=g0Lb24cqACkLATTe+DrUsuaUC7i6XnCefnPMQGxoVYyF5A3kBch4ow7tJNoDtGGdUQ
         WHL2//34SZwyrMOQaM3fxHfpUQ+h4Ln5D1Cb1N3exJ6yHuihEHraULmXJeVhdxPo7OvV
         cIV5xo1JYwjWAG4nKAWH98k1MU66y3JNfOiOOti8NDw3qvmBG9lF8qIYRYPuFveK9Va0
         auZZv3rAd1kpd8d6ZmxRB+at8Yyf9B7kxwInqyZ2nshcCrz4wIJK02lB0YHld6WmsePd
         T/BPiack3QobARw9ZIZS2qBvGc6tcSXuUVCuEFVqiQU2mqKz4mG6z9bV0REHPu3PcL6A
         5RVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1NNlelo+bGXhdIW+f+uuoPKsjyd+V452C21PX0TjzD4=;
        b=JaJyRmy9hJwnzmyb+Ns5nbN9X109uwJkuFJ8KpZzN6E4chHOHp90XSDT6RMNlM4RBM
         fRVYzYKFUVHyuuz9mekq8qO9Vq20RbMTXKYaAZotmTXS0l5x1iKgndyal5iCiBCnAljv
         FD25Gcpmb78PuKIhRAW+0VDcguDU3eK+C4ksaCtM/eWAx7FSNXvWsAjmyDMD+HqM1v+e
         gkOWzqdzPHORNXE6DW6SpYxQ9BN8Y5xLoHP745jI1VFxSfEgTDM3wrIdERpp9uPXJYnr
         pP6uq5VzEpuhaHYNpfOyR982L/UWQNodcaS0YgJaP8YJm6yZhlzJn6JXBW5NhdsNOgfR
         S4Tw==
X-Gm-Message-State: ANoB5pn6aQCoOvaFAOUVDQsQPtGgvaAsFs2Xntt4Mif1lveiMz99XB/B
        l1GaFCqSVTZO3gC7UIX0bRYK1CQ73L65Ifx7nXeJSw==
X-Google-Smtp-Source: AA0mqf66E83vyMRKRbuhDE+5gVUOcjX4AEFyQIhIEchTMD0xax9Wn/YSIBRo9yFk3BUgDpDH8il296pATsihbC75nEU=
X-Received: by 2002:adf:f944:0:b0:236:8f54:f1f4 with SMTP id
 q4-20020adff944000000b002368f54f1f4mr55202872wrr.654.1670393227267; Tue, 06
 Dec 2022 22:07:07 -0800 (PST)
MIME-Version: 1.0
References: <20221207053007.336806-1-sandipan.das@amd.com>
In-Reply-To: <20221207053007.336806-1-sandipan.das@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 6 Dec 2022 22:06:55 -0800
Message-ID: <CAP-5=fWhqWfwTwnh5SWiLamXkuZbMnefASxkLByH6a44kdc5Bg@mail.gmail.com>
Subject: Re: [PATCH 0/4] perf vendor events amd: Add Zen 4 events and metrics
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com,
        jhladky@redhat.com, ravi.bangoria@amd.com, ananth.narayan@amd.com
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

On Tue, Dec 6, 2022 at 9:30 PM Sandipan Das <sandipan.das@amd.com> wrote:
>
> Add events and metrics taken from the Processor Programming Reference
> (PPR) for AMD Family 19h Model 11h Revision B1 processors which can be
> found at: https://www.amd.com/system/files/TechDocs/55901_0.25.zip
>
> Sandipan Das (4):
>   perf vendor events amd: Add Zen 4 mapping

Adding the mapping first may break the build until the core events are added.

Thanks,
Ian

>   perf vendor events amd: Add Zen 4 core events
>   perf vendor events amd: Add Zen 4 uncore events
>   perf vendor events amd: Add Zen 4 metrics
>
>  .../pmu-events/arch/x86/amdzen4/branch.json   |   82 ++
>  .../pmu-events/arch/x86/amdzen4/cache.json    |  772 ++++++++++++
>  .../pmu-events/arch/x86/amdzen4/core.json     |  122 ++
>  .../arch/x86/amdzen4/data-fabric.json         | 1090 +++++++++++++++++
>  .../arch/x86/amdzen4/floating-point.json      |  818 +++++++++++++
>  .../pmu-events/arch/x86/amdzen4/memory.json   |  174 +++
>  .../pmu-events/arch/x86/amdzen4/other.json    |  138 +++
>  .../pmu-events/arch/x86/amdzen4/pipeline.json |   98 ++
>  .../arch/x86/amdzen4/recommended.json         |  334 +++++
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |    3 +-
>  10 files changed, 3630 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/branch.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/core.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/data-fabric.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/floating-point.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/other.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/pipeline.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/recommended.json
>
> --
> 2.34.1
>
