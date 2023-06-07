Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A182C72666A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 18:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjFGQuT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Jun 2023 12:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjFGQuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 12:50:16 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDEC1FC0;
        Wed,  7 Jun 2023 09:50:14 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-55a35e2a430so1591586eaf.0;
        Wed, 07 Jun 2023 09:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686156612; x=1688748612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Uznm7d6ydDZWyl996H+0J1qZvqt3MWV+OPBkSeFo+4=;
        b=BED/IIH3ggEYYvOW8djgDDeFMrxnu2iGYc5prYpI6AOmoKCRbvU0v9evn1Jx8qCkAM
         hyRD3Uh4os4bfNmds7WzzZMQo3iZ0WhQftYUgsv9KtSW+Y/P64AjQ0d0tvydITAgXgcG
         5+h0OpHKghWC1/JxVu93cZLEB6T9dNbBcfoA4KOg6ktBVMicwLaKd8ausraIQly8rRPA
         1x/aTizH4DWgasHedMcfQefhLaBbTxxWrODCqmXYwYYfRYXYhxKAoXkRsLGhFnK4OHnm
         8AZeV/Qw4CsKrNsPo0an5Qx7lu7VkHqZ1X+PhQbpV/mkTGBp8T1+qNBIYyCacIE30pRS
         PaGw==
X-Gm-Message-State: AC+VfDxlDyYqslHwfskHknBVcCSW7d+OZvSTQOVjHeDUgLiB8m1Qt7iX
        p6zbNJkmL/ngCUkFd9MaA+oKe7yrtdtxf6E2YUY=
X-Google-Smtp-Source: ACHHUZ4PogHEyFUd2JRwXoZWDFD7DiApzpT3ICDjwp6kSfVBf9/6QpmL83jKQP41xZrIchHmlKLOb1entcFJMIe/LiM=
X-Received: by 2002:a05:6359:399:b0:129:c526:bddb with SMTP id
 eg25-20020a056359039900b00129c526bddbmr1790108rwb.13.1686156612356; Wed, 07
 Jun 2023 09:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230531115014.161454-1-asavkov@redhat.com> <20230531115014.161454-3-asavkov@redhat.com>
 <CAM9d7ci6h_f8WsRu3cyYPQJO8nuAXcsMX_T_+aLy_0t5_33tMA@mail.gmail.com> <20230602081811.GA240769@samus.usersys.redhat.com>
In-Reply-To: <20230602081811.GA240769@samus.usersys.redhat.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 7 Jun 2023 09:50:01 -0700
Message-ID: <CAM9d7chAYCmOe84cjeHtRmwvio-NWDaoxEyA4cgx3nOg+xZ8gA@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf tools: allow running annotation browser from c2c-report
To:     Artem Savkov <asavkov@redhat.com>
Cc:     linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Sorry for the late reply.

On Fri, Jun 2, 2023 at 1:18 AM Artem Savkov <asavkov@redhat.com> wrote:
>
> Hello,
>
> Thank you for the review.
>
> On Thu, Jun 01, 2023 at 02:26:48PM -0700, Namhyung Kim wrote:
> > Hello,
> >
> > On Wed, May 31, 2023 at 4:50 AM Artem Savkov <asavkov@redhat.com> wrote:
> > >
> > > Add a shortcut to run annotation browser for selected symbol from
> > > c2c report TUI.
> > >
> > > Signed-off-by: Artem Savkov <asavkov@redhat.com>
> > > ---
> > >  tools/perf/builtin-c2c.c | 76 +++++++++++++++++++++++++++++++++++++---
> > >  1 file changed, 71 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> > > index 05dfd98af170b..96e66289c2576 100644
> > > --- a/tools/perf/builtin-c2c.c
> > > +++ b/tools/perf/builtin-c2c.c
> > > @@ -19,11 +19,13 @@
>
> snip
>
> > >  struct c2c_hists {
> > > @@ -79,6 +83,7 @@ struct c2c_hist_entry {
> > >          * because of its callchain dynamic entry
> > >          */
> > >         struct hist_entry       he;
> > > +       struct evsel            *evsel;
> >
> > I'm not sure if it's needed.  It seems c2c command doesn't collect
> > samples per evsel.  It uses c2c.hists.hists for all evsels.  Then it
> > might not be worth keeping an evsel in a c2c_hist_entry and
> > just use a random evsel in the evlist.
> >
>
> Right, but annotation browser does use it for line usage percentage
> calculation. So does this mean it won't be showing correct percentages
> whatever evsel is chosen and that's why it is possible to just select a
> random one?

Right, annotation can be correct but c2c hist entry is not tied to an evsel
so there's no need to save the evsel for each hist entry.

>
> As far as I can tell evlist is not currently available in
> perf_c2c__browse_cacheline(), but it can be added to struct perf_c2c.

Sure, please do.

>
> > >  };
>
> snip
>
> > > +       " a             Annotate current symbol\n"
> > >         " n             Toggle Node details info \n"
> > >         " s             Toggle full length of symbol and source line columns \n"
> > >         " q             Return back to cacheline list \n";
> > > @@ -2650,6 +2670,44 @@ static int perf_c2c__browse_cacheline(struct hist_entry *he)
> > >                 key = hist_browser__run(browser, "? - help", true, 0);
> > >
> > >                 switch (key) {
> > > +               case 'a':
> >
> > I think it's better to factor this code out to a function.
>
> Ok, will do.
>
> > > +                       if (!browser->selection ||
> > > +                           !browser->selection->map ||
> > > +                           !browser->selection->map->dso ||
> > > +                           browser->selection->map->dso->annotate_warned) {
> > > +                               continue;
> > > +                       }
> > > +
> > > +                       ms.map = browser->selection->map;
> > > +
> > > +                       if (!browser->selection->sym) {
> > > +                               if (!browser->he_selection)
> > > +                                       continue;
> > > +
> > > +                               ms.sym = symbol__new_unresolved(browser->he_selection->ip,
> > > +                                                               browser->selection->map);
> > > +
> > > +                               if (!ms.sym)
> > > +                                       continue;
> > > +                       } else {
> > > +                               if (symbol__annotation(browser->selection->sym)->src == NULL) {
> > > +                                       ui_browser__warning(&browser->b, 0,
> > > +                                               "No samples for the \"%s\" symbol.\n\n",
> > > +                                               browser->selection->sym->name);
> > > +                                       continue;
> > > +                               }
> > > +                               ms.sym = browser->selection->sym;
> > > +                       }
> > > +
> > > +                       err = map_symbol__tui_annotate(&ms, c2c_he->evsel, browser->hbt, &c2c.annotation_opts);
> > > +
> > > +                       ui_browser__update_nr_entries(&browser->b, browser->hists->nr_entries);
> >
> > c2c_browser__update_nr_entries() ?
>
> Will it change from the previous call before the while loop? This part
> was mostly copied over from do_annotate() in ui/browsers/hists.c so I am
> a bit hazy here. My understanding is that update_nr_entries and handle
> resize are called here mostly for refresh/reset of the ui and
> recalculation of number of entries is not needed

Hmm.. right.  I thought you should check the number of entries again but
c2c doesn't have filtering or hierarchy output so you can use
hists->nr_entries always.

But now I wonder if it's really needed as the annotate will use its own
browser so the c2c browser won't be affected.

>
> >
> > > +                       if ((err == 'q' || err == CTRL('c')) && browser->he_selection->branch_info)
> >
> > Why check branch_info?
>
> This was copied over as well and the comment in hists.c states "offer
> option to annotate the other branch source or target (if they exists)
> when returning from annotate". So I now think this might not be needed
> here at all?

Yeah, I don't think we need it.

Thanks,
Namhyung


>
> > > +                                       continue;
> > > +                       if (err)
> > > +                               ui_browser__handle_resize(&browser->b);
> > > +
> > > +                       continue;
> >
> > It'd be natural to use 'break' instead of 'continue' here.
>
> Yes, will change this.
>
> > >                 case 's':
> > >                         c2c.symbol_full = !c2c.symbol_full;
>
> snip
>
> > >         perf_session__delete(session);
> > >  out:
> > > +       annotation_options__init(&c2c.annotation_opts);
> >
> > __exit() ?
>
> Ouch, thanks for noticing!
>
> --
>  Artem
>
