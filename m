Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD85A6C1E80
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjCTRtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjCTRsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:48:04 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29D872A4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:43:24 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-3e292a249b6so131281cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679334202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXrg78CHAvQFWwunzy/sBvC4hXOal5MucBHYBTkMOtc=;
        b=qTfxowaDb3Vm9DmyrA4AMcYS/AdR88YTOLnauq1gQaQ8bGxoTGs8UmJzZvmF5Dw4qD
         0e5lnWIJgKnObCdyDs+EcyS7BFisAufEcav937GhS4fRpEs93HsWkGQ0ihMr6I9pjLeK
         L0y8/g4WXVv4/mJqMfQt7uL9oAc/+0DO9QjrhUxaryDjTDs02F0KqVxdb7obVk3tH240
         TMOH3iJsVRqtblucDXHSi76S86JpV6TITUF3AilU+zkG4PnLa5H7lYdLNU7TzWoH9bHA
         y0Iq7tC45FG2kvWrSS0lRbHfyPzupsDeNLebqfBv1900YLiOEpFo9QBmrUaTNsReYgOu
         qRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679334202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXrg78CHAvQFWwunzy/sBvC4hXOal5MucBHYBTkMOtc=;
        b=II7qA3Sv0QmOZJTfthwR0DRM5IH8PV/4nz1vX00XI5joBxyj/exdk7aSGkVxdrbZN/
         vu2YgN5aLit+b0YKwcN5gRb18J498D0XOBzpklvDjobiudYWeDlToep1ucuSXESGKXFv
         CF3IwpXnfinBHsciqyy2rnrHKHmWKWS5EZnEPt+SnA5J++YmvN+Ub1kpfgBlVazR2Kj7
         M50VB0iFdlAL8dqdQJbh/Bs+Z2kRlK5D390H28/hl0tak+q/t/fBo8gpuujLlkxO4hz9
         3AnQlKRYzEF7RxtLUPPIt11C9YE2xeCfE9/nLMKLnwIi/bdwk9Wh5qHZJMrWOMkj+oDe
         /okw==
X-Gm-Message-State: AO0yUKUElJi3D+HkgZwr+Lxq9QZo8mx7uKWYXonZTxgonTxi5aWFkhfO
        g5Ag7KH77qqEt7fRz+bwIgF9kVLmg+bS2VrOP+elLg==
X-Google-Smtp-Source: AK7set+g9keyd2/SkBVR8eY7a5R47s7uLczWHF3qlTvG0Qff8UXx4WaOh79fxawmEQKK1rywqF/k9ElVn4EWDYwdcxo=
X-Received: by 2002:a05:622a:189b:b0:3bd:f99:502e with SMTP id
 v27-20020a05622a189b00b003bd0f99502emr675564qtc.5.1679334202196; Mon, 20 Mar
 2023 10:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230320061619.29520-1-leo.yan@linaro.org>
In-Reply-To: <20230320061619.29520-1-leo.yan@linaro.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 20 Mar 2023 10:43:11 -0700
Message-ID: <CAP-5=fVBZfTrtp6OUzop3HxL-Aw80FDC+7MPS6UEwDhhfkgk_Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] perf kvm: Fix memory leak
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, Mar 19, 2023 at 11:16=E2=80=AFPM Leo Yan <leo.yan@linaro.org> wrote=
:
>
> This patch seris is to address memory leak issues in perf kvm.
>
> The first patch introduces refcnt in structure kvm_info, so we can avoid
> memory leak for it.
>
> The second patch explicitly delete histograms entries before program
> exiting rather than relying on kernel releasing memory space.
>

Series:
Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Leo Yan (2):
>   perf kvm: Support refcnt in structure kvm_info
>   perf kvm: Delete histograms entries before exiting
>
>  tools/perf/builtin-kvm.c   |  6 ++++--
>  tools/perf/util/hist.c     |  5 +++++
>  tools/perf/util/kvm-stat.h | 37 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 46 insertions(+), 2 deletions(-)
>
> --
> 2.39.2
>
