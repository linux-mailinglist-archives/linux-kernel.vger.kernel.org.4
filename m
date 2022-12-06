Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200A0644931
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 17:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbiLFQ2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 11:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbiLFQ2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 11:28:49 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D17C9FCF;
        Tue,  6 Dec 2022 08:28:47 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34C3723A;
        Tue,  6 Dec 2022 08:28:53 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.39.172])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C787A3F73B;
        Tue,  6 Dec 2022 08:28:43 -0800 (PST)
Date:   Tue, 6 Dec 2022 16:28:38 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Rob Herring <robh@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, James Clark <james.clark@arm.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v3 7/8] perf: Add perf_event_attr::config3
Message-ID: <Y49ttrv6W5k3ZNYw@FVFF77S0Q05N.cambridge.arm.com>
References: <20220825-arm-spe-v8-7-v3-0-87682f78caac@kernel.org>
 <20220825-arm-spe-v8-7-v3-7-87682f78caac@kernel.org>
 <20221118164943.GA4872@willie-the-truck>
 <CAL_JsqJMxEWhqZV=yqG15zvEHrBTwRVfHA6zptu2TswxRMSR0A@mail.gmail.com>
 <877czfujdj.fsf@ubik.fi.intel.com>
 <CAL_JsqKJYrEUzkzNMKMOGvzJN_EqacHZvBR6eVt35bRhhtRo=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKJYrEUzkzNMKMOGvzJN_EqacHZvBR6eVt35bRhhtRo=g@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter, it looks like this series is blocked on the below now; what would you
prefer out of:

(a) Take this as is, and look add adding additional validation on top.

(b) Add some flag to indicate a PMU driver supports config3, and have the core
    code check that, but leave the existing fields as-is for now (and hopefully
    follow up with further validation later for the existing fields).

(c) Go audit all the existing drivers, add flags to indicate support for
    existing fields, and have the core code check that. Atop that, add support
    for config3 with the same sort of flag check.

    I suspect that'd end up needing to go check more than config1/config2 given
    all the filter controls and so on that drivers aren't great at checking,
    and that might being fairly invasive.

(d) Something else?

I think we want to get to a point where drivers indicate what they actually
support and the core code rejects stuff drivers don't support or recognise, but
I think it'd be a little unreasonable to delay this series on cleaning up all
the existing issues.

I'm tempted to say (b) as that shouldn't introduce any regressions, should be a
relatively simple change to this series, and doesn't precluse making the rest
stricter as a follow-up. I'm happy to take a look at that (and IIUC Rob is
too).

What's your preference?

Thanks,
Mark.

On Mon, Nov 28, 2022 at 11:15:21AM -0600, Rob Herring wrote:
> On Mon, Nov 28, 2022 at 10:36 AM Alexander Shishkin
> <alexander.shishkin@linux.intel.com> wrote:
> >
> > Rob Herring <robh@kernel.org> writes:
> >
> > > On Fri, Nov 18, 2022 at 10:49 AM Will Deacon <will@kernel.org> wrote:
> > >>
> > >> On Fri, Nov 04, 2022 at 10:55:07AM -0500, Rob Herring wrote:
> > >> > @@ -515,6 +516,8 @@ struct perf_event_attr {
> > >> >        * truncated accordingly on 32 bit architectures.
> > >> >        */
> > >> >       __u64   sig_data;
> > >> > +
> > >> > +     __u64   config3; /* extension of config2 */
> > >>
> > >> I need an ack from the perf core maintainers before I can take this.
> > >
> > > Peter, Arnaldo, Ingo,
> > >
> > > Can I get an ack on this please.
> >
> > It appears that PMUs that don't use config{1,2} and now config3 allow
> > them to be whatever without any validation, whereas in reality we should
> > probably -EINVAL in those cases. Should something be done about that?
> 
> Always the 3rd occurrence that gets to clean-up things. ;)
> 
> I think we'd have to add some capability flags for PMU drivers to set
> to enable configN usage and then use those to validate configN is 0.
> Wouldn't be too hard to do for config3 as we know there's exactly 1
> user, but for 1,2 there's about 80 PMU drivers to check.
> 
> Rob
> 
