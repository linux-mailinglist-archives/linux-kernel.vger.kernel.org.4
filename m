Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A6263402A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 16:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbiKVP14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 10:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbiKVP1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 10:27:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E608E6A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 07:27:49 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669130867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9J6kHO0AGc0+BKAMdnuPyQkVRH1YnWCEE6DJYfiBZt4=;
        b=U4h4SKthzt0oiIfxFxr/UWls6HI9rW7TbNlbeWyKEU8cCLFIuPxzaOMwilRco5UJl9HHNf
        yGn8wf7OokByxhoZxqtgqHW0FmjW2/6tnn8VPzVbzpE6IctLgKbmjh3P5Gqe0ejAk4+o8K
        HPX80SWuRpH1CzGZRwZtXtjFNMAreHqK6loqtgJf0oQn1WhqAXjtQS0Q/ccO/IHvFzA0Mq
        SJaY8/tCuLr13n+mZaGmOCGouQCDEfM+q0+D0Sbqc6k7xWGERaISYwmgjfqog3vlTFnEVn
        uudkECRDjksMWTF2dO4cVjBPAFMoiCXZknkvcvqD2Au5UILeJrwW8d0KBaigxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669130867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9J6kHO0AGc0+BKAMdnuPyQkVRH1YnWCEE6DJYfiBZt4=;
        b=s+zCgtdBlYvjw/siI4T6dQMbUFyLkT+Rkf57vhntvTiBY5BWFSlwWTH/XhYaYb99BQUZwN
        2EZJX0GjwpRtdKCw==
To:     paulmck@kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: next-20221122: tinyconfig: ppc n s390:
 kernel/printk/printk.c:95:1: error: type specifier missing, defaults to
 'int'; ISO C99 and later do not support implicit int
 [-Werror,-Wimplicit-int]
In-Reply-To: <20221122144839.GI4001@paulmck-ThinkPad-P17-Gen-1>
References: <CA+G9fYvCWwndXdsvuW7iJ25wgfN6_iMY-OC_z6ufSwiJkzFFMw@mail.gmail.com>
 <87o7szoyij.fsf@jogness.linutronix.de>
 <20221122144839.GI4001@paulmck-ThinkPad-P17-Gen-1>
Date:   Tue, 22 Nov 2022 16:33:39 +0106
Message-ID: <87leo3ovpw.fsf@jogness.linutronix.de>
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

On 2022-11-22, "Paul E. McKenney" <paulmck@kernel.org> wrote:
>> @paulmck: Do you have a problem with permanently activating CONFIG_SRCU?
>
> The people wanting it separate back in the day were those wanting very
> tiny kernels.  I have not heard from them in a long time, so maybe it
> is now OK to just make SRCU unconditional.

Who decides this? Or maybe I should create a semaphore-based Variant of
console_srcu_read_lock()/console_srcu_read_unlock() for the
"!CONFIG_PRINTK && !CONFIG_SRCU" case?

John
