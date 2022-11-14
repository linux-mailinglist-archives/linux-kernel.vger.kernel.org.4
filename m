Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC18662827F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236738AbiKNO3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235617AbiKNO3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:29:05 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031F61C435
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 06:29:03 -0800 (PST)
Received: from zn.tnic (p200300ea9733e773329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e773:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B1D271EC008F;
        Mon, 14 Nov 2022 15:29:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1668436141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=c1MT1JyllbDIxWukzZBxcGNM4r9ClBKNN7L7lYaMGGY=;
        b=o384DVB5KjrvK5BWu8ohCW0a0fkot6nInXRBH8ZWSLhE+x9YuGkUMt6d+rFn4lbjookjyp
        /EtfA/3ePtcoGrEsJ3iPXJzzKyxFgUyVe6CRbX5krCz4hTw8bNCV4apnqKDdTm/iC/8APF
        rGSdfMax0xoeK18tZr6zxPw1JwFMyew=
Date:   Mon, 14 Nov 2022 15:28:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: Re: [PATCH v8 2/5] x86: Add cmdline_prepare() helper
Message-ID: <Y3JQpxi6XDkPViBr@zn.tnic>
References: <cover.1668082601.git.baskov@ispras.ru>
 <b81fa524589ff21002a501f0b4cddf41b53f640f.1668082601.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b81fa524589ff21002a501f0b4cddf41b53f640f.1668082601.git.baskov@ispras.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 04:09:30PM +0300, Evgeniy Baskov wrote:
> Command line needs to be combined in both compressed and uncompressed
> kernel from built-in and boot command line strings, which requires
> non-trivial logic depending on CONFIG_CMDLINE_BOOL and
> CONFIG_CMDLINE_OVERRIDE.
> 
> Add a helper function to avoid code duplication.
> 
> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
> ---
>  arch/x86/include/asm/shared/cmdline.h | 35 +++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 arch/x86/include/asm/shared/cmdline.h
> 
> diff --git a/arch/x86/include/asm/shared/cmdline.h b/arch/x86/include/asm/shared/cmdline.h
> new file mode 100644
> index 000000000000..01736d66028d
> --- /dev/null
> +++ b/arch/x86/include/asm/shared/cmdline.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _ASM_X86_SETUP_CMDLINE_H
> +#define _ASM_X86_SETUP_CMDLINE_H
> +
> +#define _SETUP
> +#include <asm/setup.h> /* For COMMAND_LINE_SIZE */
> +#undef _SETUP
> +
> +#include <linux/string.h>
> +
> +#ifdef CONFIG_CMDLINE_BOOL
> +#define BUILTIN_COMMAND_LINE CONFIG_CMDLINE
> +#else
> +#define BUILTIN_COMMAND_LINE ""
> +#endif
> +
> +static inline void cmdline_prepare(char *dst, const char *boot_command_line)
> +{
> +	if (!IS_ENABLED(CONFIG_CMDLINE_BOOL)) {
> +		strscpy(dst, boot_command_line, COMMAND_LINE_SIZE);
> +	} else {
> +		strscpy(dst, BUILTIN_COMMAND_LINE, COMMAND_LINE_SIZE);
> +		/*
> +		 * Append boot loader cmdline to builtin, if it exists
> +		 * and should not be overriden.
> +		 */
> +		if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE) && boot_command_line[0]) {
> +			strlcat(dst, " ", COMMAND_LINE_SIZE);
> +			strlcat(dst, boot_command_line, COMMAND_LINE_SIZE);
> +		}

You keep changing what I'm suggesting and the next patch has a strscpy()
outside of the function.

When I say it should be all concentrated in one function, I really mean
it.

So now it is my turn: I'll do it how I think it should be done and you
can review it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
