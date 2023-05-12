Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41BD700EEA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239016AbjELSfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238987AbjELSeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:34:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DE8100EC;
        Fri, 12 May 2023 11:34:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2703865820;
        Fri, 12 May 2023 18:33:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443C9C433EF;
        Fri, 12 May 2023 18:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683916436;
        bh=uEUlpihp5tVKy7mhM2g9TmmU+1eAtfhIw9NOGqIbp94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J3eR3Ee+olvwLcueJofvlX/7QB2Lr9jXZr1hsWupwld8jyIpJ0nieVY68Otn1oKdW
         R9swGe4Mb+iGzqPKq63bfMPOfzxKG0narmon64Gk27W7a1QEUHbd05f+sa10+DdlhX
         OFCcLWy8cIYD2/jD3KmmnB87WeTh1cUWl0GD0zeJDgUEHoGOdJf2xQez3jYdDRlV1e
         yClwXnQ5Yf0zwdqWwv2TMKTPisbxe4ohjiLatJdGfuc8PFOFkES36xkl0QwoXtOLVg
         yovC1dgfO+QdhVTHV//RGG1ow3GQusD7TFra2Hh5qqdlIPEgr17lgJbJtsCN/b/Md1
         YWOklEFxyuyrA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D8D5E403B5; Fri, 12 May 2023 15:33:53 -0300 (-03)
Date:   Fri, 12 May 2023 15:33:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Ian Rogers <irogers@google.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/44] Fix perf on Intel hybrid CPUs
Message-ID: <ZF6GkU6Le8bxex2O@kernel.org>
References: <20230502223851.2234828-1-irogers@google.com>
 <b8f03c40-d238-2ce9-5b50-bd9e1465be23@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8f03c40-d238-2ce9-5b50-bd9e1465be23@linux.intel.com>
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

Em Wed, May 03, 2023 at 04:56:36PM -0400, Liang, Kan escreveu:
> 
> 
> On 2023-05-02 6:38 p.m., Ian Rogers wrote:
> > TL;DR: hybrid doesn't crash, json metrics work on hybrid on both PMUs
> > or individually, event parsing doesn't always scan all PMUs, more and
> > new tests that also run without hybrid, less code.
> > 
> > The first 4 patches are aimed at Linux 6.4 to address issues raised,
> > in particular by Kan, on the existing perf stat behavior with json
> > metrics. They avoid duplicated events by removing groups. They don't
> > hide events and metrics to make event multiplexing obvious. They avoid
> > terminating perf when paranoia is higher due to certain events that
> > always fail. They avoid rearranging events by PMUs when the events
> > aren't in a group.
> > 
> > The next 5 patches avoid grouping events for metrics where they could
> > never succeed and were previously posted as:
> > "perf vendor events intel: Add xxx metric constraints"
> > https://lore.kernel.org/all/20230419005423.343862-1-irogers@google.com/
> > In general the generated json is coming from:
> > https://github.com/intel/perfmon/pull/73
> > 
> > Next are some general and test improvements.
> > 
> > Next event parsing is rewritten to not scan all PMUs for the benefit
> > of raw and legacy cache parsing, instead these are handled by the
> > lexer and a new term type. This ultimately removes the need for the
> > event parser for hybrid to be recursive as legacy cache can be just a
> > term. Tests are re-enabled for events with hyphens, so AMD's
> > branch-brs event is now parsable.
> > 
> > The cputype option is made a generic pmu filter flag and is tested
> > even on non-hybrid systems.
> > 
> > The final patches address specific json metric issues on hybrid, in
> > both the json metrics and the metric code.
> > 
> > The patches add slightly more code than they remove, in areas like
> > better json metric constraints and tests, but in the core util code,
> > the removal of hybrid is a net reduction:
> >  22 files changed, 711 insertions(+), 1016 deletions(-)
> > 
> > Sample output is contained in the v1 patch set:
> > https://lore.kernel.org/lkml/bff481ba-e60a-763f-0aa0-3ee53302c480@linux.intel.com/
> > 
> > Tested on Tigerlake, Skylake and Alderlake CPUs.
> > 
> > The v4 patch set:
> >  - rebase, 1 of the Linux 6.4 recommended patches are merged leaving:
> >    1) perf metric: Change divide by zero and !support events behavior
> >    2) perf stat: Introduce skippable evsels
> >    3) perf metric: Json flag to not group events if gathering a metric group
> >    4) perf parse-events: Don't reorder ungrouped events by pmu
> >    whose diffstat is:
> >     30 files changed, 326 insertions(+), 33 deletions(-)
> >    but without the vendor event updates (the tend to be large as they
> >    repeat something per architecture per metric) is just:
> >     10 files changed, 90 insertions(+), 32 deletions(-)
> 
> I have tested the 4 patches on top of the perf-tools-next branch on both
> Cascade Lake and Raptor Lake. The result looks good to me.
> 
> They address the permission error found in the default mode of perf stat
> on the Cascade Lake. Thanks Ian for the fix.
> 
> Arnaldo, could you please consider to back port them for the 6.4?

Yes, its in perf-tools now, will go to Linus next week.

What about the other patches? I saw some you provided your review, what
about the others, are you ok with them?

- Arnaldo
