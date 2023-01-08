Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935366619C6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 22:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjAHVMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 16:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjAHVMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 16:12:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A79655F
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 13:12:01 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673212318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rD+xdC78MuBzPnH7D1acX1ZI1y5/EvHp/7v5fVb/k04=;
        b=XjXQXUk53itPVCf02OZ87Zn/4GQV9c+cdSVuK7refuGH7sFCZ6bk+/uk2g5rbXGqKL7jo0
        0uCNbzAb7qyPyCTDfuE8kBjZgOCqSuIRgLZ9RVp+G0tt+lH4DMa3yRgDFh2B92pYgVDRk+
        b7eF2/dCWp3WqvIRSK9DyhPR6ZQThDrEiWACN82Ze5cX0q9zSOcComF5JqFHb3zDaS4hg8
        OCA94edu7BN8WbVn58tvVpxWnuITa9eCHrnFrQLMTKqcrcHSpRMVCuKb7QXsOjtxpSGv+k
        TsIIAVLwDPame6f5iDbV8CNVGYCQDLoQQIn9iFVnwYImvJ7c8EKofqH4+Rco2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673212318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rD+xdC78MuBzPnH7D1acX1ZI1y5/EvHp/7v5fVb/k04=;
        b=C0qrFVPvYRFJ3823IE9cyjOy0hzO+tTno4hqb2yDFF4GBpBYjPoxLuyHIjq+vi5isJCMPR
        WRXPq30rtI36QHCg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v4 7/8 v2] printk: use printk_buffers for devkmsg
In-Reply-To: <Y7f6U8+Kk3VoF5Dk@alley>
References: <20230105103735.880956-1-john.ogness@linutronix.de>
 <20230105103735.880956-8-john.ogness@linutronix.de>
 <87fscpch67.fsf@jogness.linutronix.de>
 <87cz7tch2n.fsf@jogness.linutronix.de> <Y7f6U8+Kk3VoF5Dk@alley>
Date:   Sun, 08 Jan 2023 22:17:15 +0106
Message-ID: <87pmbospe4.fsf@jogness.linutronix.de>
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

On 2023-01-06, Petr Mladek <pmladek@suse.com> wrote:
>> -	if (!prb_read_valid(prb, atomic64_read(&user->seq), r)) {
>> +	while (!printk_get_next_message(&pmsg, atomic64_read(&user->seq), true)) {
>
> A problem is that printk_get_next_message() does not format the
> message when it shoud get supressed on the console.

Nice catch. I missed that.

> I would solve it be adding a parameter to printk_get_next_message()
> that will tell whether to suppress or not, e.g. @can_suppress.

OK.

>>  		if (file->f_flags & O_NONBLOCK) {
>>  			ret = -EAGAIN;
>>  			goto out;
>> @@ -814,36 +814,31 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
>>  		 * This pairs with __wake_up_klogd:A.
>>  		 */
>>  		ret = wait_event_interruptible(log_wait,
>> -				prb_read_valid(prb,
>> -					atomic64_read(&user->seq), r)); /* LMM(devkmsg_read:A) */
>> +					       prb_read_valid(prb, atomic64_read(&user->seq),
>> +							      NULL)); /* LMM(devkmsg_read:A) */
>
> The above change from "if" to "while" could be avoided if we use
> printk_get_next_message() here as well. It looks slightly more
> strightfoward to me.

Yes, that is better. A loop is overkill here.

John
