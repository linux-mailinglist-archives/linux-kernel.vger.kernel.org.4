Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B5670B788
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjEVIW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbjEVIWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:22:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA90E6
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684743680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Wu/XGI/Cw3LL7Rh46pg9C16OYUTDksjb0N1uf2C+4U=;
        b=WZhfZ2ztQgQ2J7DY/tcqsCsFXb+Nh39US3w7tej5muL0Xe/X1QHuhhQfstJjSogKNZp7hf
        ATXOCn/qfC493EU9gv+cRf92v82iXe1GLBMEXOZpga7NHgd77v8Jix4xygA1dLQEMyTxse
        8HFIP4Xg0rV1IAkubcgLPwyaghev1Lk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-yd0M_vtrPJm4l9JFa2ITRw-1; Mon, 22 May 2023 04:21:16 -0400
X-MC-Unique: yd0M_vtrPJm4l9JFa2ITRw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f5df65f9f4so13495505e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684743675; x=1687335675;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Wu/XGI/Cw3LL7Rh46pg9C16OYUTDksjb0N1uf2C+4U=;
        b=UPzKNfXOScGm30CsO8v84s1gVMpaj0FFFA8wYO1CEoT5NhTRkpo+EBXiraxD0XIc7I
         4o5g27G4K7J2QRhiUIWlzLveBXjMMSKvakU2DXHkeiRcZMRXNCPadWjjcKkpVNwR1SYV
         64+uDvZYCRlXphBUIEeTYzf7FcACPP6UTJqmhYDeS/dp8sB8k+Csixje2L2Z8JQfmABf
         mqwFnuPT5RTbtxrYVH4071uYNmlOU3zUPHhi13G8svx88pGIHgOg4/mn9haS4oTrzBe0
         DpArGCFk3P3NRWCA5HS0rzgQ73j+25q4nRhW53o0E2x4cdzeetfiaG9fiwvYOfM7X0/E
         FiCw==
X-Gm-Message-State: AC+VfDyRQ8Nne6x2GohHYpbZ++gpFjC6sJh34tzSJflMnoupSNqwdlTH
        mfKuzZk5LmqENFlkJB5SzK27YDuK9LT56kqHTIE5hQSq3oqi9+X9JgJ3kewgOIwqgqgozkWs9tC
        lkTOgg47KW1ZvKgDXRbTGz2ap
X-Received: by 2002:a1c:f70e:0:b0:3f4:2b1a:553b with SMTP id v14-20020a1cf70e000000b003f42b1a553bmr6741831wmh.28.1684743675399;
        Mon, 22 May 2023 01:21:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6mG7l4xGGoGOdmClG/pwLidLadfZoXsxEEQrH052zzBQHncEp4Wz9Jql141DWAS4jQSBmoww==
X-Received: by 2002:a1c:f70e:0:b0:3f4:2b1a:553b with SMTP id v14-20020a1cf70e000000b003f42b1a553bmr6741816wmh.28.1684743675017;
        Mon, 22 May 2023 01:21:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c742:c800:d74f:aec6:f8ac:558? (p200300cbc742c800d74faec6f8ac0558.dip0.t-ipconnect.de. [2003:cb:c742:c800:d74f:aec6:f8ac:558])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c021000b003f50d6ee334sm7400593wmi.47.2023.05.22.01.21.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 01:21:14 -0700 (PDT)
Message-ID: <c7e3152b-4fdd-cb93-a4f0-06502eab59b1@redhat.com>
Date:   Mon, 22 May 2023 10:21:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>,
        virtualization@lists.linux-foundation.org, linux@rivosinc.com,
        Alexandre Ghiti <alexghiti@rivosinc.com>
References: <20230512145737.985671-1-bjorn@kernel.org>
 <9aa7d030-19b5-01df-70c0-86d8d6ab86a6@redhat.com>
 <87zg62eqm4.fsf@all.your.base.are.belong.to.us>
 <87lehikpu6.fsf@all.your.base.are.belong.to.us>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 0/7] riscv: Memory Hot(Un)Plug support
In-Reply-To: <87lehikpu6.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.05.23 11:15, Björn Töpel wrote:
> Hi David and Anshuman!
> 
> Björn Töpel <bjorn@kernel.org> writes:
> 
>> David Hildenbrand <david@redhat.com> writes:
>>
>>> On 12.05.23 16:57, Björn Töpel wrote:
>>>> From: Björn Töpel <bjorn@rivosinc.com>
>>>>
>>>> Memory Hot(Un)Plug support for the RISC-V port
>>>> ==============================================
>>
>> [...]
>>
>>>
>>> Cool stuff! I'm fairly busy right now, so some high-level questions upfront:
>>
>> No worries, and no rush! I'd say the v1 series was mainly for the RISC-V
>> folks, and I've got tons of (offline) comments from Alex -- and with
>> your comments below some more details to figure out.
> 
> One of the major issues with my v1 patch is around init_mm page table
> synchronization, and that'll be part of the v2.
> 
> I've noticed there's a quite a difference between x86-64 and arm64 in
> terms of locking, when updating (add/remove) the init_mm table. x86-64
> uses the usual page table locking mechanisms (used by the generic
> kernel functions), whereas arm64 does not.
> 
> How does arm64 manage to mix the "lock-less" updates (READ/WRITE_ONCE,
> and fences in set_p?d+friends), with the generic kernel ones that uses
> the regular page locking mechanism?
> 
> I'm obviously missing something about the locking rules for memory hot
> add/remove... I've been reading the arm64 memory hot add/remove
> series, but none the wiser! ;-)

In general, memory hot(un)plug is serialized on a high level using the 
mem_hotplug_lock. For example, in pagemap_range() or in 
add_memory_resource(), we grab that lock in write mode. So we'll never 
see memory getting added/removed concurrently from the direct map.

 From what I recall, the locking on the arch level is required for 
concurrent (direct mapping) page table modifications that target virtual 
address ranges adjacent to the ranges we hot(un)plug:
CONFIG_ARCH_HAS_SET_DIRECT_MAP and vmalloc come to mind.

For example, if a range would be mapped using a large PUD, but we have 
to unplug it partially (unplugging memory part of bootmem), we'd have to 
replace the large PUD by a PMD table first. That change (that could 
affect other concurrent page table walkers/operations) has to be 
synchronized.

I guess to which degree this applies to riscv depends on the virtual 
memory layout, direct mapping granularity and features (e.g., 
CONFIG_ARCH_HAS_SET_DIRECT_MAP).


One trick that arm64 implements is, that it only allows hotunplugging 
memory that was hotplugged (see prevent_bootmem_remove_notifier()). That 
might just rule out such problematic cases that require locking 
completely, and the high-level mem_hotplug_lock sufficient.

-- 
Thanks,

David / dhildenb

