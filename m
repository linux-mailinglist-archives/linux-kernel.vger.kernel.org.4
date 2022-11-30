Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C9363D6E8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 14:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbiK3Nii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 08:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiK3Nia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 08:38:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377222E6BF
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 05:38:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B595761BF2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 13:38:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BF2C433D6;
        Wed, 30 Nov 2022 13:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669815499;
        bh=jw+awRGtgAZKGubWrz02rHawUZJ43c/ZqUDs43or8tI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fFkq7BVurt14DpUJg5zr+OW1tB7uUyAHvmDFfvbV5ken2SYrRNMBgu2K4znbWbwY2
         eMBxxVXzSyZbLaE7AO8oq8/C2xIPwdeW2zmFZbmB6r5i5uAwm2b4TE43TXUEFUEKXg
         6Y3MD6026UeiRb2D+iLZbvU5r2MrX1F+ueSeTIs/Ee13E0JOJMKuBPWAQ+vVpIByoS
         Dbb84OQw9nWcCRbW3umDu+MY0XMOWWSN182fChctJYSQ2cccl/UxcdGge9xO/cPQ7p
         xMXgx7hbotjZMuVUtiODrsRERUt9oGUr4idfjDaFtz3gy39frz2nxgHyBHXktZKy11
         EtmpgACOHNKmA==
Date:   Wed, 30 Nov 2022 22:38:14 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Chuang Wang <nashuiliang@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/kprobes: Use switch-case for 0xFF opcodes in
 prepare_emulation
Message-Id: <20221130223814.667999640ad298f843c2aaf2@kernel.org>
In-Reply-To: <20221129084022.718355-1-nashuiliang@gmail.com>
References: <20221129084022.718355-1-nashuiliang@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Nov 2022 16:39:51 +0800
Chuang Wang <nashuiliang@gmail.com> wrote:

> For the `FF /digit` opcodes in prepare_emulation, use switch-case
> instead of hand-written code to make the logic easier to understand.
> 
> Signed-off-by: Chuang Wang <nashuiliang@gmail.com>

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> ---
>  arch/x86/kernel/kprobes/core.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index 66299682b6b7..66ec32b6cd0e 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -655,17 +655,19 @@ static int prepare_emulation(struct kprobe *p, struct insn *insn)
>  		 * is determined by the MOD/RM byte.
>  		 */
>  		opcode = insn->modrm.bytes[0];
> -		if ((opcode & 0x30) == 0x10) {
> -			if ((opcode & 0x8) == 0x8)
> -				return -EOPNOTSUPP;	/* far call */
> -			/* call absolute, indirect */
> +		switch (X86_MODRM_REG(opcode)) {
> +		case 0b010:	/* FF /2, call near, absolute indirect */
>  			p->ainsn.emulate_op = kprobe_emulate_call_indirect;
> -		} else if ((opcode & 0x30) == 0x20) {
> -			if ((opcode & 0x8) == 0x8)
> -				return -EOPNOTSUPP;	/* far jmp */
> -			/* jmp near absolute indirect */
> +			break;
> +		case 0b100:	/* FF /4, jmp near, absolute indirect */
>  			p->ainsn.emulate_op = kprobe_emulate_jmp_indirect;
> -		} else
> +			break;
> +		case 0b011:	/* FF /3, call far, absolute indirect */
> +		case 0b101:	/* FF /5, jmp far, absolute indirect */
> +			return -EOPNOTSUPP;
> +		}
> +
> +		if (!p->ainsn.emulate_op)
>  			break;
>  
>  		if (insn->addr_bytes != sizeof(unsigned long))
> -- 
> 2.37.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
