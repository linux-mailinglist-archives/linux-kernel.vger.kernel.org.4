Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01192728432
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237220AbjFHPv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbjFHPvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:51:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F319430FD
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 08:51:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E293AB6;
        Thu,  8 Jun 2023 08:52:15 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.24.103])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBE463F587;
        Thu,  8 Jun 2023 08:51:28 -0700 (PDT)
Date:   Thu, 8 Jun 2023 16:51:26 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH] arm64/fpsimd: Exit streaming mode when flushing tasks
Message-ID: <ZIH4/kLTkvIN34FL@FVFF77S0Q05N>
References: <20230607-arm64-flush-svcr-v1-1-7821a6199e0a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607-arm64-flush-svcr-v1-1-7821a6199e0a@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 09:30:51PM +0100, Mark Brown wrote:
> Ensure there is no path where we might attempt to save SME state after we
> flush a task by updating the SVCR register state as well as updating our
> in memory state. I haven't seen a specific case where this is happening or
> seen a path where it might happen but for the cost of a single low overhead
> instruction it seems sensible to close the potential gap.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/kernel/fpsimd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 2fbafa5cc7ac..1627e0efe39a 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -1649,6 +1649,7 @@ void fpsimd_flush_thread(void)
>  
>  		fpsimd_flush_thread_vl(ARM64_VEC_SME);
>  		current->thread.svcr = 0;
> +		sme_smstop_sm();

I don't think we should blindly do this if we never expect to get here in that
state; this is just going to mask bugs and make them harder to debug going
forwards.

If we need this, it'd be better to have something like:

	if (WARN_ON_ONCE(sme_is_in_streaming_mode()))
		sme_smstop_sm();

... so that we can identify this case and fix it.

Thanks,
Mark.
