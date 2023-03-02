Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF086A8990
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCBTim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjCBTik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:38:40 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0F3166D5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 11:38:38 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id r18so231178wrx.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 11:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677785917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xd8mmUQDD7YDBjit7BkvCM2rUfsuWe0DKRJ2xHROhnA=;
        b=gm7Jo0/ui30UfldWPBkbfaDsSLJZN1a3TG/Nqn6TheqH+P7zzyfstcz0c0XS5wH7c4
         pihNBXBjs2bv68RGqr/24viCXrsaBXp6cbw8yvH23g6CELbhq957owz+8OUciywIFEtU
         61O7JBAuxlSw23RyXyveQ7UFK0K1wShEtN8K8up7xuLKkochYqe9XaJLBviocYwO7mCw
         1e4OnviqCWdtBPJkUU+8sWkHQk9udQ2FFCwpZB5LRDVZxNn9i2Q9/hRaY66dmxkn+yud
         shgYx8/nwbba+L4ixftFGxXS6UYEWP6KQRrkCV5lqNe3KGHHbkfHd7jKrV/czpRpjBa4
         C9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677785917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xd8mmUQDD7YDBjit7BkvCM2rUfsuWe0DKRJ2xHROhnA=;
        b=fJyZyvWDZ5wLkvzmDOQlRFdBYxOKKPwMuD1KYPmdazG2L4GJzBW4PFQN4rkYejCewU
         j0tpR79JjGoHjRKEMtgKe39w2K0fkkb1OfdwtRe9/dWXvM2OMgsIlmbBLi77PA3t2uwX
         sbJt8E5UsBcGHXRqDT3UkCB1gM5LFymStaJV5+VgcL0oqNIEh4DgU1wuQdgAbXbo8nLI
         2lEOx3eM4qbTNPrBeK/OtIQWMtqxNDz/N4zJNgI+pG1AYXmObSijNg+CzfYIU+wwEka0
         oioBPNtKmo0EFARt6WLkJRp8DmZMhwDgfc3z4V3pf54L/tzJAajPtazxvvAiSek8KVGh
         007A==
X-Gm-Message-State: AO0yUKXAT2KH53WB8NEodGzhJjnQ4yK6JuBXXbwVNLbf+OKpaZBZcqIs
        5aqXiEjB6eF0rOMfkb9vOAZgXIGjVaKo64LrzyRAiw==
X-Google-Smtp-Source: AK7set8YzgemtxzRriQC7Q8SF1lU5jdJaxwoOh3mFpKG71vgAxCKqjHS9tuOsgQ3by7jKKYJV8j9IGc43vVMmIozGWg=
X-Received: by 2002:a5d:6041:0:b0:2ca:c865:51b4 with SMTP id
 j1-20020a5d6041000000b002cac86551b4mr2291188wrt.9.1677785917090; Thu, 02 Mar
 2023 11:38:37 -0800 (PST)
MIME-Version: 1.0
References: <20230302041211.852330-1-irogers@google.com> <20230302041211.852330-6-irogers@google.com>
 <b7597055-5fb3-c253-f9b7-190d3daf105e@linux.intel.com>
In-Reply-To: <b7597055-5fb3-c253-f9b7-190d3daf105e@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 2 Mar 2023 11:38:23 -0800
Message-ID: <CAP-5=fXkCqSz32zA0GvLV7cQ4Xcp=MQAE6sb06pNTZf4gsPtdg@mail.gmail.com>
Subject: Re: [PATCH v1 05/10] perf evsel: Limit in group test to CPUs
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Qi Liu <liuqi115@huawei.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Mar 2, 2023 at 7:24=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
>
>
>
> On 2023-03-01 11:12 p.m., Ian Rogers wrote:
> > Don't just match on the event name, restict based on the PMU too.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/arch/x86/util/evsel.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/uti=
l/evsel.c
> > index ea3972d785d1..580b0a172136 100644
> > --- a/tools/perf/arch/x86/util/evsel.c
> > +++ b/tools/perf/arch/x86/util/evsel.c
> > @@ -61,6 +61,9 @@ bool arch_evsel__must_be_in_group(const struct evsel =
*evsel)
> >       if (!evsel__sys_has_perf_metrics(evsel))
> >               return false;
> >
> > +     if (evsel->pmu_name && strncmp(evsel->pmu_name, "cpu", 3))
> > +             return false;
>
> I'm not sure why we want to check the pmu name. It seems better to move
> it into evsel__sys_has_perf_metrics(), since perf_metrics is a core PMU
> only feature.
>
> I think the strncmp(evsel->pmu_name, "cpu", 3) is to check whether it is
> a core PMU. It is also used in other places. I think it's better to
> factor out it, e.g., arch_evsel__is_core_pmu(). It will deliver a clear
> message of what we are doing here.
>
> Thanks,
> Kan

I missed the behavior of evsel__sys_has_perf_metrics and think we can
just drop this change. We should probably rename
evsel__sys_has_perf_metrics perhaps something like
arch_evsel__pmu_has_topdown_events.

Thanks,
Ian

> > +
> >       return evsel->name &&
> >               (strcasestr(evsel->name, "slots") ||
> >                strcasestr(evsel->name, "topdown"));
