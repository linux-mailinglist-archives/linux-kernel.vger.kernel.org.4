Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42FD6E68C6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjDRP6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjDRP6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:58:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73893126
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 08:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681833471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ClxVX5yTsrEn4iN5IePk2auvIblqHsmaWH8UmnJ6Yfs=;
        b=FmLE9W9dwrV3T9YzfvCwGYlsswRnAqho98Iwcy51cid2pX+4k0jsKoU+6IP45fIcQGFlI3
        4YzikRZYk4Ahj8QfEcKJ33MvdLpv+SJovF0Xx7QOGwsmtYtcbZwyhQKYFoaKa4X5ICdVzs
        Ow94CB6yczJ9JXDbBxr77WWw0D7yuFU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-atS77zgIMjuUAxvyYUiSdA-1; Tue, 18 Apr 2023 11:57:50 -0400
X-MC-Unique: atS77zgIMjuUAxvyYUiSdA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f0b0c85c4fso42634115e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 08:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681833469; x=1684425469;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ClxVX5yTsrEn4iN5IePk2auvIblqHsmaWH8UmnJ6Yfs=;
        b=cz4JZH2D9K98Af7czcl8pBUnycdeFIJbksPE6X702ND4KxDmlLJ9cr7ry7iJqylC0F
         9bi+KGQ5XPF4Hi3oKbgH69b7E+k38iJTz4wuIfDAnmmB3XqFwIkPu+W+ice4fpJGV/7a
         Enl0xH89Mj188RJDtBDAH8GTBdUx+Di5c7IDft75Pfy1wGL7n37QMw6hEICmOJxZkxFB
         qmANRtYnh6JMo84D58cZw9ayNGMSbKOh9m+rvDR2MMkuTnnv8RnfIs2bNjx8a4KFwevr
         vtRC3xRsfLE8YltTscXJa11HsS52xt9QQrZ76nuHHj69l1p7Xhv00r6muwKLQeSm/KLk
         YiVA==
X-Gm-Message-State: AAQBX9f6rnXw34IwpD7Po8RmLUMNwVnaOvl60w4LFJWvq+2q3atou/dS
        nTELGTkUV1RmVMYmOe9quGkrpDZjSfvAt2aJkEUQ3hhhOLvi16vj6d9Shzv4PhJuT35Q+ESMBfs
        TThBrjG3kTPk/894iwfL+6jJ58u87K3F+
X-Received: by 2002:a5d:58d1:0:b0:2f6:aa71:d5b0 with SMTP id o17-20020a5d58d1000000b002f6aa71d5b0mr2372401wrf.15.1681833469412;
        Tue, 18 Apr 2023 08:57:49 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zi+96637CVEF+bLgMNRwea/a7ykxdXxncauziu42MzNJmag43vt2ndN7a2lAALAol0SldyDQ==
X-Received: by 2002:a5d:58d1:0:b0:2f6:aa71:d5b0 with SMTP id o17-20020a5d58d1000000b002f6aa71d5b0mr2372384wrf.15.1681833469028;
        Tue, 18 Apr 2023 08:57:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:3f00:7545:deb6:f2f4:27ef? (p200300cbc7153f007545deb6f2f427ef.dip0.t-ipconnect.de. [2003:cb:c715:3f00:7545:deb6:f2f4:27ef])
        by smtp.gmail.com with ESMTPSA id f16-20020a05600c155000b003f177cda5ebsm3316361wmg.33.2023.04.18.08.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 08:57:48 -0700 (PDT)
Message-ID: <e6b64991-65d7-0d25-3866-6b0b44f171b1@redhat.com>
Date:   Tue, 18 Apr 2023 17:57:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mm-unstable v1] mm: don't check VMA write permissions if
 the PTE/PMD indicates write permissions
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
References: <20230418142113.439494-1-david@redhat.com> <ZD69l0zD3UL9HD8g@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZD69l0zD3UL9HD8g@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.04.23 17:56, Peter Xu wrote:
> On Tue, Apr 18, 2023 at 04:21:13PM +0200, David Hildenbrand wrote:
>> Staring at the comment "Recheck VMA as permissions can change since
>> migration started" in remove_migration_pte() can result in confusion,
>> because if the source PTE/PMD indicates write permissions, then there
>> should be no need to check VMA write permissions when restoring migration
>> entries or PTE-mapping a PMD.
>>
>> Commit d3cb8bf6081b ("mm: migrate: Close race between migration completion
>> and mprotect") introduced the maybe_mkwrite() handling in
>> remove_migration_pte() in 2014, stating that a race between mprotect() and
>> migration finishing would be possible, and that we could end up with
>> a writable PTE that should be readable.
>>
>> However, mprotect() code first updates vma->vm_flags / vma->vm_page_prot
>> and then walks the page tables to (a) set all present writable PTEs to
>> read-only and (b) convert all writable migration entries to readable
>> migration entries. While walking the page tables and modifying the
>> entries, migration code has to grab the PT locks to synchronize against
>> concurrent page table modifications.
> 
> Makes sense to me.
> 
>>
>> Assuming migration would find a writable migration entry (while holding
>> the PT lock) and replace it with a writable present PTE, surely mprotect()
>> code didn't stumble over the writable migration entry yet (converting it
>> into a readable migration entry) and would instead wait for the PT lock to
>> convert the now present writable PTE into a read-only PTE. As mprotect()
>> didn't finish yet, the behavior is just like migration didn't happen: a
>> writable PTE will be converted to a read-only PTE.
>>
>> So it's fine to rely on the writability information in the source
>> PTE/PMD and not recheck against the VMA as long as we're holding the PT
>> lock to synchronize with anyone who concurrently wants to downgrade write
>> permissions (like mprotect()) by first adjusting vma->vm_flags /
>> vma->vm_page_prot to then walk over the page tables to adjust the page
>> table entries.
>>
>> Running test cases that should reveal such races -- mprotect(PROT_READ)
>> racing with page migration or THP splitting -- for multiple hours did
>> not reveal an issue with this cleanup.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Cc: Peter Xu <peterx@redhat.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>
>> This is a follow-up cleanup to [1]:
>> 	[PATCH v1 RESEND 0/6] mm: (pte|pmd)_mkdirty() should not
>> 	unconditionally allow for write access
>>
>> I wanted to be a bit careful and write some test cases to convince myself
>> that I am not missing something important. Of course, there is still the
>> possibility that my test cases are buggy ;)
>>
>> Test cases I'm running:
>> 	https://gitlab.com/davidhildenbrand/scratchspace/-/raw/main/test_mprotect_migration.c
>> 	https://gitlab.com/davidhildenbrand/scratchspace/-/raw/main/test_mprotect_thp_split.c
>>
>>
>> [1] https://lkml.kernel.org/r/20230411142512.438404-1-david@redhat.com
>>
>> ---
>>   mm/huge_memory.c | 4 ++--
>>   mm/migrate.c     | 5 +----
>>   2 files changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index c23fa39dec92..624671aaa60d 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -2234,7 +2234,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>>   		} else {
>>   			entry = mk_pte(page + i, READ_ONCE(vma->vm_page_prot));
>>   			if (write)
>> -				entry = maybe_mkwrite(entry, vma);
>> +				entry = pte_mkwrite(entry);
> 
> This is another change besides page migration.  I also don't know why it's
> needed, but it's there since day 1 of thp split in eef1b3ba053, so maybe
> worthwhile to copy Kirill too (which I did).

Indeed (I wanted but forgot ...), thanks Peter!

-- 
Thanks,

David / dhildenb

