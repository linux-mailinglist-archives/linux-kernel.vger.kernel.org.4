Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E314D722FFA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbjFETpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235759AbjFETot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:44:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FAEF1;
        Mon,  5 Jun 2023 12:44:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85A88629E3;
        Mon,  5 Jun 2023 19:44:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF163C433EF;
        Mon,  5 Jun 2023 19:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685994287;
        bh=P3Zf9vDH5D/IWGkhQFjE1PM6fek60DSu9f7MDIGdx2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IDLgFf79qxTKEyrb4uMU2oWQtMOa+noftKfMZYlXF6dzY0osIBZaVgbt0vfERO0Ff
         vzTklZwU7pKPs/UWngEkue52KiS0GzoRlDU0G+rUli38ukb0hY9w4FHhd6dwn0tZSB
         4m4i71zvazfIFNGh5cRiok0hNPMxUM6AuCNRXgwZq4oo+84SwjhKpwNICnVD5fvDyr
         BfE8JXejfya107VylZBmuo59x/yeO0DY+rpDHKGviRrsE6RKrQZyeib5mpLI7wAKXd
         AhUxmsFRpI9vfkaVkrWqGwW4u71n6YUPtxqCxxVfscQ1sREvBo+MEzzRK7jtH3FSkH
         K62I3FhF01ZuQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4B09340692; Mon,  5 Jun 2023 16:44:45 -0300 (-03)
Date:   Mon, 5 Jun 2023 16:44:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, denik@chromium.org,
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
Subject: Re: [PATCH 0/4] perf cs-etm: Track exception level
Message-ID: <ZH47LeSnwY2uKs//@kernel.org>
References: <20230524131958.2139331-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524131958.2139331-1-james.clark@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 24, 2023 at 02:19:54PM +0100, James Clark escreveu:
> Some fixes to support an issue reported by Denis Nikitin where decoding
> trace that contains different EL1 and EL2 kernels can crash or go into
> an infinite loop because the wrong kernel maps are used for the decode.
> 
> This still doesn't support distinguishing guest and host userspace,
> we'd still have to fix the timestamps and do a bit more work to
> correlate that. And I've removed PERF_RECORD_MISC_HYPERVISOR as a
> possible outcome of cs_etm__cpu_mode(). As far as I know this could
> never have been returned anyway because machine__is_host(machine) was
> always true due to session.machines.host being hard coded. And I'm not
> sure of the relevance of the difference between PERF_RECORD_MISC_KERNEL
> and PERF_RECORD_MISC_HYPERVISOR in this scenario.
> 
> The first commit is a tidy up, second fixes a bug that I found when
> comparing the exception level and thread of branch records, the third
> is the main fix, and the last commit is some extra error checking. 
> 
> Applies to acme/perf-tools (4e111f0cf0)

So there seems to be agreement the first two patches can be applied? May
I go ahead and do that now?

- Arnaldo
 
> James Clark (4):
>   perf cs-etm: Only track threads instead of PID and TIDs
>   perf cs-etm: Use previous thread for branch sample source IP
>   perf cs-etm: Track exception level
>   perf cs-etm: Add exception level consistency check
> 
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  13 +-
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.h |   4 +-
>  tools/perf/util/cs-etm.c                      | 220 +++++++++---------
>  tools/perf/util/cs-etm.h                      |   5 +-
>  4 files changed, 126 insertions(+), 116 deletions(-)
> 
> -- 
> 2.34.1
> 

-- 

- Arnaldo
