Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B24602301
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiJRD6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiJRD6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:58:24 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DCD87FBE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 20:57:51 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id h2so5299665plb.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 20:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9p3m7T6e0mIj8rcCXtywVHD8sGWIzKCyjF4TP7KLyZQ=;
        b=F4EZTL9tVgb/GVZL3Pq3dG+YSUlqemGjgd1HKl8uW7Zv3ivDiffA8tbC7/7dWruKax
         2LCuvRHAppGUX8X6oBUrN2c9Rq3xqt9/4nqMIWNlL+g8QUFp5AYvLHJji2VTBRoAUEDs
         1E5N2J25qZgWy/Rxdk6krea1cWV1M/bcTxVsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9p3m7T6e0mIj8rcCXtywVHD8sGWIzKCyjF4TP7KLyZQ=;
        b=2XhVWquw7enCcjsKLqJ6a7pnuOGL5bx05ymQjLW8HCspS27cWeJvawu62rfZ7UGIgE
         ixUW1VGILe/wcVnTJkfetPeFb+GKYtfY47Zu07WhtlOKmN0+3JxXnFKiAXNemF6GiXcf
         8SfEqBLpVUEbhqcCYphkUVQB65BTIpdMQ2eL2JrkeLj5v0GzVlSZjBVN/QW+Y8uVuCIV
         OlCBcHp8y48QnRzWkboHCdHSG2aNlku+a6LyfPS1V3S1IlnIEcZeZpc5e32KXqA6Q5eb
         ZAui0m4q6Sx4vZKvlHZJbBy3nVFaAad8hilcK6VJLQB2BEno8xzHR49pKuSguKMHlmVT
         AN0w==
X-Gm-Message-State: ACrzQf1KVFqvPAez18XhtjEyGuge8Y8E/80aO7waZ8LvOgtx6kZRHD82
        Z5u82dBb8IXg12FdOv7p+L7tgQ==
X-Google-Smtp-Source: AMsMyM4Oi5SI4xxHrO4wJahkDYqAgw2comRgFo0posUVaiivWN51Whl+zPIHJrd+P7q1UiVjJiRzBg==
X-Received: by 2002:a17:90b:384f:b0:20d:4761:3394 with SMTP id nl15-20020a17090b384f00b0020d47613394mr1319039pjb.144.1666065470226;
        Mon, 17 Oct 2022 20:57:50 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:2ac3:f4e2:e908:c393])
        by smtp.gmail.com with UTF8SMTPSA id q23-20020a635c17000000b0043a0de69c94sm6805583pgb.14.2022.10.17.20.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 20:57:49 -0700 (PDT)
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
Subject: [PATCH 5/5] mmc: sdhci_am654: Fix SDHCI_RESET_ALL for CQHCI
Date:   Mon, 17 Oct 2022 20:57:24 -0700
Message-Id: <20221017205610.5.I35ca9d6220ba48304438b992a76647ca8e5b126f@changeid>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221018035724.2061127-1-briannorris@chromium.org>
References: <20221018035724.2061127-1-briannorris@chromium.org>
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

Fixes: f545702b74f9 ("mmc: sdhci_am654: Add Support for Command Queuing Engine to J721E")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/mmc/host/sdhci_am654.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 8f1023480e12..187a21086791 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -378,6 +378,9 @@ static void sdhci_am654_reset(struct sdhci_host *host, u8 mask)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
 
+	if ((host->mmc->caps2 & MMC_CAP2_CQE) && (mask & SDHCI_RESET_ALL))
+		cqhci_deactivate(host->mmc);
+
 	sdhci_reset(host, mask);
 
 	if (sdhci_am654->quirks & SDHCI_AM654_QUIRK_FORCE_CDTEST) {
-- 
2.38.0.413.g74048e4d9e-goog

