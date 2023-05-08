Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485E86FB2D3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 16:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234414AbjEHO3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 10:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbjEHO24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 10:28:56 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA9C2129;
        Mon,  8 May 2023 07:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1683556134;
        bh=x/r/GkBuy7Dt3JR/ZxirbXy8mCQ1jBvYhr8UrWAG4jg=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=bkkEqtTvS6agfeG4WKqHNKhvRlBqIo2FussbcNHbOwMU+Xja2iME/yZxuTNLei5Yc
         fhveRJhpOltVgcYaZWLkfkdc5/DvCH82dlvYiKboQG3Ze1lHTByTYJ7OJc48qOKFEH
         aLAQG8l02nCcQmyfw3Q9XktyFPTggnSgavLTtI4+aqoOXn4xy2c0DIpcAxaEoTlCJJ
         vH89bWmJRl5OR8fIr54txHcOQp65IqGqmsEJ3NfDM1HScVJ3EVgrYgJcjIjcCtETlG
         NgsUHSsllVHT5RfIfZq2COkSosBBP1VXkFcSa6GXX7hmctYIghv8Aocq9QCV83fXtn
         ZwTlc9qP0MuZQ==
Received: from [172.16.0.99] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QFNvV0mvdz12H6;
        Mon,  8 May 2023 10:28:54 -0400 (EDT)
Message-ID: <f9137c32-796f-a6c7-c85b-f53f64b214c7@efficios.com>
Date:   Mon, 8 May 2023 10:28:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 12/13] blk-mq.h: Fix parentheses around macro
 parameter use
Content-Language: en-US
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
References: <20230504200527.1935944-1-mathieu.desnoyers@efficios.com>
 <20230504200527.1935944-13-mathieu.desnoyers@efficios.com>
 <3b017a9f-220d-4da8-2cf6-7f0d6175b30c@efficios.com>
 <CAHk-=wjzpHjqhybyEhkTzGgTdBP3LZ1FmOw8=1MMXr=-j5OPxQ@mail.gmail.com>
 <3cc72a67-d648-0040-6f60-37663797e360@efficios.com>
 <CAHk-=wh-x1PL=UUGD__Dv6kd+kyCHjNF-TCHGG9ayLnysf-PdQ@mail.gmail.com>
 <d8dfd1af-5b82-ddd8-24f5-fa9dfbb4b1fb@efficios.com>
 <CAHk-=wg27iiFZWYmjKmULxwkXisOHuAXq=vbiazBabgh9M1rqg@mail.gmail.com>
 <322d22f5-7ab0-adbd-45a0-879364d79ce8@efficios.com>
In-Reply-To: <322d22f5-7ab0-adbd-45a0-879364d79ce8@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've attempted to capture the resulting rules based on our discussion to add this to
coding-style.rst. Please let me know if anything is wrong:

(to be added in section 12) Macros, Enums and RTL)

Always use parentheses around macro arguments, except when:

- they are used as a full expression:
   - as an initializer,
   - as an expression statement,
   - as the controlling expression of a selection statement (``if`` or ``switch``),
   - as the controlling expression of a ``while`` or ``do`` statement,
   - as any of the expressions of a ``for`` statement,
   - as the expression in a return statement,
- they are used as expression within an array subscript operator "[]",
- they are used as arguments to functions or other macros,
- there is some syntax reason why adding the parentheses would not work.

(note: I'm unsure about requiring or not the parentheses around initializers.
Based on C11 section "6.8 Statement and blocks", initializers that are not part of
a compound literal are full expressions, which makes the extra parentheses useless.)

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

