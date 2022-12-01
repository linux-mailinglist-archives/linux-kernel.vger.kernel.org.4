Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F4C63F8E0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 21:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbiLAUQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 15:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiLAUP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 15:15:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A0CBF659
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 12:15:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C4846210F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 20:15:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9FFC433D6;
        Thu,  1 Dec 2022 20:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669925752;
        bh=vVCfhscBzI9hn0s5h73jc2HuArjB4WLayXOmvKzLUo4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sfskE8PqGZAE0YG11Edae4n8y4yWSGcNRmmu1azjGMUZLqBzNWIuh9gs2rLPEUwn3
         mWFDLZtbpnoT181NqZB6ZxAQajpEk6nXI+zJihxAecgvMGnT7kCQGOZYj7I4egm5VK
         7/X7zOyOnH9tnWdb3OhbwVFH82y8u3/wz72kZWXTp9bzZx5OiU3Gdwp8K/ClkcG3Si
         US4hWWCYF/cpmd2SCt74dK8A239FzO9BOlyOJa6uUm9lit+9oPQG6Q0dkRvf3xNViW
         I8wwd7uCEut4eToKMajbE9s7FmU0BquA/BoziUayCUzZ+PG++Q75e7Dw308qqRMum/
         kD6mJMeAmcAWg==
Date:   Thu, 1 Dec 2022 20:15:46 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     guoren@kernel.org, anup@brainfault.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>, heiko@sntech.de,
        rostedt@goodmis.org, mhiramat@kernel.org, jolsa@redhat.com,
        bp@suse.de, jpoimboe@kernel.org, suagrfillet@gmail.com,
        andy.chiu@sifive.com, mark.rutland@arm.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 6/7] riscv: ftrace: Add
 DYNAMIC_FTRACE_WITH_DIRECT_CALLS support
Message-ID: <Y4kLcgp4Oas6P3UG@spud>
References: <Y4kIcGY0rXTGb3po@spud>
 <mhng-2612202a-d3bf-4b2b-9b8b-df67b38b5315@palmer-ri-x1c9a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-2612202a-d3bf-4b2b-9b8b-df67b38b5315@palmer-ri-x1c9a>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 12:06:39PM -0800, Palmer Dabbelt wrote:
> On Thu, 01 Dec 2022 12:02:56 PST (-0800), Conor Dooley wrote:
> > On Mon, Nov 28, 2022 at 10:32:29PM -0500, guoren@kernel.org wrote:
> > > From: Song Shuai <suagrfillet@gmail.com>
> > > 
> > > This patch adds DYNAMIC_FTRACE_WITH_DIRECT_CALLS support for RISC-V.
> > > 
> > > select the DYNAMIC_FTRACE_WITH_DIRECT_CALLS to provide the
> > > register_ftrace_direct[_multi] interfaces allowing users to register
> > > the customed trampoline (direct_caller) as the mcount for one or
> > > more target functions. And modify_ftrace_direct[_multi] are also
> > > provided for modifying direct_caller.
> > > 
> > > To make the direct_caller and the other ftrace hooks (eg. function/fgraph
> > > tracer, k[ret]probes) co-exist, a temporary register is nominated to
> > > store the address of direct_caller in ftrace_regs_caller. After the
> > > setting of the address direct_caller by direct_ops->func and the
> > > RESTORE_REGS in ftrace_regs_caller, direct_caller will be jumped to
> > > by the `jr` inst.
> > > 
> > > Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> > > Tested-by: Guo Ren <guoren@kernel.org>
> > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > ---
> > >  arch/riscv/Kconfig              | 1 +
> > >  arch/riscv/include/asm/ftrace.h | 6 ++++++
> > >  arch/riscv/kernel/mcount-dyn.S  | 4 ++++
> > >  3 files changed, 11 insertions(+)
> > > 
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index 1d0e5838b11b..2828537abfcd 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -278,6 +278,7 @@ config ARCH_RV64I
> > >  	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
> > >  	select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && $(cc-option,-fpatchable-function-entry=8)
> > >  	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
> > > +	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> > >  	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
> > >  	select HAVE_FUNCTION_GRAPH_TRACER
> > >  	select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPTION
> > 
> > Please sort new entries here in alphabetical order, so move the new
> > entry up by one line :)
> 
> IIRC whomever sorted these entrties orignially posted a script that does
> that.  Maybe that should be integrated into either checkpatch or one of the
> patchwork robots so we don't have to manually remember the alphabet?

If it actually does *sorting* I am not sure it's a suitable inclusion
as-is that'd seem better as a pre-commit hook. But maybe it can be
co-opted somehow. I'll try to dig it up off of lore tomorrow.

Thanks,
Conor.

