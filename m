Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2F462B5BA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbiKPI4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiKPI4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:56:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AA51142
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:56:38 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668588996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FD6M9QY8iW9aXpGMda/ftERrCCP2hqP8/1sR46SwkDs=;
        b=Pm+m88h862VmziM9o4LFN8RIoKlfl03dSyIa5vjp5tPUrpfTiF6dB+sq6gsSdM1ftq+6f/
        rGP87F7Hwu/7JvReKDnRtCSBUQq6FKYRNQ5lLsE65Zyv2PTmL2qKkY6rqLmARqBSWMLjtI
        tNSUo+mqFBWcMw4HUUOJjxPILpPOnHYvUKmx9OAD3UFYBcjHEOwlV2HS/1bDWBofHnMgKJ
        26WonJw8CZwhWgpYJl0NP596cCGuhectIWrksiOS/c+aACZ67voTSUf+xbcN8C1mtTxmGi
        0IK5rijsYleQKoMCPuB1e9s5GvIWsNYZuxLmcCwbnYoxTWjf7eOsBwQkK0j7yA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668588996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FD6M9QY8iW9aXpGMda/ftERrCCP2hqP8/1sR46SwkDs=;
        b=m22c+CdGALHaAHSz4g430YNaNrE8SmdRINyPYAHMHQZF4ivHnWzRCRBqQOYRH14dpXzIgq
        sV5KHnBIvfocgqDw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: replay log: Re: [PATCH printk v4 38/39] printk: relieve
 console_lock of list synchronization duties
In-Reply-To: <87y1sbjn77.fsf@jogness.linutronix.de>
References: <20221114162932.141883-1-john.ogness@linutronix.de>
 <20221114162932.141883-39-john.ogness@linutronix.de>
 <Y3Oxck0/LAHFLYip@alley> <87tu30maqf.fsf@jogness.linutronix.de>
 <Y3PZEbx+40ZyN/79@alley> <87y1sbjn77.fsf@jogness.linutronix.de>
Date:   Wed, 16 Nov 2022 10:02:34 +0106
Message-ID: <87v8nfjn0d.fsf@jogness.linutronix.de>
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

Hi,

I forgot to re-lock the console... See below.

On 2022-11-16, John Ogness <john.ogness@linutronix.de> wrote:
> 	if (newcon->flags & (CON_PRINTBUFFER | CON_BOOT)) {
> 		/* Get a consistent copy of @syslog_seq. */
> 		mutex_lock(&syslog_lock);
> 		newcon->seq = syslog_seq;
> 		mutex_unlock(&syslog_lock);
> 	} else {
> 		/* Begin with next message added to ringbuffer. */
> 		newcon->seq = prb_next_seq(prb);
>
> 		/*
> 		 * If any enabled boot consoles are due to be unregistered
> 		 * shortly, some may not be caught up and may be the same
> 		 * device as @newcon. Since it is not known which boot console
> 		 * is the same device, flush all consoles and, if necessary,
> 		 * start with the message of the enabled boot console that is
> 		 * the furthest behind.
> 		 */
> 		if (bootcon_registered && !keep_bootcon) {
> 			bool handover;
>
> 			/*
> 			 * Hold the console_lock to guarantee safe access to
> 			 * console->seq.
> 			 */
> 			console_lock();
>
> 			/*
> 			 * Flush all consoles and set the console to start at
> 			 * the next unprinted sequence number.
> 			 */
> 			if (!console_flush_all(true, &newcon->seq, &handover)) {
> 				/*
> 				 * Flushing failed. Just choose the lowest
> 				 * sequence of the enabled boot consoles.
> 				 */

Sorry. Here we lost the console_lock. Another acquire is needed here.

				console_lock();

> 				newcon->seq = prb_next_seq(prb);
> 				for_each_console(con) {
> 					if ((con->flags & CON_BOOT) &&
> 					    (con->flags & CON_ENABLED) &&
> 					    con->seq < newcon->seq) {
> 						newcon->seq = con->seq;
> 					}
> 				}
> 			}
>
> 			console_unlock();
> 		}
> 	}

John Ogness
