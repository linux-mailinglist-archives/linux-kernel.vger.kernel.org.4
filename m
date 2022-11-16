Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEAD62B610
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238736AbiKPJJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238792AbiKPJJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:09:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E07233B8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:08:39 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668589717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0CGWwYZrTrOzwGHnTvqXKCFp/Dj3jrSRjmzNVayxzmw=;
        b=kNIzzDy9jcb1oibTWn5I2FK59aR4j35tmXJ6OFhYezb1ZGavcMjg5c9o6lYxADsnRagKHw
        IM7/v67lVDyOQ2HCtjXFJO5JQPvUeqTSIXLCq1hgpH8dGOW44EnFkHOFewEICWtj60VaoF
        bvVsntVA5p9MsuGfdZUbEabUvCxRSNBipvdNE6CQl51Q5XayKh6NJc8yU32oYrlJkMdq7T
        sGlMu42SPO5y9dZRA1Ji2ovPFIDvLfbQCxspD2RvAMc62SMo1aenP7Kzit8Tz0YOBVaAbP
        VVh34zMTd90QWp3TQJm4ejku6ipqNzpKbbZUvtFM5RprrzFaoDpmo3Ny7j1eeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668589717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0CGWwYZrTrOzwGHnTvqXKCFp/Dj3jrSRjmzNVayxzmw=;
        b=ub2g/GEYV7gRim+IeFw+0P2xRSDXNIW/CGofJ54VJCnHwHkV6Tr0p+zo8ihQibnp2ag4li
        CqCqcaE9rcn8pkAQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: replay log: Re: [PATCH printk v4 38/39] printk: relieve
 console_lock of list synchronization duties
In-Reply-To: <87v8nfjn0d.fsf@jogness.linutronix.de>
References: <20221114162932.141883-1-john.ogness@linutronix.de>
 <20221114162932.141883-39-john.ogness@linutronix.de>
 <Y3Oxck0/LAHFLYip@alley> <87tu30maqf.fsf@jogness.linutronix.de>
 <Y3PZEbx+40ZyN/79@alley> <87y1sbjn77.fsf@jogness.linutronix.de>
 <87v8nfjn0d.fsf@jogness.linutronix.de>
Date:   Wed, 16 Nov 2022 10:14:35 +0106
Message-ID: <87sfijjmgc.fsf@jogness.linutronix.de>
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

Hi Petr,

Sorry, console_flush_all() only loses the console_lock if there was a
handover. Here is a new complete suggestion from me.

	if (newcon->flags & (CON_PRINTBUFFER | CON_BOOT)) {
		/* Get a consistent copy of @syslog_seq. */
		mutex_lock(&syslog_lock);
		newcon->seq = syslog_seq;
		mutex_unlock(&syslog_lock);
	} else {
		/* Begin with next message added to ringbuffer. */
		newcon->seq = prb_next_seq(prb);

		/*
		 * If any enabled boot consoles are due to be unregistered
		 * shortly, some may not be caught up and may be the same
		 * device as @newcon. Since it is not known which boot console
		 * is the same device, flush all consoles and, if necessary,
		 * start with the message of the enabled boot console that is
		 * the furthest behind.
		 */
		if (bootcon_registered && !keep_bootcon) {
			bool handover;

			/*
			 * Hold the console_lock to guarantee safe access to
			 * console->seq.
			 */
			console_lock();

			/*
			 * Flush all consoles and set the console to start at
			 * the next unprinted sequence number.
			 */
			if (!console_flush_all(true, &newcon->seq, &handover)) {
				/*
				 * Flushing failed. Just choose the lowest
				 * sequence of the enabled boot consoles.
				 */

				/*
				 * If there was a handover, this context no
				 * longer holds the console_lock.
				 */
				if (handover)
					console_lock();

				newcon->seq = prb_next_seq(prb);
				for_each_console(con) {
					if ((con->flags & CON_BOOT) &&
					    (con->flags & CON_ENABLED) &&
					    con->seq < newcon->seq) {
						newcon->seq = con->seq;
					}
				}
			}

			console_unlock();
		}

John Ogness
