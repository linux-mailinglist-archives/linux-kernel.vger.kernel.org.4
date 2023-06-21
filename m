Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC90473819A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbjFUKFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbjFUKDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:03:11 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E6FEA;
        Wed, 21 Jun 2023 03:03:06 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6686a1051beso3253933b3a.1;
        Wed, 21 Jun 2023 03:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687341785; x=1689933785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TFHaGnPfVE9XWAj0fyIImNZyIreKQulej0ovAEzb6Wk=;
        b=Ov7ckJfi2UtOBfTdn6F1HXOOiTa/Y9YeINzohtvVJnahy+LAPFlaKiYegYkdIwibhT
         h3cPK0jPqFvcTfFKJ+NTcUNSduKK5dBLBGpb7gE/HhR4bco9FMS5XZFYhcegC+eZZtyS
         cyKYQeJk8QLssHt2/DfIvalvX4hYt3xaJhhpPX/Oxp8dSRbbcpdY63QJZHRtXZR8tA4o
         irFGHWOp3v46SHQGh2jfZL+C54NiHIOugygzMY7am/UUVNgcAcGyVeszug5KkxKyR+Gv
         9xt3TzDXx2rW0VGmVrRVxlEZ8zJl5NrVsVvHjlVXxiaBEvtev81Hh+QFNUCvkKvJCjBJ
         3bKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687341785; x=1689933785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TFHaGnPfVE9XWAj0fyIImNZyIreKQulej0ovAEzb6Wk=;
        b=JbByQS6KxY0oMog1Rg/9V3KN4ywWxXwk0/ZvWgKU0xr3F2MwCjDxxRJNhHDy8tBod6
         l/5++Z4he42U5PSGCeY12IXAanS0arAeKk55Uepl/rMC3ydlF3ZG21gSxzzZIU7uCgsb
         8F1KzuLOUo3O87Rek7zQ39Z4+KPmgwzOXGcmitl6YFggSnU+qov/e6Db5nXC8IpAGoeM
         W1Dz152Nky54cImY/aa8oLQ4Vk7slAPF2rQBiO4X3c+sI9gZf+jbj37m8De56jzYE5b6
         vJ8Q58LsUfMhSdd9+1dNC33ZaAkl/0FGO0fyYp/PNb0j1/d96oKmb1ve+F3MpBRQmHKd
         NC6w==
X-Gm-Message-State: AC+VfDy1E6Vk5k0T+FM2k4Rt8z4BLAKu2Fie2Y2KGnT9BlaIAgmDaFDx
        9YK5y2c0rIfC1kVT+K9Vm1g=
X-Google-Smtp-Source: ACHHUZ56BzrRCA1xv+9qM/+NyEZkXX0ORubYcihYMIkp/O4eERchMsUUwO4132T0zF8pWApbkEaESQ==
X-Received: by 2002:a05:6a00:1950:b0:64f:52c9:ddd5 with SMTP id s16-20020a056a00195000b0064f52c9ddd5mr19690342pfk.34.1687341785430;
        Wed, 21 Jun 2023 03:03:05 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e254-4eda-2716-05ea-20f5-b048.emome-ip6.hinet.net. [2001:b400:e254:4eda:2716:5ea:20f5:b048])
        by smtp.gmail.com with ESMTPSA id g2-20020aa78742000000b0064f46570bb7sm2611196pfo.167.2023.06.21.03.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 03:03:05 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V8 22/23] mmc: sdhci-pci: add UHS-II support framework
Date:   Wed, 21 Jun 2023 18:01:50 +0800
Message-Id: <20230621100151.6329-23-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230621100151.6329-1-victorshihgli@gmail.com>
References: <20230621100151.6329-1-victorshihgli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Victor Shih <victor.shih@genesyslogic.com.tw>

This patch prepares for adding UHS-II support at a specific UHS-II
capable sdhci-pci controller, GL9755 for now.

Updates in V8:
 - Add config select MMC_SDHCI_UHS2 in Kconfig.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/Kconfig          |  1 +
 drivers/mmc/host/sdhci-pci-core.c | 16 +++++++++++++++-
 drivers/mmc/host/sdhci-pci.h      |  3 +++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 215f1ab011dd..aa178384de16 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -111,6 +111,7 @@ config MMC_SDHCI_PCI
 	tristate "SDHCI support on PCI bus"
 	depends on MMC_SDHCI && PCI
 	select MMC_CQHCI
+	select MMC_SDHCI_UHS2
 	select IOSF_MBI if X86
 	select MMC_SDHCI_IO_ACCESSORS
 	help
diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 1c2572c0f012..e84c2db41a70 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -40,6 +40,7 @@
 #include "sdhci.h"
 #include "sdhci-cqhci.h"
 #include "sdhci-pci.h"
+#include "sdhci-uhs2.h"
 
 static void sdhci_pci_hw_reset(struct sdhci_host *host);
 
@@ -2156,7 +2157,10 @@ static void sdhci_pci_remove_slot(struct sdhci_pci_slot *slot)
 	if (scratch == (u32)-1)
 		dead = 1;
 
-	sdhci_remove_host(slot->host, dead);
+	if (slot->chip->fixes && slot->chip->fixes->remove_host)
+		slot->chip->fixes->remove_host(slot, dead);
+	else
+		sdhci_remove_host(slot->host, dead);
 
 	if (slot->chip->fixes && slot->chip->fixes->remove_slot)
 		slot->chip->fixes->remove_slot(slot, dead);
@@ -2164,6 +2168,16 @@ static void sdhci_pci_remove_slot(struct sdhci_pci_slot *slot)
 	sdhci_free_host(slot->host);
 }
 
+int sdhci_pci_uhs2_add_host(struct sdhci_pci_slot *slot)
+{
+	return sdhci_uhs2_add_host(slot->host);
+}
+
+void sdhci_pci_uhs2_remove_host(struct sdhci_pci_slot *slot, int dead)
+{
+	sdhci_uhs2_remove_host(slot->host, dead);
+}
+
 static void sdhci_pci_runtime_pm_allow(struct device *dev)
 {
 	pm_suspend_ignore_children(dev, 1);
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index 9c8863956381..d5c9f02f3e14 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -141,6 +141,7 @@ struct sdhci_pci_fixes {
 	int			(*probe_slot) (struct sdhci_pci_slot *);
 	int			(*add_host) (struct sdhci_pci_slot *);
 	void			(*remove_slot) (struct sdhci_pci_slot *, int);
+	void			(*remove_host) (struct sdhci_pci_slot *, int);
 
 #ifdef CONFIG_PM_SLEEP
 	int			(*suspend) (struct sdhci_pci_chip *);
@@ -185,6 +186,8 @@ static inline void *sdhci_pci_priv(struct sdhci_pci_slot *slot)
 	return (void *)slot->private;
 }
 
+int sdhci_pci_uhs2_add_host(struct sdhci_pci_slot *slot);
+void sdhci_pci_uhs2_remove_host(struct sdhci_pci_slot *slot, int dead);
 #ifdef CONFIG_PM_SLEEP
 int sdhci_pci_resume_host(struct sdhci_pci_chip *chip);
 #endif
-- 
2.25.1

