Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B14D60E946
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbiJZTnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbiJZTm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:42:58 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2053E71BCB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 12:42:40 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9so4972341pll.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 12:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fb+b4UKJ1KFBJbCRol+gACElv5iiq7jjhJ1g0l5c5FA=;
        b=hRt2H2uD+wLrwvXTK0JSNIPjW4+1oJFPvSJZ/fA6Of0/Bd3NncRF9lJd0QMEKb+jA8
         tR2cfNMTkEpSuxO3w7B2BEY2iyQbOuw+XK/X0lgSDBOl61Htz/8xEX99DGyD3PlhAnxi
         zZ4KPXpdzi29DuB1ShNOgGOtr7Wl5nabY+T1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fb+b4UKJ1KFBJbCRol+gACElv5iiq7jjhJ1g0l5c5FA=;
        b=4yYemsOiKbj7HUpObA9/CC9OuK+/iBloqwF4p5cVB8917J+ln2thYp6W1dEgIKIdgq
         nAOf74ftR5Z5ReM0+fXtp9elN3zhcs2K53paB3h9Z746LzOFqhV1lXjnV06u/871HYSN
         /22aWpocNaE4e3Vuv6Vv2dg1SCmMoNTrIP6FoIrgTTIx+Kh6SS/Zj6z6Y10W5Lm33H0n
         6hCHYwnV+ZsDMgbF0qhVE39RFwlX1byyWtbqDLnAK1qaXoOnIXOXjaksZJe0wgT5Cs/S
         ipUKmXvgkniRj+af2z78xsh4jo5p9XtGCuPtskstEGeqmdUCQG+UxRwwXBmu+Koa3ddu
         QRPA==
X-Gm-Message-State: ACrzQf0dgMKWLDnYm5wLljZezGxzhBy+l7CiNIAVDObcDSGMt6AiUmWN
        dt32oqvMZNPvmV9aGsHNW77P4g==
X-Google-Smtp-Source: AMsMyM5EYvlE+qWcSFNr/Wmi9gu+0BErDUUQgt96JMzf6TmlgWUsQfqorUCkgXi+8DbCGGYaF8Lu4g==
X-Received: by 2002:a17:90a:428e:b0:205:d5fe:e0b3 with SMTP id p14-20020a17090a428e00b00205d5fee0b3mr5870742pjg.33.1666813359968;
        Wed, 26 Oct 2022 12:42:39 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:c9e3:74f3:6b2b:135])
        by smtp.gmail.com with UTF8SMTPSA id e10-20020a170902784a00b001811a197797sm3242401pln.194.2022.10.26.12.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 12:42:39 -0700 (PDT)
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
Subject: [PATCH v4 5/7] mmc: sdhci-tegra: Fix SDHCI_RESET_ALL for CQHCI
Date:   Wed, 26 Oct 2022 12:42:07 -0700
Message-Id: <20221026124150.v4.5.I418c9eaaf754880fcd2698113e8c3ef821a944d7@changeid>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To: <20221026194209.3758834-1-briannorris@chromium.org>
References: <20221026194209.3758834-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Fixes: 3c4019f97978 ("mmc: tegra: HW Command Queue Support for Tegra SDMMC")
Signed-off-by: Brian Norris <briannorris@chromium.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---

Changes in v4:
 - Add dependency notes
 - Add Adrian's Ack

Changes in v3:
 - Use new SDHCI+CQHCI helper

Changes in v2:
 - Drop unnecessary 'enable_hwcq' check

 drivers/mmc/host/sdhci-tegra.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 413925bce0ca..c71000a07656 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -28,6 +28,7 @@
 
 #include <soc/tegra/common.h>
 
+#include "sdhci-cqhci.h"
 #include "sdhci-pltfm.h"
 #include "cqhci.h"
 
@@ -367,7 +368,7 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 	const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
 	u32 misc_ctrl, clk_ctrl, pad_ctrl;
 
-	sdhci_reset(host, mask);
+	sdhci_and_cqhci_reset(host, mask);
 
 	if (!(mask & SDHCI_RESET_ALL))
 		return;
-- 
2.38.0.135.g90850a2211-goog

