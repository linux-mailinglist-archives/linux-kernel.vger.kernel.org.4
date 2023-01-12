Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320C26673E3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbjALOAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjALOAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:00:00 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 66A25517FF
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 05:59:58 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C32F13D5;
        Thu, 12 Jan 2023 06:00:40 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.43.206])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18F3B3F67D;
        Thu, 12 Jan 2023 05:59:56 -0800 (PST)
Date:   Thu, 12 Jan 2023 13:59:54 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH V7 4/6] arm64/perf: Add branch stack support in struct
 pmu_hw_events
Message-ID: <Y8ASWhYWmRbQp9Ar@FVFF77S0Q05N>
References: <20230105031039.207972-1-anshuman.khandual@arm.com>
 <20230105031039.207972-5-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105031039.207972-5-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 08:40:37AM +0530, Anshuman Khandual wrote:
> This adds branch records buffer pointer in 'struct pmu_hw_events' which can
> be used to capture branch records during PMU interrupt. This percpu pointer
> here needs to be allocated first before usage.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

This looks fine, but it's difficult to review this without seeing how its
lifetime is managed, and it feels like this should be folded into a subsequent
patch which manages that.

Thanks,
Mark.

> ---
>  include/linux/perf/arm_pmu.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index 64e1b2594025..9184f9b33740 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -44,6 +44,13 @@ static_assert((PERF_EVENT_FLAG_ARCH & ARMPMU_EVT_47BIT) == ARMPMU_EVT_47BIT);
>  	},								\
>  }
>  
> +#define MAX_BRANCH_RECORDS 64
> +
> +struct branch_records {
> +	struct perf_branch_stack	branch_stack;
> +	struct perf_branch_entry	branch_entries[MAX_BRANCH_RECORDS];
> +};
> +
>  /* The events for a given PMU register set. */
>  struct pmu_hw_events {
>  	/*
> @@ -70,6 +77,8 @@ struct pmu_hw_events {
>  	struct arm_pmu		*percpu_pmu;
>  
>  	int irq;
> +
> +	struct branch_records	*branches;
>  };
>  
>  enum armpmu_attr_groups {
> -- 
> 2.25.1
> 
