Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4637564CB8F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 14:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238424AbiLNNsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 08:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238313AbiLNNsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 08:48:06 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E9626AB8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 05:48:03 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id e15so3307183ybb.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 05:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rduJSBHNOfADwB39FsLCzXunOBvEcaJu6tUh95KODL4=;
        b=fdwnhavsGqlgQt7e1eaz36uYU8Z77IBoLK4pevJAqvSoZWgxTQUVZ6VtElmj0yFLJF
         Ufo+Nsy/BTv1p3N4pQUL4uYYI8A3yXLzI6rGOnVNy7F45EiZT39czJ9slCdQnpiP4cXz
         PUbm5mvjGFiV7BXlDC5zbiTWA9nhEzN8QR1gM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rduJSBHNOfADwB39FsLCzXunOBvEcaJu6tUh95KODL4=;
        b=N8d1uCcNQHaLd8lJbYlTPwXlNopAIxUsAjqhiS0WyKjX9v7DYK+B6Inumky9mIIy9H
         8Zc81eBXoX/g1CHmrBlqKizbPBXfy2FegqGR01H9ldC7rFG5ucJOynxUIJ8i0Gku/Zbs
         NH3A5KhdTMg+w+AGMRofKImu9GgIm3w9r4dHwG2Nv5cWr6L1twagHalHQ9ZFWT0OC6Ar
         bXDE/aU3wQGRNU5vAuYA5jtXFJIu3K8z1SJT49p4rRfb6lKzqa8NU1ocbJghPfM8BtRF
         2oW8d/KsibC/C6X75pVfOemzNFy37Lwt7M77hwkAEWj97m4bzKrwp5nOXAImYut8QOm6
         izMw==
X-Gm-Message-State: ANoB5pmkMNrAyeyhiaIj36p2z1u3lJLbDzQFgYrxOibne0FjncZGAzH7
        vv+35fL1hIl6C+Gs/uBgXfA0HA==
X-Google-Smtp-Source: AA0mqf5CDWDQUpYOHhb4MnlcEthGXqB5EMVH+jnlo0LHvdsh2lxNCgqVkA31Re7Rk3wPzDy53O2N/g==
X-Received: by 2002:a05:6902:147:b0:724:6d18:6c36 with SMTP id p7-20020a056902014700b007246d186c36mr11589008ybh.23.1671025683021;
        Wed, 14 Dec 2022 05:48:03 -0800 (PST)
Received: from localhost.localdomain (vpn.streamunlimited.com. [91.114.0.140])
        by smtp.gmail.com with ESMTPSA id f10-20020a05620a408a00b006eeb3165565sm10139602qko.80.2022.12.14.05.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 05:48:02 -0800 (PST)
From:   Peter Suti <peter.suti@streamunlimited.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Peter Suti <peter.suti@streamunlimited.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3] mmc: meson-gx: fix SDIO interrupt handling
Date:   Wed, 14 Dec 2022 14:46:21 +0100
Message-Id: <20221214134620.3028726-1-peter.suti@streamunlimited.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <52861a84-0fe2-37f0-d66a-145f2ebe1d79@gmail.com>
References: <52861a84-0fe2-37f0-d66a-145f2ebe1d79@gmail.com>
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
Marvell-8987 wifi chip got stuck using the marvell-sd-uapsta-8987
vendor driver. The cause seems to be that after sending ack to all interrupts
the IRQ_SDIO still happens, but it is ignored.

To work around this, recheck the IRQ_SDIO after meson_mmc_request_done().

Inspired by 9e2582e ("mmc: mediatek: fix SDIO irq issue") which used a
similar fix to handle lost interrupts.

Fixes: 066ecde ("mmc: meson-gx: add SDIO interrupt support")

Signed-off-by: Peter Suti <peter.suti@streamunlimited.com>
---
Changes in v2:
	- use spin_lock instead of spin_lock_irqsave
	- only reenable interrupts if they were enabled already

Changes in v3:
	- Rework the patch based on feedback from Heiner Kallweit.
		The IRQ does not happen on 2 CPUs and the hard IRQ is not re-entrant.
		But still one SDIO IRQ is lost without this change.
		After the ack, reading the SD_EMMC_STATUS BIT(15) is set, but 
		meson_mmc_irq() is never called again.

		The fix is similar to Mediatek msdc_recheck_sdio_irq().
		That platform also loses an IRQ in some cases it seems.

 drivers/mmc/host/meson-gx-mmc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 6e5ea0213b47..7d3ee2f9a7f6 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1023,6 +1023,22 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	if (ret == IRQ_HANDLED)
 		meson_mmc_request_done(host->mmc, cmd->mrq);
 
+	/*
+	* Sometimes after we ack all raised interrupts,
+	* an IRQ_SDIO can still be pending, which can get lost.
+	*
+	* To prevent this, recheck the IRQ_SDIO here and schedule
+	* it to be processed.
+	*/
+	raw_status = readl(host->regs + SD_EMMC_STATUS);
+	status = raw_status & (IRQ_EN_MASK | IRQ_SDIO);
+	if (status & IRQ_SDIO) {
+		spin_lock(&host->lock);
+		__meson_mmc_enable_sdio_irq(host->mmc, 0);
+		sdio_signal_irq(host->mmc);
+		spin_unlock(&host->lock);
+	}
+
 	return ret;
 }
 
-- 
2.25.1

