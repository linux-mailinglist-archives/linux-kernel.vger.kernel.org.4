Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDABB69DC3D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 09:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbjBUIje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 03:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbjBUIjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 03:39:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E5E234E2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 00:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676968713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ka8yKsNqGuV7c8XzxIyetsQ+yohDTXMzd54elUnsMIg=;
        b=alNBxmufDq0ncvjnzOZL3sLEvBqoOPu0Z20r9pRM2CN664Nfpx+8H6xviGVY8AQrGjT04k
        uU0BsIY4z2mvifaNM12z4t7hct0zroL7LAgXmmHT89T5YsSFOYOgIfQdkhtfYuL+eu3EQk
        xQt6KeNHPtpfbRai7wQzb+WsC+cEA48=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-10-5XIiEf32OvaCvB3dBvxvEw-1; Tue, 21 Feb 2023 03:38:31 -0500
X-MC-Unique: 5XIiEf32OvaCvB3dBvxvEw-1
Received: by mail-wm1-f69.google.com with SMTP id k20-20020a05600c1c9400b003e2249bd2b4so1795362wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 00:38:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ka8yKsNqGuV7c8XzxIyetsQ+yohDTXMzd54elUnsMIg=;
        b=uEMNo9xD0dPIvtFYqUwC+mwE5m470SQ9tav85HQMCcS8qS2Phn7nqhBcsb25lqjE0q
         svWgtXbmOGgiaA7WJLQ8lYy1HKMwyF0oM1uCeAKR1P5q6uCv2E7PD3YguPjbzvnM9/ps
         /1EtwrKxiW7KRW7VJCP1Vy7e8n9iqo6v4HaXJtkgsTFSKz8rhGHaApZjUz0ufwDLM/lW
         BZ1/SW+k1Fc715CXncbSLyHjlwnR0JcOD0kzNO4J1wGW00213+daAlNgvY2nngtuUPsg
         n17igcPycCHn3ehKxAOIooN6Bp7PWZOIIfh924xQwR3l2AfVDeQ6BkNbRuTCN/IKykMN
         FiYQ==
X-Gm-Message-State: AO0yUKWN9WspftpByFaEaC+5h6mjaEUmxUtveUgGybOblM6eFZ8hZHob
        WHOy+N9h+rMofMlamd52KpmQRIpTyMMz9lKi4Bb65vyc/b3QLAwF5itcY+lrN8zvmnjM+M2Dpxr
        u1rOaLrMQ4CqPEtpQkfg97ZQs
X-Received: by 2002:a05:6000:1141:b0:2c5:a19e:6d16 with SMTP id d1-20020a056000114100b002c5a19e6d16mr2106356wrx.61.1676968709916;
        Tue, 21 Feb 2023 00:38:29 -0800 (PST)
X-Google-Smtp-Source: AK7set9xmVVeqlz0SJdIvYxvoGZ+QENG9hT6lVbWaYP3zkoQhjiyjPjHe9AF4f0plUey4v3xSojS0w==
X-Received: by 2002:a05:6000:1141:b0:2c5:a19e:6d16 with SMTP id d1-20020a056000114100b002c5a19e6d16mr2106332wrx.61.1676968709569;
        Tue, 21 Feb 2023 00:38:29 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:4800:aecc:dadb:40a8:ce81? (p200300cbc7074800aeccdadb40a8ce81.dip0.t-ipconnect.de. [2003:cb:c707:4800:aecc:dadb:40a8:ce81])
        by smtp.gmail.com with ESMTPSA id u3-20020adff883000000b002c703d59fa7sm1615085wrp.12.2023.02.21.00.38.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 00:38:28 -0800 (PST)
Message-ID: <6e1201f5-da25-6040-8230-c84856221838@redhat.com>
Date:   Tue, 21 Feb 2023 09:38:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v6 14/41] x86/mm: Introduce _PAGE_SAVED_DIRTY
Content-Language: en-US
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
 <20230218211433.26859-15-rick.p.edgecombe@intel.com>
 <70681787-0d33-a9ed-7f2a-747be1490932@redhat.com>
 <6f19d7c7ad9f61fa8f6c9bd09d24524dbe17463f.camel@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <6f19d7c7ad9f61fa8f6c9bd09d24524dbe17463f.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.02.23 22:38, Edgecombe, Rick P wrote:
> On Mon, 2023-02-20 at 12:32 +0100, David Hildenbrand wrote:
>> On 18.02.23 22:14, Rick Edgecombe wrote:
>>> Some OSes have a greater dependence on software available bits in
>>> PTEs than
>>> Linux. That left the hardware architects looking for a way to
>>> represent a
>>> new memory type (shadow stack) within the existing bits. They chose
>>> to
>>> repurpose a lightly-used state: Write=0,Dirty=1. So in order to
>>> support
>>> shadow stack memory, Linux should avoid creating memory with this
>>> PTE bit
>>> combination unless it intends for it to be shadow stack.
>>>
>>> The reason it's lightly used is that Dirty=1 is normally set by HW
>>> _before_ a write. A write with a Write=0 PTE would typically only
>>> generate
>>> a fault, not set Dirty=1. Hardware can (rarely) both set Dirty=1
>>> *and*
>>> generate the fault, resulting in a Write=0,Dirty=1 PTE. Hardware
>>> which
>>> supports shadow stacks will no longer exhibit this oddity.
>>>
>>> So that leaves Write=0,Dirty=1 PTEs created in software. To achieve
>>> this,
>>> in places where Linux normally creates Write=0,Dirty=1, it can use
>>> the
>>> software-defined _PAGE_SAVED_DIRTY in place of the hardware
>>> _PAGE_DIRTY.
>>> In other words, whenever Linux needs to create Write=0,Dirty=1, it
>>> instead
>>> creates Write=0,SavedDirty=1 except for shadow stack, which is
>>> Write=0,Dirty=1. Further differentiated by VMA flags, these PTE bit
>>> combinations would be set as follows for various types of memory:
>>
>> I would simplify (see below) and not repeat what the patch contains
>> as
>> comments already that detailed.
> 
> This verbiage has had quite a bit of x86 maintainer attention already.
> I hear what you are saying, but I'm a bit hesitant to take style
> suggestions at this point for fear of the situation where people ask
> for changes back and forth across different versions. Unless any x86
> maintainers want to chime in again? More responses below.

Sure, for my taste this is (1) too repetitive (2) too verbose (3) to 
specialized. But whatever x86 maintainers prefer.

[...]

>> "
>> However, there are valid cases where the kernel might create read-
>> only
>> PTEs that are dirty (e.g., fork(), mprotect(), uffd-wp(), soft-dirty
>> tracking). In this case, the _PAGE_SAVED_DIRTY bit is used instead
>> of
>> the HW-dirty bit, to avoid creating a wrong "shadow stack" PTEs.
>> Such
>> PTEs have (Write=0,SavedDirty=1,Dirty=0) set.
>>
>> Note that on processors without shadow stack support, the
>> _PAGE_SAVED_DIRTY remains unused.
>> "
>>
>> The I would simply drop below (which is also too COW-specific I
>> think).
> 
> COW is the main situation where shadow stacks become read-only. So, as
> an example it is nice in that COW covers all the scenarios discussed.
> Again, do any x86 maintainers want to weigh in here?

Again, I'd not specialize on COW in all patches to much (IMHO, it 
creates more confusion than it actually helps for understanding what's 
happening) and just call it a read-only PTE that is dirty. Simple as 
that. And it's easy to see why that's problematic, because read-only 
PTEs that are dirty would be identified as shadow stack PTEs, which we 
want to work around.

Again, just my 2 cents. I'm not an x86 maintainer ;)

-- 
Thanks,

David / dhildenb

