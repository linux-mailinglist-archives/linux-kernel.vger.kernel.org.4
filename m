Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F196F88FB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbjEESuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbjEESt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 14:49:56 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4E518FD3;
        Fri,  5 May 2023 11:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1683312593;
        bh=UMXAl51MhZ0yCNriCqSE7/JYDFRhFv3fKnFkJrwV+n4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=StLBdLkztVdvX7Gof+vMkAYfLKSQH9lkrk7QcF+G7Az0ErtHLyb6k0yTPonNzEJkD
         GpnEEZphGvLt4o1H8d6pB1u1rnBh2idI59+HEya3Qa4GdxCPkEi5es7bijVUaJN6N7
         016u7wfriS6A5oyiaFYjrpY1esWa21/uzSfO7y7gYrqwZ2WqTESKFDK6p3bBqBR2ka
         A/L5eE2w8cq/qoTOQTk23x6Cbzu12xEKn76mzE3oAJQ487plkoHhVyMAscnX8pbl/9
         kOhtJAPX9Tk4LxWe/hIQyvZRLXYfPtjQ+jIIVhaoJC5DcPJui9kmtVNbkqsKrlTkpR
         NP+0Tqdp9Avww==
Received: from [172.16.0.99] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QCfr11yNTz1233;
        Fri,  5 May 2023 14:49:53 -0400 (EDT)
Message-ID: <3cc72a67-d648-0040-6f60-37663797e360@efficios.com>
Date:   Fri, 5 May 2023 14:49:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 12/13] blk-mq.h: Fix parentheses around macro
 parameter use
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
References: <20230504200527.1935944-1-mathieu.desnoyers@efficios.com>
 <20230504200527.1935944-13-mathieu.desnoyers@efficios.com>
 <3b017a9f-220d-4da8-2cf6-7f0d6175b30c@efficios.com>
 <CAHk-=wjzpHjqhybyEhkTzGgTdBP3LZ1FmOw8=1MMXr=-j5OPxQ@mail.gmail.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <CAHk-=wjzpHjqhybyEhkTzGgTdBP3LZ1FmOw8=1MMXr=-j5OPxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-05 14:40, Linus Torvalds wrote:
> On Fri, May 5, 2023 at 6:56 AM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> Which way do we want to go with respect to the rvalue of the assignment
>> operator "=" in a macro ? (with or without parentheses)
>>
>> In short:
>>
>> #define m(x) do { z = (x); } while (0)
>>
>> or
>>
>> #define m(x) do { z = x; } while (0)
> 
> I suspect that the first one is preferred, just as a "don't even have
> to think about it" thing.
> 
> In general, despite my suggestion of maybe using upper-case to show
> odd syntax (and I may have suggested it, but I really don't like how
> it looks, so I'm not at all convinced it's a good idea), to a
> first-order approximation the rule should be:
> 
>   - always use parentheses around macros
> 
>   - EXCEPT:
>       - when used purely as arguments to functions or other macros
>       - when there is some syntax reason why it's not ok to add parens

I would add to this list of exceptions cases where the argument is used 
as an expression within brackets, e.g.

#define m(x) myvar[x]

Because the content within the brackets is already an expression.

The other exception I would add is when a parameter is used as an 
lvalue, as:

#define m(x) do { x = 2; } while (0)

because I cannot find a case where it would cause unexpected operator 
precedence.

Are you OK with those 2 additional exceptions ?

> 
> The "arguments to functions/macros" is because the comma separator
> between arguments isn't even a operator (ie it is *not* a
> comma-expression, it's multiple expressions separated by commas).
> There is no "operator precedence" subtlety.

Good point.

> 
> So we have a lot of macros that are just wrappers around functions (or
> other macros), and in that situation you do *not* then add more
> parentheses, and doing something like
> 
>      #define update_screen(x) redraw_screen(x, 0)
> 
> is fine, and might even be preferred syntax because putting
> parentheses around 'x' not only doesn't buy you anything, but just
> makes things uglier.
> 
> And the "syntax reasons" can be due to the usual things: we not only
> have that 'pass member name around' issue, but we have things like
> string expansion etc, where adding parentheses anywhere to things like
> 
>      #define __stringify_1(x...)     #x
>      #define __stringify(x...)       __stringify_1(x)
> 
> would obviously simply not work (or look at our "SYSCALL_DEFINEx()"
> games for more complex examples with many layers of token pasting
> etc).
> 
> But in general I would suggest against "this is the lowest priority
> operator" kind of games. Nobody remembers the exact operator
> precedence so well that they don't have to think about it.
> 
> So for example, we have
> 
>      #define scr_writew(val, addr) (*(addr) = (val))
> 
> to pick another VT example, and I think that's right both for 'addr'
> (that requires the parentheses) and for 'val' (that might not require
> it, but let's not make people think about it).

Indeed, brain power and reviewer time is a scarce resource. It's a shame 
to waste it on figuring out operator priority again and again.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

