Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256A674D39A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjGJKgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjGJKgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:36:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0823AAF
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 03:36:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB2AE2B;
        Mon, 10 Jul 2023 03:37:30 -0700 (PDT)
Received: from [10.57.77.63] (unknown [10.57.77.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 660A03F740;
        Mon, 10 Jul 2023 03:36:46 -0700 (PDT)
Message-ID: <a6e0a493-1a1c-2e17-ad05-6a361e0f84bd@arm.com>
Date:   Mon, 10 Jul 2023 11:36:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 0/3] support large folio for mlock
To:     Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
Cc:     Yin Fengwei <fengwei.yin@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yuzhao@google.com,
        shy828301@gmail.com, akpm@linux-foundation.org
References: <20230707165221.4076590-1-fengwei.yin@intel.com>
 <ZKhK1Ic1KCdOLRYm@casper.infradead.org>
 <4bb39d6e-a324-0d85-7d44-8e8a37a1cfec@redhat.com>
 <ZKhiGLpIWi5Z2WnY@casper.infradead.org>
 <5c9bf622-0866-168f-a1cd-4e4a98322127@redhat.com>
 <ZKhm/LDJ0X/o3BYG@casper.infradead.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZKhm/LDJ0X/o3BYG@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/2023 20:26, Matthew Wilcox wrote:
> On Fri, Jul 07, 2023 at 09:15:02PM +0200, David Hildenbrand wrote:
>>>> Sure, any time we PTE-map a THP we might just say "let's put that on the
>>>> deferred split queue" and cross fingers that we can eventually split it
>>>> later. (I was recently thinking about that in the context of the mapcount
>>>> ...)
>>>>
>>>> It's all a big mess ...
>>>
>>> Oh, I agree, there are always going to be circumstances where we realise
>>> we've made a bad decision and can't (easily) undo it.  Unless we have a
>>> per-page pincount, and I Would Rather Not Do That.
>>
>> I agree ...
>>
>> But we should _try_
>>> to do that because it's the right model -- that's what I meant by "Tell
>>
>> Try to have per-page pincounts? :/ or do you mean, try to split on VMA
>> split? I hope the latter (although I'm not sure about performance) :)
> 
> Sorry, try to split a folio on VMA split.
> 
>>> me why I'm wrong"; what scenarios do we have where a user temporarilly
>>> mlocks (or mprotects or ...) a range of memory, but wants that memory
>>> to be aged in the LRU exactly the same way as the adjacent memory that
>>> wasn't mprotected?
>>
>> Let me throw in a "fun one".
>>
>> Parent process has a 2 MiB range populated by a THP. fork() a child process.
>> Child process mprotects half the VMA.
>>
>> Should we split the (COW-shared) THP? Or should we COW/unshare in the child
>> process (ugh!) during the VMA split.
>>
>> It all makes my brain hurt.
> 
> OK, so this goes back to what I wrote earlier about attempting to choose
> what size of folio to allocate on COW:
> 
> https://lore.kernel.org/linux-mm/Y%2FU8bQd15aUO97vS@casper.infradead.org/
> 
> : the parent had already established
> : an appropriate size folio to use for this VMA before calling fork().
> : Whether it is the parent or the child causing the COW, it should probably
> : inherit that choice and we should default to the same size folio that
> : was already found.

FWIW, I had patches in my original RFC that aimed to follow this policy for
large anon folios [1] & [2], and intend to follow up with a modified version of
these patches once we have an initial submission.

[1] https://lore.kernel.org/linux-mm/20230414130303.2345383-11-ryan.roberts@arm.com/
[2] https://lore.kernel.org/linux-mm/20230414130303.2345383-15-ryan.roberts@arm.com/

