Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FA372E74F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242942AbjFMPfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243000AbjFMPex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:34:53 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CF31BEE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 08:34:48 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-3f9b7de94e7so288451cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 08:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686670487; x=1689262487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dMYlj7iUQeJ0BKLhAjf7bhCdFYI7Iu2GyDUwmySGX8=;
        b=EwaGiGbQZuTd76G9xqhhCWKOH/7AbaQrtP4AMsNOavUCFeAvUUf6YdG4pAsTAB0nv3
         wwhKffPS5ALGgXrIbI2q+uwCr9s5ZMFyb4dH0zxNcxg7vvCrnxsxnuwO9KGWjy3PHKeR
         nu2LJbFvqhciO2Vfwl2xHaAaH+z421pmBXay8Xbv845RZ26F03WSE/CyLl8T/V0R+vZF
         Js7RkR1Ao1S8voU+QupyBnVUg2bRdslBXmTjmu9RTWPiKqpXiEgyfZPtUQfHTYaJcaS1
         P11y/t6QB0hH0ZtIvcncK6bjzn7hvC/IuT2ivqDlejKecK1liz8u+1WF96FwL1qGiJti
         lFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686670487; x=1689262487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8dMYlj7iUQeJ0BKLhAjf7bhCdFYI7Iu2GyDUwmySGX8=;
        b=Z0i05uxZyOD1sg00wCGdhSMDBmqLHiR/UfcCvoFoK5Rqu1gn1ZZ64Y/bQjnldzokY9
         eLQLEm/GOsjN6IcwXz/m2c6n99jh1EjOAaWe6oJPywsd0cv7Zt+Mge60VABA7mIVfx88
         +Yleu6dzt30IogyXrPxP+GGh1HYS2V1hcw2ub1jNg14rBcWzWewN5EvcYxtEl7vVSGy0
         B+0+fEvqHYZRtsI4Jeu/MXSli+1faOxIp/c4o2k1bEGTJCrVb8rdhMyndEpAWRsUk+am
         WbE71gdJDoIrjmqL4uWeXGywwxFHeqpoAsor4BNE3Ys3vX+2NB1oiSP5bEM6LhSlVi96
         HP9A==
X-Gm-Message-State: AC+VfDwIGwjly1vqe7JPqZq/D7tOXy1i90pqpgZLwXXQcJ8DExavLssA
        kTZQffGqnaM/543nVQUox1ifEEcMrpCcF+8e9wdeWw==
X-Google-Smtp-Source: ACHHUZ6x242VmlboiolvbEgyois5rr0oH8Go03NqcPHpODBvNDFIB/csmaFDIMMDpHIlK6KOJKg1ubHmmTF2+3B5lbA=
X-Received: by 2002:a05:622a:134b:b0:3f9:56c:1129 with SMTP id
 w11-20020a05622a134b00b003f9056c1129mr106783qtk.5.1686670487234; Tue, 13 Jun
 2023 08:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230613095506.547-1-ravi.bangoria@amd.com> <20230613095506.547-5-ravi.bangoria@amd.com>
In-Reply-To: <20230613095506.547-5-ravi.bangoria@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 13 Jun 2023 08:34:35 -0700
Message-ID: <CAP-5=fVm4_BhZTx2OpR+FYo4GD3ZTFiiY1NR_4_XnDX6XHuhLQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] perf mem amd: Scan all PMUs instead of just core ones
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, jolsa@kernel.org, namhyung@kernel.org,
        mark.rutland@arm.com, peterz@infradead.org,
        adrian.hunter@intel.com, kan.liang@linux.intel.com,
        james.clark@arm.com, alisaidi@amazon.com, leo.yan@linaro.org,
        maddy@linux.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 2:56=E2=80=AFAM Ravi Bangoria <ravi.bangoria@amd.co=
m> wrote:
>
> Scanning only core PMUs is not sufficient on AMD since perf mem on
> AMD uses IBS OP PMU, which is independent of core PMU.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  tools/perf/arch/x86/util/mem-events.c |  5 +++++
>  tools/perf/util/mem-events.c          | 16 ++++++++++++----
>  tools/perf/util/mem-events.h          |  1 +
>  3 files changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/=
util/mem-events.c
> index a8a782bcb121..43af872e89a6 100644
> --- a/tools/perf/arch/x86/util/mem-events.c
> +++ b/tools/perf/arch/x86/util/mem-events.c
> @@ -91,3 +91,8 @@ char *perf_mem_events__name(int i, char *pmu_name)
>
>         return (char *)e->name;
>  }
> +
> +bool perf_mem_events__via_core_pmus(void)
> +{
> +       return !x86__is_amd_cpu();
> +}
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index be15aadb6b14..0c04f883d634 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -109,6 +109,14 @@ static bool perf_mem_event__supported(const char *mn=
t, char *sysfs_name)
>         return !stat(path, &st);
>  }
>
> +bool __weak perf_mem_events__via_core_pmus(void)
> +{
> +       return true;
> +}
> +
> +#define perf_mem_scan_next_pmu(pmu) \
> +       (perf_mem_events__via_core_pmus() ? perf_pmus__scan_core(pmu) : p=
erf_pmus__scan(pmu))
> +
>  int perf_mem_events__init(void)
>  {
>         const char *mnt =3D sysfs__mount();
> @@ -130,7 +138,7 @@ int perf_mem_events__init(void)
>                 if (!e->tag)
>                         continue;
>
> -               while ((pmu =3D perf_pmus__scan_core(pmu)) !=3D NULL) {
> +               while ((pmu =3D perf_mem_scan_next_pmu(pmu)) !=3D NULL) {
>                         scnprintf(sysfs_name, sizeof(sysfs_name), e->sysf=
s_name, pmu->name);
>                         e->supported |=3D perf_mem_event__supported(mnt, =
sysfs_name);
>                 }
> @@ -165,7 +173,7 @@ static void perf_mem_events__print_unsupport_hybrid(s=
truct perf_mem_event *e,
>         char sysfs_name[100];
>         struct perf_pmu *pmu =3D NULL;
>
> -       while ((pmu =3D perf_pmus__scan_core(pmu)) !=3D NULL) {
> +       while ((pmu =3D perf_mem_scan_next_pmu(pmu)) !=3D NULL) {

It was my mistake to optimize this, I think we can just go back to:
perf_pmus__scan(pmu)
which would remove a lot of the weak/macros etc. here. We can have a
comment as to why this is scan not scan_core, because of AMD. I plan
to further improve overhead of PMUs so I'm not worried about losing
the small performance win from this.

Thanks,
Ian

>                 scnprintf(sysfs_name, sizeof(sysfs_name), e->sysfs_name,
>                           pmu->name);
>                 if (!perf_mem_event__supported(mnt, sysfs_name)) {
> @@ -188,7 +196,7 @@ int perf_mem_events__record_args(const char **rec_arg=
v, int *argv_nr,
>                 if (!e->record)
>                         continue;
>
> -               if (perf_pmus__num_core_pmus() =3D=3D 1) {
> +               if (perf_pmus__num_mem_pmus() =3D=3D 1) {
>                         if (!e->supported) {
>                                 pr_err("failed: event '%s' not supported\=
n",
>                                        perf_mem_events__name(j, NULL));
> @@ -203,7 +211,7 @@ int perf_mem_events__record_args(const char **rec_arg=
v, int *argv_nr,
>                                 return -1;
>                         }
>
> -                       while ((pmu =3D perf_pmus__scan_core(pmu)) !=3D N=
ULL) {
> +                       while ((pmu =3D perf_mem_scan_next_pmu(pmu)) !=3D=
 NULL) {
>                                 rec_argv[i++] =3D "-e";
>                                 s =3D perf_mem_events__name(j, pmu->name)=
;
>                                 if (s) {
> diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
> index 12372309d60e..d650eb311113 100644
> --- a/tools/perf/util/mem-events.h
> +++ b/tools/perf/util/mem-events.h
> @@ -36,6 +36,7 @@ enum {
>  extern unsigned int perf_mem_events__loads_ldlat;
>
>  int perf_mem_events__parse(const char *str);
> +bool perf_mem_events__via_core_pmus(void);
>  int perf_mem_events__init(void);
>
>  char *perf_mem_events__name(int i, char *pmu_name);
> --
> 2.40.1
>
