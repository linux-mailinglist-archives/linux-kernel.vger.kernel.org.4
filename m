Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8657563F8BD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 21:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiLAUDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 15:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiLAUDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 15:03:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565EE93A52
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 12:03:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A087FB82039
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 20:03:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D419C433D6;
        Thu,  1 Dec 2022 20:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669924982;
        bh=4zUvbQt2fvOvF13lR47+s4icnmOdckMCkatNScd1W3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O5y9L+drRDUDYiBMvoL/H6hKQUSFqUDjnPPQGL6Log+dgkEx164KZx3GrFHNuAhes
         YEGJ7G7EtWpxTmCxMp3xDzX6dC2qZp8x/sgAe9GKg0PKXVDGhE1t2ZACDuRt6+0iGT
         Bq1LVMUe5W9ZCnXy4aq73Jo0QoQv5yvWnpw3mVFWlzeO4HmfUsgxIOh0L+4NJ6LaWE
         qo0r3dOtFsjZbV4Kb0V4+tGSJNdBShcbCD5K7KQarHmu3MzP8HBhnZPiUHmCgplYZ/
         jpvVASn1OF92eTjanqp1B2TXJVerehOzKXTUIz8dwhm0u0zAaQPD6qrHmE2S4D8vnt
         gaQu52HmcFWAg==
Date:   Thu, 1 Dec 2022 20:02:56 +0000
From:   Conor Dooley <conor@kernel.org>
To:     guoren@kernel.org
Cc:     anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de, rostedt@goodmis.org,
        mhiramat@kernel.org, jolsa@redhat.com, bp@suse.de,
        jpoimboe@kernel.org, suagrfillet@gmail.com, andy.chiu@sifive.com,
        mark.rutland@arm.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 6/7] riscv: ftrace: Add
 DYNAMIC_FTRACE_WITH_DIRECT_CALLS support
Message-ID: <Y4kIcGY0rXTGb3po@spud>
References: <20221129033230.255947-1-guoren@kernel.org>
 <20221129033230.255947-7-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129033230.255947-7-guoren@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 10:32:29PM -0500, guoren@kernel.org wrote:
> From: Song Shuai <suagrfillet@gmail.com>
> 
> This patch adds DYNAMIC_FTRACE_WITH_DIRECT_CALLS support for RISC-V.
> 
> select the DYNAMIC_FTRACE_WITH_DIRECT_CALLS to provide the
> register_ftrace_direct[_multi] interfaces allowing users to register
> the customed trampoline (direct_caller) as the mcount for one or
> more target functions. And modify_ftrace_direct[_multi] are also
> provided for modifying direct_caller.
> 
> To make the direct_caller and the other ftrace hooks (eg. function/fgraph
> tracer, k[ret]probes) co-exist, a temporary register is nominated to
> store the address of direct_caller in ftrace_regs_caller. After the
> setting of the address direct_caller by direct_ops->func and the
> RESTORE_REGS in ftrace_regs_caller, direct_caller will be jumped to
> by the `jr` inst.
> 
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> Tested-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/Kconfig              | 1 +
>  arch/riscv/include/asm/ftrace.h | 6 ++++++
>  arch/riscv/kernel/mcount-dyn.S  | 4 ++++
>  3 files changed, 11 insertions(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 1d0e5838b11b..2828537abfcd 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -278,6 +278,7 @@ config ARCH_RV64I
>  	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
>  	select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && $(cc-option,-fpatchable-function-entry=8)
>  	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
> +	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>  	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
>  	select HAVE_FUNCTION_GRAPH_TRACER
>  	select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPTION

Please sort new entries here in alphabetical order, so move the new
entry up by one line :)

Thanks,
Conor.

