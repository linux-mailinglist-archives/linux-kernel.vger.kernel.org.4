Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911CA611B1A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 21:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiJ1Tp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 15:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJ1Tpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 15:45:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE3113F6D;
        Fri, 28 Oct 2022 12:45:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8B30B82C9C;
        Fri, 28 Oct 2022 19:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5877C433C1;
        Fri, 28 Oct 2022 19:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666986345;
        bh=8jVvfqwooB2XxehexdbsReWOhqoAsAkOoqcVmubSgWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JX0VqiHEt315CgVzGyMEXQBsgq8WJh9HtWHSCVgHGneb4InPT315/0LP4P2BN/eDe
         K7tqjiP7QLWU+etqmRXrU5LI8XJoPGMAVKzuzJADWSju1uFHh71y3P1kQ3r9eZvvet
         4FU+Kt72ImaGq2Uf9FFWuQAaTsf5mlLbP3mAnZlutDCfw3YWLdfCewQHblPBpDB1Sq
         mhEAJeWxtkAbD+qfDjqKGO28Z5wiHDPFU1tkBWxz+WNQ+y0cvPCwQTLlg/r9g7yFdD
         zZ9lDrzypYCNBxEoBXMEKyNicBTTzyRHQTA7/ZYkCGGXT9fwroYn3251j+oT3013ij
         O7wC9njA5Y/CA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1D6384034E; Fri, 28 Oct 2022 16:45:42 -0300 (-03)
Date:   Fri, 28 Oct 2022 16:45:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     John Garry <john.garry@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1] perf test: Parse events workaround for dash/minus
Message-ID: <Y1wxZgWWPwuRZ+xj@kernel.org>
References: <20221013011205.3151391-1-irogers@google.com>
 <715c8e4a-f3c3-6521-778e-8ba8c2bf659e@huawei.com>
 <CAP-5=fVBSDPPFnBnLF775noQPyHnjbpu+hC=LiEJo5566oONrA@mail.gmail.com>
 <CAP-5=fVmd-f=HAQPJ-UfG5EdnXMk5j6a-PdF5592LDrd8K8neA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVmd-f=HAQPJ-UfG5EdnXMk5j6a-PdF5592LDrd8K8neA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 28, 2022 at 10:55:14AM -0700, Ian Rogers escreveu:
> On Mon, Oct 17, 2022 at 4:07 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Thu, Oct 13, 2022 at 5:11 AM John Garry <john.garry@huawei.com> wrote:
> > >
> > > On 13/10/2022 02:12, Ian Rogers wrote:
> > > > Skip an event configuration for event names with a dash/minus in them.
> > > > Events with a dash/minus in their name cause parsing issues as legacy
> > > > encoding of events would use a dash/minus as a separator. The parser
> > > > separates events with dashes into prefixes and suffixes and then
> > > > recombines them. Unfortunately if an event has part of its name that
> > > > matches a legacy token then the recombining fails. This is seen for
> > > > branch-brs where branch is a legacy token. branch-brs was introduced
> > > > to sysfs in:
> > > > https://lore.kernel.org/all/20220322221517.2510440-5-eranian@google.com/
> > > > The failure is shown below as well as the workaround to use a config
> > > > where the dash/minus isn't treated specially:
> > > >
> > > > ```
> > > > $ perf stat -e branch-brs true
> > > > event syntax error: 'branch-brs'
> > > >                             \___ parser error
> > > >
> > > > $ perf stat -e cpu/branch-brs/ true
> > > >
> > > >   Performance counter stats for 'true':
> > > >
> > > >              46,179      cpu/branch-brs/
> > > > ```
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >   tools/perf/tests/parse-events.c | 13 +++++++++++++
> > > >   1 file changed, 13 insertions(+)
> > > >
> > > > diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> > > > index 459afdb256a1..3440dd2616b0 100644
> > > > --- a/tools/perf/tests/parse-events.c
> > > > +++ b/tools/perf/tests/parse-events.c
> > > > @@ -2237,6 +2237,19 @@ static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest
> > > >                       pr_debug("Test PMU event failed for '%s'", name);
> > > >                       ret = combine_test_results(ret, test_ret);
> > > >
> > >
> > > Hi Ian,
> > >
> > > }
> > > > +             /*
> > > > +              * Names containing '-' are recognized as prefixes and suffixes
> > > > +              * due to '-' being a legacy PMU separator. This fails when the
> > > > +              * prefix or suffix collides with an existing legacy token. For
> > > > +              * example, branch-brs has a prefix (branch) that collides with
> > > > +              * a PE_NAME_CACHE_TYPE token causing a parse error as a suffix
> > > > +              * isn't expected after this.
> > >
> > > OK, so you want to skip anything with '-'. Will we now miss out on
> > > events which contain a '-' but don't clash with an existing legacy token?
> >
> > Yes. The long term solution here is to ditch the current parse event
> > code and its legacy support. An idea is to create a simplified parser
> > as part of libperf2 (libperf but with a libbpf style license), use the
> > new parser for metrics and events. In the events case, if the new
> > parser fails then use the legacy parser and its weird handling of
> > dashes.
> >
> > > >  As event names in the config
> > > > +              * slashes are allowed a '-' in the name we check this works
> > > > +              * above.
> > >
> > > Sorry, I can't follow what you mean here. Do you mean that
> > > "cpu/branch-brs/" works ok and we continue to test it?
> >
> > Yep, as shown in the commit message. The comment isn't great, it
> > should be worded something like:
> >
> > If an event name is in the config slashes, such as cpu/branch-brs/,  a
> > '-' in the name works as the dash doesn't separate the parts of the
> > name. This continues to be tested above.
> 
> Ping. It'd be nice to merge this as otherwise we have a perf test
> failure on AMD.

I added it for perf/core, i.e. 6.2.

Thanks,

- Arnaldo
