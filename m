Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD4365C112
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 14:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237406AbjACNpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 08:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237375AbjACNpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 08:45:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7A51114A
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 05:45:03 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672753501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rAcxMAKJNRiN8Bk3atXFvfIisLL3QxgCrRf05TmHA2I=;
        b=N1ea1Fnra/MBqhoT8H2zCLgdgV1iSYTwdMAyPAJkFgWWYNkh2hci5t7ttXUBMcUAVPF0Xi
        ck98MRv15+4dFlNP7pZCIAA8cIc2X6JimARsE+U/wniBC8qN+0Cs8Nt7eVNV5oZT+Q9mL6
        1fMmQSdjpPLaMgR7HkHAraVNqrq0cVjFJSoPOBbwP/0YohURfKPWqptkG47Ca8KKEQfNfA
        k+Pxbq+AKTFpboyprV8NsOBANWmnw79UJZ8W3DQIF6BKhZD/K6Hpge+pmahP6Kzc8rqbIO
        qjbgVkQQqp2o8os00S+XY/56xp0DYPCsdgLZMkB2z4lOOJUg6KrIJW88HT4SwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672753501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rAcxMAKJNRiN8Bk3atXFvfIisLL3QxgCrRf05TmHA2I=;
        b=vtaqMSM9L1ZY4vLO30KhOGEb2eOw2Aoh3hjYS0+BSVQDUScKMPw6w9At4dWl8YeDEpIO4B
        db+JHH/TgSB+bkCQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 6/6] printk: introduce
 console_prepend_dropped() for dropped messages
In-Reply-To: <Y7QtusGlIX3AU+TN@alley>
References: <20221221202704.857925-1-john.ogness@linutronix.de>
 <20221221202704.857925-7-john.ogness@linutronix.de>
 <Y7MEDmP1zqWblj0N@alley> <87y1qjdimw.fsf@jogness.linutronix.de>
 <Y7QtusGlIX3AU+TN@alley>
Date:   Tue, 03 Jan 2023 14:50:23 +0106
Message-ID: <87o7rfd96w.fsf@jogness.linutronix.de>
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

On 2023-01-03, Petr Mladek <pmladek@suse.com> wrote:
> Well, what about making sure that something more useful is always
> printed. For example:
>
> 	/*
> 	 * Make sure outbuf is sufficiently large before prepending.
> 	 * Keep at least the prefix when the message has to be truncated.
> 	 * It is a rather theoretical problem when someone tries to
> 	 * use a minimalist buffer.
> 	 */
> 	if (WARN_ON_ONCE(len + PREFIX_MAX + 1 >= outbuf_sz))
> 		return;

I am fine with this. We won't see this warning anyway. Few lines would
ever be printed correctly if anyone ever tries to use a buffer so small.

> If we want to use this way. It would probably make sense to
> rename PREFIX_MAX to CONSOLE_PREFIX_MAX.

Actually, I would like to rename all of those limit macros to something
that makes more sense for the new code base:

CONSOLE_EXT_LOG_MAX -> CONSOLE_MESSAGE_MAX

CONSOLE_LOG_MAX     -> SYSLOG_MESSAGE_MAX

LOG_LINE_MAX        -> PRINTK_RECORD_MAX

PREFIX_MAX          -> CONSOLE_PREFIX_MAX

I have a patch to do this ready, but I did not want to post it until we
are finished with the thread/atomic work.

John
