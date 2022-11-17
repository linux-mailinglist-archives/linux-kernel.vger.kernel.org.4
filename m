Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E7862E2EE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 18:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbiKQRYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 12:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiKQRYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 12:24:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03614C252;
        Thu, 17 Nov 2022 09:24:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA5B0621D6;
        Thu, 17 Nov 2022 17:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC912C433D6;
        Thu, 17 Nov 2022 17:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668705887;
        bh=ciiPAicDMVFm+5iziU6lbJHVrHXpHFnxKld+29nDL1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XuJgXHQ/a4azaN3G9sfhFb0/beyFlIKresutiY2PqHYvWxmB9C7g44/PXB10ktYXI
         T6sFpsASiTE7MEWVFdt5HDA3mtvqqpQWAt14saQRhpiLqKD+Vg1ktBRcQ/NkzarEW9
         p0PMPBeLnwOOoUbiNHsmYFgqLUB7JZloyUiSILjZg5NT60b5Xy6rV1kvB6ymE3HCIy
         CMAYSGWg5UzbG4/FtDiUhPUcjjJkFvofQ3M3DBfF1VapkQ2ozTdOjcZEBdyk7Goxpg
         3ADmKSqU5Y7cMtJZvka+lmNaZjIxm2hiU+TLf4joWUvJqR0RW6Crhsirmvrc456w/9
         Hd1WFhtA8ekTw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9F5F34034E; Thu, 17 Nov 2022 14:24:43 -0300 (-03)
Date:   Thu, 17 Nov 2022 14:24:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        German Gomez <german.gomez@arm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH 05/12] perf test: Add 'leafloop' test workload
Message-ID: <Y3ZuW2IxVWp9yoaD@kernel.org>
References: <20221116233854.1596378-1-namhyung@kernel.org>
 <20221116233854.1596378-6-namhyung@kernel.org>
 <Y3Zb+JChHoq+89yM@kernel.org>
 <Y3ZeOuNnk0xclY2x@kernel.org>
 <CAP-5=fVh0cQDeqSgVkLHbuiZKoFAp628oggQKwN6KxfUusA01Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVh0cQDeqSgVkLHbuiZKoFAp628oggQKwN6KxfUusA01Q@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 17, 2022 at 09:16:58AM -0800, Ian Rogers escreveu:
> On Thu, Nov 17, 2022 at 8:15 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Thu, Nov 17, 2022 at 01:06:16PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Wed, Nov 16, 2022 at 03:38:47PM -0800, Namhyung Kim escreveu:
> > > > The leafloop workload is to run an infinite loop in the test_leaf
> > > > function.  This is needed for the ARM fp callgraph test to verify if it
> > > > gets the correct callchains.
> > > >
> > > >   $ perf test -w leafloop
> > >
> > > On fedora:36
> > >
> > > In file included from /usr/include/bits/libc-header-start.h:33,
> > >                  from /usr/include/stdlib.h:26,
> > >                  from tests/workloads/leafloop.c:2:
> > > /usr/include/features.h:412:4: error: #warning _FORTIFY_SOURCE requires compiling with optimization (-O) [-Werror=cpp]
> > >   412 | #  warning _FORTIFY_SOURCE requires compiling with optimization (-O)
> > >       |    ^~~~~~~
> > > cc1: all warnings being treated as errors
> > > make[5]: *** [/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/tests/workloads/leafloop.o] Error 1
> > > make[5]: *** Waiting for unfinished jobs....
> > >
> > > I'll try removing the _FORTIFY_SOURCE
> >
> > Works after I added this to datasym.c, leafloop.c and brstack.c:
> 
> Is there a reason we are compiling without -O ? Perhaps we can filter

I assumed so as Namhyung added it, perhaps he is just carrying it from
the pre-existing shell tests?

I wonder its to have a predictable binary output that the test expects
when doing things like hardware tracing? As it come from the coresight
tests, IIRC.

- Arnaldo

> setting _FORTIFY_SOURCE so that it depends on -O being enabled.
 
> Thanks,
> Ian
> 
> > diff --git a/tools/perf/tests/workloads/leafloop.c b/tools/perf/tests/workloads/leafloop.c
> > index 1bf5cc97649b0e23..5d72c001320e3013 100644
> > --- a/tools/perf/tests/workloads/leafloop.c
> > +++ b/tools/perf/tests/workloads/leafloop.c
> > @@ -1,4 +1,5 @@
> >  /* SPDX-License-Identifier: GPL-2.0 */
> > +#undef _FORTIFY_SOURCE
> >  #include <stdlib.h>
> >  #include <linux/compiler.h>
> >  #include "../tests.h"

-- 

- Arnaldo
