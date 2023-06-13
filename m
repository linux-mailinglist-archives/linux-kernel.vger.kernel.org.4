Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188C872EC28
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjFMTnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239430AbjFMTmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:42:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C8F1BC3;
        Tue, 13 Jun 2023 12:42:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 568C9635DC;
        Tue, 13 Jun 2023 19:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A7AC433F0;
        Tue, 13 Jun 2023 19:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686685372;
        bh=c6ZzikBxtlmLZ/0hwSSKRejwnFaHjBC1cBfQC+bGTAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UdWdIZQ4bJ4A2YGAFBv2Wd3RGgeQhYPOV2r7AIRCo0aCH8aSM8A7J/5ojsBB6PzNn
         2mwAI5UT38Aq/Mn4Tym0NzSOxetG19LbSHH/Z4HK1Irn+XvDJL3u4oeEMmeWn7lD45
         ahCsLFdzuHoZ3/AeYGyPowkMyNPfBj6x8H3lQjyxd/KkHDAzEJYYzNJkXOLEHvtTlG
         Xc17OFDbaM3ncJp5iXtdhUyduzrT09oyctZ3wX9NEIicN9mwxucNzw0qSi2FhnqD7Y
         2C/IRt99JQh9xCzpeB58V6Qa9PYBwtxAcx+qVWvzRkgUILbEMy4eZCGeZw/U0N2e3d
         TWWu7+WB0SGXw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EBCE140692; Tue, 13 Jun 2023 16:42:49 -0300 (-03)
Date:   Tue, 13 Jun 2023 16:42:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] perf cs-etm: Track exception level
Message-ID: <ZIjGubrXqQ8IIqDm@kernel.org>
References: <20230612111403.100613-1-james.clark@arm.com>
 <ZIdk1ArKuXLpKZT7@kernel.org>
 <94e91db2-182e-836f-2edc-f804c4bb7290@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94e91db2-182e-836f-2edc-f804c4bb7290@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 13, 2023 at 09:56:29AM +0100, James Clark escreveu:
> 
> 
> On 12/06/2023 19:32, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Jun 12, 2023 at 12:13:57PM +0100, James Clark escreveu:
> >> Changes since v2:
> >>
> >>   * Rename prev_thread -> prev_packet_thread and prev_el ->
> >>     prev_packet_el
> >>   * Add a comment about tracking the previous packet's thread
> >>
> >> Changes since v1:
> >>
> >>   * Always assume host kernel when the trace was captured at EL1 (nVHE)
> >>   * Fix EL validation to work with ETMv3
> >>   * Add a commit to make PID format accessible from struct
> >>     cs_etm_auxtrace
> > 
> > Please take a look in my tmp.perf-tools-next branch, there were some
> > conflicts I had to fix as those files were touched by refactorings for
> > addr_location and thread reference counting.
> > 
> 
> Yeah I got the same result and the tests are still passing. Thanks for
> fixing those.

Thanks for double checking that!

- Arnaldo
 
> > ⬢[acme@toolbox perf-tools-next]$ git log --oneline -10
> > aa53fb2c482e70c2 (HEAD -> perf-tools-next) perf cs-etm: Add exception level consistency check
> > 2918e9895224541f perf cs-etm: Track exception level
> > f492a33909829a75 perf cs-etm: Make PID format accessible from struct cs_etm_auxtrace
> > e29ec19b0751c6b2 perf cs-etm: Use previous thread for branch sample source IP
> > e9e03e9c3ca7088c perf cs-etm: Only track threads instead of PID and TIDs
> > 6fd34445b8c94aa7 perf map: Fix double 'struct map' reference free found with -DREFCNT_CHECKING=1
> > e9c0a7f63e45e76f perf srcline: Optimize comparision against SRCLINE_UNKNOWN
> > fd87a79c7ed62804 perf hist: Fix srcline memory leak
> > 933f9651d47cdda2 perf srcline: Change free_srcline to zfree_srcline
> > d22cfb063bcc674e perf callchain: Use pthread keys for tls callchain_cursor
> > ⬢[acme@toolbox perf-tools-next]$
> > 
> > 
> > - Arnaldo
> >  
> >> ======
> >>
> >> Some fixes to support an issue reported by Denis Nikitin where decoding
> >> trace that contains different EL1 and EL2 kernels can crash or go into
> >> an infinite loop because the wrong kernel maps are used for the decode.
> >>
> >> This still doesn't support distinguishing guest and host userspace,
> >> we'd still have to fix the timestamps and do a bit more work to
> >> correlate that. And I've removed PERF_RECORD_MISC_HYPERVISOR as a
> >> possible outcome of cs_etm__cpu_mode(). As far as I know this could
> >> never have been returned anyway because machine__is_host(machine) was
> >> always true due to session.machines.host being hard coded. And I'm not
> >> sure of the relevance of the difference between PERF_RECORD_MISC_KERNEL
> >> and PERF_RECORD_MISC_HYPERVISOR in this scenario.
> >>
> >> The first commit is a tidy up, second fixes a bug that I found when
> >> comparing the exception level and thread of branch records, the third
> >> is the main fix, and the last commit is some extra error checking. 
> >>
> >> Applies to acme/perf-tools-next (42713dafc)
> >>
> >> James Clark (5):
> >>   perf cs-etm: Only track threads instead of PID and TIDs
> >>   perf cs-etm: Use previous thread for branch sample source IP
> >>   perf cs-etm: Make PID format accessible from struct cs_etm_auxtrace
> >>   perf cs-etm: Track exception level
> >>   perf cs-etm: Add exception level consistency check
> >>
> >>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  33 +-
> >>  .../perf/util/cs-etm-decoder/cs-etm-decoder.h |   4 +-
> >>  tools/perf/util/cs-etm.c                      | 282 ++++++++++--------
> >>  tools/perf/util/cs-etm.h                      |  13 +-
> >>  4 files changed, 184 insertions(+), 148 deletions(-)
> >>
> >> -- 
> >> 2.34.1
> >>
> > 

-- 

- Arnaldo
