Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7099687E3F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 14:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjBBNEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 08:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjBBNEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 08:04:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0B78E4A7;
        Thu,  2 Feb 2023 05:04:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8F4EB82159;
        Thu,  2 Feb 2023 13:04:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32376C433EF;
        Thu,  2 Feb 2023 13:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675343055;
        bh=yUVM3WLXNypwBHB8GqC6IeD6PXsyotuZI3Y/nrlc7yg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V1HMe1Q+jFkkWbvWwukx7s4dD5Lw7QVNoB51ZAxboi/8pg0HD2z7C6Ll2oXSSYGpK
         ipbT7WqvfOQx16iqvIxptetN4Q7HRqL012FFgyo9Qug/MVhdGVDMep8WHuU/wTR+RI
         TpuVcyaOuT7/fwNUUblCYI5BteInXY5jDmutK4lcrMxc+1fyl4daPDRC++NDKz5OO1
         LXBG9Dr8ulRR0+qN5FgF28HR8yc1wl7t38BAIkCW5qqfqSd8Q3ZQ57QO/pFmTVAwug
         s72NbzBR6/YTkMEb5Mf62AyOfjexatq0IBUwF2T2NHyu3K5e+HFQDqQRzk6DKKwxl8
         JH2QAAMsU3nzw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A98F6405BE; Thu,  2 Feb 2023 10:04:12 -0300 (-03)
Date:   Thu, 2 Feb 2023 10:04:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, peterz@infradead.org, bp@alien8.de,
        namhyung@kernel.org, jolsa@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, dave.hansen@linux.intel.com,
        james.clark@arm.com, irogers@google.com, eranian@google.com,
        maddy@linux.ibm.com, kjain@linux.ibm.com, tmricht@linux.ibm.com,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH v4 0/4] tools perf: Add branch speculation info
Message-ID: <Y9u0zJA05JNHpB+i@kernel.org>
References: <cover.1675333809.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1675333809.git.sandipan.das@amd.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 02, 2023 at 05:56:13PM +0530, Sandipan Das escreveu:
> AMD Last Branch Record Extension Version 2 (LbrExtV2) provides branch
> speculation information and the perf UAPI is extended to provide this in
> a generic way. Make perf tool show this additional information.
> 
> The UAPI changes can be found in commit 93315e46b000 ("perf/core: Add
> speculation info to branch entries").
> 
> Requesting help from folks having access to big-endian systems to test
> changes in the sample parsing test as I was only able to test these in
> a ppc64 simulator.

I'll try folding some of these patches as 'perf test' must pass after
each of them, so that we keep the codebase bisectable.

Right now, after appling the first patch on this v4 series:

⬢[acme@toolbox perf]$ perf test 27
 27: Sample parsing                                                  : FAILED!
⬢[acme@toolbox perf]$

- Arnaldo
 
> Previous versions can be found at:
> v3: https://lore.kernel.org/all/cover.1675057032.git.sandipan.das@amd.com/
> v2: https://lore.kernel.org/all/cover.1664356751.git.sandipan.das@amd.com/
> v1: https://lore.kernel.org/all/cover.1660217326.git.sandipan.das@amd.com/
> 
> Changes in v4:
> - Update tests that were failing due to changes in perf output and
>   sample parsing (thanks to Arnaldo for reporting).
> 
> Changes in v3:
> - Drop tools-side UAPI changes as they have already been added by other
>   commits.
> - Rebase on top of latest perf/core.
> 
> Changes in v2:
> - Drop msr-index.h related changes for now.
> - Rebase on top of latest perf/core.
> - Fix UAPI breakage introduced by the ARM64 BRBE changes to perf branch
>   entry.
> 
> Sandipan Das (4):
>   perf script: Show branch speculation info
>   perf session: Show branch speculation info in raw dump
>   perf test sample-parsing: Update expected branch flags
>   perf test brstack: Update regex to include spec field
> 
>  tools/perf/builtin-script.c            |  5 +++--
>  tools/perf/tests/sample-parsing.c      |  2 +-
>  tools/perf/tests/shell/test_brstack.sh | 18 +++++++++---------
>  tools/perf/util/branch.c               | 15 +++++++++++++++
>  tools/perf/util/branch.h               |  2 ++
>  tools/perf/util/evsel.c                | 15 ++++++++++++---
>  tools/perf/util/session.c              |  5 +++--
>  7 files changed, 45 insertions(+), 17 deletions(-)
> 
> -- 
> 2.34.1
> 

-- 

- Arnaldo
