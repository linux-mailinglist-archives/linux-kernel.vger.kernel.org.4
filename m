Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF396D4BAE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjDCPVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjDCPVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:21:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BF910D5
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 08:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680535227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MUeaj7hBfuCp2NtQjNloBx3xDvLT9LLe4pBcw9XRijI=;
        b=BlG3+3tuZfk5Dy+JqrDeRUiOaQ9CfggLu79mTWxBgq/9Waxdhx8e/Pn6lvLIvOv5T06ANm
        R8m3fBo7OJA3Q0WZjkf7Gd5guwVpIrneMpSygx/7jVhsft9LVBIxMDEFV5GCjQfeD4SS+s
        Ucep91wYKliOJOPkczxC23DpiXSEAj8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-io73D8naNEep17oft2MVTQ-1; Mon, 03 Apr 2023 11:20:25 -0400
X-MC-Unique: io73D8naNEep17oft2MVTQ-1
Received: by mail-wm1-f72.google.com with SMTP id bg33-20020a05600c3ca100b003ef6d684105so12030292wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 08:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680535224;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MUeaj7hBfuCp2NtQjNloBx3xDvLT9LLe4pBcw9XRijI=;
        b=MPQqeQU3qqEaqryqX5JnAwUHjdLTgyyyv5mdOSOI4CqWAcrqhqQvflIqVNdVXZOp4I
         18rsyEKAUuvL6eEo6Pyniesy+ibxBZiUuOHIN7+M/Gikd/A13Le8NK64fW4P/XyhOXUA
         nnb1LASsyJ0yym3nElGS8BRY8fOcNSs91QPsgsBupWy6So6SyytR+CJ1K8h5hlzcEiJn
         2ZediMCa4M2VzRDLio+WmD5HFQTIXAbTlZ8I0hqODEmgF5Pgkut3+jl2S8HwPb6vDhg1
         6a4DFniFOgvVsoqUbeh+PcncFzSUUrKsK99SnX+1+yWeMnM5Vz0US/qQZOZUk9lQu0lm
         rI4g==
X-Gm-Message-State: AAQBX9dGppxo5Zg8AAEKfBIp1gdcFSIp+9sp/UarjzhphFLm/LqEMqeU
        mfPGkxgyT39Hw4pkMoVUaWb5v10edzADxBHNdXXN+K0VfcCdAtTRE9KXNW9tKIiJmG4DV0g48Sg
        t9v+3sHAOohS8UHnuT2Ov9YJ3
X-Received: by 2002:a5d:650d:0:b0:2e4:bfa0:8c2f with SMTP id x13-20020a5d650d000000b002e4bfa08c2fmr11440330wru.47.1680535224625;
        Mon, 03 Apr 2023 08:20:24 -0700 (PDT)
X-Google-Smtp-Source: AKy350a6wVwzOx9EXdz0NZZ4oD+60oiKSpdfYDgkoEKg8O54qtXyUeqlh0i0Ix+QB0cWJVAUVQo99g==
X-Received: by 2002:a5d:650d:0:b0:2e4:bfa0:8c2f with SMTP id x13-20020a5d650d000000b002e4bfa08c2fmr11440314wru.47.1680535224277;
        Mon, 03 Apr 2023 08:20:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:5e00:8e78:71f3:6243:77f0? (p200300cbc7025e008e7871f3624377f0.dip0.t-ipconnect.de. [2003:cb:c702:5e00:8e78:71f3:6243:77f0])
        by smtp.gmail.com with ESMTPSA id j7-20020a5d6047000000b002e105c017adsm9973759wrt.44.2023.04.03.08.20.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 08:20:23 -0700 (PDT)
Message-ID: <533a7c3d-3a48-b16b-b421-6e8386e0b142@redhat.com>
Date:   Mon, 3 Apr 2023 17:20:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To:     xu xin <xu.xin.sc@gmail.com>
Cc:     akpm@linux-foundation.org, imbrenda@linux.ibm.com,
        jiang.xuexin@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, xu.xin16@zte.com.cn,
        yang.yang29@zte.com.cn
References: <78e35d88-8a4e-3b36-bbbd-94048c0c5b54@redhat.com>
 <20230330120654.120937-1-xu.xin16@zte.com.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v6 0/6] ksm: support tracking KSM-placed zero-pages
In-Reply-To: <20230330120654.120937-1-xu.xin16@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.03.23 14:06, xu xin wrote:
> Hi, I'm sorry to reply so late because I was so busy with my job matters recently.
> 
> I appreciate David's idea of simplifying the implement of tracking KSM-placed zero pages.
> But I'm confused with how to implement that via pte_mkdirty/pte_dirty without affecting
> other functions now and in the future.

No need to worry about too much about the future here :)

> 
>>
>> I already shared some feedback in [1]. I think we should try to simplify
>> this handling, as proposed in that mail. Still waiting for a reply.
>>
>> [1]
>> https://lore.kernel.org/all/9d7a8be3-ee9e-3492-841b-a0af9952ef36@redhat.com/
> 
> I have some questions about using pte_mkdirty to mark KSM-placed zero pages.
> 
> (1) Will KSM using pte_mkdirty to mark KSM-placed zero pages collides with the existing
>      handling of the same pte in other featutes? And in the future, what if there are new
>      codes also using pte_mkdirty for other goals.

So far I am not aware of other users of the dirty bit for the shared zeropage. If ever
required (why?) we could try finding another PTE bit. Or use a completely separate set
of zeropages, if ever really running out of PTE bits.

I selected pte_dirty() because it's available on all architectures and should be unused
on the shared zeropage (always clean).

Until then, we only have to worry about architectures that treat R/O dirty PTEs as writable
(I only know sparc64), maybe a good justification to finally fix sparc64 and identify others.
Again, happy to help here. [1]

> 
> (2) Can the literal meaning of pte_mkdiry represents a pte that points to ksm zero page?

I briefly scanned the code. pte_dirty() should mostly not matter for the shared zeropage.
We have to double check (will do as well).

> 
> (3) Suppose we use the pte_mkdirty approach, how to update/decline the count of ksm_zero_pages
>      when upper app writting on the page triggers COW(Copy on Write)? In *mm_fault outside
>      mm/ksm.c ?

yes. Do it synchronously when unmapping the shared zeropage.


diff --git a/mm/memory.c b/mm/memory.c
index f456f3b5049c..78b6c60602dd 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1351,6 +1351,8 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
         pte_install_uffd_wp_if_needed(vma, addr, pte, pteval);
  }
  
+#define is_ksm_zero_pte(pte) (is_zero_pfn(pte_pfn(pte)) && pte_dirty(pte))
+
  static unsigned long zap_pte_range(struct mmu_gather *tlb,
                                 struct vm_area_struct *vma, pmd_t *pmd,
                                 unsigned long addr, unsigned long end,
@@ -1392,8 +1394,11 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
                         tlb_remove_tlb_entry(tlb, pte, addr);
                         zap_install_uffd_wp_if_needed(vma, addr, pte, details,
                                                       ptent);
-                       if (unlikely(!page))
+                       if (unlikely(!page)) {
+                               if (is_ksm_zero_pte(ptent))
+                                       /* TODO: adjust counter */
                                 continue;
+                       }
  
                         delay_rmap = 0;
                         if (!PageAnon(page)) {
@@ -3111,6 +3116,8 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
                                 inc_mm_counter(mm, MM_ANONPAGES);
                         }
                 } else {
+                       if (is_ksm_zero_pte(orig_pte))
+                               /* TODO: adjust counter */
                         inc_mm_counter(mm, MM_ANONPAGES);
                 }
                 flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));


The nice thing is, if we get it wrong we "only" get wrong counters.

A prototype for that should be fairly simple -- to see what we're missing.

> 
> 
> Move the previos message here to reply together.
>> The problem with this approach I see is that it fundamentally relies on
>> the rmap/stable-tree to detect whether a zeropage was placed or not.
>>
>> I was wondering, why we even need an rmap item *at all* anymore. Why
>> can't we place the shared zeropage an call it a day (remove the rmap
>> item)? Once we placed a shared zeropage, the next KSM scan should better
>> just ignore it, it's already deduplicated.
> 
> The reason is as follows ...
> Initially, all scanned pages by ksmd will be assigned a rmap_item storing the page
> information and ksm information, which helps ksmd can know every scanned pages' status and
> update all counts especialy when COW happens. But since use_zero_pages feature was merged,
> the situation changed, ksm zero pages is the only exception of ksm-scanned page without owning
> a rmap_item in KSM, which leads to ksmd even don't know the existing of KSM-placed, and thus
> causes the problem of our patches aimed to solve.
> 

Understood, so per-PTE information would similarly work.


[1] https://lkml.kernel.org/r/20221212130213.136267-1-david@redhat.com

-- 
Thanks,

David / dhildenb

