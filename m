Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA02F67B3A4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 14:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbjAYNob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 08:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbjAYNoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 08:44:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C7158666;
        Wed, 25 Jan 2023 05:44:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17B826144C;
        Wed, 25 Jan 2023 13:44:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AACCC433D2;
        Wed, 25 Jan 2023 13:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674654249;
        bh=S4X3970OrJcCT6E+KntVLf5UG16Jqdh4FGRjpp9Pplo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bIpSDKt//yX38vehCazUKJyL2IebOEUOMWamc00Tz82VYifiL64JTx+5faUXQx0X1
         VKQid/FcIVTiDMroNhW0M2iB3fhf00BVII28NS7A251Mv1qPXwY5MtzbtH2pNrPclt
         bsJRvNkTzNRaIq62SwuPZcYplWJdtlhluARund/eLVxykgv0d/HAxk0aYd2Sp9fR6q
         YL1iY/eLpHgt6wufQ3XO/sikM7z0E7ecljyG+GNJiZW5/tIo7fkRgGP1IDLCAPB6Jf
         jSyWCrh2WkcApDDNjDhsckO7tjLhgW7c2plC7T/LT4LlrSpqkz8N3b4bUdvem61UAF
         GxjeU1r2GhEcg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 75370405BE; Wed, 25 Jan 2023 10:44:00 -0300 (-03)
Date:   Wed, 25 Jan 2023 10:44:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Disha Goel <disgoel@linux.vnet.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf test: Fix dwarf unwind test
Message-ID: <Y9EyICeJCx+8CscR@kernel.org>
References: <20230125123442.107156-1-naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125123442.107156-1-naveen.n.rao@linux.vnet.ibm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jan 25, 2023 at 06:04:42PM +0530, Naveen N. Rao escreveu:
> Dwarf unwind perf test can sometimes fail:

Thanks, applied, next time please CC the perf tools reviewers, 

[acme@quaco perf]$ ./scripts/get_maintainer.pl tools/perf/tests/dwarf-unwind.c | grep reviewer | grep PERF
Mark Rutland <mark.rutland@arm.com> (reviewer:PERFORMANCE EVENTS SUBSYSTEM)
Alexander Shishkin <alexander.shishkin@linux.intel.com> (reviewer:PERFORMANCE EVENTS SUBSYSTEM)
Jiri Olsa <jolsa@kernel.org> (reviewer:PERFORMANCE EVENTS SUBSYSTEM)
Namhyung Kim <namhyung@kernel.org> (reviewer:PERFORMANCE EVENTS SUBSYSTEM)
Ian Rogers <irogers@google.com> (reviewer:PERFORMANCE EVENTS SUBSYSTEM)
[acme@quaco perf]$

- Arnaldo

>   $ perf test -v 74
>   Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
>    74: Test dwarf unwind                                               :
>   --- start ---
>   test child forked, pid 3785254
>   Problems creating module maps, continuing anyway...
>   Problems creating module maps, continuing anyway...
>   unwind: test__arch_unwind_sample:ip = 0x102d0ad4c (0x36ad4c)
>   unwind: access_mem addr 0x7fffc33128c8, val 1031c3228, offset 120
>   unwind: access_mem addr 0x7fffc33128d0, val 12427cc70, offset 128
>   <snip>
>   unwind: test_dwarf_unwind__krava_3:ip = 0x102b8768b (0x1e768b)
>   unwind: access_mem addr 0x7fffc3313048, val 7fffc3313050, offset 2040
>   unwind: access_mem addr 0x7fffc3313060, val 102b8777c, offset 2064
>   unwind: test_dwarf_unwind__krava_2:ip = 0x102b8770b (0x1e770b)
>   unwind: access_mem addr 0x7fffc3313088, val 7fffc3313090, offset 2104
>   unwind: access_mem addr 0x7fffc33130a0, val 102b87890, offset 2128
>   unwind: test_dwarf_unwind__krava_1:ip = 0x102b8777b (0x1e777b)
>   unwind: access_mem addr 0x7fffc3313108, val 10323a274, offset 2232
>   unwind: access_mem addr 0x7fffc3313110, val ffffffffffffffff, offset 2240
>   unwind: access_mem addr 0x7fffc3313118, val 102c08ed0, offset 2248
>   unwind: access_mem addr 0x7fffc3313120, val 1031db000, offset 2256
>   unwind: access_mem addr 0x7fffc3313128, val 7fffc3313130, offset 2264
>   unwind: access_mem addr 0x7fffc3313140, val 102b45ee8, offset 2288
>   unwind: '':ip = 0x102b8788f (0x1e788f)
>   failed: got unresolved address 0x102b8788f
>   unwind: failed with 'no error'
>   got wrong number of stack entries 0 != 8
>   test child finished with -1
>   ---- end ----
>   Test dwarf unwind: FAILED!
> 
> We expect to resolve test__dwarf_unwind as the last symbol, but that
> function can be optimized away:
>   $ objdump -tT /usr/bin/perf | grep dwarf_unwind
>   000000000083b018 g    DO .data	0000000000000040  Base        tests__dwarf_unwind
>   00000000001e7750 g    DF .text	0000000000000068  Base        0x60 test_dwarf_unwind__krava_1
>   00000000001e76e0 g    DF .text	0000000000000068  Base        0x60 test_dwarf_unwind__krava_2
>   00000000001e7620 g    DF .text	00000000000000b4  Base        0x60 test_dwarf_unwind__krava_3
>   00000000001e74f0 g    DF .text	0000000000000128  Base        0x60 test_dwarf_unwind__compare
>   00000000001e7350 g    DF .text	000000000000019c  Base        0x60 test_dwarf_unwind__thread
>   000000000083b000 g    DO .data	0000000000000018  Base        suite__dwarf_unwind
> 
> Fix this similar to commit fdf7c49c200d1b ("perf tests: Fix dwarf unwind
> for stripped binaries") by marking the function as a global and adding
> the 'noinline' attribute to it.
> 
> With this patch:
>   $ objdump -tT perf | grep dwarf_unwind
>   000000000083b018 g    DO .data	0000000000000040  Base        tests__dwarf_unwind
>   00000000001e80f0 g    DF .text	0000000000000068  Base        0x60 test_dwarf_unwind__krava_1
>   00000000001e8080 g    DF .text	0000000000000068  Base        0x60 test_dwarf_unwind__krava_2
>   00000000001e7fc0 g    DF .text	00000000000000b4  Base        0x60 test_dwarf_unwind__krava_3
>   00000000001e7e90 g    DF .text	0000000000000128  Base        0x60 test_dwarf_unwind__compare
>   00000000001e7cf0 g    DF .text	000000000000019c  Base        0x60 test_dwarf_unwind__thread
>   00000000001e8160 g    DF .text	0000000000000248  Base        0x60 test__dwarf_unwind
>   000000000083b000 g    DO .data	0000000000000018  Base        suite__dwarf_unwind
>   $ ./perf test 74
>    74: Test dwarf unwind                                               : Ok
> 
> Reported-by: Disha Goel <disgoel@linux.vnet.ibm.com>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  tools/perf/tests/dwarf-unwind.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
> index afdca7f2959f07..ee983b677a6ae0 100644
> --- a/tools/perf/tests/dwarf-unwind.c
> +++ b/tools/perf/tests/dwarf-unwind.c
> @@ -67,6 +67,7 @@ int test_dwarf_unwind__compare(void *p1, void *p2);
>  int test_dwarf_unwind__krava_3(struct thread *thread);
>  int test_dwarf_unwind__krava_2(struct thread *thread);
>  int test_dwarf_unwind__krava_1(struct thread *thread);
> +int test__dwarf_unwind(struct test_suite *test, int subtest);
>  
>  #define MAX_STACK 8
>  
> @@ -195,8 +196,8 @@ NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__krava_1(struct thread *th
>  	return ret;
>  }
>  
> -static int test__dwarf_unwind(struct test_suite *test __maybe_unused,
> -			      int subtest __maybe_unused)
> +noinline int test__dwarf_unwind(struct test_suite *test __maybe_unused,
> +				int subtest __maybe_unused)
>  {
>  	struct machine *machine;
>  	struct thread *thread;
> 
> base-commit: 5670ebf54bd26482f57a094c53bdc562c106e0a9
> -- 
> 2.39.1
> 

-- 

- Arnaldo
