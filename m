Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEEE5FC946
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 18:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiJLQ26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 12:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiJLQ2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 12:28:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124CEC6941
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 09:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665592126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p+gbkIPpJZETILryGR8Fofeq2YGGM03Y+tNouTLa6jI=;
        b=f4vts79pN8JEilTSabQEtdRCvok7qHdhnkpqo13ej3BUyOW7F/o2uodHccok3MJggkw/vL
        i7GKs3zEjo2OrSaDlTBI4Voq+kJ09EANZ6+Q1gK4rl9nh2zbC+sNPWKobF09/f6pWvY9kn
        0nxeT0LxJSPIsP65XDIXrZMQOpXPfXY=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-225-EI3ZAD98MDi0XdqBUJDFkg-1; Wed, 12 Oct 2022 12:28:45 -0400
X-MC-Unique: EI3ZAD98MDi0XdqBUJDFkg-1
Received: by mail-il1-f197.google.com with SMTP id j29-20020a056e02219d00b002f9b13c40c5so13924860ila.21
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 09:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+gbkIPpJZETILryGR8Fofeq2YGGM03Y+tNouTLa6jI=;
        b=pSXsFQot3NVfSZtH3fevamFuhfRIPP3pkFdNq4K33O0FYTkNHxWv5vi8Z+Qn0nxMxV
         nPqyKm8Ypd77MBQcpoFqrWKNIFwWHmBgyG5qm+lHG2krH86SJvuIopq3dFRL4Ejeyt7g
         i0GApYSfYK39WQBy7VPUngi1iKZkbaRjTSHC7oaHsXqMcsPKF4nxj+64JfdjZpZy2Y3s
         tjJBCbCdthOOUP70X37/hKig8CxJszf3FXQN72rrNxad3nuerleEUTSmfwSSzWhvKzl8
         4Vap7UHSHdRqhpvjx0gk1J9eqOpi/ul9sYexzpVpgY3XqqwqcCrS57kKHPMYMreO4PRs
         HE4Q==
X-Gm-Message-State: ACrzQf0988su12+MF7ceKuS2x+HynPNFIblbTzjKLhFE3n7GItThF1sU
        xl/+Epi0UsH+cmTwZCQdMmgKmQE+Ew/yyMnaOQ25UFh8i2MrbxV5tTJffkBaUcpRNzb9LhJup8a
        5+t8rirWRAOdHppjmoDzLFCs7
X-Received: by 2002:a05:6e02:1a6d:b0:2fa:cb68:b9f with SMTP id w13-20020a056e021a6d00b002facb680b9fmr14236256ilv.303.1665592124418;
        Wed, 12 Oct 2022 09:28:44 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6iQ0fe5mXyZ0PV6pwrme1wNd48yPmhXptxw1AqtsZDol6VCQ6eqXOpR51/yFoCHwecB2ykvg==
X-Received: by 2002:a05:6e02:1a6d:b0:2fa:cb68:b9f with SMTP id w13-20020a056e021a6d00b002facb680b9fmr14236240ilv.303.1665592124189;
        Wed, 12 Oct 2022 09:28:44 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id q22-20020a02b056000000b00356744215f6sm6593901jah.47.2022.10.12.09.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 09:28:43 -0700 (PDT)
Date:   Wed, 12 Oct 2022 10:28:41 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com,
        kevin.tian@intel.com, suravee.suthikulpanit@amd.com,
        vasant.hegde@amd.com, mjrosato@linux.ibm.com,
        schnelle@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/16] iommu: Move bus setup to IOMMU device
 registration
Message-ID: <20221012102841.478c2b3b.alex.williamson@redhat.com>
In-Reply-To: <d342b6f27efb5ef3e93aacaa3012d25386d74866.1660572783.git.robin.murphy@arm.com>
References: <cover.1660572783.git.robin.murphy@arm.com>
        <d342b6f27efb5ef3e93aacaa3012d25386d74866.1660572783.git.robin.murphy@arm.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Aug 2022 17:20:06 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> Move the bus setup to iommu_device_register(). This should allow
> bus_iommu_probe() to be correctly replayed for multiple IOMMU instances,
> and leaves bus_set_iommu() as a glorified no-op to be cleaned up next.
> 
> At this point we can also handle cleanup better than just rolling back
> the most-recently-touched bus upon failure - which may release devices
> owned by other already-registered instances, and still leave devices on
> other buses with dangling pointers to the failed instance. Now it's easy
> to clean up the exact footprint of a given instance, no more, no less.
> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-By: Krishna Reddy <vdumpa@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Tested-by: Matthew Rosato <mjrosato@linux.ibm.com> # s390
> Tested-by: Niklas Schnelle <schnelle@linux.ibm.com> # s390
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v4: Factor out the ops check in iommu_device_register() to keep the loop
> even simpler, and comment the nominal change in behaviour
> 
>  drivers/iommu/iommu.c | 55 +++++++++++++++++++++++--------------------
>  1 file changed, 30 insertions(+), 25 deletions(-)

This introduces the below lockdep spat regression, bisected to commit:

57365a04c921 ("iommu: Move bus setup to IOMMU device registration")

This can be reproduced with simple vfio-pci device assignment to a VM
on x86_64 with VT-d.  Thanks,

Alex

======================================================
WARNING: possible circular locking dependency detected
6.0.0-rc4+ #127 Tainted: G            E     
------------------------------------------------------
qemu-system-x86/1726 is trying to acquire lock:
ffffffffacf8a7d0 (dmar_global_lock){++++}-{3:3}, at: intel_iommu_get_resv_regions+0x21/0x2a0

but task is already holding lock:
ffff981240efb0c0 (&group->mutex){+.+.}-{3:3}, at: iommu_get_group_resv_regions+0x2c/0x3b0

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&group->mutex){+.+.}-{3:3}:
       __mutex_lock+0x6d/0x8c0
       iommu_group_add_device+0xfb/0x330
       __iommu_probe_device+0x150/0x270
       probe_iommu_group+0x31/0x50
       bus_for_each_dev+0x67/0xa0
       bus_iommu_probe+0x38/0x2a0
       iommu_device_register+0xc1/0x130
       intel_iommu_init+0xfd9/0x120d
       pci_iommu_init+0xe/0x36
       do_one_initcall+0x5b/0x310
       kernel_init_freeable+0x275/0x2c1
       kernel_init+0x16/0x140
       ret_from_fork+0x22/0x30

-> #0 (dmar_global_lock){++++}-{3:3}:
       __lock_acquire+0x10dc/0x1da0
       lock_acquire+0xc2/0x2d0
       down_read+0x2d/0x40
       intel_iommu_get_resv_regions+0x21/0x2a0
       iommu_get_group_resv_regions+0x88/0x3b0
       vfio_iommu_type1_attach_group+0x19d/0xce1 [vfio_iommu_type1]
       vfio_fops_unl_ioctl+0x19d/0x270 [vfio]
       __x64_sys_ioctl+0x8b/0xc0
       do_syscall_64+0x3b/0x90
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&group->mutex);
                               lock(dmar_global_lock);
                               lock(&group->mutex);
  lock(dmar_global_lock);

 *** DEADLOCK ***

4 locks held by qemu-system-x86/1726:
 #0: ffff9811b5546c88 (&container->group_lock){++++}-{3:3}, at: vfio_fops_unl_ioctl+0xbb/0x270 [vfio]
 #1: ffffffffc058c720 (&vfio.iommu_drivers_lock){+.+.}-{3:3}, at: vfio_fops_unl_ioctl+0xeb/0x270 [vfio]
 #2: ffff9811d865ba88 (&iommu->lock#2){+.+.}-{3:3}, at: vfio_iommu_type1_attach_group+0x51/0xce1 [vfio_iommu_type1]
 #3: ffff981240efb0c0 (&group->mutex){+.+.}-{3:3}, at: iommu_get_group_resv_regions+0x2c/0x3b0

stack backtrace:
CPU: 0 PID: 1726 Comm: qemu-system-x86 Tainted: G            E      6.0.0-rc4+ #127
Hardware name: System manufacturer System Product Name/P8H67-M PRO, BIOS 3904 04/27/2013
Call Trace:
 <TASK>
 dump_stack_lvl+0x56/0x73
 check_noncircular+0xd6/0x100
 ? __lock_acquire+0x374/0x1da0
 __lock_acquire+0x10dc/0x1da0
 lock_acquire+0xc2/0x2d0
 ? intel_iommu_get_resv_regions+0x21/0x2a0
 ? trace_contention_end+0x2d/0xd0
 ? __mutex_lock+0xdf/0x8c0
 ? iommu_get_group_resv_regions+0x2c/0x3b0
 ? lock_is_held_type+0xe2/0x140
 down_read+0x2d/0x40
 ? intel_iommu_get_resv_regions+0x21/0x2a0
 intel_iommu_get_resv_regions+0x21/0x2a0
 iommu_get_group_resv_regions+0x88/0x3b0
 ? iommu_attach_group+0x76/0xa0
 vfio_iommu_type1_attach_group+0x19d/0xce1 [vfio_iommu_type1]
 ? rcu_read_lock_sched_held+0x43/0x70
 ? __module_address.part.0+0x2b/0xa0
 ? is_module_address+0x43/0x70
 ? __init_waitqueue_head+0x4a/0x60
 vfio_fops_unl_ioctl+0x19d/0x270 [vfio]
 __x64_sys_ioctl+0x8b/0xc0
 do_syscall_64+0x3b/0x90
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f803853a17b
Code: 0f 1e fa 48 8b 05 1d ad 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ed ac 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007ffd8128c2e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000020 RCX: 00007f803853a17b
RDX: 0000000000000003 RSI: 0000000000003b66 RDI: 000000000000001c
RBP: 00007ffd8128c320 R08: 000055f59d8ff8d0 R09: 00007f8038605a40
R10: 0000000000000008 R11: 0000000000000246 R12: 000055f599aed1d0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

