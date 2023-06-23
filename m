Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6563073C4BC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 01:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjFWXVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 19:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbjFWXVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 19:21:25 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB5A268C;
        Fri, 23 Jun 2023 16:21:24 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-be49ca27e1fso1023235276.3;
        Fri, 23 Jun 2023 16:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687562484; x=1690154484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIcDOxSgYfTWQoRXEeO2BXTTJbFMCm7RzYAzqqvmBNc=;
        b=lRm3Tn1w4WERZrYiGeQnJKhVaxTdc7BWUh4M1reqsMMoKP4b/auEpW3lop5obVq33K
         1SxhpabJEvvLijxU1Uzm4Cu05Y1766fVPRCG/hyxLamKM1jzvYlNjqZqgF8M9H6IcjkF
         l4QOw7p5HUAIJ4ifsKT1cAovFWtXYOHgeqm2vLkiAvRoqHHtvXnYoCsaKlZMDs+KA0Y/
         AJjNYMi30dPQPyZK7EHn9TObR653WJCueJRT+b/a4kvZPtGl3qX3Nd+7JkqOSmCuDlUi
         rGcsmdQed7lJHttGbG/0bKTBMflSOVYBIkZqY/PfiCrXiO1JhOUz3JxLR8VX8luJGPzz
         lZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687562484; x=1690154484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CIcDOxSgYfTWQoRXEeO2BXTTJbFMCm7RzYAzqqvmBNc=;
        b=V8ixmKXkMVy7sTvxG/FfdsMS0O+f1myGppxzsl5a3Nd66wSQZoDR0MGydKm9YUWLCG
         N8fKjaa1tjE3A6D1kkf2Ve8jo8vX6YCZaOJTjAM5IUp0WukXyriNX6IKIgaXfzh6BGXG
         VRS+/bgOKiyqS0PzB2n7AjN4pucAkCdEBVsKF87tpWIL8WkwnOAwM4azdms+Zu27JHcc
         CWOoh57PG5WHCgELJxZF69QCfj/QJz90yIuosnXn6DAe7kLq7FT95IEtx17aaMgLw+Ao
         pWHcy0vd91wfK/JgioLpe32SUyTrNNTjuSx+xP+YfbDJUGt6s9VEWvCPGiczvfshhTpP
         OKDw==
X-Gm-Message-State: AC+VfDw7cPUubEKuCVKHcT/SbZQYr5EdY3IBT3HBevvtO0Ty7Jz9dAlX
        4lhwhurhrf0F7c02kA4fC131YT5HB6+VJ6tPJeg=
X-Google-Smtp-Source: ACHHUZ4xaFsULhkJ3ijaoJIsOJ+CoLabgxJEJYfyP0l5jfcK8Omoo6a/9uSrOUhbFUsvyD+dwdRN6WnVIMiKjUHX84w=
X-Received: by 2002:a25:b190:0:b0:bd4:8ea4:39bb with SMTP id
 h16-20020a25b190000000b00bd48ea439bbmr18189014ybj.4.1687562483982; Fri, 23
 Jun 2023 16:21:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230622065351.1092893-1-anshuman.khandual@arm.com> <20230622065351.1092893-4-anshuman.khandual@arm.com>
In-Reply-To: <20230622065351.1092893-4-anshuman.khandual@arm.com>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Fri, 23 Jun 2023 16:21:12 -0700
Message-ID: <CAM9d7cgTyowSHTydOUprPMn80POvbtYetrHTA_eU-wL0B_Cr8g@mail.gmail.com>
Subject: Re: [PATCH V13 03/10] arm64/perf: Add branch stack support in struct arm_pmu
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Jun 21, 2023 at 11:55=E2=80=AFPM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> This updates 'struct arm_pmu' for branch stack sampling support being add=
ed
> later. This adds an element 'reg_trbidr' to capture BRBE attribute detail=
s.

reg_brbidr, right?

Thanks,
Namhyung


> These updates here will help in tracking any branch stack sampling suppor=
t.
>
> This also enables perf branch stack sampling event on all 'struct arm pmu=
',
> supporting the feature but after removing the current gate that blocks su=
ch
> events unconditionally in armpmu_event_init(). Instead a quick probe can =
be
> initiated via arm_pmu->has_branch_stack to ascertain the support.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Tested-by: James Clark <james.clark@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  drivers/perf/arm_pmu.c       | 3 +--
>  include/linux/perf/arm_pmu.h | 9 ++++++++-
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index aada47e3b126..d9ffe9e56e74 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -510,8 +510,7 @@ static int armpmu_event_init(struct perf_event *event=
)
>                 !cpumask_test_cpu(event->cpu, &armpmu->supported_cpus))
>                 return -ENOENT;
>
> -       /* does not support taken branch sampling */
> -       if (has_branch_stack(event))
> +       if (has_branch_stack(event) && !armpmu->has_branch_stack)
>                 return -EOPNOTSUPP;
>
>         return __hw_perf_event_init(event);
> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index f7fbd162ca4c..ba4204bdcebf 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -102,7 +102,9 @@ struct arm_pmu {
>         int             (*map_event)(struct perf_event *event);
>         void            (*sched_task)(struct perf_event_pmu_context *pmu_=
ctx, bool sched_in);
>         int             num_events;
> -       bool            secure_access; /* 32-bit ARM only */
> +       unsigned int    secure_access   : 1, /* 32-bit ARM only */
> +                       has_branch_stack: 1, /* 64-bit ARM only */
> +                       reserved        : 30;
>  #define ARMV8_PMUV3_MAX_COMMON_EVENTS          0x40
>         DECLARE_BITMAP(pmceid_bitmap, ARMV8_PMUV3_MAX_COMMON_EVENTS);
>  #define ARMV8_PMUV3_EXT_COMMON_EVENT_BASE      0x4000
> @@ -118,6 +120,11 @@ struct arm_pmu {
>
>         /* Only to be used by ACPI probing code */
>         unsigned long acpi_cpuid;
> +
> +       /* Implementation specific attributes */
> +#ifdef CONFIG_ARM64_BRBE
> +       u64             reg_brbidr;
> +#endif
>  };
>
>  #define to_arm_pmu(p) (container_of(p, struct arm_pmu, pmu))
> --
> 2.25.1
>
