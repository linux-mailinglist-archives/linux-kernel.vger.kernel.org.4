Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390CB62936B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 09:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbiKOIml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 03:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiKOImi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 03:42:38 -0500
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [IPv6:2a01:e0c:1:1599::11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41605582;
        Tue, 15 Nov 2022 00:42:35 -0800 (PST)
Received: from [IPV6:2a01:e35:39f2:1220:da6c:81de:7fd7:e3eb] (unknown [IPv6:2a01:e35:39f2:1220:da6c:81de:7fd7:e3eb])
        by smtp2-g21.free.fr (Postfix) with ESMTPS id 29A2120042C;
        Tue, 15 Nov 2022 09:42:25 +0100 (CET)
Message-ID: <9ffb34a9-3cbc-bd0e-7a92-76851a77b9ef@opteya.com>
Date:   Tue, 15 Nov 2022 09:42:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Yann Droneaud <ydroneaud@opteya.com>
Subject: Re: [PATCH v1 3/5] random: add helpers for random numbers with given
 floor or range
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Theodore Ts'o <tytso@mit.edu>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221022014403.3881893-1-Jason@zx2c4.com>
 <20221022014403.3881893-4-Jason@zx2c4.com>
 <60574e8f-20ff-0996-5558-e9bd35e42681@opteya.com>
 <Y3KLH4FqFbJ7bfY0@zx2c4.com>
Content-Language: fr-FR, en-US
Organization: OPTEYA
In-Reply-To: <Y3KLH4FqFbJ7bfY0@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le 14/11/2022 à 19:38, Jason A. Donenfeld a écrit :
> On Mon, Nov 14, 2022 at 07:04:13PM +0100, Yann Droneaud wrote:
>> I have a bad feeling about this one, and can't help but thinking it's going
>> to bite someone: when asked to pick a number *between* 0 and 10,
>> I usually think I'm allowed to pick 10 (even if I'm going to answer 7 as it should).
> This is one of those bikeshed things you see all over the place, like
> whether slices in a language should be [start index, end index] or
> [start index, length], or whether arrays should be 0-based or 1-based.
> We'll never settle this variety of dispute here.
>
> But in this case, there are some particular reasons why it must be this
> way. Firstly, usage of it this way matches most of the ways the function
> is actually used in the kernel, and fits existing semantics. This alone
> I find compelling. But also, having all of these functions use half-open
> intervals means that each function can take care of its entire range,
> without having to resort to using 64-bit arithmetic, and no function is
> a complete subset of any other function. So doing it this way makes
> these maximally useful too.

For get_random_below(), which replaces a modulo, <bikeshedding> and could
have been called get_random_mod()</bikeshedding>, having an open upper
range seems fine. It's already what can be achieved by the % operator.

But I believe it's unfortunate get_random_between() cannot be called to
get a number up to UINT32_MAX, as get_random_between(0, UINT32_MAX) would
be capped to UINT32_MAX - 1.

When not a constant, one could hope the function can cope with a maximum
that would grow up to and including UINT32_MAX.


> So anyway I think the function has to be defined like this. If you'd
> like to bikeshed over a different name than "between", though, be my
> guest. Maybe you'd like "from" better. But probably "between" is fine,
> and with enough good examples (as my conversion patch does) and the
> clear succinct documentation comment, we should be good.

That the conversion patch [1] that triggered my comment: I find replacing
the following rather unpleasing, somewhat uncanny:

-get_random_u32_below(1024) + 1 + get_random_u32_between(1, 1024 + 1) I 
would prefer
- get_random_u32_below(1024) + 1 + get_random_u32_between(1, 1024) [1]https://lore.kernel.org/lkml/20221114164558.1180362-4-Jason@zx2c4.com/

Regards.

-- 
Yann Droneaud
OPTEYA

