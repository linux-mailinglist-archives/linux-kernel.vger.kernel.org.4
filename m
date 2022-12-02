Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5A1640BFC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbiLBRUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbiLBRUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:20:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6089D2C3
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670001544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5GkID1iP9MpgW84ysmyy3u1ZrLSvXrRGMbe9Yjus3rw=;
        b=F8N8I3H4a6MO2eN2xCehMTF1ljbKYLN7o5Ph8GjeZN9YUVl2UU0GLE7371YXalW0NLW91f
        rNmkc43NQfu/OXsesEx0eKSksr1xOclK5u5wZQimvKOvOUoh329q+vkcD950D4GQAKxI7s
        wLeRC6xcXAr50lD7rLj1GWT+RXipeW8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-342-ewYLWIxIMOSe5xpQx1SThw-1; Fri, 02 Dec 2022 12:19:01 -0500
X-MC-Unique: ewYLWIxIMOSe5xpQx1SThw-1
Received: by mail-wm1-f72.google.com with SMTP id z15-20020a1c4c0f000000b003cf6f80007cso2174112wmf.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:19:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5GkID1iP9MpgW84ysmyy3u1ZrLSvXrRGMbe9Yjus3rw=;
        b=JR7Hxhu3Lr1e4ldSa4/c8kS45tj5EN0rjiRv0YcOqXIUWlx1Tl/K+nWhV1o+v9RddX
         TOhbXcgw5CW/Sv9UuRMJqhEmxq4LrMKax1S4IGbN/PLeTuSWeSgoz5rMjaowpfvaMD8U
         Ip9+vZgFO3nJVp7qmJpoZ/+aq7R1XsIps9PnzTzmbpY9toCyDtIrXkNMDTQEjDHRIs95
         clJm1t7UZYjfZU5xVY5mU2sP0dhaxcuSEdVVWW/62N+6U49NGMw8RAdvg6M8hB8uh6tz
         HUEQkrpMjXM3APb+XSLw3b3L42uMEfqYYOYyyBCwYs92ewMEyG3uhL5FVxZyS531vZ4q
         0TMg==
X-Gm-Message-State: ANoB5pk7Qxqp3+givIffYesU1ejP5CV3rs7ajOiYg3qOlDAyCxeznWMd
        M5peCJyDy33sA81RqgVlH2MAv+NPldfaH6rUqVM1FxdNcBzR9u3YPnafaEAJmX2XUyYsSUxa3sg
        gnzv9BsvLcSs1Sq+alnoYQm0U
X-Received: by 2002:a05:6000:983:b0:236:aacc:ea07 with SMTP id by3-20020a056000098300b00236aaccea07mr45987390wrb.36.1670001539882;
        Fri, 02 Dec 2022 09:18:59 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7d0QCwkPBB+T+LF+MwVIetNIwUyQxWiCZhfVtlyYOjSUZtlBtkvsrxrWul3G0QGWU2WGjstA==
X-Received: by 2002:a05:6000:983:b0:236:aacc:ea07 with SMTP id by3-20020a056000098300b00236aaccea07mr45987372wrb.36.1670001539508;
        Fri, 02 Dec 2022 09:18:59 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:7a00:852e:72cd:ed76:d72f? (p200300cbc7037a00852e72cded76d72f.dip0.t-ipconnect.de. [2003:cb:c703:7a00:852e:72cd:ed76:d72f])
        by smtp.gmail.com with ESMTPSA id p18-20020adfce12000000b00242271fd2besm7431353wrn.89.2022.12.02.09.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 09:18:59 -0800 (PST)
Message-ID: <efc5f0c3-bfb7-e36e-fa5b-60f94b49b7d4@redhat.com>
Date:   Fri, 2 Dec 2022 18:18:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ives van Hoorne <ives@codesandbox.io>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Alistair Popple <apopple@nvidia.com>, stable@vger.kernel.org
References: <20221114000447.1681003-1-peterx@redhat.com>
 <20221114000447.1681003-2-peterx@redhat.com>
 <5ddf1310-b49f-6e66-a22a-6de361602558@redhat.com>
 <20221130142425.6a7fdfa3e5954f3c305a77ee@linux-foundation.org>
 <Y4jIHureiOd8XjDX@x1n> <a215fe2f-ef9b-1a15-f1c2-2f0bb5d5f490@redhat.com>
 <20221201143058.80296541cc6802d1e5990033@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 1/2] mm/migrate: Fix read-only page got writable when
 recover pte
In-Reply-To: <20221201143058.80296541cc6802d1e5990033@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.12.22 23:30, Andrew Morton wrote:
> On Thu, 1 Dec 2022 16:42:52 +0100 David Hildenbrand <david@redhat.com> wrote:
> 
>> On 01.12.22 16:28, Peter Xu wrote:
>>>
>>> I didn't reply here because I have already replied with the question in
>>> previous version with a few attempts.  Quotting myself:
>>>
>>> https://lore.kernel.org/all/Y3KgYeMTdTM0FN5W@x1n/
>>>
>>>           The thing is recovering the pte into its original form is the
>>>           safest approach to me, so I think we need justification on why it's
>>>           always safe to set the write bit.
>>>
>>> I've also got another longer email trying to explain why I think it's the
>>> other way round to be justfied, rather than justifying removal of the write
>>> bit for a read migration entry, here:
>>>
>>
>> And I disagree for this patch that is supposed to fix this hunk:
>>
>>
>> @@ -243,11 +243,15 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
>>                   entry = pte_to_swp_entry(*pvmw.pte);
>>                   if (is_write_migration_entry(entry))
>>                           pte = maybe_mkwrite(pte, vma);
>> +               else if (pte_swp_uffd_wp(*pvmw.pte))
>> +                       pte = pte_mkuffd_wp(pte);
>>    
>>                   if (unlikely(is_zone_device_page(new))) {
>>                           if (is_device_private_page(new)) {
>>                                   entry = make_device_private_entry(new, pte_write(pte));
>>                                   pte = swp_entry_to_pte(entry);
>> +                               if (pte_swp_uffd_wp(*pvmw.pte))
>> +                                       pte = pte_mkuffd_wp(pte);
>>                           }
>>                   }
> 
> David, I'm unclear on what you mean by the above.  Can you please
> expand?
> 
>>
>> There is really nothing to justify the other way around here.
>> If it's broken fix it independently and properly backport it independenty.
>>
>> But we don't know about any such broken case.
>>
>> I have no energy to spare to argue further ;)
> 
> This is a silent data loss bug, which is about as bad as it gets.
> Under obscure conditions, fortunately.  But please let's keep working
> it.  Let's aim for something minimal for backporting purposes.  We can
> revisit any cleanliness issues later.
> 
> David, do you feel that the proposed fix will at least address the bug
> without adverse side-effects?

Just to answer that question clearly: it will fix this bug, but it's 
likely that other similar bugs remain (suspecting NUMA hinting).

Adverse side effect will be that some PTEs that could we writable won't 
be writable. I assume it's not too bad in practice for this particular case.

I proposed an alternative fix and identified other possible broken 
cases. Again, I don't NAK this patch as is, it just logically doesn't 
make sense to me to handle this case differently to the other 
vma->vm_page_prot users. (more details in the other thread)

-- 
Thanks,

David / dhildenb

