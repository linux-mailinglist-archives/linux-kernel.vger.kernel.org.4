Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA6F654477
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 16:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiLVPnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 10:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235579AbiLVPmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 10:42:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF282876F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 07:42:14 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1671723731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ih6VrsxX6xsnaFe2iTJFmjZ8gev/py4lccLRL328Eog=;
        b=m5QvS6b9UKW2jepjYsi3E0HInhHFejWF2drz8QgMtDuhrvSswjAHKO0z/iHqWQZnGsW/mn
        JWClHzqHotLspB1Jfr/G71iuoMqduk5l6elswZ5wXBviT0ijZXg940f7dz9nUZ29gTQ6fk
        dCe0xJDnGP4rXGC/vbUzDffElvS6xFms76zvc5qTQ1aBxtvbt7PnugHwyTmwRKMmgl3o8M
        GZRaRnYQRXtI3mcDSswD4RkgB9URrBzjFbhtI7OhSwdz6s6hAQgt0lgwWA42qYr9DxPRMm
        Un72SIHYzKaQUhsSgVsj/ZdYkrnxMwpD0sZ8drOLfDOT3v9RRjvn2n+YJNv1BA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1671723731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ih6VrsxX6xsnaFe2iTJFmjZ8gev/py4lccLRL328Eog=;
        b=xP3mL+OXBh4Dh0FeGyUo6iIcfmh+DAxj71xS5EKEsw6EzX8jcoafqU/uc2oJAXRQyTj1ez
        hrrZdjXCy+hI9mCg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 5/6] printk: introduce
 console_get_next_message() and console_message
In-Reply-To: <20221221202704.857925-6-john.ogness@linutronix.de>
References: <20221221202704.857925-1-john.ogness@linutronix.de>
 <20221221202704.857925-6-john.ogness@linutronix.de>
Date:   Thu, 22 Dec 2022 16:47:39 +0106
Message-ID: <87bknva1jg.fsf@jogness.linutronix.de>
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

On 2022-12-21, John Ogness <john.ogness@linutronix.de> wrote:
> +static bool console_emit_next_record(struct console *con, bool *handover, int cookie)
> +{
> +	bool is_extended = console_srcu_read_flags(con) & CON_EXTENDED;
> +	static char dropped_text[DROPPED_TEXT_MAX];
> +	static struct console_buffers cbufs;
> +	static struct console_message cmsg = {
> +		.cbufs = &cbufs,
> +	};

@cmsg should not be static. The whole point of the console_message
wrapper struct is so that it can sit on the stack.

John Ogness
