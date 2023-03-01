Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172CE6A77C5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 00:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjCAXij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 18:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjCAXiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 18:38:06 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AFA83EA
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 15:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677713884; x=1709249884;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=zUIexEbd0hZhib5r+ZAg8qtfUzdZo+tlYmvOjzffG+U=;
  b=ZKM0+u4BYLAlaFwuQZbsk4yoeRtwhsThlzAhuaEjBL+E2hDcB601NzUM
   0B71AwFzbuOxpHx0HXJp+hTsSS4AA/fdeziNOhO41kvwDPBlW6lJ+9T+x
   S2bYcvdYgF7Yd/uzgIrQ1FJEzr7BgzEERSFIqVwhyM8+Tyt9/NjIJbJZn
   btuBq5NcBvllJ62H9DeauJy1wdOPUi+ewoasGW2/9eUdU57A37eaHmdMa
   Wrs2GmQ5EOacSmY6SsPq+YCifMeIPe0+RJGgykwQQdEQWuzn+ndYqvtOH
   U76H/d5db8rlZHp2az+97nZk9HubB7smdELIl+cxxMYeCdXuqJYOjdPiO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="420818750"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="420818750"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 15:37:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="738826838"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="738826838"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 01 Mar 2023 15:37:58 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Len Brown <len.brown@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH v7 13/24] x86/hpet: Add helper function hpet_set_comparator_periodic()
Date:   Wed,  1 Mar 2023 15:47:42 -0800
Message-Id: <20230301234753.28582-14-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230301234753.28582-1-ricardo.neri-calderon@linux.intel.com>
References: <20230301234753.28582-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Programming an HPET channel in periodic mode involves several steps.
Besides the HPET clocksource, the HPET-based hardlockup detector may
need to program its HPET channel in periodic mode.

To avoid code duplication, wrap the programming of the HPET timer in
a helper function.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Originally-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
When programming the HPET channel in periodic mode, a udelay(1) between
the two successive writes to HPET_Tn_CMP was introduced in commit
e9e2cdb41241 ("[PATCH] clockevents: i386 drivers"). The commit message
does not give any reason for such delay. The hardware specification does
not seem to require it. The refactoring in this patch simply carries such
delay.
---
Changes since v6:
 * Reworded the commit message for clarity.

Changes since v5:
 * None

Changes since v4:
 * Implement function only for periodic mode. This removed extra logic to
   to use a non-zero period value as a proxy for periodic mode
   programming. (Thomas)
 * Added a comment on the history of the udelay() when programming the
   channel in periodic mode. (Ashok)

Changes since v3:
 * Added back a missing hpet_writel() for time configuration.

Changes since v2:
 *  Introduced this patch.

Changes since v1:
 * N/A
---
 arch/x86/include/asm/hpet.h |  2 ++
 arch/x86/kernel/hpet.c      | 49 ++++++++++++++++++++++++++++---------
 2 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index be9848f0883f..486e001413c7 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -74,6 +74,8 @@ extern void hpet_disable(void);
 extern unsigned int hpet_readl(unsigned int a);
 extern void hpet_writel(unsigned int d, unsigned int a);
 extern void force_hpet_resume(void);
+extern void hpet_set_comparator_periodic(int channel, unsigned int cmp,
+					 unsigned int period);
 
 #ifdef CONFIG_HPET_EMULATE_RTC
 
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 8303fb1b63a9..3563849c2290 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -294,6 +294,39 @@ static void hpet_enable_legacy_int(void)
 	hpet_legacy_int_enabled = true;
 }
 
+/**
+ * hpet_set_comparator_periodic() - Helper function to set periodic channel
+ * @channel:	The HPET channel
+ * @cmp:	The value to be written to the comparator/accumulator
+ * @period:	Number of ticks per period
+ *
+ * Helper function for updating comparator, accumulator and period values.
+ *
+ * In periodic mode, HPET needs HPET_TN_SETVAL to be set before writing
+ * to the Tn_CMP to update the accumulator. Then, HPET needs a second
+ * write (with HPET_TN_SETVAL cleared) to Tn_CMP to set the period.
+ * The HPET_TN_SETVAL bit is automatically cleared after the first write.
+ *
+ * This function takes a 1 microsecond delay. However, this function is supposed
+ * to be called only once (or when reprogramming the timer) as it deals with a
+ * periodic timer channel.
+ *
+ * See the following documents:
+ *   - Intel IA-PC HPET (High Precision Event Timers) Specification
+ *   - AMD-8111 HyperTransport I/O Hub Data Sheet, Publication # 24674
+ */
+void hpet_set_comparator_periodic(int channel, unsigned int cmp, unsigned int period)
+{
+	unsigned int v = hpet_readl(HPET_Tn_CFG(channel));
+
+	hpet_writel(v | HPET_TN_SETVAL, HPET_Tn_CFG(channel));
+
+	hpet_writel(cmp, HPET_Tn_CMP(channel));
+
+	udelay(1);
+	hpet_writel(period, HPET_Tn_CMP(channel));
+}
+
 static int hpet_clkevt_set_state_periodic(struct clock_event_device *evt)
 {
 	unsigned int channel = clockevent_to_channel(evt)->num;
@@ -306,19 +339,11 @@ static int hpet_clkevt_set_state_periodic(struct clock_event_device *evt)
 	now = hpet_readl(HPET_COUNTER);
 	cmp = now + (unsigned int)delta;
 	cfg = hpet_readl(HPET_Tn_CFG(channel));
-	cfg |= HPET_TN_ENABLE | HPET_TN_PERIODIC | HPET_TN_SETVAL |
-	       HPET_TN_32BIT;
+	cfg |= HPET_TN_ENABLE | HPET_TN_PERIODIC | HPET_TN_32BIT;
 	hpet_writel(cfg, HPET_Tn_CFG(channel));
-	hpet_writel(cmp, HPET_Tn_CMP(channel));
-	udelay(1);
-	/*
-	 * HPET on AMD 81xx needs a second write (with HPET_TN_SETVAL
-	 * cleared) to T0_CMP to set the period. The HPET_TN_SETVAL
-	 * bit is automatically cleared after the first write.
-	 * (See AMD-8111 HyperTransport I/O Hub Data Sheet,
-	 * Publication # 24674)
-	 */
-	hpet_writel((unsigned int)delta, HPET_Tn_CMP(channel));
+
+	hpet_set_comparator_periodic(channel, cmp, (unsigned int)delta);
+
 	hpet_start_counter();
 	hpet_print_config();
 
-- 
2.25.1

