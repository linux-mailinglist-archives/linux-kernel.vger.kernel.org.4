Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7318971FBB9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbjFBITL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbjFBITJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:19:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E021718C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 01:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685693901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e6dgcfRzwtu2q6ZQ7H261Q/6f1VW8EOruX+6XBOQKHE=;
        b=D3eTQHfh3uD764qMtiQ3itjR5OkNa+ytU/G2S94oPnSPEbDxrvCXMR6DgJvxz7P+z4HnH2
        GDJh3aGAGY3lNSBloNo/e+ZB8O4mMdc4wOW3b2Ep/UYTbP48zUWVbmCvHLZn0sYEOmQkZH
        zohF0Zu/xzSg5SUrasyJ1kFjlBOiNso=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-hfm_teGCOESRR0UGvP-mcg-1; Fri, 02 Jun 2023 04:18:15 -0400
X-MC-Unique: hfm_teGCOESRR0UGvP-mcg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF2C4811E7F;
        Fri,  2 Jun 2023 08:18:14 +0000 (UTC)
Received: from samus.usersys.redhat.com (unknown [10.43.17.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3FBAF1121314;
        Fri,  2 Jun 2023 08:18:13 +0000 (UTC)
Date:   Fri, 2 Jun 2023 10:18:11 +0200
From:   Artem Savkov <asavkov@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf tools: allow running annotation browser from
 c2c-report
Message-ID: <20230602081811.GA240769@samus.usersys.redhat.com>
References: <20230531115014.161454-1-asavkov@redhat.com>
 <20230531115014.161454-3-asavkov@redhat.com>
 <CAM9d7ci6h_f8WsRu3cyYPQJO8nuAXcsMX_T_+aLy_0t5_33tMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7ci6h_f8WsRu3cyYPQJO8nuAXcsMX_T_+aLy_0t5_33tMA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thank you for the review.

On Thu, Jun 01, 2023 at 02:26:48PM -0700, Namhyung Kim wrote:
> Hello,
> 
> On Wed, May 31, 2023 at 4:50 AM Artem Savkov <asavkov@redhat.com> wrote:
> >
> > Add a shortcut to run annotation browser for selected symbol from
> > c2c report TUI.
> >
> > Signed-off-by: Artem Savkov <asavkov@redhat.com>
> > ---
> >  tools/perf/builtin-c2c.c | 76 +++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 71 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> > index 05dfd98af170b..96e66289c2576 100644
> > --- a/tools/perf/builtin-c2c.c
> > +++ b/tools/perf/builtin-c2c.c
> > @@ -19,11 +19,13 @@

snip

> >  struct c2c_hists {
> > @@ -79,6 +83,7 @@ struct c2c_hist_entry {
> >          * because of its callchain dynamic entry
> >          */
> >         struct hist_entry       he;
> > +       struct evsel            *evsel;
> 
> I'm not sure if it's needed.  It seems c2c command doesn't collect
> samples per evsel.  It uses c2c.hists.hists for all evsels.  Then it
> might not be worth keeping an evsel in a c2c_hist_entry and
> just use a random evsel in the evlist.
> 

Right, but annotation browser does use it for line usage percentage
calculation. So does this mean it won't be showing correct percentages
whatever evsel is chosen and that's why it is possible to just select a
random one?

As far as I can tell evlist is not currently available in
perf_c2c__browse_cacheline(), but it can be added to struct perf_c2c.

> >  };

snip

> > +       " a             Annotate current symbol\n"
> >         " n             Toggle Node details info \n"
> >         " s             Toggle full length of symbol and source line columns \n"
> >         " q             Return back to cacheline list \n";
> > @@ -2650,6 +2670,44 @@ static int perf_c2c__browse_cacheline(struct hist_entry *he)
> >                 key = hist_browser__run(browser, "? - help", true, 0);
> >
> >                 switch (key) {
> > +               case 'a':
> 
> I think it's better to factor this code out to a function.

Ok, will do.

> > +                       if (!browser->selection ||
> > +                           !browser->selection->map ||
> > +                           !browser->selection->map->dso ||
> > +                           browser->selection->map->dso->annotate_warned) {
> > +                               continue;
> > +                       }
> > +
> > +                       ms.map = browser->selection->map;
> > +
> > +                       if (!browser->selection->sym) {
> > +                               if (!browser->he_selection)
> > +                                       continue;
> > +
> > +                               ms.sym = symbol__new_unresolved(browser->he_selection->ip,
> > +                                                               browser->selection->map);
> > +
> > +                               if (!ms.sym)
> > +                                       continue;
> > +                       } else {
> > +                               if (symbol__annotation(browser->selection->sym)->src == NULL) {
> > +                                       ui_browser__warning(&browser->b, 0,
> > +                                               "No samples for the \"%s\" symbol.\n\n",
> > +                                               browser->selection->sym->name);
> > +                                       continue;
> > +                               }
> > +                               ms.sym = browser->selection->sym;
> > +                       }
> > +
> > +                       err = map_symbol__tui_annotate(&ms, c2c_he->evsel, browser->hbt, &c2c.annotation_opts);
> > +
> > +                       ui_browser__update_nr_entries(&browser->b, browser->hists->nr_entries);
> 
> c2c_browser__update_nr_entries() ?

Will it change from the previous call before the while loop? This part
was mostly copied over from do_annotate() in ui/browsers/hists.c so I am
a bit hazy here. My understanding is that update_nr_entries and handle
resize are called here mostly for refresh/reset of the ui and
recalculation of number of entries is not needed

> 
> > +                       if ((err == 'q' || err == CTRL('c')) && browser->he_selection->branch_info)
> 
> Why check branch_info?

This was copied over as well and the comment in hists.c states "offer
option to annotate the other branch source or target (if they exists)
when returning from annotate". So I now think this might not be needed
here at all?

> > +                                       continue;
> > +                       if (err)
> > +                               ui_browser__handle_resize(&browser->b);
> > +
> > +                       continue;
> 
> It'd be natural to use 'break' instead of 'continue' here.

Yes, will change this.

> >                 case 's':
> >                         c2c.symbol_full = !c2c.symbol_full;

snip

> >         perf_session__delete(session);
> >  out:
> > +       annotation_options__init(&c2c.annotation_opts);
> 
> __exit() ?

Ouch, thanks for noticing!

-- 
 Artem

