Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01075646329
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 22:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiLGVTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 16:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiLGVTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 16:19:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EC74E402
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 13:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670447909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UZoulz6jSV4QDo6LCWvnK9BE6ZYvLdrmqHb/WNLMVyI=;
        b=JzUSDWhcB6jhRfZn9CcmpapAyTKapBqCLWi1VL/lCpI0NMyG9b9Th0ViTYXFz9oVRbdNe3
        cGzb5yX1JexXyNAK5cOrkaX6PeLlLGjy0/zds0a9394CNM3hWBh2XRGmZNooBvjsNzaVh9
        bAASB+qsCBVoVZnelCGYqz3AyJNbYNE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-651-CQv5beGgM8WZxVh9W2Hfxw-1; Wed, 07 Dec 2022 16:18:28 -0500
X-MC-Unique: CQv5beGgM8WZxVh9W2Hfxw-1
Received: by mail-wm1-f69.google.com with SMTP id b47-20020a05600c4aaf00b003d031aeb1b6so1326102wmp.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 13:18:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UZoulz6jSV4QDo6LCWvnK9BE6ZYvLdrmqHb/WNLMVyI=;
        b=u0IHrarNTZj4LIoafVM8PkFxGVyZ/she/G1eI/Zgb+KnM7bnNkhy/+YXA4YaJXf1W1
         5QzTHM3YtnYMpRkl+TOpzGCSxkOQ2q2zSodBuIsCX3NfFTmdehDdldwJH2awpv/chSC+
         q4ihbYnZz2CNDwIO80A0NaULNGDHzG9xdlVYOFd2vcjb5hZjP6blSflOj9RX5+6Xwvq5
         Oy4G2w4WvU9DK3q0vWwpPbaflLOD4PYQktOAfd5D31pbjQyR/1YK7anRtn4r7aE+KbRE
         Dd1QxQ5uUQVwe9fIPTbe38WUi+un1PZxdbhiOzBgHdOziB/2WC38hAoPo+s+hENMVrH8
         u9xA==
X-Gm-Message-State: ANoB5ploFpVmds+lVz6Jjv5BleMJZgaerlI3h7vscmNtLJrdnpHFwCXj
        2EtGCZicfmcqqkzowwles+ec/jPXL8KHizx2jJYZdTC+vCBX0w4TTl6IS4z2pyUjHesOteRVgAX
        NOre7nzuOww4kKZ1hew8oDpWO
X-Received: by 2002:a5d:4f92:0:b0:242:1845:8097 with SMTP id d18-20020a5d4f92000000b0024218458097mr27220509wru.666.1670447907453;
        Wed, 07 Dec 2022 13:18:27 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5fgorQG0KcxOAv9s8Iw+8eIlItbbpS2TXSd8gWnoUAbysFboAAFOCTtaRXkWFQxKp0ME8+pg==
X-Received: by 2002:a5d:4f92:0:b0:242:1845:8097 with SMTP id d18-20020a5d4f92000000b0024218458097mr27220503wru.666.1670447907124;
        Wed, 07 Dec 2022 13:18:27 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:2500:fe2d:7534:ffa4:c1e5? (p200300cbc7022500fe2d7534ffa4c1e5.dip0.t-ipconnect.de. [2003:cb:c702:2500:fe2d:7534:ffa4:c1e5])
        by smtp.gmail.com with ESMTPSA id j42-20020a05600c1c2a00b003c6d21a19a0sm3473213wms.29.2022.12.07.13.18.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 13:18:26 -0800 (PST)
Message-ID: <1f157500-2676-7cef-a84e-9224ed64e540@redhat.com>
Date:   Wed, 7 Dec 2022 22:18:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20221206105737.69478-1-david@redhat.com> <Y4++QNzYx1CE1ayY@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2] mm/swap: fix SWP_PFN_BITS with
 CONFIG_PHYS_ADDR_T_64BIT on 32bit
In-Reply-To: <Y4++QNzYx1CE1ayY@x1n>
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

On 06.12.22 23:12, Peter Xu wrote:
> On Tue, Dec 06, 2022 at 11:57:37AM +0100, David Hildenbrand wrote:
>> We use "unsigned long" to store a PFN in the kernel and phys_addr_t to
>> store a physical address.
>>
>> On a 64bit system, both are 64bit wide. However, on a 32bit system, the
>> latter might be 64bit wide. This is, for example, the case on x86 with
>> PAE: phys_addr_t and PTEs are 64bit wide, while "unsigned long" only
>> spans 32bit.
>>
>> The current definition of SWP_PFN_BITS without MAX_PHYSMEM_BITS misses
>> that case, and assumes that the maximum PFN is limited by an 32bit
>> phys_addr_t. This implies, that SWP_PFN_BITS will currently only be able to
>> cover 4 GiB - 1 on any 32bit system with 4k page size, which is wrong.
>>
>> Let's rely on the number of bits in phys_addr_t instead, but make sure to
>> not exceed the maximum swap offset, to not make the  BUILD_BUG_ON() in
>> is_pfn_swap_entry() unhappy. Note that swp_entry_t is effectively an
>> unsigned long and the maximum swap offset shares that value with the
>> swap type.
>>
>> For example, on an 8 GiB x86 PAE system with a kernel config based on
>> Debian 11.5 (-> CONFIG_FLATMEM=y, CONFIG_X86_PAE=y), we will currently fail
>> removing migration entries (remove_migration_ptes()), because
>> mm/page_vma_mapped.c:check_pte() will fail to identify a PFN match as
>> swp_offset_pfn() wrongly masks off PFN bits. For example,
>> split_huge_page_to_list()->...->remap_page() will leave migration
>> entries in place and continue to unlock the page.
>>
>> Later, when we stumble over these migration entries (e.g., via
>> /proc/self/pagemap), pfn_swap_entry_to_page() will BUG_ON() because
>> these migration entries shouldn't exist anymore and the page was
>> unlocked.
>>
>> [   33.067591] kernel BUG at include/linux/swapops.h:497!
>> [   33.067597] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>> [   33.067602] CPU: 3 PID: 742 Comm: cow Tainted: G            E      6.1.0-rc8+ #16
>> [   33.067605] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-1.fc36 04/01/2014
>> [   33.067606] EIP: pagemap_pmd_range+0x644/0x650
>> [   33.067612] Code: 00 00 00 00 66 90 89 ce b9 00 f0 ff ff e9 ff fb ff ff 89 d8 31 db e8 48 c6 52 00 e9 23 fb ff ff e8 61 83 56 00 e9 b6 fe ff ff <0f> 0b bf 00 f0 ff ff e9 38 fa ff ff 3e 8d 74 26 00 55 89 e5 57 31
>> [   33.067615] EAX: ee394000 EBX: 00000002 ECX: ee394000 EDX: 00000000
>> [   33.067617] ESI: c1b0ded4 EDI: 00024a00 EBP: c1b0ddb4 ESP: c1b0dd68
>> [   33.067619] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010246
>> [   33.067624] CR0: 80050033 CR2: b7a00000 CR3: 01bbbd20 CR4: 00350ef0
>> [   33.067625] Call Trace:
>> [   33.067628]  ? madvise_free_pte_range+0x720/0x720
>> [   33.067632]  ? smaps_pte_range+0x4b0/0x4b0
>> [   33.067634]  walk_pgd_range+0x325/0x720
>> [   33.067637]  ? mt_find+0x1d6/0x3a0
>> [   33.067641]  ? mt_find+0x1d6/0x3a0
>> [   33.067643]  __walk_page_range+0x164/0x170
>> [   33.067646]  walk_page_range+0xf9/0x170
>> [   33.067648]  ? __kmem_cache_alloc_node+0x2a8/0x340
>> [   33.067653]  pagemap_read+0x124/0x280
>> [   33.067658]  ? default_llseek+0x101/0x160
>> [   33.067662]  ? smaps_account+0x1d0/0x1d0
>> [   33.067664]  vfs_read+0x90/0x290
>> [   33.067667]  ? do_madvise.part.0+0x24b/0x390
>> [   33.067669]  ? debug_smp_processor_id+0x12/0x20
>> [   33.067673]  ksys_pread64+0x58/0x90
>> [   33.067675]  __ia32_sys_ia32_pread64+0x1b/0x20
>> [   33.067680]  __do_fast_syscall_32+0x4c/0xc0
>> [   33.067683]  do_fast_syscall_32+0x29/0x60
>> [   33.067686]  do_SYSENTER_32+0x15/0x20
>> [   33.067689]  entry_SYSENTER_32+0x98/0xf1
>>
>> Decrease the indentation level of SWP_PFN_BITS and SWP_PFN_MASK to keep
>> it readable and consistent.
>>
>> Fixes: 0d206b5d2e0d ("mm/swap: add swp_offset_pfn() to fetch PFN from swap entry")
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Peter Xu <peterx@redhat.com>
>> Cc: Yang Shi <shy828301@gmail.com>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>
>> v1 -> v2:
>> * Rely on sizeof(phys_addr_t) and min_t() instead.
>> * Survives my various cross compilations and testing on x86 PAE.
> 
> Good to know it works, thanks a lot.
> 
> Acked-by: Peter Xu <peterx@redhat.com>
> 

Thanks. I realized that we can simply use
	min_t(int,
instead of
	min_t(phys_addr_t,
because we're only comparing numbers < 64 ...

Might look cleaner and less complicated.


 From e6f0c1099de69a11e643e4d4ee6f470147aa174e Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Wed, 7 Dec 2022 21:15:36 +0100
Subject: [PATCH] Fixup: "mm/swap: fix SWP_PFN_BITS with
  CONFIG_PHYS_ADDR_T_64BIT on 32bit"

Let's use "int" for comparison, as we're only comparing numbers < 64.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
  include/linux/swapops.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index a70b5c3a68d7..b982dd614572 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -35,7 +35,7 @@
  #ifdef MAX_PHYSMEM_BITS
  #define SWP_PFN_BITS		(MAX_PHYSMEM_BITS - PAGE_SHIFT)
  #else  /* MAX_PHYSMEM_BITS */
-#define SWP_PFN_BITS		min_t(phys_addr_t, \
+#define SWP_PFN_BITS		min_t(int, \
  				      sizeof(phys_addr_t) * 8 - PAGE_SHIFT, \
  				      SWP_TYPE_SHIFT)
  #endif	/* MAX_PHYSMEM_BITS */
-- 
2.38.1



@Andrew, I just cross-compiled and retested with that successfully.

-- 
Thanks,

David / dhildenb

