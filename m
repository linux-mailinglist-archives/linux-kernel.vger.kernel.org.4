Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980656D1E98
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 12:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjCaK7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 06:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjCaK6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 06:58:44 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360FB1F792;
        Fri, 31 Mar 2023 03:57:06 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n14so5007108plc.8;
        Fri, 31 Mar 2023 03:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680260223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYAJZrrmPDxkvadC2nk65J6PT+UmOKiqvEkS1eMtgqA=;
        b=p8gyTC/4ugFMOo0es9UFLm2LbJvpmSnkrRAuPb5Gu8IefYRfrWJQgGu0PviEsO3Dx5
         8RNScoffG6T+tISDt9fR1eMzmf9n3ru7lXh/f/665cXZbAGV9AkTgcA1dIBNfpP/aiCx
         c/KqhR/tAsusPhX2K8mgwJDu1OavdLUXRff0YiQKoB1LmAPoCrZIs/cLcwvZZwJWY16M
         LArPmICAxbGoXpAzFUVyDnYHH3HAsLHqHJbqbDRlMTl7atlFCKHChjNOXvt7QuLn+Ai7
         FCNBZ1B1f78GFdaxz0x6tuTTf4nSMqtlPtcZHaBTeUaaqpidGKxnjqs52ptKUkvgBpqN
         NTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680260223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYAJZrrmPDxkvadC2nk65J6PT+UmOKiqvEkS1eMtgqA=;
        b=JVFLQ5BlegbYU9n1EUx34OKnb+f2McXi62FDj1mbSstGOX8f8xznF+fdXsrJeVraxg
         7dsVddzNiYtRpxJudz6rvECbN0bpK1ZMeYWnqDLi4bnZxgNg5sPEQqkNkA+2Fp+bZiy7
         S2tqIPTf7v5c2nLIoWpxZXGUidI6rmwovIgMK2ot4WeCYDaHLR6zpFxOCHeqFf2abnuh
         QFAhkIgFcjxyoxyyphSIsduQLabniDGylOMwQuU/3dC6Ia3wODIUG+iJzlIMgdGKgDvW
         x8wgeEhUE/IaroMedeE/nnFzZRoeFW/BKjUVSjAE73pw6gsxDIe4zq1X7+0gSal335XX
         8g/Q==
X-Gm-Message-State: AAQBX9f3cDabCoHUb+gyKQdG3CZfLplHEIIKTTix+uSAa3b9EDmOHqdJ
        dRI/whxg0ZkNeYbrF/jCZMo=
X-Google-Smtp-Source: AKy350b3Zmc2tnlwXIM9k3hU/zR4Lpgr3ik4qVYFtPYPwztbxafjhi0VMTTHDikgQE28PtO0td7VHw==
X-Received: by 2002:a17:902:ce8e:b0:1a2:940c:e452 with SMTP id f14-20020a170902ce8e00b001a2940ce452mr4233954plg.9.1680260223728;
        Fri, 31 Mar 2023 03:57:03 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e25c-983f-c7ff-3efd-77d9-6c16.emome-ip6.hinet.net. [2001:b400:e25c:983f:c7ff:3efd:77d9:6c16])
        by smtp.gmail.com with ESMTPSA id f19-20020a170902e99300b0019acd3151d0sm1287665plb.114.2023.03.31.03.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 03:57:03 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V7 22/23] mmc: sdhci-pci: add UHS-II support framework
Date:   Fri, 31 Mar 2023 18:55:45 +0800
Message-Id: <20230331105546.13607-23-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230331105546.13607-1-victor.shih@genesyslogic.com.tw>
References: <20230331105546.13607-1-victor.shih@genesyslogic.com.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

This patch prepares for adding UHS-II support at a specific UHS-II
capable sdhci-pci controller, GL9755 for now.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/sdhci-pci-core.c | 16 +++++++++++++++-
 drivers/mmc/host/sdhci-pci.h      |  3 +++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 01975d145200..6b5109f7feef 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -40,6 +40,7 @@
 #include "sdhci.h"
 #include "sdhci-cqhci.h"
 #include "sdhci-pci.h"
+#include "sdhci-uhs2.h"
 
 static void sdhci_pci_hw_reset(struct sdhci_host *host);
 
@@ -2155,7 +2156,10 @@ static void sdhci_pci_remove_slot(struct sdhci_pci_slot *slot)
 	if (scratch == (u32)-1)
 		dead = 1;
 
-	sdhci_remove_host(slot->host, dead);
+	if (slot->chip->fixes && slot->chip->fixes->remove_host)
+		slot->chip->fixes->remove_host(slot, dead);
+	else
+		sdhci_remove_host(slot->host, dead);
 
 	if (slot->chip->fixes && slot->chip->fixes->remove_slot)
 		slot->chip->fixes->remove_slot(slot, dead);
@@ -2163,6 +2167,16 @@ static void sdhci_pci_remove_slot(struct sdhci_pci_slot *slot)
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
index 3661a224fb04..7f4a981c0e63 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -140,6 +140,7 @@ struct sdhci_pci_fixes {
 	int			(*probe_slot) (struct sdhci_pci_slot *);
 	int			(*add_host) (struct sdhci_pci_slot *);
 	void			(*remove_slot) (struct sdhci_pci_slot *, int);
+	void			(*remove_host) (struct sdhci_pci_slot *, int);
 
 #ifdef CONFIG_PM_SLEEP
 	int			(*suspend) (struct sdhci_pci_chip *);
@@ -184,6 +185,8 @@ static inline void *sdhci_pci_priv(struct sdhci_pci_slot *slot)
 	return (void *)slot->private;
 }
 
+int sdhci_pci_uhs2_add_host(struct sdhci_pci_slot *slot);
+void sdhci_pci_uhs2_remove_host(struct sdhci_pci_slot *slot, int dead);
 #ifdef CONFIG_PM_SLEEP
 int sdhci_pci_resume_host(struct sdhci_pci_chip *chip);
 #endif
-- 
2.25.1

