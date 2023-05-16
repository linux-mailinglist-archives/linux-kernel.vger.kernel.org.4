Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F25A704747
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjEPIE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjEPIEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:04:23 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590194492;
        Tue, 16 May 2023 01:04:21 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 1118540203;
        Tue, 16 May 2023 08:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684224259;
        bh=HM165daVVQlgsXpSYpBed1TlG1Fivc1kTbICBUtM1fY=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=tLYBale+26PODPoS1VF+h6hLhTA1nVg0JrdCtmmL0KuYEfVG6PAheebGbw7kjPzbN
         6i5C/D2P9pFO4pkk1xROlDyRyEKLOGk3UHkO1tdo6l7c/SkQTXC11ukItYbKlE0BkC
         VShaetH7mco8w9HFAppmHL/PXPQhnvPcWhRGWZd69EFPhr2KUYNPVz0spC5xfXSm9v
         ReoJSrYFMJMX/OKYMyJovKxwvo1XsYhfLFLeGCuetAn26ytB2kw6Q5gPwDFzV19ERs
         sLXVAHIoLr2YfVNC1b7+i01xqgr6hZSwtZ6sRvbqnqvr/sWNhbs8KdGfOOBdtVjSIV
         9nNA24Z5mbJZA==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     chandrashekar.devegowda@intel.com, linuxwwan@intel.com,
        chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
        m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: wwan: t7xx: Ensure init is completed before system sleep
Date:   Tue, 16 May 2023 16:03:27 +0800
Message-Id: <20230516080327.359825-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/net/wwan/t7xx/t7xx_pci.c | 15 +++++++++++++++
 drivers/net/wwan/t7xx/t7xx_pci.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index 226fc1703e90..7ae85f09cdbf 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -96,6 +96,7 @@ static int t7xx_pci_pm_init(struct t7xx_pci_dev *t7xx_dev)
 	spin_lock_init(&t7xx_dev->md_pm_lock);
 	init_completion(&t7xx_dev->sleep_lock_acquire);
 	init_completion(&t7xx_dev->pm_sr_ack);
+	init_completion(&t7xx_dev->init_done);
 	atomic_set(&t7xx_dev->md_pm_state, MTK_PM_INIT);
 
 	device_init_wakeup(&pdev->dev, true);
@@ -124,6 +125,7 @@ void t7xx_pci_pm_init_late(struct t7xx_pci_dev *t7xx_dev)
 	pm_runtime_mark_last_busy(&t7xx_dev->pdev->dev);
 	pm_runtime_allow(&t7xx_dev->pdev->dev);
 	pm_runtime_put_noidle(&t7xx_dev->pdev->dev);
+	complete_all(&t7xx_dev->init_done);
 }
 
 static int t7xx_pci_pm_reinit(struct t7xx_pci_dev *t7xx_dev)
@@ -529,6 +531,18 @@ static void t7xx_pci_shutdown(struct pci_dev *pdev)
 	__t7xx_pci_pm_suspend(pdev);
 }
 
+static int t7xx_pci_pm_prepare(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct t7xx_pci_dev *t7xx_dev;
+
+	t7xx_dev = pci_get_drvdata(pdev);
+	if (!wait_for_completion_timeout(&t7xx_dev->init_done, 20 * HZ))
+		dev_warn(dev, "Not ready for system sleep.\n");
+
+	return 0;
+}
+
 static int t7xx_pci_pm_suspend(struct device *dev)
 {
 	return __t7xx_pci_pm_suspend(to_pci_dev(dev));
@@ -555,6 +569,7 @@ static int t7xx_pci_pm_runtime_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops t7xx_pci_pm_ops = {
+	.prepare = t7xx_pci_pm_prepare,
 	.suspend = t7xx_pci_pm_suspend,
 	.resume = t7xx_pci_pm_resume,
 	.resume_noirq = t7xx_pci_pm_resume_noirq,
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.h b/drivers/net/wwan/t7xx/t7xx_pci.h
index 112efa534eac..f08f1ab74469 100644
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
2.34.1

