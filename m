Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FCC721F24
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjFEHLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjFEHKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:10:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 440A111A;
        Mon,  5 Jun 2023 00:10:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8936DD75;
        Mon,  5 Jun 2023 00:11:08 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.24.244])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C0223F793;
        Mon,  5 Jun 2023 00:10:20 -0700 (PDT)
Date:   Mon, 5 Jun 2023 08:10:15 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     jolsa@kernel.org, irogers@google.com, bp@alien8.de,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGRESSION][BISECT] perf/core: Remove pmu linear searching code
Message-ID: <ZH2KVyyC5oMr+Vk2@FVFF77S0Q05N>
References: <3abd3693-ad87-9abf-a762-337076638fcc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3abd3693-ad87-9abf-a762-337076638fcc@linaro.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 04, 2023 at 01:38:10PM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> #regzbot introduced: 9551fbb64d09
> 
> Bisect pointed to commit 9551fbb64d09 ("perf/core: Remove pmu linear
> searching code") as first one where all hardware events are gone from
> perf for ARMv7 Exynos5422 board.

I think that commit 9551fbb64d09 is just wrong.

The commit message asserts:

  Searching for the right pmu by iterating over all pmus is no longer
  required since all pmus now *must* be present in the 'pmu_idr' list.
  So, remove linear searching code.

... and while each PMU has *some* entry in the pmu_idr list, for its dynamic
type, that means that events with other types (e.g. PERF_TYPE_HARDWARE or
PERF_TYPE_RAW) will fail to find a PMU in the IDR whereas they'd previously
have been accepted by a PMU during the subsequent iteration over all PMUs.

So that iteration is still required.

How does this work on x86? Do you have pseudo-PMUs for PERF_TYPE_HARDWARE and
PERF_TYPE_RAW ?

Thanks,
Mark.

> Expected:
> perf list | grep "Hardware event"
>   branch-instructions OR branches                    [Hardware event]
>   branch-misses                                      [Hardware event]
>   bus-cycles                                         [Hardware event]
>   cache-misses                                       [Hardware event]
>   cache-references                                   [Hardware event]
>   cpu-cycles OR cycles                               [Hardware event]
>   instructions                                       [Hardware event]
> 
> 
> Result:
> empty, no hardware events
> 
> 1. Arch ARM Linux
> 2. exynos_defconfig
> 3. Board:
>    - Odroid HC1
>      ARMv7, octa-core (Cortex-A7+A15), Exynos5422 SoC
>      Systemd: v239
> 
> 4. perf version 6.1.0
> 
> 
> Best regards,
> Krzysztof
