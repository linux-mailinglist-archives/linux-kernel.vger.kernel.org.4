Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC37703EEB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245405AbjEOUzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242991AbjEOUzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:55:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67BA9EDF;
        Mon, 15 May 2023 13:55:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EF31623A5;
        Mon, 15 May 2023 20:55:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D42C433EF;
        Mon, 15 May 2023 20:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684184107;
        bh=7M7w+XahRSxDe8CpBjRlAW8VzSsHdjNZ68Q13QXrzvI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dfdfoNZA+ULi9QpJwHHN7LM+9Y/zrXqfzgnTb6bH7J53kg4X8gNKa8OYDcC46YtCG
         IHDgrOWfPn2lkH/t/o7BD+aOWs3yd/0Q0NRNzbxiDWPspC2I+6E1qjTBA6AfgtLez3
         Zbn65xCe1Ma0mpSmGK4DWyPoNvptELa3VPpallbXpBL+ycAZSuctWpdRjr5z8FGVWD
         MUfUo+cIf0cuQ/cJ926OzA1pLVZ23bH8sqbXFC7iviH552vntreg9VO5IVSBtNEeJy
         319+wiqvsbPGa4wDI13NiUHXpB9BYAc/FXFwlUDh1ykxxyKdgKmkyjLq1xX5081D/z
         /Q8pR0lpN3yMA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DA209403B5; Mon, 15 May 2023 17:55:04 -0300 (-03)
Date:   Mon, 15 May 2023 17:55:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 3/3] perf annotate browser: Add '<' and '>' keys for
 navigation
Message-ID: <ZGKcKI/Ba7YLNvcd@kernel.org>
References: <20230511062725.514752-1-namhyung@kernel.org>
 <20230511062725.514752-3-namhyung@kernel.org>
 <CAP-5=fV+LFcMRwHPZUrq=MpOZVp8Q+4vEVKGTQg3rLREfJsg1w@mail.gmail.com>
 <ZGKb+4DXN864kEZ+@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZGKb+4DXN864kEZ+@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 15, 2023 at 05:54:19PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, May 15, 2023 at 10:09:08AM -0700, Ian Rogers escreveu:
> > On Wed, May 10, 2023 at 11:27 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > The hists__find_annotations() allow to move to next or previous symbols
> > > for annotation using the arrow keys.  But TUI annotate_browser__run()
> > > uses the RIGHT key as ENTER to handle jump/call instructions.  That
> > > makes the navigation to the next function impossible.
> > >
> > > I'd like to change it back to move the next symbol but I'm afraid if
> > > some users get confused.  So I added a new pair of keys to handle that.
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > 
> > Acked-by: Ian Rogers <irogers@google.com>
> > 
> > Thanks,
> > Ian
> > 
> > > ---
> > >  tools/perf/builtin-annotate.c     | 4 +++-
> > >  tools/perf/ui/browsers/annotate.c | 4 +++-
> > >  2 files changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> > > index 63cdf6ea6f6d..425a7e2fd6fb 100644
> > > --- a/tools/perf/builtin-annotate.c
> > > +++ b/tools/perf/builtin-annotate.c
> > > @@ -342,7 +342,7 @@ static void hists__find_annotations(struct hists *hists,
> > >                 notes = symbol__annotation(he->ms.sym);
> > >                 if (notes->src == NULL) {
> > >  find_next:
> > > -                       if (key == K_LEFT)
> > > +                       if (key == K_LEFT || key == '<')
> > >                                 nd = rb_prev(nd);
> > >                         else
> > >                                 nd = rb_next(nd);
> > > @@ -378,9 +378,11 @@ static void hists__find_annotations(struct hists *hists,
> > >                                         return;
> > >                                 /* fall through */
> > >                         case K_RIGHT:
> > > +                       case '>':
> > >                                 next = rb_next(nd);
> > >                                 break;
> > >                         case K_LEFT:
> > > +                       case '<':
> > >                                 next = rb_prev(nd);
> > >                                 break;
> > >                         default:
> > > diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> > > index 12c3ce530e42..70bad42b807b 100644
> > > --- a/tools/perf/ui/browsers/annotate.c
> > > +++ b/tools/perf/ui/browsers/annotate.c
> > > @@ -781,9 +781,9 @@ static int annotate_browser__run(struct annotate_browser *browser,
> > >                         ui_browser__help_window(&browser->b,
> > >                 "UP/DOWN/PGUP\n"
> > >                 "PGDN/SPACE    Navigate\n"
> > > +               "</>           Move to prev/next symbol\n"
> > >                 "q/ESC/CTRL+C  Exit\n\n"
> > >                 "ENTER         Go to target\n"
> > > -               "ESC           Exit\n"
> 
> I think the two above were unintentional? I'm removing this hunk.

Humm I see, its a dup, will keep it.

- Arnaldo
