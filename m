Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D20A6779D0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 12:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjAWLIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 06:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbjAWLH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 06:07:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5FD222EF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 03:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674472030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dHJj6GHCp84olcE9Bo8DHZkNV+HuFj5W3aT+4JQhb/A=;
        b=PdujOcIgBeVPKSQBddmbeaBky8sDhUZkj+csduj8hK98kTIOXQZyzBJI3Nh76EgcAPVL85
        smbc3JEH2XM8FZEPHlmpVlo6yR7W0ZsmSFP3d5Oc3vbx3AjG4oVEeB6HqrzZLMOI2P68sA
        dm8GUiKRPLbv4e8WE1VS4G0J6u1dy3I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-271-fPH9G_M8MkC2DZ_41vVspg-1; Mon, 23 Jan 2023 06:07:08 -0500
X-MC-Unique: fPH9G_M8MkC2DZ_41vVspg-1
Received: by mail-wr1-f71.google.com with SMTP id m12-20020adfa3cc000000b002b881cb0cb4so1879930wrb.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 03:07:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dHJj6GHCp84olcE9Bo8DHZkNV+HuFj5W3aT+4JQhb/A=;
        b=ofio1MmUjfNDxjdu5dz+xl9MSnrBWykDjTQQUGSr5NRGgbK1KhIVKtruJQ0mKm0Wfu
         1DYJVGVURz1SP2pNr6OIceDWo5RSOxb+Vs08DB1AYyRjGkMAZ2jmq/DmE5i68j9xnh23
         f5vo3lSCpteIhvrsWOHfXHWUGRX3NJjtDRwr65haa7LdkGUFPYK9A+Uqu1h2Xyq9WFpH
         lE6EYnFz4mI53n8MT1iDfCyaPULeByW5qd9XBL3U+47vvlu1f5dQuwDSLbzbbuVvs86A
         RurXarZEfdTzdqQZZNX+M13oCwgJLUdN5MauTSip2m/0oXBSRpdUHLDGHVbgiLzMFfdQ
         guew==
X-Gm-Message-State: AFqh2krdlTkS7J8RZ2T7BBGLNkL4aMkR//8rjD6uBjpw4pK0MqrSsXwv
        snrE9vnXi8jRB3GvlbQEzJh36ScV8VJVcvj1HD7yJtk2W2YwcT/xyhZSliiDoqCcoNvozJaQSK2
        58O4unjrP4siIoTgWAhJKfhHR
X-Received: by 2002:a05:600c:4256:b0:3da:1d51:ef9e with SMTP id r22-20020a05600c425600b003da1d51ef9emr23420609wmm.17.1674472027581;
        Mon, 23 Jan 2023 03:07:07 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu0Cg92QjtLeNk1itjVppuG2H1v/jszHJB9+YOuh2PaEWkxGDrwwwcVA8mXq9v9fdlxS4T6LA==
X-Received: by 2002:a05:600c:4256:b0:3da:1d51:ef9e with SMTP id r22-20020a05600c425600b003da1d51ef9emr23420580wmm.17.1674472027274;
        Mon, 23 Jan 2023 03:07:07 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:1100:65a0:c03a:142a:f914? (p200300cbc704110065a0c03a142af914.dip0.t-ipconnect.de. [2003:cb:c704:1100:65a0:c03a:142a:f914])
        by smtp.gmail.com with ESMTPSA id he11-20020a05600c540b00b003d9b89a39b2sm10206202wmb.10.2023.01.23.03.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 03:07:06 -0800 (PST)
Message-ID: <1b8696ec-e2be-7b7b-705c-e2dcabb2e8e5@redhat.com>
Date:   Mon, 23 Jan 2023 12:07:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mm/khugepaged: Fix ->anon_vma race
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>
References: <20230111133351.807024-1-jannh@google.com>
 <20230112085649.gvriasb2t5xwmxkm@box.shutemov.name>
 <CAG48ez3434wZBKFFbdx4M9j6eUwSUVPd4dxhzW_k_POneSDF+A@mail.gmail.com>
 <20230115190654.mehtlyz2rxtg34sl@box.shutemov.name>
 <CAG48ez2zeQ4+g1=B4eyrrvZRYMr1S1xKBh2_eAhCjVjhj7Lpfg@mail.gmail.com>
 <20230116123403.fiyv22esqgh7bzp3@box.shutemov.name>
 <5a7fdfa7-5b25-0ed4-2479-661d387b397b@redhat.com>
 <20230116134710.n4dgtrutt6rqif62@box.shutemov.name>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230116134710.n4dgtrutt6rqif62@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.01.23 14:47, Kirill A. Shutemov wrote:
> On Mon, Jan 16, 2023 at 02:07:41PM +0100, David Hildenbrand wrote:
>> On 16.01.23 13:34, Kirill A. Shutemov wrote:
>>> On Mon, Jan 16, 2023 at 01:06:59PM +0100, Jann Horn wrote:
>>>> On Sun, Jan 15, 2023 at 8:07 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>>>>> On Fri, Jan 13, 2023 at 08:28:59PM +0100, Jann Horn wrote:
>>>>>> No, that lockdep assert has to be there. Page table traversal is
>>>>>> allowed under any one of the mmap lock, the anon_vma lock (if the VMA
>>>>>> is associated with an anon_vma), and the mapping lock (if the VMA is
>>>>>> associated with a mapping); and so to be able to remove page tables,
>>>>>> we must hold all three of them.
>>>>>
>>>>> Okay, that's fair. I agree with the patch now. Maybe adjust the commit
>>>>> message a bit?
>>>>
>>>> Just to make sure we're on the same page: Are you suggesting that I
>>>> add this text?
>>>> "Page table traversal is allowed under any one of the mmap lock, the
>>>> anon_vma lock (if the VMA is associated with an anon_vma), and the
>>>> mapping lock (if the VMA is associated with a mapping); and so to be
>>>> able to remove page tables, we must hold all three of them."
>>>> Or something else?
>>>
>>> Looks good to me.
>>>
>>>>> Anyway:
>>>>>
>>>>> Acked-by: Kirill A. Shutemov <kirill.shutemov@intel.linux.com>
>>>>
>>>> Thanks!
>>>>
>>>>> BTW, I've noticied that you recently added tlb_remove_table_sync_one().
>>>>> I'm not sure why it is needed. Why IPI in pmdp_collapse_flush() in not
>>>>> good enough to serialize against GUP fast?
>>>>
>>>> If that sent an IPI, it would be good enough; but
>>>> pmdp_collapse_flush() is not guaranteed to send an IPI.
>>>> It does a TLB flush, but on some architectures (including arm64 and
>>>> also virtualized x86), a remote TLB flush can be done without an IPI.
>>>> For example, arm64 has some fancy hardware support for remote TLB
>>>> invalidation without IPIs ("broadcast TLB invalidation"), and
>>>> virtualized x86 has (depending on the hypervisor) things like TLB
>>>> shootdown hypercalls (under Hyper-V, see hyperv_flush_tlb_multi) or
>>>> TLB shootdown signalling for preempted CPUs through shared memory
>>>> (under KVM, see kvm_flush_tlb_multi).
>>>
>>> I think such architectures must provide proper pmdp_collapse_flush()
>>> with the required serialization. Power and S390 already do that.
>>>
>>
>> The plan is to eventually move away from (ab)using IPI to synchronize with
>> GUP-fast. Moving further into that direction a is wrong.
>>
>> The flush was added as a quick fix for all architectures by Jann, until
>> we can do better.
>>
>> Even for ppc64, see:
>>
>> commit bedf03416913d88c796288f9dca109a53608c745
>> Author: Yang Shi <shy828301@gmail.com>
>> Date:   Wed Sep 7 11:01:44 2022 -0700
>>
>>      powerpc/64s/radix: don't need to broadcast IPI for radix pmd collapse flush
>>      The IPI broadcast is used to serialize against fast-GUP, but fast-GUP will
>>      move to use RCU instead of disabling local interrupts in fast-GUP.  Using
>>      an IPI is the old-styled way of serializing against fast-GUP although it
>>      still works as expected now.
>>      And fast-GUP now fixed the potential race with THP collapse by checking
>>      whether PMD is changed or not.  So IPI broadcast in radix pmd collapse
>>      flush is not necessary anymore.  But it is still needed for hash TLB.
> 
> Okay. But I think tlb_remove_table_sync_one() belongs inside
> pmdp_collapse_flush(). Collapsing pmd table into huge page without
> serialization is a bug. They should not be separate.

Agreed. But I wonder if it should be moved into a generic 
pmdp_collapse_flush(), that calls an arch specific __pmdp_collapse_flush().

-- 
Thanks,

David / dhildenb

