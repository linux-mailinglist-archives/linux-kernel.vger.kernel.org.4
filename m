Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F117B6952D9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjBMVO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjBMVOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:14:55 -0500
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1546E20548
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 13:14:41 -0800 (PST)
Received: by mail-il1-f207.google.com with SMTP id 15-20020a92190f000000b00315509b129aso1403470ilz.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 13:14:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5MOkuFS9QIN3mf/KRy78aCAqz7A+XmCO2P1W5d9dmcE=;
        b=p0hd9EVXG/RU9R4b/Q6z3KCqPNEicZz1J7SEu5SBcIMRxFOthyb5NRs1eYKFdkpGhe
         6hfyGbPyQJH0f7wYxY04BBoVVH03g2JXLsq512mk1DEXOqNpvSIlUWmWOThCvpI7AEtQ
         vkBgccrgUvRg1H6wu1iidRWlxqowWg6HqBe9uNxRHP0dUD71uEWa08Xk8W998XBG6CAE
         Ey8HeNHkEb14HungkEFwswqbfjrGVO37DjDq8Bq9Ci+7XqTLM23Lha2dC6YSlElSOikE
         c1FoboC392e48Ue6D4w5Ycd6QGD3x+l9n32Droe6WInGne3ODSHOrSgRln8qP4CiJf38
         ST9w==
X-Gm-Message-State: AO0yUKX52Njvz8cvHCqPIyHzHlSXlVGNlvLY0RR9wJmy+I0GrJaAzdfD
        7xgYTxhk1qgK88DqMbH47RzbMdfgferbo/mWQ4pgN6piBNFX
X-Google-Smtp-Source: AK7set/pAxwmNE14kr483ZJxL58VyTsM9vtXj+L/vRdydrx/Cjd+AOO1D/oO8Rw3FfGbzFqamqHiq88zxHchWOXVRzY/eQmle91o
MIME-Version: 1.0
X-Received: by 2002:a02:ccf4:0:b0:38a:adeb:d4d1 with SMTP id
 l20-20020a02ccf4000000b0038aadebd4d1mr13143021jaq.81.1676322880445; Mon, 13
 Feb 2023 13:14:40 -0800 (PST)
Date:   Mon, 13 Feb 2023 13:14:40 -0800
In-Reply-To: <0000000000000df2c105f4929eb5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d1610405f49b5514@google.com>
Subject: Re: [syzbot] KMSAN: kernel-infoleak in iommufd_vfio_ioctl
From:   syzbot <syzbot+cb1e0978f6bf46b83a58@syzkaller.appspotmail.com>
To:     eric.auger@redhat.com, glider@google.com, iommu@lists.linux.dev,
        jgg@nvidia.com, jgg@ziepe.ca, joro@8bytes.org,
        kevin.tian@intel.com, linux-kernel@vger.kernel.org,
        lixiao.yang@intel.com, mjrosato@linux.ibm.com, nicolinc@nvidia.com,
        robin.murphy@arm.com, syzkaller-bugs@googlegroups.com,
        will@kernel.org, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    da13c00eebfb kmsan: silence -Wmissing-prototypes warnings
git tree:       https://github.com/google/kmsan.git master
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10d56c2b480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41295d7e980cccef
dashboard link: https://syzkaller.appspot.com/bug?extid=cb1e0978f6bf46b83a58
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16560c43480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=109a7207480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/316f273df601/disk-da13c00e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c2802e9a4fe3/vmlinux-da13c00e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6211b8a40cab/bzImage-da13c00e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cb1e0978f6bf46b83a58@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:121 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_user+0x1c5/0x270 lib/usercopy.c:33
 instrument_copy_to_user include/linux/instrumented.h:121 [inline]
 _copy_to_user+0x1c5/0x270 lib/usercopy.c:33
 copy_to_user include/linux/uaccess.h:169 [inline]
 iommufd_vfio_iommu_get_info drivers/iommu/iommufd/vfio_compat.c:437 [inline]
 iommufd_vfio_ioctl+0x1e57/0x2330 drivers/iommu/iommufd/vfio_compat.c:462
 iommufd_fops_ioctl+0x254/0xb10 drivers/iommu/iommufd/main.c:315
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0x2dd/0x4b0 fs/ioctl.c:856
 __x64_sys_ioctl+0xdc/0x120 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Local variable info.i created at:
 iommufd_vfio_iommu_get_info drivers/iommu/iommufd/vfio_compat.c:384 [inline]
 iommufd_vfio_ioctl+0x423/0x2330 drivers/iommu/iommufd/vfio_compat.c:462
 iommufd_fops_ioctl+0x254/0xb10 drivers/iommu/iommufd/main.c:315

Bytes 20-23 of 24 are uninitialized
Memory access of size 24 starts at ffff88810ed3bcb0
Data copied to user address 0000000020000100

CPU: 0 PID: 5039 Comm: syz-executor178 Not tainted 6.2.0-rc8-syzkaller-80994-gda13c00eebfb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
=====================================================

