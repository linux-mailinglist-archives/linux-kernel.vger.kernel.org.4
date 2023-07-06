Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7455F749DEB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjGFNit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbjGFNiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:38:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE991BC8;
        Thu,  6 Jul 2023 06:38:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D71B6194B;
        Thu,  6 Jul 2023 13:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31BB2C433C7;
        Thu,  6 Jul 2023 13:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688650708;
        bh=PEkRhv1COHtz8x54hPw4xiGamOn/+BE55P4s5TpOgcI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MsNYZj5TEZvgLuORchg6awRz5nUDhNVxV8lGOGDJQ8mulpC8STRLln6uNidO8mloy
         ULu0ghqNjLQ/d1IRyj59RMPEUvVTwMgBS4Yn9E0B6oXh2opVsod626QQtjaNG1YoTB
         O+8Q9kDc033DBa0Oi76NnY4dZx7DI9dd+jci0szZwb82Y0L8lPduoVjXmZvkT4GP2w
         JOgkrjSf0p1DpT+1UYiBbHkpNBMO7YQCuRay+bV0qdnySCopIl49yntKAQajorxW7m
         UyDcRcB/DoRRlNoIH9T9LHwii1trLNDerdKWEJn5k37Zjd8rTyU0Nb3aEU7T9aVA+B
         fG+baaxsdsGxw==
Date:   Thu, 6 Jul 2023 22:38:24 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Li zeming <zeming@nfschina.com>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: Remove unnecessary =?UTF-8?B?4oCYTlVMTA==?=
 =?UTF-8?B?4oCZ?= values from correct_ret_addr
Message-Id: <20230706223824.f1eee3b3e5448dc3555c275d@kernel.org>
In-Reply-To: <20230704194359.3124-1-zeming@nfschina.com>
References: <20230704194359.3124-1-zeming@nfschina.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  5 Jul 2023 03:43:59 +0800
Li zeming <zeming@nfschina.com> wrote:

> The 'correct_ret_addr' pointer is always set in the later code, no need
> to initialize it at definition time.

Indeed. Thanks!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> 
> Signed-off-by: Li zeming <zeming@nfschina.com>
> ---
>  kernel/kprobes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index db8a3aa53cf6..ec50f9f380c1 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2007,9 +2007,9 @@ void __weak arch_kretprobe_fixup_return(struct pt_regs *regs,
>  unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
>  					     void *frame_pointer)
>  {
> -	kprobe_opcode_t *correct_ret_addr = NULL;
>  	struct kretprobe_instance *ri = NULL;
>  	struct llist_node *first, *node = NULL;
> +	kprobe_opcode_t *correct_ret_addr;
>  	struct kretprobe *rp;
>  
>  	/* Find correct address and all nodes for this frame. */
> -- 
> 2.18.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
