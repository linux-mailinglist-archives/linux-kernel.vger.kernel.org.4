Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94CC73F502
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjF0HA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjF0HA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:00:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B251B1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 23:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687849178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RbthhMj/2jM694BPdz2+B/9xEDc+NPAbla6OKLGCX4M=;
        b=FOMkBkCZ4YVZelVR6E9kU2m/o3fnqxTEEj4pbIIO8neEv4oDuY5IUUbdg2Elxx42IDnoZ9
        oL93uA0U9i19bvu9cfPKH3fhcjt1D4AqnBrlsqX+hrKA+zustHhBplPVmFJMUfKviWL0Ea
        4HlXwRre+QBtKh4tu4viRyI1Y53p+HU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-71VTKvIAOHyUtp9MfiXAXA-1; Tue, 27 Jun 2023 02:59:36 -0400
X-MC-Unique: 71VTKvIAOHyUtp9MfiXAXA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fa06fc72f2so23918155e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 23:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687849175; x=1690441175;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RbthhMj/2jM694BPdz2+B/9xEDc+NPAbla6OKLGCX4M=;
        b=lAcpUX/Idh6YQjT2lz48I22xGcdTaHZ1ah+NKKfyDf4pqY03gwBUM5cuC5kil67BjW
         L6XsW90aTdWGhEbUxgxkT5xVEeiNQZCzBcI/Ln0Vb/m03rxfhkXCZAyzZgn1oxxpQY1g
         ntIahPXrGpvQ65ylmFcPPVJJORzjppfmHlbnRDFnjtykEmSlATzMVVdyXFKEkOx9aVl3
         RzMY2ZFjLvyvieF1gOjimN4t+uVX7U9mKdvnKKEKsJO33Uoo+Y2UdE2I8IMYMc9e2Y17
         84q/2UaFoggk/gVjixgjQlu3tvz9Ld6tn5E51j/eoMc+EPPUsUCGaJtb3+8CMCrAXL3B
         fZGA==
X-Gm-Message-State: AC+VfDzROjJG51NMnUyANlu9OGvo8PKUy8FcvToQ+kTohrm6tWzWrFIP
        5FLY5kncXR33p9456JcI3CSkGP3gn2nMZdcFtKObo2zD8INZrgw5su/Nz0xSMsSLrHq4S3lzwth
        3i9X7HiEK9YVP0nulKZvnKzAu
X-Received: by 2002:adf:ed4c:0:b0:313:feeb:e0b8 with SMTP id u12-20020adfed4c000000b00313feebe0b8mr943285wro.17.1687849175574;
        Mon, 26 Jun 2023 23:59:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4rif8dQqcKrQPmhI4s/cS2VNYASx5to1xUWMtXcwVTk0sw4zYXFdycBSGL5PdYLo7viwMMsw==
X-Received: by 2002:adf:ed4c:0:b0:313:feeb:e0b8 with SMTP id u12-20020adfed4c000000b00313feebe0b8mr943268wro.17.1687849175111;
        Mon, 26 Jun 2023 23:59:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c737:4900:68b3:e93b:e07a:558b? (p200300cbc737490068b3e93be07a558b.dip0.t-ipconnect.de. [2003:cb:c737:4900:68b3:e93b:e07a:558b])
        by smtp.gmail.com with ESMTPSA id x11-20020adfdd8b000000b00313ecd3714csm6555759wrl.19.2023.06.26.23.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 23:59:34 -0700 (PDT)
Message-ID: <1832a772-93b4-70ad-3a2c-d8da104ce8dd@redhat.com>
Date:   Tue, 27 Jun 2023 08:59:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To:     Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
References: <20230626204612.106165-1-lstoakes@gmail.com>
 <074fc253-beb4-f7be-14a1-ee5f4745c15b@suse.cz>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/mprotect: allow unfaulted VMAs to be unaccounted on
 mprotect()
In-Reply-To: <074fc253-beb4-f7be-14a1-ee5f4745c15b@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 27.06.23 08:28, Vlastimil Babka wrote:
> On 6/26/23 22:46, Lorenzo Stoakes wrote:
>> When mprotect() is used to make unwritable VMAs writable, they have the
>> VM_ACCOUNT flag applied and memory accounted accordingly.
>>
>> If the VMA has had no pages faulted in and is then made unwritable once
>> again, it will remain accounted for, despite not being capable of extending
>> memory usage.
>>
>> Consider:-
>>
>> ptr = mmap(NULL, page_size * 3, PROT_READ, MAP_ANON | MAP_PRIVATE, -1, 0);
>> mprotect(ptr + page_size, page_size, PROT_READ | PROT_WRITE);
>> mprotect(ptr + page_size, page_size, PROT_READ);
> 
> In the original Mike's example there were actual pages populated, in that
> case we still won't merge the vma's, right? Guess that can't be helped.
>

I am clearly missing the motivation for this patch: above is a 
artificial reproducer that I cannot really imagine being relevant in 
practice.

So is there any sane workload that does random mprotect() without even 
touching memory once? Sure, fuzzing, ... artificial reproducers ... but 
is there any real-life problem we're solving here?

IOW, why did you (Lorenzo) invest time optimizing for this andcrafting 
this patch and why should reviewer invest time to understand if it's 
correct? :)


>> The first mprotect() splits the range into 3 VMAs and the second fails to
>> merge the three as the middle VMA has VM_ACCOUNT set and the others do not,
>> rendering them unmergeable.
>>
>> This is unnecessary, since no pages have actually been allocated and the
>> middle VMA is not capable of utilising more memory, thereby introducing
>> unnecessary VMA fragmentation (and accounting for more memory than is
>> necessary).
>>
>> Since we cannot efficiently determine which pages map to an anonymous VMA,
>> we have to be very conservative - determining whether any pages at all have
>> been faulted in, by checking whether vma->anon_vma is NULL.
>>
>> We can see that the lack of anon_vma implies that no anonymous pages are
>> present as evidenced by vma_needs_copy() utilising this on fork to
>> determine whether page tables need to be copied.
>>
>> The only place where anon_vma is set NULL explicitly is on fork with
>> VM_WIPEONFORK set, however since this flag is intended to cause the child
>> process to not CoW on a given memory range, it is right to interpret this
>> as indicating the VMA has no faulted-in anonymous memory mapped.
>>
>> If the VMA was forked without VM_WIPEONFORK set, then anon_vma_fork() will
>> have ensured that a new anon_vma is assigned (and correctly related to its
>> parent anon_vma) should any pages be CoW-mapped.
>>
>> The overall operation is safe against races as we hold a write lock against
>> mm->mmap_lock.
>>
>> If we could efficiently look up the VMA's faulted-in pages then we would
>> unaccount all those pages not yet faulted in. However as the original
>> comment alludes this simply isn't currently possible, so we remain
>> conservative and account all pages or none at all.
>>
>> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> 
> So in practice programs will likely do the PROT_WRITE in order to actually
> populate the area, so this won't trigger as I commented above. But it can
> still help in some cases and is cheap to do, so:

IMHO we should much rather look into getting hugetlb ranges merged. Mt 
recollection is that we'll never end up merging hugetlb VMAs once split.

This patch adds code without a clear motivation. Maybe there is a good 
motivation?

-- 
Cheers,

David / dhildenb

