Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3A362E2BB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 18:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbiKQRRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 12:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbiKQRRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 12:17:20 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44253781AA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 09:17:19 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id z189so2218886vsb.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 09:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+G+jefr7ymw5kyDWKXEsX2UJzRRuDh3ZeqTuoucnosI=;
        b=JkGyuBGgxo9i85kQpqZ5qcTcAXTZgX+0FucJmoLGVURLvPyw3ktPx8juDetuvyJGpP
         KnxHThmpS+6vJMTzxkmavPjHquGZRhlxtepePATfV+d+7I5rURj7vSTYRGo0Is6PaaBr
         +9MKfu80+K7LRoiN6XbLBiSyUyBfVSSymRCRP+H/A9xAnU8UeSfRmXM53GuEpQVWbIn1
         3GG4QzjC7duHxLKukZcKDyYlP3H7jIPMJ9MwWoyinM7XG78psdqigRcOt0jV9+Vu7AUX
         WjVtvGBm1DK5qj8GtXPtRs0wYoW0DknwokeCm4hclKH1ge0XZUf9x817ppsEtvLQE06K
         Hz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+G+jefr7ymw5kyDWKXEsX2UJzRRuDh3ZeqTuoucnosI=;
        b=sRMz8bOQEX9hgFtCoVA9N5HtkPEGWXsAQNr6MUpoxbp8Aue7tMz5n9A3WULkjKJ0ka
         UkisqcA+l9gplsy9sOYNhoAeLKvSCk4JljdgmkwjJR4kvwI/pqwbFgDY/Q/IEg2d/q8n
         01k8SBGveF+k0F7NNBX9RjiSo9Vv6t0d9cTB9tBKJwk/mokXa48hRDVfQOsDxkx5/iBk
         0aNyVG0RX/G104O15+KxJfQehlejftCHfGc5W5R9F5jF7kO/0HzgGAp6QR+nbuEKY661
         aFIsTWhJSHMKHorO37qvrPaAsvvihfINa/4ABlPhM6f2la5p7aiXmP43A9M8OXpRgtG0
         9a8Q==
X-Gm-Message-State: ANoB5pkGw3rKcI09n2d07QMRaQ+Z36SuDPoGJ6vkurd5eBgn+uoKvtHP
        El+8tSW9sGvoD6b5nyoU9rTocsjOVU/3BqXZbGU2nNFC76k=
X-Google-Smtp-Source: AA0mqf6o5O8WcF98p+5ZxX6+tjqqIRX8IpB/mR0JAvkF5WAWpALeNCUqSrpNVB929I1pm0qQyZJze9O0lMFdO7HygNM=
X-Received: by 2002:a05:6102:318e:b0:3ad:1459:6936 with SMTP id
 c14-20020a056102318e00b003ad14596936mr2266833vsh.23.1668705438144; Thu, 17
 Nov 2022 09:17:18 -0800 (PST)
MIME-Version: 1.0
References: <20221116233854.1596378-1-namhyung@kernel.org> <20221116233854.1596378-6-namhyung@kernel.org>
 <Y3Zb+JChHoq+89yM@kernel.org> <Y3ZeOuNnk0xclY2x@kernel.org>
In-Reply-To: <Y3ZeOuNnk0xclY2x@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 17 Nov 2022 09:16:58 -0800
Message-ID: <CAP-5=fVh0cQDeqSgVkLHbuiZKoFAp628oggQKwN6KxfUusA01Q@mail.gmail.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 8:15 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Nov 17, 2022 at 01:06:16PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Nov 16, 2022 at 03:38:47PM -0800, Namhyung Kim escreveu:
> > > The leafloop workload is to run an infinite loop in the test_leaf
> > > function.  This is needed for the ARM fp callgraph test to verify if it
> > > gets the correct callchains.
> > >
> > >   $ perf test -w leafloop
> >
> > On fedora:36
> >
> > In file included from /usr/include/bits/libc-header-start.h:33,
> >                  from /usr/include/stdlib.h:26,
> >                  from tests/workloads/leafloop.c:2:
> > /usr/include/features.h:412:4: error: #warning _FORTIFY_SOURCE requires compiling with optimization (-O) [-Werror=cpp]
> >   412 | #  warning _FORTIFY_SOURCE requires compiling with optimization (-O)
> >       |    ^~~~~~~
> > cc1: all warnings being treated as errors
> > make[5]: *** [/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/tests/workloads/leafloop.o] Error 1
> > make[5]: *** Waiting for unfinished jobs....
> >
> > I'll try removing the _FORTIFY_SOURCE
>
> Works after I added this to datasym.c, leafloop.c and brstack.c:

Is there a reason we are compiling without -O ? Perhaps we can filter
setting _FORTIFY_SOURCE so that it depends on -O being enabled.

Thanks,
Ian

> diff --git a/tools/perf/tests/workloads/leafloop.c b/tools/perf/tests/workloads/leafloop.c
> index 1bf5cc97649b0e23..5d72c001320e3013 100644
> --- a/tools/perf/tests/workloads/leafloop.c
> +++ b/tools/perf/tests/workloads/leafloop.c
> @@ -1,4 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> +#undef _FORTIFY_SOURCE
>  #include <stdlib.h>
>  #include <linux/compiler.h>
>  #include "../tests.h"
