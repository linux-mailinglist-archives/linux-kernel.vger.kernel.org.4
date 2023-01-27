Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2338467EAB8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbjA0QVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbjA0QUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:20:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1496845228
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674836404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QQC+GA2acrVBeLgoGs0vfKE8KELNAReQCZ4cMvGb/2s=;
        b=IRwgJWrKT5g5mjfzEQ98ui2rsIlaOcMjHZphHuNcabUBC3MFUgBQ+oM/1f8d8sA5j9WcxX
        XTo/K5ea0hlh9MSgWMH1w+bkZJJBnGeyKxocXkhp9NuhwOC7Z/1lDPotpCu4ZaUwttR1ot
        o5UoNMI6VSAq9Lx6zBLIUwk9Cw2jqps=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-42-o6LpzG0TNXWf-7hCqS4b2Q-1; Fri, 27 Jan 2023 11:20:03 -0500
X-MC-Unique: o6LpzG0TNXWf-7hCqS4b2Q-1
Received: by mail-wm1-f72.google.com with SMTP id m10-20020a05600c3b0a00b003dafe7451deso3029217wms.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:20:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQC+GA2acrVBeLgoGs0vfKE8KELNAReQCZ4cMvGb/2s=;
        b=LwrNS8MCyikuLn8iiaDbUrnjHKSKw84Je5liGyDl7wzp+e1h6LqRecWmtY/XQDYg7S
         aa9A9Gx438zaiCErXgJZTNxx7NXiCGQs8J1DnMFSeWoAAxNzHRxj9HyGDpmaxEC9C8IB
         5egsBl3yL0jIqj/ZV5iVy4QrfxQyx7K92xQWWIrZY8Rj01qm6Wel812KroZVDiEaC4Uu
         PTy37KjmGuRvKfFQQQQd7k5bPqnd+F6IqLOAPCM+jNZDJ1g2Vj5FdAfhTWcoEKuj4Efu
         D5blijJ3bijbFAKzgXktNXl6Smz+Wxz3izojukaUfKgP0x900oxPcZyL4PQBKyMVHwoa
         +Bbg==
X-Gm-Message-State: AFqh2ko4OYmSb4EJTeCetcYkzczK+r0N5dBwdmCDZT58Z/a3JeWLTLJw
        zbUMibo3DQ4funfPItC3vvb5gwpkLLyW7V8lzhqnZABkDocBF2buDQ5c2kNAD5LihRV3NGbkNJs
        TsQ7FGa++6snz3Drh29CQX/8v
X-Received: by 2002:a05:600c:54d0:b0:3da:f9c9:cec9 with SMTP id iw16-20020a05600c54d000b003daf9c9cec9mr40473691wmb.1.1674836401768;
        Fri, 27 Jan 2023 08:20:01 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvvcS/R7Lu9IpyYbItqDsPLR6yhYqQH7DSpvxyzPtIpO1WxqsHHYvBoFeUij0ZOWcXGc/xzYA==
X-Received: by 2002:a05:600c:54d0:b0:3da:f9c9:cec9 with SMTP id iw16-20020a05600c54d000b003daf9c9cec9mr40473649wmb.1.1674836401472;
        Fri, 27 Jan 2023 08:20:01 -0800 (PST)
Received: from ?IPV6:2003:d8:2f16:1800:a9b4:1776:c5d9:1d9a? (p200300d82f161800a9b41776c5d91d9a.dip0.t-ipconnect.de. [2003:d8:2f16:1800:a9b4:1776:c5d9:1d9a])
        by smtp.gmail.com with ESMTPSA id k18-20020a05600c081200b003dc3a6f9447sm2446245wmp.32.2023.01.27.08.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 08:20:00 -0800 (PST)
Message-ID: <349bbece-485c-4898-4583-b8f588f8322f@redhat.com>
Date:   Fri, 27 Jan 2023 17:19:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Cc:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
 <20230119212317.8324-19-rick.p.edgecombe@intel.com>
 <7f63d13d-7940-afb6-8b25-26fdf3804e00@redhat.com>
 <50cf64932507ba60639eca28692e7df285bcc0a7.camel@intel.com>
 <1327c608-1473-af4f-d962-c24f04f3952c@redhat.com>
 <8c3820ae1448de4baffe7c476b4b5d9ba0a309ff.camel@intel.com>
 <4d224020-f26f-60a4-c7ab-721a024c7a6d@redhat.com>
 <dd06b54291ad5721da392a42f2d8e5636301ffef.camel@intel.com>
 <79e0a85e-1ec4-e359-649d-618ca79c36f7@redhat.com>
 <4ebbdd643853ff02c930baee817ba6f515595224.camel@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v5 18/39] mm: Handle faultless write upgrades for shstk
In-Reply-To: <4ebbdd643853ff02c930baee817ba6f515595224.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Now shadow stack memory creation is tightly controlled. Either created
> via special syscall or automatically with a new thread.

Good, it would be valuable to document that somewhere ("Neve rapplies to 
VM_SHARED|VM_MAYSHARE VMAs").

[...]

>>
>> The other thing I had in mind was that we have to make sure that
>> we're
>> not accidentally setting "Write=0,Dirty=1" in mk_pte() /
>> pte_modify().
>>
>> Assume we had a "Write=1,Dirty=1" PTE, and we effectively wrprotect
>> using pte_modify(), we have to make sure to move the dirty bit to
>> the
>> saved_dirty bit.
> 
> For the mk_pte() case, I don't think a Write=0,Dirty=1 prot could come
> from anywhere. I guess the MAP_SHARED case is a little less bounded. We
> could maybe add a warning for this case.

Right, Write=0,Dirty=1  shouldn't apply at that point if shstk are 
always wrprotected as default.

> 
> For the pte_modify() case, this does happen. There are two scenarios
> considered:
> 1. A Write=0,Dirty=0 PTE is made dirty. This can't happen today as
> Dirty is filtered via _PAGE_CHG_MASK. Basically pte_modify() doesn't
> support it.

It should simply set the saved_dirty bit I guess. But I don't think 
pte_modify() is actually supposed to set PTEs dirty (primary goal is to 
change protection IIRC).

> 2. A Write=1,Dirty=1 PTE gets write protected. This does happen because
> the Write=0 prot comes from protection_map, and pte_modify() would
> leave the Dirty=1 bit alone. The main case I know of is mprotect(). It
> is handled by changes to pte_modify() by doing the Dirty->SoftDirty
> fixup if needed.

Right, we'd have to move the dirty bit to the saved_dirty bit. (we have 
to handle soft-dirty, too, whenever setting the PTE dirty -- either via 
the dirty bit or via the saved_dirty bit)

> 
> So pte_modify()s job should not be too tricky. What you can't do with
> it though, is create shadow stack PTEs. But it is ok for our uses
> because of the explicit mkwrite().

I think you are correct.

-- 
Thanks,

David / dhildenb

