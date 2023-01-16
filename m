Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EBA66C94E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 17:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbjAPQry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 11:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbjAPQrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 11:47:21 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACD940BEF;
        Mon, 16 Jan 2023 08:35:09 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CC830671D6;
        Mon, 16 Jan 2023 16:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673886907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x7t0YOJRqJkyR/v4+Wf24lPdcrODSmxqSGim8YzYnhs=;
        b=Io1NDW4DvizFFd/BfM+ziDxHHjtF5sOBp4nwfT08niOp80XKhwhwF/jZKscKxuc6k06VEx
        d0hQgX1MwimvRavIgcAbe6zgrgsCOiJ3Gm5gZ1adL09GDww4Pqd2NMkjqHGKUCOnmCt2Tn
        pMu7OCH1bCzfJx7+hPkUTJ5vVf+sYyk=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3CF3F2C1AC;
        Mon, 16 Jan 2023 16:35:05 +0000 (UTC)
Date:   Mon, 16 Jan 2023 17:35:02 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     coverity-bot <keescook@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: Coverity: console_prepend_dropped(): Memory - corruptions
Message-ID: <Y8V8tqMJeB7t+rcJ@alley>
References: <202301131544.D9E804CCD@keescook>
 <Y8KAhaiZQOWTcfyF@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8KAhaiZQOWTcfyF@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2023-01-14 19:14:29, Sergey Senozhatsky wrote:
> On (23/01/13 15:46), coverity-bot wrote:
> > *** CID 1530570:  Memory - corruptions  (OVERRUN)
> > kernel/printk/printk.c:2738 in console_prepend_dropped()
> > 2732     		/* Truncate the message, but keep it terminated. */
> > 2733     		pmsg->outbuf_len = outbuf_sz - (len + 1);
> > 2734     		outbuf[pmsg->outbuf_len] = 0;
> > 2735     	}
> > 2736
> > 2737     	memmove(outbuf + len, outbuf, pmsg->outbuf_len + 1);
> > vvv     CID 1530570:  Memory - corruptions  (OVERRUN)
> > vvv     Overrunning buffer pointed to by "scratchbuf" of 1024 bytes by passing it to a function which accesses it at byte offset 1998 using argument "len" (which evaluates to 1999). [Note: The source code implementation of the function has been overridden by a builtin model.]
> > 2738     	memcpy(outbuf, scratchbuf, len);
> > 2739     	pmsg->outbuf_len += len;
> > 2740     }
> > 2741     #else
> > 2742     #define console_prepend_dropped(pmsg, dropped)
> > 2743     #endif /* CONFIG_PRINTK */
> [..]
> > Human notes from Kees:
> > 
> > I'm not sure how it got 1998, but I do see that snprintf() should
> > probably be scnprintf(), otherwise "len" might be a lie (i.e. it'll hold
> > what it WANTED to write, rather than what it actually wrote).
> 
> Cannot imagine how "** %lu printk messages dropped **\n" can expand into
> 1998 bytes. Does coverity have a "verbose" mode?

I guess that coverity tries to pass some random string that is longer
than the provided buffer.

The code might be safe with the current size of the buffer and
the string. But it is true that the following is wrong:

	len = snprintf(scratchbuf, scratchbuf_sz,
		       "** %lu printk messages dropped **\n", dropped);


As Kees pointed out in the human comment, we should use scnprintf()
that will return the really written length of the string that fits
into the buffer.

I am going to send a patch.

Best Regards,
Petr
