Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD8D5BECCA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 20:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiITSbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 14:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiITSbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 14:31:03 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6571DA78;
        Tue, 20 Sep 2022 11:31:02 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1278624b7c4so5521990fac.5;
        Tue, 20 Sep 2022 11:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=rpWaSRyoPMcbkF/pZyIay3C62HyTK6rD7xQiTaVHlUQ=;
        b=AVOlprK0yeomglgHKeUGNEP9mj63jy78C1hSnt1HH5j6f9t0hbtkV3iaUhDdyMuQKN
         b6KEYCpvpUZslxAxBcTxpkbQsFPrOB+v8yA0PqK1WtxGwjm/uQFn1+t+6mdoqutKnXaJ
         +CS/Xe9xB6NrHEPo57jB/EGHKz/9hCgCvzFn3SvNDCQerwt0u7SMPQlzMFmhkyDtsMUq
         csDaHKgAs36/XRpL0qrNkScQQu8S3ZqS2KdA2DuIWoMAacN4FLRGDh9dk0MTj9uFy0G4
         0QWdOMaLrnMYTlvoB76VC+W2i9R/PpNQikp7Tw7ux91KG8ULvU4fvrr0FRQsa27E8BOr
         xbyg==
X-Gm-Message-State: ACrzQf0JuMeqiXq3qXYUVWg8K6GMZD9ft3p9+UB7ch7oVJwiMx44W3+7
        4ZnRBazOlGMUueyDM+Ztcc6b2xuY1eBzYwYwasc=
X-Google-Smtp-Source: AMsMyM5L00q500FPaTNsYPys3hFAvkhZioJDhim6wJnEsr2mRWOzbas/O3/K9vVYOD/RwY/omvEiDnVRgY4fyyBaJB4=
X-Received: by 2002:a05:6870:a70f:b0:127:666a:658 with SMTP id
 g15-20020a056870a70f00b00127666a0658mr2874617oam.218.1663698662011; Tue, 20
 Sep 2022 11:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220916175902.1155177-1-namhyung@kernel.org> <20220916175902.1155177-4-namhyung@kernel.org>
 <571fb9aa-98e7-b42a-aa81-01658e131f11@intel.com>
In-Reply-To: <571fb9aa-98e7-b42a-aa81-01658e131f11@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 20 Sep 2022 11:30:50 -0700
Message-ID: <CAM9d7ch4Rb6GxGc2NrHFVz=S5__XdCNCRy2=5Fj=XCYn2b6d3A@mail.gmail.com>
Subject: Re: [PATCH 3/4] perf record: Save DSO build-ID for synthesizing
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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

On Tue, Sep 20, 2022 at 7:00 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 16/09/22 20:59, Namhyung Kim wrote:
> > When synthesizing MMAP2 with build-id, it'd read the same file repeatedly as
> > it has no idea if it's done already.  Maintain a dsos to check that and skip
> > the file access if possible.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/synthetic-events.c | 49 +++++++++++++++++++++++++-----
> >  1 file changed, 42 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> > index 9d4f5dacd154..e6978b2dee8f 100644
> > --- a/tools/perf/util/synthetic-events.c
> > +++ b/tools/perf/util/synthetic-events.c
> > @@ -4,6 +4,7 @@
> >  #include "util/data.h"
> >  #include "util/debug.h"
> >  #include "util/dso.h"
> > +#include "util/dsos.h"
> >  #include "util/event.h"
> >  #include "util/evlist.h"
> >  #include "util/machine.h"
> > @@ -47,12 +48,25 @@
> >
> >  unsigned int proc_map_timeout = DEFAULT_PROC_MAP_PARSE_TIMEOUT;
> >
> > +static bool synth_init_done;
> > +static struct dsos synth_dsos;
> > +
> >  void perf_event__synthesize_start(void)
> >  {
> > +     if (synth_init_done)
> > +             return;
> > +
> > +     dsos__init(&synth_dsos);
> > +
> > +     synth_init_done = true;
> >  }
> >
> >  void perf_event__synthesize_stop(void)
> >  {
> > +     if (!synth_init_done)
> > +             return;
> > +
> > +     dsos__exit(&synth_dsos);
> >  }
> >
> >  int perf_tool__process_synth_event(struct perf_tool *tool,
> > @@ -374,26 +388,47 @@ static bool read_proc_maps_line(struct io *io, __u64 *start, __u64 *end,
> >  static void perf_record_mmap2__read_build_id(struct perf_record_mmap2 *event,
> >                                            bool is_kernel)
> >  {
> > -     struct build_id bid;
> > +     struct build_id _bid, *bid = &_bid;
> > +     struct dso *dso = NULL;
> > +     struct dso_id id;
> >       int rc;
> >
> > -     if (is_kernel)
> > -             rc = sysfs__read_build_id("/sys/kernel/notes", &bid);
> > -     else
> > -             rc = filename__read_build_id(event->filename, &bid) > 0 ? 0 : -1;
> > +     if (is_kernel) {
> > +             rc = sysfs__read_build_id("/sys/kernel/notes", bid);
> > +             goto out;
> > +     }
> > +
> > +     id.maj = event->maj;
> > +     id.min = event->min;
> > +     id.ino = event->ino;
> > +     id.ino_generation = event->ino_generation;
> >
>
> There might be some paths missing perf_event__synthesize_start()
> e.g. perf trace
> So it would probably be safer to use lazy initialization for
> synth_dsos.

I thought about that too, but it'd need a cleanup routine at the end
anyway.  So I ended up having a pair of start/stop routines.

>
> Also, callers of perf_record_mmap2__read_build_id() have a struct
> machine so I wonder about putting synth_dsos in struct machine ?
> Or even just using machine->dsos ?

My intention was to use minimal info from struct dso - name, id and
build-id.  But as it already uses dsos/dso routines, it's not much
different from using the existing machine->dsos.

So yeah, I think it's good to reuse the existing one as it'd benefit
the build-id processing at the end.  Will change.

Thanks,
Namhyung


>
> > +     dso = dsos__findnew_id(&synth_dsos, event->filename, &id);
> > +     if (dso && dso->has_build_id) {
> > +             bid = &dso->bid;
> > +             rc = 0;
> > +             goto out;
> > +     }
> > +
> > +     rc = filename__read_build_id(event->filename, bid) > 0 ? 0 : -1;
> > +
> > +out:
> >       if (rc == 0) {
> > -             memcpy(event->build_id, bid.data, sizeof(bid.data));
> > -             event->build_id_size = (u8) bid.size;
> > +             memcpy(event->build_id, bid->data, sizeof(bid->data));
> > +             event->build_id_size = (u8) bid->size;
> >               event->header.misc |= PERF_RECORD_MISC_MMAP_BUILD_ID;
> >               event->__reserved_1 = 0;
> >               event->__reserved_2 = 0;
> > +
> > +             if (dso && !dso->has_build_id)
> > +                     dso__set_build_id(dso, bid);
> >       } else {
> >               if (event->filename[0] == '/') {
> >                       pr_debug2("Failed to read build ID for %s\n",
> >                                 event->filename);
> >               }
> >       }
> > +     dso__put(dso);
> >  }
> >
> >  int perf_event__synthesize_mmap_events(struct perf_tool *tool,
>
