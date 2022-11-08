Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37F3620B16
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 09:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbiKHIZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 03:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbiKHIZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 03:25:41 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3906E27B11
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 00:25:40 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 08 Nov 2022 17:25:39 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 97BB620584CE;
        Tue,  8 Nov 2022 17:25:39 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 8 Nov 2022 17:25:39 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 3A906B62B3;
        Tue,  8 Nov 2022 17:25:39 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 2/4] mmc: f-sdh30: Add support for non-removable media
Date:   Tue,  8 Nov 2022 17:25:31 +0900
Message-Id: <20221108082533.21384-3-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221108082533.21384-1-hayashi.kunihiko@socionext.com>
References: <20221108082533.21384-1-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To use F_SDH30 for non-removable meda like eMMC,
need to enable FORCE_CARD_INSERT bit to skip the delay for detection.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/mmc/host/sdhci_f_sdh30.c | 7 +++++++
 drivers/mmc/host/sdhci_f_sdh30.h | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
index 7f4553b28180..e7617a08276d 100644
--- a/drivers/mmc/host/sdhci_f_sdh30.c
+++ b/drivers/mmc/host/sdhci_f_sdh30.c
@@ -76,6 +76,13 @@ static void sdhci_f_sdh30_reset(struct sdhci_host *host, u8 mask)
 		ctl |= F_SDH30_CMD_DAT_DELAY;
 		sdhci_writel(host, ctl, F_SDH30_ESD_CONTROL);
 	}
+
+	if ((host->mmc->caps & MMC_CAP_NONREMOVABLE) &&
+	    !(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT)) {
+		ctl = sdhci_readl(host, F_SDH30_TEST);
+		ctl |= F_SDH30_FORCE_CARD_INSERT;
+		sdhci_writel(host, ctl, F_SDH30_TEST);
+	}
 }
 
 static const struct sdhci_ops sdhci_f_sdh30_ops = {
diff --git a/drivers/mmc/host/sdhci_f_sdh30.h b/drivers/mmc/host/sdhci_f_sdh30.h
index fc1ad28f7ca9..7c3c66291d42 100644
--- a/drivers/mmc/host/sdhci_f_sdh30.h
+++ b/drivers/mmc/host/sdhci_f_sdh30.h
@@ -29,4 +29,7 @@
 #define  F_SDH30_CMD_DAT_DELAY	BIT(9)
 #define	 F_SDH30_EMMC_HS200		BIT(24)
 
+#define F_SDH30_TEST		0x158
+#define F_SDH30_FORCE_CARD_INSERT	BIT(6)
+
 #define F_SDH30_MIN_CLOCK		400000
-- 
2.25.1

