Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6DF66A368
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjAMTda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjAMTcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:32:12 -0500
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA5B88A25
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:31:23 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id t10so12651019vsr.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:31:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E8V7kGrFEMEHWVSu1h0mjsTnmEFIOwHC9a9fBG7LGhU=;
        b=hr7cuqLE0gUK72WP1eEp5RyVblOszQKAhaSF6ri1gnroM9RFgYBgc7ocbiia8J+r94
         10qOb3lD9DTbHszluNWBcezzVrKrYCTrCWCJE55mkUjAwyGZQ+JKaa0UTXvaUD2pV3ey
         opU3ZMGyTlmybQoB1tmJTuklz7iUI1jCBKA7Df2FwD7FbAMJP2LpfLTcuhvePFott+dE
         /P3RSl8jX13pHre0atqTNRZG22L/tZ/b8fCFAD6vqit51/zQJf4bZf3FfpDugzgTn8RI
         Ag5ATFLORtuHoOBGW6vQD6nDJXFyG6XqMj49WLu0KpDe5Hf6CwGiG+e6OkGP+SGqwzhR
         xtRQ==
X-Gm-Message-State: AFqh2kpQoWkpOJiBlEmQa+ML6lmSrv+G3McXa5C7egr8tY7TRFeJHFhO
        RGA5Zatak5W2EaGUp2vipFQAeponhXx6bC6JiqI=
X-Google-Smtp-Source: AMrXdXtZFWq9NZ8sFMtU9FtP2hpTNxzdrq03YRM9sSWneaskHTWee2E+cIV0TXhItlecAyogEW6G3xoxn4EwGNRUMlI=
X-Received: by 2002:a05:6102:160a:b0:3b2:fa7a:566a with SMTP id
 cu10-20020a056102160a00b003b2fa7a566amr11553441vsb.3.1673638282462; Fri, 13
 Jan 2023 11:31:22 -0800 (PST)
MIME-Version: 1.0
References: <20230112214015.1014857-1-namhyung@kernel.org> <20230112214015.1014857-6-namhyung@kernel.org>
 <Y8E+aPblzA/mH+Vh@hirez.programming.kicks-ass.net>
In-Reply-To: <Y8E+aPblzA/mH+Vh@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 13 Jan 2023 11:31:10 -0800
Message-ID: <CAM9d7cigVWOQxGkWzTtHnP7f9Vg43gn1kxKK21NZ9FxhBAm1FQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] perf/core: Set data->sample_flags in perf_prepare_sample()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 3:20 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jan 12, 2023 at 01:40:12PM -0800, Namhyung Kim wrote:
>
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -7053,6 +7053,14 @@ static void perf_aux_sample_output(struct perf_event *event,
> >       ring_buffer_put(rb);
> >  }
> >
> > +/*
> > + * A set of common sample data types saved even for non-sample records
> > + * when event->attr.sample_id_all is set.
> > + */
> > +#define PERF_SAMPLE_ID_ALL  (PERF_SAMPLE_TID | PERF_SAMPLE_TIME |    \
> > +                          PERF_SAMPLE_CPU | PERF_SAMPLE_ID |         \
> > +                          PERF_SAMPLE_IDENTIFIER | PERF_SAMPLE_STREAM_ID)
> > +
>
>
> >       __perf_event_header__init_id(header, data, event, filtered_sample_type);
> > +     data->sample_flags |= sample_type & PERF_SAMPLE_ID_ALL;
>
> Why not update __perf_event_header__init_id() ?

My concern was the non-sample records which don't check the sample
flags at all.  So I'd like to skip the write for them.

But that's not a big deal.  I can move it if you want.

Thanks,
Namhyung
