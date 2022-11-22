Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186326341DE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbiKVQtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbiKVQs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:48:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 939646D494
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:48:56 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D20291FB;
        Tue, 22 Nov 2022 08:49:02 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.32.179])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D5333F73D;
        Tue, 22 Nov 2022 08:48:55 -0800 (PST)
Date:   Tue, 22 Nov 2022 16:48:52 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ren Zhijie <renzhijie2@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, yusongping@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: armv8_deprecated: fix unused-function error
Message-ID: <Y3z9dEkMdCeWAWq0@FVFF77S0Q05N.cambridge.arm.com>
References: <20221122032010.202956-1-renzhijie2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221122032010.202956-1-renzhijie2@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 03:20:10AM +0000, Ren Zhijie wrote:
> If CONFIG_SWP_EMULATION is not set and
> CONFIG_CP15_BARRIER_EMULATION is not set,
> aarch64-linux-gnu complained about unused-function :
> 
> arch/arm64/kernel/armv8_deprecated.c:67:21: error: ‘aarch32_check_condition’ defined but not used [-Werror=unused-function]
>  static unsigned int aarch32_check_condition(u32 opcode, u32 psr)
>                      ^~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> To fix this error, warp the definition of
> aarch32_check_condition() by defined(CONFIG_SWP_EMULATION) ||
> defined(CONFIG_CP15_BARRIER_EMULATION)
> 
> Fixes: 0c5f416219da ("arm64: armv8_deprecated: move aarch32 helper earlier")

This also depends on building with additional options to turn warnings into
errors, no?

> Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
> ---
>  arch/arm64/kernel/armv8_deprecated.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
> index ed0788cf6bbb..3f29ceb6653a 100644
> --- a/arch/arm64/kernel/armv8_deprecated.c
> +++ b/arch/arm64/kernel/armv8_deprecated.c
> @@ -64,6 +64,7 @@ struct insn_emulation {
>  
>  #define	ARM_OPCODE_CONDITION_UNCOND	0xf
>  
> +#if defined(CONFIG_SWP_EMULATION) || defined(CONFIG_CP15_BARRIER_EMULATION)
>  static unsigned int aarch32_check_condition(u32 opcode, u32 psr)
>  {
>  	u32 cc_bits  = opcode >> 28;
> @@ -76,6 +77,7 @@ static unsigned int aarch32_check_condition(u32 opcode, u32 psr)
>  	}
>  	return ARM_OPCODE_CONDTEST_UNCOND;
>  }
> +#endif

Could we mark this as '__maybe_unused' or 'inline' instead? I think that's
preferable to the ifdeferry.

Thanks,
Mark.

>  
>  #ifdef CONFIG_SWP_EMULATION
>  /*
> -- 
> 2.17.1
> 
