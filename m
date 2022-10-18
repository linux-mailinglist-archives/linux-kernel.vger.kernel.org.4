Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E866022FF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiJRD6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiJRD5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:57:51 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4948A87F99
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 20:57:48 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y8so12910373pfp.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 20:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqIOfq4+r44BDEcAbAIaLunotKmu+d/0VAL/CFG/GZs=;
        b=UekqlQkGh6UA8fFw7UouK9kSktK5V9gIlB1tDGL6hleXWJrwAzg8cmt1FAgpk8CgWl
         a3uPfVhIqkx3w5XeROlfWH4A16t0gISqd0MOKefaZXYRf+hQ1/yA6Gu57WPgkCwc3tpv
         7V4LoIT4ltSkFehTqR+xHgMgI+oJkDSxXtuqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqIOfq4+r44BDEcAbAIaLunotKmu+d/0VAL/CFG/GZs=;
        b=qs//kOwh29a8J6aPryNoEQjaaSs7sf7rOoUtWhQZsYdB0yc0JQTmgDg3qwWhdGM4Qa
         aBGYvFfL8s+ujTTS4+d2VhDmUMMBPXFfjVnWhHRkKE7t95kvLqVSiTLSYX0aJxdIng8l
         +S30SHpPlLx1iaDE5skQe1I9GrLB3eZ6ofjjKXYBAsPf9oPVmKlOPHVqUH1Z6fzKb+3/
         M9KOdyFfNnoEd+RLJnciLX9edMc5JqAaJ3fCOMQhV9sZBBuMUXgAPwrfdnUIRi+TAw40
         MDn1ccPfqLrZ1F+J/7xNR1q6bY0RV/j+uy/r7Eyn+ouVQOoB5XpwhqMqac90SP9oo8XM
         6jdw==
X-Gm-Message-State: ACrzQf1BUsmwCs3faAf3FWTi2K2k2/JaLL/K4I2ev9QzGPZ3ijRhX/Ic
        LNbyi/zV6LJxJAVs0wzPD3jfYw==
X-Google-Smtp-Source: AMsMyM6ho3Yw2H44oOTg6yArRKh/f8YfOPn8UWoMF7c3LUoPZjSnRUSD0v76EISvEqYfqFagdhozeg==
X-Received: by 2002:a63:f07:0:b0:440:5c6e:5833 with SMTP id e7-20020a630f07000000b004405c6e5833mr972776pgl.375.1666065467479;
        Mon, 17 Oct 2022 20:57:47 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:2ac3:f4e2:e908:c393])
        by smtp.gmail.com with UTF8SMTPSA id y69-20020a62ce48000000b0054124008c14sm7955449pfg.154.2022.10.17.20.57.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 20:57:47 -0700 (PDT)
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
Subject: [PATCH 4/5] mmc: sdhci-tegra: Fix SDHCI_RESET_ALL for CQHCI
Date:   Mon, 17 Oct 2022 20:57:23 -0700
Message-Id: <20221017205610.4.I418c9eaaf754880fcd2698113e8c3ef821a944d7@changeid>
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

Fixes: 3c4019f97978 ("mmc: tegra: HW Command Queue Support for Tegra SDMMC")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/mmc/host/sdhci-tegra.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 2d2d8260c681..d1d1ae9b2a86 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -367,6 +367,10 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 	const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
 	u32 misc_ctrl, clk_ctrl, pad_ctrl;
 
+	if ((host->mmc->caps2 & MMC_CAP2_CQE) && (mask & SDHCI_RESET_ALL) &&
+	    tegra_host->enable_hwcq)
+		cqhci_deactivate(host->mmc);
+
 	sdhci_reset(host, mask);
 
 	if (!(mask & SDHCI_RESET_ALL))
-- 
2.38.0.413.g74048e4d9e-goog

