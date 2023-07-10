Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DFB74DAB5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 18:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjGJQE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 12:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjGJQEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:04:54 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFA2C3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 09:04:52 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-40371070eb7so397171cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 09:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689005091; x=1691597091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQ0ChdJZ9bvsDMGFfFNVKYinco8bgguH5l8lIeF9Wb4=;
        b=aKFNT3c6Sym9xk3ozE3Ix8+OiI1n/FwQMdOYbq9gHIld7LwkpBx8vsciYETfb+k5IT
         /G7R2iz8zjG3vsG2QfbIi+7pnRW5Qp+AWsiMFwl3JE64NRGBJnXJ/hqJ/OIN2IXxwc4x
         06IwqdWorovjUkkOKB8CzCCHGm8ANj+UpumRDVUHWX86NgXj0QVJbM3rAI1iTo06wX2x
         kLjuaeouWkbApL3PRQySkOAV5JhSui5C4yoxFbJkl9+VhehYGpgvz0Cj37SIF0vl2hT9
         rrWu4AxRkVdT7UACAMQXzKZUQ4AN7KX0/MgGPeXLguxsfi5MEAkfeVyNRoQPyI1S/Ypw
         QBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689005091; x=1691597091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQ0ChdJZ9bvsDMGFfFNVKYinco8bgguH5l8lIeF9Wb4=;
        b=LT3dhv1Tda7PCjfElKYMrAhBsbhhbOkN+Xdjp0S4BH57grrUG+0jwuUj5JgnXYF5Eg
         we6OyogySXJAJVoZJ9AYTA3AxUn3PtVs54Zn3iULbhpWczmmHcPd9YPu5zrZolHvjd7V
         vG4k5HWF/xJhSUbQZTLfDYJHYpr96rMv2pOAP2NWZ7NTLAvUDxLkDaO3g/IhVZy2Wr98
         P/paYyeA9bZx/WWPpfLrOzNf/4AMWjF0LKvxvsgUTX1fZPApvCB/m3+2RSiWtU1jtzdA
         +kEXvpRvl+g1tQ2RICQnrX46tdS3ypcFr3KrOib/AvqciXWXsR+1q6bzZ8CmVqzfwPe7
         eBaQ==
X-Gm-Message-State: ABy/qLZ4rzuqa1kPdykVuXa7L6E6KNDIr37sJrdX2qn7JmLSG8Qk0v/s
        BWtmmMuFNKUu1Gx5fscEda4oaVFr1OANLSTyUcnRqw==
X-Google-Smtp-Source: APBJJlGG3emPEW9lCBmbjIZvOhY9Y2wKHO9AVCRQTb5IQmhuex38dhkY6Tx06HnSWe1fbxnzXvXNKEm2fhg/kBCXhQI=
X-Received: by 2002:a05:622a:18a9:b0:3fa:3c8f:3435 with SMTP id
 v41-20020a05622a18a900b003fa3c8f3435mr238467qtc.27.1689005091243; Mon, 10 Jul
 2023 09:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230710122138.1450930-1-james.clark@arm.com> <20230710122138.1450930-2-james.clark@arm.com>
In-Reply-To: <20230710122138.1450930-2-james.clark@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Jul 2023 09:04:40 -0700
Message-ID: <CAP-5=fVoFKTUOLL=Bo6m=3hS61mWV_PJ9dvFCGTprbH75BJh4w@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm_pmu: Add PERF_PMU_CAP_EXTENDED_HW_TYPE capability
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 5:22=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
> This capability gives us the ability to open PERF_TYPE_HARDWARE and
> PERF_TYPE_HW_CACHE events on a specific PMU for free. All the
> implementation is contained in the Perf core and tool code so no change
> to the Arm PMU driver is needed.
>
> The following basic use case now results in Perf opening the event on
> all PMUs rather than picking only one in an unpredictable way:
>
>   $ perf stat -e cycles -- taskset --cpu-list 0,1 stress -c 2
>
>    Performance counter stats for 'taskset --cpu-list 0,1 stress -c 2':
>
>          963279620      armv8_cortex_a57/cycles/                (99.19%)
>          752745657      armv8_cortex_a53/cycles/                (94.80%)
>
> Fixes: 55bcf6ef314a ("perf: Extend PERF_TYPE_HARDWARE and PERF_TYPE_HW_CA=
CHE")
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: James Clark <james.clark@arm.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  drivers/perf/arm_pmu.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 277e29fbd504..d8844a9461a2 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -875,8 +875,13 @@ struct arm_pmu *armpmu_alloc(void)
>                  * configuration (e.g. big.LITTLE). This is not an uncore=
 PMU,
>                  * and we have taken ctx sharing into account (e.g. with =
our
>                  * pmu::filter callback and pmu::event_init group validat=
ion).
> +                *
> +                * PERF_PMU_CAP_EXTENDED_HW_TYPE is required to open the =
legacy
> +                * PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE events on a
> +                * specific PMU.
>                  */
> -               .capabilities   =3D PERF_PMU_CAP_HETEROGENEOUS_CPUS | PER=
F_PMU_CAP_EXTENDED_REGS,
> +               .capabilities   =3D PERF_PMU_CAP_HETEROGENEOUS_CPUS | PER=
F_PMU_CAP_EXTENDED_REGS |
> +                                 PERF_PMU_CAP_EXTENDED_HW_TYPE,
>         };
>
>         pmu->attr_groups[ARMPMU_ATTR_GROUP_COMMON] =3D
> --
> 2.34.1
>
