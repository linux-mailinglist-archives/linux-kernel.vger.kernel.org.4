Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65935EADB6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiIZRLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiIZRLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:11:11 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05CF422FC;
        Mon, 26 Sep 2022 09:20:09 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1279948d93dso9862666fac.10;
        Mon, 26 Sep 2022 09:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Kv0hAbAuMDhiwxda9Nahgcb504NbJJsHBppTCWLGHHk=;
        b=SpoOKxBMaiTuhWXtVbUqEjpWyrv7n+qAaH/V+5IVnZgVAWLgE2IWmZ+ZHBfz6fXxhf
         WzsbVFUZRbRGwEIEOo7ep+zdDzDLQJ3cHLfI7s9Uqoaxey8wDYcFyz18+YI1kPeghl5i
         FXE1Gp6uoo2b9C1sqITlN67QObndrIVo47E5TyA6nCDI+wiL9MIr66zKVDVt46Iqx54e
         FMOAmcOfz2kmk6hgmi3FDbY1A9apNxxL4gwKj4h70Wcyp9tOoj+qPo1IKntxlgueqlst
         DgW6kBZPO6LifE/pihwrxw/eGmiYX7o0WCoM867m7EkKfpb3KG8WQjO4bFqOUpZ2diWA
         2MZA==
X-Gm-Message-State: ACrzQf0HaEGcVcylP2MzTVRlYH8se2yrhKUQzz5xgc/NxUgLVuvW+Twp
        nRGXf2BwdAVj+JYX8J1FzWpA+QOAvu/Olwk2gJY=
X-Google-Smtp-Source: AMsMyM5Q/npal10pqlSTDATxeYfQgb/WeFnBXBfvmtNLmcHtmNAEuhq2WyMJ8EtkN3Iz6dih+p2IBRyznVjd5MCjK9c=
X-Received: by 2002:a05:6870:524b:b0:12c:cfd2:81c0 with SMTP id
 o11-20020a056870524b00b0012ccfd281c0mr12345018oai.209.1664209208682; Mon, 26
 Sep 2022 09:20:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220903000210.1112014-1-namhyung@kernel.org> <CANpmjNMPh5QjdxXtrCc5FApjgzV=81CNNiwbeg_rE3NxN_WCZw@mail.gmail.com>
 <c4f7e14b-a229-6b23-b28d-880b8369e6d8@arm.com>
In-Reply-To: <c4f7e14b-a229-6b23-b28d-880b8369e6d8@arm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 26 Sep 2022 09:19:59 -0700
Message-ID: <CAM9d7ch36RGYJJEg2dnrauQnVX_f9MiE0RB99EU4ynNL-8CUVA@mail.gmail.com>
Subject: Re: [PATCH] perf test: Skip sigtrap test on old kernels
To:     James Clark <james.clark@arm.com>
Cc:     Marco Elver <elver@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Sep 26, 2022 at 8:06 AM James Clark <james.clark@arm.com> wrote:
>
>
>
> On 03/09/2022 07:52, Marco Elver wrote:
> > On Sat, 3 Sept 2022 at 02:02, Namhyung Kim <namhyung@kernel.org> wrote:
> >>
> >> If it runs on an old kernel, perf_event_open would fail because of the
> >> new fields sigtrap and sig_data.  Just skip the test if it failed.
> >>
> >> Cc: Marco Elver <elver@google.com>
> >> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> >> ---
> >>  tools/perf/tests/sigtrap.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
> >> index e32ece90e164..7057566e6ae4 100644
> >> --- a/tools/perf/tests/sigtrap.c
> >> +++ b/tools/perf/tests/sigtrap.c
> >> @@ -140,6 +140,7 @@ static int test__sigtrap(struct test_suite *test __maybe_unused, int subtest __m
> >>         fd = sys_perf_event_open(&attr, 0, -1, -1, perf_event_open_cloexec_flag());
> >>         if (fd < 0) {
> >>                 pr_debug("FAILED sys_perf_event_open(): %s\n", str_error_r(errno, sbuf, sizeof(sbuf)));
> >> +               ret = TEST_SKIP;
> >
> > Wouldn't we be interested if perf_event_open() fails because it could
> > actually be a bug? By skipping we'll be more likely to miss the fact
> > there's a real problem.
> >
> > That's my naive thinking at least - what do other perf tests usually
> > do in this case?
>
> I missed this discussion but I just submitted a patch with a similar
> issue [1]. To me, it doesn't make sense to have the tests pass on older
> kernels if this lowers the value of the tests by accepting possibly
> invalid values. If you want to test older kernels then just use older
> tests, but maybe there is some use case that I'm not aware of.

Thanks for your opinion.  But my test environment is running the tests
on random machines which may run some old kernel.  I agree that it
should not skip the real problems but I think we can find a good way
to detect old, unsupported kernels reliably like using BTF.

Thanks,
Namhyung
