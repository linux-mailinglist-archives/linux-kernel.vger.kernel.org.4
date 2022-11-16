Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E6C62BA9D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbiKPLB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbiKPLAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:00:53 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0B045A38
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:48:54 -0800 (PST)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 792B6419E9C5;
        Wed, 16 Nov 2022 10:48:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 792B6419E9C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1668595728;
        bh=axvcYS4oL7FiAVE53nqYey2aK4PHdtglSCf08a7IWwQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NZLcHoaHjGSjCtvc/qj6v8WNP2TImPGqd6UsKTPwLG8/H1WRZkfqrIEIJudN0oHoa
         XZfH+uV1XESMs2tWmYIrCUrIj39wAGRHXmp+5tGH622Wi/foc5XS2oimqGzf0rnalS
         xiS3DU1jqHwEF0//W9UHXaQo7xVCpXxk6oi9R+bY=
MIME-Version: 1.0
Date:   Wed, 16 Nov 2022 13:48:48 +0300
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: Re: [PATCH 2/2] x86/boot: Use cmdline_prepare() in the compressed
 stage
In-Reply-To: <Y3PhtjKjt/G2kqAF@zn.tnic>
References: <cover.1668082601.git.baskov@ispras.ru>
 <b81fa524589ff21002a501f0b4cddf41b53f640f.1668082601.git.baskov@ispras.ru>
 <Y3JQpxi6XDkPViBr@zn.tnic> <Y3PhYRx9aAYsdvMQ@zn.tnic>
 <Y3PhtjKjt/G2kqAF@zn.tnic>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <d51808e14d76c5663d3eb946a92bce2d@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-15 22:00, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> Date: Tue, 15 Nov 2022 19:30:09 +0100
> 
> Use cmdline_prepare() in the compressed stage so that builtin
> command line (CONFIG_CMDLINE_BOOL) and overridden command line
> (CONFIG_CMDLINE_OVERRIDE) strings are visible in the compressed kernel
> too.
> 
> Use case being, supplying earlyprintk via a compile-time option for
> booting on systems with broken UEFI command line arguments via EFISTUB.
> 
> Reported-by: Evgeniy Baskov <baskov@ispras.ru>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/boot/compressed/misc.c       |  7 +++++++
>  arch/x86/include/asm/shared/cmdline.h | 20 ++++++++++++++++----
>  2 files changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/misc.c 
> b/arch/x86/boot/compressed/misc.c
> index cf690d8712f4..b1077b2fdba6 100644
> --- a/arch/x86/boot/compressed/misc.c
> +++ b/arch/x86/boot/compressed/misc.c
> @@ -18,6 +18,9 @@
>  #include "../string.h"
>  #include "../voffset.h"
>  #include <asm/bootparam_utils.h>
> +#include <asm/shared/cmdline.h>
> +
> +extern unsigned long get_cmd_line_ptr(void);
> 
>  /*
>   * WARNING!!
> @@ -355,6 +358,7 @@ asmlinkage __visible void *extract_kernel(void
> *rmode, memptr heap,
>  {
>  	const unsigned long kernel_total_size = VO__end - VO__text;
>  	unsigned long virt_addr = LOAD_PHYSICAL_ADDR;
> +	char *cmdline = (char *)get_cmd_line_ptr();
>  	unsigned long needed_size;
> 
>  	/* Retain x86 boot parameters pointer passed from startup_32/64. */
> @@ -365,6 +369,9 @@ asmlinkage __visible void *extract_kernel(void
> *rmode, memptr heap,
> 
>  	sanitize_boot_params(boot_params);
> 
> +	/* Destination and boot command line are the same */
> +	cmdline_prepare(cmdline, BUILTIN_CMDLINE, cmdline);
> +
>  	if (boot_params->screen_info.orig_video_mode == 7) {
>  		vidmem = (char *) 0xb0000;
>  		vidport = 0x3b4;
> diff --git a/arch/x86/include/asm/shared/cmdline.h
> b/arch/x86/include/asm/shared/cmdline.h
> index e09c06338567..8a7d8f579575 100644
> --- a/arch/x86/include/asm/shared/cmdline.h
> +++ b/arch/x86/include/asm/shared/cmdline.h
> @@ -8,6 +8,15 @@
>  #define BUILTIN_CMDLINE ""
>  #endif
> 
> +#define _SETUP
> +#include <asm/setup.h> /* For COMMAND_LINE_SIZE */
> +#undef _SETUP
> +
> +/*
> + * Add @boot_command_line to @dst only if it is not in @dst already.
> The compressed kernel
> + * has the command line pointer in setup_header.cmd_line_ptr which is
> set by the boot
> + * loader so @boot_command_line == @dst there, see the call in
> compressed/misc.c
> + */
>  static inline void cmdline_prepare(char *dst,
>                                     const char *builtin_cmdline,
>                                     char *boot_command_line)
> @@ -20,15 +29,18 @@ static inline void cmdline_prepare(char *dst,
>  			/* Add builtin cmdline */
>  			strlcat(dst, builtin_cmdline, COMMAND_LINE_SIZE);
>  			strlcat(dst, " ", COMMAND_LINE_SIZE);
> -			/* Add boot cmdline */
> -			strlcat(dst, boot_command_line, COMMAND_LINE_SIZE);
> +
> +			if (dst != boot_command_line)
> +				strlcat(dst, boot_command_line, COMMAND_LINE_SIZE);
>  		}
>  	} else {
> -		strscpy(dst, boot_command_line, COMMAND_LINE_SIZE);
> +		if (dst != boot_command_line)
> +			strscpy(dst, boot_command_line, COMMAND_LINE_SIZE);
>  	}
> 
>  	/* Copy back into boot command line, see setup_command_line() */
> -	strscpy(boot_command_line, dst, COMMAND_LINE_SIZE);
> +	if (dst != boot_command_line)
> +		strscpy(boot_command_line, dst, COMMAND_LINE_SIZE);
>  }
> 
>  #endif /* _ASM_X86_SHARED_CMDLINE_H */
> --
> 2.35.1


Thanks for your time!

This patch has a few problems I was trying to avoid though:
* It has different behavior for dst == boot_command_line and dst !=
   boot_command_line, since the order of parameters is different.
* It appends space at the end of command line, not as a separator.
* It also modifies boot_command_line in compressed kernel and it causes
   builtin command line to be appended twice.

First two problems would be fixed if compressed kernel used separate
buffer for modified cmdline like setup.c does. This also would simplify
the helper a bit and is required to fix the third problem.

The third problem was the reason I did not include the last strscpy() in
the helper. I still don't think it should be a part of the command line
preparation logic... If the code needs a copy for parse_early_param(),
it is related more to the parse_early_param() call, than to
cmdline_prepare().

Should I maybe make another iteration by removing lazy cmdline
initialization in compressed kernel and adding more comments?
I don't see though how the last strscpy() could cleanly fit into
cmdline_prepare().

Thanks,
Evgeniy Baskov
