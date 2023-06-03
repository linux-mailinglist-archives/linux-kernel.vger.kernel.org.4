Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F3A721185
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 20:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjFCSUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 14:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjFCSUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 14:20:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45ED9B9
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 11:20:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4633EFEC;
        Sat,  3 Jun 2023 11:21:23 -0700 (PDT)
Received: from [10.57.72.226] (unknown [10.57.72.226])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1260F3F793;
        Sat,  3 Jun 2023 11:20:35 -0700 (PDT)
Message-ID: <c87d4b69-0971-2faf-9d10-615e3264b131@arm.com>
Date:   Sat, 3 Jun 2023 19:20:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v3 2/4] mm/damon/ops-common: atomically test and clear
 young on ptes and pmds
To:     SeongJae Park <sj@kernel.org>
Cc:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, damon@lists.linux.dev
References: <20230602214347.85694-1-sj@kernel.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230602214347.85694-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2023 22:43, SeongJae Park wrote:
> On Fri, 2 Jun 2023 19:15:01 +0000 SeongJae Park <sj@kernel.org> wrote:
> 
>> Hi Ryan,
>>
>> On Fri, 2 Jun 2023 18:14:25 +0100 Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>>> On 02/06/2023 17:35, Yu Zhao wrote:
>>>> On Fri, Jun 2, 2023 at 3:30 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>
>>>>> It is racy to non-atomically read a pte, then clear the young bit, then
>>>>> write it back as this could discard dirty information. Further, it is
>>>>> bad practice to directly set a pte entry within a table. Instead
>>>>> clearing young must go through the arch-provided helper,
>>>>> ptep_test_and_clear_young() to ensure it is modified atomically and to
>>>>> give the arch code visibility and allow it to check (and potentially
>>>>> modify) the operation.
>>>>>
>>>>> Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memory address spaces").
>>>>
>>>> Just to double check: was "Cc: stable@vger.kernel.org" overlooked or
>>>> deemed unnecessary?
>>>
>>> It was overlooked - incompetance strikes again! I was intending to cc the
>>> whole series.
>>
>> Not the whole patches in this series but only this patch is intended to be
>> merged in stable series, right?  If I'm not wrong, you could add
>> 'Cc: <stable@vger.kernel.org>' tag here[1] when resending, to let stable kernel
>> maintainers easily understand exactly what patches should be merged in the
>> stable kernels.  So, you wouldn't need to touch coverletter or cc whole series
>> but only this one.
>>
>> [1] https://www.kernel.org/doc/html/v4.10/process/stable-kernel-rules.html
> 
> And I just found Andrew added the tag while adding this to the -mm queue.
> Thank you, Andrew!

Yes indeed - thanks for fixing that up for me, Andrew!

> 
> [1] https://lore.kernel.org/mm-commits/20230602205509.9DFBDC433D2@smtp.kernel.org/
> 
> 
> Thanks,
> SJ
> 
>>
>>
>> Thanks,
>> SJ
>>

