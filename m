Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB24C5E90A3
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 03:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiIYBXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 21:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiIYBXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 21:23:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19371260D
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 18:23:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3794B80E1C
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 01:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5947AC433D6;
        Sun, 25 Sep 2022 01:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664068993;
        bh=CVQMvErdFLaHjzW/3HPZGHlLkb8jsIT7WcB1p3YNyNA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f9s0J51kpvlIJ18/6ePq40kpqXw1IRaQhWsuLWkVT074PX5P2q63Z8hekIN6B9wAz
         EJK+Og0UoQ/49VTKTzKNosJg3I5ouC3gNgjuAI5EeP+bOC7uKkRp37tPGrGSigzq8s
         yuh/UMziqEBxkpPsT9diDILg0BnxZylz/xmcFSKKf9rcVxGZ8ADlz8APAcDwlonuQS
         ga2tQ+44gojb8d+He+40+xBCxWrJgzYljJcskV1FEBkXpSqg4HboMnFq7iB/MruEgg
         OtQ39pXJjulZnq7PB6mnfMh72OpPRGtqJDMBMOyNPQGjFUydvvCNPrKw8qKYpTK0z0
         eo1XQKJxk8+3A==
Date:   Sun, 25 Sep 2022 10:23:08 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <mhiramat@kernel.org>,
        <jpoimboe@kernel.org>, <rostedt@goodmis.org>,
        <peterz@infradead.org>, <namit@vmware.com>
Subject: Re: [PATCH -next] x86: kprobes: Remove unused macro stack_addr
Message-Id: <20220925102308.96ed6863020cfbebd69223ee@kernel.org>
In-Reply-To: <20220924072629.104759-1-chenzhongjin@huawei.com>
References: <20220924072629.104759-1-chenzhongjin@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Sep 2022 15:26:29 +0800
Chen Zhongjin <chenzhongjin@huawei.com> wrote:

> An unused macro reported by [-Wunused-macros].
> 
> This macro is used to access the sp in pt_regs because at that time
> x86_32 can only get sp by kernel_stack_pointer(regs).
> 
> '3c88c692c287 ("x86/stackframe/32: Provide consistent pt_regs")'
> This commit have unified the pt_regs and from them we can get sp from
> pt_regs with regs->sp easily. Nowhere is using this macro anymore.
> 
> Refrencing pt_regs directly is more clear. Remove this macro for
> code cleaning.

Thanks for the clean up!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> 
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> ---
>  arch/x86/kernel/kprobes/core.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index 4c3c27b6aea3..eb8bc82846b9 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -59,8 +59,6 @@
>  DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
>  DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
>  
> -#define stack_addr(regs) ((unsigned long *)regs->sp)
> -
>  #define W(row, b0, b1, b2, b3, b4, b5, b6, b7, b8, b9, ba, bb, bc, bd, be, bf)\
>  	(((b0##UL << 0x0)|(b1##UL << 0x1)|(b2##UL << 0x2)|(b3##UL << 0x3) |   \
>  	  (b4##UL << 0x4)|(b5##UL << 0x5)|(b6##UL << 0x6)|(b7##UL << 0x7) |   \
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
