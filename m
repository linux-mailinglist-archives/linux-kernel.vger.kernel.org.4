Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A384690BA5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 15:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjBIOYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 09:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjBIOYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:24:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D627FCC1A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 06:24:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 717D761A8E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 14:24:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1964C433EF;
        Thu,  9 Feb 2023 14:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675952657;
        bh=WliqAoCSkXd3TVn+JbfmJDY7uNzvOuBthAf1W1wgqtc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U4MlkBzu2n/VaLtW6P/GVJt0RaI98t1CFTSVMwzaZP8B0wCIE8pHr69/7Jex4l1NT
         rIbRKreCKev815PM+WEZJ7S3aJ1kdVI+bUH0r3PiIBIGdzEjI+jEljgbiP2yvK46eZ
         XrWkdsSIMINYwd15K0nRQnZPAMYyYYo0VivBg/YI1/OXOWpadsNd2Bg6fldurkRB5N
         Ebmn5umMe6ZAz+hjHxOGv3vwP3gzGFvhOA2cMt+a1wBmF61OdPKtJ6yb9qDxJyW7jo
         M1HaWNYLPMpaYEZKv9mU5LfmtckB1m4pAm78RN99ct6MFZiCXpQ2lWn1fhKJFn0rb7
         8korRJ87rSHSQ==
Date:   Thu, 9 Feb 2023 23:24:12 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] x86/kprobes: Fix 1 byte conditional jump target
Message-Id: <20230209232412.e0d74dde0bd47f4fb1314144@kernel.org>
In-Reply-To: <20230208071708.4048-1-namit@vmware.com>
References: <20230208071708.4048-1-namit@vmware.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  8 Feb 2023 07:17:08 +0000
Nadav Amit <nadav.amit@gmail.com> wrote:

> From: Nadav Amit <namit@vmware.com>
> 
> Commit 3bc753c06dd0 ("kbuild: treat char as always unsigned") broke
> kprobes.  Setting a probe-point on 1 byte conditional jump can cause the
> kernel to crash, as the branch target is not sign-extended and instead
> zero-extended.
> 
> In fact, there is no need for any casting of immediate.value since sign
> extension is already done during its decoding in insn_get_immediate().
> 
> Fix by removing the casting of the 1 byte conditional jump target.
> Future patches can also remove the casting (and sign extension) in other
> cases in which immediate.value is being used.
> 
> Fixes: 3bc753c06dd0 ("kbuild: treat char as always unsigned")
> Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Suggested-by: Dave Hansen <dave.hansen@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Nadav Amit <namit@vmware.com>

Thanks, looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>


> 
> ---
> 
> v1->v2: Removing the casting completely [Dave]
> ---
>  arch/x86/kernel/kprobes/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index b36f3c367cb2..695873c0f50b 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -625,7 +625,7 @@ static int prepare_emulation(struct kprobe *p, struct insn *insn)
>  		/* 1 byte conditional jump */
>  		p->ainsn.emulate_op = kprobe_emulate_jcc;
>  		p->ainsn.jcc.type = opcode & 0xf;
> -		p->ainsn.rel32 = *(char *)insn->immediate.bytes;
> +		p->ainsn.rel32 = insn->immediate.value;
>  		break;
>  	case 0x0f:
>  		opcode = insn->opcode.bytes[1];
> -- 
> 2.34.1
> 

Nadav
-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
