Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032286293FB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbiKOJOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiKOJO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:14:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E778B23A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668503609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9bGG1jGVV02EQAPeqlOkm4CeIaBapLMU4o4CCV8AKv8=;
        b=c/Sut6U/uRgpW28XH/mn221Z5aYjgO5XUAIgo8qV4SabKujH8xHwVnOG/YjEU7R8vsqeOl
        qo7PKaPLI/Hjz3H0+5boW1HGP0q4KyDybGYFIXqY9Yd8bH9Y4SewTvXVXgzMeC94iNc6Hc
        eN7eFyTUss9gVq0RvuYP8zXT1XdmZAc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-505-N49iwfO8NnmLIMjX5iwE3w-1; Tue, 15 Nov 2022 04:13:27 -0500
X-MC-Unique: N49iwfO8NnmLIMjX5iwE3w-1
Received: by mail-wr1-f72.google.com with SMTP id h26-20020adfaa9a000000b002364ad63bbcso2590267wrc.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:13:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9bGG1jGVV02EQAPeqlOkm4CeIaBapLMU4o4CCV8AKv8=;
        b=IzKPsGErm2nJsn/M8KaW5bQ82sIMZHaFy2hHXXisDiL3hLVgtt6fnJ+C1Q1+dtY555
         s5TEPSy8MqR8BnrUnmrAQ1zUOuPK4eF2mUmOw4cepbWlTq6V9AxwRE/lIcHy4BS3kob4
         /OZq5Z6IAp2U07u2N3ynVt2R63vkhD86mK0tnuPLePK158UFOQBSEnOJLwAQUN6fJK05
         eAqo/Vt2koQ+RVB5PwqFHhUhtCmTgimZMrsRBjByePgRbBtY0roNgSWU8GklVSgsbgEl
         HuSTZk/9ImzNMkTx2msgn5dDFAEN74Foh3jD60Lc0gr8WSmcBlLN/oIuDkxsh4tkPL+P
         ZRcA==
X-Gm-Message-State: ANoB5pmehP5gkJ4n7VvaKc9Sr1Evj9Rei/f6O/B2BinjPFKuWC21ofXQ
        Fdgo4yXFZ5wuTytOFWwQJOAqLqAU8TiPKmuqVzjzZ2eDLpW/f0THrQis1GLJnJWon8PBAUz7e6P
        Vq9BnzUbmW/AV7FtZ9r7HlEwr
X-Received: by 2002:a05:6000:508:b0:236:5e77:b58e with SMTP id a8-20020a056000050800b002365e77b58emr10055802wrf.320.1668503606096;
        Tue, 15 Nov 2022 01:13:26 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5fR1dfQFe+f3e2gDVTnKiSkgViBOihC6UfuqBQMHKFk8w9A4JPD9Sub6SLnzxINQNIwBlh9g==
X-Received: by 2002:a05:6000:508:b0:236:5e77:b58e with SMTP id a8-20020a056000050800b002365e77b58emr10055771wrf.320.1668503605686;
        Tue, 15 Nov 2022 01:13:25 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:9d00:9303:90ce:6dcb:2bc9? (p200300cbc7079d00930390ce6dcb2bc9.dip0.t-ipconnect.de. [2003:cb:c707:9d00:9303:90ce:6dcb:2bc9])
        by smtp.gmail.com with ESMTPSA id b15-20020adff24f000000b002345cb2723esm11723317wrp.17.2022.11.15.01.13.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 01:13:25 -0800 (PST)
Message-ID: <ec8b3c86-d3b2-f898-7297-c20a58ae2ac1@redhat.com>
Date:   Tue, 15 Nov 2022 10:13:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ives van Hoorne <ives@codesandbox.io>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, stable@vger.kernel.org
References: <20221110203132.1498183-1-peterx@redhat.com>
 <20221110203132.1498183-2-peterx@redhat.com>
 <9af36be3-313b-e39c-85bb-bf30011bccb8@redhat.com> <Y3KgYeMTdTM0FN5W@x1n>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 1/2] mm/migrate: Fix read-only page got writable when
 recover pte
In-Reply-To: <Y3KgYeMTdTM0FN5W@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> Any particular reason why not to simply glue this to pte_swp_uffd_wp(),
>> because only that needs special care:
>>
>> if (pte_swp_uffd_wp(*pvmw.pte)) {
>> 	pte = pte_wrprotect(pte);
>> 	pte = pte_mkuffd_wp(pte);
>> }
>>
>>
>> And that would match what actually should have been done in commit
>> f45ec5ff16a7 -- only special-case uffd-wp.
>>
>> Note that I think there are cases where we have a PTE that was !writable,
>> but after migration we can map it writable.
> 
> The thing is recovering the pte into its original form is the safest
> approach to me, so I think we need justification on why it's always safe to
> set the write bit.
> 
> Or do you perhaps have solid clue and think it's always safe
The problem I am having with this broader change, is that this changes 
something independent of your original patch/problem.

If we identify this to be an actual problem, it should most probably be 
separate fix + backport.


My understanding is that vma->vm_page_prot always tells you what the 
default PTE protection in a mapping is.

If the mapping is private, it is never writable (due to COW). Similarly, 
if the shared file mapping needs writenotify, it is never writable.


I consider UFFD-wp a special case: while the default VMA protection 
might state that it is writable, you actually want individual PTEs to be 
write-protected and have to manually remove the protection.

softdirty tracking is another special case: however, softdirty tracking 
is enabled for the whole VMA. For remove_migration_pte() that should be 
fine (I guess) because writenotify is active when the VMA needs to track 
softdirty bits, and consequently vma->vm_page_prot has the proper 
default permissions.


I wonder if the following (valid), for example is possible:


1) clear_refs() clears VM_SOFTDIRTY and pte_wrprotect() the pte.
-> writenotify is active and vma->vm_page_prot updated accordingly

VM_SOFTDIRTY is reset due to VMA merging and vma->vm_page_prot is 
updated accordingly. See mmap_region() where we set VM_SOFTDIRTY.

If you now migrate the (still write-protected in the PTE) page, it was 
not writable, but it can be writable on the destination.

> 
>>
>> BTW, does unuse_pte() need similar care?
>>
>> new_pte = pte_mkold(mk_pte(page, vma->vm_page_prot));
>> if (pte_swp_uffd_wp(*pte))
>> 	new_pte = pte_mkuffd_wp(new_pte);
>> set_pte_at(vma->vm_mm, addr, pte, new_pte);
> 
> I think unuse path is fine because unuse only applies to private mappings,
> so we should always have the W bit removed there within mk_pte().

You're right, however, shmem swapping confuses me. Maybe that does not 
apply here.

-- 
Thanks,

David / dhildenb

