Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA396376C8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 11:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiKXKrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 05:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiKXKrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 05:47:43 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 717252611A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:47:42 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 576E023A;
        Thu, 24 Nov 2022 02:47:48 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.5.138])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4B383F587;
        Thu, 24 Nov 2022 02:47:40 -0800 (PST)
Date:   Thu, 24 Nov 2022 10:47:34 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ren Zhijie <renzhijie2@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        yusongping@huawei.com
Subject: Re: [PATCH v2] arm64: armv8_deprecated: fix unused-function error
Message-ID: <Y39Lxn/6G35C0LVu@FVFF77S0Q05N>
References: <20221124022429.19024-1-renzhijie2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221124022429.19024-1-renzhijie2@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 02:24:29AM +0000, Ren Zhijie wrote:
> If CONFIG_SWP_EMULATION is not set and
> CONFIG_CP15_BARRIER_EMULATION is not set,
> aarch64-linux-gnu complained about unused-function :
> 
> arch/arm64/kernel/armv8_deprecated.c:67:21: error: ‘aarch32_check_condition’ defined but not used [-Werror=unused-function]
>  static unsigned int aarch32_check_condition(u32 opcode, u32 psr)
>                      ^~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> To fix this warning, modify aarch32_check_condition() with __maybe_unused.
> 
> Fixes: 0c5f416219da ("arm64: armv8_deprecated: move aarch32 helper earlier")
> Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
> Changes in v2:
> - modify aarch32_check_condition() with __maybe_unused.
> 
>  arch/arm64/kernel/armv8_deprecated.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
> index ed0788cf6bbb..8a9052cf3013 100644
> --- a/arch/arm64/kernel/armv8_deprecated.c
> +++ b/arch/arm64/kernel/armv8_deprecated.c
> @@ -64,7 +64,7 @@ struct insn_emulation {
>  
>  #define	ARM_OPCODE_CONDITION_UNCOND	0xf
>  
> -static unsigned int aarch32_check_condition(u32 opcode, u32 psr)
> +static unsigned int __maybe_unused aarch32_check_condition(u32 opcode, u32 psr)
>  {
>  	u32 cc_bits  = opcode >> 28;
>  
> -- 
> 2.17.1
> 
