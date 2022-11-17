Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7A562E357
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 18:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239841AbiKQRmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 12:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240269AbiKQRmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 12:42:00 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A1D6427
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 09:41:58 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id k67so2301536vsk.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 09:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kd4OIsltDDfbHl6+zT1xL8gEcSn2ItTupM6oKlQyk5U=;
        b=B8BYadE3d+8MzrkLbN9LMUlTF7S2fCbrWiQWXXkXH/tvlP/bbWtqgqWnyAH4r5fl/5
         RPWJDAcxzhuR36ggIWggdH0c11QODK4gA6gVbF3pouIlR76pnBe3my0RyYGaqLs6T3v9
         GjafUvX5+amQuopR1fBRYVVlP2bAz4H5cLP4gwQnM43pJIg7W19u1R8SM4T+dds+JNzx
         Dkp088z74mZLpfY2yWBugSlnHi00r0NNn0pmZUDnfhC2GCDZU/DgL09nLPdf5KUDbPnO
         AFFhz3a/Ti5Gs1EktMrRx9XUp8yAr5nTnFNvU+k1O5sb9igV7URTo4Ov0CuJ+Pk+906S
         fF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kd4OIsltDDfbHl6+zT1xL8gEcSn2ItTupM6oKlQyk5U=;
        b=L7Y19wMweAytlLbR1c5piUlzfjk5ncthhychYYhKUaT2vuFUrn/L9WNcttyc1O2cyu
         QbD9dWkFVS9gHIqfxfDwGeeLHJTJE9BnVYz+n4NaPGLAZa7fesSU3j9iPy1FlrIFrOec
         8U9634kcXyi/QzjQImb7KQBe1JKERVGIZ2KQi0l5x9RKc8fEIWn5/3lFBBihCckXxKoe
         bCxd3Ns/3DISP+gTG5bpENYmd4RU1NMs49EPfpy+mZfty1VP+t3/9dF0DxDtrOsUnrWC
         1MMYJjCXAvk+yrsdTpdHsi/ec7o+TbhT5+Hk7wDgE1hh3h8lpb1coKelTGrr1t3nGR/C
         ekNg==
X-Gm-Message-State: ANoB5pnTCpEcruJfUDSpfNfdKkT2QCvZMjW/sBZGr1a1qZ1Ehl7kkc5T
        fOnKZ/9avbZLqTA+/Sj5aj8lIr6rUvmpNLrDs3C4Ew==
X-Google-Smtp-Source: AA0mqf4LPyC81I4X+QAmHUz5fVH0MpTrAKuXHmdOUxqe81KwKV5Tt6DD0ogoE6gaEyelAz7SlfwuLdDjWcMD3dLUWLI=
X-Received: by 2002:a67:e452:0:b0:3aa:7694:a95 with SMTP id
 n18-20020a67e452000000b003aa76940a95mr2316997vsm.41.1668706917121; Thu, 17
 Nov 2022 09:41:57 -0800 (PST)
MIME-Version: 1.0
References: <20221116233854.1596378-1-namhyung@kernel.org> <20221116233854.1596378-6-namhyung@kernel.org>
 <Y3Zb+JChHoq+89yM@kernel.org> <Y3ZeOuNnk0xclY2x@kernel.org>
 <CAP-5=fVh0cQDeqSgVkLHbuiZKoFAp628oggQKwN6KxfUusA01Q@mail.gmail.com> <Y3ZuW2IxVWp9yoaD@kernel.org>
In-Reply-To: <Y3ZuW2IxVWp9yoaD@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 17 Nov 2022 09:41:44 -0800
Message-ID: <CAP-5=fWYi2ASE=v0UgrqbBDA2+jC0qmNX2_4r0wbFLV3Dw2nYw@mail.gmail.com>
Subject: Re: [PATCH 05/12] perf test: Add 'leafloop' test workload
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 9:24 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Nov 17, 2022 at 09:16:58AM -0800, Ian Rogers escreveu:
> > On Thu, Nov 17, 2022 at 8:15 AM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > Em Thu, Nov 17, 2022 at 01:06:16PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > Em Wed, Nov 16, 2022 at 03:38:47PM -0800, Namhyung Kim escreveu:
> > > > > The leafloop workload is to run an infinite loop in the test_leaf
> > > > > function.  This is needed for the ARM fp callgraph test to verify if it
> > > > > gets the correct callchains.
> > > > >
> > > > >   $ perf test -w leafloop
> > > >
> > > > On fedora:36
> > > >
> > > > In file included from /usr/include/bits/libc-header-start.h:33,
> > > >                  from /usr/include/stdlib.h:26,
> > > >                  from tests/workloads/leafloop.c:2:
> > > > /usr/include/features.h:412:4: error: #warning _FORTIFY_SOURCE requires compiling with optimization (-O) [-Werror=cpp]
> > > >   412 | #  warning _FORTIFY_SOURCE requires compiling with optimization (-O)
> > > >       |    ^~~~~~~
> > > > cc1: all warnings being treated as errors
> > > > make[5]: *** [/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/tests/workloads/leafloop.o] Error 1
> > > > make[5]: *** Waiting for unfinished jobs....
> > > >
> > > > I'll try removing the _FORTIFY_SOURCE
> > >
> > > Works after I added this to datasym.c, leafloop.c and brstack.c:
> >
> > Is there a reason we are compiling without -O ? Perhaps we can filter
>
> I assumed so as Namhyung added it, perhaps he is just carrying it from
> the pre-existing shell tests?
>
> I wonder its to have a predictable binary output that the test expects
> when doing things like hardware tracing? As it come from the coresight
> tests, IIRC.

Would the following in the Build be better:

```
# Undefine _FORTIFY_SOURCE as it doesn't work with -O0
CFLAGS_leafloop.o         = -g -O0 -fno-inline -fno-omit-frame-pointer
-U_FORTIFY_SOURCE
```

We could also use make's `filter-out`. If we are disabling inlining
then there is also `-fno-optimize-sibling-calls` otherwise we can
still lose stack frames.

Thanks,
Ian

> - Arnaldo
>
> > setting _FORTIFY_SOURCE so that it depends on -O being enabled.
>
> > Thanks,
> > Ian
> >
> > > diff --git a/tools/perf/tests/workloads/leafloop.c b/tools/perf/tests/workloads/leafloop.c
> > > index 1bf5cc97649b0e23..5d72c001320e3013 100644
> > > --- a/tools/perf/tests/workloads/leafloop.c
> > > +++ b/tools/perf/tests/workloads/leafloop.c
> > > @@ -1,4 +1,5 @@
> > >  /* SPDX-License-Identifier: GPL-2.0 */
> > > +#undef _FORTIFY_SOURCE
> > >  #include <stdlib.h>
> > >  #include <linux/compiler.h>
> > >  #include "../tests.h"
>
> --
>
> - Arnaldo
