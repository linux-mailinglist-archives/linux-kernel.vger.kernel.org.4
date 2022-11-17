Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E1562E7CF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241246AbiKQWJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240620AbiKQWIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:08:50 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD9C84300
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:08:23 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id l14so6204493wrw.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7/FTKNAmP6F3iAI6A3xeaew/xWrn0EKEXsTY8o2IBRY=;
        b=hT9jf1YBUrY2/GUlTJ1sNhW99XnZkk1OVcjVRnVj0nUDpXf1Tbg0ovhIzvWi0lH9qC
         l2npItjf5TRqGNoB75JC30SRzoPUtEHJZCki7dL/VF7ghubyOwvw8sq14Y3fHaufOap/
         cRMHP0UjqQ9hWNImTTs7ZO1YWd/tdzysaXsU9YmBmDdsSpkEORBrid7B4sFfqNSDBNqc
         +3+lWC4zZOR+yz8nLV3ddJeahpv3HtxvxTfhLXuaWc7FewzlOst0Un/RCWpcGxBYhpUI
         1Gk8dzzBp5CIZHgsYko442p61qWBpYkN1GpaUrf//msPaNzDf1cE/ugBPAZnbGXucHQ6
         YiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7/FTKNAmP6F3iAI6A3xeaew/xWrn0EKEXsTY8o2IBRY=;
        b=BI5uzoVGzx4aIPn8L/7N1oeabNnvcJclug5aF83vPUXOtiwfD8L5l0QPZUceTkS3qZ
         JDatZ2geV7/zqgE+vpT4NZ6rsK3raAxk7zucdm+FhdkMkZXV2NJZEf6seh/O5iJetmDd
         K9yUQGywB0SLLESq7Mx2NuKkDh1s9CKmsiRsz+9LkisOfsXsgg2JSSBDKiVwR7w8Cdip
         Zxv4YBjfro53hOvPWVfXW9QKbHrWdLfp91FqPOZQgQGFWDsWnPUzg65KDFRv1fDfGl2O
         hXB3pA/maXzJDudFxMW6Oe+ncM+JQORM3CMTa7R+ZVdw0mEgc0OykOSb2OOoWGXYCPIT
         JtqQ==
X-Gm-Message-State: ANoB5pkSG6dIfWdQhktnlu2/Q9hNVyfq1BxqjAqCZDkHc5LajXXXeQ8Y
        sy07AfhzCpR9/rBzoJH+FI1sysKeRHzDPkgOrsKIJA==
X-Google-Smtp-Source: AA0mqf7VR+RYn9Xb12dyPHx7g/uaDcUS/zlSYV5fXtRVeSi+ehk7hS0Q/dpJEF2vNXhTnpDSJknubw/rfoJbi4y8YMs=
X-Received: by 2002:adf:f6cc:0:b0:228:dd1d:8a42 with SMTP id
 y12-20020adff6cc000000b00228dd1d8a42mr2701812wrp.375.1668722901599; Thu, 17
 Nov 2022 14:08:21 -0800 (PST)
MIME-Version: 1.0
References: <20221012164244.3027730-1-irogers@google.com> <CAP-5=fW5+boUZqJV6-6VVa2bOcTrErHU3K5Fz-Z54j8uq_kfdw@mail.gmail.com>
 <Y21Hdoc8KsvNMbTQ@kernel.org> <CAP-5=fXbjk31SvZNVzo5x0uDnVndw7Z=BFPah9Dgx=AULkTPaA@mail.gmail.com>
 <f3e704f9-988c-e01f-eb40-13aa405e2857@oracle.com> <259f8e47-bd58-c8dc-c3fd-12e8dd5d013d@oracle.com>
In-Reply-To: <259f8e47-bd58-c8dc-c3fd-12e8dd5d013d@oracle.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 17 Nov 2022 14:08:09 -0800
Message-ID: <CAP-5=fV-pfdSP+L4+Gr0D_+MO9bAOSd3s1_2Ayahg5vcqC66HQ@mail.gmail.com>
Subject: Re: [External] : Re: RFC Re: [PATCH v2] perf jevents: Parse metrics
 during conversion
To:     John Garry <john.g.garry@oracle.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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

On Thu, Nov 17, 2022 at 10:16 AM John Garry <john.g.garry@oracle.com> wrote:
>
> On 15/11/2022 17:35, John Garry wrote:
> > On 15/11/2022 17:26, Ian Rogers wrote:
> >> On Thu, Nov 10, 2022 at 10:48 AM Arnaldo Carvalho de Melo
> >> <acme@kernel.org> wrote:
> >>>
> >>> Em Fri, Oct 28, 2022 at 10:57:02AM -0700, Ian Rogers escreveu:
> >>>> On Wed, Oct 12, 2022 at 9:42 AM Ian Rogers <irogers@google.com> wrote:
> >>>>>
> >>>>> Currently the 'MetricExpr' json value is passed from the json
> >>>>> file to the pmu-events.c. This change introduces an expression
> >>>>> tree that is parsed into. The parsing is done largely by using
> >>>>> operator overloading and python's 'eval' function. Two advantages
> >>>>> in doing this are:
> >>>>>
> >>>>> 1) Broken metrics fail at compile time rather than relying on
> >>>>>     `perf test` to detect. `perf test` remains relevant for checking
> >>>>>     event encoding and actual metric use.
> >>>>>
> >>>>> 2) The conversion to a string from the tree can minimize the
> >>>>>     metric's string size, for example, preferring 1e6 over 1000000
> >>>>>     and removing unnecessary whitespace. On x86 this reduces the
> >>>>>     string size by 2,823bytes (0.06%).
> >>>>>
> >>>>> In future changes it would be possible to programmatically
> >>>>> generate the json expressions (a single line of text and so a
> >>>>> pain to write manually) for an architecture using the expression
> >>>>> tree. This could avoid copy-pasting metrics for all architecture
> >>>>> variants.
> >>>>>
> >>>>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>>>
> >>>> Ping, PTAL.
> >>>
> >>> That would be really nice if people working with JSON, metrics, could
> >>> take a look at Ian's work and test it with their files, volunteers?
> >>
> >> Perhaps John could help?
> >
> > I'll have a look soon. I have to admit that I have not been tracking the
> > jevents changes as close as before.
>
> At least I can try to test it... so we support python 3.6 and later, right?
>
> I have 3.6 and acme perf/core generated pmu-events.c is ok for me, but
> this patch causes an error:
>
>    GEN     pmu-events/pmu-events.c
>   PERF_VERSION = 6.1.rc3.g39b7ecfa5b4a
>   GEN     perf-archive
>   GEN     perf-iostat
> Traceback (most recent call last):
>   File "pmu-events/jevents.py", line 7, in <module>
>     import metric
>   File "/home/john/kernel-dev2/tools/perf/pmu-events/metric.py", line
> 399, in <module>
>     class MetricGroup:
>   File "/home/john/kernel-dev2/tools/perf/pmu-events/metric.py", line
> 408, in MetricGroup
>     'MetricGroup']]):
> TypeError: 'type' object is not subscriptable
> make[3]: *** [pmu-events/Build:26: pmu-events/pmu-events.c] Error 1
> make[2]: *** [Makefile.perf:672: pmu-events/pmu-events-in.o] Error 2
> make[2]: *** Waiting for unfinished jobs....
>
>
> Any idea?

Apologies, this looks like a fault by me. I'll downgrade my python and
fix this for the next version.

Thanks!
Ian

> Thanks,
> John
