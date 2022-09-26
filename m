Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12705EB1B8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 21:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiIZT4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 15:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiIZT4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 15:56:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444226F266;
        Mon, 26 Sep 2022 12:56:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B94E561155;
        Mon, 26 Sep 2022 19:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05777C433D6;
        Mon, 26 Sep 2022 19:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664222199;
        bh=cVsd6K5MNCDnfJEvYpDydiEXtgAumOf06eArAUYgvmk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pRmVat7JHOHqdX6cyq9py1+0JwpNtxb6XCfA1cZE/mVKxyVmufTvV0ih6Yh/GFdLs
         GgTm3MNonvH4BhdJ2KquZ/uOol199FOR4llDTxHMIbS6ALzHGgKmPm6esoK9uTxvx1
         CvsyAIhzWN9uKcM09UnATa4aVihRNGatwV9QGtPc/ImTSwvTG/1z0g1KQPNsakBc88
         pqMKdWvpZ0Rn9B9nU2uIRzPd/Oxsfvf5jh01fKlA90yhHPnBD1M7eN11smBKuAhPuo
         O3jxjMWrfUcBKzenPsCGPI0YGJETElGxaCXUt6hUugODcQa262jhL4YlHet+aVECto
         Svaj1s/+1A0BA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 72780403B0; Mon, 26 Sep 2022 20:56:36 +0100 (IST)
Date:   Mon, 26 Sep 2022 20:56:36 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 0/2] perf test: Add test for java symbol
Message-ID: <YzID9Hrt5BOKiX1T@kernel.org>
References: <20220925025835.70364-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220925025835.70364-1-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Sep 25, 2022 at 10:58:33AM +0800, Leo Yan escreveu:
> This patch set is to add a test for java symbol.
> 
> To allow a shell script to know the installed lib path, we need to
> export the environment variable "PREFIX" in the C code.  We use the
> first patch for this purpose.  The second patch introduces the java
> symbol testing.
> 
> The test has been verified on x86_64 machine with perf/core branch with
> the latest commit 62e64c9d2fd1 ("perf test: Add basic core_wide
> expression test").


Thanks, applied locally.

- Arnaldo


> Changes from v2:
> - Skipped test if jshell is not existed (Namhyung);
> - Fixed a typo for s/if/elif/ (Namhyung).
> 
> Changes from v1:
> - Added Ian's suggested tag;
> - Added the search folder for the system lib libperf-jvmti.so;
> - Skip the test if fail to find jvmti lib.
> 
> 
> Leo Yan (2):
>   perf subcmd: Set environment variable "PREFIX"
>   perf test: Introduce script for java symbol testing
> 
>  tools/lib/subcmd/exec-cmd.c                |  3 +
>  tools/perf/tests/shell/test_java_symbol.sh | 75 ++++++++++++++++++++++
>  2 files changed, 78 insertions(+)
>  create mode 100755 tools/perf/tests/shell/test_java_symbol.sh
> 
> -- 
> 2.34.1

-- 

- Arnaldo
