Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283B974E9B0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjGKJBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjGKJBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:01:41 -0400
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCB310FF
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:01:34 -0700 (PDT)
Received: from [192.168.108.81] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id BE6B02003C6;
        Tue, 11 Jul 2023 11:01:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1689066092;
        bh=kzLwFEZiiwK9VWldSuslytwZfQEdKH1LYg5EawYSmjQ=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=YFIe1QKymp3K6OhI+PW3VS6QUKiUiicO6XH7GZNOeW0weanp9MkZQQ/Ur2AlHwoM4
         OoHGgoNsGXeo4sb2u6ijsoDw+7SVgD+20f6p5lknaoC8ZSTfld+1/MFJHHCq/IrsKg
         2mYRSPZ8uEARrj2Hs59VVU/kx7aiEbcaQMH8Vfpjqc5dyjYIQ+ztxD00kUKkgOwenG
         8NZIFf9QEoueKfwlW5PXvZsuzBOPw1RghnP19bq6X7OAQtCyRoJto/gh6AcShkwifo
         cuQ0QfUcKZzt7Oe7bQ1alqg4ALBO/2NMNKa+j7DqDlKKLZxElK53g0SthBxi8GmAtM
         QJ1WTa2Zp//lw==
Message-ID: <0caa0a41-4eb9-1683-8aa5-cc830b12dfe3@free.fr>
Date:   Tue, 11 Jul 2023 11:01:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: RFC: Faster memtest (possibly bypassing data cache)
Content-Language: en-US
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Vladimir Murzin <vladimir.murzin@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tomas Mudrunka <tomas.mudrunka@gmail.com>,
        HPeter Anvin <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
References: <b74d93bc-ed02-4019-e5e4-0841bdceb44c@free.fr>
In-Reply-To: <b74d93bc-ed02-4019-e5e4-0841bdceb44c@free.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2023 17:41, Marc Gonzalez wrote:

> Hello,
> 
> When dealing with a few million devices (x86 and arm64),
> it is statistically expected to have "a few" devices with
> at least one bad RAM cell. (How many?)
> 
> For one particular model, we've determined that ~0.1% have
> at least one bad RAM cell (ergo, a few thousand devices).
> 
> I've been wondering if someone more experienced knows:
> Are these RAM cells bad from the start, or do they become bad
> with time? (I assume both failure modes exist.)
> 
> Once the first bad cell is detected, is it more likely
> to detect other bad cells as time goes by?
> In other words, what are the failure modes of ageing RAM?
> 
> 
> Closing the HW tangent, focusing on the SW side of things:
> 
> Since these bad RAM cells wreak havoc for the device's user,
> especially with ASLR (different stuff crashes across reboots),
> I've been experimenting with mm/memtest.c as a first line
> of defense against bad RAM cells.
> 
> However, I have a run into a few issues.
> 
> Even though early_memtest is called, well... early, memory has
> already been mapped as regular *cached* memory.
> 
> This means that when we test an area smaller than L3 cache, we're
> not even hitting RAM, we're just testing the cache hierarchy.
> I suppose it /might/ make sense to test the cache hierarchy,
> as it could(?) have errors as well?
> However, I suspect defects in cache are much more rare
> (and thus detection might not be worth the added run-time).
> 
> On x86, I ran a few tests using SIMD non-temporal stores
> (to bypass the cache on stores), and got 30% reduction in run-time.
> (Minimal run-time is critical for being able to deploy the code
> to millions of devices for the benefit of a few thousand users.)
> AFAIK, there are no non-temporal loads, the normal loads probably
> thrashed the data cache.
> 
> I was hoping to be able to test a different implementation:
> 
> When we enter early_memtest(), we remap [start, end]
> as UC (or maybe WC?) so as to entirely bypass the cache.
> We read/write using the largest size available for stores/loads,
> e.g. entire cache lines on recent x86 HW.
> Then when we leave, we remap as was done originally.
> 
> Is that possible?
> 
> Hopefully, the other cores are not started at this point?
> (Otherwise this whole charade would be pointless.)
> 
> To summarize: is it possible to tweak memtest to make it
> run faster while testing RAM in all cases?

Hello again,

I had a short chat with Robin on IRC.

He said trying to bypass the cache altogether was a bad idea(TM)
performance-wise. Do others agree with this assessment? :)

Would like to read people's thoughts about the whole thing.

What is the kernel API to flush a kernel memory range to memory?

  int flush_cache_to_memory(void *va_start, void *va_end);

On aarch64, I would test LDNP/STNP. Possibly also LD4/ST4.

Regards,

Marc

