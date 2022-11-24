Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7ED363773A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiKXLJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiKXLJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:09:30 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2C773BBD
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:09:27 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 59AE421A94;
        Thu, 24 Nov 2022 11:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669288166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IFku1/4PD/oqyNGcI/Zxd5kU8GOuD5zCbfv2NQBHbmo=;
        b=Kh0EDWe7QhgOU65RVk5ZRUro9xRHE/NexyQzzL3EFVa5fRTwyP0ZlJLdxaa5RZ8vE2VVKH
        AjE4yeMg8w3CK3Yt42ww0gnwC8/R0rTmEo+nV5CKQut2TbSDH8XlE3JI/czoZ/4hrGXM3q
        4DqYnSIGrv8sMae9E0LxB7uxRy4RyF4=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1A95F2C141;
        Thu, 24 Nov 2022 11:09:26 +0000 (UTC)
Date:   Thu, 24 Nov 2022 12:09:25 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 1/7] printk: Move buffer size defines
Message-ID: <Y39Q5TjoHUUKXC1S@alley>
References: <20221123231400.614679-1-john.ogness@linutronix.de>
 <20221123231400.614679-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123231400.614679-2-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-11-24 00:19:54, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Move the buffer size defines to console.h in preparation of adding a
> buffer structure. The new buffer structure will be embedded within
> struct console. Therefore console.h was chosen as the new home for
> these defines.

The buffers are not embedded into struct console in this patchset.
Are they going to be added directly or via pointer, please?

IMHO, it is always better to hide these implementation details
in an internal header or source file. It will be possible
if struct console contained on a pointer to the buffers.


> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  include/linux/console.h | 14 ++++++++++++++
>  include/linux/printk.h  |  2 --
>  kernel/printk/printk.c  |  4 ----
>  3 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/console.h b/include/linux/console.h
> index 9cea254b34b8..799fc3216aad 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -122,6 +122,20 @@ static inline int con_debug_leave(void)
>  #define CM_ERASE    (2)
>  #define CM_MOVE     (3)
>  
> +#ifdef CONFIG_PRINTK
> +
> +/* The maximum size of a formatted record (i.e. with prefix added per line) */
> +#define CONSOLE_LOG_MAX		1024
> +
> +#else
> +
> +#define CONSOLE_LOG_MAX		0
> +
> +#endif
> +
> +/* The maximum size of a formatted extended record */
> +#define CONSOLE_EXT_LOG_MAX	8192

It looks strange that we need the buffer for extended messages
and not the normal one when !CONFIG_PRINTK. I can't find any reason
for this. It looks like a historic inconsistency.

CONSOLE_EXT_LOG_MAX was added into printk.h in the commit
d43ff430f434d862db59 ("printk: guard the amount written per line
by devkmsg_read()"). It didn't have to be in include/linux/printk.h
at that time. But nobody cared, including me, I was a greenhorn ;-)

Well, it would be nice to fix it when we are moving the definition
next to each other.

Best Regards,
Petr
