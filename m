Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201616CDA90
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjC2NUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjC2NU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:20:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1935598;
        Wed, 29 Mar 2023 06:20:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CE7861D1E;
        Wed, 29 Mar 2023 13:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C577C433D2;
        Wed, 29 Mar 2023 13:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680096018;
        bh=Vp7Tk9FZto6rCmf812cmUkq4T6NxSn9CdcRG6uBna6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IPx1XTCJhoNO96hDi+jLdysiRWDplquD4sU4MIQ8fKqJiKaYpNwXU2HwTFzzubRW+
         ZrrFDHqCBLPAem8lJd7TNN3wbHYNJsbrRHw3tE4/C4lbXLaWKjYlvN+uIsa46jEG4Y
         Pw7wEr4MJE7sXLiN0SBA1A86QzWC1JHBtSOa93ZHY7lva2afGbwDMTWgmUWsyROQrx
         9+d299HDPbTpo+JQRpr6J97CPXN4bIuzYOS8kxdv9NaTxTtaRNyLDJZ8yBPLzdI+Xh
         ih86RP5992Z5ewvhn1eotK+nwJM0YJbcYdaqPLzkWwv37IEHzIx4ZKi0WyLoXVo/oX
         UZt8EdHH4oslg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5F5A84052D; Wed, 29 Mar 2023 10:20:16 -0300 (-03)
Date:   Wed, 29 Mar 2023 10:20:16 -0300
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
        Tom Rix <trix@redhat.com>, James Clark <james.clark@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Andres Freund <andres@anarazel.de>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v1 0/6] config file/command line for objdump & addr2line
Message-ID: <ZCQ7EG1+/emX0ZZW@kernel.org>
References: <20230328235543.1082207-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230328235543.1082207-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 28, 2023 at 04:55:37PM -0700, Ian Rogers escreveu:
> Allow objdump to be set as a perf config file variable. As previously
> objdump was set via the command line, the string was owned by
> argv. Now the string must be strdup-ed, so the corresponding logic
> needs changing with an annotation_options__init/exit.

ui/gtk/annotate.c: In function ‘symbol__gtk_annotate’:
ui/gtk/annotate.c:177:44: error: ‘annotation__default_options’ undeclared (first use in this function); did you mean ‘annotation_options’?
  177 |         err = symbol__annotate(ms, evsel, &annotation__default_options, NULL);
      |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                                            annotation_options
ui/gtk/annotate.c:177:44: note: each undeclared identifier is reported only once for each function it appears in
make[6]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:97: ui/gtk/annotate.o] Error 1
make[6]: *** Waiting for unfinished jobs....


I'll fix this later...

- Arnaldo
 
> Add command line and config file options for addr2line, set in
> symbol_conf for convenience. This doesn't allow the setting of
> llvm-addr2line due to a bug, but could in the future.
> 
> Ian Rogers (6):
>   perf annotate: Delete session for debug builds
>   perf report: Additional config warnings
>   perf annotate: Add init/exit to annotation_options remove default
>   perf annotate: Own objdump_path and disassembler_style strings
>   perf annotate: Allow objdump to be set in perfconfig
>   perf symbol: Add command line support for addr2line path
> 
>  tools/perf/Documentation/perf-annotate.txt |  3 ++
>  tools/perf/Documentation/perf-config.txt   |  8 +++-
>  tools/perf/Documentation/perf-report.txt   |  3 ++
>  tools/perf/Documentation/perf-top.txt      |  6 +++
>  tools/perf/arch/common.c                   |  4 +-
>  tools/perf/arch/common.h                   |  2 +-
>  tools/perf/builtin-annotate.c              | 42 +++++++++++++-------
>  tools/perf/builtin-report.c                | 35 ++++++++++++++---
>  tools/perf/builtin-top.c                   | 27 +++++++++++--
>  tools/perf/util/annotate.c                 | 45 +++++++++++++++++-----
>  tools/perf/util/annotate.h                 |  9 +++--
>  tools/perf/util/srcline.c                  | 26 ++++++++-----
>  tools/perf/util/symbol_conf.h              |  1 +
>  13 files changed, 163 insertions(+), 48 deletions(-)
> 
> -- 
> 2.40.0.348.gf938b09366-goog
> 

-- 

- Arnaldo
