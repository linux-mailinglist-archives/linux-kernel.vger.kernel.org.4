Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C9260525A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 23:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJSVzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 17:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbiJSVzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 17:55:19 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E32E162508
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 14:55:16 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id l6so17476432pgu.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 14:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdWjXp1yQqqnWhAF+f3RrVqI4HKKxf+i6fXlj1bwLGc=;
        b=dsorLnZ6g7l46LRyLdlp2vDy2D5bxCKpUlzS+ILZbL2KnQEvI9+bHKJsmLlMd5z939
         vFlptL1Scv3wg1kkesMKClNuMREJqrHJ2b1uLX9NPxSkw4qQzeJLAYCuENPkiEgsu5qq
         +DWF967Wz8uWOX1fu5humVdZ0fo80sExLbdRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mdWjXp1yQqqnWhAF+f3RrVqI4HKKxf+i6fXlj1bwLGc=;
        b=5n4+EbqzN2tQNNfZEOqmA32XSC0XTs7YuhDQHAo2O3RiPpNVRLb9py4AtJJM0HuzDp
         tTGWxt7A4rRNee30GLc0oF8ELdHkWpswQCVCHT/z3Olmv0mPiXRceYobfefyunhrxP0w
         i7PjKynqKZHDhzqqw88IGeFgn5rz2zPM6815LDz64Cr5KXUrnYOzaV8bIz5Yp6Ynh0Ku
         4xHI7RiRChN/qLUJ5Rb4ygXI75NwNiE4Shi/T+nBfqT7z7hoUbfGQfSm4pPEKcKeA/Js
         Nk+BQrjYjcaImoR4rTcqoegJuPqqJgeZ6dGBzFt8dmQ8jR0FCcu96AgjHacbHNQ+eyHZ
         tTnw==
X-Gm-Message-State: ACrzQf3Wu3Z2lTeLo7LMP10VL2Zm1qHI5wYghfVGg8pbwS0RoCZFeA1P
        Gk8DziavpDDNkyHxoSB4czGJzg==
X-Google-Smtp-Source: AMsMyM7ucaMeh7aA0C9osOktHedzsvrEuCvV5oZ+DjVR9lNos2N3qyUSnVuMThWXyLgLD5alo3A/wA==
X-Received: by 2002:a05:6a00:408c:b0:565:fc2c:8c71 with SMTP id bw12-20020a056a00408c00b00565fc2c8c71mr10838457pfb.82.1666216514655;
        Wed, 19 Oct 2022 14:55:14 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:57b7:1f0e:44d1:f252])
        by smtp.gmail.com with UTF8SMTPSA id c4-20020a633504000000b0043be67b6304sm10453631pga.0.2022.10.19.14.55.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 14:55:14 -0700 (PDT)
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
Subject: [PATCH v2 6/7] mmc: sdhci_am654: Fix SDHCI_RESET_ALL for CQHCI
Date:   Wed, 19 Oct 2022 14:54:39 -0700
Message-Id: <20221019145246.v2.6.I35ca9d6220ba48304438b992a76647ca8e5b126f@changeid>
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

Fixes: f545702b74f9 ("mmc: sdhci_am654: Add Support for Command Queuing Engine to J721E")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

(no changes since v1)

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

