Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEDE748834
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjGEPlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGEPlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:41:18 -0400
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [IPv6:2a01:e0c:1:1599::15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9F2171D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 08:41:17 -0700 (PDT)
Received: from [IPV6:2a02:8428:2a4:1a01:e930:cb1d:5289:8ae5] (unknown [IPv6:2a02:8428:2a4:1a01:e930:cb1d:5289:8ae5])
        (Authenticated sender: marc.w.gonzalez@free.fr)
        by smtp6-g21.free.fr (Postfix) with ESMTPSA id C9A987803B1;
        Wed,  5 Jul 2023 17:41:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1688571674;
        bh=CA3gCAHvSvyVtQtdw9a5nZjjhlRWF6CDKaN5Y6rWae8=;
        h=Date:To:From:Cc:Subject:From;
        b=eINM56G+GjgTYwJloBp/bafwfUfwEV/jZ3O7+kMQkG6+e/F0WAXnVJHmjMJ5oPcoB
         L6BNVSWDPvCujdKq4xUNBQSyvGrrQBP9pOaEszY32JNLe7pV2XtSpMsZdFt8DChLRo
         bI3AXGLQUP0HW1Ls1q3LN3OlzNZcIOGNwR2JVjF5aB2xixR/RABb2awjB27nhBkGer
         CMqyqU9Bzt/EhcCYZVfKZLa8/8Fc4GFZQfg8vTuNYkwou79LMEokqAsobsGpWwTQEi
         OHtCPlbvZN8BYm3KG5zpvCxD1YIDwxZ8Zs8thHBJQOz9AsO5dFb5AxhDjuiVGlHato
         +UmaPCaO8GA2g==
Message-ID: <b74d93bc-ed02-4019-e5e4-0841bdceb44c@free.fr>
Date:   Wed, 5 Jul 2023 17:41:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: fr, en-US
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Vladimir Murzin <vladimir.murzin@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Tomas Mudrunka <tomas.mudrunka@gmail.com>,
        HPeter Anvin <hpa@zytor.com>, Arnd Bergmann <arnd@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: RFC: Faster memtest (possibly bypassing data cache)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When dealing with a few million devices (x86 and arm64),
it is statistically expected to have "a few" devices with
at least one bad RAM cell. (How many?)

For one particular model, we've determined that ~0.1% have
at least one bad RAM cell (ergo, a few thousand devices).

I've been wondering if someone more experienced knows:
Are these RAM cells bad from the start, or do they become bad
with time? (I assume both failure modes exist.)

Once the first bad cell is detected, is it more likely
to detect other bad cells as time goes by?
In other words, what are the failure modes of ageing RAM?


Closing the HW tangent, focusing on the SW side of things:

Since these bad RAM cells wreak havoc for the device's user,
especially with ASLR (different stuff crashes across reboots),
I've been experimenting with mm/memtest.c as a first line
of defense against bad RAM cells.

However, I have a run into a few issues.

Even though early_memtest is called, well... early, memory has
already been mapped as regular *cached* memory.

This means that when we test an area smaller than L3 cache, we're
not even hitting RAM, we're just testing the cache hierarchy.
I suppose it /might/ make sense to test the cache hierarchy,
as it could(?) have errors as well?
However, I suspect defects in cache are much more rare
(and thus detection might not be worth the added run-time).

On x86, I ran a few tests using SIMD non-temporal stores
(to bypass the cache on stores), and got 30% reduction in run-time.
(Minimal run-time is critical for being able to deploy the code
to millions of devices for the benefit of a few thousand users.)
AFAIK, there are no non-temporal loads, the normal loads probably
thrashed the data cache.

I was hoping to be able to test a different implementation:

When we enter early_memtest(), we remap [start, end]
as UC (or maybe WC?) so as to entirely bypass the cache.
We read/write using the largest size available for stores/loads,
e.g. entire cache lines on recent x86 HW.
Then when we leave, we remap as was done originally.

Is that possible?

Hopefully, the other cores are not started at this point?
(Otherwise this whole charade would be pointless.)

To summarize: is it possible to tweak memtest to make it
run faster while testing RAM in all cases?

Regards,

Marc Gonzalez
