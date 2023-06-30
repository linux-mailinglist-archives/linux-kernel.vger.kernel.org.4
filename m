Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F448743403
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 07:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjF3FVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 01:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbjF3FVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 01:21:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C192D78;
        Thu, 29 Jun 2023 22:21:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B43D161644;
        Fri, 30 Jun 2023 05:21:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94DB1C433C0;
        Fri, 30 Jun 2023 05:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688102478;
        bh=8Ef5WYOUOB2AfTmhfbQVbF6OgLVgkrEM1qir2bZFwy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F/ThVpgqdR4bTPAGDcwcoqRvSuB7IH0y33T5SYkqhwf8BR/46VvONOeKW34M7qCCR
         xaWzCJd2z7/zX5Wxiq8GukOlK4yBCU5iLX03FvIoFMoUVf8MIFxR9l9Embky0anB8a
         x3WdHqrnpnzBpqo4t/4gWy0mW79VhdWObGSfNB3w=
Date:   Fri, 30 Jun 2023 07:21:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     stable@vger.kernel.org, mhiramat@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        sashal@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, xukuohai@huawei.com
Subject: Re: [PATCH 5.10] kprobes/x86: Fix kprobe debug exception handling
 logic
Message-ID: <2023063039-dotted-improper-7b3c@gregkh>
References: <20230630020845.227939-1-lihuafei1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630020845.227939-1-lihuafei1@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 10:08:45AM +0800, Li Huafei wrote:
> We get the following crash caused by a null pointer access:
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000000
>  ...
>  RIP: 0010:resume_execution+0x35/0x190
>  ...
>  Call Trace:
>   <#DB>
>   kprobe_debug_handler+0x41/0xd0
>   exc_debug+0xe5/0x1b0
>   asm_exc_debug+0x19/0x30
>  RIP: 0010:copy_from_kernel_nofault.part.0+0x55/0xc0
>  ...
>   </#DB>
>   process_fetch_insn+0xfb/0x720
>   kprobe_trace_func+0x199/0x2c0
>   ? kernel_clone+0x5/0x2f0
>   kprobe_dispatcher+0x3d/0x60
>   aggr_pre_handler+0x40/0x80
>   ? kernel_clone+0x1/0x2f0
>   kprobe_ftrace_handler+0x82/0xf0
>   ? __se_sys_clone+0x65/0x90
>   ftrace_ops_assist_func+0x86/0x110
>   ? rcu_nocb_try_bypass+0x1f3/0x370
>   0xffffffffc07e60c8
>   ? kernel_clone+0x1/0x2f0
>   kernel_clone+0x5/0x2f0
> 
> The analysis reveals that kprobe and hardware breakpoints conflict in
> the use of debug exceptions.
> 
> If we set a hardware breakpoint on a memory address and also have a
> kprobe event to fetch the memory at this address. Then when kprobe
> triggers, it goes to read the memory and triggers hardware breakpoint
> monitoring. This time, since kprobe handles debug exceptions earlier
> than hardware breakpoints, it will cause kprobe to incorrectly assume
> that the exception is a kprobe trigger.
> 
> Notice that after the mainline commit 6256e668b7af ("x86/kprobes: Use
> int3 instead of debug trap for single-step"), kprobe no longer uses
> debug trap, avoiding the conflict with hardware breakpoints here. This
> commit is to remove the IRET that returns to kernel, not to fix the
> problem we have here. Also there are a bunch of merge conflicts when
> trying to apply this commit to older kernels, so fixing it directly in
> older kernels is probably a better option.

What is the list of commits that it would take to resolve this in these
kernels?  We would almost always prefer to do that instead of taking
changes that are not upstream.

thanks,

greg k-h
