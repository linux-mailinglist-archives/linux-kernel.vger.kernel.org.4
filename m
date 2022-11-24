Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7DA637EEB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 19:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiKXSaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 13:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiKXSaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 13:30:18 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057F7827CC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 10:30:13 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BE17A21AC2;
        Thu, 24 Nov 2022 18:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669314611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3kTbFRyfWHcbzHx3yVRWYiE5rqpeYo8YEGSgadCWbj0=;
        b=Vkg90M4mNhJcUl8QrsNVtnjzD/xy95JD1njwwPURIS2xbYKAak3pq91OyUEEWIgE8igZ7e
        O774eKRuLMLhykcqjKfT9k7H8GqoFCJNav+XePn1gCNenOFEVRzBs/DZtFbkXMLj0S9LE7
        h5erYl1fgbAu9caSEDDMQSKuoxW+4uk=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 893A42C141;
        Thu, 24 Nov 2022 18:30:11 +0000 (UTC)
Date:   Thu, 24 Nov 2022 19:30:11 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: OFFLIST: Re: [PATCH printk v2 6/7] printk: Use an output buffer
 descriptor struct for emit
Message-ID: <Y3+4MzIed3yLG4LE@alley>
References: <20221123231400.614679-1-john.ogness@linutronix.de>
 <20221123231400.614679-7-john.ogness@linutronix.de>
 <Y3+xK7hHmUIlzq9w@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3+xK7hHmUIlzq9w@alley>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-11-24 19:00:14, Petr Mladek wrote:
> PS: Please, wait a bit with updating the patches. I have got yet
>     another idea when seeing the code around dropped messages.
>     But I have to sleep over it.
> 
>     My concern is that the message about dropped messages need not
>     fit into the smaller "cbufs->text" buffer. It might be better
>     to put it into the bigger one.
> 
>     We might actually always use the bigger buffer as the output
>     buffer. The smaller buffer might be only temporary when formatting
>     the extended messages.
> 
>      We could replace
> 
> 	struct console_buffers {
> 		char	ext_text[CONSOLE_EXT_LOG_MAX];
> 		char	text[CONSOLE_LOG_MAX];
> 	};
> 
>     with
> 
> 	struct console_buffers {
> 		char	outbuf[CONSOLE_EXT_LOG_MAX];
> 		char	readbuf[CONSOLE_LOG_MAX];
> 	};
> 
>      Normal consoles would use only @outbuf. Only the extended console
>      would need the @readbuf to read the messages before they are formatted.
> 
>      I guess that struct console_message won't be needed then at all.
> 
>      It might help to remove several twists in the code.
> 
>      I am sorry that I have not got this idea when reviewing v1.
>      Well, the code was even more complicated at that time.

Honestly, I haven't looked if you extended struct console_messages in
later patches that added the atomic consoles. It is possible that
the structure will be needed in the end anyway.

This was just an idea. You know, I always try to simplify things.
And many layers, pointers to the same buffers with different names,
makes things complicated.

Well, there are always many ways how to design the code and I do not
want to delay it too much with trying them all. Please, tell me
when you think that some changes are not worth the effort.

Best Regards,
Petr
