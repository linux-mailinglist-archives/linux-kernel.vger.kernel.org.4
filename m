Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A39E7092C3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjESJMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjESJMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:12:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C600173C
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 02:12:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3935E1FB;
        Fri, 19 May 2023 02:13:08 -0700 (PDT)
Received: from [10.57.73.191] (unknown [10.57.73.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9EC43F73F;
        Fri, 19 May 2023 02:12:21 -0700 (PDT)
Message-ID: <692e9e7e-ee00-368b-6a31-60a895f7011c@arm.com>
Date:   Fri, 19 May 2023 10:12:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 4/5] mm: Add new ptep_deref() helper to fully
 encapsulate pte_t
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sj@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        damon@lists.linux.dev
References: <20230518110727.2106156-1-ryan.roberts@arm.com>
 <20230518110727.2106156-5-ryan.roberts@arm.com>
 <CAOUHufZaiTCxk4M4w5GaA-+5FoMnHZt+fzoU=cYCA1Ldk7CVEQ@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAOUHufZaiTCxk4M4w5GaA-+5FoMnHZt+fzoU=cYCA1Ldk7CVEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2023 20:28, Yu Zhao wrote:
> On Thu, May 18, 2023 at 5:07 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> There are many call sites that directly dereference a pte_t pointer.
>> This makes it very difficult to properly encapsulate a page table in the
>> arch code without having to allocate shadow page tables. ptep_deref()
>> aims to solve this by replacing all direct dereferences with a call to
>> this function.
>>
>> The default implementation continues to just dereference the pointer
>> (*ptep), so generated code should be exactly the same. However, it is
>> possible for the architecture to override the default with their own
>> implementation, that can (e.g.) hide certain bits from the core code, or
>> determine young/dirty status by mixing in state from another source.
>>
>> While ptep_get() and ptep_get_lockless() already exist, these are
>> implemented as atomic accesses (e.g. READ_ONCE() in the default case).
>> So rather than using ptep_get() and risking performance regressions,
>> introduce an new variant.
> 
> We should reuse ptep_get():
> 1. I don't think READ_ONCE() can cause measurable regressions in this case.
> 2. It's technically wrong without it.

Can you clarify what you mean by technically wrong? Are you saying that the
current code that does direct dereferencing is buggy?

I previously convinced myself that the potential for the compiler generating
multiple loads was safe because the code in question is under the PTL so there
are no concurrent stores. And we shouldn't see any tearing for the same reason.

That said, if there is concensus that we can just use ptep_get() (==
READ_ONCE()) everywhere, then I agree that would be cleaner. Does anyone object?

