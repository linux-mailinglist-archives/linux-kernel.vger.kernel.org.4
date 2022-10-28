Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B091611B28
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 21:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiJ1TtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 15:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiJ1TtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 15:49:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C83244C4E;
        Fri, 28 Oct 2022 12:48:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 744CFB82C99;
        Fri, 28 Oct 2022 19:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA46C433D6;
        Fri, 28 Oct 2022 19:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666986533;
        bh=+tk8StPWL2eTUFNnVPmwC3O8GjHR+1aKv511/lqFp/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ETDNT6RvUhpwoIHjfUZ4ad34i2klkvjG7jEyF6CsiJRGFFcUoyfI76dwY2bBHTbfE
         X88UjVYP3bdNRZGXEYuaCZ04r5pkVj0P+ZBT8XAlp2MHwt96tPBc8o+3gr2ZZ4hAtH
         5VLOAVO66VpkhI7YE7C28MIdFEmlrOhXhkFbh4/qLqpBJxhid90CvE31OWpF8JOWV5
         TNLEKJSix3fHOqPoL4MIhgEs+x33qzciIwBWZ/gTe4NVmd4OZM8Z0P9IAeScQ2zjcP
         8HLk2aUusCPR2Ybc9XmuC18NqEho+1NuFw3mBhweZyh1kCQ8nLv7bINlfqpdyREri5
         Bwebv0GQccX8w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 75DF74034E; Fri, 28 Oct 2022 16:48:50 -0300 (-03)
Date:   Fri, 28 Oct 2022 16:48:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/4] perf lock contention: Small random fixes
Message-ID: <Y1wyIsOqDt4iU134@kernel.org>
References: <20221028180128.3311491-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028180128.3311491-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 28, 2022 at 11:01:24AM -0700, Namhyung Kim escreveu:
> Hello,
> 
> This is a small update for the perf lock contention command.
> 
> The first issue is from msan (memory sanitizer) related to uninitialized
> memory access and use of variable length array.
> 
> The other is to increase the default stack skip count to find appropriate
> callers in most cases.
> 
> You can get it from 'perf/lock-con-fix-v1' branch in
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks, applied.

- Arnaldo

 
> Thanks,
> Namhyung
> 
> 
> Namhyung Kim (4):
>   perf lock contention: Fix memory sanitizer issue
>   perf lock contention: Check --max-stack option
>   perf lock contention: Avoid variable length arrays
>   perf lock contention: Increase default stack skip to 4
> 
>  tools/perf/builtin-lock.c             | 30 +++++++++++++++++--
>  tools/perf/util/bpf_lock_contention.c | 43 ++++++++++++++++++---------
>  tools/perf/util/lock-contention.h     |  2 +-
>  3 files changed, 57 insertions(+), 18 deletions(-)
> 
> 
> base-commit: a3a365655a28f12f07eddf4f3fd596987b175e1d
> -- 
> 2.38.1.273.g43a17bfeac-goog

-- 

- Arnaldo
