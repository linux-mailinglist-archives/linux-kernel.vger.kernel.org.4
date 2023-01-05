Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343FF65EE0A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbjAEN55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234239AbjAEN5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:57:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB1150F5E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 05:56:10 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672926968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/sIatotjJUdFh+rLaqBhsOp82C9DkXXeUSI88pC2wMQ=;
        b=tKbhHoYA15Dd2DKj+LbkG8ogGrd5rC1zAHRutJjK5T+Y8veV1e7EqYQkfASMFnvijMcfbN
        ejzluB3l0b+IhOIC1O+bDJeRQp6laLp2s1L/KuOd7GgNPyRrU9u3mk8nU2i9KNa7xXwTwH
        DpqxDWTFUBK/djmdfiF0r6xtRMI/jkM8viPufUqYuK/+HLNe+H1nNIQcsu+7iFpNecq08t
        KMb0uyKlw+5XkAQfZc1l/K9s4Wal4N3oEzCC9ejBaxsou+gXGAxWGrwJoX6hEgKvHBojIn
        hovEocqZ3mTly0K/g5WhqLgUVwxYnhN77UyXBizrOL9WsGU+VrrJUba55iiSbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672926968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/sIatotjJUdFh+rLaqBhsOp82C9DkXXeUSI88pC2wMQ=;
        b=jGuJbd3Q9omAGinUHrftA9GNZEoPsIzbq8o5o9m5WJje6IMnjqr3kOaMjaViRI+11YEQ8s
        bhl6ki37r1CEKSDg==
To:     kernel test robot <lkp@intel.com>, Petr Mladek <pmladek@suse.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 6/6] printk: introduce
 console_prepend_dropped() for dropped messages
In-Reply-To: <202301052114.vvN3wQoH-lkp@intel.com>
References: <20221221202704.857925-7-john.ogness@linutronix.de>
 <202301052114.vvN3wQoH-lkp@intel.com>
Date:   Thu, 05 Jan 2023 15:01:28 +0106
Message-ID: <877cy1cchb.fsf@jogness.linutronix.de>
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

On 2023-01-05, kernel test robot <lkp@intel.com> wrote:
> smatch warnings:
> kernel/printk/printk.c:2735 console_prepend_dropped() warn: always true condition '(cmsg->outbuf_len + len >= outbuf_sz) => (0-u64max >= 0)'

Thank you kernel test robot, but actually this code will never be hit
when outbuf_sz is 0. Explanation below.

> vim +2735 kernel/printk/printk.c
>
>   2701	
>   2702	/*
>   2703	 * Prepend the message in @cmsg->cbufs->outbuf with a "dropped message". This
>   2704	 * is achieved by shifting the existing message over and inserting the dropped
>   2705	 * message.
>   2706	 *
>   2707	 * @cmsg is the console message to prepend.
>   2708	 *
>   2709	 * @dropped is the dropped count to report in the dropped message.
>   2710	 *
>   2711	 * If the message text in @cmsg->cbufs->outbuf does not have enough space for
>   2712	 * the dropped message, the message text will be sufficiently truncated.
>   2713	 *
>   2714	 * If @cmsg->cbufs->outbuf is modified, @cmsg->outbuf_len is updated.
>   2715	 */
>   2716	static void console_prepend_dropped(struct console_message *cmsg, unsigned long dropped)
>   2717	{
>   2718		struct console_buffers *cbufs = cmsg->cbufs;
>   2719		const size_t scratchbuf_sz = sizeof(cbufs->scratchbuf);
>   2720		const size_t outbuf_sz = sizeof(cbufs->outbuf);
>   2721		char *scratchbuf = &cbufs->scratchbuf[0];
>   2722		char *outbuf = &cbufs->outbuf[0];
>   2723		size_t len;
>   2724	
>   2725		len = snprintf(scratchbuf, scratchbuf_sz,
>   2726			       "** %lu printk messages dropped **\n", dropped);
>   2727	
>   2728		/*
>   2729		 * Make sure outbuf is sufficiently large before prepending. Space
>   2730		 * for a terminator is also counted in case truncation occurs.
>   2731		 */
>   2732		if (WARN_ON_ONCE(len + 1 >= outbuf_sz))
>   2733			return;

If outbuf_sz is 0, the above check will return. It is interesting that
smatch did not complain about this line instead. I suppose the
WARN_ON_ONCE confused it.

Note that if outbuf_sz is 0, then CONFIG_PRINTK is undefined. In that
case this function should not be called anyway. So the check and warning
are appropriate here.

>   2734	
>> 2735		if (cmsg->outbuf_len + len >= outbuf_sz) {

John Ogness
