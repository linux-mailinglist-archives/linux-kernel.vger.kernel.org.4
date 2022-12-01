Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B8763FA90
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiLAWaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiLAWaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:30:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F677BE68B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 14:30:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C06C62155
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 22:30:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41235C433D6;
        Thu,  1 Dec 2022 22:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669933806;
        bh=crrTc4BB/TtAj4Jcr6fAdCXapLSJT2myUcnrxQqhsxw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DiwWOZnUh01DUktGLOI2LDw3VYpfaUR8WcL8tjRSlOQa1/qDEwnGy62kaOBNwha1Q
         lgkZMxfiZL/MxjYJ5yuXuCYgDDz80stz2WSEw17airtXhXOxLuscLYvn4jL8JlsJao
         4Ph22cLapRGX1f/ap32wVeCuPurh5ZN/jn71wzi8Gmh+BrrrkSoWS0zKcpI8MwaSwj
         XVl+7xPBbCZyCpFOjztIEFNDc9XyDbHdwUkSaVTRysKKBj/AaN3SS1X3VdIQ+pEsR+
         CR7F/swKDHbzPO/NOr000tI3GmglIjg+vfGQTna4symSAgRJkF5XkAm4HV78aIfmZh
         K/l1lZa2+KBtw==
Date:   Fri, 2 Dec 2022 07:30:02 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Seiji Nishikawa <snishika@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes/x86: allow to probe a "nop" insn with 0x66
 prefix
Message-Id: <20221202073002.cae85d5ff0c80b1a3b8b67b4@kernel.org>
In-Reply-To: <20221201142644.GA27185@redhat.com>
References: <20221201142644.GA27185@redhat.com>
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

On Thu, 1 Dec 2022 15:26:44 +0100
Oleg Nesterov <oleg@redhat.com> wrote:

> From: Denys Vlasenko <dvlasenk@redhat.com>
> 
> Intel icc -hotpatch inserts 2-byte "0x66 0x90" NOP at the start of each
> function to reserve extra space for hot-patching, and currently it is not
> possible to probe these functions because branch_setup_xol_ops() wrongly
> nacks NOP with REP prefix.

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> 
> Fixes: 250bbd12c2fe ("uprobes/x86: Refuse to attach uprobe to "word-sized" branch insns")
> Reported-by: Seiji Nishikawa <snishika@redhat.com>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  arch/x86/kernel/uprobes.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index b63cf8f7745e..6c07f6daaa22 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -722,8 +722,9 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
>  	switch (opc1) {
>  	case 0xeb:	/* jmp 8 */
>  	case 0xe9:	/* jmp 32 */
> -	case 0x90:	/* prefix* + nop; same as jmp with .offs = 0 */
>  		break;
> +	case 0x90:	/* prefix* + nop; same as jmp with .offs = 0 */
> +		goto setup;
>  
>  	case 0xe8:	/* call relative */
>  		branch_clear_offset(auprobe, insn);
> @@ -753,6 +754,7 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
>  			return -ENOTSUPP;
>  	}
>  
> +setup:
>  	auprobe->branch.opc1 = opc1;
>  	auprobe->branch.ilen = insn->length;
>  	auprobe->branch.offs = insn->immediate.value;
> -- 
> 2.25.1.362.g51ebf55
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
