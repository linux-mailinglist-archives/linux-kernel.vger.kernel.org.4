Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510AB71158A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242454AbjEYSoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242379AbjEYSnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:43:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C371173D;
        Thu, 25 May 2023 11:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4020A6111E;
        Thu, 25 May 2023 18:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C86BC4339E;
        Thu, 25 May 2023 18:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685039907;
        bh=db40lIQNftQ6tKjDPGrRKcbC2u/3Ff74Fj9+8XNcPDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rfrs6Q4rGzo4iRbZcenHYDrXn9SHmQxtpgxDOnDY0p4YaF+MyfFQZFdtbr9LHKzxq
         un7uSxTAFZGs4V8/NplOKhKGHtrCapg0rIP1du1kQnZn8WPbaJnAj0Bmz83p56o8tO
         f3r15lHJkPOATCjlN69fXUVHwydX50WRS8rsVvB/9Eg004SIaahBlIlD831tTH2ADO
         sn/zieE961jWK1YpQ8oLtbtncVotv0tLIKGoh5hN1Db0Cqkrt1nDlyt6BDlmZMKxeI
         bhjkTq7KhTHdgfRNwFxiZTYszlFNBlxRJ9bbGMucIPeVSAE06sA8CT+D67QgiCTX4S
         AA1WmcB3WO+xA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        chandrashekar.devegowda@intel.com, linuxwwan@intel.com,
        loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 45/57] net: wwan: t7xx: Ensure init is completed before system sleep
Date:   Thu, 25 May 2023 14:35:55 -0400
Message-Id: <20230525183607.1793983-45-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183607.1793983-1-sashal@kernel.org>
References: <20230525183607.1793983-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit ab87603b251134441a67385ecc9d3371be17b7a7 ]

When the system attempts to sleep while mtk_t7xx is not ready, the driver
cannot put the device to sleep:
[   12.472918] mtk_t7xx 0000:57:00.0: [PM] Exiting suspend, modem in invalid state
[   12.472936] mtk_t7xx 0000:57:00.0: PM: pci_pm_suspend(): t7xx_pci_pm_suspend+0x0/0x20 [mtk_t7xx] returns -14
[   12.473678] mtk_t7xx 0000:57:00.0: PM: dpm_run_callback(): pci_pm_suspend+0x0/0x1b0 returns -14
[   12.473711] mtk_t7xx 0000:57:00.0: PM: failed to suspend async: error -14
[   12.764776] PM: Some devices failed to suspend, or early wake event detected

Mediatek confirmed the device can take a rather long time to complete
its initialization, so wait for up to 20 seconds until init is done.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wwan/t7xx/t7xx_pci.c | 18 ++++++++++++++++++
 drivers/net/wwan/t7xx/t7xx_pci.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index 226fc1703e90f..91256e005b846 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -45,6 +45,7 @@
 #define T7XX_PCI_IREG_BASE		0
 #define T7XX_PCI_EREG_BASE		2
 
+#define T7XX_INIT_TIMEOUT		20
 #define PM_SLEEP_DIS_TIMEOUT_MS		20
 #define PM_ACK_TIMEOUT_MS		1500
 #define PM_AUTOSUSPEND_MS		20000
@@ -96,6 +97,7 @@ static int t7xx_pci_pm_init(struct t7xx_pci_dev *t7xx_dev)
 	spin_lock_init(&t7xx_dev->md_pm_lock);
 	init_completion(&t7xx_dev->sleep_lock_acquire);
 	init_completion(&t7xx_dev->pm_sr_ack);
+	init_completion(&t7xx_dev->init_done);
 	atomic_set(&t7xx_dev->md_pm_state, MTK_PM_INIT);
 
 	device_init_wakeup(&pdev->dev, true);
@@ -124,6 +126,7 @@ void t7xx_pci_pm_init_late(struct t7xx_pci_dev *t7xx_dev)
 	pm_runtime_mark_last_busy(&t7xx_dev->pdev->dev);
 	pm_runtime_allow(&t7xx_dev->pdev->dev);
 	pm_runtime_put_noidle(&t7xx_dev->pdev->dev);
+	complete_all(&t7xx_dev->init_done);
 }
 
 static int t7xx_pci_pm_reinit(struct t7xx_pci_dev *t7xx_dev)
@@ -529,6 +532,20 @@ static void t7xx_pci_shutdown(struct pci_dev *pdev)
 	__t7xx_pci_pm_suspend(pdev);
 }
 
+static int t7xx_pci_pm_prepare(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct t7xx_pci_dev *t7xx_dev;
+
+	t7xx_dev = pci_get_drvdata(pdev);
+	if (!wait_for_completion_timeout(&t7xx_dev->init_done, T7XX_INIT_TIMEOUT * HZ)) {
+		dev_warn(dev, "Not ready for system sleep.\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
 static int t7xx_pci_pm_suspend(struct device *dev)
 {
 	return __t7xx_pci_pm_suspend(to_pci_dev(dev));
@@ -555,6 +572,7 @@ static int t7xx_pci_pm_runtime_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops t7xx_pci_pm_ops = {
+	.prepare = t7xx_pci_pm_prepare,
 	.suspend = t7xx_pci_pm_suspend,
 	.resume = t7xx_pci_pm_resume,
 	.resume_noirq = t7xx_pci_pm_resume_noirq,
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.h b/drivers/net/wwan/t7xx/t7xx_pci.h
index 50b37056ce5a4..5dffe24ef37b4 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.h
+++ b/drivers/net/wwan/t7xx/t7xx_pci.h
@@ -69,6 +69,7 @@ struct t7xx_pci_dev {
 	struct t7xx_modem	*md;
 	struct t7xx_ccmni_ctrl	*ccmni_ctlb;
 	bool			rgu_pci_irq_en;
+	struct completion	init_done;
 
 	/* Low Power Items */
 	struct list_head	md_pm_entities;
-- 
2.39.2

