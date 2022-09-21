Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A795E54D3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 22:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiIUU7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 16:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiIUU71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 16:59:27 -0400
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3809A5705
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 13:59:25 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 10811 invoked from network); 21 Sep 2022 22:59:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1663793962; bh=eYat1uCJDkfVTxQVLAjdR9+O2hpBg5EfLC0oZyPm3Jk=;
          h=From:To:Cc:Subject;
          b=yLd5kz5pQn06UdirC14XJMq7fqgHNUN8RpOCQjtmRkP+a/skd7WljLTiW0tKQve5Q
           DNz2067ulc1jVn0IKC2e4Z4Wphk/tnndw+WR5K1blQ/AQfYgmx1L9OrPrGHetQ+ANi
           zzSqlx+42FkBlPc7aYCSCDkg/T0v+nvbqq3sUNWA=
Received: from ip-137-21.ds.pw.edu.pl (HELO LAPTOP-OLEK.lan) (olek2@wp.pl@[194.29.137.21])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <john@phrozen.org>; 21 Sep 2022 22:59:22 +0200
From:   Aleksander Jan Bajkowski <olek2@wp.pl>
To:     john@phrozen.org, martin.blumenstingl@googlemail.com,
        hauke@hauke-m.de, tsbogend@alpha.franken.de, maz@kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH v2 1/1] MIPS: lantiq: enable all hardware interrupts on second VPE
Date:   Wed, 21 Sep 2022 22:59:44 +0200
Message-Id: <20220921205944.466745-2-olek2@wp.pl>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220921205944.466745-1-olek2@wp.pl>
References: <20220921205944.466745-1-olek2@wp.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                      
X-WP-MailID: 1fd3897e21a0bb49c1f0119ef35da854
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [sVP0]                               
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is needed to handle interrupts by the second VPE on the Lantiq
ARX100, xRX200, xRX300 and xRX330 SoCs. Switching some ICU interrupts to
the second VPE results in a hang. Currently, the vsmp_init_secondary()
function is responsible for enabling these interrupts. It only enables
Malta-specific interrupts (SW0, SW1, HW4 and HW5).

The MIPS core has 8 interrupts defined. On Lantiq SoCs, hardware
interrupts are wired to an ICU instance. Each VPE has an independent
instance of the ICU. The mapping of the ICU interrupts is shown below:
SW0(IP0) - IPI call,
SW1(IP1) - IPI resched,
HW0(IP2) - ICU 0-31,
HW1(IP3) - ICU 32-63,
HW2(IP4) - ICU 64-95,
HW3(IP5) - ICU 96-127,
HW4(IP6) - ICU 128-159,
HW5(IP7) - timer.

This patch enables all interrupt lines on the second VPE.

This problem affects multithreaded SoCs with a custom interrupt controller.
SOCs with 1004Kc core and newer use the MIPS GIC. At this point, I am aware
that the Realtek RTL839x and RTL930x SoCs may need a similar fix. In the
future, this may be replaced with some generic solution.

Tested on Lantiq xRX200.

Suggested-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 arch/mips/lantiq/prom.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index c731082a0c42..be4829cc7a3a 100644
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -34,6 +34,14 @@ unsigned long physical_memsize = 0L;
  */
 static struct ltq_soc_info soc_info;
 
+/*
+ * These structs are used to override vsmp_init_secondary()
+ */
+#if defined(CONFIG_MIPS_MT_SMP)
+extern const struct plat_smp_ops vsmp_smp_ops;
+static struct plat_smp_ops lantiq_smp_ops;
+#endif
+
 const char *get_system_type(void)
 {
 	return soc_info.sys_type;
@@ -84,6 +92,17 @@ void __init plat_mem_setup(void)
 	__dt_setup_arch(dtb);
 }
 
+#if defined(CONFIG_MIPS_MT_SMP)
+static void lantiq_init_secondary(void)
+{
+	/*
+	 * MIPS CPU startup function vsmp_init_secondary() will only
+	 * enable some of the interrupts for the second CPU/VPE.
+	 */
+	set_c0_status(ST0_IM);
+}
+#endif
+
 void __init prom_init(void)
 {
 	/* call the soc specific detetcion code and get it to fill soc_info */
@@ -95,7 +114,10 @@ void __init prom_init(void)
 	prom_init_cmdline();
 
 #if defined(CONFIG_MIPS_MT_SMP)
-	if (register_vsmp_smp_ops())
-		panic("failed to register_vsmp_smp_ops()");
+	if (cpu_has_mipsmt) {
+		lantiq_smp_ops = vsmp_smp_ops;
+		lantiq_smp_ops.init_secondary = lantiq_init_secondary;
+		register_smp_ops(&lantiq_smp_ops);
+	}
 #endif
 }
-- 
2.30.2

