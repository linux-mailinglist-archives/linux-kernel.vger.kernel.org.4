Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E237396E6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 07:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjFVFil convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 22 Jun 2023 01:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjFVFij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 01:38:39 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23100171C;
        Wed, 21 Jun 2023 22:38:38 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-3fde1d6b1c4so44997821cf.0;
        Wed, 21 Jun 2023 22:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687412317; x=1690004317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Eh3Tho9G5dcHLtDGu4SUUL2wcAiMRt26dH7fPjuM3g=;
        b=CGs6ctKsBRyrFvWkYtXROB8zNet7DrMf6kP8VwColE1qVgUw+W6a1DC19NhiRUhb7e
         esnvxZsMzTvkCkhYAkUD9/SPk+Did5lEhy0C3PsDiKTLvE++Xj/gJAIr1tjfFHf9w5vU
         vT911ZZ+jyHGM9JAKfq+uJJABduE1wxYxJVNZ3fEbGvqpV177ZPxoMvsQxsFwRlNoiL4
         /zuqssAXp4hHzRGoCs0dbTq3FAui04CDwa/DmOPlLG0iqjiHQg/zks5fsbGFfg9SGWtc
         t39bMRrW3i6eVs2m6L9/+m2NwoxpDXpXycFHcabcgrphVWbk9zpey2wiIV4SM9T2Q1Tz
         KS9A==
X-Gm-Message-State: AC+VfDwjKMpa2EhLPyUS2KilOCoSdj5UPb1R34FrEcQUBMVkpf0VhlSk
        pvH1hvkoehOIJd0lDkclICAg5N6tIGG0Ab9zIWE=
X-Google-Smtp-Source: ACHHUZ4leG1iUSVkw4o0GtD+VdmQkN18H6DUCrqHTIpwTWLX8X1Kg5leF0jVXkl8x40OM/wiJJzTCPxRH/6KGyYFN70=
X-Received: by 2002:ac8:4e88:0:b0:3f3:a0c0:cd6f with SMTP id
 8-20020ac84e88000000b003f3a0c0cd6fmr23877432qtp.9.1687412317137; Wed, 21 Jun
 2023 22:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <3b0abd4a-6450-c282-65ff-ec0c7df67b03@amd.com> <20230621062359.201-1-ravi.bangoria@amd.com>
 <CAM9d7chbpiSJ6eSu9_Gs7aLZZb58gtHsvH9tsE-U4eM1eyDvKQ@mail.gmail.com> <27a64673-63f1-e438-ff17-164b008c674b@amd.com>
In-Reply-To: <27a64673-63f1-e438-ff17-164b008c674b@amd.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 21 Jun 2023 22:38:25 -0700
Message-ID: <CAM9d7ci834BsU0NBVXrFptnM924=hE46cP5qDaU6z_vpY2MTzA@mail.gmail.com>
Subject: Re: [PATCH] perf evsel amd: Fix IBS error message
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, peterz@infradead.org, irogers@google.com,
        jolsa@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 10:28 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> Hi Namhyung,
>
> On 22-Jun-23 4:03 AM, Namhyung Kim wrote:
> > Hi Ravi,
> >
> > On Tue, Jun 20, 2023 at 11:24 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
> >>
> >> AMD IBS can do per-process profiling[1] and is no longer restricted to
> >> per-cpu or systemwide only. Remove stale error message.
> >>
> >> Before:
> >>   $ sudo ./perf record -e "{ibs_op//,ibs_op//}" -C 0
> >>   Error:
> >>   AMD IBS may only be available in system-wide/per-cpu mode.
> >>   Try using -a, or -C and workload affinity
> >
> > It was strange that the -C option was given already.
>
> Hmm. evsel->core.system_wide is bit confusing for me. A Comment on it's
> definition says "irrespective of user requested CPUs or threads":
>
>         /*
>          * system_wide is for events that need to be on every CPU, irrespective
>          * of user requested CPUs or threads. Map propagation will set cpus to
>          * this event's own_cpus, whereby they will contribute to evlist
>          * all_cpus.
>          */
>         bool                     system_wide;
>
> So, I guess evsel->core.system_wide doesn't depend on -a / -C.

Right, you shouldn't check this flag.  IIRC It's used by Intel PT
for dummy events to get sideband events from every CPU
regardless of the target.

The proper check would be target__has_cpu() and it seems
the evsel__open_strerror() already checks that.

Thanks,
Namhyung


>
> >
> >>
> >> After:
> >>   $ sudo ./perf record -e "{ibs_op//,ibs_op//}" -C 0
> >>   Error:
> >>   The sys_perf_event_open() syscall returned with 22 (Invalid
> >>   argument) for event (ibs_op//).
> >>   /bin/dmesg | grep -i perf may provide additional information.
> >
> > It can run newer perf tools on an old kernel but the old error
> > message seems to be invalid anyway.  So I'm ok with removing it.
>
> Right.
>
> >>
> >> [1] https://git.kernel.org/torvalds/c/30093056f7b2
> >>
> >> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> >> ---
> >>  tools/perf/util/evsel.c | 10 +++-------
> >>  1 file changed, 3 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> >> index 356c07f03be6..65b0b70830f0 100644
> >> --- a/tools/perf/util/evsel.c
> >> +++ b/tools/perf/util/evsel.c
> >> @@ -3092,14 +3092,10 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
> >>                         return scnprintf(msg, size,
> >>         "Invalid event (%s) in per-thread mode, enable system wide with '-a'.",
> >>                                         evsel__name(evsel));
> >> -               if (is_amd(arch, cpuid)) {
> >> -                       if (is_amd_ibs(evsel)) {
> >> -                               if (evsel->core.attr.exclude_kernel)
> >> -                                       return scnprintf(msg, size,
> >> +               if (is_amd(arch, cpuid) && is_amd_ibs(evsel)) {
> >> +                       if (evsel->core.attr.exclude_kernel) {
> >> +                               return scnprintf(msg, size,
> >>         "AMD IBS can't exclude kernel events.  Try running at a higher privilege level.");
> >
> > I'm not sure if it's enough.  The IBS PMUs have CAP_NO_EXCLUDE then
> > it can't exclude user events too, right?
>
> That's correct. Let me try to fix this whole `if (is_amd())` part properly.
>
> Thanks for your feedback,
> Ravi
