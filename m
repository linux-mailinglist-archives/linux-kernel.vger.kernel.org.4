Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE5A6BD4A6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjCPQGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 12:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjCPQGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:06:22 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE8AA1FCE;
        Thu, 16 Mar 2023 09:06:21 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id rj10so2099992pjb.4;
        Thu, 16 Mar 2023 09:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678982780;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3/BYlKm1OOM4FM5sq6VFyTDVBzXDbNiTrGJipf7AXzE=;
        b=f6oxs7KmI/7sb2F8Xyg3kgHogHr4EptnikWdMBHTlx0O/in6zdYazoC2LkxFYkmfwH
         XugMLUknQ2t3vIKmYW8q/wcddsk48GwmpxKtVpC5BFJ/vDRo7pj/cSG0M0qDl6DlpBhm
         J3tKHvMQOp0CZwVh7nXEVf96Gt9CqwsChV/9APLzqXnsBe3saQkGC9FewYrhQV4LqV7I
         g/je/vMYNcgpHyiQtllpXkzwYuq3OWdqi9T9+CypIUI8B6bYRvuM/RM2/QvZe2pbVFU+
         SkZkb9Qy2FCZB4WAxw21673ktAbQfBDeLABUC0u20v3c4epA2uHbUD0g3ChuzCd/iVAd
         rFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678982780;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3/BYlKm1OOM4FM5sq6VFyTDVBzXDbNiTrGJipf7AXzE=;
        b=V7nAbl79j3tFpX16OEeIyn6ASs5g7uvb6rzb0MiyUVg3s/L6J8ih0elv950SZbwM1C
         xTjHbqt7Oz3ULJ7WkpRXLeIVpVrd2SAOiFNSXG/gfJMDxgYOU2neHUNAd/yCqR293hGG
         pBxtJgNjcJ/+GsRzY0IQ6I2SeyW2TloFOYLHOga5XpmQZTpGg87NvdWSsuduNa9us5cH
         0PMcso+ffrvVIsnjbCOr5ljTeVTFGJ5QxxWYHcpQIgOzwa2KabjWFU0FPgn6zUMesHzg
         2TBzUSP1HavSepTjL07uIiQK/PnzILTkUuu+Q3k++d0YxKc1HL3bMVLbvDfsN+qNOBCh
         H6Fw==
X-Gm-Message-State: AO0yUKXTOpSlnIlkD/SVPS3GoxvTbLZfiXaqSBPQ3snKOjI14PN+3DgS
        q3pz0tQGAPdSfQZ2sYCo+LY=
X-Google-Smtp-Source: AK7set+EVRaLdrl+7diz4Rb6s51DKRy/egjlu6T3PVdwO8CC06bzNfn0dbDqxQYDu5aGT5LB46no+Q==
X-Received: by 2002:a05:6a20:734e:b0:cd:a334:a531 with SMTP id v14-20020a056a20734e00b000cda334a531mr5249262pzc.62.1678982780028;
        Thu, 16 Mar 2023 09:06:20 -0700 (PDT)
Received: from yoga ([2400:1f00:13:9b18:1f77:4356:f626:b1b])
        by smtp.gmail.com with ESMTPSA id x5-20020a62fb05000000b006242f4a8945sm5598681pfm.182.2023.03.16.09.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 09:06:19 -0700 (PDT)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Thu, 16 Mar 2023 21:36:12 +0530
To:     Ian Rogers <irogers@google.com>
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
        leo.yan@linaro.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, anupnewsmail@gmail.com
Subject: Re: [PATCH] perf: Fix indentation errors by removing extra spaces
Message-ID: <ZBM+dBK27EtCH78k@yoga>
References: <ZBIro7uDO/Mii3xF@yoga>
 <CAP-5=fX8xyd4qby2w15s+fEC4EeZt=2J2C6gz-stgtKTk2tkuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX8xyd4qby2w15s+fEC4EeZt=2J2C6gz-stgtKTk2tkuA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 05:10:52PM -0700, Ian Rogers wrote:
> On Wed, Mar 15, 2023 at 1:33 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
> >
> > Cleaning up tabstop related warning reported by checkpatch.pl script
> >
> > WARNING: Statements should start on a tabstop
> >
> > Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> 
> Thanks Anup,
> 
> Arnaldo, what's the policy on whitespace cleanup? Obviously new
> patches should try to avoid it, but patches like this are sometimes
> frowned upon due to losing blame history.>

Thank you Ian for informing, Just to get kickstarted I sent this patch. 
Will keep in mind from next time.

> Anup, when I run checkpatch.pl on this I see other warnings in the same code:

Correct, there are few other warning also, however I tried cleaning tabstop related
warning first, then thought of going to the next. 

> ```
> $ b4 am ZBIro7uDO/Mii3xF@yoga
> Grabbing thread from lore.kernel.org/all/ZBIro7uDO%2FMii3xF%40yoga/t.mbox.gz
> Analyzing 1 messages in the thread
> Checking attestation on all messages, may take a moment...
> ---
>  ✓ [PATCH] perf: Fix indentation errors by removing extra spaces
>  ---
>  ✓ Signed: DKIM/gmail.com
> ---
> Total patches: 1
> ---
> Link: https://lore.kernel.org/r/ZBIro7uDO/Mii3xF@yoga
> Base: not specified
>       git am ./20230316_anupnewsmail_perf_fix_indentation_errors_by_removing_extra_spaces.mbx
> $ scripts/checkpatch.pl
> ./20230316_anupnewsmail_perf_fix_indentation_errors_by_removing_extra_spaces.mbx
> WARNING: braces {} are not necessary for single statement blocks
> #78: FILE: tools/perf/jvmti/libjvmti.c:315:
> +               if (line_file_names[nr_lines - 1]) {
> +                       free(line_file_names[nr_lines - 1]);
> +               }
> 
> WARNING: Missing a blank line after declarations
> #96: FILE: tools/perf/ui/browser.c:44:
> +       int color = ui_browser__percent_color(browser, percent, current);
> +       ui_browser__set_color(browser, color);
> ```
> 
> These should probably be fixed at the same time.

I'd want to fix those as well, if you can guide me on the correct proceduce. 

> Thanks,
> Ian
> 
> > ---
> >  tools/perf/builtin-lock.c      |  2 +-
> >  tools/perf/builtin-trace.c     |  6 +++---
> >  tools/perf/jvmti/libjvmti.c    |  8 ++++----
> >  tools/perf/ui/browser.c        |  4 ++--
> >  tools/perf/ui/browsers/hists.c | 10 +++++-----
> >  tools/perf/util/symbol-elf.c   |  2 +-
> >  6 files changed, 16 insertions(+), 16 deletions(-)
> >
> > diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> > index 054997edd98b..4a1d5a08c8d6 100644
> > --- a/tools/perf/builtin-lock.c
> > +++ b/tools/perf/builtin-lock.c
> > @@ -2094,7 +2094,7 @@ static int parse_lock_type(const struct option *opt __maybe_unused, const char *
> >                         char buf[32];
> >
> >                         if (strchr(tok, ':'))
> > -                           continue;
> > +                               continue;
> >
> >                         /* try :R and :W suffixes for rwlock, rwsem, ... */
> >                         scnprintf(buf, sizeof(buf), "%s:R", tok);
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index 610fb60b1c0d..155abfd07286 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -1942,7 +1942,7 @@ static __maybe_unused bool trace__syscall_enabled(struct trace *trace, int id)
> >                                   trace->ev_qualifier_ids.nr, sizeof(int), intcmp) != NULL;
> >
> >         if (in_ev_qualifier)
> > -              return !trace->not_ev_qualifier;
> > +               return !trace->not_ev_qualifier;
> >
> >         return trace->not_ev_qualifier;
> >  }
> > @@ -3363,10 +3363,10 @@ static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace
> >                              candidate_is_pointer = candidate_field->flags & TEP_FIELD_IS_POINTER;
> >
> >                         if (is_pointer) {
> > -                              if (!candidate_is_pointer) {
> > +                               if (!candidate_is_pointer) {
> >                                         // The candidate just doesn't copies our pointer arg, might copy other pointers we want.
> >                                         continue;
> > -                              }
> > +                               }
> >                         } else {
> >                                 if (candidate_is_pointer) {
> >                                         // The candidate might copy a pointer we don't have, skip it.
> > diff --git a/tools/perf/jvmti/libjvmti.c b/tools/perf/jvmti/libjvmti.c
> > index fcca275e5bf9..faf5925f7433 100644
> > --- a/tools/perf/jvmti/libjvmti.c
> > +++ b/tools/perf/jvmti/libjvmti.c
> > @@ -312,10 +312,10 @@ compiled_method_load_cb(jvmtiEnv *jvmti,
> >         (*jvmti)->Deallocate(jvmti, (unsigned char *)class_sign);
> >         free(line_tab);
> >         while (line_file_names && (nr_lines > 0)) {
> > -           if (line_file_names[nr_lines - 1]) {
> > -               free(line_file_names[nr_lines - 1]);
> > -           }
> > -           nr_lines -= 1;
> > +               if (line_file_names[nr_lines - 1]) {
> > +                       free(line_file_names[nr_lines - 1]);
> > +               }
> > +               nr_lines -= 1;
> >         }
> >         free(line_file_names);
> >  }
> > diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
> > index 78fb01d6ad63..ba725ed5c86d 100644
> > --- a/tools/perf/ui/browser.c
> > +++ b/tools/perf/ui/browser.c
> > @@ -40,8 +40,8 @@ int ui_browser__set_color(struct ui_browser *browser, int color)
> >  void ui_browser__set_percent_color(struct ui_browser *browser,
> >                                    double percent, bool current)
> >  {
> > -        int color = ui_browser__percent_color(browser, percent, current);
> > -        ui_browser__set_color(browser, color);
> > +       int color = ui_browser__percent_color(browser, percent, current);
> > +       ui_browser__set_color(browser, color);
> >  }
> >
> >  void ui_browser__gotorc_title(struct ui_browser *browser, int y, int x)
> > diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> > index b72ee6822222..947f8023a140 100644
> > --- a/tools/perf/ui/browsers/hists.c
> > +++ b/tools/perf/ui/browsers/hists.c
> > @@ -402,7 +402,7 @@ static bool hist_browser__selection_has_children(struct hist_browser *browser)
> >                 return false;
> >
> >         if (ms == &he->ms)
> > -              return he->has_children;
> > +               return he->has_children;
> >
> >         return container_of(ms, struct callchain_list, ms)->has_children;
> >  }
> > @@ -421,7 +421,7 @@ static bool hist_browser__selection_unfolded(struct hist_browser *browser)
> >                 return false;
> >
> >         if (ms == &he->ms)
> > -              return he->unfolded;
> > +               return he->unfolded;
> >
> >         return container_of(ms, struct callchain_list, ms)->unfolded;
> >  }
> > @@ -436,8 +436,8 @@ static char *hist_browser__selection_sym_name(struct hist_browser *browser, char
> >                 return NULL;
> >
> >         if (ms == &he->ms) {
> > -              hist_entry__sym_snprintf(he, bf, size, 0);
> > -              return bf + 4; // skip the level, e.g. '[k] '
> > +               hist_entry__sym_snprintf(he, bf, size, 0);
> > +               return bf + 4; // skip the level, e.g. '[k] '
> >         }
> >
> >         callchain_entry = container_of(ms, struct callchain_list, ms);
> > @@ -3599,7 +3599,7 @@ static bool evlist__single_entry(struct evlist *evlist)
> >         int nr_entries = evlist->core.nr_entries;
> >
> >         if (nr_entries == 1)
> > -              return true;
> > +               return true;
> >
> >         if (nr_entries == 2) {
> >                 struct evsel *last = evlist__last(evlist);
> > diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> > index 41882ae8452e..32bd70d7b712 100644
> > --- a/tools/perf/util/symbol-elf.c
> > +++ b/tools/perf/util/symbol-elf.c
> > @@ -304,7 +304,7 @@ static char *demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
> >          * to it...
> >          */
> >         if (!want_demangle(dso->kernel || kmodule))
> > -           return demangled;
> > +               return demangled;
> >
> >         demangled = bfd_demangle(NULL, elf_name, demangle_flags);
> >         if (demangled == NULL) {
> > --
> > 2.34.1
> >
