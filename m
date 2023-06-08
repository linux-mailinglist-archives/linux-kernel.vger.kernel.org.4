Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5868727F93
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbjFHMCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 08:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjFHMCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:02:10 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A221FD5
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 05:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1686225730; x=1717761730;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8rQt5sb+SnoZ1UdA02p3GMjDXxrIX+iZxf+jpM8LHPw=;
  b=awvETnF3J9/6VPlaqX3hUuCGKJIHxtoZtAvs7KoVTaYJrlp5WOUd1HxA
   cAU7qPwDVNmsjn5u+mJKNYy9jimtkfRj9N/AGLODXwc/dYC0dBqK0TmdH
   RErzNx3ebpkroaUH+eeGfXx9k+coBGa2WhPneHsS7Uz1aWxNMf+1CH/39
   8=;
X-IronPort-AV: E=Sophos;i="6.00,226,1681171200"; 
   d="scan'208";a="219684897"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-d23e07e8.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 12:02:07 +0000
Received: from EX19D014EUC004.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-m6i4x-d23e07e8.us-east-1.amazon.com (Postfix) with ESMTPS id 2A79280D9F;
        Thu,  8 Jun 2023 12:02:04 +0000 (UTC)
Received: from u5d18b891348c5b.ant.amazon.com (10.146.13.221) by
 EX19D014EUC004.ant.amazon.com (10.252.51.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 8 Jun 2023 12:02:00 +0000
From:   James Gowans <jgowans@amazon.com>
To:     Thomas Gleixner <tglx@linutronix.de>, <liaochang1@huawei.com>,
        Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, James Gowans <jgowans@amazon.com>
Subject: [PATCH 0/3] Resend GIC-v3 LPIs on concurrent invoke
Date:   Thu, 8 Jun 2023 14:00:18 +0200
Message-ID: <20230608120021.3273400-1-jgowans@amazon.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.146.13.221]
X-ClientProxiedBy: EX19D032UWB002.ant.amazon.com (10.13.139.190) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If interrupts do not have global active states it is possible for
the next interrupt to arrive on a new CPU if an affinity change happens
while the original CPU is still running the handler. This specifically
impacts GIC-v3.

In this series, generic functionality is added to handle_fast_eoi() to
support resending the interrupt when this race happens, and that generic
functionality is enabled specifically for the GIC-v3 which is impacted
by this issue. GIC-v3 uses the handle_fast_eoi() generic handler, hence
that is the handler getting the functionality.

Also adding a bit more details to the IRQD flags docs to help future
readers know when/why flags should be used and what they mean.

== Testing: ==

TL;DR: Run a virt using QEMU on a EC2 R6g.metal host with a ENA device
passed through using VFIO - bounce IRQ affinity between two CPUs. Before
this change an interrupt can get lost and the device stalls; after this
change the interrupt is not lost.

=== Details: ===

Intentionally slow down the IRQ injection a bit, to turn this from a
rare race condition which to something which can easily be flushed out
in testing:

@@ -763,6 +764,7 @@ int vgic_its_inject_cached_translation(struct kvm *kvm, struct kvm_msi *msi)
        raw_spin_lock_irqsave(&irq->irq_lock, flags);
        irq->pending_latch = true;
        vgic_queue_irq_unlock(kvm, irq, flags);
+       udelay(10);

        return 0;
 }

Also sprinkle a print to make it clear when the race described here is
hit:

@@ -698,6 +698,7 @@ void handle_fasteoi_irq(struct irq_desc *desc)
         * handling the previous one - it may need to be resent.
         */
        if (!irq_may_run(desc)) {
+               printk("!irq_may_run %i\n", desc->irq_data.irq);
                if (irqd_needs_resend_when_in_progress(&desc->irq_data))
                        desc->istate |= IRQS_PENDING;
                goto out;

Launch QEMU in your favourite way, with an ENA device passed through via
VFIO (VFIO driver re-binding needs to be done before this):

qemu-system-aarch64 -enable-kvm  -machine virt,gic_version=3 -device vfio-pci,host=04:00.0 ...

In the VM, generate network traffic to get interrupts flowing:

ping -f -i 0.001 10.0.3.1 > /dev/null

On the host, change affinity of the interrupt around to flush out the race:

while true; do
	echo 1 > /proc/irq/71/smp_affinity ; sleep 0.01;
	echo 2 > /proc/irq/71/smp_affinity ; sleep 0.01;
done

In host dmesg the printk indicates that the race is hit:

[  102.215801] !irq_may_run 71
[  105.426413] !irq_may_run 71
[  105.586462] !irq_may_run 71

Before this change, an interrupt is lost and this manifests as a driver
watchdog timeout in the guest device driver:

[   35.124441] ena 0000:00:02.0 enp0s2: Found a Tx that wasn't completed on time,...
...
[   37.124459] ------------[ cut here ]------------
[   37.124791] NETDEV WATCHDOG: enp0s2 (ena): transmit queue 0 timed out

After this change, even though the !irq_may_run print is still shown
(indicating that the race is still hit) the driver no longer times out
because the interrupt now gets resent when the race occurs.

James Gowans (3):
  genirq: Expand doc for PENDING and REPLAY flags
  genirq: fasteoi supports resend on concurrent invoke
  irqchip/gic-v3-its: Enable RESEND_WHEN_IN_PROGRESS for LPIs

 drivers/irqchip/irq-gic-v3-its.c |  2 ++
 include/linux/irq.h              | 13 +++++++++++++
 kernel/irq/chip.c                | 16 +++++++++++++++-
 kernel/irq/debugfs.c             |  2 ++
 kernel/irq/internals.h           |  7 +++++--
 5 files changed, 37 insertions(+), 3 deletions(-)


base-commit: 5f63595ebd82f56a2dd36ca013dd7f5ff2e2416a
-- 
2.25.1

