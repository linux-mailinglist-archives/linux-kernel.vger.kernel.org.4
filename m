Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512176236D0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 23:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiKIWyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 17:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKIWyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 17:54:15 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9533D1D335
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 14:54:14 -0800 (PST)
Received: from zn.tnic (p200300ea9733e7bc329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7bc:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 25D811EC064C;
        Wed,  9 Nov 2022 23:54:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1668034453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lE6UwfAfNZ0h2E9FFQxvbitrMQW4lDZbQpPEYD8P3wM=;
        b=qApjqwf7bwhGNHv8lkANueTJOiBisHBLP7RLzwYVjEUfOhM6FodA4qHF9XVt9pmWFWGxUG
        9zknT73Bpu46X3AUmShuf/IQ01ZkE57TGPoahK8/yg1r/lLddUH/QyhdqHP/moYhjjUkZZ
        gikbpxvADITy4JTSTW/XV4F1XgxXnW0=
Date:   Wed, 9 Nov 2022 23:54:06 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: Re: [PATCH v7 2/5] x86: Add cmdline_prepare() helper
Message-ID: <Y2wvjmpwpOWsc5WT@zn.tnic>
References: <cover.1664886978.git.baskov@ispras.ru>
 <603dc95beb44340aa1787328589ff2e073b251e1.1664886978.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <603dc95beb44340aa1787328589ff2e073b251e1.1664886978.git.baskov@ispras.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 03:48:21PM +0300, Evgeniy Baskov wrote:
> +static inline void cmdline_prepare(char *command_line,
> +				   const char *boot_command_line)
> +{
> +	if (!IS_ENABLED(CONFIG_CMDLINE_BOOL)) {
> +		strscpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
> +	} else if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE)) {
> +		/* Append boot loader cmdline to builtin one. */
> +		strlcat(command_line, " ", COMMAND_LINE_SIZE);
> +		strlcat(command_line, boot_command_line, COMMAND_LINE_SIZE);
> +	}

Why can't we make this plain and simple and understandable at a quick
glance instead of putting parts of the string in some variable and then
still doing copying outside of the function?

IOW, simply put everything in a single function:

static inline void cmdline_prepare(char *dst,
                                   const char *builtin_cmdline,
                                   const char *boot_command_line)
{                                  
        /* Depends on CONFIG_CMDLINE_BOOL, overwrite with builtin cmdline */
        if (IS_ENABLED(CONFIG_CMDLINE_OVERRIDE))
                strscpy(dst, builtin_cmdline, COMMAND_LINE_SIZE);
        else if (IS_ENABLED(CONFIG_CMDLINE_BOOL)) {
                if (builtin_cmdline[0]) {
                        /* append boot loader cmdline to builtin */
                        srtlcat(dst, builtin_cmdline, COMMAND_LINE_SIZE)
                        strlcat(dst, " ", COMMAND_LINE_SIZE);
                        strlcat(dst, boot_command_line, COMMAND_LINE_SIZE);
                } else {
                        strscpy(dst, boot_command_line, COMMAND_LINE_SIZE);
                }
        }
}

which is then called like this:

	cmdline_prepare(command_line, builtin_cmdline, boot_command_line);

and when it returns command_line is ready. And before it, command_line
is the empty string:

static char __initdata command_line[COMMAND_LINE_SIZE];

And all the complexity is in one single function and that single
function does each case in an obvious manner and you don't have to go
look outside of the function body to understand what it does.

Hmmm?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
