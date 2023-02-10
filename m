Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B8A6924C3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 18:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbjBJRqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 12:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjBJRqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 12:46:51 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7401E93D4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 09:46:48 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3A532F4;
        Fri, 10 Feb 2023 09:47:30 -0800 (PST)
Received: from [192.168.122.164] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24D4B3F71E;
        Fri, 10 Feb 2023 09:46:43 -0800 (PST)
Message-ID: <f6452cdd-65ff-34b8-bab0-5c06416da5f6@arm.com>
Date:   Fri, 10 Feb 2023 11:46:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Marc Zyngier <marc.zyngier@arm.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Subject: Circular lockdep in kvm_reset_vcpu() ?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I saw this pop yesterday:

[   78.333360] ======================================================
[   78.339541] WARNING: possible circular locking dependency detected
[   78.345721] 6.2.0-rc7+ #19 Not tainted
[   78.349470] ------------------------------------------------------
[   78.355647] qemu-system-aar/859 is trying to acquire lock:
[   78.361130] ffff5aa69269eba0 (&host_kvm->lock){+.+.}-{3:3}, at: 
kvm_reset_vcpu+0x34/0x274
[   78.369344]
[   78.369344] but task is already holding lock:
[   78.375182] ffff5aa68768c0b8 (&vcpu->mutex){+.+.}-{3:3}, at: 
kvm_vcpu_ioctl+0x8c/0xba0
[   78.383133]
[   78.383133] which lock already depends on the new lock.
[   78.383133]
[   78.391318]
[   78.391318] the existing dependency chain (in reverse order) is:
[   78.398811]
[   78.398811] -> #1 (&vcpu->mutex){+.+.}-{3:3}:
[   78.404682]        __lock_acquire+0x480/0x9c0
[   78.409068]        lock_acquire.part.0+0xf0/0x240
[   78.413806]        lock_acquire+0xa8/0x204
[   78.417934]        __mutex_lock+0xac/0x460
[   78.422053]        mutex_lock_nested+0x34/0x40
[   78.426517]        kvm_vm_ioctl_create_vcpu+0x17c/0x474
[   78.431768]        kvm_vm_ioctl+0x67c/0xb00
[   78.435966]        __arm64_sys_ioctl+0xb4/0x100
[   78.440516]        invoke_syscall+0x78/0xfc
[   78.444714]        el0_svc_common.constprop.0+0x68/0x124
[   78.450044]        do_el0_svc+0x34/0x4c
[   78.453892]        el0_svc+0x50/0x140
[   78.457571]        el0t_64_sync_handler+0xf4/0x120
[   78.462381]        el0t_64_sync+0x194/0x198
[   78.466580]
[   78.466580] -> #0 (&host_kvm->lock){+.+.}-{3:3}:
[   78.472714]        check_prev_add+0xa4/0x8d4
[   78.477005]        validate_chain+0x420/0x590
[   78.481381]        __lock_acquire+0x480/0x9c0
[   78.485759]        lock_acquire.part.0+0xf0/0x240
[   78.490483]        lock_acquire+0xa8/0x204
[   78.494598]        __mutex_lock+0xac/0x460
[   78.498711]        mutex_lock_nested+0x34/0x40
[   78.503171]        kvm_reset_vcpu+0x34/0x274
[   78.507461]        kvm_vcpu_set_target+0x10c/0x154
[   78.512274]        kvm_arch_vcpu_ioctl_vcpu_init+0x20/0xf0
[   78.517782]        kvm_arch_vcpu_ioctl+0x398/0x550
[   78.522595]        kvm_vcpu_ioctl+0x5f8/0xba0
[   78.526973]        __arm64_sys_ioctl+0xb4/0x100
[   78.531522]        invoke_syscall+0x78/0xfc
[   78.535719]        el0_svc_common.constprop.0+0x68/0x124
[   78.541048]        do_el0_svc+0x34/0x4c
[   78.544897]        el0_svc+0x50/0x140
[   78.548574]        el0t_64_sync_handler+0xf4/0x120
[   78.553384]        el0t_64_sync+0x194/0x198
[   78.557581]
[   78.557581] other info that might help us debug this:
[   78.557581]
[   78.565606]  Possible unsafe locking scenario:
[   78.565606]
[   78.571541]        CPU0                    CPU1
[   78.576080]        ----                    ----
[   78.580606]   lock(&vcpu->mutex);
[   78.583922]                                lock(&host_kvm->lock);
[   78.590017]                                lock(&vcpu->mutex);
[   78.595851]   lock(&host_kvm->lock);
[   78.599426]
[   78.599426]  *** DEADLOCK ***
[   78.599426]
[   78.605344] 1 lock held by qemu-system-aar/859:
[   78.609873]  #0: ffff5aa68768c0b8 (&vcpu->mutex){+.+.}-{3:3}, at: 
kvm_vcpu_ioctl+0x8c/0xba0
[   78.618245]
[   78.618245] stack backtrace:
[   78.622599] CPU: 1 PID: 859 Comm: qemu-system-aar Not tainted 
6.2.0-rc7+ #19
[   78.629650] Hardware name: Raspberry Pi Foundation Raspberry Pi 4 
Model B/Raspberry Pi 4 Model B, BIOS EDK2-DEV 11/07/2022
[   78.640696] Call trace:
[   78.643137]  dump_backtrace+0xe8/0x140
[   78.646885]  show_stack+0x20/0x30
[   78.650197]  dump_stack_lvl+0x88/0xb4
[   78.653858]  dump_stack+0x18/0x34
[   78.657171]  print_circular_bug+0x1f8/0x200
[   78.661355]  check_noncircular+0x13c/0x150
[   78.665451]  check_prev_add+0xa4/0x8d4
[   78.669199]  validate_chain+0x420/0x590
[   78.673035]  __lock_acquire+0x480/0x9c0
[   78.676871]  lock_acquire.part.0+0xf0/0x240
[   78.681055]  lock_acquire+0xa8/0x204
[   78.684629]  __mutex_lock+0xac/0x460
[   78.688203]  mutex_lock_nested+0x34/0x40
[   78.692124]  kvm_reset_vcpu+0x34/0x274
[   78.695873]  kvm_vcpu_set_target+0x10c/0x154
[   78.700144]  kvm_arch_vcpu_ioctl_vcpu_init+0x20/0xf0
[   78.705110]  kvm_arch_vcpu_ioctl+0x398/0x550
[   78.709380]  kvm_vcpu_ioctl+0x5f8/0xba0
[   78.713217]  __arm64_sys_ioctl+0xb4/0x100
[   78.717225]  invoke_syscall+0x78/0xfc
[   78.720885]  el0_svc_common.constprop.0+0x68/0x124
[   78.725674]  do_el0_svc+0x34/0x4c
[   78.728986]  el0_svc+0x50/0x140
[   78.732126]  el0t_64_sync_handler+0xf4/0x120
[   78.736395]  el0t_64_sync+0x194/0x198


It appears to be triggered by the new commit 42a90008f890a ('KVM: Ensure 
lockdep knows about kvm->lock vs. vcpu->mutex ordering rule') which is 
detecting the vcpu lock grabbed by kvm_vcpu_ioctl() and then the kvm 
mutext grabbed by kvm_reset_vcpu().

This is 6.2rc7 configured for fedora-debug and qemu on the rpi4.

Thanks,
