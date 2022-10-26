Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060F660E950
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbiJZTns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbiJZTnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:43:00 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF207108256
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 12:42:42 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id f23so15202682plr.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 12:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFvAy1Yx9bF2vsbUT1HqGJtHQU9f7u8fB33iw92Qf8Q=;
        b=oKBbVUwj0ewG2ZP2F3fTEFFC5mwv4W+c9kZCqjl7JXd4iDbGJEY0AoQ8UYLEbFN5Ra
         0x7RjJ30MNig+oRb1brPsUeEwBwRiuFhggpgiWrCKI86pV0GVPWln+FXhDLy0iIYorOi
         D2M5OJERgyDjOH1XHcjM7eR7XT3klUoE64Go4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFvAy1Yx9bF2vsbUT1HqGJtHQU9f7u8fB33iw92Qf8Q=;
        b=NIELn19pzNK2aJnXCqTArl60az+mRrne8fRkYjP9lFVdqa1Sw42h6oV5JsbZy2f3dB
         MyuGYodi33OImsoNFuEiWMgWKeTVnO4U2AHcL/d3sqFPiXL0OEwWO4PceOJ+zE3rJ+6y
         b9TEdBe+6jOCh47p8yjR7fhFKnwG5JUFOAm2bSp+8xuhaMe/h56a4b0J28RXnzqIvqFg
         wa76j9NpC1qHRVwdYH4AFsUFCro/vLIV9QOtDFNvZyFu/bQGT3Z/tRlf7WDCV2m4G0JC
         zLU0AfwoMXdS4yZkS1C/8e4W+XIkVPwdXlkog3maHm6F0tc2OKh0qywsksYJVXu6sb16
         5Z3Q==
X-Gm-Message-State: ACrzQf009WvLbvGmasRht7j/8gkR1Rhrq74//zKReV6/wPdU5cYajk62
        HxRF7jFNiQ5rh0aj758nKFq5Tw==
X-Google-Smtp-Source: AMsMyM6/nAg3Qf2+rzXxGPfXINpJPMqGo03+LmGleFJ+vpTt0n0E2kkRProcj1N0J8vVNAWQ1Pjecg==
X-Received: by 2002:a17:90b:4a02:b0:213:63e7:d0b1 with SMTP id kk2-20020a17090b4a0200b0021363e7d0b1mr2659334pjb.208.1666813362670;
        Wed, 26 Oct 2022 12:42:42 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:c9e3:74f3:6b2b:135])
        by smtp.gmail.com with UTF8SMTPSA id p5-20020a17090ac00500b0020ae09e9724sm1424933pjt.53.2022.10.26.12.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 12:42:42 -0700 (PDT)
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
Subject: [PATCH v4 6/7] mmc: sdhci_am654: Fix SDHCI_RESET_ALL for CQHCI
Date:   Wed, 26 Oct 2022 12:42:08 -0700
Message-Id: <20221026124150.v4.6.I35ca9d6220ba48304438b992a76647ca8e5b126f@changeid>
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

Fixes: f545702b74f9 ("mmc: sdhci_am654: Add Support for Command Queuing Engine to J721E")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v4:
 - Also fix sdhci_am654_ops, sdhci_j721e_8bit_ops
 - Add dependency notes
 - Drop bouncing Faiz Abbas <faiz_abbas@ti.com> address

Changes in v3:
 - Use new SDHCI+CQHCI helper

 drivers/mmc/host/sdhci_am654.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 8f1023480e12..c2333c7acac9 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -15,6 +15,7 @@
 #include <linux/sys_soc.h>
 
 #include "cqhci.h"
+#include "sdhci-cqhci.h"
 #include "sdhci-pltfm.h"
 
 /* CTL_CFG Registers */
@@ -378,7 +379,7 @@ static void sdhci_am654_reset(struct sdhci_host *host, u8 mask)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
 
-	sdhci_reset(host, mask);
+	sdhci_and_cqhci_reset(host, mask);
 
 	if (sdhci_am654->quirks & SDHCI_AM654_QUIRK_FORCE_CDTEST) {
 		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
@@ -464,7 +465,7 @@ static struct sdhci_ops sdhci_am654_ops = {
 	.set_clock = sdhci_am654_set_clock,
 	.write_b = sdhci_am654_write_b,
 	.irq = sdhci_am654_cqhci_irq,
-	.reset = sdhci_reset,
+	.reset = sdhci_and_cqhci_reset,
 };
 
 static const struct sdhci_pltfm_data sdhci_am654_pdata = {
@@ -494,7 +495,7 @@ static struct sdhci_ops sdhci_j721e_8bit_ops = {
 	.set_clock = sdhci_am654_set_clock,
 	.write_b = sdhci_am654_write_b,
 	.irq = sdhci_am654_cqhci_irq,
-	.reset = sdhci_reset,
+	.reset = sdhci_and_cqhci_reset,
 };
 
 static const struct sdhci_pltfm_data sdhci_j721e_8bit_pdata = {
-- 
2.38.0.135.g90850a2211-goog

