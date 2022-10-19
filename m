Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D308D60441F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbiJSL6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbiJSL5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:57:49 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A181135;
        Wed, 19 Oct 2022 04:36:21 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id j188so18884829oih.4;
        Wed, 19 Oct 2022 04:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xThVRskN7VHfYk+O1JiI7661/ghq/PgPv9FeXBCma8=;
        b=hSS8f9H06KpDj16xChPmvJxYo/dE7kptFsqDhZDJfDqc4rAe7jwia0BirUV+1xWxOq
         UpdlJsH/exYuyq9J4cKUEiNYm11xmrRR3rnhbpHExFnID2d0iyYi760RbdReTEg/DW+a
         tkFi4zSp7VkErf3V/fDNZbTq55LY7Txj5kpCvTyJTqUj1axwXBBOc2WSpCD9vKHlr7tE
         10w6o8ZB0dwb0s+qth0n7hryjN+k+tf6poMyT4IJ4XbeH9UHJ38rVRXPEuHh6Pvbr4dB
         W2NE5x56kbhWXsdbbCSSNdWejuZ1NECQohyqJtndTjo1rc2Oq2TsfWyTWjv5wLvfWIdP
         WPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xThVRskN7VHfYk+O1JiI7661/ghq/PgPv9FeXBCma8=;
        b=6oX9/Urzjh/WXlDYsEr/j6OQEcP9QqdxemQ292MQ1kkDF1+4LrazBeqY6A20cGEVOK
         Bczw5XUe1cEuRYkXz6HghToCBRqP2HKPc/yiVCn73DUgCRta9VQNCrao5h4q58E7+efT
         jYFnMMGP8HHCZN9ku1fS9mpgpJY2rEJ70jd27EsPPyJKV+xqmV/1beAnB5AJJO14UL3a
         O8IsneicUc97acxHQWvFyJLKJ0blHE58PTQ9MvvldfySFL/vlzIbnyp+SYeHEg65LqZm
         bPK3cguDoOf8rfKSTbgU1Dnl923CMbyb7YetWz4kglj/Bbp1XjKZ8ZIxJkA7aLMuEery
         etyw==
X-Gm-Message-State: ACrzQf32ulYZaO/1DViU7P2t01tlye/VxthOqtHnYUdxkJyu8nBRm1i8
        Etdp7zYpBpQoiCxkAx0dqB3fOjAAjCo=
X-Google-Smtp-Source: AMsMyM6zyUQYZX0j7jq3h0926dhBY4adlfTTtomLfmHBAKIBV0gSqdNquxHbl9wFEwDYW7/RPWlJUQ==
X-Received: by 2002:a17:90a:5ac2:b0:205:de77:72be with SMTP id n60-20020a17090a5ac200b00205de7772bemr9392086pji.24.1666177672433;
        Wed, 19 Oct 2022 04:07:52 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e258-8c34-821b-9613-557f-bd8d.emome-ip6.hinet.net. [2001:b400:e258:8c34:821b:9613:557f:bd8d])
        by smtp.gmail.com with ESMTPSA id cc11-20020a17090af10b00b0020dc318a43esm8696225pjb.25.2022.10.19.04.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 04:07:52 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V5 18/26] mmc: sdhci-uhs2: add uhs2_control() to initialise the interface
Date:   Wed, 19 Oct 2022 19:06:39 +0800
Message-Id: <20221019110647.11076-19-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
References: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
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
 drivers/mmc/host/sdhci-uhs2.c | 103 ++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c      |  12 ++++
 drivers/mmc/host/sdhci.h      |   1 +
 3 files changed, 116 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index afaca5d96938..c9d59b8ac37f 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -350,6 +350,53 @@ static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
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
@@ -435,6 +482,61 @@ static int sdhci_uhs2_enable_clk(struct mmc_host *mmc)
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
@@ -589,6 +691,7 @@ static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
 	host->mmc_host_ops.start_signal_voltage_switch =
 		sdhci_uhs2_start_signal_voltage_switch;
 	host->mmc_host_ops.uhs2_set_ios = sdhci_uhs2_set_ios;
+	host->mmc_host_ops.uhs2_control = sdhci_uhs2_control;
 
 	if (!host->mmc_host_ops.uhs2_detect_init)
 		host->mmc_host_ops.uhs2_detect_init = sdhci_uhs2_do_detect_init;
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index de47c71995fb..b9db2e976010 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -236,6 +236,18 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
 }
 EXPORT_SYMBOL_GPL(sdhci_reset);
 
+void sdhci_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set)
+{
+	u32 ier;
+
+	ier = sdhci_readl(host, SDHCI_INT_ENABLE);
+	ier &= ~clear;
+	ier |= set;
+	sdhci_writel(host, ier, SDHCI_INT_ENABLE);
+	sdhci_writel(host, ier, SDHCI_SIGNAL_ENABLE);
+}
+EXPORT_SYMBOL_GPL(sdhci_clear_set_irqs);
+
 static bool sdhci_do_reset(struct sdhci_host *host, u8 mask)
 {
 	if (host->quirks & SDHCI_QUIRK_NO_CARD_NO_RESET) {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 22d7f47862ae..f049331bd0bc 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -869,6 +869,7 @@ void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq);
 int sdhci_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
 void sdhci_set_bus_width(struct sdhci_host *host, int width);
 void sdhci_reset(struct sdhci_host *host, u8 mask);
+void sdhci_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set);
 void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
 int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
 void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
-- 
2.25.1

