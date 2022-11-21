Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46675632E7E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 22:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiKUVKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 16:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiKUVKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 16:10:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CC2C661B;
        Mon, 21 Nov 2022 13:10:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7432612AE;
        Mon, 21 Nov 2022 21:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF947C433D6;
        Mon, 21 Nov 2022 21:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669065044;
        bh=wgXhA1V/D2pb+oIfFK+cZa9q7Str/LyaiLVk1+km9N4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aR/tdGKg39lLzLyQ3fFu6wbyWzr+0SwXrkUD/GH3de+xT26VuBfQLFFAPxZWhw/dK
         H+Ks83eBhTlR79ktC9EdrIfQ35RVhmrrGMxTE43Mi7w8OCmTarbSJPWCfS0cvZH6al
         AJEmfVPR3AuquPRs9jYK9jTPfG5r3TD1WDpkecNsYmgkqOZ4oTRl4BHQ/ftQknKenk
         TjjLBwb2cA+EfJ9jcIKpA1od75+lideVx4XZnmF2qS/CIsf0vlwpSJQtnIFAIPzwNX
         FIo2T1aTVkfAIqC19HIIMV+x8qoUeBsRZso//LGCvsSivdzSy41Co5ep65rWEaU8S6
         P4CJIeC5Jhbhg==
Date:   Mon, 21 Nov 2022 21:10:39 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     anup@brainfault.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux@rivosinc.com
Subject: Re: [PATCH] cpuidle: riscv-sbi: Stop using non-retentive suspend
Message-ID: <Y3vpT2XoylY4i2kx@spud>
References: <20221121205647.23343-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121205647.23343-1-palmer@rivosinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 12:56:47PM -0800, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> As per [1], whether or not the core can wake up from non-retentive
> suspend is a platform-specific detail.  We don't have any way to encode
> that, so just stop using them until we've sorted that out.

For anyone playing along at home, Anup had a proposal for encoding this
information (yoinked from the GH issue below):
https://lore.kernel.org/all/20220727114302.302201-1-apatel@ventanamicro.com/> 

> Link: https://github.com/riscv-non-isa/riscv-sbi-doc/issues/98#issuecomment-1288564687
> Fixes: 6abf32f1d9c5 ("cpuidle: Add RISC-V SBI CPU idle driver")
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> ---
> 
> This should allow us to revert 232ccac1bd9b ("clocksource/drivers/riscv:
> Events are stopped during CPU suspend"), which fixes suspend on the D1
> but breaks timers everywhere.

FWIW the revert is at:
https://lore.kernel.org/linux-riscv/20221023185444.678573-1-conor@kernel.org/

Commit message is probably a little lacking as I didn't understand the
problem when I wrote it. I'll respin the revert with a tidier message
tomorrow.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  drivers/cpuidle/cpuidle-riscv-sbi.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
> index 05fe2902df9a..9d1063a54495 100644
> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> @@ -214,6 +214,17 @@ static bool sbi_suspend_state_is_valid(u32 state)
>  	if (state > SBI_HSM_SUSPEND_NON_RET_DEFAULT &&
>  	    state < SBI_HSM_SUSPEND_NON_RET_PLATFORM)
>  		return false;
> +
> +	/*
> +	 * Whether or not RISC-V systems deliver interrupts to harts in a
> +	 * non-retentive suspend state is a platform-specific detail.  This can
> +	 * leave the hart unable to wake up, so just mark these states as
> +	 * unsupported until we have a mechanism to expose these
> +	 * platform-specific details to Linux.
> +	 */
> +	if (state & SBI_HSM_SUSP_NON_RET_BIT)
> +		return false;
> +
>  	return true;
>  }
>  
> -- 
> 2.38.1
> 
