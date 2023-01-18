Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F86671EC1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjARODT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjAROC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:02:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8332953F9A;
        Wed, 18 Jan 2023 05:37:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FDCC617D4;
        Wed, 18 Jan 2023 13:37:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6C1C433D2;
        Wed, 18 Jan 2023 13:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674049035;
        bh=0xJGKj3eRqUoWBwB+TjH6T+WceRDQEQkTnoUc5UVybU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JJE4rrtphL6e9IS0xXRTIi59Nl06Yzx++7lIR0xkpflGRDTvhL5qpX1KhZaufA6/e
         PWP2ddV4Otbx3auIz1juBpjuGyN4Lfjq4dU23T0R3rgLIvDidvpQviKjxQQJiLm7RH
         1W6m4T22I/hRnJA95HUDZWXHfH/nSi0WmZXbBK0Ib5Z5mp4bnh/qGAy7SAfW1rievj
         ZflxyWBYcH+PAfay5lwQPcWpSE+aMWiIbnDVz9NrJaej1Kasp21ElOz0tTOQv5+rZ2
         mNvdxWF13kzf+54tGC1KfaJG0NNafipHU3isqHfeWtZJXuizeN/y6ndWVgTNPuGgCg
         OS0haJ8FVyzUg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BBAB7405BE; Wed, 18 Jan 2023 10:37:12 -0300 (-03)
Date:   Wed, 18 Jan 2023 10:37:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sohom Datta <sohomdatta1+git@gmail.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Prevent normalize() from reading into undefined memory
Message-ID: <Y8f2CCUYzDfXtUTG@kernel.org>
References: <20221204105836.1012885-1-sohomdatta1+git@gmail.com>
 <Y7rPZ21J2mnWiIcx@krava>
 <CAP-5=fUjto38BaJX+Uj-BUOc74vg5KqZFewVCuUTW81Q=PAXHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUjto38BaJX+Uj-BUOc74vg5KqZFewVCuUTW81Q=PAXHA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jan 08, 2023 at 04:55:59PM -0800, Ian Rogers escreveu:
> On Sun, Jan 8, 2023, 6:13 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > On Sun, Dec 04, 2022 at 04:28:35PM +0530, Sohom Datta wrote:
> > > The current implementation does not account for a
> > > trailing backslash followed by a null-byte. If a
> > > null-byte is encountered following a backslash,
> > > normalize() will continue reading (and potentially
> > > writing) into garbage memory ignoring the EOS
> > > null-byte.
> > >
> > > Signed-off-by: Sohom Datta <sohomdatta1+git@gmail.com>
> >
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> >
> > thanks,
> > jirka
> >
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied. Sorry for the delay, probably I didn't saw the "perf
tools: ' prefix in the subject and this fell thru the cracks :-\

Thanks to Ingo for pinging me about this, appreciated.

- Arnaldo
 
> Thanks,
> Ian
> 
> > ---
> > >  tools/perf/util/expr.l | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
> > > index 0168a9637330..d47de5f270a8 100644
> > > --- a/tools/perf/util/expr.l
> > > +++ b/tools/perf/util/expr.l
> > > @@ -42,8 +42,11 @@ static char *normalize(char *str, int runtime)
> > >       char *dst = str;
> > >
> > >       while (*str) {
> > > -             if (*str == '\\')
> > > +             if (*str == '\\') {
> > >                       *dst++ = *++str;
> > > +                     if (!*str)
> > > +                             break;
> > > +             }
> > >               else if (*str == '?') {
> > >                       char *paramval;
> > >                       int i = 0;
> > > --
> > > 2.38.1
> > >
> >
