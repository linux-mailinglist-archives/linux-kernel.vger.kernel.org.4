Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815A5675A9A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjATQ6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjATQ6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:58:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71912915C;
        Fri, 20 Jan 2023 08:58:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7139F61FD4;
        Fri, 20 Jan 2023 16:58:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EADAC4339C;
        Fri, 20 Jan 2023 16:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674233928;
        bh=4hWdwwDzyxlBYTSLecyMQZGLnPGW/XM3KfBBRliMAmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZWLIiiU737lTtjK3CVrxntqmf6kkeRrLLI+eKBxK3f+wsCQH9KkTgMJIzqlBqKZ7T
         t0pNrP8i0oqxtk1NvyQGgWLp4GkUfYNobTdCJOOrkQSqrqASBLS7uLJ9nhSgWarX0u
         yYUFMRV8o3D49bvYz7sotO+vHPhUaV//nS6XsQIqU3lLXdathgTH6zaYkTH2vvCr6z
         Baz3MAQf+DTBUVOLf93R+wSDvvRkUhOiOrfedclQ/ERgOYlYCf15Ln03ZVeaa8ETa1
         ysLED5Ym/KF+JhddsE2Lip2dVLVHAoK6OfGnTjm+rQ9eeQ2dWgAuMv2c+56BX6VOJS
         BboyD/cmR5sVA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 432C0405BE; Fri, 20 Jan 2023 13:58:46 -0300 (-03)
Date:   Fri, 20 Jan 2023 13:58:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, tanmay@marvell.com,
        leo.yan@linaro.org, mike.leach@linaro.org, sgoutham@marvell.com,
        gcherian@marvell.com, lcherian@marvell.com, bbhushan2@marvell.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/8] perf cs_etm: Basic support for virtual/kernel
 timestamps
Message-ID: <Y8rIRuUd4h+309cE@kernel.org>
References: <20230119154308.3815108-1-james.clark@arm.com>
 <Y8l20EOD6vtvJw83@kernel.org>
 <72843540-fe25-d805-df76-3a3556fb5774@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72843540-fe25-d805-df76-3a3556fb5774@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jan 20, 2023 at 02:39:30PM +0000, James Clark escreveu:
> 
> 
> On 19/01/2023 16:58, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Jan 19, 2023 at 03:42:59PM +0000, James Clark escreveu:
> >> Changes since v3:
> >>
> >>   * Scale time estimates by INSTR_PER_NS, rather than assuming 1
> >>     instruction = 1ns
> >>   * Add a new commit that fixes some issues around timestamps going
> >>     backwards
> >>   * Use nanoseconds inside cs-etm-decoder.c, rather than storing the
> >>     raw time values and converting when a sample is synthesized. This
> >>     simplifies some of the code like estimating the first timestamp.
> > 
> > I would check this myself, but since Suzuki had some review comments and
> > you may consider a v5, please check this:
> > 
> > Cover: ./v4_20230119_james_clark_perf_cs_etm_basic_support_for_virtual_kernel_timestamps.cover
> >  Link: https://lore.kernel.org/r/20230119154308.3815108-1-james.clark@arm.com
> >        git checkout -b v4_20230119_james_clark_arm_com 69b41ac87e4a664de78a395ff97166f0b2943210
> >        git am ./v4_20230119_james_clark_perf_cs_etm_basic_support_for_virtual_kernel_timestamps.mbx
> > [acme@quaco perf]$        git am ./v4_20230119_james_clark_perf_cs_etm_basic_support_for_virtual_kernel_timestamps.mbx
> > Applying: perf: Remove duplication around EVENT_SOURCE_DEVICE_PATH
> > error: patch failed: tools/perf/util/pmu.c:1993
> > error: tools/perf/util/pmu.c: patch does not apply
> > error: patch failed: tools/perf/util/pmu.h:259
> > error: tools/perf/util/pmu.h: patch does not apply
> > Patch failed at 0001 perf: Remove duplication around EVENT_SOURCE_DEVICE_PATH
> > hint: Use 'git am --show-current-patch=diff' to see the failed patch
> > When you have resolved this problem, run "git am --continue".
> > If you prefer to skip this patch, run "git am --skip" instead.
> > To restore the original branch and stop patching, run "git am --abort".
> > [acme@quaco perf]$
> > 
> > Probably a conflict with one of these:
> > 
> > [acme@quaco perf]$ git log --oneline -5 tools/perf/util/pmu.c
> > acef233b7ca749fd perf pmu: Add #slots literal support for arm64
> > 336b92da1aa4228a perf tool: Move pmus list variable to a new file
> > 49bd97c28b7e7f01 perf tools: Use dedicated non-atomic clear/set bit helpers
> > e5c6109f4813246a perf list: Reorganize to use callbacks to allow honouring command line options
> > eb2d4514a5971444 perf pmu: Restructure print_pmu_events() to avoid memory allocations
> > [acme@quaco perf]$
> > 
> > Update to my perf/core branch or even tmp.perf/core which is newer but
> > still needs the full set of container build tests.
> 
> Oops I must have just missed the latest perf/core update. I fixed the
> conflict and sent a v5, and decided to not make any changes for Suzuki's
> comments.

Trying it now
