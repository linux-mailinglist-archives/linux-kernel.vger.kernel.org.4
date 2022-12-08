Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2F46475FF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 20:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiLHTLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 14:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiLHTLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 14:11:12 -0500
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038AE862CD
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 11:11:11 -0800 (PST)
Received: by mail-io1-f45.google.com with SMTP id p6so807942iod.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 11:11:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=joAR2U3MbwjKUOm3s5OmrqkSX8hEk/d+Rr8ropcmRlo=;
        b=crnGFlAK7LIrycywVHJ8sjFCMbggC4WYk+bEeQUetULBCdvKfBgbniFMkNV2B7k/Ii
         o5Aex3yeZzadMWVqmsWGGd4Iy5XN1fLNuyu3KRlP+m+WFagV8XYlOE3PYwIvJj71M0/g
         UvdAbswkO2t6SXqkVmftTuqleTtYsS2BQpsgiN+2rrOAfFzGI0h0zZv1Pkv/Qc2r8vze
         m4x7pApBMSf7J7KE/7Mu7cX25rP0Aw2V0KjdixnLtsVQqKU2WlT4fjGsNAY2/pwR+EnL
         jQTKDlzInnRAGzLj0lE/WQRBpUtYoFTyxfiLInpxGROhiuQw7znbhUmyG2GYNtUjg+Jd
         zukg==
X-Gm-Message-State: ANoB5pkvfGNU6WbumYSTLQLxj4PFrNPUABuhXRcSW5BugyZDsZxlCIhn
        apxp/YQj7Fy7d+GEm+CHiVjlOpdWpGqVePaCtNg=
X-Google-Smtp-Source: AA0mqf4PvfnnnRW9Lkn438rrWLZb3o8FaLee51yhDNLGxxZ+ubCjidkrieB4C2yLfNAMJJBh+jPLGawOEPvDr+I9pac=
X-Received: by 2002:a05:6638:16c3:b0:389:d9a2:8667 with SMTP id
 g3-20020a05663816c300b00389d9a28667mr24878617jat.91.1670526670037; Thu, 08
 Dec 2022 11:11:10 -0800 (PST)
MIME-Version: 1.0
References: <20221206154406.41941-1-petar.gligor@gmail.com>
 <CAM9d7cizPC3p0-Z1oYsDPofwNfZHyKYiJR5JXEcS31Q=mgzcLg@mail.gmail.com>
 <Y4/AfA2OYtlTkKwo@debian> <CAM9d7chLZVDg_-tnUh_qFYzchnpis-e7HYNDVM_OPjj_QXMeKQ@mail.gmail.com>
 <Y5HVdS3mlDruNyrl@debian>
In-Reply-To: <Y5HVdS3mlDruNyrl@debian>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 8 Dec 2022 11:10:58 -0800
Message-ID: <CAM9d7ciX9ULwSy5G3cFZi7mMXrt_A52hwwk7L1m-oV_0P07_vw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] perf: introduce perf based task analyzer
To:     Petar Gligoric <petar.gligor@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Petar Gligoric <petar.gligoric@rohde-schwarz.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Hagen Paul Pfeifer <hagen@jauu.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 8, 2022 at 4:15 AM Petar Gligoric <petar.gligor@gmail.com> wrote:
>
> > > Thanks for the input! For this patchset we explicitly decided against
> > > extending "perf sched timehist" - after some pros and cons. Mainly we
> > > didn't want to break existing programs (which might parse the output of
> > > perf sched) and also the goal of the task-analyzer is a bit different.
> > > E.g what will follow as a follow-up patch, is to show IRQs visually
> > > pleasing intermixed with tasks to show potential sources of task
> > > latency. This will be offered as an option for the task-analyzer, but
> > > would be too much functionality for "perf sched timehist". This was the
> > > main reason why we decided against the extension.
> >
> > Then you might want to add a new sub-command under perf sched.
> > But I guess we can just add a new option for the different output
> > format in the perf sched timehist.
> >
> > Anyway, "perf script" is a generic tool not targeting specific events.
> > This functionality requires sched_switch (and more?) then we need
> > the record part to make sure the data has the events.  That's why
> > it's natural to have it in perf sched IMHO.
> >
> > Thanks,
> > Namhyung
>
> We assumed that python scripts should not only be used as a "generic tool".

Oh, I didn't know you worked on a separate python script.
Sorry, I just read the cover letter (but not the diffstat) and
I thought you added it to the builtin-script.c. ;-)

> There are a number of tools like flamegraph, netdev-times, dropmonitor and
> other scripts that analyze and look at *very specific* events. The question is
> rather, why should this be implemented in C? When using Python - with batteries
> included - less code has to be written for the identical result, and it is less
> error-prone than C (less technical debt). We have measured the performance,
> even for very large perf.data files, and again we see no problems.

Then I have no problem with python.  Please take a look at the
scripts/python/bin directory to provide shortcuts for record/report.

Thanks,
Namhyung


>
> But maybe this should be clarified in principle! What do you say Arnaldo, Ian,
> ...?
>
> Petar
>
