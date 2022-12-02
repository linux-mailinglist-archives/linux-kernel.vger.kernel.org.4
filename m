Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAAF6406EE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbiLBMh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbiLBMhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:37:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AFED4247
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 04:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669984617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YW3FZUEzghNp222x8h/61zufi5SpjBb4mDT+mVod0Jw=;
        b=OguHZD+m5dzCHSY7VY94ecSO09pFBHlM4LuTm/ddoMZkqF7M+BXRjQRvAHiIJbMCU2pOH5
        nTPjgi6UKLyCnvs6FeT0Wg8mTy18ArMVTqpYbgOj5pWnYAlF/6ZNz6+eeh6wDiXhc3hJNO
        H3ExMBMbkn5+5ZgJKvvlMwcdCtEok4E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-262-vri6-5iPMnm2VjCeVHMtvA-1; Fri, 02 Dec 2022 07:36:56 -0500
X-MC-Unique: vri6-5iPMnm2VjCeVHMtvA-1
Received: by mail-wr1-f69.google.com with SMTP id h10-20020adfaa8a000000b0024208cf285eso1054813wrc.22
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 04:36:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YW3FZUEzghNp222x8h/61zufi5SpjBb4mDT+mVod0Jw=;
        b=4TeF8lWCSlGQCZ8RjZelaHtsrszbGbcfgSRu9/PCwafbSsi17BYiNtfuo9tjIM5SlT
         l94Sv1xnu+cQ1BQMt0ZdJyQ6lXu1Ef7ZjdMtI2GQx5nHONONMMT4KfvXsy0vAXCQ9lAM
         y/EXObt0Luob8YAGqikQ3zc1i/gCCi+AwjvDAAY9Ob4gdvrNuogv9sN6DiEtQPbMHudC
         zKRW5LlgN8hIs6CMmJZOvpPm92ImzM0rb0q9ScWVC6YbHANNx69JPLGWNYTiE9t6vdPw
         MU8mugn+NMbShAVQDCz2D2en7KDXlIIHQqEO/yR6ZiKPEBuKEA1IXqrCwelINAo1ib+l
         tt7g==
X-Gm-Message-State: ANoB5pnY//4fg7XLOYzDPPxdqg7ge2zDCd1sBOGyQGpUNM5/NDHQnBaZ
        J6qb0nsGZghJK96X+4qwplcES2NiJj3py11mJDWMd7XyTtL6j0K+mors5DDyTlfPwVINzOH5Xtp
        zYBAfdPYC/naFfnmnwcODwU/m
X-Received: by 2002:a5d:4dd2:0:b0:242:451c:1c35 with SMTP id f18-20020a5d4dd2000000b00242451c1c35mr1757262wru.463.1669984615054;
        Fri, 02 Dec 2022 04:36:55 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5It4H9tBI7OhEPz76VabsXu2ze8KLkcq95zoshLp45N5PiwYSJFUPhME8yQGxTAs4ZpJHETQ==
X-Received: by 2002:a5d:4dd2:0:b0:242:451c:1c35 with SMTP id f18-20020a5d4dd2000000b00242451c1c35mr1757247wru.463.1669984614656;
        Fri, 02 Dec 2022 04:36:54 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:7a00:852e:72cd:ed76:d72f? (p200300cbc7037a00852e72cded76d72f.dip0.t-ipconnect.de. [2003:cb:c703:7a00:852e:72cd:ed76:d72f])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c315100b003cfd64b6be1sm16699659wmo.27.2022.12.02.04.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 04:36:54 -0800 (PST)
Message-ID: <082e64a7-7340-b1fb-b819-43bc4df0584f@redhat.com>
Date:   Fri, 2 Dec 2022 13:36:53 +0100
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAHbLzkp095z5vSLYAiD4Fy_W0=1zXk3uY1k0hYOA7Tq2y9=bZQ@mail.gmail.com>
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

On 01.12.22 19:14, Yang Shi wrote:
> On Thu, Dec 1, 2022 at 9:48 AM Yang Shi <shy828301@gmail.com> wrote:
>>
>> On Thu, Dec 1, 2022 at 8:58 AM David Hildenbrand <david@redhat.com> wrote:
>>>
>>> Hi,
>>>
>>> running COW tests (in mm-unstable) on x86-pae with 8GiB, I am able to trigger the
>>> following BUG on latest upstream:
>>>
>>> root@debian:/mnt/scratch/linux/tools/testing/selftests/vm# ./cow
>>> # [INFO] detected THP size: 2048 KiB
>>> # [INFO] detected hugetlb size: 2048 KiB
>>> # [INFO] huge zeropage is enabled
>>> TAP version 13
>>> 1..147
>>> # [INFO] Anonymous memory tests in private mappings
>>> # [RUN] Basic COW after fork() ... with base page
>>> ok 1 No leak from parent into child
>>> # [RUN] Basic COW after fork() ... with swapped out base page
>>> ok 2 No leak from parent into child
>>> # [RUN] Basic COW after fork() ... with THP
>>> ok 3 No leak from parent into child
>>> # [RUN] Basic COW after fork() ... with swapped-out THP
>>> Segmentation fault
>>>
>>>
>>> [  879.314600] kernel BUG at include/linux/swapops.h:497!
>>> [  879.314615] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>>> [  879.314624] CPU: 7 PID: 746 Comm: cow Tainted: G            E      6.1.0-rc7+ #5
>>> [  879.314631] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-1.fc36 04/01/2014
>>> [  879.314634] EIP: pagemap_pmd_range+0x644/0x650
>>> [  879.314645] Code: 00 00 00 00 66 90 89 ce b9 00 f0 ff ff e9 ff fb ff ff 89 d8 31 db e8 1b c2 52 00 e9 23 fb ff ff e8 51 80 56 00 e9 b6 fe ff ff <0f> 0b bf 00 f0 ff ff e9 38 fa ff ff 3e 8d 74 26 00 55 89 e5 57 31
>>> [  879.314651] EAX: ee2bd000 EBX: 00000002 ECX: ee2bd000 EDX: 00000000
>>> [  879.314656] ESI: f54b9ed4 EDI: 0001f400 EBP: f54b9db4 ESP: f54b9d68
>>> [  879.314660] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010246
>>> [  879.314670] CR0: 80050033 CR2: b7a00000 CR3: 357452a0 CR4: 00350ef0
>>> [  879.314675] Call Trace:
>>> [  879.314681]  ? madvise_free_pte_range+0x720/0x720
>>> [  879.314689]  ? smaps_pte_range+0x4b0/0x4b0
>>> [  879.314694]  walk_pgd_range+0x325/0x720
>>> [  879.314701]  ? mt_find+0x1d6/0x3a0
>>> [  879.314710]  __walk_page_range+0x164/0x170
>>> [  879.314716]  walk_page_range+0xf9/0x170
>>> [  879.314720]  ? __kmem_cache_alloc_node+0x2a8/0x340
>>> [  879.314729]  pagemap_read+0x124/0x280
>>> [  879.314738]  ? default_llseek+0xf1/0x160
>>> [  879.314747]  ? smaps_account+0x1d0/0x1d0
>>> [  879.314754]  vfs_read+0x90/0x290
>>> [  879.314760]  ? do_madvise.part.0+0x24b/0x390
>>> [  879.314765]  ? debug_smp_processor_id+0x12/0x20
>>> [  879.314773]  ksys_pread64+0x58/0x90
>>> [  879.314778]  __ia32_sys_ia32_pread64+0x1b/0x20
>>> [  879.314787]  __do_fast_syscall_32+0x4c/0xc0
>>> [  879.314796]  do_fast_syscall_32+0x29/0x60
>>> [  879.314803]  do_SYSENTER_32+0x15/0x20
>>> [  879.314809]  entry_SYSENTER_32+0x98/0xf1
>>> [  879.314815] EIP: 0xb7f36559
>>> [  879.314820] Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
>>> [  879.314825] EAX: ffffffda EBX: 00000003 ECX: bff00a50 EDX: 00000008
>>> [  879.314829] ESI: 005bd000 EDI: 00000000 EBP: b7f1c000 ESP: bff00a00
>>> [  879.314833] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000246
>>> [  879.314840] Modules linked in: intel_rapl_msr(E) intel_rapl_common(E) intel_pmc_core(E) kvm_intel(E) kvm(E) irqbypass(E) aesni_intel(E) libaes(E) crypto_simd(E) cryptd(E) rfkill(E) snd_pcm(E) snd_timer(E) joydev(E) snd(E) soundcore(E) sg(E) evdev(E) pcspkr(E) serio_raw(E) qemu_fw_cfg(E) parport_pc(E) ppdev(E) lp(E) parport(E) fuse(E) configfs(E) ip_tables(E) x_tables(E) autofs4(E) ext4(E) crc32c_generic(E) crc16(E) mbcache(E) jbd2(E) sd_mod(E) t10_pi(E) crc64_rocksoft(E) crc64(E) crc_t10dif(E) sr_mod(E) crct10dif_generic(E) cdrom(E) crct10dif_common(E) bochs(E) drm_vram_helper(E) drm_ttm_helper(E) ttm(E) drm_kms_helper(E) ata_generic(E) ata_piix(E) crc32_pclmul(E) libata(E) crc32c_intel(E) drm(E) e1000(E) scsi_mod(E) psmouse(E) i2c_piix4(E) scsi_common(E) floppy(E) button(E)
>>> [  879.314936] ---[ end trace 0000000000000000 ]---
>>> [  879.314940] EIP: pagemap_pmd_range+0x644/0x650
>>> [  879.314944] Code: 00 00 00 00 66 90 89 ce b9 00 f0 ff ff e9 ff fb ff ff 89 d8 31 db e8 1b c2 52 00 e9 23 fb ff ff e8 51 80 56 00 e9 b6 fe ff ff <0f> 0b bf 00 f0 ff ff e9 38 fa ff ff 3e 8d 74 26 00 55 89 e5 57 31
>>> [  879.314949] EAX: ee2bd000 EBX: 00000002 ECX: ee2bd000 EDX: 00000000
>>> [  879.314953] ESI: f54b9ed4 EDI: 0001f400 EBP: f54b9db4 ESP: f54b9d68
>>> [  879.314957] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010246
>>> [  879.314961] CR0: 80050033 CR2: b7a00000 CR3: 357452a0 CR4: 00350ef0
>>>
>>>
>>> Reading /proc/self/pagemap in THP test case seems to trigger the
>>>     BUG_ON(is_migration_entry(entry) && !PageLocked(p));
>>> in pfn_swap_entry_to_page().
>>>
>>> I did not have time to cherry pick (slow machine) or look into details.
>>> And I don't remember seeing that BUG 64bit yet during my tests.
>>>
>>> Having a migration entry in the swap testcase is kind-of weird. But maybe it's
>>> related to THP splitting (which would, however, also be weird). I'd have expected
>>> a swap entry ... hopefully our swap type doesn't get corrupted.
>>
>> I'm on a slow machine too... anyway some hints off the top of my head.
>>
>> First of all, I don't think we will see a real swap PMD entry since
>> even though THP swap is supported the transhuge PMD is split by
>> try_to_unmap() if I remember correctly. So we should just be able to
>> see a regular PMD, a transhuge PMD, a migration PMD or a PROT_NONE PMD
>> (if autonuma is on).

Yes.

>>
>> Secondly, THP splitting doesn't convert transhuge PMD to migration PMD
>> either, it just splits transhuge PMD then converts every single PTEs
>> to migration PTEs.

Right.

>>
>> Thirdly, before pfn_swap_entry_to_page() is called, it does check
>> whether the swap PMD is migration PMD or not, if it is not a VM_BUG is
>> triggered.
>>
>> So it seems like a migration PMD is fine. The problem seems like the
>> page is not locked when doing migration IIUC.
> 
> A quick look at the migration code, I don't see the page is unlocked
> if I don't miss something. So it may be helpful to dump the page.

It is highly unlikely that we have migration happening here, because

1) This triggers 100% on the first try
2) The machine is essentially idle with 7 GiB of free memory.

I'll try digging a bit what exactly is happening here, dumping the PMD 
entry first.


Thanks!

-- 
Thanks,

David / dhildenb

