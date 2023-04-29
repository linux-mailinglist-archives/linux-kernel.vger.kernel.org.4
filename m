Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81636F221B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 03:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347271AbjD2Bec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 21:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjD2Beb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 21:34:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452462134;
        Fri, 28 Apr 2023 18:34:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0D0F6327E;
        Sat, 29 Apr 2023 01:34:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3B0C433D2;
        Sat, 29 Apr 2023 01:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682732068;
        bh=kCC4iEEf5RF+THve+YJpPhq/LRRoIrDbIu25AAEMQzk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t3w9EMaTfEnlV0yFJttk6b8csUC0fYZ9mmPXp79RLzG+uTR0KJZOdXT/tAo2GF0kh
         lnGlAbvqCTjs8EKsTzK1kxUH/M4OR7tXdMe8e3O0VsiKCg8p9IJ5HQl2b3JO3itQ2y
         B4uOyOjutZAnJOhMjdp+RanmPMsSxgxwH31x+3Jzu+jbkM/z7KgeebopscNGBdIzf/
         /KoqKvUhTwBCz3IiwhIlKN7wC7N7BeNqLLwuuUOO3As9BuLh3fNLuNQ/qh//tsd7tx
         MiLACUeCDIMEHogrjjjAXH/tbDbq8c0fnsXiKFxx4UI7mmvrWRW9V3tFBA8e9cbRlk
         hVDnxTLJzZPXQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 35E0E403B5; Fri, 28 Apr 2023 22:34:25 -0300 (-03)
Date:   Fri, 28 Apr 2023 22:34:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Justin M. Forbes" <jforbes@fedoraproject.org>
Subject: Re: [PATCH v2] perf: Avoid implicit function declarations in
 lexer/parse interface
Message-ID: <ZEx0IQAtBatrRDCR@kernel.org>
References: <87sfcn7uot.fsf@oldenburg.str.redhat.com>
 <CAP-5=fXZv+KCdCN05wVUcAwDCZAgXjWunoaviGBQEiUPqNwOmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXZv+KCdCN05wVUcAwDCZAgXjWunoaviGBQEiUPqNwOmg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 25, 2023 at 10:40:14AM -0700, Ian Rogers escreveu:
> On Tue, Apr 25, 2023 at 10:12 AM Florian Weimer <fweimer@redhat.com> wrote:
> >
> > In future compilers, -Wno-implicit-function-declaration may not bring
> > back support for implicit function declarations, a feature that was
> > removed from the C language in C99.  Instead of relying on implicit
> > declarations, include the flex-generated header from the
> > bison-generated C code.
> >
> > he expr-flex.h header needs to be included later than the others
> 
> nit: s/he/The/
> 
> > because at the early point, the definition of YYSTYPE is not yet
> > available.
> >
> > Signed-off-by: Florian Weimer <fweimer@redhat.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>
> 
> Thanks for fighting the build wrt parallel dependencies!
> Ian


Thanks, applied. BTW b4 coulnd't find this message (nor the original):

⬢[acme@toolbox perf-tools-next]$ b4 am -ctsl --cc-trailers 87sfcn7uot.fsf@oldenburg.str.redhat.com
Grabbing thread from lore.kernel.org/all/87sfcn7uot.fsf%40oldenburg.str.redhat.com/t.mbox.gz
That message-id is not known.
⬢[acme@toolbox perf-tools-next]$ b4 am -ctsl --cc-trailers CAP-5=fXZv+KCdCN05wVUcAwDCZAgXjWunoaviGBQEiUPqNwOmg@mail.gmail.com
Grabbing thread from lore.kernel.org/all/CAP-5%3DfXZv%2BKCdCN05wVUcAwDCZAgXjWunoaviGBQEiUPqNwOmg%40mail.gmail.com/t.mbox.gz
Analyzing 1 messages in the thread
No patches found.
⬢[acme@toolbox perf-tools-next]$

I applied it in the old fashion.


- Arnaldo

 
> > ---
> > v2: Include the flex-generated files instead of manually-written prototypes.
> >
> >  tools/perf/util/Build          | 10 +++++++++-
> >  tools/perf/util/expr.y         |  2 ++
> >  tools/perf/util/parse-events.y |  1 +
> >  tools/perf/util/pmu.y          |  1 +
> >  4 files changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > index 918b501f9bd8..92897068c362 100644
> > --- a/tools/perf/util/Build
> > +++ b/tools/perf/util/Build
> > @@ -283,7 +283,7 @@ CFLAGS_expr-flex.o          += $(flex_flags)
> >  bison_flags := -DYYENABLE_NLS=0
> >  BISON_GE_35 := $(shell expr $(shell $(BISON) --version | grep bison | sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\)/\1\2/g') \>\= 35)
> >  ifeq ($(BISON_GE_35),1)
> > -  bison_flags += -Wno-unused-parameter -Wno-nested-externs -Wno-implicit-function-declaration -Wno-switch-enum -Wno-unused-but-set-variable -Wno-unknown-warning-option
> > +  bison_flags += -Wno-unused-parameter -Wno-nested-externs -Wno-switch-enum -Wno-unused-but-set-variable -Wno-unknown-warning-option
> >  else
> >    bison_flags += -w
> >  endif
> > @@ -340,3 +340,11 @@ $(OUTPUT)util/vsprintf.o: ../lib/vsprintf.c FORCE
> >  $(OUTPUT)util/list_sort.o: ../lib/list_sort.c FORCE
> >         $(call rule_mkdir)
> >         $(call if_changed_dep,cc_o_c)
> > +
> > +# These dependencies ensure that the flex-generated .h file is
> > +# available at the time the bison-generated .c sources are compiled.
> > +# Do not depend on the generated .h file to prevent triggering
> > +# parallel flex invocations for the same two output files.
> > +$(OUTPUT)util/expr-bison.o : $(OUTPUT)util/expr-flex.c
> > +$(OUTPUT)util/parse-events-bison.o : $(OUTPUT)util/parse-events-flex.c
> > +$(OUTPUT)util/pmu-bison.o : $(OUTPUT)util/pmu-flex.c
> > diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> > index 635e562350c5..99581193ca4c 100644
> > --- a/tools/perf/util/expr.y
> > +++ b/tools/perf/util/expr.y
> > @@ -53,6 +53,8 @@
> >  %destructor { ids__free($$.ids); } <ids>
> >
> >  %{
> > +#include "expr-flex.h"
> > +
> >  static void expr_error(double *final_val __maybe_unused,
> >                        struct expr_parse_ctx *ctx __maybe_unused,
> >                        bool compute_ids __maybe_unused,
> > diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> > index be8c51770051..67a7f70c4767 100644
> > --- a/tools/perf/util/parse-events.y
> > +++ b/tools/perf/util/parse-events.y
> > @@ -17,6 +17,7 @@
> >  #include "evsel.h"
> >  #include "parse-events.h"
> >  #include "parse-events-bison.h"
> > +#include "parse-events-flex.h"
> >
> >  void parse_events_error(YYLTYPE *loc, void *parse_state, void *scanner, char const *msg);
> >
> > diff --git a/tools/perf/util/pmu.y b/tools/perf/util/pmu.y
> > index e675d79a0274..2170f1ac7b74 100644
> > --- a/tools/perf/util/pmu.y
> > +++ b/tools/perf/util/pmu.y
> > @@ -9,6 +9,7 @@
> >  #include <linux/bitmap.h>
> >  #include <string.h>
> >  #include "pmu.h"
> > +#include "pmu-flex.h"
> >
> >  #define ABORT_ON(val) \
> >  do { \
> >
> > base-commit: 173ea743bf7a9eef04460e03b00ba267cc52aee2
> >

-- 

- Arnaldo
