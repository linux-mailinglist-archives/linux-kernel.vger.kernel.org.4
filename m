Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE5F6E4348
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 11:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjDQJIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 05:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjDQJIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 05:08:52 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D73E60;
        Mon, 17 Apr 2023 02:08:26 -0700 (PDT)
X-UUID: 64e3ab04dcff11eda9a90f0bb45854f4-20230417
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ZocelY8Xzrm6tgwprT9z94nG/u6U7wBfo/19biInwZI=;
        b=BB6SFsh29mmRrhNOBnpVa0b3i0Yo875FWC0/Hc940xeFy6ErleEYHL1n/aCMbd82n6adUt1Dt6ujj3SGbv5Zve9B4ucWRXzXHFaSD9Nx0AmD6GRSmp00cHgcElpFkfk0vXwfnSTGi2+8FMjXP3JFiAaH61r7B4mTpJZHPXcYnc4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:99022a69-5960-405d-9f62-1c8c6075f823,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.22,REQID:99022a69-5960-405d-9f62-1c8c6075f823,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:120426c,CLOUDID:9a1a95a1-8fcb-430b-954a-ba3f00fa94a5,B
        ulkID:2304171708212RITSUTE,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 64e3ab04dcff11eda9a90f0bb45854f4-20230417
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <walter.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1483748974; Mon, 17 Apr 2023 17:08:18 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 17 Apr 2023 17:08:17 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 17 Apr 2023 17:08:17 +0800
From:   <walter.chang@mediatek.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <wsd_upstream@mediatek.com>, <stanley.chu@mediatek.com>,
        <Chun-hung.Wu@mediatek.com>, <Freddy.Hsin@mediatek.com>,
        Walter Chang <walter.chang@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] clocksource/drivers/arm_arch_timer: Add workaround for MediaTek MMIO timer
Date:   Mon, 17 Apr 2023 17:06:28 +0800
Message-ID: <20230417090635.13202-1-walter.chang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Walter Chang <walter.chang@mediatek.com>

The MT69XX series SoCs have the incomplete implementation issue in the
mmio timer. Specifically, the hardware only implements the TVAL
functionality, but not the CVAL functionality. This hardware limitation
will cause set_next_event_mem() fail to set the actual expiration time
when writing a value to the CVAL. On these platforms, the mmio timer's
internal expiration time will still be judged as 0 (the value of TVAL),
resulting in the mmio timer not functioning as intended.

The workaround is to use TVAL in addition to CVAL for these affected
platforms.

Signed-off-by: Walter Chang <walter.chang@mediatek.com>
---
 Documentation/arm64/silicon-errata.rst |  4 ++++
 drivers/clocksource/Kconfig            |  9 ++++++++
 drivers/clocksource/arm_arch_timer.c   | 29 ++++++++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index ec5f889d7681..ca1893713a4c 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -209,3 +209,7 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Fujitsu        | A64FX           | E#010001        | FUJITSU_ERRATUM_010001      |
 +----------------+-----------------+-----------------+-----------------------------+
+
++----------------+-----------------+-----------------+-----------------------------+
+| MediaTek       | MT69XX series   | #690001         | MEDIATEK_ERRATUM_690001     |
++----------------+-----------------+-----------------+-----------------------------+
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 5fc8f0e7fb38..475356b8dbdc 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -368,6 +368,15 @@ config SUN50I_ERRATUM_UNKNOWN1
 	  the Allwinner A64 SoC. The workaround will only be active if the
 	  allwinner,erratum-unknown1 property is found in the timer node.
 
+config MEDIATEK_ERRATUM_690001
+	bool "Workaround for MediaTek MT69XX erratum 690001"
+	depends on ARM_ARCH_TIMER && ARM64
+	help
+	  This option enables a workaround for incomplete implementation
+	  in the MMIO timer on the MediaTek MT69XX SoCs. The workaround
+	  will only be active if mediatek,erratum-690001 property is
+	  found in the timer node.
+
 config ARM_GLOBAL_TIMER
 	bool "Support for the ARM global timer" if COMPILE_TEST
 	select TIMER_OF if OF
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index e09d4427f604..920570d57fc0 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -389,6 +389,10 @@ static u64 notrace sun50i_a64_read_cntvct_el0(void)
 }
 #endif
 
+#ifdef CONFIG_MEDIATEK_ERRATUM_690001
+static bool arch_timer_mem_sne_use_tval __ro_after_init;
+#endif
+
 #ifdef CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND
 DEFINE_PER_CPU(const struct arch_timer_erratum_workaround *, timer_unstable_counter_workaround);
 EXPORT_SYMBOL_GPL(timer_unstable_counter_workaround);
@@ -783,6 +787,19 @@ static __always_inline void set_next_event_mem(const int access, unsigned long e
 		cnt = arch_counter_get_cnt_mem(timer, CNTPCT_LO);
 
 	arch_timer_reg_write(access, ARCH_TIMER_REG_CVAL, evt + cnt, clk);
+#ifdef CONFIG_MEDIATEK_ERRATUM_690001
+	if (arch_timer_mem_sne_use_tval) {
+		/* Due to the incomplete implementation of mmio timer on
+		 * specific MediaTek platforms, CVAL has not been implemented.
+		 * Therefore, the workaround is to use TVAL in addition to
+		 * CVAL.
+		 */
+		if (access == ARCH_TIMER_MEM_VIRT_ACCESS)
+			writel_relaxed(evt, timer->base + 0x38);
+		else
+			writel_relaxed(evt, timer->base + 0x28);
+	}
+#endif
 	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
 }
 
@@ -878,7 +895,16 @@ static void __arch_timer_setup(unsigned type,
 				arch_timer_set_next_event_phys_mem;
 		}
 
+#ifdef CONFIG_MEDIATEK_ERRATUM_690001
+		if (arch_timer_mem_sne_use_tval) {
+			pr_info("Enabling mediatek,erratum-690001 for mmio timer\n");
+			max_delta = CLOCKSOURCE_MASK(31);
+		} else {
+			max_delta = CLOCKSOURCE_MASK(56);
+		}
+#else
 		max_delta = CLOCKSOURCE_MASK(56);
+#endif
 	}
 
 	clk->set_state_shutdown(clk);
@@ -1591,6 +1617,9 @@ static int __init arch_timer_mem_of_init(struct device_node *np)
 		frame->valid = true;
 	}
 
+#ifdef CONFIG_MEDIATEK_ERRATUM_690001
+	arch_timer_mem_sne_use_tval = of_property_read_bool(np, "mediatek,erratum-690001");
+#endif
 	frame = arch_timer_mem_find_best_frame(timer_mem);
 	if (!frame) {
 		pr_err("Unable to find a suitable frame in timer @ %pa\n",
-- 
2.18.0

