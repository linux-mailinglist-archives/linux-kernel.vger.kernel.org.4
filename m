Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD536A8A8C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 21:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjCBUkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 15:40:40 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50776 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjCBUki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 15:40:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66EF5B815B1;
        Thu,  2 Mar 2023 20:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC74C433D2;
        Thu,  2 Mar 2023 20:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677789620;
        bh=LQ8d2L9Uk3goGZZQFeBVqXpx52R2xE0oIeEApdEUNxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=acdCQbIzy6A6YKiXbhtg5CuwyLWMjWCXWXbiwDXAXZlIvc+VfysL1eE1OUsdPSTIR
         ODOfAdsKfMOTW7XE+P8Vgh0BOC3n3erxU6OpD+UNRs5V6azsbHfdX8S1pu7SMLyQmy
         y/h7tjumpfPd41hxnIfMfyhvDkXgEMdUvxIw0bq+l/cRTpHY231pam/SrXRNI9W3TW
         444p7uI0XlBVsYdp7/b2Xk835Y6o4dzWAPTkQ+POb3ptsM2SPWtbmsMSJkR1OsGveS
         JXBpdxMQxLYspBEmRlOIsbf6ou5/DlnUuArlMuffta6Fo/OeY9NTLOkM7JRVE6AHQu
         B9dVIRbjZYmCA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F419E4049F; Thu,  2 Mar 2023 17:40:16 -0300 (-03)
Date:   Thu, 2 Mar 2023 17:40:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Changbin Du <changbin.du@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hui Wang <hw.huiwang@huawei.com>
Subject: Re: [PATCH v2 0/3] perf : fix counting when initial delay configured
Message-ID: <ZAEJsMYGo1HC5CRk@kernel.org>
References: <20230302031146.2801588-1-changbin.du@huawei.com>
 <CAM9d7cigZ=TRoH8-MNbovUETzsjf+OuX7ykXA9rSyhsOY48dRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cigZ=TRoH8-MNbovUETzsjf+OuX7ykXA9rSyhsOY48dRg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 02, 2023 at 11:22:37AM -0800, Namhyung Kim escreveu:
> Hello,
> 
> On Wed, Mar 1, 2023 at 7:12 PM Changbin Du <changbin.du@huawei.com> wrote:
> >
> > The first one fixes the problem that counters are never enabled  when initial
> > delay configured.
> > The remaining two reuse the common field target::initial_delay for
> > record/ftrace/trace subcommands.
> >
> > v2:
> >  - introduce common filed target::initial_delay
> >
> > Changbin Du (3):
> >   perf stat: fix counting when initial delay configured
> >   perf record: reuse target::initial_delay
> >   perf: ftrace: reuse target::initial_delay
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applying the first to perf-tools (old perf/urgent) and the rest
to perf-tools-next (old perf/core).

- Arnaldo
 
> Thanks,
> Namhyung
> 
> >
> >  tools/perf/builtin-ftrace.c | 10 +++++-----
> >  tools/perf/builtin-record.c | 12 ++++++------
> >  tools/perf/builtin-stat.c   | 15 +++++----------
> >  tools/perf/builtin-trace.c  |  8 ++++----
> >  tools/perf/util/evlist.c    |  6 +++---
> >  tools/perf/util/evsel.c     |  2 +-
> >  tools/perf/util/ftrace.h    |  1 -
> >  tools/perf/util/record.h    |  1 -
> >  tools/perf/util/stat.c      |  6 +-----
> >  tools/perf/util/stat.h      |  1 -
> >  tools/perf/util/target.h    | 12 ++++++++++++
> >  11 files changed, 37 insertions(+), 37 deletions(-)
> >
> > --
> > 2.25.1
> >

-- 

- Arnaldo
