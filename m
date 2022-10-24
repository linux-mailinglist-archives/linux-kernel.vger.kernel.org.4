Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC1860B752
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbiJXTWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbiJXTVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:21:45 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1145357FC
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:57:09 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so13700706pji.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDRHGSwf7KM6nOlEftMlpWT5HOavgsCjZBMurS4KgKQ=;
        b=N7qZz/zJfn8lrPYDgaQNbAKG2AbnWZeyNQLBZ7DHtw0LYdnjsr6ZX1FDH55nDDkMIo
         UcqYTJ9Nprz+nvahXLqZBr+tO2XbMHIwASvchpoIo1YliHu11CIR9y4k65EolzPxGa4N
         gtKpf+WRwwqv/Gv/eyY9jWWqok8HVyLx+4LSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDRHGSwf7KM6nOlEftMlpWT5HOavgsCjZBMurS4KgKQ=;
        b=u65xhfkdFZj4YY0k4+vg1tUdABgu88IdQCJbrak7AJJuQZ1zTK9AyP+hWEkXeq9bIP
         drZJuo8dD6Qg7scliTsdkNKXjKq0BP2wPcWvTxjOv/nkpj8n+Mv3QTyc8TAEs3WYuh8F
         myLdLC/H7KR7JKtAB24cgpgJDpT41hgMRd8nP+2fHYnwc5apQoFNhLtzc/oN9vW6SyKk
         HomGl9J7F7/CedQtJ+Fq9svYnkZL77bZGW03ZQKNrfC6X0RBR7ftYFLbNPcpBo3UjJj+
         YzPGuuvIyobNRPz4ZMZhhF7XO5aAOjuxis08yvqk07+J/YA986Koz57LQWkPht4jSgbc
         xuig==
X-Gm-Message-State: ACrzQf2ncjZz/nAqz62C+nHlSnGUYFUe6jf3M0vCi5z7l/0rlxmzFZk0
        kiYRId+8McSum8Fp7p4hBms/KQ==
X-Google-Smtp-Source: AMsMyM5BthOgJGA3ADerm/sDHRlf1tA0MU33oqIWE/gleggB4VstlKI4Rnx87QJKBubqXVFGk/KMNg==
X-Received: by 2002:a17:90a:c306:b0:211:8e5e:9a66 with SMTP id g6-20020a17090ac30600b002118e5e9a66mr29200392pjt.152.1666634183551;
        Mon, 24 Oct 2022 10:56:23 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:808b:e2f6:edcf:ccb0])
        by smtp.gmail.com with UTF8SMTPSA id mr2-20020a17090b238200b0021301a63e86sm2386229pjb.18.2022.10.24.10.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 10:56:23 -0700 (PDT)
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
Subject: [PATCH v3 4/7] mms: sdhci-esdhc-imx: Fix SDHCI_RESET_ALL for CQHCI
Date:   Mon, 24 Oct 2022 10:54:58 -0700
Message-Id: <20221024105229.v3.4.I7d01f9ad11bacdc9213dee61b7918982aea39115@changeid>
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

Fixes: bb6e358169bf ("mmc: sdhci-esdhc-imx: add CMDQ support")
Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
---

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

