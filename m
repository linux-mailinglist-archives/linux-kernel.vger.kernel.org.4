Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96503613E0E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiJaTMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 15:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiJaTME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:12:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBCB1181E;
        Mon, 31 Oct 2022 12:12:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C817EB81A02;
        Mon, 31 Oct 2022 19:12:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1926C433D6;
        Mon, 31 Oct 2022 19:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667243521;
        bh=yOLlW4b3WOWWf4x3j0sTzOFLrIjxCJoh5lRv8XuHQX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T6+KBsQAKIWoX9OhQwvZEA8O7d6lcTQ0zQivckZkAi8YXxmX2M7GlEwhaTDEE2I8j
         mWOEP5MV4yvJTHJFV048SCifQSLH2CWdqXWe0kZc3d64BaDL6lCURlM7LeIbtRzW1l
         ztNodA+LNLKLQgJHoejf04w+uKENE1lwuraAFzTsA6fAd/jwBly88jQLnLWLDBmS5n
         IXme8eckTS5ZsZ3XKteuztI5FMlqMGWlguzKemc2gPadwn1Xg88jiNUgLqzDxUs2AE
         b20JNxI1MTcxxCsIK6sLwfHEgbANCV3j8kcy4Q4OiLXDk7tThS36o4V35PqABCN6y1
         6J5O31R7jAz5Q==
Date:   Mon, 31 Oct 2022 19:11:56 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Atish Patra <atishp@rivosinc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] RISC-V: Do not issue remote fences until smp is available
Message-ID: <Y2Ad/FaLE5qM01gR@spud>
References: <20221028231929.347918-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028231929.347918-1-atishp@rivosinc.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 04:19:29PM -0700, Atish Patra wrote:
> It is useless to issue remote fences if there is a single core
> available. It becomes a bottleneck for sbi based rfences where
> we will be making those ECALLs for no reason. Early code patching
> because of static calls end up in this path.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Hey Atish,
This doesn't apply for me to either fixes or for-next. What branch does
it apply to?
Thanks,
Conor.

> ---
>  arch/riscv/mm/cacheflush.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> index f10cb47eac3a..7fafc8c26505 100644
> --- a/arch/riscv/mm/cacheflush.c
> +++ b/arch/riscv/mm/cacheflush.c
> @@ -19,6 +19,10 @@ void flush_icache_all(void)
>  {
>  	local_flush_icache_all();
>  
> +	/* No need to issue remote fence if only 1 cpu is online */
> +	if (num_online_cpus() == 1)
> +		return;
> +
>  	if (IS_ENABLED(CONFIG_RISCV_SBI) && !riscv_use_ipi_for_rfence())
>  		sbi_remote_fence_i(NULL);
>  	else
> -- 
> 2.34.1
> 
