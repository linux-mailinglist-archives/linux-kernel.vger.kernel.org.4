Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6955263AEF8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbiK1Rfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiK1Rfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:35:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F415515A0C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669656885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HOnSzZsHYJMsU4U1iQE6DAPLRF/mhbFHpR28YkQY5sY=;
        b=NP6M/N75gqj4m5v+GK7YPWmBFNJAsKBEGruMEgKwHkrZ2mhqjuP1lHsNBrW+1YNu66wvUc
        QLgBIQ3Ah09l6YPqda/nnt+b5zEHxi5AYSD1OgF6xqAjXOS6ArveXToQ8HdlAfEHfIYY5D
        5QtzfeYwXleDICS+YlSuAVeuvVqZ8tI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-240-2tjU_1OEMTaJkjG_m0CzKQ-1; Mon, 28 Nov 2022 12:34:43 -0500
X-MC-Unique: 2tjU_1OEMTaJkjG_m0CzKQ-1
Received: by mail-wm1-f72.google.com with SMTP id o5-20020a05600c510500b003cfca1a327fso6550115wms.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:34:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOnSzZsHYJMsU4U1iQE6DAPLRF/mhbFHpR28YkQY5sY=;
        b=3pI0TQrwj4KX3qsTvbhXbU7h3jdxTLB1L8HzvKMqxFxE6FugoLF3EB7yd4WtQXT55M
         vIO3uY7nPLvcWKCuVTRlYXqm12+NtKcb9wew/KKvNJt4sGH5hC630OU1UCL9mPv7MSkW
         vjLSHQI5io+WLrKbEkQZ4zhw4q6GH0vqesdHs1aqlQs4dK2GnvC/2Ik44RQCcDJ5PWKk
         H34bZf9405kGLxSxbYef7xDfQpMmoB9REFX5AGkAmbwDWyKqiIaAXOgJUYv5THlMOLFg
         y/SQwyKWkjIc3qxlUvMh9Ls9k/fMyV9aZeRTlUzFNJxN6LBFM2vj2vdgKDhAwDftY0AM
         3h1Q==
X-Gm-Message-State: ANoB5pm57G484CK+m9IJh4kvNZ1Oo6cU/xf2vpOpHFIVZ2slAOvv2N/Q
        dEQC5DhMkJGp4hIOgGE2ddEwdMzRx+oPo7/ppn58rrMIKCZKI7pb6pRtSE5dk71LR828yZzmKiF
        sJvjXI5khCOyM21oByl30gwp0
X-Received: by 2002:a7b:c4cc:0:b0:3cf:89c5:c241 with SMTP id g12-20020a7bc4cc000000b003cf89c5c241mr37100204wmk.204.1669656882284;
        Mon, 28 Nov 2022 09:34:42 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7Vg7Jm1kR4dA6EHQua9xX4cybNBFmpBAFyMBAC9EygowzOSbC7XNsISkS4AJ/A0EcLcu5sGA==
X-Received: by 2002:a7b:c4cc:0:b0:3cf:89c5:c241 with SMTP id g12-20020a7bc4cc000000b003cf89c5c241mr37100175wmk.204.1669656881884;
        Mon, 28 Nov 2022 09:34:41 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:9000:3d6:e434:f8b4:80cf? (p200300cbc702900003d6e434f8b480cf.dip0.t-ipconnect.de. [2003:cb:c702:9000:3d6:e434:f8b4:80cf])
        by smtp.gmail.com with ESMTPSA id u26-20020a7bcb1a000000b003cfd42821dasm15515518wmj.3.2022.11.28.09.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 09:34:41 -0800 (PST)
Message-ID: <a830d5fb-a2e7-6fdd-0426-8b884b4141bc@redhat.com>
Date:   Mon, 28 Nov 2022 18:34:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 1/3] mm/khugepaged: Take the right locks for page table
 retraction
To:     Jann Horn <jannh@google.com>
Cc:     security@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20221125213714.4115729-1-jannh@google.com>
 <fec3f46e-a777-06e7-0ba0-a8cf169afa02@redhat.com>
 <CAG48ez11R7LMxCM0QrqHT16ugqsECswCosNkQV62QsLZaLaeYQ@mail.gmail.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAG48ez11R7LMxCM0QrqHT16ugqsECswCosNkQV62QsLZaLaeYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.11.22 18:28, Jann Horn wrote:
> On Mon, Nov 28, 2022 at 2:53 PM David Hildenbrand <david@redhat.com> wrote:
>> On 25.11.22 22:37, Jann Horn wrote:
>>> pagetable walks on address ranges mapped by VMAs can be done under the mmap
>>> lock, the lock of an anon_vma attached to the VMA, or the lock of the VMA's
>>> address_space. Only one of these needs to be held, and it does not need to
>>> be held in exclusive mode.
>>>
>>> Under those circumstances, the rules for concurrent access to page table
>>> entries are:
>>>
>>>    - Terminal page table entries (entries that don't point to another page
>>>      table) can be arbitrarily changed under the page table lock, with the
>>>      exception that they always need to be consistent for
>>>      hardware page table walks and lockless_pages_from_mm().
>>>      This includes that they can be changed into non-terminal entries.
>>>    - Non-terminal page table entries (which point to another page table)
>>>      can not be modified; readers are allowed to READ_ONCE() an entry, verify
>>>      that it is non-terminal, and then assume that its value will stay as-is.
>>>
>>> Retracting a page table involves modifying a non-terminal entry, so
>>> page-table-level locks are insufficient to protect against concurrent
>>> page table traversal; it requires taking all the higher-level locks under
>>> which it is possible to start a page walk in the relevant range in
>>> exclusive mode.
>>>
>>> The collapse_huge_page() path for anonymous THP already follows this rule,
>>> but the shmem/file THP path was getting it wrong, making it possible for
>>> concurrent rmap-based operations to cause corruption.
>>
>> This sounds sane and correct to me. No expert on file-THP, though.
>>
>> For anon-THP it's the mmap lock and the rmap locks. I assume the only
>> difference for file-THP is that the rmap lock is actually the mapping
>> lock. Looking at rmap_walk_file(), that seems to be the case.
> 
> Yeah. You can also have private file VMAs that are associated with
> both a mapping and a set of anon_vmas, and in that case you would need
> to lock the mmap, the mapping, and the anon_vma root; but the file THP
> code in khugepaged instead just bails on file VMAs with an anon_vma.

Right, that's my understanding as well.

> 
>> I wish at least PTE table removal could be done easier ... I already
>> experimented some time ago with some ideas (e.g., lock in PMD table
>> memmap) but it's all far from trivial and space in the memmap is rare.
> 
> Because you want it to be faster? Is that for the THP usecase or something else?

Page table reclaim and page table migration, where you might only have 
limited context and wouldn't want to take all these expensive locks in 
write mode (IOW, you wouldn't want to care about them at all).

Feel free to add my

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

