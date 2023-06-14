Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90C472F358
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 06:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239516AbjFNEFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 00:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbjFNEFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 00:05:20 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9591989
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 21:05:19 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-3f9d619103dso82571cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 21:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686715518; x=1689307518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIjV3lWjaQkKhtqUtY90A9oM4YHalH9AYvGghINsmAo=;
        b=Ab+rk0PFLtd1lJ/SnOCQR51a5iLHGIOJRhIdEKrg2X4QGiPyZkqyZm7yeHrAkEp2wG
         vliMnu37mLhNh1puzH2MkAMWhy0DteIErnaNQWg4GqX4QVNHz4wo7GJuZE3TrkF4KZCN
         IoEzayyO0JzhXASZtJnF1zWtKAOFDsoLEPBNSb3XnRpQfQIHPiESm50sjtShlCXXsXS8
         cJj/e7qRb2jXDGf6bodrhs7HS/oRQ++4wtMVg6575Nj66Lq1/OiBZd5N60bXgpiRFxXt
         o33LqQ7Lc/Bgdjz/Os2hm9hMjPDKvrKutuM+wg18TWhoriMy6UN/hoi7XUDYkuDPsMfU
         y2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686715518; x=1689307518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gIjV3lWjaQkKhtqUtY90A9oM4YHalH9AYvGghINsmAo=;
        b=YyxZ/p0lko8KAua4d5SS+5htVi/pLz7CanxybOZ8U0CLoTuo1NspjrhJYVum6fbXbA
         G5OZWch1m4TBRxmxA/RBFqdoq58/hfUt9KXo2343F3BLocuOpvskBFsiNXCv/pKRKXDO
         hadfik4+QteMjyU9ke8xZ7s/kyuGBQ2q81hgzVpwoUyfWrCkVSBVEgYuaTWFY5lYthEa
         ncogts1dWfXYuU8B/DNhIzV0/9j1STw59m9LttqzpDMhVQz/pk81z+8sj0MXYQiuC/7A
         ubLY/FYqZe4NeZZC1CWDJu8ee32F3oFtnGeJn0KyUcmdF2wUjTFN3RZY+1bOvuiPOFTD
         EJEA==
X-Gm-Message-State: AC+VfDwkA8kdPpbsDXNCQ35dyyPsz2JYWU39PpYBycSICAJNNlJtV/YZ
        I1+k2N+ZwnVWWRx8De93vszUKOUNBf9LlMP5ezbKnoROedwrjLkRiDtElw==
X-Google-Smtp-Source: ACHHUZ7PcxUCi6+GeOGY7IWcJYT/G2LdsUQZKXD4sWp7z4xf7uFvkgW36v0jWtxqTLRCPYgGaxNhArXBOgcPx5CdMKg=
X-Received: by 2002:a05:622a:1707:b0:3fc:7fb0:ad3a with SMTP id
 h7-20020a05622a170700b003fc7fb0ad3amr164550qtk.24.1686715518273; Tue, 13 Jun
 2023 21:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230613235416.1650755-1-irogers@google.com> <ZIkShy2yj1b0+GDv@kernel.org>
 <60477a13-1b8b-5aad-b635-73b9d8e3f734@amd.com>
In-Reply-To: <60477a13-1b8b-5aad-b635-73b9d8e3f734@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 13 Jun 2023 21:05:05 -0700
Message-ID: <CAP-5=fWc_rDCsnO13nhREa4pCxq=rKx4y0PVTR0Y0-Qud7_8dQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf tool x86: Fix perf_env memory leak
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Jun 13, 2023 at 8:24=E2=80=AFPM Ravi Bangoria <ravi.bangoria@amd.co=
m> wrote:
>
> On 14-Jun-23 6:36 AM, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Jun 13, 2023 at 04:54:16PM -0700, Ian Rogers escreveu:
> >> Found by leak sanitizer:
> >> ```
> >> =3D=3D1632594=3D=3DERROR: LeakSanitizer: detected memory leaks
> >>
> >> Direct leak of 21 byte(s) in 1 object(s) allocated from:
> >>     #0 0x7f2953a7077b in __interceptor_strdup ../../../../src/libsanit=
izer/asan/asan_interceptors.cpp:439
> >>     #1 0x556701d6fbbf in perf_env__read_cpuid util/env.c:369
> >>     #2 0x556701d70589 in perf_env__cpuid util/env.c:465
> >>     #3 0x55670204bba2 in x86__is_amd_cpu arch/x86/util/env.c:14
> >>     #4 0x5567020487a2 in arch__post_evsel_config arch/x86/util/evsel.c=
:83
> >>     #5 0x556701d8f78b in evsel__config util/evsel.c:1366
> >>     #6 0x556701ef5872 in evlist__config util/record.c:108
> >>     #7 0x556701cd6bcd in test__PERF_RECORD tests/perf-record.c:112
> >>     #8 0x556701cacd07 in run_test tests/builtin-test.c:236
> >>     #9 0x556701cacfac in test_and_print tests/builtin-test.c:265
> >>     #10 0x556701cadddb in __cmd_test tests/builtin-test.c:402
> >>     #11 0x556701caf2aa in cmd_test tests/builtin-test.c:559
> >>     #12 0x556701d3b557 in run_builtin tools/perf/perf.c:323
> >>     #13 0x556701d3bac8 in handle_internal_command tools/perf/perf.c:37=
7
> >>     #14 0x556701d3be90 in run_argv tools/perf/perf.c:421
> >>     #15 0x556701d3c3f8 in main tools/perf/perf.c:537
> >>     #16 0x7f2952a46189 in __libc_start_call_main ../sysdeps/nptl/libc_=
start_call_main.h:58
> >>
> >> SUMMARY: AddressSanitizer: 21 byte(s) leaked in 1 allocation(s).
> >> ```
> >>
> >> Fixes: daea405f5f06 ("perf tool x86: Consolidate is_amd check into sin=
gle function")
> >
> > Its a fix, yes, but it is not for this daea405f5f06 patch, he just move=
d the
> > perf_mem_is_amd_cpu(), that was leaky, to a different file, the fixes i=
s
> > for  for:
> >
> > f7b58cbdb3ff36eb ("perf mem/c2c: Add load store event mappings for
> > AMD").
> >
> > Right?
>
> Yeah that's correct "Fixes" commit. Thanks for the fix Ian!
>
> Ravi

Thanks Arnaldo and Ravi. No worries on the fix, if you build with
EXTRA_CFLAGS=3D"-fsanitize=3Daddress" then you should find "perf test" is
now passing unless a memory leak has been introduced (address
sanitizer coming with leak sanitizer).  Of course there could be
memory leaks specific to AMD so please check it out :-)

Thanks,
Ian
