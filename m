Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438EF60B76A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbiJXTXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbiJXTVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:21:54 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99591E718
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:57:24 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y1so9613490pfr.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBU82kTAb6ejCzCPdRzJommk6OJkr5XyNm4aFLMb1Lo=;
        b=RnX9z/EyXFWaUQ4+NHwDXdpAWxW+FR9R8nm39w0AaYU9kdznNu4IHmM6GSKF4cRcV4
         aRfuhZxa9CM2GIlk54VdFm5ss32J0pIw9JiN4zYfVZ12g2Llv4W2LoC94v4PMZ40bAzx
         3kA73t9lBnjmWm9QMfq36+K1fqNixXiAfEkTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kBU82kTAb6ejCzCPdRzJommk6OJkr5XyNm4aFLMb1Lo=;
        b=7kWrDHkwhHmSBPGfoefn4wAhTWtRaolAg+CY4uHrkdIUAuXL2VU+aUULLktzmL9jqS
         rmn2oT9U3WgeTrH4XaUJizoAHDlL4HxNCKMFJuq4PPMOmjyaQwVXckfTo2OCQxP5W3ZQ
         cAnwXZ/29h84K/99JXNaZmafK+VTIgLO3dIAPL2U1BiqsQl1P4DuEQ0WFkTt5mIBLPYW
         zIiCO62y3E1iZAdMgQmvUbdj1CrVic9u1KAPLBdB2XBuGH7rLY84b9uLVanWDWkfhnFB
         lgpEUDj5wUl6YaUgLJmpmgd8gM5dFcDKkbeszNDQcuJUfw37miSmLYaaWuuhDYWnYDAO
         KWDA==
X-Gm-Message-State: ACrzQf3yLn7EcyYOq5hPtRJ623Vs1vPKfIwydNjkQnoNFvmPJbcygmqn
        fP7ixJ4dTWobX8D3VSTdeSM65g==
X-Google-Smtp-Source: AMsMyM6Hp0vgunlSJu4/TCH07DNhzYhxDd1XyT5BfXLbDyfeI3MU6gI+gnXmu+1SQyl1XKUTxmYmYQ==
X-Received: by 2002:a62:1a97:0:b0:562:5587:12d6 with SMTP id a145-20020a621a97000000b00562558712d6mr34124134pfa.37.1666634192416;
        Mon, 24 Oct 2022 10:56:32 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:808b:e2f6:edcf:ccb0])
        by smtp.gmail.com with UTF8SMTPSA id b1-20020a1709027e0100b00176a6ba5969sm39531plm.98.2022.10.24.10.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 10:56:32 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org,
        Al Cooper <alcooperx@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>,
        Andy Gross <agross@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Faiz Abbas <faiz_abbas@ti.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v3 7/7] mmc: sdhci-*: Convert drivers to new sdhci_and_cqhci_reset()
Date:   Mon, 24 Oct 2022 10:55:01 -0700
Message-Id: <20221024105229.v3.7.Ia91f031f5f770af7bd2ff3e28b398f277606d970@changeid>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To: <20221024175501.2265400-1-briannorris@chromium.org>
References: <20221024175501.2265400-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An earlier patch ("mmc: cqhci: Provide helper for resetting both SDHCI
and CQHCI") does these operations for us.

I keep these as a separate patch, since the earlier patch is a
prerequisite to some important bugfixes that need to be backported via
linux-stable.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v3:
 - Rewrite to new helper, patch sdhci-msm too

Changes in v2:
 - Factor out ->cqe_private helpers

 drivers/mmc/host/sdhci-msm.c      | 10 ++--------
 drivers/mmc/host/sdhci-pci-core.c | 11 ++---------
 drivers/mmc/host/sdhci-pci-gli.c  | 11 ++---------
 3 files changed, 6 insertions(+), 26 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 3a091a387ecb..03f76384ab3f 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -19,6 +19,7 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/reset.h>
 
+#include "sdhci-cqhci.h"
 #include "sdhci-pltfm.h"
 #include "cqhci.h"
 
@@ -2304,13 +2305,6 @@ static void sdhci_msm_set_regulator_caps(struct sdhci_msm_host *msm_host)
 	pr_debug("%s: supported caps: 0x%08x\n", mmc_hostname(mmc), caps);
 }
 
-static void sdhci_msm_reset(struct sdhci_host *host, u8 mask)
-{
-	if ((host->mmc->caps2 & MMC_CAP2_CQE) && (mask & SDHCI_RESET_ALL))
-		cqhci_deactivate(host->mmc);
-	sdhci_reset(host, mask);
-}
-
 static int sdhci_msm_register_vreg(struct sdhci_msm_host *msm_host)
 {
 	int ret;
@@ -2450,7 +2444,7 @@ static const struct of_device_id sdhci_msm_dt_match[] = {
 MODULE_DEVICE_TABLE(of, sdhci_msm_dt_match);
 
 static const struct sdhci_ops sdhci_msm_ops = {
-	.reset = sdhci_msm_reset,
+	.reset = sdhci_and_cqhci_reset,
 	.set_clock = sdhci_msm_set_clock,
 	.get_min_clock = sdhci_msm_get_min_clock,
 	.get_max_clock = sdhci_msm_get_max_clock,
diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 169b84761041..cc039155b5c7 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -38,6 +38,7 @@
 #include "cqhci.h"
 
 #include "sdhci.h"
+#include "sdhci-cqhci.h"
 #include "sdhci-pci.h"
 
 static void sdhci_pci_hw_reset(struct sdhci_host *host);
@@ -234,14 +235,6 @@ static void sdhci_pci_dumpregs(struct mmc_host *mmc)
 	sdhci_dumpregs(mmc_priv(mmc));
 }
 
-static void sdhci_cqhci_reset(struct sdhci_host *host, u8 mask)
-{
-	if ((host->mmc->caps2 & MMC_CAP2_CQE) && (mask & SDHCI_RESET_ALL) &&
-	    host->mmc->cqe_private)
-		cqhci_deactivate(host->mmc);
-	sdhci_reset(host, mask);
-}
-
 /*****************************************************************************\
  *                                                                           *
  * Hardware specific quirk handling                                          *
@@ -703,7 +696,7 @@ static const struct sdhci_ops sdhci_intel_glk_ops = {
 	.set_power		= sdhci_intel_set_power,
 	.enable_dma		= sdhci_pci_enable_dma,
 	.set_bus_width		= sdhci_set_bus_width,
-	.reset			= sdhci_cqhci_reset,
+	.reset			= sdhci_and_cqhci_reset,
 	.set_uhs_signaling	= sdhci_intel_set_uhs_signaling,
 	.hw_reset		= sdhci_pci_hw_reset,
 	.irq			= sdhci_cqhci_irq,
diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 4d509f656188..633a8ee8f8c5 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -15,6 +15,7 @@
 #include <linux/of.h>
 #include <linux/iopoll.h>
 #include "sdhci.h"
+#include "sdhci-cqhci.h"
 #include "sdhci-pci.h"
 #include "cqhci.h"
 
@@ -922,14 +923,6 @@ static int gl9763e_add_host(struct sdhci_pci_slot *slot)
 	return ret;
 }
 
-static void sdhci_gl9763e_reset(struct sdhci_host *host, u8 mask)
-{
-	if ((host->mmc->caps2 & MMC_CAP2_CQE) && (mask & SDHCI_RESET_ALL) &&
-	    host->mmc->cqe_private)
-		cqhci_deactivate(host->mmc);
-	sdhci_reset(host, mask);
-}
-
 static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
 {
 	struct pci_dev *pdev = slot->chip->pdev;
@@ -1136,7 +1129,7 @@ static const struct sdhci_ops sdhci_gl9763e_ops = {
 	.set_clock		= sdhci_set_clock,
 	.enable_dma		= sdhci_pci_enable_dma,
 	.set_bus_width		= sdhci_set_bus_width,
-	.reset			= sdhci_gl9763e_reset,
+	.reset			= sdhci_and_cqhci_reset,
 	.set_uhs_signaling	= sdhci_set_gl9763e_signaling,
 	.voltage_switch		= sdhci_gli_voltage_switch,
 	.irq                    = sdhci_gl9763e_cqhci_irq,
-- 
2.38.0.135.g90850a2211-goog

