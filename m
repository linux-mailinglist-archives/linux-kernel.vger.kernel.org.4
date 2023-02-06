Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF67568BFE0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjBFOSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjBFOSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:18:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A55271F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 06:18:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC60260F00
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 14:18:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D84C433EF;
        Mon,  6 Feb 2023 14:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675693109;
        bh=N0jlMsP1a2pFkwKypT6oJ/20U4sMLM/W0F/2lPeQtH8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KyQCMI370m77ZFJVsLt4vh91v8swcCjpfKYfTyb4Tz8MzTaS5yF/MGnh8W93SoK/r
         LQ19aVaCKU7AKrAkrgEIi+an++7Z6vSqrEOgEgKgEleC6F/PnL/mkdrfflOBqiDXxh
         a6k1eNGlCTeJ1Rs20nxB3dh2MksWlPeqLZcNWs1sr5VN/8rQFor9DG7oUj0K4p5ry6
         HN+S7wrC65E2nSHUiAnjBgOCLfjFhKi057H+NuW+DBgL1kjXGavol0C4pOGpfcXnlt
         iVoq209YXW1oMGRglGmrpplimHaqfFShhvW5uGk5hd3RNJin56keFDn60krgE5cdWg
         ATQ71xDejZ8xQ==
Date:   Mon, 6 Feb 2023 23:18:25 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86/kprobes: Fix 1 byte conditional jump target
Message-Id: <20230206231825.9997d73ded8497df9006585d@kernel.org>
In-Reply-To: <20230204210807.3930-1-namit@vmware.com>
References: <20230204210807.3930-1-namit@vmware.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  4 Feb 2023 21:08:07 +0000
Nadav Amit <nadav.amit@gmail.com> wrote:

> From: Nadav Amit <namit@vmware.com>
> 
> Commit 3bc753c06dd0 ("kbuild: treat char as always unsigned") broke
> kprobes.  Setting a probe-point on 1 byte conditional jump can cause the
> kernel to crash, as the branch target is not sign extended.

Oops, indeed!

> 
> Fix by using s8 instead of char and use immediate.value instead of
> immediate.bytes for consistency.

Looks good to me. Thanks for finding this bug!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Fixes: 3bc753c06dd0 ("kbuild: treat char as always unsigned")

Thank you!
> 
> Cc: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  arch/x86/kernel/kprobes/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index b36f3c367cb2..6a56d56b3817 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -625,7 +625,7 @@ static int prepare_emulation(struct kprobe *p, struct insn *insn)
>  		/* 1 byte conditional jump */
>  		p->ainsn.emulate_op = kprobe_emulate_jcc;
>  		p->ainsn.jcc.type = opcode & 0xf;
> -		p->ainsn.rel32 = *(char *)insn->immediate.bytes;
> +		p->ainsn.rel32 = *(s8 *)&insn->immediate.value;
>  		break;
>  	case 0x0f:
>  		opcode = insn->opcode.bytes[1];
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
