Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804C55B6BEB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 12:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbiIMKsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 06:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbiIMKsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:48:00 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EEC5F220
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:47:58 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MRg7M61gsz14QTT;
        Tue, 13 Sep 2022 18:43:59 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (7.193.23.208) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 13 Sep 2022 18:47:56 +0800
Received: from DESKTOP-6NKE0BC.china.huawei.com (10.174.185.210) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 13 Sep 2022 18:47:55 +0800
From:   Kunkun Jiang <jiangkunkun@huawei.com>
To:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oliver Upton <oupton@google.com>
CC:     <wanghaibin.wang@huawei.com>, <yuzenghui@huawei.com>,
        Kunkun Jiang <jiangkunkun@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: arch_timer: Fix the lack of set_next_event* for workaround of Cortex-A73 erratum 858921
Date:   Tue, 13 Sep 2022 18:47:23 +0800
Message-ID: <20220913104723.332-1-jiangkunkun@huawei.com>
X-Mailer: git-send-email 2.26.2.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.185.210]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch a38b71b0833e moves the programming of the timers from
the countdown timer (TVAL) over to the comparator (CVAL). This
makes it necessary to read the counter when setting next event.
However, the workaround of Cortex-A73 erratum 858921 does not
set the corresponding set_next_event_phys and set_next_event_virt.
This patch fixes it.

Fixes: a38b71b0833e ("clocksource/drivers/arm_arch_timer: Move system register timer programming over to CVAL")
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
---
 drivers/clocksource/arm_arch_timer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 9ab8221ee3c6..ff935efb6a88 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -473,6 +473,8 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
 		.desc = "ARM erratum 858921",
 		.read_cntpct_el0 = arm64_858921_read_cntpct_el0,
 		.read_cntvct_el0 = arm64_858921_read_cntvct_el0,
+		.set_next_event_phys = erratum_set_next_event_phys,
+		.set_next_event_virt = erratum_set_next_event_virt,
 	},
 #endif
 #ifdef CONFIG_SUN50I_ERRATUM_UNKNOWN1
-- 
2.27.0

