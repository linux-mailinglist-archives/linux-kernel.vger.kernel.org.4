Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D9F633D85
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbiKVNXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbiKVNXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:23:45 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA4F1F62A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 05:23:41 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id l2so9186407qtq.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 05:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=issWTojkRWwRHPZ2j+gQ8ojVqtNRu9IZkFS8IgCllcQ=;
        b=Q6aoLE/g+fzPHn+PnCKdrn/BrRxrGWD0/CX5ONbAQckV97NqTO8xj2TigP9aYVdRUX
         AoIAvco6DhsUru77+CJBvtWPK+uovNdFeERay1OWYOEI2r0CQdtwQaIjQQcsWTmcXyti
         FJXYD8hXeWr76NwVyFXjygZkUQcFwyQGyjaXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=issWTojkRWwRHPZ2j+gQ8ojVqtNRu9IZkFS8IgCllcQ=;
        b=USdA4nKZfS7ttEqZxkmPVTiFpG2LrjxHO2lp+shi2HJZ/VEG7NQUJglWHaH5X2pOQ8
         JS+na84KsHjPn7Y7Z/klFQWMDmXBTOsXULESGPh7YIKaqj9CbXw/JROnmTsu1Idq7qGB
         mZaMOsbaUDVQqf+jZXH2sqZwxPGrXuzoybISmyRQm2yRhWWcijhnqmbIfS7SiXRZcDiS
         JdlF2KfBdlQKBtqo2RCuSGZQCx2KE210vJ1HGohiqmbcEuxb7LP1sx4ABORJu4YKWmJg
         g0s/EtdkaqBJ/zkkx+pluPOioxvQH6YdA3PE4slVFnCNkKqRTB5PIssDxoWZGHUGAalH
         jkzA==
X-Gm-Message-State: ANoB5pnMSMlvQHp0hlmPz0fWC6rK5dIjRNXUk6zK3cGcpRFL3ZGbPXIO
        994uZuPHQF/H+gcRhNgS0joQJw==
X-Google-Smtp-Source: AA0mqf6o5e5xDM5n95dwthsSblW7L+S7SvxEFiDzFfhDNPrE9TLVj/83o4uuV8rzacLGbiT2HpOFqw==
X-Received: by 2002:a05:622a:4c18:b0:3a6:275a:8538 with SMTP id ey24-20020a05622a4c1800b003a6275a8538mr17685007qtb.109.1669123420436;
        Tue, 22 Nov 2022 05:23:40 -0800 (PST)
Received: from localhost.localdomain (vpn.streamunlimited.com. [91.114.0.140])
        by smtp.gmail.com with ESMTPSA id w11-20020a05620a444b00b006fb72dbbaa4sm10084441qkp.27.2022.11.22.05.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 05:23:39 -0800 (PST)
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
Subject: [PATCH v2] mmc: meson-gx: fix SDIO interrupt handling
Date:   Tue, 22 Nov 2022 14:23:03 +0100
Message-Id: <20221122132304.1482508-1-peter.suti@streamunlimited.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAPDyKFqrCCtY_A072WswEFa3Bnz7EfMp40MRYtr3G7Jbq_hbTw@mail.gmail.com>
References: <CAPDyKFqrCCtY_A072WswEFa3Bnz7EfMp40MRYtr3G7Jbq_hbTw@mail.gmail.com>
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
Changes in v2:
	- use spin_lock instead of spin_lock_irqsave
	- only reenable interrupts if they were enabled already

 drivers/mmc/host/meson-gx-mmc.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 6e5ea0213b47..0c95f8640b34 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -934,6 +934,13 @@ static void meson_mmc_read_resp(struct mmc_host *mmc, struct mmc_command *cmd)
 	}
 }
 
+static bool __meson_mmc_sdio_irq_is_enabled(struct mmc_host *mmc)
+{
+	struct meson_host *host = mmc_priv(mmc);
+
+	return readl(host->regs + SD_EMMC_IRQ_EN) & IRQ_SDIO;
+}
+
 static void __meson_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 {
 	struct meson_host *host = mmc_priv(mmc);
@@ -950,6 +957,11 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	struct mmc_command *cmd;
 	u32 status, raw_status;
 	irqreturn_t ret = IRQ_NONE;
+	bool irq_enabled;
+
+	spin_lock(&host->lock);
+	irq_enabled = __meson_mmc_sdio_irq_is_enabled(host->mmc);
+	__meson_mmc_enable_sdio_irq(host->mmc, 0);
 
 	raw_status = readl(host->regs + SD_EMMC_STATUS);
 	status = raw_status & (IRQ_EN_MASK | IRQ_SDIO);
@@ -958,11 +970,11 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
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
@@ -970,17 +982,16 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	cmd = host->cmd;
 
 	if (status & IRQ_SDIO) {
-		spin_lock(&host->lock);
-		__meson_mmc_enable_sdio_irq(host->mmc, 0);
 		sdio_signal_irq(host->mmc);
-		spin_unlock(&host->lock);
 		status &= ~IRQ_SDIO;
-		if (!status)
+		if (!status) {
+			spin_unlock(&host->lock);
 			return IRQ_HANDLED;
+		}
 	}
 
 	if (WARN_ON(!cmd))
-		return IRQ_NONE;
+		goto out_unlock;
 
 	cmd->error = 0;
 	if (status & IRQ_CRC_ERR) {
@@ -1023,6 +1034,11 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	if (ret == IRQ_HANDLED)
 		meson_mmc_request_done(host->mmc, cmd->mrq);
 
+out_unlock:
+	if (irq_enabled)
+		__meson_mmc_enable_sdio_irq(host->mmc, 1);
+	spin_unlock(&host->lock);
+
 	return ret;
 }
 
-- 
2.25.1

