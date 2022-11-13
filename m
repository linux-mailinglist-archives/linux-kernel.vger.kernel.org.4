Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E5A62729F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 21:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbiKMUsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 15:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235411AbiKMUs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 15:48:28 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C981FCF8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 12:48:27 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-13bd19c3b68so10684792fac.7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 12:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A+FqJCQj3cxcBSnjLAJDzR2+3n1zYLnsgtHBpABoNnQ=;
        b=D1Fxb6u/rIa6zUsRamAj+tUHDp/UiMRsW1vdPDCvxJb+rkdm1z+VCXXMfr9mHq3DZo
         hxYwo5gjCEWlm6kEltYGgqSiBB5qhvnzzCX5XGMjpsn3rTGjLnn/su6E9DEj88+y5FsO
         J+3vt7fuLw5epBHtKqDmWKoTi8aa1jr/DpF3IQ0WOGBIF1KuWhTd399sNvPyEGlTOMxM
         yTECGoouiveS7oNPC8+WB6fq9H26ll0rkleWMjeNIp+pX8AEWioLQLDlFX2ghXcgfr95
         JHbnwcG7NC/pa0S0xFHYGfrnRqTcQPmFRl8twMTzS1X+r1HnfgtbFwKufiPYeHzElJBP
         husA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A+FqJCQj3cxcBSnjLAJDzR2+3n1zYLnsgtHBpABoNnQ=;
        b=Z4uH5EexLTR7ETtoX301+6x1Z7X38H+EsfkJMTy2eJcTaD+mxrXndW85UhaSjHSbXQ
         E4gby9mKVciyl0Z6ehB9pR5wWlKl8gsJ9nuKg53wYOLml7eb/p4Ar+3Kz0vKRevL8eLi
         yHBQanfHN1pEz9846xV9KvnCNsTr/DnaYY0Iv3OPW9yvC0C6gNp0MNl3lIwvBOBVBloJ
         svq9gDbC70EYyMmKp6T6WdLC4L48yMAbaOeYcwX/itjqPEhXAQsI40Z/QIwpGqdVRRlw
         KfPBM4PK1EHG1Ej+xVWsRsxwcDL7rCyIg3z2EX8aXsXruN1QYPaFDgDW1N0NRN4gtu3C
         8v3w==
X-Gm-Message-State: ANoB5pnPAKB0GikPYzWPHqqqUPB9kKSDQcuN8pfAwpxa1Jysv+J2ennv
        YpXAjds5UFdc6yaaQoLqNzy9ySJrOxablfbEZBbF3w==
X-Google-Smtp-Source: AA0mqf47dX7RN8qqGSzmJeDvNjmCCRtkgWjGs+Hj0Kp3Oys9ObMoe8KAdWDXf/SjvuyXtISbRT/yJLTRRjA4Hg66bNk=
X-Received: by 2002:a05:6870:1117:b0:13d:a22b:3503 with SMTP id
 23-20020a056870111700b0013da22b3503mr5503729oaf.233.1668372506826; Sun, 13
 Nov 2022 12:48:26 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+bJiZgT1W4JY+X=aZjbg8+X2fw7j2pxH_Hke_yn7R0Qnw@mail.gmail.com>
In-Reply-To: <CACT4Y+bJiZgT1W4JY+X=aZjbg8+X2fw7j2pxH_Hke_yn7R0Qnw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 13 Nov 2022 21:48:16 +0100
Message-ID: <CACT4Y+YFtMzmDyHH8Uf2Q69xBAP6gVg+hN2Gz-+cj=K79U8okg@mail.gmail.com>
Subject: Re: dealock in drm_fb_helper_damage_work
To:     Dave Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        DRI <dri-devel@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        dmitry.osipenko@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Nov 2022 at 21:42, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> Hi,
>
> I am getting the following deadlock on reservation_ww_class_mutex
> while trying to boot next-20221111 kernel:

The code is recently added by this commit:

commit 79e2cf2e7a193473dfb0da3b9b869682b43dc60f
Author: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Date:   Mon Oct 17 20:22:11 2022 +0300
    drm/gem: Take reservation lock for vmap/vunmap operations

> ============================================
> WARNING: possible recursive locking detected
> 6.1.0-rc4-next-20221111 #193 Not tainted
> --------------------------------------------
> kworker/4:1/81 is trying to acquire lock:
> ffff88812ebe89a8 (reservation_ww_class_mutex){+.+.}-{3:3}, at:
> dma_resv_lock_interruptible include/linux/dma-resv.h:372 [inline]
> ffff88812ebe89a8 (reservation_ww_class_mutex){+.+.}-{3:3}, at:
> ttm_bo_reserve include/drm/ttm/ttm_bo_driver.h:121 [inline]
> ffff88812ebe89a8 (reservation_ww_class_mutex){+.+.}-{3:3}, at:
> drm_gem_vram_vmap+0xa4/0x590 drivers/gpu/drm/drm_gem_vram_helper.c:436
>
> but task is already holding lock:
> ffff88812ebe89a8 (reservation_ww_class_mutex){+.+.}-{3:3}, at:
> dma_resv_lock include/linux/dma-resv.h:345 [inline]
> ffff88812ebe89a8 (reservation_ww_class_mutex){+.+.}-{3:3}, at:
> drm_gem_vmap_unlocked+0x3f/0xa0 drivers/gpu/drm/drm_gem.c:1195
>
> other info that might help us debug this:
>  Possible unsafe locking scenario:
>
>        CPU0
>        ----
>   lock(reservation_ww_class_mutex);
>   lock(reservation_ww_class_mutex);
>
>  *** DEADLOCK ***
>
>  May be due to missing lock nesting notation
>
> 4 locks held by kworker/4:1/81:
>  #0: ffff888100078d38 ((wq_completion)events){+.+.}-{0:0}, at:
> arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
>  #0: ffff888100078d38 ((wq_completion)events){+.+.}-{0:0}, at:
> arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
>  #0: ffff888100078d38 ((wq_completion)events){+.+.}-{0:0}, at:
> atomic_long_set include/linux/atomic/atomic-instrumented.h:1280
> [inline]
>  #0: ffff888100078d38 ((wq_completion)events){+.+.}-{0:0}, at:
> set_work_data kernel/workqueue.c:636 [inline]
>  #0: ffff888100078d38 ((wq_completion)events){+.+.}-{0:0}, at:
> set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
>  #0: ffff888100078d38 ((wq_completion)events){+.+.}-{0:0}, at:
> process_one_work+0x8e4/0x1720 kernel/workqueue.c:2260
>  #1: ffffc9000694fda0
> ((work_completion)(&helper->damage_work)){+.+.}-{0:0}, at:
> process_one_work+0x918/0x1720 kernel/workqueue.c:2264
>  #2: ffff88812ebe8278 (&helper->lock){+.+.}-{3:3}, at:
> drm_fbdev_damage_blit drivers/gpu/drm/drm_fbdev_generic.c:312 [inline]
>  #2: ffff88812ebe8278 (&helper->lock){+.+.}-{3:3}, at:
> drm_fbdev_fb_dirty+0x30e/0xcd0 drivers/gpu/drm/drm_fbdev_generic.c:342
>  #3: ffff88812ebe89a8 (reservation_ww_class_mutex){+.+.}-{3:3}, at:
> dma_resv_lock include/linux/dma-resv.h:345 [inline]
>  #3: ffff88812ebe89a8 (reservation_ww_class_mutex){+.+.}-{3:3}, at:
> drm_gem_vmap_unlocked+0x3f/0xa0 drivers/gpu/drm/drm_gem.c:1195
>
> stack backtrace:
> CPU: 4 PID: 81 Comm: kworker/4:1 Not tainted 6.1.0-rc4-next-20221111 #193
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> Workqueue: events drm_fb_helper_damage_work
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x100/0x178 lib/dump_stack.c:106
>  print_deadlock_bug kernel/locking/lockdep.c:2990 [inline]
>  check_deadlock kernel/locking/lockdep.c:3033 [inline]
>  validate_chain kernel/locking/lockdep.c:3818 [inline]
>  __lock_acquire.cold+0x119/0x3b9 kernel/locking/lockdep.c:5055
>  lock_acquire kernel/locking/lockdep.c:5668 [inline]
>  lock_acquire+0x1e0/0x610 kernel/locking/lockdep.c:5633
>  __mutex_lock_common kernel/locking/mutex.c:603 [inline]
>  __ww_mutex_lock.constprop.0+0x1ba/0x2ee0 kernel/locking/mutex.c:754
>  ww_mutex_lock_interruptible+0x37/0x140 kernel/locking/mutex.c:886
>  dma_resv_lock_interruptible include/linux/dma-resv.h:372 [inline]
>  ttm_bo_reserve include/drm/ttm/ttm_bo_driver.h:121 [inline]
>  drm_gem_vram_vmap+0xa4/0x590 drivers/gpu/drm/drm_gem_vram_helper.c:436
>  drm_gem_vmap+0xc5/0x1b0 drivers/gpu/drm/drm_gem.c:1166
>  drm_gem_vmap_unlocked+0x4a/0xa0 drivers/gpu/drm/drm_gem.c:1196
>  drm_client_buffer_vmap+0x45/0xd0 drivers/gpu/drm/drm_client.c:326
>  drm_fbdev_damage_blit drivers/gpu/drm/drm_fbdev_generic.c:314 [inline]
>  drm_fbdev_fb_dirty+0x31e/0xcd0 drivers/gpu/drm/drm_fbdev_generic.c:342
>  drm_fb_helper_damage_work+0x27a/0x5d0 drivers/gpu/drm/drm_fb_helper.c:388
>  process_one_work+0xa33/0x1720 kernel/workqueue.c:2289
>  worker_thread+0x67d/0x10e0 kernel/workqueue.c:2436
>  kthread+0x2e4/0x3a0 kernel/kthread.c:376
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
>  </TASK>
>
> The config is:
> https://gist.githubusercontent.com/dvyukov/2897b21db809075a22db0370c495ed2d/raw/9b2535b2ba77bb57e4f1ba2b909ad4075b6e2c6a/gistfile1.txt
>
> Qemu command line:
> qemu-system-x86_64 -enable-kvm -machine q35,nvdimm -cpu
> max,migratable=off -smp 18 \
> -m 72G -hda buildroot-amd64-2021.08 -kernel arch/x86/boot/bzImage -nographic \
> -net user,host=10.0.2.10,hostfwd=tcp::10022-:22 -net nic,model=virtio-net-pci \
> -append "console=ttyS0 root=/dev/sda1 earlyprintk=serial rodata=n \
> oops=panic panic_on_warn=1 panic=86400 coredump_filter=0xffff"
