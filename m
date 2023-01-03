Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2706E65BDEC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236991AbjACKWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237383AbjACKVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:21:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BCD641D
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 02:21:02 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672741261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xaFdqkmUa2xw274BNG9FQW1T/HjWKx1XdMMyVmWq9As=;
        b=nrTAgLCi+Szd6JdsAW6y+kJrxSCzomfLrIXGBE6/Aagx4UVapBUohiLM6114fmmy2Bn8Y+
        UHgtTZ1CZvd+nAFqHzFHmzqIcK95qt2abQbzm4UQ75CRXTkdaDp1zc+ufDUv6pYDi5598L
        bUW8hymMVaqgkUShbC4ctjK4gwR9jyPLfBMv6IuT00MmN45SRhv1qDAU6Q4K5pNowTbrtk
        kxbHUDkUDMT4taJCsw6cxmmUPDxn4ksqHOvYfeygV+0tQM4Acnfa9GXbzoWLQOYj4WxyPG
        2VLvDV7egA2XlMNQVnkfzvFnbHhr/hawXvbfsCw5E31iqZq1WkrdB7JLtFkVyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672741261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xaFdqkmUa2xw274BNG9FQW1T/HjWKx1XdMMyVmWq9As=;
        b=eOxCVYhcOfUIJYna85+1GHJCxARXqXP0NIKRre3LRECWdpSbOk/lR2F+PJeZZPJU7ms9cM
        AScva6rW5CXX/aDQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 6/6] printk: introduce
 console_prepend_dropped() for dropped messages
In-Reply-To: <Y7MEDmP1zqWblj0N@alley>
References: <20221221202704.857925-1-john.ogness@linutronix.de>
 <20221221202704.857925-7-john.ogness@linutronix.de>
 <Y7MEDmP1zqWblj0N@alley>
Date:   Tue, 03 Jan 2023 11:26:23 +0106
Message-ID: <87y1qjdimw.fsf@jogness.linutronix.de>
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

On 2023-01-02, Petr Mladek <pmladek@suse.com> wrote:
>> +static void console_prepend_dropped(struct console_message *cmsg, unsigned long dropped)
>> +{
>> +	struct console_buffers *cbufs = cmsg->cbufs;
>> +	const size_t scratchbuf_sz = sizeof(cbufs->scratchbuf);
>> +	const size_t outbuf_sz = sizeof(cbufs->outbuf);
>> +	char *scratchbuf = &cbufs->scratchbuf[0];
>> +	char *outbuf = &cbufs->outbuf[0];
>> +	size_t len;
>> +
>> +	len = snprintf(scratchbuf, scratchbuf_sz,
>> +		       "** %lu printk messages dropped **\n", dropped);
>> +
>> +	/*
>> +	 * Make sure outbuf is sufficiently large before prepending. Space
>> +	 * for a terminator is also counted in case truncation occurs.
>> +	 */
>> +	if (WARN_ON_ONCE(len + 1 >= outbuf_sz))
>> +		return;
>
> Strictly speaking, this should be:
>
> 	if (WARN_ON_ONCE(len >= outbuf_sz))
> 		return;
>
> The trailing '\0' will fit into the buffer when len < outbuf_sz.

You are correct.

My concern was that if "@len = @outbuf_sz - 1", the entire message will
be truncated and you will only see the dropped messages text. I wanted
at least 1 character from the message to survive. ;-)

How about the commments:

	/*
	 * Make sure outbuf is sufficiently large before prepending. Space
	 * for a terminator and at least 1 byte of the message is also
	 * checked in case truncation is needed.
	 */

John
