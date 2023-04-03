Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1C06D5274
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 22:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjDCU0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 16:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjDCUZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 16:25:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE9840CA;
        Mon,  3 Apr 2023 13:25:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E14E4629D4;
        Mon,  3 Apr 2023 20:24:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26506C433D2;
        Mon,  3 Apr 2023 20:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680553473;
        bh=91QBxRuG+rj/36B4hBwkQ8h+oBWnHyLVhu12FWCCONI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W8kTGH71sFwl+OsC3I+KiR8KOyeDixAklpjrmMugAQY+ZBJgijHwKWMUIYtgr0u+P
         BNg00hOMiVhMwTmR69saevYaagHb53+pNAjIb9ODIUlXUMi9M3STHcppcMb1g5Lw1k
         oASkMWJTeiEh5rsXT47CoNhdAEPznp/LpPR2kMjpFxn1zKckghXiXyP3IxGLt0pi9E
         GnhhL8QqsG/B8eVBLfU3x5JvLADMEUezqw5G7wi408LLXA+xfKPkYI6RysPeRexFit
         hhNCnHVK25coCZlojbza13BYO9FvF8RyD7LYeMi4xv23AGf2R0WMQBtm1UlPRMmyNy
         56AWn0taghhkQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A4CA34052D; Mon,  3 Apr 2023 17:24:30 -0300 (-03)
Date:   Mon, 3 Apr 2023 17:24:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2 0/4] Support for llvm-addr2line
Message-ID: <ZCs1/skb2XqDYrYF@kernel.org>
References: <20230403184033.1836023-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403184033.1836023-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 03, 2023 at 11:40:29AM -0700, Ian Rogers escreveu:
> The addr2line command is started and then addresses piped to it. In
> order to determine the end of a addr2lines output a ',' it output with
> an expectation to get '??\n??:0\n' as a reply. llvm-addr2line differs
> in that ',' generates a reply of ','.
> 
> The approach detects and then caches the addr2line style. When records
> are read the sentinel is detected appropriately.
> 
> Comparing the output there is a little more inline data on my machine
> with llvm-addr2line:
> $ sudo perf record -a -g sleep 1
> $ sudo perf report --addr2line=addr2line > a.txt
> $ sudo perf report --addr2line=llvm-addr2line > b.txt
> $ wc -l a.txt b.txt
>   12386 a.txt
>   12477 b.txt
> 
> Some other small changes, switching to the api/io code to avoid file
> streams wrapping the command's stdin/stdout. Ignore SIGPIPE for when
> addr2line exits and writes fail.
> 
> v2. Address review comments from Arnaldo and Namhyung, fixing a
>     realloc error path, argument ordering and a comment.

Added to local repo, build testing, will be in tmp.perf-tools-next soon.

- Arnaldo
 
> Ian Rogers (4):
>   tools api: Add io__getline
>   perf srcline: Simplify addr2line subprocess
>   perf srcline: Support for llvm-addr2line
>   perf srcline: Avoid addr2line SIGPIPEs
> 
>  tools/lib/api/io.h        |  45 ++++++++++
>  tools/perf/tests/api-io.c |  36 ++++++++
>  tools/perf/util/srcline.c | 171 +++++++++++++++++++++++---------------
>  3 files changed, 184 insertions(+), 68 deletions(-)
> 
> -- 
> 2.40.0.348.gf938b09366-goog
> 

-- 

- Arnaldo
