Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143FF74F33F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjGKPXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjGKPXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:23:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958DB120
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:23:48 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689089026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DWbO1Q44FIPTU4N/HOQTcbw3hKIu3NjTIDNtiAhWGKQ=;
        b=Som3JxKCnmruK0WXH+8VKj8Zp9tA5Gq+AW54Yx1PiJf2Kij2L9E24VqmYxxc4LFM+RAASg
        7SU9Fj3hLf3o8dauLNYob/LXQdeknKEiVUbo0X7WTxGhqGjFHy9lVCTqsiL+7muWHzpyvU
        T1JIhnhrDYoxMbTZ5vexvNSS1OHIMusumJE2uLG8Ornu4L6hLArGb/gHyVOqePbIHQw5kX
        aD3nNROSh4O8HMOwR5lkonMqTrpyTKgYAw4HSwhpfgGobbVT+gBlQDDN927AWW45YNp/JQ
        OT3ax5gvJ9AVAWaR4cCtEQM8imy1Ar5OnhZsXqAyAmll7c4F1YpvMZoQW3f44g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689089026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DWbO1Q44FIPTU4N/HOQTcbw3hKIu3NjTIDNtiAhWGKQ=;
        b=XTw7SoGTF1RI/3t9zbP1W0dNHhSDRUkX1Z7F2M35Ots5PBJr6i3caah4mNOclef6ZYf7Oe
        W/SR9i+cljyFLrBQ==
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 4/5] printk: Add per-console suspended state
In-Reply-To: <20230711150819.GC12154@google.com>
References: <20230710134524.25232-1-john.ogness@linutronix.de>
 <20230710134524.25232-5-john.ogness@linutronix.de>
 <20230711150819.GC12154@google.com>
Date:   Tue, 11 Jul 2023 17:29:43 +0206
Message-ID: <877cr6pj40.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-12, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
>> @@ -2623,8 +2647,6 @@ void console_lock(void)
>>  		msleep(1000);
>>  
>>  	down_console_sem();
>> -	if (console_suspended)
>> -		return;
>>  	console_locked = 1;
>>  	console_may_schedule = 1;
>>  }
>> @@ -2645,10 +2667,6 @@ int console_trylock(void)
>>  		return 0;
>>  	if (down_trylock_console_sem())
>>  		return 0;
>> -	if (console_suspended) {
>> -		up_console_sem();
>> -		return 0;
>> -	}
>>  	console_locked = 1;
>>  	console_may_schedule = 0;
>>  	return 1;
>
> Interesting. console_locked previously would not be set if
> console is suspended, but now it's always set, which in theory
> changes the way WARN_CONSOLE_UNLOCKED() macro works in some
> cases?

Yes, Petr mentioned [0] this during the v1 review. His direct comment:

  "console_locked" seems to be used only in WARN_CONSOLE_UNLOCKED().
  I could imagine a corner case where, for example, "vt" code does
  not print the warning because it works as it works. But it does
  not make much sense. IMHO, such a code should get fixed. And it
  is just a warning after all.

And his final comment in that thread:

  I believe that @console_suspended is not longer needed.
  Let's replace it with the per-console flag and do not worry
  about races.

John Ogness

[0] https://lore.kernel.org/lkml/ZAieQtcs7YEuCCDa@alley
