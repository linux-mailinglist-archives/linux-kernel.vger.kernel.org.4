Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAAC673059
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 05:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjASE3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 23:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjASDoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 22:44:46 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D1747EE2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 19:42:05 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id f3so525013pgc.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 19:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ASmDPbaFuzX/ldCl1/F7wg3DR9HkEcxMnn+qoW/V/nU=;
        b=ArzbdiscwYK3LdiDxnVNtk27XCCAlI9lq1kbQw4doLJ6phSV5thQZOtfefJWLRfV7H
         090zxFfGUaLGQ1rGtoqfnPL3cM6HdtwEaQckbiWfrvfwh57pCrrysUVe46GmWQE88uOR
         CLPzRDPinaXOOmr7dloKda4tuBnGl8U7GaviHBDZavJYB5tqzsD1RF31UWzDlXhaS4ip
         6kN0UwtTPReGD2/gdFdb/V8d2Ik93GTOQKibpzLbymR4CCo25QZ3w1T/6AdmnQR33jQI
         elw2UFQEW1Pmc8LAvAn9avORR/XbPDqTE/eLt+ce+018203EA8OkxEJV3Rcx/taEiKbg
         mhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ASmDPbaFuzX/ldCl1/F7wg3DR9HkEcxMnn+qoW/V/nU=;
        b=J1Blf/zGjdn5LzQlNX5X7i3XO8y6DRVXfO3NNXilgPFHV//8hSFLY37yB/KhNRDfY1
         Ta3rbJn6900TpFXBQUaUeXvnQcKqJo/klE/Hwv5dcTwaB+QvLDd0Af4MduPkdDdrwMUr
         Ll+efjo4xJzl9+CpEwRCAcBMv5yDim0N48gwjizEWM9WYQb4XcNq389prCBHSlCMllhR
         Z0SWGQbdelBOUZ7SrmsvpOvIj//TdBb9f6VmtYrCul1b+pLTsDP9aJSqcIe62e1UayT3
         wMlTfwhAUB4kvmf+eYOSXel5cNOCIA/l4+Oc+9RpVysh2+gj+UQXhgrbeL1xM4OQwkTQ
         y7IA==
X-Gm-Message-State: AFqh2ko4QCKF1pYB0ribDBvi/Xudwe9yj4NlAoYI89/aJkqWvli/6Zck
        Hh7zVQz7JgpXvOSi72ZoZ2pb6Q==
X-Google-Smtp-Source: AMrXdXuu2bbbJ+y9jJKSyzK4PNrSoOdtJ85nSenFoxceQUj0FfJjm9/vkytvnYHzhE7psWYSMsTRZw==
X-Received: by 2002:a05:6a00:288c:b0:586:8ead:a8e8 with SMTP id ch12-20020a056a00288c00b005868eada8e8mr10806412pfb.8.1674099679068;
        Wed, 18 Jan 2023 19:41:19 -0800 (PST)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id f13-20020aa7968d000000b0056b4c5dde61sm11097879pfk.98.2023.01.18.19.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 19:41:18 -0800 (PST)
From:   Brad Larson <brad@pensando.io>
X-Google-Original-From: Brad Larson <blarson@amd.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        brad@pensando.io, blarson@amd.com, brendan.higgins@linux.dev,
        briannorris@chromium.org, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, davidgow@google.com, gsomlo@gmail.com,
        gerg@linux-m68k.org, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        ulf.hansson@linaro.org, vaishnav.a@ti.com, will@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v9 14/15] mmc: sdhci-cadence: Support mmc hardware reset
Date:   Wed, 18 Jan 2023 19:39:17 -0800
Message-Id: <20230119033918.44117-15-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230119033918.44117-1-blarson@amd.com>
References: <20230119033918.44117-1-blarson@amd.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for mmc hardware reset using a reset-controller
that would need to be enabled in the device tree with
a supporting driver.  The default is disabled for all
existing designs.

Signed-off-by: Brad Larson <blarson@amd.com>
---

Changes since v6:
- Previously patch 17/17
- Changed delay after reset_control_assert() from 9 to 3 usec
- Renamed sdhci_mmc_hw_reset() to sdhci_cdns_mmc_hw_reset()

---
 drivers/mmc/host/sdhci-cadence.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index e92aa79a8be2..62321cef41db 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -12,6 +12,7 @@
 #include <linux/mmc/mmc.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/reset.h>
 
 #include "sdhci-pltfm.h"
 
@@ -70,6 +71,7 @@ struct sdhci_cdns_priv {
 	spinlock_t wrlock;	/* write lock */
 	bool enhanced_strobe;
 	void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val, void __iomem *reg);
+	struct reset_control *rst_hw;
 	unsigned int nr_phy_params;
 	struct sdhci_cdns_phy_param phy_params[];
 };
@@ -458,6 +460,24 @@ static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
 					 SDHCI_CDNS_HRS06_MODE_MMC_HS400);
 }
 
+extern unsigned int sdhci_timeout_val;
+
+static void sdhci_cdns_mmc_hw_reset(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
+
+	dev_dbg(mmc_dev(host->mmc), "emmc hardware reset\n");
+
+	reset_control_assert(priv->rst_hw);
+	/* For eMMC, minimum is 1us but give it 3us for good measure */
+	udelay(3);
+
+	reset_control_deassert(priv->rst_hw);
+	/* For eMMC, minimum is 200us but give it 300us for good measure */
+	usleep_range(300, 1000);
+}
+
 static int sdhci_cdns_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
@@ -521,6 +541,17 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	if (ret)
 		goto free;
 
+	if (host->mmc->caps & MMC_CAP_HW_RESET) {
+		priv->rst_hw = devm_reset_control_get_optional_exclusive(dev, "hw");
+		if (IS_ERR(priv->rst_hw)) {
+			ret = PTR_ERR(priv->rst_hw);
+			if (ret == -ENOENT)
+				priv->rst_hw = NULL;
+		} else {
+			host->mmc_host_ops.card_hw_reset = sdhci_cdns_mmc_hw_reset;
+		}
+	}
+
 	ret = sdhci_add_host(host);
 	if (ret)
 		goto free;
-- 
2.17.1

