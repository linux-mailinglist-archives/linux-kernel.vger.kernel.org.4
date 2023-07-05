Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C7D748185
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 11:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbjGEJyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 05:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjGEJyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 05:54:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26F781713
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 02:54:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39DEB16F3;
        Wed,  5 Jul 2023 02:55:16 -0700 (PDT)
Received: from [10.57.76.116] (unknown [10.57.76.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 253F83F762;
        Wed,  5 Jul 2023 02:54:32 -0700 (PDT)
Message-ID: <4ee6e325-30ea-f74c-7d73-10a5d1453d01@arm.com>
Date:   Wed, 5 Jul 2023 10:54:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 4/5] mm: FLEXIBLE_THP for improved performance
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Yin, Fengwei" <fengwei.yin@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <20230703135330.1865927-5-ryan.roberts@arm.com>
 <6865a59e-9e40-282d-c434-b7c757388b65@intel.com>
 <f364d9f1-8f7b-f531-ab9e-400c57a60c16@arm.com>
 <ZKSx5Udt3Oh8Kr35@casper.infradead.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZKSx5Udt3Oh8Kr35@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2023 00:57, Matthew Wilcox wrote:
> On Tue, Jul 04, 2023 at 03:20:35PM +0100, Ryan Roberts wrote:
>> On 04/07/2023 04:45, Yin, Fengwei wrote:
>>>
>>> On 7/3/2023 9:53 PM, Ryan Roberts wrote:
>>>> Introduce FLEXIBLE_THP feature, which allows anonymous memory to be
>>> THP is for huge page which is 2M size. We are not huge page here. But
>>> I don't have good name either.
>>
>> Is that really true? On arm64 with 16K pages, huge pages are 32M and with 64K
>> base page, they are 512M. So huge pages already have a variable size. And they
>> sometimes get PTE-mapped. So can't we just think of this as an extension of the
>> THP feature?
> 
> The confusing thing is that we have counters for the number of THP
> allocated (and number of THP mapped), and for those we always use
> PMD-size folios.

OK fair point. I really don't have a strong opinion on the name - I changed it
from LARGE_ANON_FOLIO because Yu was suggesting it should be tied to THP. So I'm
happy to change it back to LARGE_ANON_FOLIO (or something else) if that's the
concensus. But I expect I'll end up in a game of ping-pong. So I'm going to keep
this name for now and focus on converging the actual implementation to something
that is agreeable. Once we are there, we can argue about the name.

> 
> If we must have a config option, then this is ANON_LARGE_FOLIOS.
> 
> But why do we need a config option?  We don't have one for the
> page cache, and we're better off for it.  Yes, it depends on
> CONFIG_TRANSPARENT_HUGEPAGE today, but that's more of an accidental
> heritage, and it'd be great to do away with that dependency eventually.
> 
> Hardware support isn't needed.  Large folios benefit us from a software
> point of view.  if we need a chicken bit, we can edit the source code
> to not create anon folios larger than order 0.

From my PoV it's about managing risk; there are currently parts of the mm that
will interact poorly with large pte-mapped folios (madvise, compaction, ...). We
want to incrementally fix that stuff, but until it's all fixed, we can't deploy
this as always-on. Further down the line when things are more complete and there
is more test coverage, we could remove the Kconfig or default it to enabled.

