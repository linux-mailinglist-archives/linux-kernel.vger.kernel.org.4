Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84ADD7222AE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 11:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjFEJyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 05:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjFEJyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 05:54:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 550BAD2;
        Mon,  5 Jun 2023 02:54:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22949D75;
        Mon,  5 Jun 2023 02:55:19 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.24.244])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0CD03F793;
        Mon,  5 Jun 2023 02:54:31 -0700 (PDT)
Date:   Mon, 5 Jun 2023 10:54:26 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, jolsa@kernel.org,
        irogers@google.com, bp@alien8.de, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGRESSION][BISECT] perf/core: Remove pmu linear searching code
Message-ID: <ZH2w0hIAEIpEXjk2@FVFF77S0Q05N>
References: <3abd3693-ad87-9abf-a762-337076638fcc@linaro.org>
 <ZH2KVyyC5oMr+Vk2@FVFF77S0Q05N>
 <ecc69e40-f975-69e8-a372-6aafde66e0af@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecc69e40-f975-69e8-a372-6aafde66e0af@amd.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 03:04:45PM +0530, Ravi Bangoria wrote:
> On 05-Jun-23 12:40 PM, Mark Rutland wrote:
> > On Sun, Jun 04, 2023 at 01:38:10PM +0200, Krzysztof Kozlowski wrote:
> >> Hi,
> >>
> >> #regzbot introduced: 9551fbb64d09
> >>
> >> Bisect pointed to commit 9551fbb64d09 ("perf/core: Remove pmu linear
> >> searching code") as first one where all hardware events are gone from
> >> perf for ARMv7 Exynos5422 board.
> > 
> > I think that commit 9551fbb64d09 is just wrong.
> > 
> > The commit message asserts:
> > 
> >   Searching for the right pmu by iterating over all pmus is no longer
> >   required since all pmus now *must* be present in the 'pmu_idr' list.
> >   So, remove linear searching code.
> > 
> > ... and while each PMU has *some* entry in the pmu_idr list, for its dynamic
> > type, that means that events with other types (e.g. PERF_TYPE_HARDWARE or
> > PERF_TYPE_RAW) will fail to find a PMU in the IDR whereas they'd previously
> > have been accepted by a PMU during the subsequent iteration over all PMUs.
> 
> Not sure I follow.
> 
> PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE are aliased to PERF_TYPE_RAW in
> perf_init_event(). And PERF_TYPE_RAW should be present in pmu_idr if it
> was registered using:
> 
>   perf_pmu_register(pmu, "name", PERF_TYPE_RAW);

As I said, the PMUs get registered with a dynamic type, and there's no
registration with PERF_TYPE_RAW. On arm/arm64 systems, *every* CPU PMU gets
registered with:

	perf_pmu_register(pmu, name, -1);

... and *none* are registered with:

	perf_pmu_register(pmu, name, PERF_TYPE_RAW)

... so those all get a dynamic IDR type, and nothing gets placed into the IDR
for PERF_TYPE_RAW, etc. We rely on the linear search to find a PMU that can
handle PERF_TYPE_RAW, etc.

I appreciate that's not ideal, but it's how it has worked for almost a decade
now, so we can't change the userspace-visible behaviour.

Thanks,
Mark.
