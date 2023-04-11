Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841D56DCEA6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 03:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjDKBCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 21:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjDKBCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 21:02:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39F5272A;
        Mon, 10 Apr 2023 18:02:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30CA66160D;
        Tue, 11 Apr 2023 01:02:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BD5C433D2;
        Tue, 11 Apr 2023 01:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681174948;
        bh=09CCZjy87xxOe0DkfHZpMCRVWG3qG7BLPcmM01KF3pM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TzyxS4VixjI9lOtPrfkEoO3fajNs9bsmroJxpuSjXsga5CB9YSzF5K3lxz/mb4Ig3
         DsB4rCR1LYHDax46EaDukpgWsUNb9WSgCaBpDm1z3nXu5FekVBGniP8vn402S2Id3K
         KsMPytgESLrO66OHVwiIcjmT67AkS0HjaDlGskMAVQy3GjB+ik0fD0FH4he02oVRdM
         fgZ+vXw5U7BukpGJCVriR0ThDMpfYl3ojpHVdp6sMrdELUmuMdoMdCYrgZZ6DFgJSI
         6716nhnhdPPQDD+yk+qWQdGPigTiAgKTFvKN3Ff6tMD6rIUl1/OWxz/EAgZF/gHUm6
         TjhWRoZye+6ww==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B49BE40080; Mon, 10 Apr 2023 22:02:25 -0300 (-03)
Date:   Mon, 10 Apr 2023 22:02:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf evsel: Avoid segv if delete is called on NULL
Message-ID: <ZDSxoUqxij2yJjXX@kernel.org>
References: <20230410205659.3131608-1-irogers@google.com>
 <CAM9d7cjuqcwcy+CwAPj8wK4hO2Pzr6xor76+jW-Do443Gr2ENQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cjuqcwcy+CwAPj8wK4hO2Pzr6xor76+jW-Do443Gr2ENQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 10, 2023 at 04:20:57PM -0700, Namhyung Kim escreveu:
> Hi Ian,
> 
> On Mon, Apr 10, 2023 at 1:57 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Seen in "perf stat --bpf-counters --for-each-cgroup test" running in a
> > container:
> >
> > libbpf: Failed to bump RLIMIT_MEMLOCK (err = -1), you might need to do it explicitly!
> > libbpf: Error in bpf_object__probe_loading():Operation not permitted(1). Couldn't load trivial BPF program. Make sure your kernel supports BPF (CONFIG_BPF_SYSCALL=y) and/or that RLIMIT_MEMLOCK is set to big enough value.
> > libbpf: failed to load object 'bperf_cgroup_bpf'
> > libbpf: failed to load BPF skeleton 'bperf_cgroup_bpf': -1
> > Failed to load cgroup skeleton
> >
> >     #0 0x55f28a650981 in list_empty tools/include/linux/list.h:189
> >     #1 0x55f28a6593b4 in evsel__exit util/evsel.c:1518
> >     #2 0x55f28a6596af in evsel__delete util/evsel.c:1544
> >     #3 0x55f28a89d166 in bperf_cgrp__destroy util/bpf_counter_cgroup.c:283
> >     #4 0x55f28a899e9a in bpf_counter__destroy util/bpf_counter.c:816
> >     #5 0x55f28a659455 in evsel__exit util/evsel.c:1520
> >     #6 0x55f28a6596af in evsel__delete util/evsel.c:1544
> >     #7 0x55f28a640d4d in evlist__purge util/evlist.c:148
> >     #8 0x55f28a640ea6 in evlist__delete util/evlist.c:169
> >     #9 0x55f28a4efbf2 in cmd_stat tools/perf/builtin-stat.c:2598
> >     #10 0x55f28a6050c2 in run_builtin tools/perf/perf.c:330
> >     #11 0x55f28a605633 in handle_internal_command tools/perf/perf.c:384
> >     #12 0x55f28a6059fb in run_argv tools/perf/perf.c:428
> >     #13 0x55f28a6061d3 in main tools/perf/perf.c:562
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo

 
> In addition to this, I think bperf code should clear the evsel->bpf_skel
> at the end of the bpf_counter__destroy() to avoid confusion with the
> bpf_filter as they share the fields in a union.
> 
> Thanks,
> Namhyung
> 
> 
> > ---
> >  tools/perf/util/evsel.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index dc3faf005c3b..fe3ce765a4f3 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -1541,6 +1541,9 @@ void evsel__exit(struct evsel *evsel)
> >
> >  void evsel__delete(struct evsel *evsel)
> >  {
> > +       if (!evsel)
> > +               return;
> > +
> >         evsel__exit(evsel);
> >         free(evsel);
> >  }
> > --
> > 2.40.0.577.gac1e443424-goog
> >

-- 

- Arnaldo
