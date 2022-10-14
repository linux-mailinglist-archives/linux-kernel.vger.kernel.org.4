Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579535FF44B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 22:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiJNUHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 16:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJNUHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 16:07:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3C21D3470;
        Fri, 14 Oct 2022 13:07:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E53C3B818B2;
        Fri, 14 Oct 2022 20:07:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569E2C433C1;
        Fri, 14 Oct 2022 20:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665778052;
        bh=YWmZRkT29yxHVpv3x4R49YLhg/fHwxCzqRo8/w2hFHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wj+3TmTwm3tds2TXcBr4EMBKGOSqIlgXM3gWNK9ZPRG9pnD7WGnENsVXgGRknBYYK
         moWX+o3oVhVSIjmLofVXZX+AIRXxVl8CfpJwa0nkeIbQyIECHJLT+po6j+wfZTsFZ1
         ckHQZTSM4mACujBz2dT+XrauiNCjJnNfATIeXpScNT3gAoOWPBPnqIyOu7PY8FiLil
         5wbiQ0Xo2Uqcw6s3sSInNE1dyJ2goNAVSK4h7mKMaSpkC3lNQoUCE85TyCAwtXVa+O
         emChraxcxWmyxTMg3BByzcnRhtx1JjKHC9uor8PsJYuKSH8k4kS6R0sNeJsJVxDCDE
         hLH6i90ZV+6Lw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0CA6E4062C; Fri, 14 Oct 2022 17:07:30 -0300 (-03)
Date:   Fri, 14 Oct 2022 17:07:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     James Clark <james.clark@arm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 1/1] perf test: Fix attr tests for PERF_FORMAT_LOST
Message-ID: <Y0nBgrTOipoot11y@kernel.org>
References: <20221012094633.21669-1-james.clark@arm.com>
 <20221012094633.21669-2-james.clark@arm.com>
 <CAM9d7ci-o4fzBLaLB5pcKA2=GAUVFt8PJofnuy6RjG7bibJE-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ci-o4fzBLaLB5pcKA2=GAUVFt8PJofnuy6RjG7bibJE-w@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 12, 2022 at 09:06:27AM -0700, Namhyung Kim escreveu:
> Hello,
> 
> On Wed, Oct 12, 2022 at 2:47 AM James Clark <james.clark@arm.com> wrote:
> >
> > Since PERF_FORMAT_LOST was added, the default read format has that bit
> > set, so add it to the tests. Keep the old value as well so that the test
> > still passes on older kernels.
> >
> > This fixes the following failure:
> >
> >   expected read_format=0|4, got 20
> >   FAILED './tests/attr/test-record-C0' - match failure
> >
> > Fixes: 85b425f31c88 ("perf record: Set PERF_FORMAT_LOST by default")
> > Signed-off-by: James Clark <james.clark@arm.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Namhyung
> 
> 
> > ---
> >  tools/perf/tests/attr/base-record                | 2 +-
> >  tools/perf/tests/attr/system-wide-dummy          | 2 +-
> >  tools/perf/tests/attr/test-record-group          | 4 ++--
> >  tools/perf/tests/attr/test-record-group-sampling | 6 +++---
> >  tools/perf/tests/attr/test-record-group1         | 4 ++--
> >  tools/perf/tests/attr/test-record-group2         | 4 ++--
> >  6 files changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/tools/perf/tests/attr/base-record b/tools/perf/tests/attr/base-record
> > index 8c10955eff93..3ef07a12aa14 100644
> > --- a/tools/perf/tests/attr/base-record
> > +++ b/tools/perf/tests/attr/base-record
> > @@ -9,7 +9,7 @@ size=128
> >  config=0
> >  sample_period=*
> >  sample_type=263
> > -read_format=0|4
> > +read_format=0|4|20
> >  disabled=1
> >  inherit=1
> >  pinned=0
> > diff --git a/tools/perf/tests/attr/system-wide-dummy b/tools/perf/tests/attr/system-wide-dummy
> > index 86a15dd359d9..8fec06eda5f9 100644
> > --- a/tools/perf/tests/attr/system-wide-dummy
> > +++ b/tools/perf/tests/attr/system-wide-dummy
> > @@ -11,7 +11,7 @@ size=128
> >  config=9
> >  sample_period=4000
> >  sample_type=455
> > -read_format=4
> > +read_format=4|20
> >  # Event will be enabled right away.
> >  disabled=0
> >  inherit=1
> > diff --git a/tools/perf/tests/attr/test-record-group b/tools/perf/tests/attr/test-record-group
> > index 14ee60fd3f41..6c1cff8aae8b 100644
> > --- a/tools/perf/tests/attr/test-record-group
> > +++ b/tools/perf/tests/attr/test-record-group
> > @@ -7,14 +7,14 @@ ret     = 1
> >  fd=1
> >  group_fd=-1
> >  sample_type=327
> > -read_format=4
> > +read_format=4|20
> >
> >  [event-2:base-record]
> >  fd=2
> >  group_fd=1
> >  config=1
> >  sample_type=327
> > -read_format=4
> > +read_format=4|20
> >  mmap=0
> >  comm=0
> >  task=0
> > diff --git a/tools/perf/tests/attr/test-record-group-sampling b/tools/perf/tests/attr/test-record-group-sampling
> > index 300b9f7e6d69..97e7e64a38f0 100644
> > --- a/tools/perf/tests/attr/test-record-group-sampling
> > +++ b/tools/perf/tests/attr/test-record-group-sampling
> > @@ -7,7 +7,7 @@ ret     = 1
> >  fd=1
> >  group_fd=-1
> >  sample_type=343
> > -read_format=12
> > +read_format=12|28
> >  inherit=0
> >
> >  [event-2:base-record]
> > @@ -21,8 +21,8 @@ config=3
> >  # default | PERF_SAMPLE_READ
> >  sample_type=343
> >
> > -# PERF_FORMAT_ID | PERF_FORMAT_GROUP
> > -read_format=12
> > +# PERF_FORMAT_ID | PERF_FORMAT_GROUP  | PERF_FORMAT_LOST
> > +read_format=12|28
> >  task=0
> >  mmap=0
> >  comm=0
> > diff --git a/tools/perf/tests/attr/test-record-group1 b/tools/perf/tests/attr/test-record-group1
> > index 3ffe246e0228..eeb1db392bc9 100644
> > --- a/tools/perf/tests/attr/test-record-group1
> > +++ b/tools/perf/tests/attr/test-record-group1
> > @@ -7,7 +7,7 @@ ret     = 1
> >  fd=1
> >  group_fd=-1
> >  sample_type=327
> > -read_format=4
> > +read_format=4|20
> >
> >  [event-2:base-record]
> >  fd=2
> > @@ -15,7 +15,7 @@ group_fd=1
> >  type=0
> >  config=1
> >  sample_type=327
> > -read_format=4
> > +read_format=4|20
> >  mmap=0
> >  comm=0
> >  task=0
> > diff --git a/tools/perf/tests/attr/test-record-group2 b/tools/perf/tests/attr/test-record-group2
> > index 6b9f8d182ce1..cebdaa8e64e4 100644
> > --- a/tools/perf/tests/attr/test-record-group2
> > +++ b/tools/perf/tests/attr/test-record-group2
> > @@ -9,7 +9,7 @@ group_fd=-1
> >  config=0|1
> >  sample_period=1234000
> >  sample_type=87
> > -read_format=12
> > +read_format=12|28
> >  inherit=0
> >  freq=0
> >
> > @@ -19,7 +19,7 @@ group_fd=1
> >  config=0|1
> >  sample_period=6789000
> >  sample_type=87
> > -read_format=12
> > +read_format=12|28
> >  disabled=0
> >  inherit=0
> >  mmap=0
> > --
> > 2.28.0
> >

-- 

- Arnaldo
