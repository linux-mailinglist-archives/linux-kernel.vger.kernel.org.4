Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F0E699691
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 15:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjBPOCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 09:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBPOCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 09:02:53 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 572F86EB6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 06:02:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96DF11042;
        Thu, 16 Feb 2023 06:03:34 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.28.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF3213F703;
        Thu, 16 Feb 2023 06:02:50 -0800 (PST)
Date:   Thu, 16 Feb 2023 14:02:42 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Janne Grunau <j@jannau.net>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Subject: Re: [PATCH] arm_pmu: Invert fallback armpmu_filter() return value
Message-ID: <Y+43ghGB21FUm2ER@FVFF77S0Q05N.cambridge.arm.com>
References: <20230215-arm_pmu_m1_regression-v1-1-f5a266577c8d@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215-arm_pmu_m1_regression-v1-1-f5a266577c8d@jannau.net>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Feb 15, 2023 at 12:27:13PM +0100, Janne Grunau wrote:
> Fixes a regression in "perf: Rewrite core context handling" for arm_pmu
> based drivers without a filter function pointer as the Apple M1 PMU.
> The event is ignored if filter() returns 'true' opposite to
> filter_match(). The refactoring failed to invert the return value if
> arm_pmu has no filter() function pointer of its own.
> 
> Fixes: bd2756811766 ("perf: Rewrite core context handling")
> Signed-off-by: Janne Grunau <j@jannau.net>

Thanks for the report and the patch, and apologies for this happening in the
first place; this has clearly slipped by our testing...

I think this fix is correct, but I spot that bd2756811766 also broken CHAIN
event filtering, and made armv8pmu_filter() trivial, so we can get rid of
arm_pmu::filter() entirely and make this simpler and clearer.

I'm going to send a couple of patches to addres both those issues in a moment,
with everyone here on Cc.

Thanks,
Mark.

> ---
>  drivers/perf/arm_pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 9b593f985805..9cb22f36cf66 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -556,7 +556,7 @@ static bool armpmu_filter(struct pmu *pmu, int cpu)
>  	if (ret && armpmu->filter)
>  		return armpmu->filter(pmu, cpu);
>  
> -	return ret;
> +	return !ret;
>  }
>  
>  static ssize_t cpus_show(struct device *dev,
> 
> ---
> base-commit: ceaa837f96adb69c0df0397937cd74991d5d821a
> change-id: 20230215-arm_pmu_m1_regression-b6dd48d0c792
> 
> Best regards,
> -- 
> Janne Grunau <j@jannau.net>
> 
