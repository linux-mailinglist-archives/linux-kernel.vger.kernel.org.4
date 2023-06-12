Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8356672CED5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237396AbjFLS6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237389AbjFLS6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:58:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2101E10CC
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:58:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A791D6293D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 18:58:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B63C433D2;
        Mon, 12 Jun 2023 18:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686596288;
        bh=NzOrgjY0PmQqVNWzeQrVfJyOEmAeF8b3sOa3eh1Li80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KokyR1J1m99amxx7Bf7mz7VNJmcftwvr26eexJqYu3PuOXUnGmjdK7deHzFNdYVJY
         QZNBagXQrx1fia5BX7uwYMQzqteuE4oY37Uj/yhh9TtT+ZQXBV1tr6KJtOjg663uvd
         VOTpUyD9A+6xYY2MpBWaDW/w9gDaBeWKClneYfHgFNwiJ55CDQYSB+WKKHbDQl+70t
         1NzdxH71TsAf+PfeQpj2YTpPwd/+7RfQ7BYhpCi438t75ZWFPU3A5GnbtmONZ+N22r
         U3UDrh3QsYcDpftflYMQLQf59RHTLIHZiAbkIcl8Cs0S9iAF0MfW4+RDKrPcZ9uopm
         S+tqjk/lNG2ew==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9065740692; Mon, 12 Jun 2023 15:58:05 -0300 (-03)
Date:   Mon, 12 Jun 2023 15:58:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] perf script: Fix allocation of evsel->priv related
 to per-event dump files
Message-ID: <ZIdqvQVkK0vUYw1O@kernel.org>
References: <ZH+F0wGAWV14zvMP@kernel.org>
 <CAP-5=fUNefbgzKNVDZJZvem0bm8cYhc4FPQzp+Ja7v9n6y5ufA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUNefbgzKNVDZJZvem0bm8cYhc4FPQzp+Ja7v9n6y5ufA@mail.gmail.com>
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

Em Tue, Jun 06, 2023 at 04:14:51PM -0700, Ian Rogers escreveu:
> On Tue, Jun 6, 2023 at 12:15 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > I'm carrying this in my perf-tools-next, please ack :-)
> >
> > - Arnaldo
> >
> > ---
> >
> > When printing output we may want to generate per event files, where the
> > --per-event-dump option should be used, creating perf.data.EVENT.dump
> > files instead of printing to stdout.
> >
> > The callback thar processes event thus expects that evsel->priv->fp
> > should point to either the per-event FILE descriptor or to stdout.
> >
> > The a3af66f51bd0bca7 ("perf script: Fix crash because of missing
> > evsel->priv") changeset fixed a case where evsel->priv wasn't setup,
> > thus set to NULL, causing a segfault when trying to access
> > evsel->priv->fp.
> >
> > But it did it for the non --per-event-dump case by allocating a 'struct
> > perf_evsel_script' just to set its ->fp to stdout.
> >
> > Since evsel->priv is only freed when --per-event-dump is used, we ended
> > up with a memory leek, detected using ASAN.
> 
> nit: s/leek/leak/

Fixed
 
> >
> > Fix it by using the same method as perf_script__setup_per_event_dump(),
> > and reuse that static 'struct perf_evsel_script'.
> >
> > Also check if evsel_script__new() failed.
> >
> > Fixes: a3af66f51bd0bca7 ("perf script: Fix crash because of missing evsel->priv")
> > Reported-by: Ian Rogers <irogers@google.com>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Tested on top of my asan work:
> Tested-by: Ian Rogers <irogers@google.com>

Thanks,

- Arnaldo
 
> > ---
> >  tools/perf/builtin-script.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index 70549fc93b125394..b02ad386a55baf07 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -2410,6 +2410,9 @@ static int process_sample_event(struct perf_tool *tool,
> >         return ret;
> >  }
> >
> > +// Used when scr->per_event_dump is not set
> > +static struct evsel_script es_stdout;
> > +
> >  static int process_attr(struct perf_tool *tool, union perf_event *event,
> >                         struct evlist **pevlist)
> >  {
> > @@ -2418,7 +2421,6 @@ static int process_attr(struct perf_tool *tool, union perf_event *event,
> >         struct evsel *evsel, *pos;
> >         u64 sample_type;
> >         int err;
> > -       static struct evsel_script *es;
> >
> >         err = perf_event__process_attr(tool, event, pevlist);
> >         if (err)
> > @@ -2428,14 +2430,13 @@ static int process_attr(struct perf_tool *tool, union perf_event *event,
> >         evsel = evlist__last(*pevlist);
> >
> >         if (!evsel->priv) {
> > -               if (scr->per_event_dump) {
> > +               if (scr->per_event_dump) {
> 
> nit: whitespace issue.
> 
> >                         evsel->priv = evsel_script__new(evsel, scr->session->data);
> > -               } else {
> > -                       es = zalloc(sizeof(*es));
> > -                       if (!es)
> > +                       if (!evsel->priv)
> >                                 return -ENOMEM;
> > -                       es->fp = stdout;
> > -                       evsel->priv = es;
> > +               } else { // Replicate what is done in perf_script__setup_per_event_dump()
> > +                       es_stdout.fp = stdout;
> > +                       evsel->priv = &es_stdout;
> >                 }
> >         }
> >
> > @@ -2741,7 +2742,6 @@ static int perf_script__fopen_per_event_dump(struct perf_script *script)
> >  static int perf_script__setup_per_event_dump(struct perf_script *script)
> >  {
> >         struct evsel *evsel;
> > -       static struct evsel_script es_stdout;
> >
> >         if (script->per_event_dump)
> >                 return perf_script__fopen_per_event_dump(script);
> > --
> > 2.37.1
> >

-- 

- Arnaldo
