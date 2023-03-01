Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425266A71E0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 18:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjCARN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 12:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCARN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:13:57 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD411ADC1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 09:13:56 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.217.110])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9C77066020D1;
        Wed,  1 Mar 2023 17:13:52 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677690835;
        bh=sX1l5vpO1pOZkdcjHK8B8ItjOquI8mvBxgNUPz9UUtU=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=WpwQWd4IIz2bSmEsysv06hje/uFtGJtgn+Y9V7s6tDVHRPIPwLmRtra4nODd7a8+6
         QdOglGJAbsw2D7rFomi47r7cOBQjU+InHvqkzh6ePefGUQu6pW0459GtnejpVUJEf/
         EoBDwWZp5AqeR6tEGDlUxP1+4LzBNLvSSUzmofSfE5ZvcOoUUrCBjYybFBTBLeid/z
         wyMTOefzz0fGk7xmTTu0L8tYf83px0M57XjEQ5Bf01nwmwdl9gpE1o8EkbXwymfNFx
         sSnRTXAJtvj7buxOxrA/7eQHQAmNT1BZs/wlUi6tCA21ArH5nJgWUfINMO/SOSOWao
         QdagiQheS9Bow==
Message-ID: <fc95fd2c-d661-926c-3bdb-8709cb49de3b@collabora.com>
Date:   Wed, 1 Mar 2023 22:13:47 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [PATCH v2] mm/uffd: UFFD_FEATURE_WP_UNPOPULATED
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
References: <20230227230044.1596744-1-peterx@redhat.com>
 <Y/1Mh5uivFt+zWKM@x1n> <e1e0ed70-76df-647f-30ac-0bb6ae8dc05c@collabora.com>
 <Y/4kjnom6MQqh9iA@x1n> <fb7ec372-2b16-14e1-a8cd-a90f4449661f@collabora.com>
 <640319be-ddb6-d74f-b731-eee5ceab3d01@collabora.com> <Y/9tA2EVglOJ0Ap1@x1n>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <Y/9tA2EVglOJ0Ap1@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/23 8:19 PM, Peter Xu wrote:
> On Wed, Mar 01, 2023 at 12:55:51PM +0500, Muhammad Usama Anjum wrote:
>> Hi Peter,
> 
> Hi, Muhammad,
> 
>> While using WP_UNPOPULATED, we get stuck if newly allocated memory is read
>> without initialization. This can be reproduced by either of the following
>> statements:
>>     printf("%c", buffer[0]);
>>     buffer[0]++;
>>
>> This bug has start to appear on this patch. How are you handling reading
>> newly allocated memory when WP_UNPOPULATED is defined?
> 
> Yes it's a bug, thanks for the reproducer. You're right I missed a trivial
> but important detail.  Could you try apply below on top?
> 
> ---8<---
> diff --git a/mm/memory.c b/mm/memory.c
> index 46934133bd0b..2f4b3892948b 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4062,7 +4062,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>                                                 vma->vm_page_prot));
>                 vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
>                                 vmf->address, &vmf->ptl);
> -               if (!pte_none(*vmf->pte)) {
> +               if (vmf_pte_changed(vmf)) {
>                         update_mmu_tlb(vma, vmf->address, vmf->pte);
>                         goto unlock;
>                 }
> ---8<---
This patch works. Thank you so much!

> 
> I can send a new version after you confirmed it at least works on your
> side. I'll also add some more test to cover that in the next version.
> 
> The current smoke test within this patch is really light; I somehow rely on
> you on this patch on the testing side, and thanks for that.
> 
>> Running my pagemap_ioctl selftest as benchmark in a VM:
>> without zeropage / wp_unpopulated (decide from pte_none() if page is dirty
>> or not, buggy and wrong implementation, just for reference)
>> 26.608 seconds
>> with zeropage
>> 39.203 seconds
>> with wp_unpopulated
>> 62.907 seconds
>>
>> 136% worse performance overall
>> 60% worse performance of unpopulated than zeropage
> 
> Yes this is unfortunate, because we're protecting more things than before
> when with WP_ZEROPAGE / WP_UNPOPULATED but that's what it is for (when we
> want to make sure that accuracy on the holes).
> 
> I didn't look closer to your whole test suite yet, but my pure test on
> protection above should mean that it's still much better for such a use
> case than either (1) pre-read or (2) MADV_POPULATE_READ.
Ohh... I should stop comparing UNPOPULATE with buggy implementation and
compare with pre-read. I've compared apples with oranges.

I'll do better benchmark for the comparison sake. I'll let you know if the
performance is becoming an issue. Overall we need pagemap_ioctl + UFFD to
correctly emulate Windows syscall. Secondly we also need good performance
(more the better).

> 
> Again, I hope the performance result is not a concern to you.  If it is,
> please let us know.
> 
> Thanks,
> 

-- 
BR,
Muhammad Usama Anjum
