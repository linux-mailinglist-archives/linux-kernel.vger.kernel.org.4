Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFF85FED88
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 13:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiJNLtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 07:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiJNLs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 07:48:27 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E779410A7C4;
        Fri, 14 Oct 2022 04:48:09 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id g28so4664638pfk.8;
        Fri, 14 Oct 2022 04:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUtXR1NdrKHcUH0qXdCpzNzpBEVeqH48oqp/hW6UgTQ=;
        b=nv0u3Pzj5ucY5eyk5QJ3iT39WyoSy48kJTFSn4sxz2/cf8a08ZngEX7M/r6u+Vw/7H
         xjq8pkeRNaUcTsN2qfDaiH+AVL3RvxheBR3VVPpBcyaFrLfhBnp+T4179vxZIh/62g6R
         3QawgxedTdFOSzeZ3tCeSQ2okcQcBsOKVW4ZxFLONnMuHTgRAeydUGalp2JGPR688/7o
         z/AGOXtLuFWTTW5BmArm5vMh7o6RmdRBaCV4go8bOt8zurexah8ivigt2WPFk47A6npA
         YQ/BuBlLJ5w6rKC5SpwupDjn9kQWm+voI6IZq/PR0UYoh9Qjnmr0uOnzjpkJ8wvQLwLT
         4ieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kUtXR1NdrKHcUH0qXdCpzNzpBEVeqH48oqp/hW6UgTQ=;
        b=ZCLk0uLOfWSOG9hU3dpIeVMNQMGc0UjtBF3mX4bKe1GX7OMLCbsyI24MUXGIAevi34
         oZsStIHv7rAoPEnYQUvHrZ2h5lfi2jCJ4Zg6m277LRuHJeskJCuShjOkk3CZuGb188hf
         +odhD7ErGUNi5dZPFB1CMeukajzk4mF39632lwExmQY+SZImIhEZY3np4vteskUszvcp
         GipaKgbx6sDsLsJOTSILWz6v1TYM5giAIEcosfEDSna1b4Flh5psNi5zDfvZsNyTE5VI
         ZbN/m+JhLyHK4e+jd5IB3aqFiaJ29bo+u0iwjARmDFyWchWLOBlXPmntO+PsIr0vNm0Y
         OHIw==
X-Gm-Message-State: ACrzQf3v0hWpAeF1KKJrYwBzAnUVV9qqbyqwBa7GdtZ7P16UrPTq8ahL
        3SlqYXvVmBt+FLq6fG0mSoM=
X-Google-Smtp-Source: AMsMyM5FxoWghJ7gnCPJ1+ZLM3X0kSwuzNB3g6SlkCxKSbi62CDQajL8YlA/zJ+d5JgfnX+PVCE3pw==
X-Received: by 2002:a65:6944:0:b0:43c:da07:5421 with SMTP id w4-20020a656944000000b0043cda075421mr4388944pgq.72.1665748083050;
        Fri, 14 Oct 2022 04:48:03 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e282-2aaa-c1aa-06c8-0e68-c5ee.emome-ip6.hinet.net. [2001:b400:e282:2aaa:c1aa:6c8:e68:c5ee])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902ec8800b001746f66244asm1606678plg.18.2022.10.14.04.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 04:48:02 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V5 18/26] mmc: sdhci-uhs2: add uhs2_control() to initialise the interface
Date:   Fri, 14 Oct 2022 19:45:53 +0800
Message-Id: <20221014114601.15594-19-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221014114601.15594-1-victor.shih@genesyslogic.com.tw>
References: <20221014114601.15594-1-victor.shih@genesyslogic.com.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a sdhci version of mmc's uhs2_set_reg operation.
UHS-II interface (related registers) will be initialised here.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-uhs2.c | 115 ++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 3f3665d7990c..b0e6403ed31f 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -350,6 +350,65 @@ static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
+/* TODO: move this function to sdhci.c */
+static void sdhci_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set)
+{
+	u32 ier;
+
+	ier = sdhci_readl(host, SDHCI_INT_ENABLE);
+	ier &= ~clear;
+	ier |= set;
+	sdhci_writel(host, ier, SDHCI_INT_ENABLE);
+	sdhci_writel(host, ier, SDHCI_SIGNAL_ENABLE);
+}
+
+static void sdhci_uhs2_set_config(struct sdhci_host *host)
+{
+	u32 value;
+	u16 sdhci_uhs2_set_ptr = sdhci_readw(host, SDHCI_UHS2_SET_PTR);
+	u16 sdhci_uhs2_gen_set_reg = (sdhci_uhs2_set_ptr + 0);
+	u16 sdhci_uhs2_phy_set_reg = (sdhci_uhs2_set_ptr + 4);
+	u16 sdhci_uhs2_tran_set_reg = (sdhci_uhs2_set_ptr + 8);
+	u16 sdhci_uhs2_tran_set_1_reg = (sdhci_uhs2_set_ptr + 12);
+
+	/* Set Gen Settings */
+	sdhci_writel(host, host->mmc->uhs2_caps.n_lanes_set <<
+		SDHCI_UHS2_GEN_SET_N_LANES_POS, sdhci_uhs2_gen_set_reg);
+
+	/* Set PHY Settings */
+	value = (host->mmc->uhs2_caps.n_lss_dir_set <<
+			SDHCI_UHS2_PHY_SET_N_LSS_DIR_POS) |
+		(host->mmc->uhs2_caps.n_lss_sync_set <<
+			SDHCI_UHS2_PHY_SET_N_LSS_SYN_POS);
+	if (host->mmc->flags & MMC_UHS2_SPEED_B)
+		value |= 1 << SDHCI_UHS2_PHY_SET_SPEED_POS;
+	sdhci_writel(host, value, sdhci_uhs2_phy_set_reg);
+
+	/* Set LINK-TRAN Settings */
+	value = (host->mmc->uhs2_caps.max_retry_set <<
+			SDHCI_UHS2_TRAN_SET_RETRY_CNT_POS) |
+		(host->mmc->uhs2_caps.n_fcu_set <<
+			SDHCI_UHS2_TRAN_SET_N_FCU_POS);
+	sdhci_writel(host, value, sdhci_uhs2_tran_set_reg);
+	sdhci_writel(host, host->mmc->uhs2_caps.n_data_gap_set,
+		     sdhci_uhs2_tran_set_1_reg);
+}
+
+static int sdhci_uhs2_check_dormant(struct sdhci_host *host)
+{
+	u32 val;
+	/* 100ms */
+	int timeout = 100000;
+
+	if (read_poll_timeout_atomic(sdhci_readl, val, (val & SDHCI_UHS2_IN_DORMANT_STATE),
+				     100, timeout, true, host, SDHCI_PRESENT_STATE)) {
+		pr_warn("%s: UHS2 IN_DORMANT fail in 100ms.\n", mmc_hostname(host->mmc));
+		sdhci_dumpregs(host);
+		return -EIO;
+	}
+	return 0;
+}
+
 /*****************************************************************************\
  *                                                                           *
  * MMC callbacks                                                             *
@@ -435,6 +494,61 @@ static int sdhci_uhs2_enable_clk(struct mmc_host *mmc)
 	return 0;
 }
 
+static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc);
+
+static int sdhci_uhs2_control(struct mmc_host *mmc, enum sd_uhs2_operation op)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	unsigned long flags;
+	int err = 0;
+	u16 sdhci_uhs2_set_ptr = sdhci_readw(host, SDHCI_UHS2_SET_PTR);
+	u16 sdhci_uhs2_phy_set_reg = (sdhci_uhs2_set_ptr + 4);
+
+	DBG("Begin %s, act %d.\n", __func__, op);
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	switch (op) {
+	case UHS2_PHY_INIT:
+		err = sdhci_uhs2_do_detect_init(mmc);
+		break;
+	case UHS2_SET_CONFIG:
+		sdhci_uhs2_set_config(host);
+		break;
+	case UHS2_ENABLE_INT:
+		sdhci_clear_set_irqs(host, 0, SDHCI_INT_CARD_INT);
+		break;
+	case UHS2_DISABLE_INT:
+		sdhci_clear_set_irqs(host, SDHCI_INT_CARD_INT, 0);
+		break;
+	case UHS2_SET_SPEED_B:
+		sdhci_writeb(host, 1 << SDHCI_UHS2_PHY_SET_SPEED_POS,
+			     sdhci_uhs2_phy_set_reg);
+		break;
+	case UHS2_CHECK_DORMANT:
+		err = sdhci_uhs2_check_dormant(host);
+		break;
+	case UHS2_DISABLE_CLK:
+		err = sdhci_uhs2_disable_clk(mmc);
+		break;
+	case UHS2_ENABLE_CLK:
+		err = sdhci_uhs2_enable_clk(mmc);
+		break;
+	case UHS2_POST_ATTACH_SD:
+		host->ops->uhs2_post_attach_sd(host);
+		break;
+	default:
+		pr_err("%s: input sd uhs2 operation %d is wrong!\n",
+		       mmc_hostname(host->mmc), op);
+		err = -EIO;
+		break;
+	}
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	return err;
+}
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
@@ -593,6 +707,7 @@ static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
 	host->mmc_host_ops.start_signal_voltage_switch =
 		sdhci_uhs2_start_signal_voltage_switch;
 	host->mmc_host_ops.uhs2_set_ios = sdhci_uhs2_set_ios;
+	host->mmc_host_ops.uhs2_control = sdhci_uhs2_control;
 
 	if (!host->mmc_host_ops.uhs2_detect_init)
 		host->mmc_host_ops.uhs2_detect_init = sdhci_uhs2_do_detect_init;
-- 
2.25.1

