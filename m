Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A6E6EF402
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 14:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240798AbjDZMI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 08:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240644AbjDZMI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 08:08:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33ACE41
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 05:08:56 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682510934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XCqcamQq4Zyq9k2WUbejlCEtJ2lPQeWzu5/VlCA/Ec0=;
        b=OND8DEJ3JzN8Y0rrflWW9AvXlqxDtFV0erfX0JgMS3uyfaRnrUV8Z/j2hTzKBfQKx+gdo3
        8Du4mfK7NM90FvIgda3KmVFHv3s9tK5Qp/cGioFxtRo4oB3iIoizqFSUH8SejKXXp1q6pW
        63KWtI5oR4fBrnMFgpuHzGLK8jgn+68QtEhUnxRMkcrbfxaHG8ttsz40ZD4g53MUPT8Zbj
        k19bYdV+HaoqmZk4j9Sxng5M8xkLhUYSX/zYMEka7qzr3x9XVXhTEdk+s8YxN1Z2MECAaM
        kOri3v7OeAmcnzgAp2y2daiH8ko9l4vYZTCpHlc/BDvLdfYrPDVh9PCWBtg0eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682510934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XCqcamQq4Zyq9k2WUbejlCEtJ2lPQeWzu5/VlCA/Ec0=;
        b=khWgThSxPsOMTRdxvyiZCo2+aH/yvKoepdPwS0T6vk3pB1aQTn1uozjLcIfYRElWxDYpq2
        dVFEabdYuxrgUhAw==
To:     kernel test robot <yujie.liu@intel.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Walle <michael@walle.cc>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Vikram Sethi <vsethi@nvidia.com>
Subject: Re: [PATCH v3 3/3] genirq: Use the maple tree for IRQ descriptors
 management
In-Reply-To: <202304251035.19367560-yujie.liu@intel.com>
References: <202304251035.19367560-yujie.liu@intel.com>
Date:   Wed, 26 Apr 2023 14:08:54 +0200
Message-ID: <87a5yuzvzd.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25 2023 at 11:16, kernel test robot wrote:
> kernel test robot noticed "WARNING:at_arch/x86/kernel/apic/ipi.c:#default_send_IPI_mask_logical" on:
>
> commit: 13eb5c4e7d2fb860d3dc5f63d910e3acf78dfd28 ("[PATCH v3 3/3] genirq: Use the maple tree for IRQ descriptors management")
> url: https://github.com/intel-lab-lkp/linux/commits/Shanker-Donthineni/genirq-Use-hlist-for-managing-resend-handlers/20230410-235853
> base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 6f3ee0e22b4c62f44b8fa3c8de6e369a4d112a75
> patch link: https://lore.kernel.org/all/20230410155721.3720991-4-sdonthineni@nvidia.com/
> patch subject: [PATCH v3 3/3] genirq: Use the maple tree for IRQ
> descriptors management

This happens during CPU hot-unplug.

[  206.930774][  T228] block/008 => sdb2 (do IO while hotplugging CPUs)            
[  206.935757][ T2086] run blktests block/008 at 2023-04-22 16:27:25
[  207.199359][ T2086] smpboot: CPU 2 is now offline

[  207.468574][   T30] WARNING: CPU: 3 PID: 30 at arch/x86/kernel/apic/ipi.c:299 default_send_IPI_mask_logical+0x40/0x44
[  207.568426][   T30] CPU: 3 PID: 30 Comm: migration/3 Tainted: G S          E      6.2.0-rc4-00051-g13eb5c4e7d2f #1
[  207.588372][   T30] Stopper: multi_cpu_stop+0x0/0xf0 <- stop_machine_cpuslocked+0xf5/0x138
[  207.596649][   T30] EIP: default_send_IPI_mask_logical+0x40/0x44

This warns because fixup_irqs() sends an IPI to an offline CPU. In this
case to CPU3 which just cleared its online bit and is about to vanish:

[  207.622147][   T30] EAX: 00000008 EBX: 00000002 ECX: fffffffc EDX: 00000022

EAX contains the target and ECX the inverted online mask. That's
probably the ata2 interrupt as that later detects a timeout:

[  238.826212][  T174] ata2.00: exception Emask 0x0 SAct 0x3c00000 SErr 0x0 action 0x6 frozen
[  238.834522][  T174] ata2.00: failed command: READ FPDMA QUEUED
[  238.840378][  T174] ata2.00: cmd 60/08:b0:90:3e:90/00:00:25:00:00/40 tag 22 ncq dma 4096 in
[  238.840378][  T174]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)

Which means that migrating the interrupt away from the outgoing CPU3
failed for yet to understand reasons.

The patch in question is changing the interrupt descriptor storage and
with that also the iterator function. But I can't spot anything wrong
right now.

But what I can spot is this:

[    0.000000][    T0] Linux version 6.2.0-rc4-00051-g13eb5c4e7d2f

IOW, that test is based on some random upstream version, which lacks
about 30 commits to maple_tree, where 12 of them have 'fix' in the
commit subject.

Can you please retest this on v6.3 and report back when the problem
persists?

Thanks,

        tglx


