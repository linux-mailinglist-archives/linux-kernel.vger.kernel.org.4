Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97C06022FD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiJRD6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiJRD5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:57:47 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547DD87FB1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 20:57:45 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so12869690pjl.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 20:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bYbVaurNHZoKZuiVprhZUwyKptjwry92NaACiNGGbI=;
        b=biCG5g3PRhSpx+svQLWgmgvOwtH++XWGKTkyE9UWOj6vpD7L1xDgNgA2bS7D6s5lzt
         6VCdakl25O4uQtiTkhYdpW2bJKszFrfsV48BRcAimQ2GDDRoq2nZg6E61fEGNtTw7cer
         IxKQK4PEAs9gKnrrzgPwkjW4YE6M2eNLHRR+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8bYbVaurNHZoKZuiVprhZUwyKptjwry92NaACiNGGbI=;
        b=V5qlh05x2UfHkVEynXTHDsLoySvD5XeDJaY89IxYharoDS6BKjdQG/GRy2lRwQ3nYf
         yiRClukxeL1GoJi0WGhV2ZmzklJOfBvEimXogF5XiHkMBzpW0V2E5Q/CRYYgSJoEPQ/v
         3Km72uLfZVXCTiGxSElxQGLjj6OY+5awBpeSkOSSWP/MoltD971B1k45iwzoQrHvDnwK
         9xjxR0SGwcwCVSpcm8MHii5wMkEecPY/WyIJv8QepIl5BosXSprveA5XzQ9y16o03eNV
         yPRrfDLGZLx63/+mqcuNJea1G2vg54hiLExbaVyKjkYVTFNIU9Cd508urfYDeDEtzeG8
         kPrQ==
X-Gm-Message-State: ACrzQf38zFjev1/rqPbawJdY21Az55mSs4xTwX4Mw4gUCmpTxmbxxzr7
        q7TnVucpUmt6hmOClAYfEs0w/g==
X-Google-Smtp-Source: AMsMyM4uYSizE6bAIrsyINpuEBbUqcSLImXqDRTQmFW3Z8JeyX3c+3AaBMWv5jKZI6sxwoXEXsVJdg==
X-Received: by 2002:a17:90b:3892:b0:20d:4bb5:91fe with SMTP id mu18-20020a17090b389200b0020d4bb591femr1296941pjb.31.1666065464699;
        Mon, 17 Oct 2022 20:57:44 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:2ac3:f4e2:e908:c393])
        by smtp.gmail.com with UTF8SMTPSA id k6-20020aa79986000000b0056186e8b29esm8229358pfh.96.2022.10.17.20.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 20:57:44 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Al Cooper <alcooperx@gmail.com>, linux-mmc@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        linux-arm-kernel@lists.infradead.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 3/5] mms: sdhci-esdhc-imx: Fix SDHCI_RESET_ALL for CQHCI
Date:   Mon, 17 Oct 2022 20:57:22 -0700
Message-Id: <20221017205610.3.I7d01f9ad11bacdc9213dee61b7918982aea39115@changeid>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221018035724.2061127-1-briannorris@chromium.org>
References: <20221018035724.2061127-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 [[ NOTE: this is completely untested by the author, but included solely
    because, as noted in commit df57d73276b8 ("mmc: sdhci-pci: Fix
    SDHCI_RESET_ALL for CQHCI for Intel GLK-based controllers"), "other
    drivers using CQHCI might benefit from a similar change, if they
    also have CQHCI reset by SDHCI_RESET_ALL." We've now seen the same
    bug on at least MSM, Arasan, and Intel hardware. ]]

SDHCI_RESET_ALL resets will reset the hardware CQE state, but we aren't
tracking that properly in software. When out of sync, we may trigger
various timeouts.

It's not typical to perform resets while CQE is enabled, but this may
occur in some suspend or error recovery scenarios.

Fixes: bb6e358169bf ("mmc: sdhci-esdhc-imx: add CMDQ support")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/mmc/host/sdhci-esdhc-imx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 55981b0f0b10..222c83929e20 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1288,6 +1288,13 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 
 static void esdhc_reset(struct sdhci_host *host, u8 mask)
 {
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+
+	if ((host->mmc->caps2 & MMC_CAP2_CQE) && (mask & SDHCI_RESET_ALL) &&
+	    imx_data->socdata->flags & ESDHC_FLAG_CQHCI)
+		cqhci_deactivate(host->mmc);
+
 	sdhci_reset(host, mask);
 
 	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
-- 
2.38.0.413.g74048e4d9e-goog

