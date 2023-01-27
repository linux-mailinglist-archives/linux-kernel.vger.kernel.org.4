Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D637967E474
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbjA0MDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbjA0MCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:02:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAC92A9B5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:58:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC89B61B48
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CC0C433EF;
        Fri, 27 Jan 2023 11:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674820245;
        bh=yg7LVjF/Sxi7pRws/+ezLgbUiexQuVEylBV9Ln2+OZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fIsy9043QSVE0+qZwwPJD86MLjYhe5Vl7AcvAzBQ7tCcVq3TxiJo2HUMywupE3z59
         H1iTpcLQIDEDFGmXNkmfMrnlbCzmiNQLLmYeZvtHBkxpxLeBy88FzMv57J8P7Od0wt
         XovcKlayuFatPnOVBVgcWSZHD6DxFcpwLupGojlCdx2qg5lsvYt6wh/08nYYTMZpLO
         Cl9P0pAr8x+JOdHdu0cxbbU8VOXTInmxp7N9fkXoWHh6Yr4N3/V+OCA/E4pKk3Qy9Z
         QKsa9pTT0pJbOIrtpPi24mk3HW3Rc5KHK4sLcoZ0A4sLzaBBk0rcmQTQ5QolgtdeN4
         nQp+VmQkV8r5w==
Date:   Fri, 27 Jan 2023 11:50:39 +0000
From:   Will Deacon <will@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     catalin.marinas@arm.com, mark.rutland@arm.com,
        daniel.thompson@linaro.org, dianders@chromium.org,
        liwei391@huawei.com, mhiramat@kernel.org, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] arm64: kgdb: Set PSTATE.SS to 1 to re-enable
 single-step
Message-ID: <20230127115039.GA30505@willie-the-truck>
References: <20221219102452.2860088-1-sumit.garg@linaro.org>
 <20221219102452.2860088-3-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219102452.2860088-3-sumit.garg@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 03:54:52PM +0530, Sumit Garg wrote:
> Currently only the first attempt to single-step has any effect. After
> that all further stepping remains "stuck" at the same program counter
> value.
> 
> Refer to the ARM Architecture Reference Manual (ARM DDI 0487E.a) D2.12,
> PSTATE.SS=1 should be set at each step before transferring the PE to the
> 'Active-not-pending' state. The problem here is PSTATE.SS=1 is not set
> since the second single-step.
> 
> After the first single-step, the PE transferes to the 'Inactive' state,
> with PSTATE.SS=0 and MDSCR.SS=1, thus PSTATE.SS won't be set to 1 due to
> kernel_active_single_step()=true. Then the PE transferes to the
> 'Active-pending' state when ERET and returns to the debugger by step
> exception.
> 
> Before this patch:
> ==================
> Entering kdb (current=0xffff3376039f0000, pid 1) on processor 0 due to Keyboard Entry
> [0]kdb>
> 
> [0]kdb>
> [0]kdb> bp write_sysrq_trigger
> Instruction(i) BP #0 at 0xffffa45c13d09290 (write_sysrq_trigger)
>     is enabled   addr at ffffa45c13d09290, hardtype=0 installed=0
> 
> [0]kdb> go
> $ echo h > /proc/sysrq-trigger
> 
> Entering kdb (current=0xffff4f7e453f8000, pid 175) on processor 1 due to Breakpoint @ 0xffffad651a309290
> [1]kdb> ss
> 
> Entering kdb (current=0xffff4f7e453f8000, pid 175) on processor 1 due to SS trap @ 0xffffad651a309294
> [1]kdb> ss
> 
> Entering kdb (current=0xffff4f7e453f8000, pid 175) on processor 1 due to SS trap @ 0xffffad651a309294
> [1]kdb>
> 
> After this patch:
> =================
> Entering kdb (current=0xffff6851c39f0000, pid 1) on processor 0 due to Keyboard Entry
> [0]kdb> bp write_sysrq_trigger
> Instruction(i) BP #0 at 0xffffc02d2dd09290 (write_sysrq_trigger)
>     is enabled   addr at ffffc02d2dd09290, hardtype=0 installed=0
> 
> [0]kdb> go
> $ echo h > /proc/sysrq-trigger
> 
> Entering kdb (current=0xffff6851c53c1840, pid 174) on processor 1 due to Breakpoint @ 0xffffc02d2dd09290
> [1]kdb> ss
> 
> Entering kdb (current=0xffff6851c53c1840, pid 174) on processor 1 due to SS trap @ 0xffffc02d2dd09294
> [1]kdb> ss
> 
> Entering kdb (current=0xffff6851c53c1840, pid 174) on processor 1 due to SS trap @ 0xffffc02d2dd09298
> [1]kdb> ss
> 
> Entering kdb (current=0xffff6851c53c1840, pid 174) on processor 1 due to SS trap @ 0xffffc02d2dd0929c
> [1]kdb>
> 
> Fixes: 44679a4f142b ("arm64: KGDB: Add step debugging support")
> Co-developed-by: Wei Li <liwei391@huawei.com>
> Signed-off-by: Wei Li <liwei391@huawei.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> Tested-by: Douglas Anderson <dianders@chromium.org>
> ---
>  arch/arm64/include/asm/debug-monitors.h | 1 +
>  arch/arm64/kernel/debug-monitors.c      | 5 +++++
>  arch/arm64/kernel/kgdb.c                | 2 ++
>  3 files changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
> index 7b7e05c02691..ce3875ad5cd3 100644
> --- a/arch/arm64/include/asm/debug-monitors.h
> +++ b/arch/arm64/include/asm/debug-monitors.h
> @@ -104,6 +104,7 @@ void user_regs_reset_single_step(struct user_pt_regs *regs,
>  void kernel_enable_single_step(struct pt_regs *regs);
>  void kernel_disable_single_step(void);
>  int kernel_active_single_step(void);
> +void kernel_regs_reset_single_step(struct pt_regs *regs);
>  
>  #ifdef CONFIG_HAVE_HW_BREAKPOINT
>  int reinstall_suspended_bps(struct pt_regs *regs);
> diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
> index 3da09778267e..9af898b22ed4 100644
> --- a/arch/arm64/kernel/debug-monitors.c
> +++ b/arch/arm64/kernel/debug-monitors.c
> @@ -438,6 +438,11 @@ int kernel_active_single_step(void)
>  }
>  NOKPROBE_SYMBOL(kernel_active_single_step);
>  
> +void kernel_regs_reset_single_step(struct pt_regs *regs)
> +{
> +	set_regs_spsr_ss(regs);
> +}

Just a nit on the naming here, but please can this be
kernel_rewind_single_step() instead? I think it's closer to the rewind
function we have for user tasks than the reset function.

Cheers,

Will
