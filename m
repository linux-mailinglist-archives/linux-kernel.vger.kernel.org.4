Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D95D735D50
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 20:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbjFSSIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 14:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjFSSIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 14:08:51 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A89127
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 11:08:48 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-54fdf8c79a3so1739975a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 11:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1687198128; x=1689790128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fs6mVZy+ApJjSA3fKN+GyxgBRC/lFXRt6YaugvJMyeM=;
        b=L/uLsqh431ZIwySMxeYWyJIkFQNeDBhq/cRQscjtn3NCSntIDDyAxuz52RjYd1kqTM
         gfQi1pQ7aYTbx772Z5egSsRx3EbkVjFOf5cgc5pormkx4UVeIRTQ7AYp8q+1qjcYATnQ
         4Na8IW3Zz9OCqZtN79ge+CSyuRX09oCwAKAlFEgfPWkpbt76ct3Pnd5ZyyP6y5nPF4+B
         uHr72AAtsE0AQJXGBXeLLSOblk8LixW+Z6R7szRAJnf4pGRUd8S24e9imM/aP2Cbk8im
         Q1PvgbfVJ/ycwKoOXqMK2mBZilzTNYqGAe0qis/dG3ZE6CZRjQYYGlRenc3aZy+XJHcW
         OYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687198128; x=1689790128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fs6mVZy+ApJjSA3fKN+GyxgBRC/lFXRt6YaugvJMyeM=;
        b=VylSI+D+J1eq3FK3TcLDtfnNk+l2WI6N4fY46kFBksVTH7Ox1GSfYxczg29rCoKEq6
         FjyUhADq1oq9YC1jCyjGbKHzkYargi0JEH3sKMTwE6aps9kEGVP/gEK8M0jQro/Zp1N0
         rjJwlF7Y3CXSZTVbJDSKBE4hazCWXJML6FXCqgIAZpJxlg5dweXVtC+vz0GbU5Yzc0wt
         nBKCwpp2mh93LLObGe0VCWEB6cRng1HLs0PqnvWiFZ+DNiljUOnZEtDtrj59ohe1WdXA
         XxpdHFlj76JVLbtYZmcpglyAQO4a0osUEbG682Il9FoKaTE532YTB1jiKw8NRhtXqtSB
         RKsg==
X-Gm-Message-State: AC+VfDxZa5DfXzQl9yc9mUeocgHfUloHu9QTMcfL6ODjKnyUtJ6gRFrX
        h8I1V5hjqOYxltNvsRXqFNNK5g==
X-Google-Smtp-Source: ACHHUZ72NbyVVWuIQYWUIxHS6JF+LDQXXit/zA8AKDrLPJ2Vp6UEee5W8mbIQIiYcHZFYRazKu6dkA==
X-Received: by 2002:a17:903:120b:b0:1ad:b5b4:e424 with SMTP id l11-20020a170903120b00b001adb5b4e424mr1550857plh.38.1687198127821;
        Mon, 19 Jun 2023 11:08:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902a60d00b001ac8e0ea157sm145490plq.144.2023.06.19.11.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 11:08:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qBJIz-007DQH-Jh;
        Mon, 19 Jun 2023 15:08:45 -0300
Date:   Mon, 19 Jun 2023 15:08:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     syzbot <syzbot+6c8d756f238a75fc3eb8@syzkaller.appspotmail.com>
Cc:     iommu@lists.linux.dev, joro@8bytes.org, kevin.tian@intel.com,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        syzkaller-bugs@googlegroups.com, will@kernel.org
Subject: Re: [syzbot] [iommu?] KASAN: slab-use-after-free Read in
 iommufd_access_unpin_pages
Message-ID: <ZJCZrSE6QQtp03l1@ziepe.ca>
References: <000000000000905eba05fe38e9f2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000905eba05fe38e9f2@google.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 11:01:13PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    4c605260bc60 Merge tag 'x86_urgent_for_v6.4_rc6' of git://..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14d07943280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3c980bfe8b399968
> dashboard link: https://syzkaller.appspot.com/bug?extid=6c8d756f238a75fc3eb8
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=158a29dd280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=167dd475280000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/9c4a756cb2ce/disk-4c605260.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/321df5350ca6/vmlinux-4c605260.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/f117647a1dc2/bzImage-4c605260.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+6c8d756f238a75fc3eb8@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in iopt_area_last_iova drivers/iommu/iommufd/io_pagetable.h:88 [inline]
> BUG: KASAN: slab-use-after-free in iopt_area_contig_done drivers/iommu/iommufd/io_pagetable.h:160 [inline]
> BUG: KASAN: slab-use-after-free in iommufd_access_unpin_pages+0x363/0x370 drivers/iommu/iommufd/device.c:557
> Read of size 8 at addr ffff888022286e20 by task syz-executor669/5771
> 
> CPU: 0 PID: 5771 Comm: syz-executor669 Not tainted 6.4.0-rc5-syzkaller-00313-g4c605260bc60 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
>  print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:351
>  print_report mm/kasan/report.c:462 [inline]
>  kasan_report+0x11c/0x130 mm/kasan/report.c:572
>  iopt_area_last_iova drivers/iommu/iommufd/io_pagetable.h:88 [inline]
>  iopt_area_contig_done drivers/iommu/iommufd/io_pagetable.h:160 [inline]
>  iommufd_access_unpin_pages+0x363/0x370 drivers/iommu/iommufd/device.c:557
>  iommufd_test_access_unmap+0x24b/0x390 drivers/iommu/iommufd/selftest.c:613
>  iommufd_access_notify_unmap+0x24c/0x3a0 drivers/iommu/iommufd/device.c:520
>  iopt_unmap_iova_range+0x4c4/0x5f0 drivers/iommu/iommufd/io_pagetable.c:497
>  iopt_unmap_all+0x27/0x50 drivers/iommu/iommufd/io_pagetable.c:555
>  iommufd_ioas_unmap+0x3d0/0x490 drivers/iommu/iommufd/ioas.c:300
>  iommufd_fops_ioctl+0x317/0x4b0 drivers/iommu/iommufd/main.c:337
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:870 [inline]
>  __se_sys_ioctl fs/ioctl.c:856 [inline]
>  __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fec1dae3b19
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fec1da74308 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007fec1db6b438 RCX: 00007fec1dae3b19
> RDX: 0000000020000100 RSI: 0000000000003b86 RDI: 0000000000000003
> RBP: 00007fec1db6b430 R08: 00007fec1da74700 R09: 0000000000000000
> R10: 00007fec1da74700 R11: 0000000000000246 R12: 00007fec1db6b43c
> R13: 00007fec1db39074 R14: 6d6f692f7665642f R15: 0000000000022000
>  </TASK>

#syz dup: KASAN: slab-use-after-free Read in iopt_unmap_iova_range

