Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FA56F79ED
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 02:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjEEAJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 20:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEEAJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 20:09:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE4F4215
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 17:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683245306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=HJY/+1JnMiLlEkq2AgTedma+exuZfk/CXW/dTd1p/CU=;
        b=fabERFKNQo15sDLB9hqAKUPjW6MJN4f+sf8itqa98O9A7CfG3LR/eS85LCoMqihIGD0Hv6
        8LgXG+NF/yUDWFS6G5xPle/0QGcehImjFVAO2k39qFJIrVUoB1rAfuo3S172KRYlcMLlHU
        RnnciWeNIleHNA0v8MX7U6illQARAlk=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-z-QjHbJ-OOSqVL7fnf05Lg-1; Thu, 04 May 2023 20:08:25 -0400
X-MC-Unique: z-QjHbJ-OOSqVL7fnf05Lg-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-64115ef7234so10922194b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 17:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683245304; x=1685837304;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HJY/+1JnMiLlEkq2AgTedma+exuZfk/CXW/dTd1p/CU=;
        b=dJGEQWQsDTJYnSUGB5hrcoa+gTXi1buVHGnj3Tt0zaprTSHMoFEcm6RXNUGcoM37ak
         Bw2uUG0f2UsO4VXyseDhHzA+AWb44KG9L1FH6+hbjH4l+FtgjddUx+CLlL6/djx4iipv
         C3n/I11myRq5j9UBsAkfjm4cpTsv9wfgGuf2D3Wio6AfMF5CfUdCWyVkCwcjzi+7ESI/
         sAt8Avk6YxUSaoCIi6wqoTNuFBqGsvpWhcosW9OEaCyWOeklP2B2GBihX/fCyrINJtrE
         0QSxOIQKFwDme0QkzjmKDSBsKOgPBUFvEKUiMNFtAx6jYvinSL9qfrEAyBC293iL+fQz
         WQ4g==
X-Gm-Message-State: AC+VfDylngVdqm+TJBwJhTWhPP3AHITxkNgiIA1DmyIycVJEGjC/FKLg
        SdZ229xG8q2e5OaKC+7W7gTroDAX7WMcDEBGu/0hwMYIl2BUockVm4bhaVjiE8MgLcfXPUHrRjd
        1I07vxibxjHMjh2TrjlcBf2lnJC9u+gMTAjhLRoH0
X-Received: by 2002:a17:903:187:b0:1ab:11d5:4f07 with SMTP id z7-20020a170903018700b001ab11d54f07mr5943175plg.18.1683245304104;
        Thu, 04 May 2023 17:08:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5pia5jzktcY9DJ3FiTjR62zcaa5OFwm3fL4RAbURwTghhmq5tClspk9pc5xmrXA3xEsNZQEXdO68OtnEdgOkw=
X-Received: by 2002:a17:903:187:b0:1ab:11d5:4f07 with SMTP id
 z7-20020a170903018700b001ab11d54f07mr5943146plg.18.1683245303744; Thu, 04 May
 2023 17:08:23 -0700 (PDT)
MIME-Version: 1.0
From:   Guangwu Zhang <guazhang@redhat.com>
Date:   Fri, 5 May 2023 08:09:28 +0800
Message-ID: <CAGS2=Yrv_pXweGN7hsX1A0kc7a9WjYUg2G+swD5eiK4sqURsXg@mail.gmail.com>
Subject: [bug report] BUG libfc_em (Not tainted): Objects remaining in
 libfc_em on __kmem_cache_shutdown()
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Meneghini <jmeneghi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I found kernel panic issue with latest linux-block/for-next.
repo : https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
Merge branch 'for-6.4/block' into for-next

Reproducer:
1. found qedf HBA host
2. create npiv port
3. remove some modules
modprobe -r qedf
modprobe -r libfcoe
modprobe -r libfc
4. remove npiv port

=============================================================================
[  218.400452] BUG libfc_em (Not tainted): Objects remaining in
libfc_em on __kmem_cache_shutdown()
[  218.410255] -----------------------------------------------------------------------------
[  218.410255]
[  218.421028] Slab 0xffffda6cc4444f00 objects=36 used=4
fp=0xffff92381113ea40
flags=0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
[  218.435392] CPU: 22 PID: 3794 Comm: modprobe Kdump: loaded Not
tainted 6.3.0+ #1
[  218.443645] Hardware name: Dell Inc. PowerEdge R730/0H21J3, BIOS
2.16.0 07/20/2022
[  218.452091] Call Trace:
[  218.454817]  <TASK>
[  218.457154]  dump_stack_lvl+0x33/0x50
[  218.461240]  slab_err+0xc3/0x130
[  218.464842]  ? pick_next_task+0x57/0x9b0
[  218.469219]  ? check_preempt_curr+0x5d/0x70
[  218.473883]  ? ttwu_do_activate+0x6b/0x220
[  218.478453]  ? __switch_to_asm+0x3a/0x80
[  218.482831]  __kmem_cache_shutdown+0x159/0x310
[  218.487789]  kmem_cache_destroy+0x51/0x160
[  218.492361]  libfc_exit+0xa/0x280 [libfc]
[  218.496848]  __do_sys_delete_module.constprop.0+0x17a/0x2f0
[  218.503067]  ? syscall_trace_enter.constprop.0+0x126/0x1a0
[  218.509188]  do_syscall_64+0x5c/0x90
[  218.513177]  ? exit_to_user_mode_prepare+0xc4/0xd0
[  218.518522]  ? syscall_exit_to_user_mode+0x12/0x30
[  218.523866]  ? do_syscall_64+0x69/0x90
[  218.528046]  ? exc_page_fault+0x65/0x150
[  218.532420]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  218.538058] RIP: 0033:0x7f9fafa3f5ab
[  218.542046] Code: 73 01 c3 48 8b 0d 75 a8 1b 00 f7 d8 64 89 01 48
83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 45 a8 1b 00 f7 d8 64 89
01 48
[  218.563001] RSP: 002b:00007fff16e560c8 EFLAGS: 00000206 ORIG_RAX:
00000000000000b0
[  218.571448] RAX: ffffffffffffffda RBX: 000055631b3dc510 RCX: 00007f9fafa3f5ab
[  218.579407] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 000055631b3dc578
[  218.587367] RBP: 000055631b3dc510 R08: 0000000000000000 R09: 0000000000000000
[  218.595328] R10: 00007f9fafb9eac0 R11: 0000000000000206 R12: 000055631b3dc578
[  218.603287] R13: 0000000000000000 R14: 000055631b3dbda8 R15: 00007fff16e58458
[  218.611248]  </TASK>
[  218.613683] Disabling lock debugging due to kernel taint
[  218.619610] Object 0xffff92381113c740 @offset=1856
[  218.624953] Allocated in mempool_init_node+0x92/0xd0 age=205368 cpu=0 pid=391
[  218.632917]  mempool_init_node+0x92/0xd0
[  218.637291]  mempool_create+0x56/0x80
[  218.641374]  fc_exch_mgr_alloc+0xd4/0x220 [libfc]
[  218.646631]  0xffffffffc0a10cbf
[  218.650133]  0xffffffffc0a12ce1
[  218.653633]  local_pci_probe+0x46/0xa0
[  218.657813]  work_for_cpu_fn+0x16/0x20
[  218.661994]  process_one_work+0x1e5/0x3f0
[  218.666467]  worker_thread+0x1c4/0x3a0
[  218.670647]  kthread+0xe2/0x110
[  218.674150]  ret_from_fork+0x2c/0x50
[  218.678138] Object 0xffff92381113d8c0 @offset=6336
[  218.683481] Allocated in mempool_init_node+0x92/0xd0 age=205133 cpu=0 pid=391
[  218.691442]  mempool_init_node+0x92/0xd0
[  218.695816]  mempool_create+0x56/0x80
[  218.699898]  fc_exch_mgr_alloc+0xd4/0x220 [libfc]
[  218.705155]  0xffffffffc0a10cbf
[  218.708655]  0xffffffffc0a12ce1
[  218.712156]  local_pci_probe+0x46/0xa0
[  218.716334]  work_for_cpu_fn+0x16/0x20
[  218.720515]  process_one_work+0x1e5/0x3f0
[  218.724986]  worker_thread+0x1c4/0x3a0
[  218.729167]  kthread+0xe2/0x110
[  218.732668]  ret_from_fork+0x2c/0x50
[  218.736656] Object 0xffff92381113da80 @offset=6784
[  218.741998] Allocated in mempool_init_node+0x92/0xd0 age=205192 cpu=0 pid=391
[  218.749959]  mempool_init_node+0x92/0xd0
[  218.754333]  mempool_create+0x56/0x80
[  218.758416]  fc_exch_mgr_alloc+0xd4/0x220 [libfc]
[  218.763673]  0xffffffffc0a10cbf
[  218.767173]  0xffffffffc0a12ce1
[  218.770674]  local_pci_probe+0x46/0xa0
[  218.774852]  work_for_cpu_fn+0x16/0x20
[  218.779031]  process_one_work+0x1e5/0x3f0
[  218.783504]  worker_thread+0x1c4/0x3a0
[  218.787683]  kthread+0xe2/0x110
[  218.791184]  ret_from_fork+0x2c/0x50
[  218.795172] Object 0xffff92381113dfc0 @offset=8128
[  218.800514] Allocated in mempool_init_node+0x92/0xd0 age=205544 cpu=0 pid=391
[  218.808477]  mempool_init_node+0x92/0xd0
[  218.812851]  mempool_create+0x56/0x80
[  218.816933]  fc_exch_mgr_alloc+0xd4/0x220 [libfc]
[  218.822187]  0xffffffffc0a10cbf
[  218.825688]  0xffffffffc0a12ce1
[  218.829188]  local_pci_probe+0x46/0xa0
[  218.833367]  work_for_cpu_fn+0x16/0x20
[  218.837547]  process_one_work+0x1e5/0x3f0
[  218.842018]  worker_thread+0x1c4/0x3a0
[  218.846197]  kthread+0xe2/0x110
[  218.849698]  ret_from_fork+0x2c/0x50

