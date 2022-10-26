Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BC360E94E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbiJZTni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbiJZTm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:42:56 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860C9105361
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 12:42:37 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id jo13so11595602plb.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 12:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y45Z9F5+/R9uqywDzN7icoG5SzFxInaah2IApmdYfxw=;
        b=Iy9rHMtN9Rv2jganlhmWgo4QVH8Z7RUUGpg2ylFrGCK3WZN2XS7hhrGR9N3EkAipMB
         Iwx6g7aDxY2T1V1+Jm761uVArvrg2ri/fPYwbk0fiE4ko/o4cdje9BwYuxpIrfgvmK72
         KB/rlobuS5mS4s+bNIjyb46By3UIsEOQ4qZwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y45Z9F5+/R9uqywDzN7icoG5SzFxInaah2IApmdYfxw=;
        b=w4LZCNjHR8rFCfS73SfTgfzk+HwrTA07NQztTTq3iCl916H0QwC+KGg0JF3KswOUlC
         CbyOrEl8dIbbEAV3p4OxPhDxHl/MjjTUj33J88T2fxy3fK//LHTF4o1FuFn1hScQrCNd
         a+5E00NfUwfk/q4U/7paN63HiO0OmU2YjU2yYZhkkMzaP1qII3nLKNQCF+VkFOZGJxgE
         e2YSTK79eQJgvu1F0vXWwNbJS4GkICrJ50GBpSjbpClfr//Bx4C8gfRjXkXTrV3Fct82
         BNo9e+/jHxPIrTGC+AJbnYocI38hrGFhz6nwULJTLdwcHigVIweqpq/W1jbCLERkL8x5
         1n2g==
X-Gm-Message-State: ACrzQf0bTaFCV4hEo1qrgMAGJ1+OZ/5Qr/nhb6iaTMm1matqWqleWhYY
        uZXz//Ybrxsi/uKGbFWF+j1O5iNqVDKt8w==
X-Google-Smtp-Source: AMsMyM6bJdMa7N5QxnACd3Ttb0ThzapeCiUxb/MbTJVAXotHLUcV2tMCdTodRYT9wH43R9ASc1A4qg==
X-Received: by 2002:a17:90b:1e49:b0:20b:36a3:aba6 with SMTP id pi9-20020a17090b1e4900b0020b36a3aba6mr6128720pjb.2.1666813357227;
        Wed, 26 Oct 2022 12:42:37 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:c9e3:74f3:6b2b:135])
        by smtp.gmail.com with UTF8SMTPSA id s27-20020aa78bdb000000b0056bc30e618dsm3341776pfd.38.2022.10.26.12.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 12:42:36 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Andy Gross <agross@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Al Cooper <alcooperx@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v4 4/7] mms: sdhci-esdhc-imx: Fix SDHCI_RESET_ALL for CQHCI
Date:   Wed, 26 Oct 2022 12:42:06 -0700
Message-Id: <20221026124150.v4.4.I7d01f9ad11bacdc9213dee61b7918982aea39115@changeid>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To: <20221026194209.3758834-1-briannorris@chromium.org>
References: <20221026194209.3758834-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Include this fix by way of the new sdhci_and_cqhci_reset() helper.

This patch depends on (and should not compile without) the patch
entitled "mmc: cqhci: Provide helper for resetting both SDHCI and
CQHCI".

Fixes: bb6e358169bf ("mmc: sdhci-esdhc-imx: add CMDQ support")
Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---

Changes in v4:
 - Add dependency notes
 - Add Adrian's Ack

Changes in v3:
 - Use new SDHCI+CQHCI helper
 - Add Reviewed-by

Changes in v2:
 - Drop unnecessary ESDHC_FLAG_CQHCI check

 drivers/mmc/host/sdhci-esdhc-imx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 55981b0f0b10..b297c3c360eb 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -25,6 +25,7 @@
 #include <linux/of_device.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pm_runtime.h>
+#include "sdhci-cqhci.h"
 #include "sdhci-pltfm.h"
 #include "sdhci-esdhc.h"
 #include "cqhci.h"
@@ -1288,7 +1289,7 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 
 static void esdhc_reset(struct sdhci_host *host, u8 mask)
 {
-	sdhci_reset(host, mask);
+	sdhci_and_cqhci_reset(host, mask);
 
 	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
-- 
2.38.0.135.g90850a2211-goog

