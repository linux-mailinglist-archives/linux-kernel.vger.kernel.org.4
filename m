Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4594C699074
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjBPJtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjBPJtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:49:02 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB62212A8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:49:00 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.217.110])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ECD37660219B;
        Thu, 16 Feb 2023 09:48:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676540939;
        bh=PX8dOl30j3Yr0k0JAknV8dpZqe1VdlzvplpwBLPzdKc=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=H5v4ZpM/z+wrQUpEW5xK3yLSyNMR0XOXYFHJm9aBPg6Ze0M6QB+Yehh9TffL/TsgJ
         U/WkkBKQ3mZzJpky43EowepFh60QwCIA2bs0+cQOmI9RPBSkUE34dumQbB5gWwh7qK
         dHzIqN2OS5SPKKquYugbRwUcPJ5UmeKyoZhhxsFWm1z3NBRjio2bREYV36Yj5UUntK
         BwVsSYglk00vNqe9Nm6tigdcqXGI+8j1OwF8AMu5qOAv8OQiD2EWtYW2fOlxNOa9lt
         QwFBvfsyxNQX9YdZ55BYpdyO+nO5VRmcU/uiFlVGpBl4WeHTHtdcwvidj2dct8z20U
         l1amKTZJEEPeg==
Message-ID: <c239e126-9b75-9a81-6142-a8e518e769e2@collabora.com>
Date:   Thu, 16 Feb 2023 14:48:51 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] mm/userfaultfd: add VM_WARN_ONCE()
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230216091656.2045471-1-usama.anjum@collabora.com>
 <20230216091656.2045471-2-usama.anjum@collabora.com>
 <4d29a9ec-027d-06b9-8543-87d386e58c94@redhat.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <4d29a9ec-027d-06b9-8543-87d386e58c94@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/23 2:24 PM, David Hildenbrand wrote:
> On 16.02.23 10:16, Muhammad Usama Anjum wrote:
>> Add VM_WARN_ONCE() to uffd_wp_range() to detect range (start, len) abuse.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>   mm/userfaultfd.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
>> index 77c5839e591c..d89ed44d2668 100644
>> --- a/mm/userfaultfd.c
>> +++ b/mm/userfaultfd.c
>> @@ -717,6 +717,8 @@ long uffd_wp_range(struct mm_struct *dst_mm, struct
>> vm_area_struct *dst_vma,
>>       struct mmu_gather tlb;
>>       long ret;
>>   +    VM_WARN_ONCE(start < dst_vma->vm_start || start + len >
>> dst_vma->vm_end,
>> +             "The address range exceeds VMA boundary.\n");
> 
> VM_WARN_ON_ONCE is sufficient (sorry for spelling out the wrong variant
> earlier).
Will do in the next version. Thanks.

> 
> These kinds of bugs are expected to be found early during testing, still it
> might make sense to implement a backup path
> 
> if (WARN_ON_ONCE(...))
>     return -EINVAL;
> 
> But we can't use VM_WARN_ON_ONCE here, so we can't compile it out anymore
> ... so I guess a simple VM_WARN_ON_ONCE() is sufficient.
> 

-- 
BR,
Muhammad Usama Anjum
