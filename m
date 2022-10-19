Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BAF60525D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 23:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbiJSVzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 17:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiJSVzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 17:55:23 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC47116CA66
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 14:55:20 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-132af5e5543so22327887fac.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 14:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wydu2mgXy/Ti5pZeMNO0oB2V13SqCsRFUj9VGtENhPc=;
        b=ChDSlokPNsjy2o/57nhAg7mfMjZkGB61uN8KGokp5uFWwk9gAqAvvQdsKuPhhf4Er9
         wmKVQHHL8CkIAihTw0hRaEFTwdI+sSmSvrHn8I7fE03IUF48Nd0r5X/3gjaqFYEsNSKg
         5Er7iJ8I6HnyOcMvqA10t1iAAiUYMokHH21IE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wydu2mgXy/Ti5pZeMNO0oB2V13SqCsRFUj9VGtENhPc=;
        b=rJYPR0iwDSbox8fylZTbUxMg/kzAMKlqsBo5CoAjhLaYcECLXQY/VccJTO6q8GHD/+
         0KwDWTMhPGsQ+mWu/yk9Oz1xXfZxcJK5qkCXDzLEebex1N6RXCYkSblw0fIZYaRFqXUk
         7oqA561P7Y1Uyhgp0H53cv1D2+HtTiyBl4kEhSSlnIETNewPBKWiwZtk8kFS3I/yoO22
         52YgcGB/vBH4wABw6XbPhJ45YYS5g8eu4r0n42ivhzTRyMu/yP/y7hH3N7o5c4H/U/B8
         xAKj5rEOeW+SSIhd8oOx3Fy4Xa9zUO87lWZVHPUR5Fu3HjhJAihxgv/VUiNrO79czn3L
         rlag==
X-Gm-Message-State: ACrzQf1GAMicMBptYrN0rAkXUeCn6KmFKBpvDnZK179o/oxl+eX12GDQ
        B+UPH55Y8YHYDM0j9iW96IZn1nUT+yisYQ==
X-Google-Smtp-Source: AMsMyM65zy9w0RdzVEqmld4/qnsBulitgQpGHjJqxSrm9Wcnqk0BhVHkXGaAFZEodAFwIynT26Y3TA==
X-Received: by 2002:a17:90a:c782:b0:202:c73e:5488 with SMTP id gn2-20020a17090ac78200b00202c73e5488mr47000873pjb.202.1666216509347;
        Wed, 19 Oct 2022 14:55:09 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:57b7:1f0e:44d1:f252])
        by smtp.gmail.com with UTF8SMTPSA id l10-20020a170903244a00b0017f637b3e87sm11258807pls.279.2022.10.19.14.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 14:55:08 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Faiz Abbas <faiz_abbas@ti.com>, linux-mmc@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Al Cooper <alcooperx@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 4/7] mms: sdhci-esdhc-imx: Fix SDHCI_RESET_ALL for CQHCI
Date:   Wed, 19 Oct 2022 14:54:37 -0700
Message-Id: <20221019145246.v2.4.I7d01f9ad11bacdc9213dee61b7918982aea39115@changeid>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221019215440.277643-1-briannorris@chromium.org>
References: <20221019215440.277643-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Fixes: bb6e358169bf ("mmc: sdhci-esdhc-imx: add CMDQ support")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 - Drop unnecessary ESDHC_FLAG_CQHCI check

 drivers/mmc/host/sdhci-esdhc-imx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 55981b0f0b10..c07df7b71b22 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1288,6 +1288,9 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 
 static void esdhc_reset(struct sdhci_host *host, u8 mask)
 {
+	if ((host->mmc->caps2 & MMC_CAP2_CQE) && (mask & SDHCI_RESET_ALL))
+		cqhci_deactivate(host->mmc);
+
 	sdhci_reset(host, mask);
 
 	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
-- 
2.38.0.413.g74048e4d9e-goog

