Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E03665CF0E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbjADJHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbjADJGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:06:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F298CB1B
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 01:06:42 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672823200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sU4x9/BqxCUthBYuCLU8Ml8yQvKGj5tCmV4eN7Bf/NI=;
        b=P/R+Pd8OylSV3wtqOlk+AgYv4gDqcOHAG8CQcVLa94ON3OwBo56xSfJ16rfNKUelUER3lE
        q0mNeF1tEapi4wXdDD+RdRBERv+DG6Rx9e4N9cGk/UKco2GAIyBlv6tnkp3LNjEmsQ0k8v
        QmZxUjZCglzE8kCr/a1kXTSE12+OCU2qudWT/I72FVf1DuH+Wkbl29tavZ9P4qHTKzi7ty
        HD9uDFRNbzye8z5AkoKQ2VCnrRNKyMLJnXnhZh/bnIcwFtGMMCfKmmqDWwfEq8MLiKuCAe
        S0pBy6/oZcBHhNq9RpeOeLm2rjeGg5KQXhsiDQ+BSnfXlx4qEQVdctkeUjHcmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672823200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sU4x9/BqxCUthBYuCLU8Ml8yQvKGj5tCmV4eN7Bf/NI=;
        b=MKAVTSb6e76zqE2U/1AUr5tC8DRw8t20OcCpF9CNy2MZj7Kr0mTACper0nN6GoAHhvPKoo
        4it6dg2aO4MhR9DA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 6/6] printk: introduce
 console_prepend_dropped() for dropped messages
In-Reply-To: <Y7RUF1zhmJEJKWl3@alley>
References: <20221221202704.857925-1-john.ogness@linutronix.de>
 <20221221202704.857925-7-john.ogness@linutronix.de>
 <Y7MEDmP1zqWblj0N@alley> <87y1qjdimw.fsf@jogness.linutronix.de>
 <Y7QtusGlIX3AU+TN@alley> <87o7rfd96w.fsf@jogness.linutronix.de>
 <Y7Q4u9ICptw0RnXb@alley> <87fscrd5os.fsf@jogness.linutronix.de>
 <Y7RUF1zhmJEJKWl3@alley>
Date:   Wed, 04 Jan 2023 10:12:01 +0106
Message-ID: <874jt6fz46.fsf@jogness.linutronix.de>
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
>> Unless you think it is OK to kmalloc 8KB instead of 1KB for the
>> syslog calls. Then yes, we do not need SYSLOG_MESSAGE_MAX.
>
> IMHO, it is acceptable and even correct. syslog uses the same
> prefixes as console. It would make sense to use the same
> buffers for formatting.
>
> That said, 8kB looks non-necessary big to me.
>
> It seems that it comes from devkmsg interface, see the commit
> d43ff430f434d862db59582 ("printk: guard the amount written
> per line by devkmsg_read()"). It was supposed to include
> the message, the extended prefix and dictionary, where
>
>    + message is limited by LOG_LINE_MAX
>    + prefix includes few well defined fields (should be < 128B)
>    + dictionary comes from dev_printk() => ( < 128B as well)
>
> I believe that 2kB or 4kB would be perfectly fine.

The main issue is multi-line records. Normal messages become _much_
larger than extended messages in this case because they add a prefix per
'\n', whereas extended messages just use "\x0a". Extended messages
really could only end up being significantly longer than normal messages
if there are many non-printable characters in the message. But AFAIK
non-printables are not really used in printk messages.

So IMHO it does not make sense that normal messages are limited to 1KB
but extended messages can use 8KB. I agree that a universal limit of 2KB
for normal/extended/syslog would be a nice compromise. Normal messages
will have more space available and it will reduce the overall static
buffer usage. It would mean that syslog calls will kmalloc 2KB instead
of 1KB, but I expect that should be acceptable since, generally
speaking, overall we are reducing memory usage.

John
