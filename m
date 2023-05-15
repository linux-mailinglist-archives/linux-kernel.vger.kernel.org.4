Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26E0703EE8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245390AbjEOUy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244817AbjEOUyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:54:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7349EDF;
        Mon, 15 May 2023 13:54:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29B4B624D3;
        Mon, 15 May 2023 20:54:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B276C433D2;
        Mon, 15 May 2023 20:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684184062;
        bh=n9VyGRNUJDkLTEUulgC2aa9ObEOGijpX7zOS2WKs5FY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IwYgj53VUTN3MX6a4+0pmH6Lz2xdtgiknjyMyyAsTvtVdi3EuKM5zLb4VKYdh0umv
         pXAQtvVZl6Rw+UgeaH5dImJzLRbwxldjKukRp/zxG8xnYCBV2nMcQzZQbZhAaWr6ul
         pa4OL+NIteBWG2xMJnXVeiDDoyn7wbaq1RlCesiS67bhD0Qf1zSC7ry9/nuPbUPaNq
         bE5WEa24R4XEfMjn0uQZyvijvgp6lLYcJt7LdV02tROrZbYLDZNvhiUyD/1c/rs+8D
         hO9LTDSyJGMsi+wJK8L1Em3l1V0GIvrPHEFzZ0nikQS/unA2zWsVVOlhxaLUIEIdGL
         SfqLnF8iyrQrQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DCD22403B5; Mon, 15 May 2023 17:54:19 -0300 (-03)
Date:   Mon, 15 May 2023 17:54:19 -0300
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
Message-ID: <ZGKb+4DXN864kEZ+@kernel.org>
References: <20230511062725.514752-1-namhyung@kernel.org>
 <20230511062725.514752-3-namhyung@kernel.org>
 <CAP-5=fV+LFcMRwHPZUrq=MpOZVp8Q+4vEVKGTQg3rLREfJsg1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV+LFcMRwHPZUrq=MpOZVp8Q+4vEVKGTQg3rLREfJsg1w@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 15, 2023 at 10:09:08AM -0700, Ian Rogers escreveu:
> On Wed, May 10, 2023 at 11:27 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The hists__find_annotations() allow to move to next or previous symbols
> > for annotation using the arrow keys.  But TUI annotate_browser__run()
> > uses the RIGHT key as ENTER to handle jump/call instructions.  That
> > makes the navigation to the next function impossible.
> >
> > I'd like to change it back to move the next symbol but I'm afraid if
> > some users get confused.  So I added a new pair of keys to handle that.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Acked-by: Ian Rogers <irogers@google.com>
> 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/builtin-annotate.c     | 4 +++-
> >  tools/perf/ui/browsers/annotate.c | 4 +++-
> >  2 files changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> > index 63cdf6ea6f6d..425a7e2fd6fb 100644
> > --- a/tools/perf/builtin-annotate.c
> > +++ b/tools/perf/builtin-annotate.c
> > @@ -342,7 +342,7 @@ static void hists__find_annotations(struct hists *hists,
> >                 notes = symbol__annotation(he->ms.sym);
> >                 if (notes->src == NULL) {
> >  find_next:
> > -                       if (key == K_LEFT)
> > +                       if (key == K_LEFT || key == '<')
> >                                 nd = rb_prev(nd);
> >                         else
> >                                 nd = rb_next(nd);
> > @@ -378,9 +378,11 @@ static void hists__find_annotations(struct hists *hists,
> >                                         return;
> >                                 /* fall through */
> >                         case K_RIGHT:
> > +                       case '>':
> >                                 next = rb_next(nd);
> >                                 break;
> >                         case K_LEFT:
> > +                       case '<':
> >                                 next = rb_prev(nd);
> >                                 break;
> >                         default:
> > diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> > index 12c3ce530e42..70bad42b807b 100644
> > --- a/tools/perf/ui/browsers/annotate.c
> > +++ b/tools/perf/ui/browsers/annotate.c
> > @@ -781,9 +781,9 @@ static int annotate_browser__run(struct annotate_browser *browser,
> >                         ui_browser__help_window(&browser->b,
> >                 "UP/DOWN/PGUP\n"
> >                 "PGDN/SPACE    Navigate\n"
> > +               "</>           Move to prev/next symbol\n"
> >                 "q/ESC/CTRL+C  Exit\n\n"
> >                 "ENTER         Go to target\n"
> > -               "ESC           Exit\n"

I think the two above were unintentional? I'm removing this hunk.

- Arnaldo

> >                 "H             Go to hottest instruction\n"
> >                 "TAB/shift+TAB Cycle thru hottest instructions\n"
> >                 "j             Toggle showing jump to target arrows\n"
> > @@ -913,6 +913,8 @@ static int annotate_browser__run(struct annotate_browser *browser,
> >                         annotation__toggle_full_addr(notes, ms);
> >                         continue;
> >                 case K_LEFT:
> > +               case '<':
> > +               case '>':
> >                 case K_ESC:
> >                 case 'q':
> >                 case CTRL('c'):
> > --
> > 2.40.1.521.gf1e218fcd8-goog
> >

-- 

- Arnaldo
