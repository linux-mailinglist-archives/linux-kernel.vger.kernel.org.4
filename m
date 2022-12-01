Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBF763F5CB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 17:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiLAQ7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 11:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiLAQ7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 11:59:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453EFA47EE
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 08:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669913903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6cdcNljLmynk6/GuhFsh128ucIpdnadU/qZA9dNVejM=;
        b=BJVlBY8tuu+EVx5t4+04+yBYAwHenDtujTKQP2v+94zZI3V1/6KGOmfuWjPAKttMLFKkmu
        qYYguugHkGYtDbXf/3FGU8fptxA5q2af63gMysq5orrKcC9aaFJK/UtsQPaskayjm+aDQk
        AQBgMoTGyyRYA/CuX4RFSslUqVy0Rp4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-562-9jQyrtBnMCywDveOiVdzrA-1; Thu, 01 Dec 2022 11:58:22 -0500
X-MC-Unique: 9jQyrtBnMCywDveOiVdzrA-1
Received: by mail-wm1-f70.google.com with SMTP id c126-20020a1c3584000000b003cfffcf7c1aso2812928wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 08:58:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:cc:to:organization:from
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6cdcNljLmynk6/GuhFsh128ucIpdnadU/qZA9dNVejM=;
        b=bi2JvtTQT4wuM9slvSeaGJBEc2k0n6TY24+uI3XYy4KT0WrK8xXRwqOK5MgXYajoL3
         IPRJ8vCPEBkmkTNCqiQoO6m5HVr7lj4uttI6XLRmcOPlQATX8QCWjYusBWBIWAyERLpc
         LpSfIzRe1bXqK2TfUiU7TjE8Xe72syuqwPt9KTXDNo2FEKUIa3N868eXWp/y7BXlyhad
         2TOcZsmJ3xDyFsmiJPimWXUFpimelbOtRhzZodYz275RugekCs98rNqYES/3ZN1JTzw/
         ufno46OLc1x5W9KMJGg1NlWVnlXZ5i5JYLwjjz4yoCwCYzfAXFfnQd3Ur9ld5WVJqn6e
         AFiQ==
X-Gm-Message-State: ANoB5pn0XkBYI30mBXkUbATeTwxFwSYyUO0BPHR5+e74qZtsZh+CP/0E
        eBPcmGbvi/JFS3NjgHggXb8iRKHlPnr+OlmquRHZrPuvWaIqeCACwZH+eyBV9vEJhEuNhGope9T
        i58+2uQlnseIcNsDelAvd4Eir
X-Received: by 2002:a05:600c:1d93:b0:3cf:d0ba:e5ff with SMTP id p19-20020a05600c1d9300b003cfd0bae5ffmr48602938wms.36.1669913901239;
        Thu, 01 Dec 2022 08:58:21 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5FVf/aTyvsBgQRQlWs7MsKCR7Q1t+PxvMXjVvDRqvy42X7zjQ+jy22Rr6DMuWx6yttlyMuUg==
X-Received: by 2002:a05:600c:1d93:b0:3cf:d0ba:e5ff with SMTP id p19-20020a05600c1d9300b003cfd0bae5ffmr48602925wms.36.1669913900904;
        Thu, 01 Dec 2022 08:58:20 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id m188-20020a1c26c5000000b003c83465ccbfsm8825938wmm.35.2022.12.01.08.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 08:58:20 -0800 (PST)
Message-ID: <0efeec33-8030-df1e-b055-2e0748fab4e0@redhat.com>
Date:   Thu, 1 Dec 2022 17:58:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Hugh Dickins <hughd@google.com>, Yang Shi <shy828301@gmail.com>,
        Peter Xu <peterx@redhat.com>
Subject: kernel BUG at include/linux/swapops.h:497!
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

running COW tests (in mm-unstable) on x86-pae with 8GiB, I am able to trigger the
following BUG on latest upstream:

root@debian:/mnt/scratch/linux/tools/testing/selftests/vm# ./cow
# [INFO] detected THP size: 2048 KiB
# [INFO] detected hugetlb size: 2048 KiB
# [INFO] huge zeropage is enabled
TAP version 13
1..147
# [INFO] Anonymous memory tests in private mappings
# [RUN] Basic COW after fork() ... with base page
ok 1 No leak from parent into child
# [RUN] Basic COW after fork() ... with swapped out base page
ok 2 No leak from parent into child
# [RUN] Basic COW after fork() ... with THP
ok 3 No leak from parent into child
# [RUN] Basic COW after fork() ... with swapped-out THP
Segmentation fault


[  879.314600] kernel BUG at include/linux/swapops.h:497!
[  879.314615] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[  879.314624] CPU: 7 PID: 746 Comm: cow Tainted: G            E      6.1.0-rc7+ #5
[  879.314631] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-1.fc36 04/01/2014
[  879.314634] EIP: pagemap_pmd_range+0x644/0x650
[  879.314645] Code: 00 00 00 00 66 90 89 ce b9 00 f0 ff ff e9 ff fb ff ff 89 d8 31 db e8 1b c2 52 00 e9 23 fb ff ff e8 51 80 56 00 e9 b6 fe ff ff <0f> 0b bf 00 f0 ff ff e9 38 fa ff ff 3e 8d 74 26 00 55 89 e5 57 31
[  879.314651] EAX: ee2bd000 EBX: 00000002 ECX: ee2bd000 EDX: 00000000
[  879.314656] ESI: f54b9ed4 EDI: 0001f400 EBP: f54b9db4 ESP: f54b9d68
[  879.314660] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010246
[  879.314670] CR0: 80050033 CR2: b7a00000 CR3: 357452a0 CR4: 00350ef0
[  879.314675] Call Trace:
[  879.314681]  ? madvise_free_pte_range+0x720/0x720
[  879.314689]  ? smaps_pte_range+0x4b0/0x4b0
[  879.314694]  walk_pgd_range+0x325/0x720
[  879.314701]  ? mt_find+0x1d6/0x3a0
[  879.314710]  __walk_page_range+0x164/0x170
[  879.314716]  walk_page_range+0xf9/0x170
[  879.314720]  ? __kmem_cache_alloc_node+0x2a8/0x340
[  879.314729]  pagemap_read+0x124/0x280
[  879.314738]  ? default_llseek+0xf1/0x160
[  879.314747]  ? smaps_account+0x1d0/0x1d0
[  879.314754]  vfs_read+0x90/0x290
[  879.314760]  ? do_madvise.part.0+0x24b/0x390
[  879.314765]  ? debug_smp_processor_id+0x12/0x20
[  879.314773]  ksys_pread64+0x58/0x90
[  879.314778]  __ia32_sys_ia32_pread64+0x1b/0x20
[  879.314787]  __do_fast_syscall_32+0x4c/0xc0
[  879.314796]  do_fast_syscall_32+0x29/0x60
[  879.314803]  do_SYSENTER_32+0x15/0x20
[  879.314809]  entry_SYSENTER_32+0x98/0xf1
[  879.314815] EIP: 0xb7f36559
[  879.314820] Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
[  879.314825] EAX: ffffffda EBX: 00000003 ECX: bff00a50 EDX: 00000008
[  879.314829] ESI: 005bd000 EDI: 00000000 EBP: b7f1c000 ESP: bff00a00
[  879.314833] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000246
[  879.314840] Modules linked in: intel_rapl_msr(E) intel_rapl_common(E) intel_pmc_core(E) kvm_intel(E) kvm(E) irqbypass(E) aesni_intel(E) libaes(E) crypto_simd(E) cryptd(E) rfkill(E) snd_pcm(E) snd_timer(E) joydev(E) snd(E) soundcore(E) sg(E) evdev(E) pcspkr(E) serio_raw(E) qemu_fw_cfg(E) parport_pc(E) ppdev(E) lp(E) parport(E) fuse(E) configfs(E) ip_tables(E) x_tables(E) autofs4(E) ext4(E) crc32c_generic(E) crc16(E) mbcache(E) jbd2(E) sd_mod(E) t10_pi(E) crc64_rocksoft(E) crc64(E) crc_t10dif(E) sr_mod(E) crct10dif_generic(E) cdrom(E) crct10dif_common(E) bochs(E) drm_vram_helper(E) drm_ttm_helper(E) ttm(E) drm_kms_helper(E) ata_generic(E) ata_piix(E) crc32_pclmul(E) libata(E) crc32c_intel(E) drm(E) e1000(E) scsi_mod(E) psmouse(E) i2c_piix4(E) scsi_common(E) floppy(E) button(E)
[  879.314936] ---[ end trace 0000000000000000 ]---
[  879.314940] EIP: pagemap_pmd_range+0x644/0x650
[  879.314944] Code: 00 00 00 00 66 90 89 ce b9 00 f0 ff ff e9 ff fb ff ff 89 d8 31 db e8 1b c2 52 00 e9 23 fb ff ff e8 51 80 56 00 e9 b6 fe ff ff <0f> 0b bf 00 f0 ff ff e9 38 fa ff ff 3e 8d 74 26 00 55 89 e5 57 31
[  879.314949] EAX: ee2bd000 EBX: 00000002 ECX: ee2bd000 EDX: 00000000
[  879.314953] ESI: f54b9ed4 EDI: 0001f400 EBP: f54b9db4 ESP: f54b9d68
[  879.314957] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010246
[  879.314961] CR0: 80050033 CR2: b7a00000 CR3: 357452a0 CR4: 00350ef0


Reading /proc/self/pagemap in THP test case seems to trigger the
   BUG_ON(is_migration_entry(entry) && !PageLocked(p));
in pfn_swap_entry_to_page().

I did not have time to cherry pick (slow machine) or look into details.
And I don't remember seeing that BUG 64bit yet during my tests.

Having a migration entry in the swap testcase is kind-of weird. But maybe it's
related to THP splitting (which would, however, also be weird). I'd have expected
a swap entry ... hopefully our swap type doesn't get corrupted.


Something slightly realted was reported for -next a couple of months ago:

https://lore.kernel.org/all/11765.1657004484@turing-police/


-- 
Thanks,

David / dhildenb

