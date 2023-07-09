Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C18674C1AE
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 11:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjGIJ0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 05:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjGIJ0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 05:26:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2230791;
        Sun,  9 Jul 2023 02:26:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8024460B9E;
        Sun,  9 Jul 2023 09:26:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5183EC433C7;
        Sun,  9 Jul 2023 09:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688894808;
        bh=UwgeWwEsboihw5tgDSb6TTkUJR3cL0ybJK7x9TY9PAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xXsfbj4yFX4S/qBidAnBb5sfOEPTwvkAKOHrCSvbTWZLVtkjCANIRbhXIJvP8JJch
         TClP+54czoVlIJIOlQLIrbwxcn5aXMmD5wNQVM3tQDSOuNkTK+MZtumAn5m/NfQQty
         2B5nc6/h59IQHqbOzZ8G2JPQ8oxo7qR994DKgEY0=
Date:   Sun, 9 Jul 2023 11:26:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     stable-commits@vger.kernel.org, jpoimboe@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Zack Rusin <zackr@vmware.com>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: Patch "drm/vmwgfx: Add unwind hints around RBP clobber" has been
 added to the 6.4-stable tree
Message-ID: <2023070929-crayon-pronto-8b3c@gregkh>
References: <20230709050310.433132-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230709050310.433132-1-sashal@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2023 at 01:03:10AM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     drm/vmwgfx: Add unwind hints around RBP clobber
> 
> to the 6.4-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      drm-vmwgfx-add-unwind-hints-around-rbp-clobber.patch
> and it can be found in the queue-6.4 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit aeb6b7c6b6ef84ab496189cdbc698426092aa46c
> Author: Josh Poimboeuf <jpoimboe@kernel.org>
> Date:   Mon Jun 5 09:12:22 2023 -0700
> 
>     drm/vmwgfx: Add unwind hints around RBP clobber
>     
>     [ Upstream commit a9da8247627eefc73f909bf945031a5431a53993 ]
>     
>     VMware high-bandwidth hypercalls take the RBP register as input.  This
>     breaks basic frame pointer convention, as RBP should never be clobbered.
>     
>     So frame pointer unwinding is broken for the instructions surrounding
>     the hypercalls.  Fortunately this doesn't break live patching with
>     CONFIG_FRAME_POINTER, as it only unwinds from blocking tasks, and stack
>     traces from preempted tasks are already marked unreliable anyway.
>     
>     However, for live patching with ORC, this could actually be a
>     theoretical problem if vmw_port_hb_{in,out}() were still compiled with a
>     frame pointer due to having an aligned stack.  In practice that hasn't
>     seemed to be an issue since the objtool warnings have only been seen
>     with CONFIG_FRAME_POINTER.
>     
>     Add unwind hint annotations to tell the ORC unwinder to mark stack
>     traces as unreliable.
>     
>     Fixes the following warnings:
>     
>       vmlinux.o: warning: objtool: vmw_port_hb_in+0x1df: return with modified stack frame
>       vmlinux.o: warning: objtool: vmw_port_hb_out+0x1dd: return with modified stack frame
>     
>     Fixes: 89da76fde68d ("drm/vmwgfx: Add VMWare host messaging capability")
>     Reported-by: kernel test robot <lkp@intel.com>
>     Link: https://lore.kernel.org/oe-kbuild-all/202305160135.97q0Elax-lkp@intel.com/
>     Link: https://lore.kernel.org/r/4c795f2d87bc0391cf6543bcb224fa540b55ce4b.1685981486.git.jpoimboe@kernel.org
>     Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/arch/x86/include/asm/unwind_hints.h b/arch/x86/include/asm/unwind_hints.h
> index 01cb9692b160a..85cc57cb65392 100644
> --- a/arch/x86/include/asm/unwind_hints.h
> +++ b/arch/x86/include/asm/unwind_hints.h
> @@ -76,9 +76,18 @@
>  
>  #else
>  
> +#define UNWIND_HINT_UNDEFINED \
> +	UNWIND_HINT(UNWIND_HINT_TYPE_UNDEFINED, 0, 0, 0)
> +
>  #define UNWIND_HINT_FUNC \
>  	UNWIND_HINT(UNWIND_HINT_TYPE_FUNC, ORC_REG_SP, 8, 0)
>  
> +#define UNWIND_HINT_SAVE \
> +	UNWIND_HINT(UNWIND_HINT_TYPE_SAVE, 0, 0, 0)
> +
> +#define UNWIND_HINT_RESTORE \
> +	UNWIND_HINT(UNWIND_HINT_TYPE_RESTORE, 0, 0, 0)
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* _ASM_X86_UNWIND_HINTS_H */
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg_x86.h b/drivers/gpu/drm/vmwgfx/vmwgfx_msg_x86.h
> index 0b74ca2dfb7bd..23899d743a903 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg_x86.h
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg_x86.h
> @@ -105,10 +105,14 @@
>                          flags, magic, bp,		\
>                          eax, ebx, ecx, edx, si, di)	\
>  ({							\
> -        asm volatile ("push %%rbp;"			\
> +        asm volatile (					\
> +		UNWIND_HINT_SAVE			\
> +		"push %%rbp;"				\
> +		UNWIND_HINT_UNDEFINED			\
>                  "mov %12, %%rbp;"			\
>                  VMWARE_HYPERCALL_HB_OUT			\
> -                "pop %%rbp;" :				\
> +                "pop %%rbp;"				\
> +		UNWIND_HINT_RESTORE :			\
>                  "=a"(eax),				\
>                  "=b"(ebx),				\
>                  "=c"(ecx),				\
> @@ -130,10 +134,14 @@
>                         flags, magic, bp,		\
>                         eax, ebx, ecx, edx, si, di)	\
>  ({							\
> -        asm volatile ("push %%rbp;"			\
> +        asm volatile (					\
> +		UNWIND_HINT_SAVE			\
> +		"push %%rbp;"				\
> +		UNWIND_HINT_UNDEFINED			\
>                  "mov %12, %%rbp;"			\
>                  VMWARE_HYPERCALL_HB_IN			\
> -                "pop %%rbp" :				\
> +                "pop %%rbp;"				\
> +		UNWIND_HINT_RESTORE :			\
>                  "=a"(eax),				\
>                  "=b"(ebx),				\
>                  "=c"(ecx),				\

This adds build warnings to the build, so I am going to drop this one
for now, sorry.

greg k-h
