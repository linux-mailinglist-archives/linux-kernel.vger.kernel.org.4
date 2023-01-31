Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6406821F1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 03:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjAaCUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 21:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjAaCUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 21:20:08 -0500
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6212F7A9;
        Mon, 30 Jan 2023 18:20:07 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso9568628wmq.5;
        Mon, 30 Jan 2023 18:20:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9I9GOWPAkA+SyKQULJQoDd7R/B5663oOHl+xrR91pBo=;
        b=F3kDoOD9L1VcKXWSpBqIcTM7kRpNk9phDz4cecexIKOh3eMA/ujgDMYAPSt9hPbHch
         Z/VlI5AORO7MkTCF5s40BZSVpioM1h/ywN06XhR+ShMI3UYP04/GmqTPS6L1aYph6DjM
         xcUB1Ir0gKjh5c2v6PoNwqtUy37r0KPZAWhLlAPW2eDad/eDNVMgdVs1PYOKtaPJaz+t
         nNrpoG34OikWWuHfFfMvI+zSECasUIwQ16rfpUmvBiFfHbynjcH5FTrjON9GOhlXrj0e
         XcSpoTi0sB3bYB8wHM5Pao+oMOr9KPLnukouYXnn80KyuMRE+QATnKwpkJeNIkQ4y1qa
         Pb6g==
X-Gm-Message-State: AO0yUKXOwuoY92Pcb4xsmYYiP9PZowjz8T2dJTIv5Hrp9fQIxkKWPq2H
        x3XoFagfAjuMBFU6ruhgkklJ4XXxjuIAmiknENA=
X-Google-Smtp-Source: AK7set/Tid26edDcaXLYMwfdjsrpeoxBXvPJ4zA9hcxD+MJmm+tVyzctecnw6cyrgXgxU+XGw6ExWgFWw4i1FkSGOJQ=
X-Received: by 2002:a05:600c:b9b:b0:3dc:587d:69b with SMTP id
 fl27-20020a05600c0b9b00b003dc587d069bmr492106wmb.28.1675131605910; Mon, 30
 Jan 2023 18:20:05 -0800 (PST)
MIME-Version: 1.0
References: <20230127001951.3432374-1-namhyung@kernel.org> <bda606c2-2b1b-de9f-1386-8ee2bf925b4b@intel.com>
 <CAM9d7cg_7LNKrXtBuo2QUR1Voi9NKM98qYLC+pznMf4-5yo4Dg@mail.gmail.com>
 <Y9fREY3BxROqYYBO@kernel.org> <5676a1b7-885c-e8d9-1809-8bedcf1ff995@intel.com>
In-Reply-To: <5676a1b7-885c-e8d9-1809-8bedcf1ff995@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 30 Jan 2023 18:19:54 -0800
Message-ID: <CAM9d7chWEtgvJXgD3qM=iQ+Vr7r9ow6nzOXpouwHpnxbP8mn9w@mail.gmail.com>
Subject: Re: [PATCH 0/4] perf intel-pt: Fix the pipe mode (v1)
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>,
        Stephane Eranian <eranian@google.com>
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

On Mon, Jan 30, 2023 at 9:36 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 30/01/23 16:15, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Jan 27, 2023 at 02:54:36PM -0800, Namhyung Kim escreveu:
> >> Hi Adrian,
> >>
> >> On Thu, Jan 26, 2023 at 11:22 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>>
> >>> On 27/01/23 02:19, Namhyung Kim wrote:
> >>>> Hello,
> >>>>
> >>>> I found some problems in Intel-PT and auxtrace in general with pipe.
> >>>> In the past it used to work with pipe, but recent code fails.
> >>>
> >>> Pipe mode is a problem for Intel PT and possibly other auxtrace users.
> >>> Essentially the auxtrace buffers do not behave like the regular perf
> >>> event buffers.  That is because the head and tail are updated by
> >>> software, but in the auxtrace case the data is written by hardware.
> >>> So the head and tail do not get updated as data is written.  In the
> >>> Intel PT case, the head and tail are updated only when the trace is
> >>> disabled by software, for example:
> >>>     - full-trace, system wide : when buffer passes watermark
> >>>     - full-trace, not system-wide : when buffer passes watermark or
> >>>     context switches
> >>>     - snapshot mode : as above but also when a snapshot is made
> >>>     - sample mode : as above but also when a sample is made
> >>>
> >>> That means finished-round ordering doesn't work.  An auxtrace buffer
> >>> can turn up that has data that extends back in time, possibly to the
> >>> very beginning of tracing.
> >>
> >> Ok, IIUC we want to process the main buffer and auxtrace buffer
> >> together in time order but there's no guarantee to get the auxtrace
> >> data in time, right?
>
> Yes
>
> >>
> >> I wonder if it's possible to use 2 pass processing for pipe mode.
> >> We may keep the events in the ordered queue and auxtrace queue
> >> in the first pass, and process together from the beginning in the
> >> second pass. But I guess the data size would be a problem.
> >>
> >> Or, assuming that the auxtrace buffer comes later than (or equal to)
> >> the main buffer, we may start processing the main buffer as soon as
> >> every auxtrace queue gets some data.  Thoughts?
>
> That sounds like it would require figuring out a timestamp up to
> which there is Intel PT trace data in all queues.  That would
> be very complicated.

Yeah, I don't think it's a simple change.  Just think out loud how
we can handle it.  I'll think about it more..

>
> >>
> >>>
> >>> For a perf.data file, that problem is solved by going through the trace
> >>> and queuing up the auxtrace buffers in advance.
> >>>
> >>> For pipe mode, the order of events and timestamps can presumably
> >>> be messed up.
> >>>
> >>> For Intel PT, it is a bit of a surprise that there is not
> >>> validation to error out in pipe mode.
> >>
> >> What kind of validation do you have in mind?  Checking pid/tid?
>
> Validation to kill pipe mode for Intel PT entirely.  But a warning
> is ok.

I see.

>
> >>
> >>>
> >>> At the least, a warning is needed, and the above explanation needs
> >>> to be added to the documentation.
> >>
> >> Thanks, I'll add it to the documentation.
> >
> > Ok, so I'll wait for v2 of this patch series, Adrian, apart from what
> > you mentioned, are you ok with the patches, or a subset of them? The
> > first ones looks ok, right?
>
> Yes they are ok.
>
> >
> > - Arnaldo
> >
> >> How about showing something like this for pipe mode?
> >>
> >>   WARNING: Intel-PT with pipe mode may not work correctly.
>
> Perhaps:
>
> WARNING: Intel PT with pipe mode is not recommended. The output cannot be relied upon. In particular, time stamps and the order of events may be incorrect.

Ok, will add this.

Thanks,
Namhyung
