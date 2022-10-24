Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CA160B8DC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiJXT4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbiJXTyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:54:53 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25999270237
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:19:11 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id e4so5729987pfl.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RuKI5bp1FsoKhoX8KTyHPCH/WRbZz2nZbg0xRSkPhiI=;
        b=SAsToB0UY7YN+KrCipRGgiZP1WEESaE1EbzE7YzlXSzfhgOGP7hTTSg70BQopQlwi4
         j6h90asxgIpL99oGuXu0An6MsIVKP7y3kYBRMbpgPIkwHCNSuKEyr/f2IfqU+GjkaXGD
         EsPAgBL8w1tviNqPYB0W0zyrCBlgiS3nxM18o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RuKI5bp1FsoKhoX8KTyHPCH/WRbZz2nZbg0xRSkPhiI=;
        b=hVb+n/765ahbb/wRhq2ayk9HdMiB3RpmTtGPqlZPaoQY8y2aBQZJB4ib54kR7mr0W8
         0W7vBNbIe8lxUjl4Y2xr+zFtcRw12QSL5uuVIbnYO6l9Mjc7JVciGpl5hdIQ73DVPREC
         IsjhrTc3EFHazt3HK+aI19bJYEIEqo/j/ttELTFN555YgCzAibheYnJR13SjLWAXVjFF
         dP3K+BuOku93/JlOywH/IOlbyGiJK89aDVneWpuH7oGFCplYCFxzXI8gnYzRA/brV3wT
         5q46MTz2NjPxCBd6B+OVbVvSeKTuQ9Lq3AZex5udCxg5o3KHmgKi9cSIYIIIHydJzak4
         yPpQ==
X-Gm-Message-State: ACrzQf0peMVaWZ6yp1Eir+DAlUdrXebw9Dk2NJqdf7HavT2H1TatKkwC
        IBtWywCLPfXTuY115EZLlyDzCA==
X-Google-Smtp-Source: AMsMyM7xgKD8kYLElBTTogulLA2Q1qFTwpJDSgq2Zx98nTCDWRpU4D0HA+WUrBGwpTveEjwvBfE3NQ==
X-Received: by 2002:a63:581b:0:b0:464:a9a6:571b with SMTP id m27-20020a63581b000000b00464a9a6571bmr6774778pgb.560.1666635501718;
        Mon, 24 Oct 2022 11:18:21 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:808b:e2f6:edcf:ccb0])
        by smtp.gmail.com with UTF8SMTPSA id a18-20020a170902b59200b00186b1bfbe79sm60642pls.66.2022.10.24.11.18.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 11:18:21 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-mmc@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] mmc: sdhci-brcmstb: Allow building with COMPILE_TEST
Date:   Mon, 24 Oct 2022 11:17:59 -0700
Message-Id: <20221024181759.2355583-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
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

This driver is pretty simple, and it can be useful to build it (for
validation purposes) without BMIPS or ARCH_BRCMSTB.

It technically depends on CONFIG_OF to do anything useful at runtime,
but it still works out OK for compile-testing using the !OF stubs.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/mmc/host/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index f324daadaf70..453fba8d2d9d 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -1040,10 +1040,10 @@ config MMC_SDHCI_MICROCHIP_PIC32
 
 config MMC_SDHCI_BRCMSTB
 	tristate "Broadcom SDIO/SD/MMC support"
-	depends on ARCH_BRCMSTB || BMIPS_GENERIC
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
 	depends on MMC_SDHCI_PLTFM
 	select MMC_CQHCI
-	default y
+	default ARCH_BRCMSTB || BMIPS_GENERIC
 	help
 	  This selects support for the SDIO/SD/MMC Host Controller on
 	  Broadcom STB SoCs.
-- 
2.38.0.135.g90850a2211-goog

