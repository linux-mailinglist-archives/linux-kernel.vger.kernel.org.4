Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAA1733BA1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 23:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjFPVqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 17:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjFPVq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 17:46:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A8F30F7;
        Fri, 16 Jun 2023 14:46:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB5FC6170D;
        Fri, 16 Jun 2023 21:46:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08445C433C8;
        Fri, 16 Jun 2023 21:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686951986;
        bh=8nS29JYBi41s0ToV/0PJ3m2jNI34TvMWq3ncjUsYJFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UiZHuqb74A4KH7S/TqILosH546SKIh4GCoCfo8ScpR/2OQ9Oq3ryk6A3g0z0Hwp4U
         P83baFZPFsgTUnxIwBKmNddprlQGY1BbQQglBIJHCK7+LDrX5e0qi37N2EVUJe1u6G
         66USXDlabr2BkFRkay5jo4/ZDQdoyS7X2xf0Dflhnt4ybhOlNtGd/7eOpulA55D7vF
         IhRBbwAGr3L3Q0LsPVq77PwlcKKwwZF/yUbgP7vKTEPYmT3YVLh2nKwlLXgOjxvzmH
         ytGfWiZBItF4zMje5wlXtZMJ+SlVUTRAoOtO74yrJ/BS2/HSgkSyqa4V/mxWZz2h3V
         hgg+UuljknnFA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A7FC240692; Fri, 16 Jun 2023 18:46:23 -0300 (-03)
Date:   Fri, 16 Jun 2023 18:46:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        sumanthk@linux.ibm.com, hca@linux.ibm.com, svens@linux.ibm.com,
        gor@linux.ibm.com
Subject: Re: [PATCH] perf test: fix failing test cases on linux-next for s390
Message-ID: <ZIzYL2TXf4OqwLaP@kernel.org>
References: <20230616081437.1932003-1-tmricht@linux.ibm.com>
 <ZIxf7A1jPiDUUdDt@kernel.org>
 <CAP-5=fXZFgVFMALts+r03c=Xjnv1_iKAx=jqcmRSDU4sDzxSWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXZFgVFMALts+r03c=Xjnv1_iKAx=jqcmRSDU4sDzxSWg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 16, 2023 at 01:48:45PM -0700, Ian Rogers escreveu:
> On Fri, Jun 16, 2023 at 6:13 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Fri, Jun 16, 2023 at 10:14:37AM +0200, Thomas Richter escreveu:
> > > In linux-next tree the many test cases fail on s390x when running the
> > > perf test suite, sometime the perf tool dumps core.
> > >
> > > Output before:
> > >   6.1: Test event parsing                               : FAILED!
> > >  10.3: Parsing of PMU event table metrics               : FAILED!
> > >  10.4: Parsing of PMU event table metrics with fake PMUs: FAILED!
> > >  17: Setup struct perf_event_attr                       : FAILED!
> > >  24: Number of exit events of a simple workload         : FAILED!
> > >  26: Object code reading                                : FAILED!
> > >  28: Use a dummy software event to keep tracking        : FAILED!
> > >  35: Track with sched_switch                            : FAILED!
> > >  42.3: BPF prologue generation                          : FAILED!
> > >  66: Parse and process metrics                          : FAILED!
> > >  68: Event expansion for cgroups                        : FAILED!
> > >  69.2: Perf time to TSC                                 : FAILED!
> > >  74: build id cache operations                          : FAILED!
> > >  86: Zstd perf.data compression/decompression           : FAILED!
> > >  87: perf record tests                                  : FAILED!
> > > 106: Test java symbol                                   : FAILED!
> > >
> > > The reason for all these failure is a missing PMU. On s390x
> > > the PMU is named cpum_cf which is not detected as core PMU.
> > > A similar patch was added before, see
> > > commit 9bacbced0e32 ("perf list: Add s390 support for detailed PMU event description")
> > > which got lost during the recent reworks. Add it again.
> > >
> > > Output after:
> > >  10.2: PMU event map aliases                            : FAILED!
> > >  42.3: BPF prologue generation                          : FAILED!
> > >
> > > Most test cases now work and there is not core dump anymore.
> >
> > So you're not fixing 'perf test', that is just what detects the problem,
> > the part being fixed is the PMU code, so I'm rewriting the patch subject
> > to:
> >
> > [PATCH] perf pmu: Fix core PMU detection on s/390
> >
> > Have you bisected the problem to the first patch where this problem
> > appears?
> 
> I suspect:
> https://lore.kernel.org/all/20230527072210.2900565-30-irogers@google.com/
> 9d6a1df9b2ee ("perf pmus: Allow just core PMU scanning")
> 
> Acked-by: Ian Rogers <irogers@google.com>

I already pushed to perf-tools-next, but this acked/fixes is reachable
via the Link tag.

Thanks for checking and acking!

- Arnaldo
 
> Thanks,
> Ian
> 
> > - Arnaldo
> >
> > > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > > Cc: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/pmu.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > > index fe64ad292d36..6142e4710a2f 100644
> > > --- a/tools/perf/util/pmu.c
> > > +++ b/tools/perf/util/pmu.c
> > > @@ -1419,7 +1419,7 @@ void perf_pmu__del_formats(struct list_head *formats)
> > >
> > >  bool is_pmu_core(const char *name)
> > >  {
> > > -     return !strcmp(name, "cpu") || is_sysfs_pmu_core(name);
> > > +     return !strcmp(name, "cpu") || !strcmp(name, "cpum_cf") || is_sysfs_pmu_core(name);
> > >  }
> > >
> > >  bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu)
> > > --
> > > 2.39.2
> > >
> >
> > --
> >
> > - Arnaldo

-- 

- Arnaldo
