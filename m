Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FF460B780
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbiJXTX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbiJXTWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:22:02 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0D83AE66
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:57:22 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id s196so9308434pgs.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlyFLurvfH7029w8iwxQ1Sku/pg4fNXCW6GH7YT3X1o=;
        b=oFFypgAmtRSfdYpG2g2vzrpENnpBptPReooSwNKcKMviZOjIzHdqvDt9dal43yElrs
         pjMh+aBByGRMnMNHeptY6IphflqbfVd2BqYoYNmd7AMSahsxsSPrM47jqwMcKMV4XVBi
         tKrPXznD/J4GqIn/JRB0IhdbNpRPvrVOg2Pqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PlyFLurvfH7029w8iwxQ1Sku/pg4fNXCW6GH7YT3X1o=;
        b=1mjsmbcB5bIEVz0M5zy3aAZZrsn/sjCm70MyJbNBFwcZNJegYmh9wac8uD0ncp1wlF
         2lDe5tZ+nTkGKO0p9t9NZDnX83hwJzqVk5gO6hW9PU6hH8BAtYGPQ4hGLTiqLb1UwRlB
         v5HJWpN686gqWVRadFBG2FQmzKRjtgu9KElpek1I8fLWff4LbjMcAiMgXIMb+96LpGOk
         rAul+8JW4d7ioyyBUtPCglf8xNu7wesmdtYJlpiKpIRh8jbuVeD9kkP1Bh9L0ufg0Fpf
         Y8L3Dl0SlusvkXEe5vaKZyoGAwly3M2rYnc7rwfy7fGY6iReqgOdLEfMzBwSh7GlCnlT
         WN4w==
X-Gm-Message-State: ACrzQf0MHvWm8JhXRIXuAlOo5KILskyQnpFqFkVqhPxES0lqT95w6grN
        FzNtvROVhBEgYjN3UWB50SfGOQ==
X-Google-Smtp-Source: AMsMyM5aI4ESYUjnWx/ltF6ITQLbqR9WNBLs0vx0yVG9Dmuqqy2XQbiNxwdPWgnOeMLEHF8SpYrtzg==
X-Received: by 2002:a63:f755:0:b0:44b:e438:ef2f with SMTP id f21-20020a63f755000000b0044be438ef2fmr30101590pgk.314.1666634180688;
        Mon, 24 Oct 2022 10:56:20 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:808b:e2f6:edcf:ccb0])
        by smtp.gmail.com with UTF8SMTPSA id w20-20020a170902ca1400b001714e7608fdsm26385pld.256.2022.10.24.10.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 10:56:20 -0700 (PDT)
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
Subject: [PATCH v3 3/7] mmc: sdhci-brcmstb: Fix SDHCI_RESET_ALL for CQHCI
Date:   Mon, 24 Oct 2022 10:54:57 -0700
Message-Id: <20221024105229.v3.3.I6a715feab6d01f760455865e968ecf0d85036018@changeid>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To: <20221024175501.2265400-1-briannorris@chromium.org>
References: <20221024175501.2265400-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
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

Fixes: d46ba2d17f90 ("mmc: sdhci-brcmstb: Add support for Command Queuing (CQE)")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v3:
 - Use new SDHCI+CQHCI helper

Changes in v2:
 - Rely on cqhci_deactivate() to handle NULL cqe_private, instead of
   moving around CQE capability flags

 drivers/mmc/host/sdhci-brcmstb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index aff36a933ebe..55d8bd232695 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -12,6 +12,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 
+#include "sdhci-cqhci.h"
 #include "sdhci-pltfm.h"
 #include "cqhci.h"
 
@@ -55,7 +56,7 @@ static void brcmstb_reset(struct sdhci_host *host, u8 mask)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
 
-	sdhci_reset(host, mask);
+	sdhci_and_cqhci_reset(host, mask);
 
 	/* Reset will clear this, so re-enable it */
 	if (priv->flags & BRCMSTB_PRIV_FLAGS_GATE_CLOCK)
-- 
2.38.0.135.g90850a2211-goog

