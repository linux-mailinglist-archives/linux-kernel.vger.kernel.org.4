Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872DE6AB4A3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 03:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjCFCak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 21:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjCFCai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 21:30:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342AAF770
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 18:30:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B108A60B7A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 02:30:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C654C433D2;
        Mon,  6 Mar 2023 02:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678069833;
        bh=V64I46ZzY7Dh4P52BU7PgFz03pVtaYG+gG+pc48SyKI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MWl27Q2AYfMk/NKe94szJ923hPfE/qHk/irh5Q79iHGALLJjj/4U7LIsjw3NCsvJ1
         0aubf+6gGnFag9WexDZHqBvz8F11O9EjyEe6mxMGIQdaRsaEJBXL2XXTH4jm9TwlVO
         W/unJlXC7zRTmFh1qp8I/1vk75xmtJdanHGL3g+c6L+jtajaADgTKlWD8R/fd5LSQr
         RPFKnGAq/Ckp1jvLa82bRy0lAv/rHkhFvFWQkZdmwdhF+T0c7seWDDxuvmJ3xLKK2c
         eFUnJDjQtZ5y3gHmOPE/D5OmY3CbDYetrzWFM8YP55vto/gU7w6H5lYBj6pbzxQMkT
         GgGhZtIj1Olig==
Date:   Mon, 6 Mar 2023 11:30:28 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, yangjihong1@huawei.com,
        ast@kernel.org, peterz@infradead.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/kprobes: remove extern from
 arch_unoptimized_kprobes
Message-Id: <20230306113028.8b36416af9f22805e5c2a46d@kernel.org>
In-Reply-To: <20230304141544.1936934-1-trix@redhat.com>
References: <20230304141544.1936934-1-trix@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  4 Mar 2023 09:15:44 -0500
Tom Rix <trix@redhat.com> wrote:

> smatch reports
> arch/x86/kernel/kprobes/opt.c:537:13: warning:
>   function 'arch_unoptimize_kprobes' with external linkage has definition
> 
> extern is only needed in a declaration, so remove it.

Thanks for pointing it out! This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks, 

> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  arch/x86/kernel/kprobes/opt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
> index 57b0037d0a99..1e699deb77fe 100644
> --- a/arch/x86/kernel/kprobes/opt.c
> +++ b/arch/x86/kernel/kprobes/opt.c
> @@ -534,8 +534,8 @@ void arch_unoptimize_kprobe(struct optimized_kprobe *op)
>   * Recover original instructions and breakpoints from relative jumps.
>   * Caller must call with locking kprobe_mutex.
>   */
> -extern void arch_unoptimize_kprobes(struct list_head *oplist,
> -				    struct list_head *done_list)
> +void arch_unoptimize_kprobes(struct list_head *oplist,
> +			     struct list_head *done_list)
>  {
>  	struct optimized_kprobe *op, *tmp;
>  
> -- 
> 2.27.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
