Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF3A71A3B5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbjFAQFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbjFAQFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:05:40 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60518194
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 09:05:33 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-62614a2ce61so9690566d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 09:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685635532; x=1688227532;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WpSLy8MPIf+Dviq+rHrcXwl6jU6/m0OleOhPeH+wFGw=;
        b=OnSPTXA0Vt60IcaLHX3dMQN87EUTqlBi3IqWloklJzBp6NVioqi9xaitoY6bGzurEO
         hsWNDHTDUhmldXCGmd+6GRVwBuTKyZYJlbUkYpOGI+swJz4YDqOvx9OIsqgIccsBXQ7u
         I1c+YXyBmx8GQgKRlJMjEu9UqUdiDzgf0OGwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685635532; x=1688227532;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WpSLy8MPIf+Dviq+rHrcXwl6jU6/m0OleOhPeH+wFGw=;
        b=aX7TE0qYYO3raXOSWihGjwUP4SwDGgx1u55j6kQXQVYNJPAryCUPt7qnU8dUdh7Qyb
         TDlkNxnNQIR2NkD/ku2rv7gvlHBG85M0mhrv9s2aXlstyCtgMQCoIpWPXXkYNtzwCefd
         z0+NWM1EEbHhEYboZ+fIX9vq9rdRTR916mOF9EgweQgf9z83KnycyJtlGntH0l328+Iq
         lph5klUtTqp/6VRkjZj22GAwKnuxm/J9OW9bdV8Ja7+rhkTiWmDauTn3tTi3s+0MZ6aa
         L8SnoVJgZtvNegnxFgxWk/nmdYC4B1JkB1Bm8Dl13+6s8B0Xpt3i3y1/a2s9+k7wY+JA
         3BbQ==
X-Gm-Message-State: AC+VfDxpmCHozPIQAb/ViyWfL3z0+dYdDzbF4kyhzm0+ScR6wQQx36w0
        EsOPf2K9UJeC/YBdHEKWyPagSLB1BuHbGdpMdH2L0A==
X-Google-Smtp-Source: ACHHUZ5EhsH/lJ1rt3K6+fNLu+NEhVrLyHWXLGUP8O+lhV1tprzVmAoGl0Shnn0wwEmtM7eKiXnGzA==
X-Received: by 2002:a05:6214:1944:b0:626:198b:3481 with SMTP id q4-20020a056214194400b00626198b3481mr14459747qvk.62.1685635531811;
        Thu, 01 Jun 2023 09:05:31 -0700 (PDT)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com. [209.85.219.52])
        by smtp.gmail.com with ESMTPSA id pr2-20020a056214140200b006238d903f9bsm7716985qvb.42.2023.06.01.09.05.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 09:05:31 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-62606e67c0dso9710496d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 09:05:30 -0700 (PDT)
X-Received: by 2002:a05:6214:2487:b0:621:83d:3a47 with SMTP id
 gi7-20020a056214248700b00621083d3a47mr11839100qvb.39.1685635530343; Thu, 01
 Jun 2023 09:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230531-xhci-deadlock-v1-1-57780bff5124@chromium.org> <14d94fa1-1499-de1f-c924-9b823a606580@linux.intel.com>
In-Reply-To: <14d94fa1-1499-de1f-c924-9b823a606580@linux.intel.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 1 Jun 2023 18:05:19 +0200
X-Gmail-Original-Message-ID: <CANiDSCuTYRUfW8tLbPDq3dE+F7Wno5oc4C9qESMmTpaNyW-54Q@mail.gmail.com>
Message-ID: <CANiDSCuTYRUfW8tLbPDq3dE+F7Wno5oc4C9qESMmTpaNyW-54Q@mail.gmail.com>
Subject: Re: [PATCH] xhci: Do not create endpoint debugfs while holding the
 bandwidth mutex
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathias

On Thu, 1 Jun 2023 at 16:13, Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
> On 31.5.2023 15.40, Ricardo Ribalda Delgado wrote:
> > xhci_debugfs_create_endpoint needs to take the mm->mmap_sem, which is
> > not serialized with the hcd->bandwidth_mutex across the codebase.
> >
> > Without this patch a deadlock has been observed with the uvc driver at
> > the functions v4l2_mmap() and usb_set_interface().
> >
> > Cc: Stephen Boyd <swboyd@chromium.org
> > Fixes: 167657a1bb5f ("xhci: don't create endpoint debugfs entry before ring buffer is set.")
> > Signed-off-by: Ricardo Ribalda Delgado <ribalda@chromium.org>
> > ---
> > I do not have a proper reproducer for this and I am not used to this
> > subsystem, so please take a careful look at this patch :).
> >
> > Thanks!
>
> Do you still have the lockdep output showing the deadlock?

[  459.731142] ======================================================
[  459.731150] WARNING: possible circular locking dependency detected
[  459.731161] 5.4.169-lockdep-17434-g505c8a10e6fe #1 Not tainted
[  459.731168] ------------------------------------------------------
[  459.731176] syz-executor.3/15308 is trying to acquire lock:
[  459.731184] ffffff80c63e0ee0 (&queue->mutex){+.+.}, at:
uvc_queue_mmap+0x30/0xa0 [uvcvideo]
[  459.731226]
               but task is already holding lock:
[  459.731232] ffffff80a748eea8 (&mm->mmap_sem){++++}, at:
vm_mmap_pgoff+0x10c/0x1f4
[  459.731255]
               which lock already depends on the new lock.

[  459.731262]
               the existing dependency chain (in reverse order) is:
[  459.731269]
               -> #3 (&mm->mmap_sem){++++}:
[  459.731286]        __might_fault+0xec/0x150
[  459.731298]        filldir64+0x2e0/0x15dc
[  459.731310]        dcache_readdir+0x134/0x660
[  459.731320]        iterate_dir+0x200/0x40c
[  459.731331]        ksys_getdents64+0x218/0x78c
[  459.731342]        __arm64_sys_getdents64+0x7c/0x90
[  459.731353]        el0_svc_common+0x1c0/0x3dc
[  459.731363]        el0_svc_compat_handler+0x88/0xd4
[  459.731373]        el0_svc_compat+0x8/0x2c
[  459.731379]
               -> #2 (&sb->s_type->i_mutex_key#4){++++}:
[  459.731398]        down_write+0x60/0x118
[  459.731409]        start_creating+0xf8/0x260
[  459.731419]        debugfs_create_dir+0x30/0x290
[  459.731430]        xhci_debugfs_create_endpoint+0x118/0x1c8
[  459.731442]        xhci_check_bandwidth+0x520/0x6c0
[  459.731453]        usb_hcd_alloc_bandwidth+0x800/0x900
[  459.731464]        usb_set_configuration+0x4c4/0x1258
[  459.731475]        usb_generic_driver_probe+0x80/0x140
[  459.731486]        usb_probe_device+0xc8/0x240
[  459.731497]        really_probe+0x2f0/0x9e4
[  459.731507]        driver_probe_device+0xf0/0x2e4
[  459.731517]        __device_attach_driver+0x180/0x254
[  459.731528]        bus_for_each_drv+0x114/0x184
[  459.731537]        __device_attach+0x224/0x398
[  459.731547]        device_initial_probe+0x24/0x30
[  459.731557]        bus_probe_device+0xa8/0x1b8
[  459.731567]        device_add+0x63c/0x940
[  459.731577]        usb_new_device+0x810/0xe68
[  459.731587]        hub_port_connect+0xaf0/0x16bc
[  459.731597]        hub_port_connect_change+0x32c/0x5c0
[  459.731606]        port_event+0x9e8/0xe4c
[  459.731616]        hub_event+0x3fc/0xaec
[  459.731628]        process_one_work+0x604/0xa2c
[  459.731638]        worker_thread+0x930/0xea8
[  459.731648]        kthread+0x2dc/0x350
[  459.731658]        ret_from_fork+0x10/0x18
[  459.731664]
               -> #1 (hcd->bandwidth_mutex){+.+.}:
[  459.731680]        __mutex_lock_common+0x140/0x18c8
[  459.731690]        mutex_lock_nested+0x48/0x58
[  459.731701]        usb_set_interface+0x108/0x778
[  459.731724]        uvc_video_start_transfer+0x824/0x12a4 [uvcvideo]
[  459.731746]        uvc_video_start_streaming+0x148/0x2c8 [uvcvideo]
[  459.731767]        uvc_start_streaming+0x108/0x214 [uvcvideo]
[  459.731779]        vb2_start_streaming+0x110/0x3f0
[  459.731789]        vb2_core_streamon+0x234/0x340
[  459.731799]        vb2_streamon+0x80/0xac
[  459.731819]        uvc_queue_streamon+0x3c/0x5c [uvcvideo]
[  459.731840]        uvc_ioctl_streamon+0xd0/0x118 [uvcvideo]
[  459.731850]        v4l_streamon+0x6c/0x9c
[  459.731860]        __video_do_ioctl+0x940/0xaa8
[  459.731870]        video_usercopy+0x528/0x920
[  459.731880]        video_ioctl2+0x3c/0x4c
[  459.731889]        v4l2_ioctl+0x120/0x158
[  459.731900]        do_video_ioctl+0xdec/0x1784
[  459.731910]        v4l2_compat_ioctl32+0xc0/0x198
[  459.731921]        __arm64_compat_sys_ioctl+0x314/0x778
[  459.731931]        el0_svc_common+0x1c0/0x3dc
[  459.731941]        el0_svc_compat_handler+0x88/0xd4
[  459.731950]        el0_svc_compat+0x8/0x2c
[  459.731957]
               -> #0 (&queue->mutex){+.+.}:
[  459.731974]        __lock_acquire+0x1b74/0x4f04
[  459.731985]        lock_acquire+0xd0/0x168
[  459.731995]        __mutex_lock_common+0x140/0x18c8
[  459.732004]        mutex_lock_nested+0x48/0x58
[  459.732024]        uvc_queue_mmap+0x30/0xa0 [uvcvideo]
[  459.732045]        uvc_v4l2_mmap+0xa4/0x138 [uvcvideo]
[  459.732054]        v4l2_mmap+0x114/0x1f8
[  459.732065]        mmap_region+0x8b8/0xc90
[  459.732075]        do_mmap+0x654/0xaec
[  459.732084]        vm_mmap_pgoff+0x15c/0x1f4
[  459.732094]        ksys_mmap_pgoff+0x124/0x194
[  459.732105]        __arm64_compat_sys_aarch32_mmap2+0xd8/0xf0
[  459.732114]        el0_svc_common+0x1c0/0x3dc
[  459.732124]        el0_svc_compat_handler+0x88/0xd4
[  459.732134]        el0_svc_compat+0x8/0x2c
[  459.732141]
               other info that might help us debug this:

[  459.732148] Chain exists of:
                 &queue->mutex --> &sb->s_type->i_mutex_key#4 --> &mm->mmap_sem

[  459.732165]  Possible unsafe locking scenario:

[  459.732172]        CPU0                    CPU1
[  459.732178]        ----                    ----
[  459.732184]   lock(&mm->mmap_sem);
[  459.732193]                                lock(&sb->s_type->i_mutex_key#4);
[  459.732204]                                lock(&mm->mmap_sem);
[  459.732212]   lock(&queue->mutex);
[  459.732221]
                *** DEADLOCK ***

[  459.732230] 1 lock held by syz-executor.3/15308:
[  459.732237]  #0: ffffff80a748eea8 (&mm->mmap_sem){++++}, at:
vm_mmap_pgoff+0x10c/0x1f4
[  459.732256]
               stack backtrace:
[  459.732269] CPU: 6 PID: 15308 Comm: syz-executor.3 Not tainted
5.4.169-lockdep-17434-g505c8a10e6fe #1
[  459.732277] Hardware name: Google Pazquel (TI,LTE) (DT)
[  459.732284] Call trace:
[  459.732294]  dump_backtrace+0x0/0x2ec
[  459.732304]  show_stack+0x24/0x30
[  459.732315]  dump_stack+0x148/0x21c
[  459.732324]  print_circular_bug+0x18c/0x1b8
[  459.732334]  check_noncircular+0x2e4/0x3c4
[  459.732344]  __lock_acquire+0x1b74/0x4f04
[  459.732355]  lock_acquire+0xd0/0x168
[  459.732364]  __mutex_lock_common+0x140/0x18c8
[  459.732374]  mutex_lock_nested+0x48/0x58
[  459.732395]  uvc_queue_mmap+0x30/0xa0 [uvcvideo]
[  459.732415]  uvc_v4l2_mmap+0xa4/0x138 [uvcvideo]
[  459.732425]  v4l2_mmap+0x114/0x1f8
[  459.732435]  mmap_region+0x8b8/0xc90
[  459.732444]  do_mmap+0x654/0xaec
[  459.732454]  vm_mmap_pgoff+0x15c/0x1f4
[  459.732463]  ksys_mmap_pgoff+0x124/0x194
[  459.732474]  __arm64_compat_sys_aarch32_mmap2+0xd8/0xf0
[  459.732483]  el0_svc_common+0x1c0/0x3dc
[  459.732493]  el0_svc_compat_handler+0x88/0xd4
[  459.732502]  el0_svc_compat+0x8/0x2c


>
> I'm not sure how calling xhci_debugfs_create_endpoint() from
> xhci_add_endpoint() instead of xhci_check_bandwidth() helps.
>
> Both are called with hcd->bandwidth_mutex held:
>
> usb_set_interface()
>         mutex_lock(hcd->bandwidth_mutex);
>         usb_hcd_alloc_bandwidth()
>                 hcd->driver->add_endpoint()    -> xhci_add_endpoint()
>                 hcd->driver->check_bandwidth() -> xhci_check_bandwidth()
>         mutex_unlock(hcd->bandwidth_mutex);

Yep, I guess I was lucky not to be able to repro again :)

The locks involved are:

hcd->bandwidth_mutex
mm->mmap_sem
[uvc] queue->mutex



>
> Thanks
> Mathias
>


-- 
Ricardo Ribalda
