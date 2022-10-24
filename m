Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4E560BDF1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiJXWy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiJXWye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:54:34 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC39321FE6;
        Mon, 24 Oct 2022 14:16:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6B8F3CE132B;
        Mon, 24 Oct 2022 11:39:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F69C433B5;
        Mon, 24 Oct 2022 11:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666611593;
        bh=fCEDp+PSEpDcC1ByB+UoAAPsz26Ay97tQb1BDgCAMcw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QSrakSOHsS3P5RL6IVRNLl5dfP43mYfX5r5hqT2sjPb1KXq9PkhUgrQVjF4/g82ZQ
         mfxoyjfTbGOYo/3mWl0Q+flNELb7tHYPdD2m5FOsxMWHG24jsJTvfRZhRrDBSRDsD3
         PeMIIbEgLURz4ntcCQYZuVkJPaQZhGHQm3wIT9FmEuEJRINx5oBrm9hwvl4KOME4Zq
         8GS75NZ0KRDOqjMuyCmN1vutpmVilT2xGBJD2mTpBDH4qn9coOOGAv0OQcNLTGiGbU
         ed0fRsuDR8fJMfBcJeqLt/UDgZayIC67sZiQS+zlJFXqUHXnnPW9XY3DtJ4lYUmLk/
         5IvECQW6HEkJA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D915F404BE; Mon, 24 Oct 2022 08:39:51 -0300 (-03)
Date:   Mon, 24 Oct 2022 08:39:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Ammy Yi <ammy.yi@intel.com>
Subject: Re: [PATCH v2] perf test: Do not fail Intel-PT misc test w/o
 libpython
Message-ID: <Y1Z5h/Sy6s8AFp1P@kernel.org>
References: <20221021181055.60183-1-namhyung@kernel.org>
 <CAP-5=fWaqhZu0sUTgBogpeOxF1gf=V0CZjQ=2NDJEbVB-Cvjew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWaqhZu0sUTgBogpeOxF1gf=V0CZjQ=2NDJEbVB-Cvjew@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 21, 2022 at 03:00:04PM -0700, Ian Rogers escreveu:
> On Fri, Oct 21, 2022 at 11:11 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The virtuall LBR test uses a python script to check the max size of
> 
> nit: virtual

Thanks, fixed and applied.

- Arnaldo
 
> > branch stack in the Intel-PT generated LBR.  But it didn't check whether
> > python scripting is available (as it's optional).
> >
> > Let's skip the test if the python support is not available.
> >
> > Fixes: f77811a0f625 ("perf test: test_intel_pt.sh: Add 9 tests")
> > Cc: Ammy Yi <ammy.yi@intel.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Acked-by: Ian Rogers <irogers@google.com>
> 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/tests/shell/test_intel_pt.sh | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
> > index 4c0aabbe33bd..f5ed7b1af419 100755
> > --- a/tools/perf/tests/shell/test_intel_pt.sh
> > +++ b/tools/perf/tests/shell/test_intel_pt.sh
> > @@ -526,6 +526,12 @@ test_kernel_trace()
> >  test_virtual_lbr()
> >  {
> >         echo "--- Test virtual LBR ---"
> > +       # Check if python script is supported
> > +       libpython=$(perf version --build-options | grep python | grep -cv OFF)
> > +       if [ "${libpython}" != "1" ] ; then
> > +               echo "SKIP: python scripting is not supported"
> > +               return 2
> > +       fi
> >
> >         # Python script to determine the maximum size of branch stacks
> >         cat << "_end_of_file_" > "${maxbrstack}"
> > --
> > 2.38.0.135.g90850a2211-goog
> >

-- 

- Arnaldo
