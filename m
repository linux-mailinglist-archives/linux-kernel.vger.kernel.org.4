Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1A06603AD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 16:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbjAFPtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 10:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjAFPtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 10:49:49 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FBA7A908;
        Fri,  6 Jan 2023 07:49:48 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EAA3A26FE7;
        Fri,  6 Jan 2023 15:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673020186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nlLNBsJ016dLRLV9zMcCXmH5Ooqp6V91N5ceMdEy2yY=;
        b=KslERRkULJDTNmddR6w++KIFNpGBwef2TfP4NMyEiLHnAwyjYVkYPTnRiCX3+uHxszP8eV
        FF8pWElqACAJigbvmQRBcNQwPdoyUzYlUKINXB5J+pVURDYgE66jpqizr+kmtQ+Y66qjYU
        OUwCPa6x52VpRFIUILLVYetUFAE5pTE=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A362F2C141;
        Fri,  6 Jan 2023 15:49:46 +0000 (UTC)
Date:   Fri, 6 Jan 2023 16:49:46 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsprintf: fix possible NULL pointer deref in vsnprintf()
Message-ID: <Y7hDGoCbWG2ZYdlV@alley>
References: <1f4d159e-5382-3c75-bd5e-42337ecd8c28@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f4d159e-5382-3c75-bd5e-42337ecd8c28@omp.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Adding Kees, Linus, and linux-hardening into Cc. It seems that
__vsnprintf_internal() does not do this in glibc. I wonder if
there is a good reason for it.

My guess is that glibc does not do this either because they do not
want to quietly hide bugs or just nobody had this idea.


On Fri 2023-01-06 00:16:31, Sergey Shtylyov wrote:
> In vsnprintf() etc, C99 allows the 'buf' argument to be NULL when the
> 'size' argument equals 0.  Let us treat NULL passed as if the 'buf'
> argument pointed to a 0-sized buffer, so that we can avoid a NULL pointer
> dereference and still return the # of characters that would be written if
> 'buf' pointed to a valid buffer...

This is misleading. The message says how vsprintf() should behave
by the standard. But it does not describe what this patch does.

The function already behaves by the standard. The change is that
the vsprintf() will catch an obvious mistake and prevent failure.

> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> analysis tool.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> ---
> This patch is against the 'master' branch of the PRINTK Group's repo...
> 
>  lib/vsprintf.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> Index: linux/lib/vsprintf.c
> ===================================================================
> --- linux.orig/lib/vsprintf.c
> +++ linux/lib/vsprintf.c
> @@ -2738,6 +2738,15 @@ int vsnprintf(char *buf, size_t size, co
>  	if (WARN_ON_ONCE(size > INT_MAX))
>  		return 0;
>  
> +	/*
> +	 * C99 allows @buf to be NULL when @size is 0. We treat such NULL as if
> +	 * @buf pointed to 0-sized buffer, so we can both avoid a NULL pointer
> +	 * dereference and still return # of characters that would be written
> +	 * if @buf pointed to a valid buffer...
> +	 */
> +	if (!buf)
> +		size = 0;

It makes sense except that it would hide bugs. It should print a
warning, for example:

	char *err_msg;

	err_msg = check_pointer_msg(buf);
	if (err_msg) {
		WARN_ONCE(1, "Invalid buffer passed to vsnprintf(). Trying to continue with 0 length limit\n");
		size = 0;
	}

check_pointer_msg() allows to catch even more buggy pointers. WARN()
helps to locate the caller. WARN_ONCE() variant is used to prevent
a potential infinite loop.

> +
>  	str = buf;
>  	end = buf + size;
>  

Best Regards,
Petr
