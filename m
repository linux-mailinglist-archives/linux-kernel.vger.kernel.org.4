Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC346D1F7A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 13:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjCaLv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 07:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjCaLvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 07:51:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657074498;
        Fri, 31 Mar 2023 04:51:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6C26B82EBD;
        Fri, 31 Mar 2023 11:51:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B530C433EF;
        Fri, 31 Mar 2023 11:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680263508;
        bh=pq99YNVP8zVp0i8YVWlsVcO4uXm1s1osVaX3cFcttDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BpmZAHXRodN9zRVrQWbbG4q6Abz1UCVruj+lRiS61YGxPCJjfDrLwvydp6Ll+TgLi
         G+j4ctbgm8pVRVBlpAGHwnvvjqDgErCLZJiKfje0o0TWkcXbaXYHioxzNh/dQs8abo
         yPiTpIQ2qBTngaA6q6vpuf+94w9R7y4m4QN7zLY6PX7mHh5zVIwhY9NQ29E9D4hNe/
         kzWhmWXWIkflbCpocnZ2IDNVudl50PzyyoyngmXZeSnGujInBYaH6oLJaJZ1SY8iWl
         mOmW5DoGwyv8HMf6vHOHdyiWcBag1zOFDcctG//61LRUIuVFTJX8dG9xuZUTGpgk01
         770f9Y2ff6GUg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 747764052D; Fri, 31 Mar 2023 08:51:45 -0300 (-03)
Date:   Fri, 31 Mar 2023 08:51:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
        leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, gankulkarni@os.amperecomputing.com,
        darren@os.amperecomputing.com
Subject: Re: [PATCH v9 0/3] perf: cs-etm: Update perf to handle new Coresight
 Trace ID
Message-ID: <ZCbJUWw7TkUCWWuc@kernel.org>
References: <20230331055645.26918-1-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331055645.26918-1-mike.leach@linaro.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 31, 2023 at 06:56:42AM +0100, Mike Leach escreveu:
> The original method for allocating trace source ID values to sources was
> to use a fixed algorithm for CPU based sources of (cpu_num * 2 + 0x10).
> The STM was allocated ID 0x1.
> 
> This mechanism is broken for systems with more than 47 cores.
> 
> The kernel related patches the provide a fixed Trace ID allocation mechanism
> are now upstreamed.
> 
> This patchset updates the perf code to handle the changes to the trace ID
> notification mechanism that now uses the PERF_RECORD_AUX_OUTPUT_HW_ID
> packet to set Trace ID in the perf ETM decoders.
> 
> Applies and test oo perf/core

I'm keeping perf/core with the same contents as perf-tools-next, please
use perf-tools-next as in the future I'll stop using the old perf/core
name.

Applied, testing.

- Arnaldo
 
> Changes since v8:
> 1. Fix build issues
> 2. Fix implicit function problem
> 
> Changes since v7:
> Split from original patchset [1] to be sent separately as kernel related
> patches are now upstream.
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20230116124928.5440-1-mike.leach@linaro.org/
> 
> Mike Leach (3):
>   perf: cs-etm: Move mapping of Trace ID and cpu into helper function
>   perf: cs-etm: Update record event to use new Trace ID protocol
>   perf: cs-etm: Handle PERF_RECORD_AUX_OUTPUT_HW_ID packet
> 
>  tools/include/linux/coresight-pmu.h           |  47 ++-
>  tools/perf/arch/arm/util/cs-etm.c             |  27 +-
>  tools/perf/util/cs-etm-base.c                 |   3 +-
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c |   7 +
>  tools/perf/util/cs-etm.c                      | 326 +++++++++++++++---
>  tools/perf/util/cs-etm.h                      |  14 +-
>  6 files changed, 356 insertions(+), 68 deletions(-)
> 
> -- 
> 2.17.1
> 

-- 

- Arnaldo
