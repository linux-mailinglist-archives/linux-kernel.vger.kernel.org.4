Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5236460E94C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbiJZTng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235051AbiJZTms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:42:48 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3514FBCCF
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 12:42:34 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id f23so15202195plr.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 12:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OP/jpiXLlD32ihmuaQEisQ+o2cyp9ywlsHpK/BoVXYw=;
        b=jIbj4VPfhvDYQIKBdqCPB7rCCl8cb8N0uMtORU/8idM1msip0PJNFW8t1Tsq6UghFQ
         1NVt00V8DqN9+0rdST/hMLOLcAixEjGcC4+0AJtX6OPzOYc7mVA+cH/cYq9oKQY+vYPR
         Cr8pF7qUMSS4oL2KezQ3wAEovOTMTkvDVNa2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OP/jpiXLlD32ihmuaQEisQ+o2cyp9ywlsHpK/BoVXYw=;
        b=wyrcEbart3vRjnwA+yJSzkaApp8pwaTlianEmki3GDfmNUTjCt9ZMrUoYcqFwcRSSd
         MguVh9jQdIFq4BAT2zhK8Ga9GSNtNYlu9WWDB7K7R2ggViPHv0WVEsDAxoCOx7P57SRZ
         z+/Fj/+ERGsPxmWStXCGG+inDDRNBvweCJ6oumrCxePV5Ur40RpJyW8GuZH7JDzY74eB
         isp+25tolUwqg6WH1V6jzs3TY6k5Y9WD2HkoHfsbTjLOJrjidP10+vTtnl7DizsPcoQ/
         f1LwcvhxWcivOPfM5zj4zrfZvmmRvsbo3a0tV6IMxtPRoIpc/1HH+oq8lcsGLn8P9vVQ
         NsKA==
X-Gm-Message-State: ACrzQf05N8DDcxMb50l5f6AwCq4JaIzrcqAmYs90i864mMR0BtQsyaIB
        PL4NrOT/oNomXzJbsXgdlWYHcg==
X-Google-Smtp-Source: AMsMyM4Bs+rRHohZ2DACI+XW7RSFhufaX5l272kIQlvmDvY/No85n14oIKITViZzWTWJOu4fUf7wTw==
X-Received: by 2002:a17:902:b18d:b0:186:9bb5:a92 with SMTP id s13-20020a170902b18d00b001869bb50a92mr20552157plr.11.1666813354356;
        Wed, 26 Oct 2022 12:42:34 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:c9e3:74f3:6b2b:135])
        by smtp.gmail.com with UTF8SMTPSA id e21-20020a635015000000b004582e25a595sm3151642pgb.41.2022.10.26.12.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 12:42:33 -0700 (PDT)
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
Subject: [PATCH v4 3/7] mmc: sdhci-brcmstb: Fix SDHCI_RESET_ALL for CQHCI
Date:   Wed, 26 Oct 2022 12:42:05 -0700
Message-Id: <20221026124150.v4.3.I6a715feab6d01f760455865e968ecf0d85036018@changeid>
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

I only patch the bcm7216 variant even though others potentially *could*
provide the 'supports-cqe' property (and thus enable CQHCI), because
d46ba2d17f90 ("mmc: sdhci-brcmstb: Add support for Command Queuing
(CQE)") and some Broadcom folks confirm that only the 7216 variant
actually supports it.

This patch depends on (and should not compile without) the patch
entitled "mmc: cqhci: Provide helper for resetting both SDHCI and
CQHCI".

Fixes: d46ba2d17f90 ("mmc: sdhci-brcmstb: Add support for Command Queuing (CQE)")
Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---

Changes in v4:
 - Improve commit notes
 - Add Adrian's Ack
 - Add Florian's Reviewed-by

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

