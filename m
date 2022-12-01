Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498EB63F066
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 13:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiLAMYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 07:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiLAMYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 07:24:43 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F9CD5AE1C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 04:24:42 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FCC9D6E;
        Thu,  1 Dec 2022 04:24:49 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.5.176])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D1863F73D;
        Thu,  1 Dec 2022 04:24:41 -0800 (PST)
Date:   Thu, 1 Dec 2022 12:24:35 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm_pmu: Drop redundant armpmu->map_event() in
 armpmu_event_init()
Message-ID: <Y4idAz6XTpj6gdTd@FVFF77S0Q05N>
References: <20221130083350.264583-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130083350.264583-1-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 02:03:50PM +0530, Anshuman Khandual wrote:
> __hw_perf_event_init() already calls armpmu->map_event() callback, and also
> returns its error code including -ENOENT, along with a debug callout. Hence
> an additional armpmu->map_event() check for -ENOENT is redundant.

Hmm; it looks like this has been redundant since commit:

  e1f431b57ef9e4a6 ("ARM: perf: refactor event mapping")

... and was an oversight on my behalf.

This looks fine to me, so FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on v6.1-rc6
> 
>  drivers/perf/arm_pmu.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 6538cec1a601..4be6869005f1 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -529,10 +529,6 @@ static int armpmu_event_init(struct perf_event *event)
>  			return -EOPNOTSUPP;
>  		}
>  	}
> -
> -	if (armpmu->map_event(event) == -ENOENT)
> -		return -ENOENT;
> -
>  	return __hw_perf_event_init(event);
>  }
>  
> -- 
> 2.25.1
> 
