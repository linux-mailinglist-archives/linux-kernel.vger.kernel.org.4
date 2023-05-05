Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9416F8A01
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 22:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjEEUIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 16:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjEEUIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 16:08:09 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4133A90;
        Fri,  5 May 2023 13:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1683317283;
        bh=MxlloURjFSjx/Iu9Sthcv41R+IrnMYZ51QIlmN0ptqA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XWlYikXBWNXZZ71IfRCspwZtHRfUa5pEwzz5/jtkSmLUNxEI5lD63dMi6MalkJeE7
         f6zGNcnNl+w4mXon5lX6SO160AkqumZD5g5r0vfiFcSBD3csRQbQPGtej/X1gByLFl
         TW+Q2/M+e1Qgwdapelwn4C+CxbvvZat62J3BzfbgUd/CotFpLsPmbQqsU5HNZpi3eq
         m7A5+7IQrHlHeLkfbvU4YqoEP7NQviGfCdlW9iNlQSlSseBGCTeXibDo1gKw+I2cWC
         HfPxPNBrDmAGEjO7BZmEfgIl+ypsc/orqsOgkcMdUq2pIFtv/WS0C5T4ja6vzZbUl6
         VGajGaWhfZWHQ==
Received: from [172.16.0.99] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QChZC4hqvz123B;
        Fri,  5 May 2023 16:08:03 -0400 (EDT)
Message-ID: <d8dfd1af-5b82-ddd8-24f5-fa9dfbb4b1fb@efficios.com>
Date:   Fri, 5 May 2023 16:08:07 -0400
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
 <3cc72a67-d648-0040-6f60-37663797e360@efficios.com>
 <CAHk-=wh-x1PL=UUGD__Dv6kd+kyCHjNF-TCHGG9ayLnysf-PdQ@mail.gmail.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <CAHk-=wh-x1PL=UUGD__Dv6kd+kyCHjNF-TCHGG9ayLnysf-PdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-05 15:54, Linus Torvalds wrote:
> On Fri, May 5, 2023 at 11:49 AM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:

[...]

>> The other exception I would add is when a parameter is used as an
>> lvalue, as:
>>
>> #define m(x) do { x = 2; } while (0)
> 
> I really don't understand why you think '=' is so special. It's very
> much not special.
> 
> It happens to have the lowest precedence, sure, but the keyword is "happens".
> 
> I think you are confused by the non-C languages that make assignment
> be not an expression operator, but a statement.

The reason why I think the lvalue of a "=" operator can be argued to be 
"special" is because it is simply invalid to apply many of the C 
operators to an lvalue (e.g. +, -, /, ...), which leads me to think that 
there are no valid lvalue parameters which can cause unexpected operator 
precedence.

That being said, just having to *think* about it is wasted brain power, 
so I am in favor of just adding the parentheses for lvalues as well.

> So I think you are technically correct in that the parentheses aren't
> _needed_, but the above is still the same case that in many other
> situations parentheses aren't technically *needed*, but not having to
> think about it is better than having to do so.

Yes, so no exception for the lvalue of an assignment, therefore giving:

#define m(x) do { (x) = 2; } while (0)

If we are OK with this, I will go ahead and update my patch set accordingly.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

