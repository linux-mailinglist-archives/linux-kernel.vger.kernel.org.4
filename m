Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7573643F39
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 10:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbiLFJB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 04:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbiLFJB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 04:01:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1281B1C3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 01:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670317228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HGTXIY8L+DJ21AIcNg1CmE9ujShwBnVaqo1xss4HQhk=;
        b=WyN9SVGNNTr3a6PTA511s3vCzkO88wMUOa//WilYBvUAdjXQr8SLByPM/isX+bZlHXycMq
        YhZ4o6XGYy88BCmWhu+ZBnu3Yyu+Z4hWEAPuvXPUlHyKscsjZJpzyUGWbW0XpC1SUnUUBn
        rkuVPb3SNZC5zN21B2n0kR2QeUK28iE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-418-OaeF2u0NPE6oCMyZnT-Q5w-1; Tue, 06 Dec 2022 04:00:26 -0500
X-MC-Unique: OaeF2u0NPE6oCMyZnT-Q5w-1
Received: by mail-wm1-f69.google.com with SMTP id i203-20020a1c3bd4000000b003d0f49bc21bso4090470wma.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 01:00:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HGTXIY8L+DJ21AIcNg1CmE9ujShwBnVaqo1xss4HQhk=;
        b=R4WTndXqSUhov7gcF+L5mN6rRYGE00u2isbveJ2drVVouCwxN9UFIG12SdQYeXCd3C
         GgBnIqTPMlCUP0MOzYBXs8s0siji4KZ5ZdDJgWlEoqJkyskBpFn/Ehh11syY11P/X0wT
         9z4k+lzvIU2U67wj/uGjjKZqX9K0l3rVLjF+iq6WDchdEL6s7bA3JcpnfLqnF4vZlYH7
         xo+zHYL0XjDkkn7OLMAn4m74/TwMopra98uQagEHRyRIgjCtEsmWUWTHouyWuXRqc1VJ
         4LcE+UZXQnOnbdPteU5ePYQk01Z0ODUoNhHoKRUUjJm5zkWThANYmMZk76hMSE6MMWv2
         lAuA==
X-Gm-Message-State: ANoB5plgKJPQ+r83q4woqkZJ5Uj9T+We7Fc5uXdnR5EcCG8NivI9Aa9y
        zaNA6FQRvZX5rdaV1Cb25wlcmCD96bRY0BDiZajwEwQDwM3YOYsbIOGvE2N7Mv36fUFb4mFSUZp
        mM/qDWvDomnwu2jnpK0gUzs2+
X-Received: by 2002:a05:600c:1d12:b0:3cf:8441:4a7c with SMTP id l18-20020a05600c1d1200b003cf84414a7cmr67229929wms.0.1670317225519;
        Tue, 06 Dec 2022 01:00:25 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7NgvpsWx9d1Dl44P/n2vQSchPjDT2NSctvIV6yaloKyLs2Kdv8I7uNNMdFNyXKC0sabj4l2Q==
X-Received: by 2002:a05:600c:1d12:b0:3cf:8441:4a7c with SMTP id l18-20020a05600c1d1200b003cf84414a7cmr67229906wms.0.1670317225063;
        Tue, 06 Dec 2022 01:00:25 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:4f00:41f1:185d:4f9f:d1c2? (p200300cbc7054f0041f1185d4f9fd1c2.dip0.t-ipconnect.de. [2003:cb:c705:4f00:41f1:185d:4f9f:d1c2])
        by smtp.gmail.com with ESMTPSA id m41-20020a05600c3b2900b003d1e3b1624dsm3781426wms.2.2022.12.06.01.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 01:00:24 -0800 (PST)
Message-ID: <24acd798-4e54-ca82-5ff9-e84a4795742e@redhat.com>
Date:   Tue, 6 Dec 2022 10:00:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: kernel BUG at include/linux/swapops.h:497!
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>
References: <0efeec33-8030-df1e-b055-2e0748fab4e0@redhat.com>
 <CAHbLzkpW6zg_bY5MZ4FFyw6TKC1MyBk7RsxB2LCHC7X9Ek439g@mail.gmail.com>
 <CAHbLzkp095z5vSLYAiD4Fy_W0=1zXk3uY1k0hYOA7Tq2y9=bZQ@mail.gmail.com>
 <082e64a7-7340-b1fb-b819-43bc4df0584f@redhat.com>
 <3b75765f-d4d7-fd0e-366d-59e18ab42766@redhat.com>
 <CAHbLzkqb+_3tb5t8eFOVXuEii25Uvdzfx_VpUHyO3pciySKpMQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAHbLzkqb+_3tb5t8eFOVXuEii25Uvdzfx_VpUHyO3pciySKpMQ@mail.gmail.com>
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

On 06.12.22 00:14, Yang Shi wrote:
> On Mon, Dec 5, 2022 at 7:14 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 02.12.22 13:36, David Hildenbrand wrote:
>>> On 01.12.22 19:14, Yang Shi wrote:
>>>> On Thu, Dec 1, 2022 at 9:48 AM Yang Shi <shy828301@gmail.com> wrote:
>>>>>
>>>>> On Thu, Dec 1, 2022 at 8:58 AM David Hildenbrand <david@redhat.com> wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> running COW tests (in mm-unstable) on x86-pae with 8GiB, I am able to trigger the
>>>>>> following BUG on latest upstream:
>>>>>>
>>>>>> root@debian:/mnt/scratch/linux/tools/testing/selftests/vm# ./cow
>>>>>> # [INFO] detected THP size: 2048 KiB
>>>>>> # [INFO] detected hugetlb size: 2048 KiB
>>>>>> # [INFO] huge zeropage is enabled
>>>>>> TAP version 13
>>>>>> 1..147
>>>>>> # [INFO] Anonymous memory tests in private mappings
>>>>>> # [RUN] Basic COW after fork() ... with base page
>>>>>> ok 1 No leak from parent into child
>>>>>> # [RUN] Basic COW after fork() ... with swapped out base page
>>>>>> ok 2 No leak from parent into child
>>>>>> # [RUN] Basic COW after fork() ... with THP
>>>>>> ok 3 No leak from parent into child
>>>>>> # [RUN] Basic COW after fork() ... with swapped-out THP
>>>>>> Segmentation fault
>>>>>>
>>>>>>
>>>>>> [  879.314600] kernel BUG at include/linux/swapops.h:497!
>>>>>> [  879.314615] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>>>>>> [  879.314624] CPU: 7 PID: 746 Comm: cow Tainted: G            E      6.1.0-rc7+ #5
>>>>>> [  879.314631] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-1.fc36 04/01/2014
>>>>>> [  879.314634] EIP: pagemap_pmd_range+0x644/0x650
>>>>>> [  879.314645] Code: 00 00 00 00 66 90 89 ce b9 00 f0 ff ff e9 ff fb ff ff 89 d8 31 db e8 1b c2 52 00 e9 23 fb ff ff e8 51 80 56 00 e9 b6 fe ff ff <0f> 0b bf 00 f0 ff ff e9 38 fa ff ff 3e 8d 74 26 00 55 89 e5 57 31
>>>>>> [  879.314651] EAX: ee2bd000 EBX: 00000002 ECX: ee2bd000 EDX: 00000000
>>>>>> [  879.314656] ESI: f54b9ed4 EDI: 0001f400 EBP: f54b9db4 ESP: f54b9d68
>>>>>> [  879.314660] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010246
>>>>>> [  879.314670] CR0: 80050033 CR2: b7a00000 CR3: 357452a0 CR4: 00350ef0
>>>>>> [  879.314675] Call Trace:
>>>>>> [  879.314681]  ? madvise_free_pte_range+0x720/0x720
>>>>>> [  879.314689]  ? smaps_pte_range+0x4b0/0x4b0
>>>>>> [  879.314694]  walk_pgd_range+0x325/0x720
>>>>>> [  879.314701]  ? mt_find+0x1d6/0x3a0
>>>>>> [  879.314710]  __walk_page_range+0x164/0x170
>>>>>> [  879.314716]  walk_page_range+0xf9/0x170
>>>>>> [  879.314720]  ? __kmem_cache_alloc_node+0x2a8/0x340
>>>>>> [  879.314729]  pagemap_read+0x124/0x280
>>>>>> [  879.314738]  ? default_llseek+0xf1/0x160
>>>>>> [  879.314747]  ? smaps_account+0x1d0/0x1d0
>>>>>> [  879.314754]  vfs_read+0x90/0x290
>>>>>> [  879.314760]  ? do_madvise.part.0+0x24b/0x390
>>>>>> [  879.314765]  ? debug_smp_processor_id+0x12/0x20
>>>>>> [  879.314773]  ksys_pread64+0x58/0x90
>>>>>> [  879.314778]  __ia32_sys_ia32_pread64+0x1b/0x20
>>>>>> [  879.314787]  __do_fast_syscall_32+0x4c/0xc0
>>>>>> [  879.314796]  do_fast_syscall_32+0x29/0x60
>>>>>> [  879.314803]  do_SYSENTER_32+0x15/0x20
>>>>>> [  879.314809]  entry_SYSENTER_32+0x98/0xf1
>>>>>> [  879.314815] EIP: 0xb7f36559
>>>>>> [  879.314820] Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
>>>>>> [  879.314825] EAX: ffffffda EBX: 00000003 ECX: bff00a50 EDX: 00000008
>>>>>> [  879.314829] ESI: 005bd000 EDI: 00000000 EBP: b7f1c000 ESP: bff00a00
>>>>>> [  879.314833] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000246
>>>>>> [  879.314840] Modules linked in: intel_rapl_msr(E) intel_rapl_common(E) intel_pmc_core(E) kvm_intel(E) kvm(E) irqbypass(E) aesni_intel(E) libaes(E) crypto_simd(E) cryptd(E) rfkill(E) snd_pcm(E) snd_timer(E) joydev(E) snd(E) soundcore(E) sg(E) evdev(E) pcspkr(E) serio_raw(E) qemu_fw_cfg(E) parport_pc(E) ppdev(E) lp(E) parport(E) fuse(E) configfs(E) ip_tables(E) x_tables(E) autofs4(E) ext4(E) crc32c_generic(E) crc16(E) mbcache(E) jbd2(E) sd_mod(E) t10_pi(E) crc64_rocksoft(E) crc64(E) crc_t10dif(E) sr_mod(E) crct10dif_generic(E) cdrom(E) crct10dif_common(E) bochs(E) drm_vram_helper(E) drm_ttm_helper(E) ttm(E) drm_kms_helper(E) ata_generic(E) ata_piix(E) crc32_pclmul(E) libata(E) crc32c_intel(E) drm(E) e1000(E) scsi_mod(E) psmouse(E) i2c_piix4(E) scsi_common(E) floppy(E) button(E)
>>>>>> [  879.314936] ---[ end trace 0000000000000000 ]---
>>>>>> [  879.314940] EIP: pagemap_pmd_range+0x644/0x650
>>>>>> [  879.314944] Code: 00 00 00 00 66 90 89 ce b9 00 f0 ff ff e9 ff fb ff ff 89 d8 31 db e8 1b c2 52 00 e9 23 fb ff ff e8 51 80 56 00 e9 b6 fe ff ff <0f> 0b bf 00 f0 ff ff e9 38 fa ff ff 3e 8d 74 26 00 55 89 e5 57 31
>>>>>> [  879.314949] EAX: ee2bd000 EBX: 00000002 ECX: ee2bd000 EDX: 00000000
>>>>>> [  879.314953] ESI: f54b9ed4 EDI: 0001f400 EBP: f54b9db4 ESP: f54b9d68
>>>>>> [  879.314957] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010246
>>>>>> [  879.314961] CR0: 80050033 CR2: b7a00000 CR3: 357452a0 CR4: 00350ef0
>>>>>>
>>>>>>
>>>>>> Reading /proc/self/pagemap in THP test case seems to trigger the
>>>>>>       BUG_ON(is_migration_entry(entry) && !PageLocked(p));
>>>>>> in pfn_swap_entry_to_page().
>>>>>>
>>>>>> I did not have time to cherry pick (slow machine) or look into details.
>>>>>> And I don't remember seeing that BUG 64bit yet during my tests.
>>>>>>
>>>>>> Having a migration entry in the swap testcase is kind-of weird. But maybe it's
>>>>>> related to THP splitting (which would, however, also be weird). I'd have expected
>>>>>> a swap entry ... hopefully our swap type doesn't get corrupted.
>>>>>
>>>>> I'm on a slow machine too... anyway some hints off the top of my head.
>>>>>
>>>>> First of all, I don't think we will see a real swap PMD entry since
>>>>> even though THP swap is supported the transhuge PMD is split by
>>>>> try_to_unmap() if I remember correctly. So we should just be able to
>>>>> see a regular PMD, a transhuge PMD, a migration PMD or a PROT_NONE PMD
>>>>> (if autonuma is on).
>>>
>>> Yes.
>>>
>>>>>
>>>>> Secondly, THP splitting doesn't convert transhuge PMD to migration PMD
>>>>> either, it just splits transhuge PMD then converts every single PTEs
>>>>> to migration PTEs.
>>>
>>> Right.
>>>
>>>>>
>>>>> Thirdly, before pfn_swap_entry_to_page() is called, it does check
>>>>> whether the swap PMD is migration PMD or not, if it is not a VM_BUG is
>>>>> triggered.
>>>>>
>>>>> So it seems like a migration PMD is fine. The problem seems like the
>>>>> page is not locked when doing migration IIUC.
>>>>
>>>> A quick look at the migration code, I don't see the page is unlocked
>>>> if I don't miss something. So it may be helpful to dump the page.
>>>
>>> It is highly unlikely that we have migration happening here, because
>>>
>>> 1) This triggers 100% on the first try
>>> 2) The machine is essentially idle with 7 GiB of free memory.
>>>
>>> I'll try digging a bit what exactly is happening here, dumping the PMD
>>> entry first.
>>
>> Turns out that 32bit x86 doesn't even support PMD migration. We're
>> stumbling over a PTE holding a migration entry and the underlying page
>> was indeed unlocked. Turns out we fail to remove the migration entries
>> we temporarily installed while splitting the THP. Splitting code
>> doesn't/cannot notice that and unlocks the now-split page(s).
> 
> Thanks for debugging this. IIUC the real call trace should be:
> 
> pagemap_pmd_range ->
>      pte_to_pagemap_entry ->
>          pfn_swap_entry_to_page <--- BUG
> 
> I thought it was due to the migration PMD entry in the first place.

Yeah, me too. Unfortunately, the system swallowed that part of the call 
trace.

-- 
Thanks,

David / dhildenb

