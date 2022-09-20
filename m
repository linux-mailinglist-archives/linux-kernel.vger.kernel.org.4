Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AFF5BECAC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 20:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiITSRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 14:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiITSR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 14:17:28 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D0352451;
        Tue, 20 Sep 2022 11:17:27 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-11eab59db71so5422132fac.11;
        Tue, 20 Sep 2022 11:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=lzAR5EIrusYB8W382hzaSsfUkXSCRt/ZC1GFR4BZOo8=;
        b=nDjhXNqB5DW3KAteDacrYYmzUOtWeOUxAM8Q2/wI0TSD1qJLSreEzyV7eOn49wHZXL
         VLpuuPYnE+QbMFhC1MNhDcmwB/lv/83Ys75qUKKogjQzMCEAoTh8ilj2tru2YZodwlfe
         mReIQiwMQiVo9DMewVrKquhszeL0Hxjhmmdp4SrHdrO/vr+RY3SysNLlbc9vax6AYEID
         VO14CxQVA0KsDoww5eL6aL77rkErGOOZVkQWDTx7WsJIvu1MiAAaeeOXVQO2ZjhONtN+
         r383gA8+2xZhLHHymKjRd0v8tBv1wysH9+YUqE8FUb2fC0so4EYGQ0NsPgZP5c1NDfWr
         VPEg==
X-Gm-Message-State: ACrzQf2CDu0gmY0vskdu5nCXd5VZOCXFWrMyWM0kTNfajdKnsBljZYDD
        H8ndMsTRciH6DGAqIAjkfZOAYbOF6utpXX+15VM=
X-Google-Smtp-Source: AMsMyM6yY8aQAEYs/HCM5tZw43I1H4/dfwjXYKjPAxOI6LLdm+HHngcMP747BCxZiuxw2pEs13DF0cQMCO+YPvrF9G0=
X-Received: by 2002:a05:6870:524b:b0:12c:cfd2:81c0 with SMTP id
 o11-20020a056870524b00b0012ccfd281c0mr2771362oai.209.1663697846788; Tue, 20
 Sep 2022 11:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220916175902.1155177-1-namhyung@kernel.org> <20220916175902.1155177-3-namhyung@kernel.org>
 <5116611b-2d91-a9fe-5760-65a9a9b50747@intel.com>
In-Reply-To: <5116611b-2d91-a9fe-5760-65a9a9b50747@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 20 Sep 2022 11:17:15 -0700
Message-ID: <CAM9d7cizZ3Ztdqe8fXfWNOTk0Rg5v6tuSO3KbX2O_c-7a0-vNg@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf tools: Add perf_event__synthesize_{start,stop}()
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

On Tue, Sep 20, 2022 at 6:50 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 16/09/22 20:59, Namhyung Kim wrote:
> > These functions are to prepare and cleanup necessary work for synthesizing.
> > It doesn't do anything yet but later patch will add it.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/builtin-inject.c        | 3 +++
> >  tools/perf/builtin-record.c        | 3 +++
> >  tools/perf/builtin-stat.c          | 2 ++
> >  tools/perf/builtin-top.c           | 4 ++++
> >  tools/perf/util/auxtrace.c         | 2 ++
> >  tools/perf/util/synthetic-events.c | 8 ++++++++
> >  tools/perf/util/synthetic-events.h | 3 +++
> >  7 files changed, 25 insertions(+)
> >
> > diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> > index e254f18986f7..2e91a887919b 100644
> > --- a/tools/perf/builtin-inject.c
> > +++ b/tools/perf/builtin-inject.c
> > @@ -2368,9 +2368,12 @@ int cmd_inject(int argc, const char **argv)
> >       if (ret < 0)
> >               goto out_delete;
> >
> > +     perf_event__synthesize_start();
> > +
> >       ret = __cmd_inject(&inject);
> >
> >       guest_session__exit(&inject.guest_session);
> > +     perf_event__synthesize_stop();
>
> AFAICT perf inject synthesizes mmap events only for JIT and that is
> open-coded in jitdump.c. i.e. perf_event__synthesize_start / stop
> not needed

Right, it's not strictly necessary.  While perf inject -b can synthesize
some build-id events but it also doesn't require this even with the
patch 3.

Originally I thought this might be a good place to add something
we want to do for synthesis.  But I only need it for DSO build-IDs
in MMAP2 and we can remove it from other places.

>
> >
> >  out_delete:
> >       strlist__delete(inject.known_build_ids);
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 02e38f50a138..5b7b9ad2a280 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -1966,6 +1966,8 @@ static int record__synthesize(struct record *rec, bool tail)
> >       if (rec->opts.tail_synthesize != tail)
> >               return 0;
> >
> > +     perf_event__synthesize_start();
>
> Perhaps also record__synthesize_workload() ?

Oh, right.  I thought it's handled during exec but it seems
switch-output things need it additionally.  Will add.

>
> > +
> >       if (data->is_pipe) {
> >               err = perf_event__synthesize_for_pipe(tool, session, data,
> >                                                     process_synthesized_event);
> > @@ -2072,6 +2074,7 @@ static int record__synthesize(struct record *rec, bool tail)
> >       }
> >
> >  out:
> > +     perf_event__synthesize_stop();
> >       return err;
> >  }
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index e05fe72c1d87..f6f61e08f4c2 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -962,6 +962,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
> >               if (err < 0)
> >                       return err;
> >
> > +             perf_event__synthesize_start();
> >               err = perf_event__synthesize_stat_events(&stat_config, NULL, evsel_list,
> >                                                        process_synthesized_event, is_pipe);
> >               if (err < 0)
> > @@ -2641,6 +2642,7 @@ int cmd_stat(int argc, const char **argv)
> >                       perf_session__write_header(perf_stat.session, evsel_list, fd, true);
> >               }
> >
> > +             perf_event__synthesize_stop();
> >               evlist__close(evsel_list);
> >               perf_session__delete(perf_stat.session);
> >       }
> > diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> > index e89208b4ad4b..1eff894e6b5f 100644
> > --- a/tools/perf/builtin-top.c
> > +++ b/tools/perf/builtin-top.c
> > @@ -1258,6 +1258,8 @@ static int __cmd_top(struct perf_top *top)
> >  #endif
> >       }
> >
> > +     perf_event__synthesize_start();
> > +
> >       ret = perf_event__synthesize_bpf_events(top->session, perf_event__process,
> >                                               &top->session->machines.host,
> >                                               &top->record_opts);
> > @@ -1273,6 +1275,8 @@ static int __cmd_top(struct perf_top *top)
> >                                   top->evlist->core.threads, true, false,
> >                                   top->nr_threads_synthesize);
> >
> > +     perf_event__synthesize_stop();
> > +
> >       if (top->nr_threads_synthesize > 1)
> >               perf_set_singlethreaded();
> >
> > diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> > index b59c278fe9ed..1bfe076c22fb 100644
> > --- a/tools/perf/util/auxtrace.c
> > +++ b/tools/perf/util/auxtrace.c
> > @@ -1328,6 +1328,7 @@ int perf_event__process_auxtrace_info(struct perf_session *session,
> >       if (err)
> >               return err;
> >
> > +     perf_event__synthesize_start();
> >       unleader_auxtrace(session);
> >
> >       return 0;
> > @@ -2834,6 +2835,7 @@ void auxtrace__free(struct perf_session *session)
> >       if (!session->auxtrace)
> >               return;
> >
> > +     perf_event__synthesize_stop();
>
> auxtrace does not synthesize mmap events

Yeah, I don't have a strong need for it.  I just added it in case
we need something for synthesis later.  But I will remove it
if you don't think it's worth it.

Thanks,
Namhyung

>
> >       return session->auxtrace->free(session);
> >  }
> >
> > diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> > index 0ff57ca24577..9d4f5dacd154 100644
> > --- a/tools/perf/util/synthetic-events.c
> > +++ b/tools/perf/util/synthetic-events.c
> > @@ -47,6 +47,14 @@
> >
> >  unsigned int proc_map_timeout = DEFAULT_PROC_MAP_PARSE_TIMEOUT;
> >
> > +void perf_event__synthesize_start(void)
> > +{
> > +}
> > +
> > +void perf_event__synthesize_stop(void)
> > +{
> > +}
> > +
> >  int perf_tool__process_synth_event(struct perf_tool *tool,
> >                                  union perf_event *event,
> >                                  struct machine *machine,
> > diff --git a/tools/perf/util/synthetic-events.h b/tools/perf/util/synthetic-events.h
> > index 53737d1619a4..e4414616080c 100644
> > --- a/tools/perf/util/synthetic-events.h
> > +++ b/tools/perf/util/synthetic-events.h
> > @@ -43,6 +43,9 @@ int parse_synth_opt(char *str);
> >  typedef int (*perf_event__handler_t)(struct perf_tool *tool, union perf_event *event,
> >                                    struct perf_sample *sample, struct machine *machine);
> >
> > +void perf_event__synthesize_start(void);
> > +void perf_event__synthesize_stop(void);
> > +
> >  int perf_event__synthesize_attrs(struct perf_tool *tool, struct evlist *evlist, perf_event__handler_t process);
> >  int perf_event__synthesize_attr(struct perf_tool *tool, struct perf_event_attr *attr, u32 ids, u64 *id, perf_event__handler_t process);
> >  int perf_event__synthesize_build_id(struct perf_tool *tool, struct dso *pos, u16 misc, perf_event__handler_t process, struct machine *machine);
>
