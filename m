Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388EA67111C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 03:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjARCYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 21:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjARCYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 21:24:04 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2057.outbound.protection.outlook.com [40.107.96.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E2C53557
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:24:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9MMQNtMxxdl9TzWN4x5RnTd213vs7x6VTQmROQ60YVlX1ERgKDKGZ549vcf4bN3zOLmY8bqaAqtmxwioZ2sD7MYojEttgMAbV3sWX0gvXj7w9Uwc/tBYW4YlZ1FMTDjmq5NpTZGP9L6uf1XsnMsyBFpGeHElnPmiAC6MKicbYZVK3/APesz0h3zb2gxaalGZ674CczjVvWd0x5xLgV5yRFKiZE39qkcJFvsfchryqhDtBfn/C0yncedxwI9UP1ZOOZRFiII0zNkVQEPaT4LJciKU3z6lcxE86v1jVD5hjCEzHVuLYjoxPqyf3brHHr8PxyEAYhgBb+ja1iMAt0q4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Ef1fTfEDZsGQoMZwQzS3LJKAaL12xu3o343vHqCW24=;
 b=MLmwPQxs9qP5LjfQnM3b9anE5GWCyyf5P5NIh9VCCG0Sg567l4xoJje28WiSUVEvhFExSvohCqwbc6hFqWWq6myzLYZLAVeB60h1OLCq9hMIRK3Uo8HBQostiSscNInsJMg0gjaBXyB4fQgtOgQB+gZ0S65b1BR7x1CUBDPyClJRh1xEAvIBuPM4BYc2/gHlfaABrGwilsMfFZ8zRHPiDRdEzGem1uqcuKkMqeUht2iEsktPJDOOmUhULrpbIxln9OeT3ihcJQqrkefrVUjEwh/dONebNmuqIXJjDHGLCMXQjCkUEMUI19zG8oIa3Wu9D2eqCDH3bIPpDrJ1t3EmDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Ef1fTfEDZsGQoMZwQzS3LJKAaL12xu3o343vHqCW24=;
 b=kZ0trjs4HZKR+cOgpLKMCIYeMLqO44J3rSn6K+gLEgecnMh3AZe4VdGO2ww4IxEgaHpECkynaqzkCswuEHRX/ZKOQOstdxaWr88huFE2C/tOsH6WQY5ggfNLtSmQXB48rPhABVKcBZzEb/R4RwMEGqMH3PmXuzKp2cavCGJ14wcNkHETazkAqAUlMgAVJijpF65z8xZXQ+GIMOIlUCHMC2qkt6kmNiXJaL+5Ivz+ObtGv1TxodWje2kQznvRUIg+xAnlMmQjrhAR2log6Gs4vFspJgIP67OPmKZ6/olEhnFQqkLjLQ2Vo2GC7R0FyXPz3W5R3gmRB0TwHnM5iT9uBQ==
Received: from DS7PR05CA0074.namprd05.prod.outlook.com (2603:10b6:8:57::22) by
 DS7PR12MB6238.namprd12.prod.outlook.com (2603:10b6:8:96::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Wed, 18 Jan 2023 02:24:01 +0000
Received: from DS1PEPF0000E632.namprd02.prod.outlook.com
 (2603:10b6:8:57:cafe::c7) by DS7PR05CA0074.outlook.office365.com
 (2603:10b6:8:57::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6023.12 via Frontend
 Transport; Wed, 18 Jan 2023 02:24:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0000E632.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.11 via Frontend Transport; Wed, 18 Jan 2023 02:24:01 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 17 Jan
 2023 18:23:53 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 17 Jan
 2023 18:23:52 -0800
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Tue, 17 Jan 2023 18:23:52 -0800
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>
Subject: [PATCH] KVM: arm64: vgic: Fix soft lockup during VM teardown
Date:   Tue, 17 Jan 2023 20:23:48 -0600
Message-ID: <20230118022348.4137094-1-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E632:EE_|DS7PR12MB6238:EE_
X-MS-Office365-Filtering-Correlation-Id: 47cf6034-4159-4a81-8df8-08daf8fb1028
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lvg1ux7+iu9qNpv5UsOy6cqfUswxiRyYSNh7oEb+mZzaCDbx3pz8wGcGxNFOkF2aqZT92/7N0qJDwCqtKsBN2eJtRRFavABrZQ1j5Ih4HOSmELZoz1lQMI4lCUHLYu7s/0amw2aKgRmmVAcZ6z0z+Yc+lKtPHIcPEy6E4DkDKxfF0++HNrtVVNQqtRLOLEE18lsdD83S4UpAmMLyC4e8sMBR67YPE7KQsAcvMjWBLQ4EcbMD+4Y/DausYJKKa8IwuH4jkVPtAuNzFOvxAwNfJLOM17sacUw+tU/VhKuMKwe/cBm1d9qaJBap+9c066T4kqN4VdTNYVcxXVYaglAOzJhECOf8lciPbAOBZS3nv+Vvq05dfsSkPGRgp+/tceGC9qciOuoVTtETmXXyydyFFRnWqK985htdtRA4Z68JCHJ8wVbISHnhzzUWq88VntPoYnO+Tt7r2szZeBZu0g6eJLZjFMZQ/9ENbgQKeNtC1GlZdeVQOct0vLmI5TVkfKLa8eI/wIVZYaVY2qVmB7uZ/i1NOcia5dnhXl9tRYB9yswzNrlB4tZvVHgnfahF1X7lM41M+2vdi0R6RX3UbXKT3yuHOyKOj4Gm325MWnH3KFwHJAV/Kk0pG+tlyCPsuq50q+AAstEv8bMW5i5IpTiqU4dynyW6lsk0Nbdiv8mmmg6T1iP3U76vgWmd0yLuig6l+0JMoQTRMIxYX2Dn6Dx7CQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199015)(46966006)(36840700001)(40470700004)(54906003)(1076003)(110136005)(7696005)(2616005)(4326008)(26005)(70206006)(8676002)(336012)(70586007)(186003)(478600001)(47076005)(8936002)(83380400001)(426003)(6666004)(107886003)(41300700001)(2906002)(5660300002)(36860700001)(316002)(7636003)(82740400003)(356005)(86362001)(40460700003)(36756003)(40480700001)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 02:24:01.6356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47cf6034-4159-4a81-8df8-08daf8fb1028
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E632.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6238
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Getting intermittent CPU soft lockups during the virtual machines
teardown on a system with GICv4 features enabled. The function
__synchronize_hardirq() has been waiting for IRQD_IRQ_INPROGRESS
to be cleared forever as per the current implementation.

CPU stuck here for a long time leads to soft lockup:
  while (irqd_irq_inprogress(&desc->irq_data))
	cpu_relax();

Call trace from the lockup CPU:
 [   87.238866] watchdog: BUG: soft lockup - CPU#37 stuck for 23s!
 [   87.250025] CPU: 37 PID: 1031 Comm: qemu-system-aarch64
 [   87.358397] Call trace:
 [   87.360891]  __synchronize_hardirq+0x48/0x140
 [   87.365343]  free_irq+0x138/0x424
 [   87.368727]  vgic_v4_teardown+0xa4/0xe0
 [   87.372649]  __kvm_vgic_destroy+0x18c/0x194
 [   87.376922]  kvm_vgic_destroy+0x28/0x3c
 [   87.380839]  kvm_arch_destroy_vm+0x24/0x44
 [   87.385024]  kvm_destroy_vm+0x158/0x2c4
 [   87.388943]  kvm_vm_release+0x6c/0x98
 [   87.392681]  __fput+0x70/0x220
 [   87.395800]  ____fput+0x10/0x20
 [   87.399005]  task_work_run+0xb4/0x23c
 [   87.402746]  do_exit+0x2bc/0x8a4
 [   87.406042]  do_group_exit+0x34/0xb0
 [   87.409693]  get_signal+0x878/0x8a0
 [   87.413254]  do_notify_resume+0x138/0x1530
 [   87.417440]  el0_svc+0xdc/0xf0
 [   87.420559]  el0t_64_sync_handler+0xf0/0x11c
 [   87.424919]  el0t_64_sync+0x18c/0x190

The state of the IRQD_IRQ_INPROGRESS information is lost inside
irq_domain_activate_irq() which happens before calling free_irq().
Instrumented the code and confirmed, the IRQD state is changed from
0x10401400 to 0x10441600 instead of 0x10401600 causing problem.

Call trace from irqd_set_activated():
 [   78.983544] irqd_set_activated: lost IRQD_IRQ_INPROGRESS
                old=0x10401400, new=0x10441600
 [   78.992093] CPU: 19 PID: 1511 Comm: qemu-system-aarch64
 [   79.008461] Call trace:
 [   79.010956]  dump_backtrace.part.0+0xc8/0xe0
 [   79.015328]  show_stack+0x18/0x54
 [   79.018713]  dump_stack_lvl+0x64/0x7c
 [   79.022459]  dump_stack+0x18/0x30
 [   79.025842]  irq_domain_activate_irq+0x88/0x94
 [   79.030385]  vgic_v3_save_pending_tables+0x260/0x29c
 [   79.035463]  vgic_set_common_attr+0xac/0x23c
 [   79.039826]  vgic_v3_set_attr+0x48/0x60
 [   79.043742]  kvm_device_ioctl+0x120/0x19c
 [   79.047840]  __arm64_sys_ioctl+0x42c/0xe00
 [   79.052027]  invoke_syscall.constprop.0+0x50/0xe0
 [   79.056835]  do_el0_svc+0x58/0x180
 [   79.060308]  el0_svc+0x38/0xf0
 [   79.063425]  el0t_64_sync_handler+0xf0/0x11c
 [   79.067785]  el0t_64_sync+0x18c/0x190

irqreturn_t handle_irq_event(struct irq_desc *desc)
{
    irqd_set(&desc->irq_data, IRQD_IRQ_INPROGRESS);
    raw_spin_unlock(&desc->lock);

    ret = handle_irq_event_percpu(desc);

    raw_spin_lock(&desc->lock);
    irqd_clear(&desc->irq_data, IRQD_IRQ_INPROGRESS);
}

In this particular failed case and based on traces, the two functions
irqd_set_activated() and handle_irq_event() are concurrently modifying
IRQD state without both holding desc->lock. The irqd_set_activated()
execution path is reading memory 'state_use_accessors' in between set
& clear of IRQD_IRQ_INPROGRESS state change and writing the modified
data after executing 'irqd_clear(desc->irq_data, IRQD_IRQ_INPROGRESS)'.

To fix the lockup issue, hold desc->lock when calling functions
irq_domain_activate_irq() and irq_domain_deactivate_irq).

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---
 arch/arm64/kvm/vgic/vgic-v3.c | 6 ++++++
 arch/arm64/kvm/vgic/vgic-v4.c | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm64/kvm/vgic/vgic-v3.c b/arch/arm64/kvm/vgic/vgic-v3.c
index 2074521d4a8c..e6aa909fcbe2 100644
--- a/arch/arm64/kvm/vgic/vgic-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-v3.c
@@ -353,22 +353,28 @@ int vgic_v3_lpi_sync_pending_status(struct kvm *kvm, struct vgic_irq *irq)
 static void unmap_all_vpes(struct vgic_dist *dist)
 {
 	struct irq_desc *desc;
+	unsigned long flags;
 	int i;
 
 	for (i = 0; i < dist->its_vm.nr_vpes; i++) {
 		desc = irq_to_desc(dist->its_vm.vpes[i]->irq);
+		raw_spin_lock_irqsave(&desc->lock, flags);
 		irq_domain_deactivate_irq(irq_desc_get_irq_data(desc));
+		raw_spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
 
 static void map_all_vpes(struct vgic_dist *dist)
 {
 	struct irq_desc *desc;
+	unsigned long flags;
 	int i;
 
 	for (i = 0; i < dist->its_vm.nr_vpes; i++) {
 		desc = irq_to_desc(dist->its_vm.vpes[i]->irq);
+		raw_spin_lock_irqsave(&desc->lock, flags);
 		irq_domain_activate_irq(irq_desc_get_irq_data(desc), false);
+		raw_spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
 
diff --git a/arch/arm64/kvm/vgic/vgic-v4.c b/arch/arm64/kvm/vgic/vgic-v4.c
index ad06ba6c9b00..a01b8313e82c 100644
--- a/arch/arm64/kvm/vgic/vgic-v4.c
+++ b/arch/arm64/kvm/vgic/vgic-v4.c
@@ -139,8 +139,10 @@ static void vgic_v4_enable_vsgis(struct kvm_vcpu *vcpu)
 		/* Transfer the full irq state to the vPE */
 		vgic_v4_sync_sgi_config(vpe, irq);
 		desc = irq_to_desc(irq->host_irq);
+		raw_spin_lock(&desc->lock);
 		ret = irq_domain_activate_irq(irq_desc_get_irq_data(desc),
 					      false);
+		raw_spin_unlock(&desc->lock);
 		if (!WARN_ON(ret)) {
 			/* Transfer pending state */
 			ret = irq_set_irqchip_state(irq->host_irq,
@@ -177,7 +179,9 @@ static void vgic_v4_disable_vsgis(struct kvm_vcpu *vcpu)
 		WARN_ON(ret);
 
 		desc = irq_to_desc(irq->host_irq);
+		raw_spin_lock(&desc->lock);
 		irq_domain_deactivate_irq(irq_desc_get_irq_data(desc));
+		raw_spin_unlock(&desc->lock);
 	unlock:
 		raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
 		vgic_put_irq(vcpu->kvm, irq);
-- 
2.25.1

