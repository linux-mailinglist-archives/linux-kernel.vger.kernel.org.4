Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA8F6756B7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjATONP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjATONB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:13:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13431C63A1;
        Fri, 20 Jan 2023 06:11:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DA1A61F5F;
        Fri, 20 Jan 2023 14:11:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA54C433EF;
        Fri, 20 Jan 2023 14:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674223894;
        bh=4XdmM2RXn8ZvAQ6RSJXIviUo0OKUUjP7H8qXfzZ5bIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r0GJQ0bJOBQGdq7DbMq58XBLT0BRIXBSn8IYngaXuViqzB3ctAL3bZ6916b597WII
         8iwGWF305zWu7JBfpQYRdmxuLKSYn0U/UolNnWexjkMgPT9YprVrhz0t9mSJPP/USi
         2BfSFM2s+r8VJQDDz73qvckIjxQvV3zBuI55dToTNBNpg0elKns6MM9+zHp1BdU5Zv
         6ijqAgoc0MYl1JnhPmzl24rTKcfw+akChyTsIMKwOWHwp1cJ6S/fAPtJFz6ulv1Pzy
         vS9JbrVt0bIKsfMUl+EXNk7oyzK81oetZOHij7FLw8U06MiS/PWCPadxzV+8vxD//P
         qRARiEsvqS91Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 27063405BE; Fri, 20 Jan 2023 11:11:31 -0300 (-03)
Date:   Fri, 20 Jan 2023 11:11:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 00/10] perf symbols: Improve dso__synthesize_plt_symbols()
Message-ID: <Y8qhE6Sd66l8Coaj@kernel.org>
References: <20230120123456.12449-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120123456.12449-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jan 20, 2023 at 02:34:46PM +0200, Adrian Hunter escreveu:
> Hi
> 
> This is the first of 2 patchsets to improve dso__synthesize_plt_symbols().
> This patchset is really preparation for the 2nd patchset, which focuses
> on getting rid of unknown symbols that show up in Intel PT traces.
> The 2nd patchset is still under development.
> 
> These patches are small and staightforward. Only the new Symbols test is
> slightly interesting because it provides a way to see what symbols
> perf discovers for any given dso. The test fails initially, but
> should pass after patch 7 "perf symbols: Add symbol for .plt header".

Looks nice, I've test build, one by one and used the test with a
different --dso, etc. I'll keep it today locally for further container
tests and to give time to others to look at it, I'll have it in
tmp.perf/core soon.

- Arnaldo
 
> 
> Adrian Hunter (10):
>       perf test: Add Symbols test
>       perf symbols: Factor out get_plt_sizes()
>       perf symbols: Check plt_entry_size is not zero
>       perf symbols: Add dso__find_symbol_nocache()
>       perf symbols: Slightly simplify 'err' usage in dso__synthesize_plt_symbols()
>       perf symbols: Do not check ss->dynsym twice
>       perf symbols: Add symbol for .plt header
>       perf symbols: Allow for .plt entries with no symbol
>       perf symbols: Combine handling for SHT_RELA and SHT_REL
>       perf symbols: Check SHT_RELA and SHT_REL type earlier
> 
>  tools/perf/Documentation/perf-test.txt |   3 +
>  tools/perf/tests/Build                 |   1 +
>  tools/perf/tests/builtin-test.c        |   3 +
>  tools/perf/tests/symbols.c             | 150 ++++++++++++++++++++++++++
>  tools/perf/tests/tests.h               |   3 +
>  tools/perf/util/symbol-elf.c           | 190 +++++++++++++++++----------------
>  tools/perf/util/symbol.c               |   5 +
>  tools/perf/util/symbol.h               |   1 +
>  8 files changed, 262 insertions(+), 94 deletions(-)
>  create mode 100644 tools/perf/tests/symbols.c
> 
> 
> Regards
> Adrian

-- 

- Arnaldo
