Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8AF5B5491
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 08:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiILGeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 02:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiILGeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 02:34:02 -0400
Received: from m12-15.163.com (m12-15.163.com [220.181.12.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2597140D2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=4EqH1
        chU5d770X/kuYiWfOyfZ4c8rIYHHXZj6bS5NoQ=; b=al1qouJMZuNywPpg9ueYg
        WsmLBT7us/rp7Hte28eU+NTZRVhFQnX014VSfu/tIQvHRyqo0JqXv5c2h2gsk+rv
        3gcnStvgcTF8m0MwqPa5zY+hhX79VkKE1Y80oGhjhj9JV2vGLT0tMezIcztXiqzc
        UnBZdCqAZDBX/N3uKO0EGw=
Received: from DESKTOP-B1R4FVG.localdomain (unknown [218.201.129.20])
        by smtp11 (Coremail) with SMTP id D8CowAC353W60h5jxXlpBQ--.26310S2;
        Mon, 12 Sep 2022 14:33:32 +0800 (CST)
From:   qianfanguijin@163.com
To:     linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Evgeny Boger <boger@wirenboard.com>,
        Andre Przywara <andre.przywara@arm.com>,
        =?UTF-8?q?Jernej=20=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        qianfan Zhao <qianfanguijin@163.com>
Subject: [PATCH v2] net: allwinner: emac: Fix double spinlock in emac_timeout
Date:   Mon, 12 Sep 2022 14:33:31 +0800
Message-Id: <20220912063331.23369-1-qianfanguijin@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowAC353W60h5jxXlpBQ--.26310S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuryrCF45KrWkWw15Zr15XFb_yoWrCFyfpF
        yUAa48Cw4xX3Wqvw4xtrW0qFWvq3Zay34xCr4xAw4fuFn3G34rXFy8tFy2kFWYyrZrAa47
        KF1qy3ySkF4kXaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pisqXdUUUUU=
X-Originating-IP: [218.201.129.20]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/1tbiGhx67VaECzBFRAAAs5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: qianfan Zhao <qianfanguijin@163.com>

emac_timeout() callback acquires lock and so does emac_init_device(),
which called inside lock protected region. This hangs the system and
produces following warning:

WARNING: CPU: 2 PID: 0 at net/sched/sch_generic.c:478
dev_watchdog+0x2e4/0x2e8
NETDEV WATCHDOG: FE0 (sun4i-emac): transmit queue 0 timed out
Modules linked in:
CPU: 2 PID: 0 Comm: swapper/2 Tainted: G W 5.15.0-00047-g0848e4aeb313
Hardware name: Wisdom T3 based CCT Family
[<c010f740>] (unwind_backtrace) from [<c010b744>] (show_stack+0x10/0x14)
[<c010b744>] (show_stack) from [<c0a4d978>] (dump_stack_lvl+0x40/0x4c)
[<c0a4d978>] (dump_stack_lvl) from [<c0120734>] (__warn+0x104/0x108)
[<c0120734>] (__warn) from [<c01207b0>] (warn_slowpath_fmt+0x78/0xbc)
[<c01207b0>] (warn_slowpath_fmt) from [<c0898a54>]
(dev_watchdog+0x2e4/0x2e8)
[<c0898a54>] (dev_watchdog) from [<c019a888>] (call_timer_fn+0x3c/0x178)
[<c019a888>] (call_timer_fn) from [<c019bddc>]
(run_timer_softirq+0x540/0x624)
[<c019bddc>] (run_timer_softirq) from [<c0101298>]
(__do_softirq+0x130/0x3bc)
[<c0101298>] (__do_softirq) from [<c0127ea0>] (irq_exit+0xbc/0x100)
[<c0127ea0>] (irq_exit) from [<c017e514>] (handle_domain_irq+0x60/0x78)
[<c017e514>] (handle_domain_irq) from [<c05a6130>]
(gic_handle_irq+0x7c/0x90)
[<c05a6130>] (gic_handle_irq) from [<c0100afc>] (__irq_svc+0x5c/0x78)
Exception stack(0xc14f3f70 to 0xc14f3fb8)
3f60:                                     0003475c 00000000 00000001
c01188a0
3f80: c107b200 c0f06b4c c0f06b90 00000004 c1079ff8 c0c62774 00000000
00000000
3fa0: c10b2198 c14f3fc0 c0107fcc c0107fd0 60030013 ffffffff
[<c0100afc>] (__irq_svc) from [<c0107fd0>] (arch_cpu_idle+0x38/0x3c)
[<c0107fd0>] (arch_cpu_idle) from [<c0a57f38>]
(default_idle_call+0x3c/0xcc)
[<c0a57f38>] (default_idle_call) from [<c0157258>] (do_idle+0xdc/0x13c)
[<c0157258>] (do_idle) from [<c01575a4>] (cpu_startup_entry+0x18/0x1c)
[<c01575a4>] (cpu_startup_entry) from [<401015d0>] (0x401015d0)
---[ end trace a70942a1265338f1 ]---
rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
rcu: \x092-...0: (1 GPs behind) idle=75d/0/0x1 softirq=8288/8289 fqs=931
\x09(detected by 0, t=2102 jiffies, g=13485, q=1635)
Sending NMI from CPU 0 to CPUs 2:
spi_master spi2: spi2.1: timeout transferring 4 bytes@100000Hz for
110(100)ms
spidev spi2.1: SPI transfer failed: -110

Fixes: 492205050d77b (net: Add EMAC ethernet driver found on Allwinner A10 SoC's)
Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
---
 drivers/net/ethernet/allwinner/sun4i-emac.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/allwinner/sun4i-emac.c b/drivers/net/ethernet/allwinner/sun4i-emac.c
index 49759deeed8e..034989b396f7 100644
--- a/drivers/net/ethernet/allwinner/sun4i-emac.c
+++ b/drivers/net/ethernet/allwinner/sun4i-emac.c
@@ -378,14 +378,11 @@ static int emac_set_mac_address(struct net_device *dev, void *p)
 }
 
 /* Initialize emac board */
-static void emac_init_device(struct net_device *dev)
+static void emac_init_device_no_lock(struct net_device *dev)
 {
 	struct emac_board_info *db = netdev_priv(dev);
-	unsigned long flags;
 	unsigned int reg_val;
 
-	spin_lock_irqsave(&db->lock, flags);
-
 	emac_update_speed(dev);
 	emac_update_duplex(dev);
 
@@ -398,7 +395,15 @@ static void emac_init_device(struct net_device *dev)
 	reg_val = readl(db->membase + EMAC_INT_CTL_REG);
 	reg_val |= (0xf << 0) | (0x01 << 8);
 	writel(reg_val, db->membase + EMAC_INT_CTL_REG);
+}
+
+static void emac_init_device(struct net_device *dev)
+{
+	struct emac_board_info *db = netdev_priv(dev);
+	unsigned long flags;
 
+	spin_lock_irqsave(&db->lock, flags);
+	emac_init_device_no_lock(dev);
 	spin_unlock_irqrestore(&db->lock, flags);
 }
 
@@ -416,7 +421,7 @@ static void emac_timeout(struct net_device *dev, unsigned int txqueue)
 
 	netif_stop_queue(dev);
 	emac_reset(db);
-	emac_init_device(dev);
+	emac_init_device_no_lock(dev);
 	/* We can accept TX packets again */
 	netif_trans_update(dev);
 	netif_wake_queue(dev);
-- 
2.25.1

