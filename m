Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1721967CD8E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjAZOUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjAZOU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:20:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C4C5B95;
        Thu, 26 Jan 2023 06:20:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4F71617FE;
        Thu, 26 Jan 2023 14:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14CF4C433EF;
        Thu, 26 Jan 2023 14:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674742812;
        bh=0gXWAG3HpQenfONyLXdhDKUli2Bo4Uhdo9PrFLTy79U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Di5FbnDS9IrLIy3Qguh0lMbFBe4bJSqS/l3RAASfKfNH1svLVK5jIH4Wjx0Qm7lcs
         p1ANYjqQnfYnxcGRR3hAFwSmbx7h+hpr8Z4tZZTDzQROrpG0qD7Vaf1OfCZ9Uvs+AG
         tdF/Segi7SvyPLuSXD0gaULEqWFYRz58MyilF5I8LCXgmljMCMVU+uTw4Baa1b6Bwl
         5GxnpltqOr4V//yI/aBZ83AFdyOWCWdjAHpgSqID/KujYWxtJTWL2Wkt69aTbBzjLW
         9TdyQMIjh6spUOVsL5qyxZ5sUEJYrdkLy4Vjaqr6j9W9qsu8+p6CBUrtcOxOt3BjVS
         +L/UXKiSp2Oiw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 71802405BE; Thu, 26 Jan 2023 11:20:09 -0300 (-03)
Date:   Thu, 26 Jan 2023 11:20:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.g.garry@oracle.com>
Cc:     Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandipan Das <sandipan.das@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linuxppc-dev@lists.ozlabs.org, Kajol Jain <kjain@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Subject: Re: [PATCH v4 11/12] perf jevents: Add model list option
Message-ID: <Y9KMGa1jGW3aLVZG@kernel.org>
References: <20230126011854.198243-1-irogers@google.com>
 <20230126011854.198243-12-irogers@google.com>
 <10ae719f-2549-a367-2d2b-48671a00135e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10ae719f-2549-a367-2d2b-48671a00135e@oracle.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 26, 2023 at 01:44:39PM +0000, John Garry escreveu:
> On 26/01/2023 01:18, Ian Rogers wrote:
> > This allows the set of generated jevents events and metrics be limited
> > to a subset of the model names. Appropriate if trying to minimize the
> > binary size where only a set of models are possible.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Thanks for this:
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>

Thanks for reviewing the series John, I see there are a few patches for
which you didn't provide your Reviewed-by, are you planning to review
those as well?

- Arnaldo
 
> > ---
> >   tools/perf/pmu-events/Build      |  3 ++-
> >   tools/perf/pmu-events/jevents.py | 14 ++++++++++++++
> >   2 files changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> > index 15b9e8fdbffa..a14de24ecb69 100644
> > --- a/tools/perf/pmu-events/Build
> > +++ b/tools/perf/pmu-events/Build
> > @@ -10,6 +10,7 @@ JEVENTS_PY	=  pmu-events/jevents.py
> >   ifeq ($(JEVENTS_ARCH),)
> >   JEVENTS_ARCH=$(SRCARCH)
> >   endif
> > +JEVENTS_MODEL ?= all
> >   #
> >   # Locate/process JSON files in pmu-events/arch/
> > @@ -23,5 +24,5 @@ $(OUTPUT)pmu-events/pmu-events.c: pmu-events/empty-pmu-events.c
> >   else
> >   $(OUTPUT)pmu-events/pmu-events.c: $(JSON) $(JSON_TEST) $(JEVENTS_PY) pmu-events/metric.py
> >   	$(call rule_mkdir)
> > -	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) pmu-events/arch $@
> > +	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) pmu-events/arch $@
> >   endif
> > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> > index 627ee817f57f..2bcd07ce609f 100755
> > --- a/tools/perf/pmu-events/jevents.py
> > +++ b/tools/perf/pmu-events/jevents.py
> > @@ -599,6 +599,8 @@ const struct pmu_events_map pmu_events_map[] = {
> >               else:
> >                 metric_tblname = 'NULL'
> >                 metric_size = '0'
> > +            if event_size == '0' and metric_size == '0':
> > +              continue
> >               cpuid = row[0].replace('\\', '\\\\')
> >               _args.output_file.write(f"""{{
> >   \t.arch = "{arch}",
> > @@ -888,12 +890,24 @@ def main() -> None:
> >             action: Callable[[Sequence[str], os.DirEntry], None]) -> None:
> >       """Replicate the directory/file walking behavior of C's file tree walk."""
> >       for item in os.scandir(path):
> > +      if _args.model != 'all' and item.is_dir():
> > +        # Check if the model matches one in _args.model.
> > +        if len(parents) == _args.model.split(',')[0].count('/'):
> > +          # We're testing the correct directory.
> > +          item_path = '/'.join(parents) + ('/' if len(parents) > 0 else '') + item.name
> > +          if 'test' not in item_path and item_path not in _args.model.split(','):
> > +            continue
> >         action(parents, item)
> >         if item.is_dir():
> >           ftw(item.path, parents + [item.name], action)
> >     ap = argparse.ArgumentParser()
> >     ap.add_argument('arch', help='Architecture name like x86')
> > +  ap.add_argument('model', help='''Select a model such as skylake to
> > +reduce the code size.  Normally set to "all". For architectures like
> > +ARM64 with an implementor/model, the model must include the implementor
> 
> mega-nit: /s/ARM64/arm64/
> 
> it just makes grepping easier (without -i, of course)
> 
> > +such as "arm/cortex-a34".''',
> > +                  default='all')
> >     ap.add_argument(
> >         'starting_dir',
> >         type=dir_path,
> 

-- 

- Arnaldo
