Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4712461F9DD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbiKGQc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiKGQce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:32:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B642656E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 08:30:51 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667838649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L4sUpwP8dk3i0wHw3GqyNgDqqSt5iy8yfrZ+H4hTCuM=;
        b=z7MSggwv/tpw0jOGQo4tlAQlF0EFYw7CE/SANbF/+wjfeGKkqWFYut1T+THTKM9CY6XM7E
        wpLqJ6K9YcpDKElYc1lkZU9Mb741nqad4crQt6atRYIma2frV5yBvMlNJIrw8UZU15EDi+
        JQfYKU3UO2GHeE172C/5ehi2N0Cynsb74/iL1+xdYPllyYRjXg4RzLuAm3BsR5nFe31IZv
        gK3tNpG2q7IAR5jhGK72ylbfo8LRbCfGMBwWKRDLeWuvROBfr+BvqpB/gIiUacZGTD4k9W
        bQHxo7cWXINEWazlvLsq3M5fzS0fY1FOaiy03g6/mebo1zv58NLCvNzXf6kk5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667838649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L4sUpwP8dk3i0wHw3GqyNgDqqSt5iy8yfrZ+H4hTCuM=;
        b=bimstmKxlVRzf6FmJc/1c4t/+NiaiolMrCbZMj68Le8FWkdj25yVnqE5BplMjnEeEnGjmR
        /Tz+vzxxDlKWQODA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 39/40] printk: relieve console_lock of list
 synchronization duties
In-Reply-To: <20221107141638.3790965-40-john.ogness@linutronix.de>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-40-john.ogness@linutronix.de>
Date:   Mon, 07 Nov 2022 17:36:48 +0106
Message-ID: <87r0ye916v.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-07, John Ogness <john.ogness@linutronix.de> wrote:
> @@ -3344,7 +3340,6 @@ void register_console(struct console *newcon)
>  	 * Put this console in the list - keep the
>  	 * preferred driver at the head of the list.
>  	 */
> -	console_lock();
>  	if (hlist_empty(&console_list)) {
>  		/* Ensure CON_CONSDEV is always set for the head. */
>  		newcon->flags |= CON_CONSDEV;
> @@ -3358,7 +3353,6 @@ void register_console(struct console *newcon)
>  	} else {
>  		hlist_add_behind_rcu(&newcon->node, console_list.first);
>  	}
> -	console_unlock();
>  
>  	/*
>  	 * No need to synchronize SRCU here! The caller does not rely

I just realized that because of the new @seq initialization (patch 5/40)
that we cannot completely remove the console_lock from
register_console(). It will still be needed for @seq synchronization
when registering non-boot/non-printbuffer consoles. So something like
the patch below will need to be folded into this one.

I am not happy with this. If an enabled boot console is behind, the
console_unlock() will probably catch it up and we will end up with some
repeat messages. But maybe this is "good enough" until we implement some
real coordination between boot console and normal console takeovers.

John Ogness

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 17765166ac42..bb119001df56 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3328,12 +3328,21 @@ void register_console(struct console *newcon)
 		 * that message instead. That boot console will be
 		 * unregistered shortly and may be the same device.
 		 */
+
+		/*
+		 * Hold the console_lock to guarantee safe access to
+		 * console->seq.
+		 */
+		console_lock();
+
 		for_each_console(con) {
 			if ((con->flags & (CON_BOOT | CON_ENABLED)) == (CON_BOOT | CON_ENABLED) &&
 			    con->seq < newcon->seq) {
 				newcon->seq = con->seq;
 			}
 		}
+
+		console_unlock();
 	}
 
 	/*
