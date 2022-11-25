Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798086391F4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 00:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiKYXDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 18:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiKYXDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 18:03:12 -0500
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF824A051
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 15:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1669417389; x=1700953389;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/V48wm+KFgv3i/JbkWBA72q9kUIRXPqZTsOIWEY9uTk=;
  b=rjB2XgFWPInPaZW/Dloky7wZ2k8UrthPMVOHObh0HgDm/X038A7XHRFP
   h5nCdkvwUSqRBMxQDhHSwh1MTeasRXcystPOCyqE3YTJVIs4S+DJDB6hp
   qTP6VEEvg3cIXgvBXECYMpYY10wwMtiTbOyrth2mH9NaYJHgphL2jU6kb
   4=;
X-IronPort-AV: E=Sophos;i="5.96,194,1665446400"; 
   d="scan'208";a="1077511612"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-bbc6e425.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 23:03:08 +0000
Received: from EX13MTAUWC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-m6i4x-bbc6e425.us-east-1.amazon.com (Postfix) with ESMTPS id 73BA886034;
        Fri, 25 Nov 2022 23:03:07 +0000 (UTC)
Received: from EX19D003UWC001.ant.amazon.com (10.13.138.144) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Fri, 25 Nov 2022 23:03:06 +0000
Received: from 88665a005865.ant.amazon.com (10.43.161.14) by
 EX19D003UWC001.ant.amazon.com (10.13.138.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.20;
 Fri, 25 Nov 2022 23:03:05 +0000
From:   Geoff Blake <blakgeof@amazon.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <blakgeof@amazon.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] perf/arm-cmn: Add shutdown routine
Date:   Fri, 25 Nov 2022 17:01:53 -0600
Message-ID: <20221125230153.49468-1-blakgeof@amazon.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.161.14]
X-ClientProxiedBy: EX13D38UWB001.ant.amazon.com (10.43.161.10) To
 EX19D003UWC001.ant.amazon.com (10.13.138.144)
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CMN driver does not gracefully handle all
restart cases, such as kexec.  On a kexec if the
arm-cmn driver is in use it can be left in a state
with still active  events that can cause spurious and/or
unhandled interrupts that appear as non-fatal kernel errors
like below, that can be confusing and misleading:

[    3.895093] irq 28: nobody cared (try booting with the "irqpoll" option)
[    3.895170] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19.0-1011-aws #12
[    3.895172] Hardware name: Amazon EC2 c6g.metal/Not Specified, BIOS 1.0 10/16/2017
[    3.895174] Call trace:
[    3.895175]  dump_backtrace+0xe8/0x150
[    3.895181]  show_stack+0x28/0x70
[    3.895183]  dump_stack_lvl+0x68/0x9c
[    3.895188]  dump_stack+0x1c/0x48
[    3.895190]  __report_bad_irq+0x58/0x138
[    3.895193]  note_interrupt+0x23c/0x360
[    3.895196]  handle_irq_event+0x108/0x1a0
[    3.895198]  handle_fasteoi_irq+0xd0/0x24c
[    3.895201]  generic_handle_domain_irq+0x3c/0x70
[    3.895203]  __gic_handle_irq_from_irqson.isra.0+0xcc/0x2c0
[    3.895207]  gic_handle_irq+0x34/0xb0
[    3.895209]  call_on_irq_stack+0x40/0x50
[    3.895211]  do_interrupt_handler+0xb0/0xb4
[    3.895214]  el1_interrupt+0x4c/0xe0
[    3.895217]  el1h_64_irq_handler+0x1c/0x40
[    3.895220]  el1h_64_irq+0x78/0x7c
[    3.895222]  __do_softirq+0xd0/0x450
[    3.895223]  __irq_exit_rcu+0xcc/0x120
[    3.895227]  irq_exit_rcu+0x20/0x40
[    3.895229]  el1_interrupt+0x50/0xe0
[    3.895231]  el1h_64_irq_handler+0x1c/0x40
[    3.895233]  el1h_64_irq+0x78/0x7c
[    3.895235]  arch_cpu_idle+0x1c/0x6c
[    3.895238]  default_idle_call+0x4c/0x19c
[    3.895240]  cpuidle_idle_call+0x18c/0x1f0
[    3.895243]  do_idle+0xb0/0x11c
[    3.895245]  cpu_startup_entry+0x34/0x40
[    3.895248]  rest_init+0xec/0x104
[    3.895250]  arch_post_acpi_subsys_init+0x0/0x30
[    3.895254]  start_kernel+0x4d0/0x534
[    3.895256]  __primary_switched+0xc4/0xcc
[    3.895259] handlers:
[    3.895292] [<000000008f5364c7>] arm_cmn_handle_irq [arm_cmn]
[    3.895369] Disabling IRQ #28

This type of kernel error can be reproduced by running perf with
an arm_cmn event active and then forcing a kexec.  On return from
the kexec, this message can appear semi-regularly.

This patch adds a shutdown routine that gets called by the
reboot/kexec path to put the PMU nodes back into a clean state
to avoid leaked events and the above unhandled interrupts.
Additionally modify arm_cmn_discover() loop to initialize all PMU
capable nodes to have no active events as done for XP watchpoints
in arm_cmn_init_dtm().  Testing 100's of kexecs with this patch
has shown this error message goes away.

Signed-off-by: Geoff Blake <blakgeof@amazon.com>
---
 drivers/perf/arm-cmn.c | 58 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index b80a9b74662b..032e0c87e8b6 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -112,6 +112,7 @@
 #define CMN_DTM_UNIT_INFO		0x0910
 
 #define CMN_DTM_NUM_COUNTERS		4
+#define CMN_DTM_NUM_WPS			4
 /* Want more local counters? Why not replicate the whole DTM! Ugh... */
 #define CMN_DTM_OFFSET(n)		((n) * 0x200)
 
@@ -1865,7 +1866,7 @@ static void arm_cmn_init_dtm(struct arm_cmn_dtm *dtm, struct arm_cmn_node *xp, i
 
 	dtm->base = xp->pmu_base + CMN_DTM_OFFSET(idx);
 	dtm->pmu_config_low = CMN_DTM_PMU_CONFIG_PMU_EN;
-	for (i = 0; i < 4; i++) {
+	for (i = 0; i < CMN_DTM_NUM_WPS; i++) {
 		dtm->wp_event[i] = -1;
 		writeq_relaxed(0, dtm->base + CMN_DTM_WPn_MASK(i));
 		writeq_relaxed(~0ULL, dtm->base + CMN_DTM_WPn_VAL(i));
@@ -2137,6 +2138,7 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 			case CMN_TYPE_CCRA:
 			case CMN_TYPE_CCHA:
 			case CMN_TYPE_CCLA:
+				writeq_relaxed(0, dn->pmu_base + CMN_PMU_EVENT_SEL);
 				dn++;
 				break;
 			/* Nothing to see here */
@@ -2156,6 +2158,8 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 				dn[1] = dn[0];
 				dn[0].pmu_base += CMN_HNP_PMU_EVENT_SEL;
 				dn[1].type = arm_cmn_subtype(dn->type);
+				writeq_relaxed(0, dn[0].pmu_base + CMN_PMU_EVENT_SEL);
+				writeq_relaxed(0, dn[1].pmu_base + CMN_PMU_EVENT_SEL);
 				dn += 2;
 				break;
 			/* Something has gone horribly wrong */
@@ -2312,15 +2316,64 @@ static int arm_cmn_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int arm_cmn_remove(struct platform_device *pdev)
+static void arm_cmn_shutdown(struct platform_device *pdev)
 {
 	struct arm_cmn *cmn = platform_get_drvdata(pdev);
+	struct arm_cmn_dtm *dtm = cmn->dtms;
+	struct arm_cmn_node *dn = cmn->dns;
+	int i, j = 0;
 
+	writel_relaxed(0, cmn->dtc[0].base + CMN_DT_PMCR);
 	writel_relaxed(0, cmn->dtc[0].base + CMN_DT_DTC_CTL);
 
+	/* Go through all DTMs and disable PMU events and WPs */
+	for (i = 0, dtm = cmn->dtms; i < cmn->num_xps; i++, dtm++) {
+		writeq_relaxed(0, dtm->base + CMN_DTM_PMU_CONFIG);
+		for (j = 0; j < CMN_DTM_NUM_WPS; j++) {
+			writeq_relaxed(0, dtm->base + CMN_DTM_WPn_CONFIG(j));
+			writeq_relaxed(0, dtm->base + CMN_DTM_WPn_VAL(j));
+			writeq_relaxed(0, dtm->base + CMN_DTM_WPn_MASK(j));
+		}
+	}
+
+	/* Go through all relevant DN types and disable any leaked PMU events */
+	for (i = 0, dn = cmn->dns; i < cmn->num_dns; i++, dn++) {
+		switch (dn->type) {
+		case CMN_TYPE_DVM:
+		case CMN_TYPE_HNI:
+		case CMN_TYPE_HNF:
+		case CMN_TYPE_HNP:
+		case CMN_TYPE_SBSX:
+		case CMN_TYPE_RNI:
+		case CMN_TYPE_RND:
+		case CMN_TYPE_MTSX:
+		case CMN_TYPE_CXRA:
+		case CMN_TYPE_CXHA:
+		case CMN_TYPE_CCRA:
+		case CMN_TYPE_CCHA:
+		case CMN_TYPE_CCLA:
+		case CMN_TYPE_CCLA_RNI:
+		case CMN_TYPE_XP:
+			writeq_relaxed(0, dn->pmu_base + CMN_PMU_EVENT_SEL);
+			break;
+		case CMN_TYPE_DTC:
+		case CMN_TYPE_MPAM_S:
+		case CMN_TYPE_MPAM_NS:
+		case CMN_TYPE_RNSAM:
+		case CMN_TYPE_CXLA:
+		default:
+			break;
+		}
+	}
+
 	perf_pmu_unregister(&cmn->pmu);
 	cpuhp_state_remove_instance_nocalls(arm_cmn_hp_state, &cmn->cpuhp_node);
 	debugfs_remove(cmn->debug);
+}
+
+static int arm_cmn_remove(struct platform_device *pdev)
+{
+	arm_cmn_shutdown(pdev);
 	return 0;
 }
 
@@ -2353,6 +2406,7 @@ static struct platform_driver arm_cmn_driver = {
 	},
 	.probe = arm_cmn_probe,
 	.remove = arm_cmn_remove,
+	.shutdown = arm_cmn_shutdown,
 };
 
 static int __init arm_cmn_init(void)
-- 
2.24.3 (Apple Git-128)

