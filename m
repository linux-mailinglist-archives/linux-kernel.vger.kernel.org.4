Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5206B6C05
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 23:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjCLWmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 18:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjCLWmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 18:42:00 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DFA2FCD0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 15:41:58 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id p23-20020a05600c1d9700b003ead4835046so6747200wms.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 15:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678660916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3DV3WErX81w+oA4u46CgOde85YlNmEd8A6YS/1NMMiY=;
        b=DS4J85DaLrNKPyqVJvGc/VQSd4fLq4wFqYnY+fUanmZ2ezx8KgUKzL8DeXtfNvVPlZ
         +lSDEnTMFWCqwiFNWUBm98o5f6Eol1aeSEEgcEosKrZutFburwWxXfVK490hfKPejTn2
         PRE8EtNAZwnMlKrnlPhhXkvc7zWfNsoPN/62NMxFsx3rMd3KXzaEg4z5b0VlPB3Y5MaU
         Nrg7mntzofcM90s0PY9MzP07RZuZpqwJ4yG7qmCHX3PuWx0h61Nv2am6ssS56q56TaAD
         mFMDOKK7EjYE4d/L5YMBg11T+Q47G0BAdw7LmMmdFNIKwb4CFTj2LLwdd0HwOzv8gHaD
         THfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678660916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3DV3WErX81w+oA4u46CgOde85YlNmEd8A6YS/1NMMiY=;
        b=CliNh+X30JHQhXDqf9IKBrDdUC9f0NXhKHm0wp0RxmCPQkv2EIOSOav0a+77XYviNM
         r/pVEcjty3AHiRQkkLb8BFY1KXR9RIK0p8Z/rbEKI2CGSLSBUt8jwuRBlLaaXL8it+9E
         FG1tNbqNxTuyC7j3mc2s/si0RCb5pmYsDgHiYq0GXSqGBBGPwKHXD5NajDur/v+D2+Eu
         6pEPgwJjhX+s8X2uBQQ+8oaHHXNf600N6QL2A7bCih4Mtw2UOmfUtmoyN0ZUImJybido
         7pg6zV56NRHBodXSkKFDBz5Wu6CjXg4NuA/Ix25e4AcLJvFf5c+98B5SOSok1K48lwdq
         fj/g==
X-Gm-Message-State: AO0yUKU3gwKkCFyC02eQZMRJqhwTJun9r2/4M3Efc+LpjFfiX+J0439e
        RJKgYrpM6JnJv9wj35tzipSqw6Uew2GYGQ==
X-Google-Smtp-Source: AK7set+Y+FI9zNZpA+pWt8rs6vDigtGJMebgVH5yAwDKB0ArlOgT98n98M8O9iiYbJ4+rPg8/DEkLA==
X-Received: by 2002:a1c:6a07:0:b0:3e2:1e01:803a with SMTP id f7-20020a1c6a07000000b003e21e01803amr8862204wmc.9.1678660915673;
        Sun, 12 Mar 2023 15:41:55 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:5d37:537d:cd23:cd6e:ae14:44fe])
        by smtp.gmail.com with ESMTPSA id bi26-20020a05600c3d9a00b003e01493b136sm7127295wmb.43.2023.03.12.15.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 15:41:55 -0700 (PDT)
From:   Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     jgg@ziepe.ca, Liam.Howlett@Oracle.com, jhubbard@nvidia.com,
        david@redhat.com, willy@infradead.org, akpm@linux-foundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Subject: [RFC PATCH v1 0/1] possibile regression in the mm_types
Date:   Sun, 12 Mar 2023 23:41:50 +0100
Message-Id: <20230312224150.425382-1-vincenzopalazzodev@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While I was testing the last rc1 version on my build machine
I noticed that I was not able to build my nvidia driver and 
also, the vboxhost/7.0.6_OSE driver while I was building [1].

So I noticed that this change was introduced in the 6.3-rc1 
and proposed by [2]. However, I think I can miss important 
around this change,  there may be some motivation to 
have the `const` constraint here, 
and this change needs to be done in the out-of-tree driver 
(this is the reason for the RFC) and not on the kernel itself.

Therefore with the current path I was able to build and run 
all the drivers mentioned, and before sending the email 
I tested also with linux-next if the bug persists, and it does.

Except for the nvidia driver that has this double-free exception
but I guess it is unrelated

[1] https://github.com/linux-kdevops/linux-kdevops
[2] https://lore.kernel.org/all/20230126193752.297968-3-surenb@google.com/T/#u

----
[Mar11 18:59] ==================================================================
[  +0.000008] BUG: KASAN: slab-use-after-free in nv_match_dev_state+0x74/0xa0 [nvidia]
[  +0.001054] Read of size 8 at addr ffff88810dae4b38 by task cinnamon/791

[  +0.000007] CPU: 6 PID: 791 Comm: cinnamon Tainted: P           OE      6.3.0-rc1-vincenzopalazzo-ge208f19e7da1-dirty #2 d6f374db04afea9926e4fb922b3f0658d8f082d0
[  +0.000005] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./H97M Pro4, BIOS P1.20 07/29/2014
[  +0.000003] Call Trace:
[  +0.000003]  <TASK>
[  +0.000002]  dump_stack_lvl+0x47/0x60
[  +0.000007]  print_report+0xcf/0x660
[  +0.000006]  ? __virt_addr_valid+0xf8/0x180
[  +0.000006]  ? nv_match_dev_state+0x74/0xa0 [nvidia a203532645cde567719e13f62d588b43ee43cdbf]
[  +0.001048]  kasan_report+0xc9/0x100
[  +0.000006]  ? nv_match_dev_state+0x74/0xa0 [nvidia a203532645cde567719e13f62d588b43ee43cdbf]
[  +0.001045]  nv_match_dev_state+0x74/0xa0 [nvidia a203532645cde567719e13f62d588b43ee43cdbf]
[  +0.001036]  ? __pfx_nv_match_dev_state+0x10/0x10 [nvidia a203532645cde567719e13f62d588b43ee43cdbf]
[  +0.001043]  iterate_fd+0x89/0xd0
[  +0.000007]  nv_is_gpu_accessible+0x48/0x60 [nvidia a203532645cde567719e13f62d588b43ee43cdbf]
[  +0.001046]  _nv017347rm+0x24b/0x490 [nvidia a203532645cde567719e13f62d588b43ee43cdbf]
[  +0.001173]  _nv002227rm+0x4e/0x70 [nvidia a203532645cde567719e13f62d588b43ee43cdbf]
[  +0.001075]  _nv003800rm+0x7a/0xd0 [nvidia a203532645cde567719e13f62d588b43ee43cdbf]
[  +0.001076]  _nv003495rm+0x4c/0x70 [nvidia a203532645cde567719e13f62d588b43ee43cdbf]
[  +0.001096]  _nv039310rm+0x8c/0x160 [nvidia a203532645cde567719e13f62d588b43ee43cdbf]
[  +0.001059]  _nv009851rm+0x259/0x520 [nvidia a203532645cde567719e13f62d588b43ee43cdbf]
[  +0.001088]  _nv041137rm+0x40a/0x830 [nvidia a203532645cde567719e13f62d588b43ee43cdbf]
[  +0.001056]  _nv041135rm+0x29d/0x2b0 [nvidia a203532645cde567719e13f62d588b43ee43cdbf]
[  +0.001091]  _nv039423rm+0x15a/0x2e0 [nvidia a203532645cde567719e13f62d588b43ee43cdbf]
[  +0.001051]  _nv039424rm+0x5b/0x90 [nvidia a203532645cde567719e13f62d588b43ee43cdbf]
[  +0.001066]  ? _nv039424rm+0x31/0x90 [nvidia a203532645cde567719e13f62d588b43ee43cdbf]
[  +0.001051]  ? cap_capable+0xaf/0xe0
[  +0.000006]  _nv000559rm+0x5a/0x70 [nvidia a203532645cde567719e13f62d588b43ee43cdbf]
[  +0.001071]  ? _nv000559rm+0x33/0x70 [nvidia a203532645cde567719e13f62d588b43ee43cdbf]
[  +0.001076]  _nv000694rm+0x94a/0xc80 [nvidia a203532645cde567719e13f62d588b43ee43cdbf]
[  +0.001056]  rm_ioctl+0x54/0xb0 [nvidia a203532645cde567719e13f62d588b43ee43cdbf]
[  +0.001051]  nvidia_ioctl+0xaa3/0xd90 [nvidia a203532645cde567719e13f62d588b43ee43cdbf]
[  +0.001027]  ? __pfx_nvidia_ioctl+0x10/0x10 [nvidia a203532645cde567719e13f62d588b43ee43cdbf]
[  +0.001023]  ? __rcu_read_unlock+0x4c/0x70
[  +0.000005]  nvidia_frontend_unlocked_ioctl+0x82/0xb0 [nvidia a203532645cde567719e13f62d588b43ee43cdbf]
[  +0.001042]  __x64_sys_ioctl+0xc3/0x100
[  +0.000005]  do_syscall_64+0x5f/0x90
[  +0.000006]  ? __x64_sys_ioctl+0xdb/0x100
[  +0.000004]  ? syscall_exit_to_user_mode+0x1b/0x40
[  +0.000005]  ? do_syscall_64+0x6b/0x90
[  +0.000004]  ? syscall_exit_to_user_mode+0x1b/0x40
[  +0.000004]  ? do_syscall_64+0x6b/0x90
[  +0.000004]  ? syscall_exit_to_user_mode+0x1b/0x40
[  +0.000004]  ? syscall_exit_to_user_mode+0x1b/0x40
[  +0.000004]  ? do_syscall_64+0x6b/0x90
[  +0.000004]  ? do_syscall_64+0x6b/0x90
[  +0.000003]  ? exc_page_fault+0x5e/0xd0
[  +0.000005]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  +0.000006] RIP: 0033:0x7fb3d2b9453f
[  +0.000004] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[  +0.000003] RSP: 002b:00007ffd30cd2f60 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  +0.000005] RAX: ffffffffffffffda RBX: 0000000000000028 RCX: 00007fb3d2b9453f
[  +0.000003] RDX: 00007ffd30cd30c0 RSI: 00000000c028462b RDI: 000000000000000c
[  +0.000003] RBP: 00007ffd30cd30c0 R08: 00007ffd30cd30c0 R09: 00007ffd30cd30e4
[  +0.000003] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000000c
[  +0.000002] R13: 00000000c028462b R14: 000000000000002b R15: 00007ffd30cd2fc0
[  +0.000005]  </TASK>

[  +0.000004] Allocated by task 791:
[  +0.000002]  kasan_save_stack+0x33/0x60
[  +0.000005]  kasan_set_track+0x25/0x30
[  +0.000004]  __kasan_kmalloc+0xaa/0xb0
[  +0.000004]  __kmalloc+0x5e/0xd0
[  +0.000003]  os_alloc_mem+0x11a/0x140 [nvidia]
[  +0.001050]  _nv012306rm+0x23/0x30 [nvidia]
[  +0.001089]  _nv012307rm+0x27/0xe0 [nvidia]
[  +0.001086]  _nv013141rm+0x1b/0x90 [nvidia]
[  +0.001090]  _nv043333rm+0x65/0xb0 [nvidia]
[  +0.001100]  _nv039461rm+0xf9/0x1d0 [nvidia]
[  +0.001070]  _nv041190rm+0x45/0xd0 [nvidia]
[  +0.001064]  _nv041135rm+0x142/0x2b0 [nvidia]
[  +0.001093]  _nv039423rm+0x15a/0x2e0 [nvidia]
[  +0.001062]  _nv039424rm+0x5b/0x90 [nvidia]
[  +0.001056]  _nv000560rm+0x59/0x70 [nvidia]
[  +0.001065]  _nv000694rm+0x4ae/0xc80 [nvidia]
[  +0.001051]  rm_ioctl+0x54/0xb0 [nvidia]
[  +0.001050]  nvidia_ioctl+0xaa3/0xd90 [nvidia]
[  +0.001026]  nvidia_frontend_unlocked_ioctl+0x82/0xb0 [nvidia]
[  +0.001028]  __x64_sys_ioctl+0xc3/0x100
[  +0.000003]  do_syscall_64+0x5f/0x90
[  +0.000003]  entry_SYSCALL_64_after_hwframe+0x72/0xdc

[  +0.000006] Freed by task 791:
[  +0.000002]  kasan_save_stack+0x33/0x60
[  +0.000004]  kasan_set_track+0x25/0x30
[  +0.000004]  kasan_save_free_info+0x2e/0x50
[  +0.000004]  ____kasan_slab_free+0x169/0x1c0
[  +0.000004]  slab_free_freelist_hook+0xcd/0x190
[  +0.000003]  __kmem_cache_free+0x1a6/0x2f0
[  +0.000004]  _nv013138rm+0xbe/0x100 [nvidia]
[  +0.001087]  _nv039463rm+0xa7/0xe0 [nvidia]
[  +0.001055]  _nv041189rm+0x45/0x60 [nvidia]
[  +0.001049]  _nv041135rm+0xbb/0x2b0 [nvidia]
[  +0.001086]  _nv039423rm+0x15a/0x2e0 [nvidia]
[  +0.001062]  _nv039424rm+0x5b/0x90 [nvidia]
[  +0.001056]  _nv000560rm+0x59/0x70 [nvidia]
[  +0.001065]  _nv000694rm+0x4ae/0xc80 [nvidia]
[  +0.001060]  rm_ioctl+0x54/0xb0 [nvidia]
[  +0.001050]  nvidia_ioctl+0xaa3/0xd90 [nvidia]
[  +0.001020]  nvidia_frontend_unlocked_ioctl+0x82/0xb0 [nvidia]
[  +0.001038]  __x64_sys_ioctl+0xc3/0x100
[  +0.000004]  do_syscall_64+0x5f/0x90
[  +0.000003]  entry_SYSCALL_64_after_hwframe+0x72/0xdc

[  +0.000005] Last potentially related work creation:
[  +0.000002]  kasan_save_stack+0x33/0x60
[  +0.000004]  __kasan_record_aux_stack+0xb6/0xd0
[  +0.000004]  kvfree_call_rcu+0x7c/0x530
[  +0.000003]  kernfs_unlink_open_file+0x1ac/0x1c0
[  +0.000005]  kernfs_fop_release+0x6f/0x160
[  +0.000003]  __fput+0x10c/0x420
[  +0.000004]  task_work_run+0xfc/0x170
[  +0.000006]  exit_to_user_mode_prepare+0x1a7/0x1d0
[  +0.000006]  syscall_exit_to_user_mode+0x1b/0x40
[  +0.000003]  do_syscall_64+0x6b/0x90
[  +0.000003]  entry_SYSCALL_64_after_hwframe+0x72/0xdc

[  +0.000005] The buggy address belongs to the object at ffff88810dae4b00
               which belongs to the cache kmalloc-96 of size 96
[  +0.000004] The buggy address is located 56 bytes inside of
               freed 96-byte region [ffff88810dae4b00, ffff88810dae4b60)

[  +0.000005] The buggy address belongs to the physical page:
[  +0.000002] page:00000000b6b0fdcc refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10dae4
[  +0.000004] anon flags: 0x2ffff0000000200(slab|node=0|zone=2|lastcpupid=0xffff)
[  +0.000006] raw: 02ffff0000000200 ffff888100042780 0000000000000000 dead000000000001
[  +0.000003] raw: 0000000000000000 0000000080200020 00000001ffffffff 0000000000000000
[  +0.000002] page dumped because: kasan: bad access detected

[  +0.000003] Memory state around the buggy address:
[  +0.000002]  ffff88810dae4a00: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
[  +0.000003]  ffff88810dae4a80: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
[  +0.000003] >ffff88810dae4b00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
[  +0.000002]                                         ^
[  +0.000003]  ffff88810dae4b80: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
[  +0.000003]  ffff88810dae4c00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
[  +0.000002] ==================================================================

Vincenzo Palazzo (1):
  linux: mm_types: allow to modified the vm_flags in vm_area_struct

 include/linux/mm_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.39.2

