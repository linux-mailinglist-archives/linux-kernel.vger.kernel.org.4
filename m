Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2526728F97
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 08:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjFIGBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 02:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjFIGBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 02:01:05 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CD33584
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 23:01:03 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-33d928a268eso223695ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 23:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686290463; x=1688882463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1nqF1EW9Xw6Dg19Y4kVDXlrr3m8WKbMsDEM6/70bgY=;
        b=k2CEB0SGwTwhin1kamQE/wXQGaNH0+meO2IKlg5S6EzlpcruYynoyzp3ohB0AHEqtb
         HxFsBAgGf4E0n8KU/snK6QzdG4OqTQb6ebGmmYGuWo+gFULNTaOGNx2ILwTRYlZqE4jR
         jb7gi//8LpYHMgPM8Q0i3R8YxiJUjHtRp1iJTDkt08zYa4Xu7gud8Q9XZX8rVar9sJkm
         FYwzz+NRCC9RKnK17YzaGuDOGACFtd9DHvH/v9tXm/gM3pxABXGIciuj4TXQjffIf1qT
         ZQVmPDjvSdzJKsbdNQxWx/S+0JG3WlpFO4FFGgl684VsgdJHTE90/3vg1jZxHy7RDX3I
         OP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686290463; x=1688882463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s1nqF1EW9Xw6Dg19Y4kVDXlrr3m8WKbMsDEM6/70bgY=;
        b=EQVDM0UojEXzsQe2P4Wl3vcXn7jsbq0++xMKIkNSYoIi2AHZY81LE+QSim14PkmP2k
         BytMFwRPZlz0ATPeh3YZq33pqu+jMLgMWhVodLwZWwGTECzc9S+l8jMD3jOjKIrYdurP
         DqLFwSn3FM7dpFU2QBLchRvfC1aKMUjrOoxuxK0o21aGVGAzmC5xPD9lsAlJG0vx9Yb4
         OGRD6nctlK9HcAiNDurYB0UJP/OJdN+b26VoPf2VAWVWuaS/hyaE28YH4Asw4Mv+MyT3
         MA5fGHxNcOLJZ89rq/qlp9sIv6ze+RAnQmJwn4Q88DJKvXzhXlhafuDDtJEe+0NtljCx
         ozeQ==
X-Gm-Message-State: AC+VfDxQ8GFTcRGzMVgqa5d2kGkRqjm+VbVnkninM4RE3xlkJTxB00H3
        KrH49bGh6jU59Hgtof2FdSDGWXDCCXcyPwdlHCGKKg==
X-Google-Smtp-Source: ACHHUZ7dVUka4OPg6SfqOs8yDq7/jTgCdNEXoF+87TD50HzODl4fZSvEWLI2DQ1dUK/hdVt2lS7kq1IG78+abovEohM=
X-Received: by 2002:a05:6e02:214a:b0:32a:f2a9:d1b7 with SMTP id
 d10-20020a056e02214a00b0032af2a9d1b7mr293623ilv.10.1686290463021; Thu, 08 Jun
 2023 23:01:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230527072210.2900565-1-irogers@google.com> <20230527072210.2900565-29-irogers@google.com>
 <b8efdc75-253c-ad88-f82f-90c626a26592@amd.com> <CAP-5=fXg-4NWOhOoTCfNm3aWp_rd6PWcq5NyZ7xwinbuDPUtZg@mail.gmail.com>
 <7c7d9279-25b0-328e-af41-66c2096febaa@amd.com> <CAP-5=fUPYjG2J-bxcBf8h1JW34FGQwEbSo4uDbbi+GTGmvGMtg@mail.gmail.com>
 <8a642886-89e0-b43f-d7fb-6831519ee62a@amd.com>
In-Reply-To: <8a642886-89e0-b43f-d7fb-6831519ee62a@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 8 Jun 2023 23:00:51 -0700
Message-ID: <CAP-5=fUOPWd51gihOtytS6-FvTt6jnMGFSA9nsfmGYMSN4E21Q@mail.gmail.com>
Subject: Re: [PATCH v5 28/34] perf pmus: Split pmus list into core and other
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ali Saidi <alisaidi@amazon.com>, Rob Herring <robh@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
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

On Thu, Jun 8, 2023 at 10:55=E2=80=AFPM Ravi Bangoria <ravi.bangoria@amd.co=
m> wrote:
>
> On 09-Jun-23 11:05 AM, Ian Rogers wrote:
> > On Thu, Jun 8, 2023 at 10:30=E2=80=AFPM Ravi Bangoria <ravi.bangoria@am=
d.com> wrote:
> >>
> >> On 09-Jun-23 10:10 AM, Ian Rogers wrote:
> >>> On Thu, Jun 8, 2023 at 9:01=E2=80=AFPM Ravi Bangoria <ravi.bangoria@a=
md.com> wrote:
> >>>>
> >>>> Hi Ian,
> >>>
> >>> Hi Ravi,
> >>>
> >>>> On 27-May-23 12:52 PM, Ian Rogers wrote:
> >>>>> Split the pmus list into core and other. This will later allow for
> >>>>> the core and other pmus to be populated separately.
> >>>>>
> >>>>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>>>> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> >>>>> ---
> >>>>>  tools/perf/util/pmus.c | 52 ++++++++++++++++++++++++++++++--------=
----
> >>>>>  1 file changed, 38 insertions(+), 14 deletions(-)
> >>>>>
> >>>>> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> >>>>> index 58ff7937e9b7..4ef4fecd335f 100644
> >>>>> --- a/tools/perf/util/pmus.c
> >>>>> +++ b/tools/perf/util/pmus.c
> >>>>> @@ -12,13 +12,19 @@
> >>>>>  #include "pmu.h"
> >>>>>  #include "print-events.h"
> >>>>>
> >>>>> -static LIST_HEAD(pmus);
> >>>>> +static LIST_HEAD(core_pmus);
> >>>>> +static LIST_HEAD(other_pmus);
> >>>>
> >>>> AMD ibs_fetch// and ibs_op// PMUs are per SMT-thread and are indepen=
dent of
> >>>> core hw pmu. I wonder where does IBS fit. Currently it's part of oth=
er_pmus.
> >>>> So, is it safe to assume that other_pmus are not just uncore pmus? I=
n that
> >>>> case shall we add a comment here?
> >>>
> >>> I'm a fan of comments. The code has landed in perf-tools-next:
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/t=
ools/perf/util/pmus.c?h=3Dperf-tools-next
> >>> Do you have any suggestions on wording? I've had limited success
> >>> adding glossary terms, for example, offcore vs uncore:
> >>> https://perf.wiki.kernel.org/index.php/Glossary#Offcore
> >>> I think offcore is a more interconnect related term, but I'd prefer
> >>> not to be inventing the definitions. I'd like it if we could be less
> >>> ambiguous in the code and provide useful information on the wiki, so
> >>> help appreciated :-)
> >>
> >> Does this look good?
> >>
> >> /*
> >>  * core_pmus:  A PMU belongs to core_pmus if it's name is "cpu" or it'=
s sysfs
> >>  *             directory contains "cpus" file. All PMUs belonging to c=
ore_pmus
> >>  *             must have pmu->is_core=3D1. If there are more than one =
PMUs in
> >>  *             this list, perf interprets it as a heterogeneous platfo=
rm.
> >
> >
> > Looks good but a nit here. It is heterogeneous from point-of-view of
> > PMUs, there are ARM systems where they are heterogenous with big an> li=
ttle cores but they have a single homogeneous PMU driver. The perf
> > tool will treat them as homogeneous.
>
> In that case number of entries in core_pmus list would still be 1 right?

Right. Heterogeneous platform, homogeneous PMU, single core PMU.

Thanks,
Ian

> Thanks,
> Ravi
