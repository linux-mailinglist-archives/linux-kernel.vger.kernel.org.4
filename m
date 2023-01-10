Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946CF664CD7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjAJTzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 14:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbjAJTzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 14:55:14 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5921D6145A
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:55:12 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id j1so3113522uan.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sWBEBP027jXHEOv42rUgQvSGJQYUen22iKr19l7Fb5c=;
        b=ZvDn4oLes/zIvHZnvm9rOYT4nRMF641r1zUUek8ObygdZBRDlKXPXaR3O73c5Z8N5c
         yTZU8haKKw2Jt9Lu0nZ9R4wxDLJiZKc8zL6SJZelSJ3Mys0++GiEgBPYJVnjdny49Ubz
         WueFGuXhgejNTzvxG72WVDyXzk+P8OFy+E26WcowRGQpDNirYzuw/jxjTUjPzKdNzODT
         1IIFTQHLQiOGsAvACd/P1TqMk0IR67cFhcN5QGkcHANIBKYcF6oklKsEGh/toH9rc+hj
         tx7SGz92SYR751/wWpPsA5k1SXEkz+euWt//srFjU3rruVzzEo0po4rbYqq6gVaq3BtZ
         COGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sWBEBP027jXHEOv42rUgQvSGJQYUen22iKr19l7Fb5c=;
        b=v/mrBPSc1uaEk2Q6NhOwRraFEePENeW+TCZid0YTfKrivE57/+jEl3YhU6B+B0av8E
         f4pXFBoDjCgCuQ7yo3Gml0JpMm+pUkkApmgk59oJwpxzW21/RbLPpANrzxVCv1gjjoJh
         nQ2v3WtSgJaADJPa0oaG63MwU9LfUu31DvI6njENry5m5tAn3KWmvGHU3mqYN1K6OOow
         4t8MhxY2BGe2zPX7u9fwnGnBP7y9uqoPLc7AuBUyJDheDt8WGqzsYHka7hDf8HvNxDeF
         lZ5Zb8+3q9IvbKhJ7e+tmLoQF6kBO3K3zE4bBsvoOb74Fzxz74a4LwcZtMoOiy1xMoIr
         aM2w==
X-Gm-Message-State: AFqh2kqmP83r98EBh4GyAofJnwjO1/0BJO8V1Z91aL5VVyFszefslETt
        zD/PVP0s56Y07nyCLr6ZpyLooei4oJFb1nVV197Mow==
X-Google-Smtp-Source: AMrXdXsKJ3C7aDvSUwLwevuHQJ81rHrWDmF5y8Qk9LmQIOGF4k3ZXY44O3j2EAQ2+FM0Kkw8jiVd4jC9tH4xM8gmIWg=
X-Received: by 2002:ab0:152b:0:b0:418:620e:6794 with SMTP id
 o40-20020ab0152b000000b00418620e6794mr7714686uae.59.1673380511203; Tue, 10
 Jan 2023 11:55:11 -0800 (PST)
MIME-Version: 1.0
References: <20230109223110.1201541-1-irogers@google.com> <CAM9d7cgGq=+MC+qwRNxO=0Bn_ZMOucEzh_WWH95Lq8fsYHMb4A@mail.gmail.com>
 <CAP-5=fXniy80Jpc2Hu=-GF7yDNUNHjs0=B2iqkUkMb6zArPukg@mail.gmail.com> <CAM9d7chS+91Nep8FtsJsOdTvMJ0HhkSD1_Fn70=hWPi7a1JpfQ@mail.gmail.com>
In-Reply-To: <CAM9d7chS+91Nep8FtsJsOdTvMJ0HhkSD1_Fn70=hWPi7a1JpfQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 10 Jan 2023 11:54:58 -0800
Message-ID: <CAP-5=fUXoOFueaeSD2D9H+xoH5tKXRHK1164yPSX8_m_Nx_AeQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf tools: Remove HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Leo Yan <leo.yan@linaro.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Jan 10, 2023 at 11:09 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Mon, Jan 9, 2023 at 3:38 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Mon, Jan 9, 2023 at 2:57 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > Hi Ian,
> > >
> > > On Mon, Jan 9, 2023 at 2:31 PM Ian Rogers <irogers@google.com> wrote:
> > > > diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> > > > index e188f74698dd..cfcc253239f0 100644
> > > > --- a/tools/perf/util/sort.c
> > > > +++ b/tools/perf/util/sort.c
> > > > @@ -28,6 +28,7 @@
> > > >  #include "time-utils.h"
> > > >  #include "cgroup.h"
> > > >  #include "machine.h"
> > > > +#include "trace-event.h"
> > > >  #include <linux/kernel.h>
> > > >  #include <linux/string.h>
> > > >
> > > > @@ -2667,7 +2668,7 @@ static int64_t __sort__hde_cmp(struct perf_hpp_fmt *fmt,
> > > >                 tep_read_number_field(field, a->raw_data, &dyn);
> > > >                 offset = dyn & 0xffff;
> > > >                 size = (dyn >> 16) & 0xffff;
> > > > -#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> > > > +#if LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
> > > >                 if (field->flags & TEP_FIELD_IS_RELATIVE)
> > > >                         offset += field->offset + field->size;
> > >
> > > Maybe I missed the previous discussion.
> > >
> > > As it's only used in the bit test, can we have something like this
> > > in the header file?
> > >
> > > #if LIBTRACE_EVENT_VERSION < ...(1, 5, 0)
> > > # define TEP_FIELD_IS_RELATIVE  0
> > > #endif
> > >
> > > Thanks,
> > > Namhyung
> >
> > We could but I think we lose some of the intention revealing-ness that
> > TEP_FIELD_IS_RELATIVE is only present with libtraceevent 1.5.0 or
> > newer.
>
> I'm not sure how important it is to reveal the intention.
> I think we wanted to minimize #ifdef-ery in the .c file and
> moved the conditionals to the header.  Maybe we can add
> a wrapper like this.
>
> #if LIBTRACEEVENT_VERSION >= ...(1, 5, 0)
> static inline bool is_relative_field(field)
> {
>     return field->flags & TEP_FIELD_IS_RELATIVE;
> }
> #else
> static inline bool is_relative_field(field)
> {
>     return false;
> }
> #endif
>
> Thanks,
> Namhyung

Sounds good. Should the change be part of this one or a follow up
patch? A follow up patch seems cleanest, I can add it to v2.

Thanks,
Ian
