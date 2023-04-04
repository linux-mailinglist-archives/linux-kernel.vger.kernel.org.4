Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2606D5829
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 07:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbjDDFrw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Apr 2023 01:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjDDFrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 01:47:51 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF8610E7;
        Mon,  3 Apr 2023 22:47:50 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id o12so13877930iow.6;
        Mon, 03 Apr 2023 22:47:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680587269; x=1683179269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNz+tor2PT8Dbq65kqmNewapvxNXvpyZu0fSYT9vvkg=;
        b=03+CVV3UY2YlwmhI/hhAUsTfD2ZWja/ela+A+pzl86tZusXGDb8LTC7x3PvTrhayX9
         0FaJUP/9PYuagfpjsy/argEdz8NkOI0BJm0xyti8sPmAjQGwtIvKU4D4j8PfvlrCbJMs
         tkBNlVRQvwtyFMv0shwXINRBoTEssQ0Qaqh4hs/nEpkz48fBtv+1FzcT/db12df6tyKo
         MvskOyhrzuVB62gmP/mcXzRyxS81i9rAbU7UKI2rwoYPSqlB2lrjPX7IBO3TY0P9F50N
         wjR36zPXhSIUhmmtPhL569x9iP+oHqjyAHqS4BYnZ7dIbX7h4vuz+LPmuE2aRaqf0V9j
         qJgQ==
X-Gm-Message-State: AAQBX9fgQ5+/LVg0Jl0E+VhXRvsJd/9tPXC3WjYSPhKJxxm0P7+ek/yv
        /e/jMvUiHm2MhUi+Z+GJGWQvi3LCVh+LGgmDNPQ=
X-Google-Smtp-Source: AKy350bYd8OQ4OgcesTf2t3y16sqqc7o75Oy1CdW1IDubFekOL0QL3zle3DhKo76y8/vwrZU3V0TN3byJcR/6nwiysE=
X-Received: by 2002:a5d:9f15:0:b0:760:932:b2fd with SMTP id
 q21-20020a5d9f15000000b007600932b2fdmr1441378iot.12.1680587269125; Mon, 03
 Apr 2023 22:47:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230316133557.868731-1-asavkov@redhat.com> <CAM9d7ciT7Wtmxt0_2ZVv4nbAb1KoeX_itTSAhz8B9T41-NeZYQ@mail.gmail.com>
 <ZBQZoyJc7mhUrL8n@samus.usersys.redhat.com> <CAM9d7ch9NjnaB5dB6fO7WKdwPd8M9DmNpdu4-V-8R+96ssxMvA@mail.gmail.com>
 <ZBtalEw0qKQFlVWR@kernel.org> <8f7077e8-bcce-a13f-48d3-92a3cb80b02a@intel.com>
 <20230331085224.GA688995@samus.usersys.redhat.com> <ZCs3WX4klUpe+aso@kernel.org>
In-Reply-To: <ZCs3WX4klUpe+aso@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 3 Apr 2023 22:47:37 -0700
Message-ID: <CAM9d7cgOA97n10FPz0Bwjtmfon1En+CN2K7CYL3fQ6nrjBqF9Q@mail.gmail.com>
Subject: Re: [PATCH 0/1] perf report: append inlines to non-dwarf callchains
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Artem Savkov <asavkov@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Milian Wolff <milian.wolff@kdab.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 3, 2023 at 1:30 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Fri, Mar 31, 2023 at 10:52:24AM +0200, Artem Savkov escreveu:
> > On Thu, Mar 30, 2023 at 08:06:20AM +0300, Adrian Hunter wrote:
> > > On 22/03/23 21:44, Arnaldo Carvalho de Melo wrote:
> > > > Em Wed, Mar 22, 2023 at 11:18:49AM -0700, Namhyung Kim escreveu:
> > > >> On Fri, Mar 17, 2023 at 12:41 AM Artem Savkov <asavkov@redhat.com> wrote:
> > > >>>
> > > >>> On Thu, Mar 16, 2023 at 02:26:18PM -0700, Namhyung Kim wrote:
> > > >>>> Hello,
> > > >>>>
> > > >>>> On Thu, Mar 16, 2023 at 6:36 AM Artem Savkov <asavkov@redhat.com> wrote:
> > > >>>>>
> > > >>>>> In an email to Arnaldo Andrii Nakryiko suggested that perf can get
> > > >>>>> information about inlined functions from dwarf when available and then
> > > >>>>> add it to userspace stacktraces even in framepointer or lbr mode.
> > > >>>>> Looking closer at perf it turned out all required bits and pieces are
> > > >>>>> already there and inline information can be easily added to both
> > > >>>>> framepointer and lbr callchains by adding an append_inlines() call to
> > > >>>>> add_callchain_ip().
> > > >>>>
> > > >>>> Looks great!  Have you checked it with perf report -g callee ?
> > > >>>> I'm not sure the ordering of inlined functions is maintained
> > > >>>> properly.  Maybe you can use --no-children too to simplify
> > > >>>> the output.
> > > >>>
> > > >>> Thanks for the suggestion. I actually have another test program with
> > > >>> functions being numbered rather than (creatively) named, so it might be
> > > >>> easier to use it to figure out ordering. Here's the code:
> > > >>
> > > >> Yep, looks good.
> > > >>
> > > >> Acked-by: Namhyung Kim <namhyung@kernel.org>
> > > >
> > > > So, I'll apply this shorter patch instead, ok?
> > > >
> > > > - Arnaldo
> > > >
> > > > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > > > index 803c9d1803dd26ef..abf6167f28217fe6 100644
> > > > --- a/tools/perf/util/machine.c
> > > > +++ b/tools/perf/util/machine.c
> > > > @@ -44,6 +44,7 @@
> > > >  #include <linux/zalloc.h>
> > > >
> > > >  static void __machine__remove_thread(struct machine *machine, struct thread *th, bool lock);
> > > > +static int append_inlines(struct callchain_cursor *cursor, struct map_symbol *ms, u64 ip);
> > > >
> > > >  static struct dso *machine__kernel_dso(struct machine *machine)
> > > >  {
> > > > @@ -2322,6 +2323,10 @@ static int add_callchain_ip(struct thread *thread,
> > > >   ms.maps = al.maps;
> > > >   ms.map = al.map;
> > > >   ms.sym = al.sym;
> > > > +
> > > > + if (append_inlines(cursor, &ms, ip) == 0)
> > > > +         return 0;
> > > > +
> > > >   srcline = callchain_srcline(&ms, al.addr);
> > > >   return callchain_cursor_append(cursor, ip, &ms,
> > > >                                  branch, flags, nr_loop_iter,
> > >
> > > This seems to be breaking --branch-history.  I am not sure
> > > append_inlines() makes sense for branches.  Maybe this should be:
> > >
> > >     if (!branch && !append_inlines(cursor, &ms, ip))
> > >             return 0;
> > >
> >
> > Right. So when cllchain_cursor is appended through append_inlines it
> > always discards branch information, even for the non-inlined function.
> > So adding !branch makes sense to me. Does anyone else see any problems
> > with that?
>
> I'm no expert in this specific area, so for now till we get to a
> conclusion on this, I'll follow Andi's suggestion and revert this patch.

I think we can simply apply Adrian's patch above.

Thanks,
Namhyung
