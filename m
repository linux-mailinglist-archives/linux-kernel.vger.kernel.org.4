Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE076730048
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245047AbjFNNmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235356AbjFNNmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:42:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B5D180;
        Wed, 14 Jun 2023 06:42:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFA0860B8B;
        Wed, 14 Jun 2023 13:42:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA6EC433C9;
        Wed, 14 Jun 2023 13:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686750160;
        bh=Nb7CPj9aCc9W/md2YbvPak2r1D+IBPGs4lsh9DGHjqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tYm9xOOmyBSZSk1WWZ2/9FZecbrunSb9YwoFSkRns5bi9Jk9X95EKx9cpXdX3nfCC
         K8+7KtxvqZWcDeRygcMXc4uqXexSvcD8PsUG5+LmJjEFlmmt/JvmmWQRnni3zAgieA
         ZiRrtyY6qg4htrRD7MHNI0O2WOwHXr/A3m9Mx1le1hHjHl7m1dbtMFuRVXfbaRVhGk
         cqBZs/fAVkTtgCTKyKs4pL93fwwLxXt/OivL6Tg2VUrPN+HxqwhUAcW8K3B2HZaWAU
         wLDzqCz0AoKdw1nA8ou7+V/+JxZVGrnYIRB+TM0aeMLcTdi8tBtaejdsRi9RtMV7Rj
         NGc7A7e4MmfOQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 87F7D40692; Wed, 14 Jun 2023 10:42:37 -0300 (-03)
Date:   Wed, 14 Jun 2023 10:42:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf tool x86: Fix perf_env memory leak
Message-ID: <ZInDzUVOyuUda7A7@kernel.org>
References: <20230613235416.1650755-1-irogers@google.com>
 <ZIkShy2yj1b0+GDv@kernel.org>
 <60477a13-1b8b-5aad-b635-73b9d8e3f734@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60477a13-1b8b-5aad-b635-73b9d8e3f734@amd.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 14, 2023 at 08:52:43AM +0530, Ravi Bangoria escreveu:
> On 14-Jun-23 6:36 AM, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Jun 13, 2023 at 04:54:16PM -0700, Ian Rogers escreveu:
> >> Found by leak sanitizer:
> >> ```
> >> ==1632594==ERROR: LeakSanitizer: detected memory leaks
> >>
> >> Direct leak of 21 byte(s) in 1 object(s) allocated from:
> >>     #0 0x7f2953a7077b in __interceptor_strdup ../../../../src/libsanitizer/asan/asan_interceptors.cpp:439
> >>     #1 0x556701d6fbbf in perf_env__read_cpuid util/env.c:369
> >>     #2 0x556701d70589 in perf_env__cpuid util/env.c:465
> >>     #3 0x55670204bba2 in x86__is_amd_cpu arch/x86/util/env.c:14
> >>     #4 0x5567020487a2 in arch__post_evsel_config arch/x86/util/evsel.c:83
> >>     #5 0x556701d8f78b in evsel__config util/evsel.c:1366
> >>     #6 0x556701ef5872 in evlist__config util/record.c:108
> >>     #7 0x556701cd6bcd in test__PERF_RECORD tests/perf-record.c:112
> >>     #8 0x556701cacd07 in run_test tests/builtin-test.c:236
> >>     #9 0x556701cacfac in test_and_print tests/builtin-test.c:265
> >>     #10 0x556701cadddb in __cmd_test tests/builtin-test.c:402
> >>     #11 0x556701caf2aa in cmd_test tests/builtin-test.c:559
> >>     #12 0x556701d3b557 in run_builtin tools/perf/perf.c:323
> >>     #13 0x556701d3bac8 in handle_internal_command tools/perf/perf.c:377
> >>     #14 0x556701d3be90 in run_argv tools/perf/perf.c:421
> >>     #15 0x556701d3c3f8 in main tools/perf/perf.c:537
> >>     #16 0x7f2952a46189 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
> >>
> >> SUMMARY: AddressSanitizer: 21 byte(s) leaked in 1 allocation(s).
> >> ```
> >>
> >> Fixes: daea405f5f06 ("perf tool x86: Consolidate is_amd check into single function")
> > 
> > Its a fix, yes, but it is not for this daea405f5f06 patch, he just moved the
> > perf_mem_is_amd_cpu(), that was leaky, to a different file, the fixes is
> > for  for:
> > 
> > f7b58cbdb3ff36eb ("perf mem/c2c: Add load store event mappings for
> > AMD").
> > 
> > Right?
> 
> Yeah that's correct "Fixes" commit. Thanks for the fix Ian!

Thanks, I'm taking that as an:

Acked-by: Ravi Bangoria <ravi.bangoria@amd.com>

Ok?

- Arnaldo
