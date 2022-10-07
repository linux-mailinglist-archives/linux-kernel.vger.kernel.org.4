Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56E45F75C1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 11:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJGJLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 05:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiJGJLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 05:11:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CA8DED0C
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 02:11:44 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D67E11F7AB;
        Fri,  7 Oct 2022 09:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665133902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o5k3b8vGjea3maltVuBt6eUg45yrs+ve9GoN3hFlQf4=;
        b=Fj4atX2tHC/HCbl0h/KolgfUhmhJmVVM5/N25X3nGxhVFPSZLQlKu7ZuEGy6p+x2tT9xdl
        +TWuIgrjtIEHgZs2UD1VC2k9mr5Kl/aRksmt/fTAh4Mm1pPbGhV98IWjgxk1OjoiIYSQhP
        0ZXecdHlIaJWbH2YJhGNbrsBItuk+HQ=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8A3C62C143;
        Fri,  7 Oct 2022 09:11:42 +0000 (UTC)
Date:   Fri, 7 Oct 2022 11:11:42 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk 13/18] printk: Move buffer size defines
Message-ID: <Yz/tTt+V5MxraquY@alley>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-14-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924000454.3319186-14-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2022-09-24 02:10:49, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Move the buffer size defines to console.h in preparation of adding a buffer
> structure.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  include/linux/console.h | 14 ++++++++++++++
>  include/linux/printk.h  |  2 --
>  kernel/printk/printk.c  |  8 --------
>  3 files changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/console.h b/include/linux/console.h
> index dc0df9d9e7d9..3bb5bc62e154 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -122,6 +122,20 @@ static inline int con_debug_leave(void)
>  #define CM_ERASE    (2)
>  #define CM_MOVE     (3)
>  
> +#ifdef CONFIG_PRINTK
> +/* The maximum size of a formatted record (i.e. with prefix added per line) */
> +#define CONSOLE_LOG_MAX		1024
> +
> +/* The maximum size for a dropped text message */
> +#define DROPPED_TEXT_MAX	64
> +#else
> +#define CONSOLE_LOG_MAX		0
> +#define DROPPED_TEXT_MAX	0
> +#endif
> +
> +/* The maximum size of an formatted extended record */
> +#define CONSOLE_EXT_LOG_MAX	8192

It seems that all these defines are going to be used only under
kernel/printk/. I would prefer to move them into
kernel/printk/internal.h or another internal header file there.

Any public API can be misused. And these are rather implementation
details.

Best Regards,
Petr
