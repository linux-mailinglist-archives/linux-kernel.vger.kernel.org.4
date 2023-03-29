Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A691C6CDB50
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjC2N6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjC2N6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:58:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9EF40C1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 06:58:10 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 561BA219E6;
        Wed, 29 Mar 2023 13:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680098289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EJC5tS+cmkz5uiZXxKFpX9md9Z4n6qSgdvMMotlD+Ow=;
        b=PC+UBGMbjj5aAlcDEpdgC4mHYZqdx0upihfOgDXYTmQoa8xgZoFvkZIde+hXdt/g2PMLPm
        SrmNcKwzB0uQr7TLOT3OWXDErpjoy+tUL4/6wtKl49mKREybGnHisKh/R3G2VvLNa4kkp/
        wfO/ntE/AB8mBklrlERz1N9/d5bCcBI=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E79312C16E;
        Wed, 29 Mar 2023 13:58:08 +0000 (UTC)
Date:   Wed, 29 Mar 2023 15:58:06 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: buffer write race: Re: [PATCH printk v1 09/18] printk: nobkl: Add
 print state functions
Message-ID: <ZCRD7oOcTzOM5cXe@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-10-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302195618.156940-10-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-03-02 21:02:09, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Provide three functions which are related to the safe handover
> mechanism and allow console drivers to denote takeover unsafe
> sections:
> 
>  - console_can_proceed()
> 
>    Invoked by a console driver to check whether a handover request
>    is pending or whether the console was taken over in a hostile
>    fashion.
> 
> --- a/kernel/printk/printk_nobkl.c
> +++ b/kernel/printk/printk_nobkl.c
> @@ -947,6 +947,145 @@ static void cons_free_percpu_data(struct console *con)
>  	con->pcpu_data = NULL;
>  }
>  
> +/**
> + * console_can_proceed - Check whether printing can proceed
> + * @wctxt:	The write context that was handed to the write function
> + *
> + * Returns:	True if the state is correct. False if a handover
> + *		has been requested or if the console was taken
> + *		over.
> + *
> + * Must be invoked after the record was dumped into the assigned record
> + * buffer

The word "after" made me think about possible races when the record
buffer is being filled. The owner might loose the lock a hostile
way during this action. And we should prevent using the same buffer
when the other owner is still modifying the content.

It should be safe when the same buffer might be used only by nested
contexts. It does not matter if the outer context finishes writing
later. The nested context should not need the buffer anymore.

But a problem might happen when the same buffer is shared between
more non-nested contexts. One context might loose the lock a hostile way.
The other context might get the access after the hostile context
released the lock.

NORMAL and PANIC contexts are safe. These priorities have only
one context and both have their own buffers.

A problem might be with EMERGENCY contexts. Each CPU might have
its own EMERGENCY context. We might prevent this problem if
we do not allow to acquire the lock in EMERGENCY (and NORMAL)
context when panic() is running or after the first hostile
takeover.

If we want to detect these problems and always be on the safe side,
we might need to add a flag 1:1 connected with the buffers.

We either could put a flag into struct printk_buffers. Or we could
bundle this struct into another one for the atomic consoles.
I mean something like:

struct printk_atomic_buffers {
	struct printk_buffers pbufs;
	atomic_t write_lock;
}

And use it in cons_get_record():

#define PRINTK_BUFFER_WRITE_LOCKED_VAL 1

static int cons_get_record(struct cons_write_context *wctxt)
{
	int ret = 0;

	/*
	 * The buffer is not usable when another write context
	 * is still writing the record and lost the lock a hostille
	 * way.
	 */
	if (WARN_ON_ONCE(cmpxchg_acquire(&wctxt->pabufs->write_lock,
			    0, PRINTK_BUFFER_WRITE_LOCKED_VAL) != 0)) {
		return -EBUSY;
	}

	// Fill the buffers

	if (no new message) {
		ret = -ENOENT;
		goto unlock;
	}

unlock:
	/* Release the write lock */
	atomic_set_release(&wctxt->pabufs->write_lock, 0);
	return ret;
}


Note: This is related to the discussion about the 7th patch but
      it is not the same.

      This mail is only about using the same buffer for the same console.

      The other discussion was also about using the same buffer
      for more consoles. It is even more problematic because
      each console uses its own lock.

      It means that we would still need separate buffer for each
      interrupt context. Nested context might be able to get
      the lock for another console a regular way, see
      https://lore.kernel.org/all/ZBndaSUFd4ipvKwj@alley/

> + * and at appropriate safe places in the driver.  For unsafe driver
> + * sections see console_enter_unsafe().
> + *
> + * When this function returns false then the calling context is not allowed
> + * to go forward and has to back out immediately and carefully. The buffer
> + * content is no longer trusted either and the console lock is no longer
> + * held.
> + */
> +bool console_can_proceed(struct cons_write_context *wctxt)
> +{

Best Regards,
Petr
