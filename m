Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051D9626F98
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 14:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbiKMNAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 08:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbiKMNAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 08:00:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EEFF31
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 04:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668344359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YDbE9HMitpVMVBGcKpaPg+t4NbUTfc5Zmsj/A5QLKDM=;
        b=KGfoqf5JlZkFslfwN11/yAmJJ66TDA5cEWX26HFPjtaJnCahWaJYQ2t/GZh2Akacb/7kXI
        EEHgplBMQjCA15AdEwIPEGES+XkxChgoNKmw4t7WNy06JHgYexkxkDoyX2wNgEBr3c4Gp1
        IcQWx+shp5NewXQH+32rn0pFrYIQOQw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-182-SpYgIdGTOoKsHKMb55-aYA-1; Sun, 13 Nov 2022 07:59:17 -0500
X-MC-Unique: SpYgIdGTOoKsHKMb55-aYA-1
Received: by mail-wm1-f71.google.com with SMTP id v188-20020a1cacc5000000b003cf76c4ae66so7419692wme.7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 04:59:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDbE9HMitpVMVBGcKpaPg+t4NbUTfc5Zmsj/A5QLKDM=;
        b=tTFVbsddrMW8s6tIbc9YoarR0szb4ZxDScZla2qUifAivMq+Qe1z1CO16Tu/L89SbH
         2X84iOKrAi3DXnnI3P/jqPPfo0cqw3AnUDEDIwgVcuQK4I4+wp2hGDWZCAEd87QQdlHB
         ZEVvpmWyWZcfmUvSgqbk3hbyxRzsbroOt0TVWLUuFZIXNy6TgcUmuTtDO5hXzE9TYDq8
         eoCtcJvIy/hlyBIUL6T51V1JouZu/143iW6gFWqQgolNteI/Y505Hp8w1+S3Z2J5i+je
         BGMqiZ2LOAExD5APH8uO2BcpT5rrMDqJDxQJYTZsUWJ0WXpgcNiEsPLF48QUUM54nVyB
         iRrA==
X-Gm-Message-State: ANoB5pkyeDIcEPK2TW0rVDXPYZnebGVgz/BtKnG1NxxJo4ltPTjM6+ce
        0UD60kgsMdStlSZaqgaxawTiaz26FXiHwLKDNTlLj/sSH1r+pr9xof3wMc/8Ta1vvxLK+deV+Kr
        IbnGEteYQoDxgd8oOB1bXAy5K
X-Received: by 2002:a5d:456e:0:b0:236:8fab:b373 with SMTP id a14-20020a5d456e000000b002368fabb373mr5198712wrc.9.1668344355995;
        Sun, 13 Nov 2022 04:59:15 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6XEoOofo0Ti278J5VtVjhKCdhb5zVhuqiJzinzghrlzRAp95NyIWTF+6qNJSzm6UB3SF3Eow==
X-Received: by 2002:a5d:456e:0:b0:236:8fab:b373 with SMTP id a14-20020a5d456e000000b002368fabb373mr5198706wrc.9.1668344355705;
        Sun, 13 Nov 2022 04:59:15 -0800 (PST)
Received: from redhat.com ([2.52.4.127])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b002365730eae8sm6885228wrf.55.2022.11.13.04.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 04:59:14 -0800 (PST)
Date:   Sun, 13 Nov 2022 07:59:11 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Angus Chen <angus.chen@jaguarmicro.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liming Wu <liming.wu@jaguarmicro.com>,
        "stefanha@redhat.com" <stefanha@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v1] virtio_blk: should not use IRQD_AFFINITY_MANAGED in
 init_rq
Message-ID: <20221113075617-mutt-send-email-mst@kernel.org>
References: <20220924034854.323-1-angus.chen@jaguarmicro.com>
 <20220927163723-mutt-send-email-mst@kernel.org>
 <TY2PR06MB3424C2AD8F7AC77DA83FB4C685549@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <TY2PR06MB34249F3D2DE2C30BB324E5A385039@TY2PR06MB3424.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY2PR06MB34249F3D2DE2C30BB324E5A385039@TY2PR06MB3424.apcprd06.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 03:28:37AM +0000, Angus Chen wrote:
> Hi.
> I use the patch to workaround irq resource exhausted.
> Although mst helped me to fix the intx irq resource in virtio_pci_common.c,
> Link: https://lore.kernel.org/virtualization/20221014013156-mutt-send-email-mst@kernel.org/
> 
> As mst said,the bug will still be there.
> The dpu can provide more than 512 virtio_blk in one machine. 
> Could you pls provide more suggestion?
> 
> Thanks.

I think you need to write a new message documenting the
behaviour on new kernels (with the crash fixed).


> > -----Original Message-----
> > From: Angus Chen
> > Sent: Wednesday, September 28, 2022 11:25 AM
> > To: Michael S. Tsirkin <mst@redhat.com>
> > Cc: jasowang@redhat.com; pbonzini@redhat.com; axboe@kernel.dk;
> > virtualization@lists.linux-foundation.org; linux-block@vger.kernel.org;
> > linux-kernel@vger.kernel.org; Liming Wu <liming.wu@jaguarmicro.com>;
> > stefanha@redhat.com; Christoph Hellwig <hch@lst.de>
> > Subject: RE: [PATCH v1] virtio_blk: should not use IRQD_AFFINITY_MANAGED in
> > init_rq
> > 
> > 
> > 
> > > -----Original Message-----
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Wednesday, September 28, 2022 4:47 AM
> > > To: Angus Chen <angus.chen@jaguarmicro.com>
> > > Cc: jasowang@redhat.com; pbonzini@redhat.com; axboe@kernel.dk;
> > > virtualization@lists.linux-foundation.org; linux-block@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; Liming Wu <liming.wu@jaguarmicro.com>;
> > > stefanha@redhat.com; Christoph Hellwig <hch@lst.de>
> > > Subject: Re: [PATCH v1] virtio_blk: should not use IRQD_AFFINITY_MANAGED
> > in
> > > init_rq
> > >
> > > On Sat, Sep 24, 2022 at 11:48:54AM +0800, Angus Chen wrote:
> > > > The background is that we use dpu in cloud computing,the arch is x86,80
> > > > cores.We will have a lots of virtio devices,like 512 or more.
> > > > When we probe about 200 virtio_blk devices,it will fail and
> > > > the stack is print as follows:
> > > >
> > > > [25338.485128] virtio-pci 0000:b3:00.0: virtio_pci: leaving for legacy driver
> > > > [25338.496174] genirq: Flags mismatch irq 0. 00000080 (virtio418) vs.
> > > 00015a00 (timer)
> > > > [25338.503822] CPU: 20 PID: 5431 Comm: kworker/20:0 Kdump: loaded
> > > Tainted: G           OE    --------- -  - 4.18.0-305.30.1.el8.x86_64
> > > > [25338.516403] Hardware name: Inspur NF5280M5/YZMB-00882-10E, BIOS
> > > 4.1.21 08/25/2021
> > > > [25338.523881] Workqueue: events work_for_cpu_fn
> > > > [25338.528235] Call Trace:
> > > > [25338.530687]  dump_stack+0x5c/0x80
> > > > [25338.534000]  __setup_irq.cold.53+0x7c/0xd3
> > > > [25338.538098]  request_threaded_irq+0xf5/0x160
> > > > [25338.542371]  vp_find_vqs+0xc7/0x190
> > > > [25338.545866]  init_vq+0x17c/0x2e0 [virtio_blk]
> > > > [25338.550223]  ? ncpus_cmp_func+0x10/0x10
> > > > [25338.554061]  virtblk_probe+0xe6/0x8a0 [virtio_blk]
> > > > [25338.558846]  virtio_dev_probe+0x158/0x1f0
> > > > [25338.562861]  really_probe+0x255/0x4a0
> > > > [25338.566524]  ? __driver_attach_async_helper+0x90/0x90
> > > > [25338.571567]  driver_probe_device+0x49/0xc0
> > > > [25338.575660]  bus_for_each_drv+0x79/0xc0
> > > > [25338.579499]  __device_attach+0xdc/0x160
> > > > [25338.583337]  bus_probe_device+0x9d/0xb0
> > > > [25338.587167]  device_add+0x418/0x780
> > > > [25338.590654]  register_virtio_device+0x9e/0xe0
> > > > [25338.595011]  virtio_pci_probe+0xb3/0x140
> > > > [25338.598941]  local_pci_probe+0x41/0x90
> > > > [25338.602689]  work_for_cpu_fn+0x16/0x20
> > > > [25338.606443]  process_one_work+0x1a7/0x360
> > > > [25338.610456]  ? create_worker+0x1a0/0x1a0
> > > > [25338.614381]  worker_thread+0x1cf/0x390
> > > > [25338.618132]  ? create_worker+0x1a0/0x1a0
> > > > [25338.622051]  kthread+0x116/0x130
> > > > [25338.625283]  ? kthread_flush_work_fn+0x10/0x10
> > > > [25338.629731]  ret_from_fork+0x1f/0x40
> > > > [25338.633395] virtio_blk: probe of virtio418 failed with error -16
> > > >
> > > > After I did some work of this stack,took stap and crash to get more
> > > > information,I found that the auto irq_affinity affect this.
> > > > When "vp_find_vqs" call "vp_find_vqs_msix" failed,it will be go back
> > > > to call vp_find_vqs_msix again with ctx be false, and when it failed again,
> > > > we will call vp_find_vqs_intx,if the vp_dev->pci_dev->irq is zero,
> > > > we will get a backtrace like above.
> > > >
> > > > The log :
> > > > "genirq: Flags mismatch irq 0. 00000080 (virtio418) vs. 00015a00 (timer)"
> > > > was print because of the irq 0 is used by timer exclusive,and when
> > > > vp_find_vqs called vp_find_vqs_msix and return false twice,then it will
> > > > call vp_find_vqs_intx for the last try.
> > > > Because vp_dev->pci_dev->irq is zero,so it will be request irq 0 with
> > > > flag IRQF_SHARED.
> > >
> > > First this is a bug. We can fix that so it will fail more cleanly.
> > >
> > > We should check pci_dev->pin and if 0 do not try to use INT#x
> > > at all.
> > Yes, I will send a patch for this only.
> > Thank you.
> > > It will still fail, just with a nicer backtrace.
> > >
> > >
> > >
> > >
> > > > without config CONFIG_GENERIC_IRQ_DEBUGFS,
> > > > I found that we called vp_find_vqs_msix failed twice because of
> > > > the irq resource was exhausted.
> > >
> > > I see. I don't know enough about how this work, but roughly
> > > I think the issue is at a high level
> > >
> > > - because of auto affinity, we try to reserve an interrupt on all CPUs
> > > - as there are 512 devices with a single vector per VQ we would
> > >   have no issue as they would be spread between CPUs,
> > >   but allocating on all CPUs fails.
> > >
> > >
> > > I don't think the issue should be fixed at blk level - it is not
> > > blk specifix - but yes this looks like a problem.
> > > Christoph, any idea?
> > >
> > >
> > >
> > > > crash> irq_domain.name,parent 0xffff9bff87d4dec0
> > > >   name = 0xffff9bff87c1fd60 "INTEL-IR-MSI-1-2"
> > > >   parent = 0xffff9bff87400000
> > > > crash> irq_domain.name,parent 0xffff9bff87400000
> > > >   name = 0xffff9bff87c24300 "INTEL-IR-1"
> > > >   parent = 0xffff9bff87c6c900
> > > > crash> irq_domain.name,parent 0xffff9bff87c6c900
> > > >   name = 0xffff9bff87c3ecd0 "VECTOR"
> > > >   parent = 0x0----------------------the highest level
> > > >
> > > > and stap irq_matrix_alloc_managed get return value -ENOSPC.
> > > >
> > > > When no virtio_blk device probe,the vctor_matrix is:
> > > > crash>  p *vector_matrix
> > > > $1 = {
> > > >   matrix_bits = 256,
> > > >   alloc_start = 32,
> > > >   alloc_end = 236,
> > > >   alloc_size = 204,
> > > >   global_available = 15593,
> > > >   global_reserved = 149,
> > > >   systembits_inalloc = 3,
> > > >   total_allocated = 409,
> > > >   online_maps = 80,
> > > >   maps = 0x2ff20,
> > > >   scratch_map = {1161063342014463, 0, 1, 18446726481523507200,
> > > >  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> > > >  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
> > > >   system_map = {1125904739729407, 0, 1, 18446726481523507200,
> > > >  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> > > >  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
> > > > }
> > > >
> > > > When the dump stack occur,the vector_matrix of system is exhausted.
> > > > crash> p *vector_matrix
> > > > $82 = {
> > > >   matrix_bits = 256,
> > > >   alloc_start = 32,
> > > >   alloc_end = 236,
> > > >   alloc_size = 204,
> > > >   global_available = 0,//caq:irq left
> > > >   global_reserved = 151,
> > > >   systembits_inalloc = 3,
> > > >   total_allocated = 1922,//caq:irq that allocated
> > > >   online_maps = 80,
> > > >   maps = 0x2ff20,
> > > >   scratch_map = {18446744069952503807, 18446744073709551615,
> > > >  18446744073709551615, 18446735277616529407, 0, 0, 0, 0, 0,
> > > >  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
> > > >   system_map = {1125904739729407, 0, 1, 18446726481523507200,
> > > >  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> > > >  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
> > > > }
> > > >
> > > > And we tested the virtio_blk device which request irq success,
> > > > we found that in a system with 80 cores and two numa ,one
> > > > virtio_blk device with just two data queues consume 81 irqs capacity,
> > > > Although it just only three irqs in /proc/interrupt,80 irqs capacity
> > > > is effected by function "irq_build_affinity_masks" with 2*40.
> > > >
> > > > before one virtio_blk device hotplug out:
> > > > crash> p *vector_matrix
> > > > $2 = {
> > > >   matrix_bits = 256,
> > > >   alloc_start = 32,
> > > >   alloc_end = 236,
> > > >   alloc_size = 204,
> > > >   global_available = 15215,
> > > >   global_reserved = 150,
> > > >   systembits_inalloc = 3,
> > > >   total_allocated = 553,
> > > >   online_maps = 80,
> > > >   maps = 0x2ff20,
> > > >   scratch_map = {1179746449752063, 0, 1, 18446726481523507200, 0, 0,
> > 0,
> > > >  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> > > >  0, 0, 0, 0, 0},
> > > >   system_map = {1125904739729407, 0, 1, 18446726481523507200, 0, 0,
> > 0,
> > > >  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> > > >  0, 0, 0, 0, 0}
> > > > }
> > > >
> > > > after one virtio_blk device hotplug out:
> > > > crash> p *vector_matrix
> > > > $3 = {
> > > >   matrix_bits = 256,
> > > >   alloc_start = 32,
> > > >   alloc_end = 236,
> > > >   alloc_size = 204,
> > > >   global_available = 15296,---it increase 81,include 1 config irq.
> > > >   global_reserved = 150,
> > > >   systembits_inalloc = 3,
> > > >   total_allocated = 550,------it just decrease 3.
> > > >   online_maps = 80,
> > > >   maps = 0x2ff20,
> > > >   scratch_map = {481036337152, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> > > >  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> > > >  0, 0, 0, 0},
> > > >   system_map = {1125904739729407, 0, 1, 18446726481523507200, 0, 0,
> > 0,
> > > >  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> > > >  0, 0, 0, 0, 0}
> > > > }
> > > >
> > > > We test the new kernel also,it occur the same result.
> > > > [Fri Sep 23 04:51:42 2022] genirq: Flags mismatch irq 0. 00000080 (virtio608)
> > > vs. 00015a00 (timer)
> > > > [Fri Sep 23 04:51:42 2022] CPU: 0 PID: 5749 Comm: kworker/0:0 Kdump:
> > > loaded Tainted: G        W  OE      6.0.0-rc6+ #5
> > > > [Fri Sep 23 04:51:42 2022] Hardware name: Inspur
> > > NF5280M5/YZMB-00882-10E, BIOS 4.1.19 06/16/2021
> > > > [Fri Sep 23 04:51:42 2022] Workqueue: events work_for_cpu_fn
> > > > [Fri Sep 23 04:51:42 2022] Call Trace:
> > > > [Fri Sep 23 04:51:42 2022]  <TASK>
> > > > [Fri Sep 23 04:51:42 2022]  dump_stack_lvl+0x33/0x46
> > > > [Fri Sep 23 04:51:42 2022]  __setup_irq+0x705/0x770
> > > > [Fri Sep 23 04:51:42 2022]  request_threaded_irq+0x109/0x170
> > > > [Fri Sep 23 04:51:42 2022]  vp_find_vqs+0xc4/0x190
> > > > [Fri Sep 23 04:51:42 2022]  init_vqs+0x348/0x580 [virtio_net]
> > > > [Fri Sep 23 04:51:42 2022]  virtnet_probe+0x54d/0xa80 [virtio_net]
> > > > [Fri Sep 23 04:51:42 2022]  virtio_dev_probe+0x19c/0x240
> > > > [Fri Sep 23 04:51:42 2022]  really_probe+0x106/0x3e0
> > > > [Fri Sep 23 04:51:42 2022]  ? pm_runtime_barrier+0x4f/0xa0
> > > > [Fri Sep 23 04:51:42 2022]  __driver_probe_device+0x79/0x170
> > > > [Fri Sep 23 04:51:42 2022]  driver_probe_device+0x1f/0xa0
> > > > [Fri Sep 23 04:51:42 2022]  __device_attach_driver+0x85/0x110
> > > > [Fri Sep 23 04:51:42 2022]  ? driver_allows_async_probing+0x60/0x60
> > > > [Fri Sep 23 04:51:42 2022]  ? driver_allows_async_probing+0x60/0x60
> > > > [Fri Sep 23 04:51:42 2022]  bus_for_each_drv+0x67/0xb0
> > > > [Fri Sep 23 04:51:42 2022]  __device_attach+0xe9/0x1b0
> > > > [Fri Sep 23 04:51:42 2022]  bus_probe_device+0x87/0xa0
> > > > [Fri Sep 23 04:51:42 2022]  device_add+0x59f/0x950
> > > > [Fri Sep 23 04:51:42 2022]  ? dev_set_name+0x4e/0x70
> > > > [Fri Sep 23 04:51:42 2022]  register_virtio_device+0xac/0xf0
> > > > [Fri Sep 23 04:51:42 2022]  virtio_pci_probe+0x101/0x170
> > > > [Fri Sep 23 04:51:42 2022]  local_pci_probe+0x42/0xa0
> > > > [Fri Sep 23 04:51:42 2022]  work_for_cpu_fn+0x13/0x20
> > > > [Fri Sep 23 04:51:42 2022]  process_one_work+0x1c2/0x3d0
> > > > [Fri Sep 23 04:51:42 2022]  ? process_one_work+0x3d0/0x3d0
> > > > [Fri Sep 23 04:51:42 2022]  worker_thread+0x1b9/0x360
> > > > [Fri Sep 23 04:51:42 2022]  ? process_one_work+0x3d0/0x3d0
> > > > [Fri Sep 23 04:51:42 2022]  kthread+0xe6/0x110
> > > > [Fri Sep 23 04:51:42 2022]  ? kthread_complete_and_exit+0x20/0x20
> > > > [Fri Sep 23 04:51:42 2022]  ret_from_fork+0x1f/0x30
> > > > [Fri Sep 23 04:51:42 2022]  </TASK>
> > > > [Fri Sep 23 04:51:43 2022] virtio_net: probe of virtio608 failed with error -16
> > > >
> > > > Fixes: ad71473d9c43 ("virtio_blk: use virtio IRQ affinity")
> > > > Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> > > > Tested-by: Liming Wu <liming.wu@jaguarmicro.com>
> > > > ---
> > > >  drivers/block/virtio_blk.c | 3 +--
> > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > > index a8bcf3f664af..075de30a9bb4 100644
> > > > --- a/drivers/block/virtio_blk.c
> > > > +++ b/drivers/block/virtio_blk.c
> > > > @@ -513,7 +513,6 @@ static int init_vq(struct virtio_blk *vblk)
> > > >  	struct virtqueue **vqs;
> > > >  	unsigned short num_vqs;
> > > >  	struct virtio_device *vdev = vblk->vdev;
> > > > -	struct irq_affinity desc = { 0, };
> > > >
> > > >  	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_MQ,
> > > >  				   struct virtio_blk_config, num_queues,
> > > > @@ -548,7 +547,7 @@ static int init_vq(struct virtio_blk *vblk)
> > > >  	}
> > > >
> > > >  	/* Discover virtqueues and write information to configuration.  */
> > > > -	err = virtio_find_vqs(vdev, num_vqs, vqs, callbacks, names, &desc);
> > > > +	err = virtio_find_vqs(vdev, num_vqs, vqs, callbacks, names, NULL);
> > > >  	if (err)
> > > >  		goto out;
> > > >
> > > > --
> > > > 2.17.1
> 

