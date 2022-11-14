Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378B9627935
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236975AbiKNJko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236937AbiKNJkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:40:16 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40421EADC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:40:11 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id n12so26782105eja.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/E7DQv1w5VxBWNYYy8b3rJwQQFYjed72q0l2u49VmFw=;
        b=mV1Xk5oqlPhbGM675526QGnANRWzR3kkuCK7FjmV9soqIRzH7cFh2DRZEQaq7RKsl8
         +sp0+OlHXt7xWppuqpq+9kMfLz+Fmc1qs3Ui6Tm3NaeH3UUyC7VtVRIhGjQmi9WLftgZ
         lRFGpWsBqHXodsusA1zkb0pMPsxHbH1JYQYcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/E7DQv1w5VxBWNYYy8b3rJwQQFYjed72q0l2u49VmFw=;
        b=6x6HowL9PGHH0c6Mou9ae2YQKJZhrf3pyXXdR6dvKDsVC6ddyKLWip1IczKxI1+vqk
         xyBL9Tt5XYyH1IS3LflfYPSl4YJA++8A95xY3TY7S0p16xa0+JMVsZtnagvO0v3x0lR3
         avcogke79eOWA7ajztcJzuQ+xdfn4C3pPqiwwuiSSO3E+ixf+PyjPxHu/joVgSydO+hV
         0pZS4TJWzEPYL1Q/64eFTJBoAdkE9HIsWt/iIZLWXcRhldAe1bOMoZ424O0M1pewZjir
         BjgPys1JiWiXy+tJPyo2xe5KNGeiVmMSp35I+EOjakkmMj7HwMA5AQT622NZXFD9cHdu
         fZLw==
X-Gm-Message-State: ANoB5pkgyQ8YEQQ6hA723sHGeRXrKOk9p0ivLm5Ljf4WCOFrAhJS5qom
        KuUP7vPjTkoSzQaxm/awuflWkQ==
X-Google-Smtp-Source: AA0mqf5rOmZDPmo+r9tZg7mKbD10KNVdVuxgpnD4x2FxOInLKSsw/pvFBCDxNyjJ0tF2dI6SUBll/Q==
X-Received: by 2002:a17:906:8d06:b0:78d:8d70:8bf8 with SMTP id rv6-20020a1709068d0600b0078d8d708bf8mr9312698ejc.15.1668418810409;
        Mon, 14 Nov 2022 01:40:10 -0800 (PST)
Received: from localhost.localdomain (vpn.streamunlimited.com. [91.114.0.140])
        by smtp.gmail.com with ESMTPSA id 26-20020a170906311a00b007ae693cd265sm3928068ejx.150.2022.11.14.01.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 01:40:09 -0800 (PST)
From:   Peter Suti <peter.suti@streamunlimited.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Peter Suti <peter.suti@streamunlimited.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: meson-gx: fix SDIO interrupt handling
Date:   Mon, 14 Nov 2022 10:38:57 +0100
Message-Id: <20221114093857.491695-1-peter.suti@streamunlimited.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the interrupt support introduced in commit 066ecde sometimes the
Marvell-8987 wifi chip entered a deadlock using the marvell-sd-uapsta-8987
vendor driver. The cause seems to be that sometimes the interrupt handler
handles 2 IRQs and one of them disables the interrupts which are not reenabled
when all interrupts are finished. To work around this, disable all interrupts
when we are in the IRQ context and reenable them when the current IRQ is handled.

Fixes: 066ecde ("mmc: meson-gx: add SDIO interrupt support")

Signed-off-by: Peter Suti <peter.suti@streamunlimited.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 6e5ea0213b47..972024d57d1c 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -950,6 +950,10 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	struct mmc_command *cmd;
 	u32 status, raw_status;
 	irqreturn_t ret = IRQ_NONE;
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+	__meson_mmc_enable_sdio_irq(host->mmc, 0);
 
 	raw_status = readl(host->regs + SD_EMMC_STATUS);
 	status = raw_status & (IRQ_EN_MASK | IRQ_SDIO);
@@ -958,11 +962,11 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 		dev_dbg(host->dev,
 			"Unexpected IRQ! irq_en 0x%08lx - status 0x%08x\n",
 			 IRQ_EN_MASK | IRQ_SDIO, raw_status);
-		return IRQ_NONE;
+		goto out_unlock;
 	}
 
 	if (WARN_ON(!host))
-		return IRQ_NONE;
+		goto out_unlock;
 
 	/* ack all raised interrupts */
 	writel(status, host->regs + SD_EMMC_STATUS);
@@ -970,17 +974,16 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	cmd = host->cmd;
 
 	if (status & IRQ_SDIO) {
-		spin_lock(&host->lock);
-		__meson_mmc_enable_sdio_irq(host->mmc, 0);
 		sdio_signal_irq(host->mmc);
-		spin_unlock(&host->lock);
 		status &= ~IRQ_SDIO;
-		if (!status)
+		if (!status) {
+			spin_unlock_irqrestore(&host->lock, flags);
 			return IRQ_HANDLED;
+		}
 	}
 
 	if (WARN_ON(!cmd))
-		return IRQ_NONE;
+		goto out_unlock;
 
 	cmd->error = 0;
 	if (status & IRQ_CRC_ERR) {
@@ -1023,6 +1026,10 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	if (ret == IRQ_HANDLED)
 		meson_mmc_request_done(host->mmc, cmd->mrq);
 
+out_unlock:
+	__meson_mmc_enable_sdio_irq(host->mmc, 1);
+	spin_unlock_irqrestore(&host->lock, flags);
+
 	return ret;
 }
 
-- 
2.25.1

