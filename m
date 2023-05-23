Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC4670E534
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 21:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237938AbjEWTSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 15:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjEWTS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 15:18:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8436991;
        Tue, 23 May 2023 12:18:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20C78619E6;
        Tue, 23 May 2023 19:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4D8C4339B;
        Tue, 23 May 2023 19:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684869507;
        bh=c3YaECBvIL688/luHj1FT0nFTaRLKDTPaXQJSYsHc0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W9nCu6MX47sikJ2H5nchZ2DMyg6Iy6kPQKKcDQg6xQaIOBIsnewT1h/9dQtqE9D3i
         PZohbmq36RYN/9MZ1/EphHRi2NC8XoVOyuRM1HpOWQAJ/m0L9b3s6Cg+CWber/vICm
         n/oSn/znzRB2c0M/SJzeLdkbsh2y3MqNobjc7h84EPDL9MOv1+CFhzpiLfvr5yFeAe
         0ZxQn/m7kwr2skA+/R5hOIoUkaS9Gwgq8cKF4pfrwLgf09p84ecdrVD1760dnazI30
         h90rXstAdEQD8Rdv78zMTJ5rqVrCY6GoNvpvwVs/zXnzPdWjYpi14n85yQjSdDpYTc
         92SdEp3HrlOdA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 766FA403B5; Tue, 23 May 2023 16:18:24 -0300 (-03)
Date:   Tue, 23 May 2023 16:18:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 14/15] perf jevents: Add support for metricgroup
 descriptions
Message-ID: <ZG0RgAjiqQHoVXQR@kernel.org>
References: <20230517173805.602113-1-irogers@google.com>
 <20230517173805.602113-15-irogers@google.com>
 <ZGzYroXZUsPTNZVE@kernel.org>
 <CAP-5=fXKvhqySuomqHU5FMh17N=R-TVoJgLEWU=UgM+HVhSdLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXKvhqySuomqHU5FMh17N=R-TVoJgLEWU=UgM+HVhSdLQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 23, 2023 at 08:58:25AM -0700, Ian Rogers escreveu:
> On Tue, May 23, 2023 at 8:16 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Wed, May 17, 2023 at 10:38:03AM -0700, Ian Rogers escreveu:
> > > Metrics have a field where the groups they belong to are listed like
> > > the following from
> > > tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json:
> > >
> > >         "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
> > >         "MetricName": "tma_frontend_bound",
> >
> >   LD      /tmp/build/perf-tools-next/util/perf-in.o
> >   LD      /tmp/build/perf-tools-next/perf-in.o
> >   CC      /tmp/build/perf-tools-next/pmu-events/pmu-events.o
> > In file included from /var/home/acme/git/perf-tools-next/tools/include/linux/bitmap.h:9,
> >                  from /var/home/acme/git/perf-tools-next/tools/perf/util/header.h:10,
> >                  from /tmp/build/perf-tools-next/pmu-events/pmu-events.c:3:
> > /tmp/build/perf-tools-next/pmu-events/pmu-events.c: In function ‘describe_metricgroup’:
> > /var/home/acme/git/perf-tools-next/tools/include/linux/kernel.h:102:25: error: overflow in conversion from ‘long unsigned int’ to ‘int’ changes value from ‘18446744073709551615’ to ‘-1’ [-Werror=overflow]
> >   102 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
> >       |                         ^
> > /tmp/build/perf-tools-next/pmu-events/pmu-events.c:61603:29: note: in expansion of macro ‘ARRAY_SIZE’
> > 61603 |         int low = 0, high = ARRAY_SIZE(metricgroups) - 1;
> >       |                             ^~~~~~~~~~
> > cc1: all warnings being treated as errors
> > make[3]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:98: /tmp/build/perf-tools-next/pmu-events/pmu-events.o] Error 1
> > make[2]: *** [Makefile.perf:679: /tmp/build/perf-tools-next/pmu-events/pmu-events-in.o] Error 2
> > make[1]: *** [Makefile.perf:236: sub-make] Error 2
> > make: *** [Makefile:113: install-bin] Error 2
> > make: Leaving directory '/var/home/acme/git/perf-tools-next/tools/perf'
> >
> >  Performance counter stats for 'make -k BUILD_BPF_SKEL=1 CORESIGHT=1 O=/tmp/build/perf-tools-next -C tools/perf install-bin':
> >
> >       241752971879      cycles:u
> >       296060193784      instructions:u                   #    1.22  insn per cycle
> >
> >        6.129451072 seconds time elapsed
> >
> >       59.018259000 seconds user
> >       12.132871000 seconds sys
> >
> >
> > ⬢[acme@toolbox perf-tools-next]$ fg
> > git rebase -i HEAD~15
> >
> > [1]+  Stopped                 git rebase -i HEAD~15
> > ⬢[acme@toolbox perf-tools-next]$ git log --oneline -1
> > 995a2beaa64deb7b (HEAD) perf jevents: Add support for metricgroup descriptions
> > ⬢[acme@toolbox perf-tools-next]$
> >
> > Applied 1-13, pushing to tmp.perf-tools-next,
> >
> > - Arnaldo
> 
> Thanks, there's a missing (int) cast on ARRAY_SIZE. It doesn't make
> sense to resend the entire series so I'll wait to rebase, add the cast
> and then resend in v2 - that's unless you beat me to it ;-)

I made the amendment below, now lets see why it is not building after
the next patch is applied...

- Arnaldo

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 8fca7c9adee0c354..7ed258be18292241 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -938,7 +938,7 @@ static const int metricgroups[][2] = {
 
 const char *describe_metricgroup(const char *group)
 {
-        int low = 0, high = ARRAY_SIZE(metricgroups) - 1;
+        int low = 0, high = (int)ARRAY_SIZE(metricgroups) - 1;
 
         while (low <= high) {
                 int mid = (low + high) / 2;
