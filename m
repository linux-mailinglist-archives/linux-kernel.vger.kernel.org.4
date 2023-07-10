Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1D774CE1D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjGJHWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjGJHWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:22:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DD99D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688973691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jEfNU3mvKWLTx66KLJD7IWl55ixvFZkA0OwvpmJNf9U=;
        b=JgOdHE3qIh/76z+1L8P3Flr+mr0Y2bAIa0bgGxJ2FDd+2tD8jAfsZH2NyAo4Kkslw0269m
        SDmZ5LEuVPO37S4xMJxeV7iPQ0WLXYlATL86UnrYcREN1hnjQTzwJ3c25mveOr8CTUleMY
        s3UxwvAgYt9nhSs9xAAI9ZAC1SwsYtQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-ncqaY_sBP9Wp8RQLwfjQxA-1; Mon, 10 Jul 2023 03:21:30 -0400
X-MC-Unique: ncqaY_sBP9Wp8RQLwfjQxA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-635d9e482f1so47187216d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688973690; x=1691565690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEfNU3mvKWLTx66KLJD7IWl55ixvFZkA0OwvpmJNf9U=;
        b=BRSD6dkpWioOOKH+tRDoM3l6Gqg/DssmDo2OrM07zMnRTntVeGP10yqbycM70T8JA+
         TFzS4KV96w50+/c2WlNIQSwOBJvukUJbsTETzjznJwutKcs3gGrrzAW8EwfFcRXEqaBr
         l7cUyNqWut6Z3WR73Mk2Qp7+5rwTN9kLbg0NMAQc8pdCw9CM5CCzzpXGler/0AC+AuAF
         vxFefxtXa19xScinfl81tJCI24r/Mgw2jsU1Rr191+wMbZbi+7jpKyQ08BjecE+sX3Mk
         07H01EHtKae5ogG8pDJ75cuVo95eKEGEXVbzkJX9uKmtzkbgyUggVP8Ey1iv4yHHzOym
         87Qw==
X-Gm-Message-State: ABy/qLbTmMGyABgufV2M+LElS7ZO3SnlavukY5YDb27LTq5L72lWDSyg
        szZpjBEejfKAXYuD2OD7mVEjQBU79zspDD0ylDR5qS6R7MTC2/OjxQF/o0OwJDA+5HvnrEJyhPb
        Dp5NOBzgp40GBiYZaHIpXiyQZ6SZ20wPU
X-Received: by 2002:a0c:df90:0:b0:636:b633:9fd6 with SMTP id w16-20020a0cdf90000000b00636b6339fd6mr10623076qvl.17.1688973689958;
        Mon, 10 Jul 2023 00:21:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFNfYcRBHjYhKj1QikGAcGRp5e+PzgD9u/dm5HHUeQoUMkiA2Pt/L3p+zDXfFFfx2A0gdEsTw==
X-Received: by 2002:a0c:df90:0:b0:636:b633:9fd6 with SMTP id w16-20020a0cdf90000000b00636b6339fd6mr10623066qvl.17.1688973689613;
        Mon, 10 Jul 2023 00:21:29 -0700 (PDT)
Received: from localhost.localdomain ([176.206.37.158])
        by smtp.gmail.com with ESMTPSA id h11-20020a0cf40b000000b0062fffa42cc5sm5263903qvl.79.2023.07.10.00.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 00:21:28 -0700 (PDT)
Date:   Mon, 10 Jul 2023 09:21:25 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RT] i915 sleeping function from atomic in gen6_reset_engines()
Message-ID: <ZKuxdVJcsHdcbmYs@localhost.localdomain>
References: <Y86wDg/EZfJOnlwJ@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y86wDg/EZfJOnlwJ@localhost.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 23/01/23 17:04, Juri Lelli wrote:
> Hi,
> 
> I've just noticed the following while testing v6.2-rc3-rt1.

I'm still seeing the following on v6.4-rt6.

I believe 20211006164628.s2mtsdd2jdbfyf7g@linutronix.de should cure it,
but I don't think it did go anywhere?

> # lspci -k | grep -EA3 'VGA|3D|Display'
> 00:02.0 VGA compatible controller: Intel Corporation Xeon E3-1200 v3 Processor Integrated Graphics Controller (rev 06)
>         DeviceName:  Onboard IGD
>         Subsystem: Dell Device 0620
>         Kernel driver in use: i915
>  
> ---
> 
> [   11.960670] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
> [   11.960672] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 429, name: systemd-udevd
> [   11.960673] preempt_count: 1, expected: 0
> [   11.960674] RCU nest depth: 0, expected: 0
> [   11.960674] 2 locks held by systemd-udevd/429:
> [   11.960675]  #0: ffff8e1f022b71b0 (&dev->mutex){....}-{3:3}, at: __driver_attach+0xcb/0x1d0
> [   11.960684]  #1: ffff8e1e27d32ed8 (&uncore->lock){+.+.}-{2:2}, at: gen6_reset_engines+0x1b/0x50 [i915]
> [   11.960897] Preemption disabled at:
> [   11.960898] [<ffffffffc07d5d62>] __intel_gt_reset+0x92/0x100 [i915]
> [   11.961024] CPU: 3 PID: 429 Comm: systemd-udevd Not tainted 6.2.0-rc3-rt1 #1
> [   11.961025] Hardware name: Dell Inc. PowerEdge T20/0VD5HY, BIOS A03 11/25/2013
> [   11.961026] Call Trace:
> [   11.961027]  <TASK>
> [   11.961029]  ? __intel_gt_reset+0x92/0x100 [i915]
> [   11.961155]  dump_stack_lvl+0x57/0x81
> [   11.961160]  __might_resched.cold+0xf4/0x12f
> [   11.961165]  rt_spin_lock+0x4a/0xe0
> [   11.961169]  ? gen6_reset_engines+0x1b/0x50 [i915]
> [   11.961294]  ? __pfx_gen6_reset_engines+0x10/0x10 [i915]
> [   11.961453]  gen6_reset_engines+0x1b/0x50 [i915]
> [   11.961579]  __intel_gt_reset+0xa0/0x100 [i915]
> [   11.961708]  i915_driver_mmio_probe+0x126/0x220 [i915]
> [   11.961815]  ? intel_gt_probe_all+0x70/0x280 [i915]
> [   11.961939]  i915_driver_probe+0xd4/0x3c0 [i915]
> [   11.962047]  ? i915_pci_probe+0x87/0x1b0 [i915]
> [   11.962160]  local_pci_probe+0x45/0x80
> [   11.962167]  pci_call_probe+0x56/0x170
> [   11.962173]  pci_device_probe+0x79/0xf0
> [   11.962175]  ? driver_sysfs_add+0x73/0xd0
> [   11.962179]  really_probe+0xe1/0x390
> [   11.962181]  ? pm_runtime_barrier+0x50/0x90
> [   11.962187]  __driver_probe_device+0x78/0x180
> [   11.962191]  driver_probe_device+0x1e/0x90
> [   11.962195]  __driver_attach+0xd6/0x1d0
> [   11.962197]  ? __pfx___driver_attach+0x10/0x10
> [   11.962201]  bus_for_each_dev+0x7b/0xc0
> [   11.962206]  bus_add_driver+0x1b2/0x200
> [   11.962212]  driver_register+0x8f/0xf0
> [   11.962215]  i915_init+0x20/0x80 [i915]
> [   11.962337]  ? __pfx_init_module+0x10/0x10 [i915]
> [   11.962461]  do_one_initcall+0x47/0x190
> [   11.962467]  ? rcu_read_lock_sched_held+0x43/0x80
> [   11.962471]  ? trace_kmalloc+0x3c/0x160
> [   11.962473]  ? kmalloc_trace+0x44/0x60
> [   11.962476]  do_init_module+0x4c/0x200
> [   11.962480]  __do_sys_finit_module+0xb4/0x130
> [   11.962497]  do_syscall_64+0x5c/0x90
> [   11.962505]  ? do_syscall_64+0x69/0x90
> [   11.962507]  ? lockdep_hardirqs_on+0x79/0x100
> [   11.962511]  ? do_syscall_64+0x69/0x90
> [   11.962513]  ? do_syscall_64+0x69/0x90
> [   11.962515]  ? lockdep_hardirqs_on+0x79/0x100
> [   11.962518]  ? do_syscall_64+0x69/0x90
> [   11.962520]  ? lockdep_hardirqs_on+0x79/0x100
> [   11.962523]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [   11.962526] RIP: 0033:0x7fa35d020e5d
> [   11.962529] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89
>                      d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73
> 		     01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
> [   11.962530] RSP: 002b:00007ffd62f23a78 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> [   11.962532] RAX: ffffffffffffffda RBX: 000056058a1429e0 RCX: 00007fa35d020e5d
> [   11.962533] RDX: 0000000000000000 RSI: 00007fa35d25232c RDI: 0000000000000017
> [   11.962534] RBP: 0000000000020000 R08: 0000000000000000 R09: 0000000000000002
> [   11.962534] R10: 0000000000000017 R11: 0000000000000246 R12: 00007fa35d25232c
> [   11.962535] R13: 000056058a147360 R14: 0000000000000007 R15: 000056058a12b790
> [   11.962548]  </TASK>
> [   11.964024] i915 0000:00:02.0: vgaarb: deactivate vga console
> [   11.974095] Console: switching to colour dummy device 80x25
> [   11.981308] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
> [   12.041808] [drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on minor 0
> 
> ---

Thanks,
Juri

