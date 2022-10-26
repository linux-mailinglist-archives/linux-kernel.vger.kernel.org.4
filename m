Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1A360E2F9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 16:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbiJZOPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 10:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbiJZOPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 10:15:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC93A98CA;
        Wed, 26 Oct 2022 07:15:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E371B822B5;
        Wed, 26 Oct 2022 14:15:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC99C433D6;
        Wed, 26 Oct 2022 14:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666793705;
        bh=bPQpw1YW/RYUx9xDPaehp0siCZJYUrJDtAPLbnqzJH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UM1u4sHYdC8RQ3vbFlDUC4dawHYQ80NJ+/V7tWEpOMUebBWE3EowzgqMIbp3PFDeM
         biB32xiew3R0v5rgoxZxe3n+K+EyTQE5BUvXCWeM+t42vXKsQL7o1QJR2dY1xpwraF
         pLJ5wsvWxozMVui+pdVPrcKO8OqsH3JPLP1aQPRj6FL4MALpFA2snMbfaKkUi/8jBN
         M4ElAKdItOeA8r5f8ac2mycNbhmwcf+A1FCHT+/fWOcZwD6blSA7hWYYfJFMikWR/0
         YquwGO/WiViCXdA0umI602mqRxyE7lyxIXDUjKG/48MRU7kDtkBvGgoRuE0zYuFk96
         AzcPEdcrL6pUg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6FCD6404BE; Wed, 26 Oct 2022 11:15:03 -0300 (-03)
Date:   Wed, 26 Oct 2022 11:15:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCHSET 0/8] perf test: Improve perf record tests (v2)
Message-ID: <Y1lA57moAxMCiJzG@kernel.org>
References: <20221020172643.3458767-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020172643.3458767-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 20, 2022 at 10:26:35AM -0700, Namhyung Kim escreveu:
> Hello,
> 
> This patchset improves the perf record tests to check more cases so that it
> can find problems early.  The motivation was a failure per-thread mmap with
> multi-threaded targets which Adrian is working on the fix.
> 
> Changes in v2)
>  * fix shellcheck issues
>  * drop unsupported --per-thread and --threads combination
>  * do not use initial delay (-D option); instead it runs the target
>    and wait for it separately using the recent waiting.sh library
>  * add Adrian's Reviewed-by tags
> 
> I added a custom test program and more combinations like system-wide and
> command line workload (in per-process mode) testing with multi-threaded
> recording mode.

Thanks, applied to perf/core.

- Arnaldo

 
> Currently it succeeds every tests when running as root!
> 
>   $ sudo ./perf test -v 91
>    91: perf record tests                                               :
>   --- start ---
>   test child forked, pid 108975
>   Build a test program
>   Basic --per-thread mode test
>   Basic --per-thread mode test [Success]
>   Register capture test
>   Register capture test [Success]
>   Basic --system-wide mode test
>   Basic --system-wide mode test [Success]
>   Basic target workload test
>   Basic target workload test [Success]
>   test child finished with 0
>   ---- end ----
>   perf record tests: Ok
> 
> You can find it in 'perf/record-test-v2' branch in
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> 
> Thanks,
> Namhyung
> 
> 
> Namhyung Kim (8):
>   perf test: Do not use instructions:u explicitly
>   perf test: Fix shellcheck issues in the record test
>   perf test: Use a test program in perf record tests
>   perf test: Wait for a new thread when testing --per-thread record
>   perf test: Add system-wide mode in perf record tests
>   perf test: Add target workload test in perf record tests
>   perf test: Test record with --threads option
>   perf test: Do not set TEST_SKIP for record subtests
> 
>  tools/perf/tests/shell/record.sh | 180 +++++++++++++++++++++++++++----
>  1 file changed, 158 insertions(+), 22 deletions(-)
> 
> 
> base-commit: a3a365655a28f12f07eddf4f3fd596987b175e1d
> -- 
> 2.38.0.135.g90850a2211-goog

-- 

- Arnaldo
