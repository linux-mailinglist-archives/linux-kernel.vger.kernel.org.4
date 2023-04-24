Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FE46E4EDC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 19:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjDQRKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 13:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjDQRKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 13:10:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418EA93D6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 10:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681751396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QQNksUmrzmpV+dashnfxg18WBPJ6A9aN9By2cdYHves=;
        b=QZNiTPVoY971LY/pRhuBowPvsGeD/SJAAREVfLASe1IT411R+xcrmjWcE7PHsR0zRg9s2V
        VOm93hD4X0tOeDkn8t5rwe1EfnSvxiim2WfKi3GMBCRNeKqaa4e3tnqzs6WX4CCW0nIrGQ
        MUeBC99/qvBqVNZgaBHbWpvfotKaRh4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-2euPTf4TPA-9uzB0hurxZg-1; Mon, 17 Apr 2023 13:09:55 -0400
X-MC-Unique: 2euPTf4TPA-9uzB0hurxZg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-2f96ecfb40cso339506f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 10:09:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681751394; x=1684343394;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQNksUmrzmpV+dashnfxg18WBPJ6A9aN9By2cdYHves=;
        b=HcFFtwwEE/Vnt620BT1AvfU4+rv6wf2fAB/x9L7lxhfeVIpmG8DIdZ31JcMpvxUHLz
         HpowVdSOballR7FPck53Mf8cR8l/5+9KMCIK0FX53WduAO34KFEQck+JOseGRps846rt
         3qRy+Nv+pm32xWrM8cROpfHGE6070O+/dZg0ZKcL1gj655rphhZhPUn8woVsnWuM+Sqm
         DTtW06Yff4+iCoR5mVmQPgk/e+nR+RlMnC+E2ZborH2OKhAkJ4A8ltAahbQnaT7OyjsZ
         5DOnx4BSheYDh7T9+El/14OUylGZ+zxx1hXTU3RpeUKM/JIl8adKoc8eIi0rF0kEvj+q
         7iwQ==
X-Gm-Message-State: AAQBX9dfUI1P2+EybrklJrVRccW/fuLrbqgV5BoRzmGm1waJ1OxkNXRX
        uR1gSOPdvu2T+vA4q1C67bdYGv0zAcDhJXSbBzEHyOZD52HiahPVjyBPuz/OpUU6KD3YqDL4GsB
        7IGV+DC2+TeNYiSPFGAudIqSQ
X-Received: by 2002:a5d:6047:0:b0:2ce:5056:7220 with SMTP id j7-20020a5d6047000000b002ce50567220mr6182908wrt.51.1681751394161;
        Mon, 17 Apr 2023 10:09:54 -0700 (PDT)
X-Google-Smtp-Source: AKy350abOJY4ermk86mEx3aLL0hUx/Uw/xriKRUGaKLzwhECDk+l7gZYG1YfQbJ9xANQ6vxXp2Tb5A==
X-Received: by 2002:a5d:6047:0:b0:2ce:5056:7220 with SMTP id j7-20020a5d6047000000b002ce50567220mr6182878wrt.51.1681751393755;
        Mon, 17 Apr 2023 10:09:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:fc00:db07:68a9:6af5:ecdf? (p200300cbc700fc00db0768a96af5ecdf.dip0.t-ipconnect.de. [2003:cb:c700:fc00:db07:68a9:6af5:ecdf])
        by smtp.gmail.com with ESMTPSA id e16-20020a5d4e90000000b002f2782978d8sm10866353wru.20.2023.04.17.10.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 10:09:53 -0700 (PDT)
Message-ID: <1ed06a62-05a1-ebe6-7ac4-5b35ba272d13@redhat.com>
Date:   Mon, 17 Apr 2023 19:09:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        tabba@google.com, Michael Roth <michael.roth@amd.com>,
        wei.w.wang@intel.com, Mike Rapoport <rppt@kernel.org>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Ackerley Tng <ackerleytng@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <ZD1oevE8iHsi66T2@google.com>
 <658018f9-581c-7786-795a-85227c712be0@redhat.com>
 <ZD12htq6dWg0tg2e@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: Rename restrictedmem => guardedmem? (was: Re: [PATCH v10 0/9]
 KVM: mm: fd-based approach for supporting KVM)
In-Reply-To: <ZD12htq6dWg0tg2e@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.04.23 18:40, Sean Christopherson wrote:
> On Mon, Apr 17, 2023, David Hildenbrand wrote:
>> On 17.04.23 17:40, Sean Christopherson wrote:
>>> I want to start referring to the code/patches by its syscall/implementation name
>>> instead of "UPM", as "UPM" is (a) very KVM centric, (b) refers to the broader effort
>>> and not just the non-KVM code, and (c) will likely be confusing for future reviewers
>>> since there's nothing in the code that mentions "UPM" in any way.
>>>
>>> But typing out restrictedmem is quite tedious, and git grep shows that "rmem" is
>>> already used to refer to "reserved memory".
>>>
>>> Renaming the syscall to "guardedmem"...
>>
>> restrictedmem, guardedmem, ... all fairly "suboptimal" if you'd ask me ...
> 
> I'm definitely open to other suggestions, but I suspect it's going to be difficult
> to be more precise than something like "guarded".

Guardedmem is just as bad as restrictedmem IMHO, sorry.


Restricted: what's restricted? how does the restriction manifest? 
secretmem also has it's restrictions/limitations (pinning), why does 
that one not fall under the same category?

Make a stranger guess what "restrictedmem" is and I can guarantee that 
it has nothing to do with the concept we're introducing here.


Guarded: what's guarded? From whom? For which purpose? How does the 
"guarding" manifest?

Again, make a stranger guess what "guardedmem" is and I can guarantee 
that it has nothing to do with the concept we're introducing here.

If, at all, the guess might be "guarded storage" [1] on s390x, which, of 
course, has nothing to do with the concept here. (storage on s390x is 
just the dinosaur slang for memory)


Often, if we fail to find a good name, the concept is either unclear or 
not well defined.

So what are the characteristics we want to generalize under that new 
name? We want to have an fd, that

(a) cannot be mapped into user space (mmap)
(b) cannot be accessed using ordinary system calls (read/write)
(c) can still be managed like other fds (fallocate, future NUMA
     policies?)
(d) can be consumed by some special entities that are allowed to
     read/write/map.

So the fd content is inaccessible using the ordinary POSIX syscalls. 
It's only accessible by special entities (e.g., KVM).

Most probably I am forgetting something. But maybe that will help to 
find a more expressive name. Maybe :)

> 
> E.g. we discussed "unmappable" at one point, but the memory can still be mapped,
> just not via mmap().  And it's not just about mappings, e.g. read() and its many
> variants are all disallowed too, despite the kernel direct map still being live
> (modulo SNP requirements).
> 

[1] https://man.archlinux.org/man/s390_guarded_storage.2.en

-- 
Thanks,

David / dhildenb

