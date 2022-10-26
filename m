Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8DF60DD21
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 10:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJZIgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 04:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbiJZIgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 04:36:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A15D4A801
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 01:36:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A25A23A;
        Wed, 26 Oct 2022 01:36:08 -0700 (PDT)
Received: from [10.163.37.85] (unknown [10.163.37.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5B563F792;
        Wed, 26 Oct 2022 01:35:58 -0700 (PDT)
Message-ID: <3c545133-71aa-9a8d-8a13-09186c4fa767@arm.com>
Date:   Wed, 26 Oct 2022 14:06:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH -next 1/1] mm: hugetlb_vmemmap: Fix WARN_ON in
 vmemmap_remap_pte
Content-Language: en-US
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Wupeng Ma <mawupeng1@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, catalin.marinas@arm.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
References: <20221025014215.3466904-1-mawupeng1@huawei.com>
 <614E3E83-1EAB-4C39-AF9C-83C0CCF26218@linux.dev>
 <35dd51eb-c266-f221-298a-21309c17971a@arm.com>
 <3D6FDA43-A812-4907-B9C8-C2B25567DBBC@linux.dev>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <3D6FDA43-A812-4907-B9C8-C2B25567DBBC@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/26/22 12:31, Muchun Song wrote:
> 
> 
>> On Oct 26, 2022, at 13:06, Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>
>>
>>
>> On 10/25/22 12:06, Muchun Song wrote:
>>>
>>>
>>>> On Oct 25, 2022, at 09:42, Wupeng Ma <mawupeng1@huawei.com> wrote:
>>>>
>>>> From: Ma Wupeng <mawupeng1@huawei.com>
>>>>
>>>> Commit f41f2ed43ca5 ("mm: hugetlb: free the vmemmap pages associated with
>>>> each HugeTLB page") add vmemmap_remap_pte to remap the tail pages as
>>>> read-only to catch illegal write operation to the tail page.
>>>>
>>>> However this will lead to WARN_ON in arm64 in __check_racy_pte_update()
>>>
>>> Thanks for your finding this issue.
>>>
>>>> since this may lead to dirty state cleaned. This check is introduced by
>>>> commit 2f4b829c625e ("arm64: Add support for hardware updates of the
>>>> access and dirty pte bits") and the initial check is as follow:
>>>>
>>>> BUG_ON(pte_write(*ptep) && !pte_dirty(pte));
>>>>
>>>> Since we do need to mark this pte as read-only to catch illegal write
>>>> operation to the tail pages, use set_pte  to replace set_pte_at to bypass
>>>> this check.
>>>
>>> In theory, the waring does not affect anything since the tail vmemmap
>>> pages are supposed to be read-only. So, skipping this check for vmemmap
>>
>> Tails vmemmap pages are supposed to be read-only, in practice but their
>> backing pages do have pte_write() enabled. Otherwise the VM_WARN_ONCE()
>> warning would not have triggered.
> 
> Right.
> 
>>
>>        VM_WARN_ONCE(pte_write(old_pte) && !pte_dirty(pte),
>>                     "%s: racy dirty state clearing: 0x%016llx -> 0x%016llx",
>>                     __func__, pte_val(old_pte), pte_val(pte));
>>
>> Also, is not it true that the pte being remapped into a different page
>> as read only, than what it had originally (which will be freed up) i.e 
>> the PFN in 'old_pte' and 'pte' will be different. Hence is there still
> 
> Right.
> 
>> a possibility for a race condition even when the PFN changes ?
> 
> Sorry, I didn't get this question. Did you mean the PTE is changed from
> new (pte) to the old one (old_pte) by the hardware because of the update
> of dirty bit when a concurrent write operation to the tail vmemmap page?

No, but is not vmemmap_remap_pte() reuses walk->reuse_page for all remaining
tails pages ? Is not there a PFN change, along with access permission change
involved in this remapping process ?
