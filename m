Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BE36BABEB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjCOJSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjCOJSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:18:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92C2710401
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:18:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BECFC2F4;
        Wed, 15 Mar 2023 02:18:44 -0700 (PDT)
Received: from [10.57.64.236] (unknown [10.57.64.236])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B5E03F8C6;
        Wed, 15 Mar 2023 02:18:00 -0700 (PDT)
Message-ID: <765586c5-1009-87b2-094b-2391d0454cd2@arm.com>
Date:   Wed, 15 Mar 2023 09:17:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [BUG] v6.3-rc2 regresses sched_getaffinity() for arm64
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <7d026744-6bd6-6827-0471-b5e8eae0be3f@arm.com>
 <CAHk-=wiQYOroYNzqe36bv3w-2FuTbgs927dNYwpoy3ttKtus_g@mail.gmail.com>
 <CAHk-=whWPcj4QUTqORbT4X2fS+ZD4s5-38t+3=eyxMA_atXv+w@mail.gmail.com>
 <CAHk-=whaMzSk6kjxUMvOKK=T2EKWmcyJ_QV0JCowos4pM2a7yw@mail.gmail.com>
Content-Language: en-US
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAHk-=whaMzSk6kjxUMvOKK=T2EKWmcyJ_QV0JCowos4pM2a7yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/2023 02:48, Linus Torvalds wrote:
> On Tue, Mar 14, 2023 at 6:35 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> So this does look  like purely a sched_getaffinity() thing (including
>> the compat handling for same).
>>
>> And I can see why sched_getaffinity() uses cpumask_size(): we have no
>> other good helper for this.
> 
> I decided that the cleanest fix is to just keep the cpumask_size() use
> as-is, and just use zalloc_cpumask_var() to make sure the cpumask is
> fully initialized.
> 
> Yes, we could play games with the exact size, but there just isn't any
> excuse for it. Either it's a small on-stack allocation that gets
> copied to user space (in which case we really are better off just
> initializing it instead of doing anything clever), or it's an explicit
> allocation due to the x86-64 MAXSMP case (in which case zeroing the
> allocation is the least of our problems).
> 
> And zeroing the cpumask was what other somewhat similar cases seemed
> to be doing, so it's consistent.

Thanks for the fast response and clear explanation! FWIW, the fix you committed
looks sensible to me.

> 
> I've pushed out my fix. It looks ObviouslyCorrect(tm), but it would be
> good to get verification that it does indeed fix things for you.

I tested at 6015b1aca1a233379625385feb01dd014aca60b5 and all looks good now, so:

Tested-by: Ryan Roberts <ryan.roberts@arm.com>

> 
> Because sometimes things look a bit more obvious than they actually are ;)
> 
>               Linus

