Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D344364B1D3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbiLMJDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235012AbiLMJCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:02:07 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C902DF02E;
        Tue, 13 Dec 2022 01:02:03 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso2905496pjt.0;
        Tue, 13 Dec 2022 01:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbLCNFK4yUEg4Jb2vovMrI4jYY1qH30LfoBhRWLCbl0=;
        b=fnkii9b6+rvOHo65mYRv+TUP2xVkjHg3Ql2Vq67yU7MLmBQSW6jMngG3ndKpHJDySv
         Bq49davB5VVZxzUomzrFSF4UCB3EfCkLhtMptUX4kkQ0qIowNR1h/lcl11pXjNwdbyWa
         3HJ+jeNulBwQDoZVwSJ3x3rBLyV8x16rsw3a1nO04qO20pfHvw7H3y1L6Vc4t7SrdRjj
         Qi6T5R0Sfvth/dMbX82Z8lXXyxSj61M5o0TZv5Yrn//l+p7ckx/H9qvMmtU9yORQyOhs
         D9e8Gr3SyoW6IkMv7e3wRL28LtAdeGC+Za5cFwC+MPvvmCTL5EJsGDdhXzOn3MtjG58u
         BJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbLCNFK4yUEg4Jb2vovMrI4jYY1qH30LfoBhRWLCbl0=;
        b=qIf/ggchARo4mq52oofsAu9C2Gc0cQw0g53aLeFQQRiwzEi7jamcDZF2AZHbTz6AUm
         ZgsR1t12dCwrqXLfIidHXqPjOjgzxKeLqEVrTx6UungT7MvoU6KlQSL7XWgfEdnI8Adf
         cVSIwmDgIAh7xYT0Oeklwswg7eEqjIo5tvvzgS6JU/STJ1kqa7r/Pkzjt7bK+aEd05c+
         1+HNVilj3Ho3qZZ3uE0jNEHNxjpzPt2GZQHk6QgaVrjzurbc47P4nfea8hMPukG9uC7V
         +YmocddzXSHgyGKVCkU+w+yVf8cM2FcMcdInkED8WWKDddtzvircNhTEMldsTny+B3Oc
         TVJA==
X-Gm-Message-State: ANoB5pkx0UU+LAMgFFHqgrBmfLII81qTfW6ENTxN/ZtvvSLsura3rRaL
        v01zv3PXFQH1+U/lRhcIjUs=
X-Google-Smtp-Source: AA0mqf7+lJh2W4s0zwmY2pk4D8umsH7+/P/wgfDsAZpUoeYtTIGDX8t1mCtErmtDuw00cgyBw/GHJw==
X-Received: by 2002:a05:6a20:6d8a:b0:ad:a0c2:53ee with SMTP id gl10-20020a056a206d8a00b000ada0c253eemr7147746pzb.12.1670922123411;
        Tue, 13 Dec 2022 01:02:03 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2dc-5c03-264b-f684-a8c9-21ae.emome-ip6.hinet.net. [2001:b400:e2dc:5c03:264b:f684:a8c9:21ae])
        by smtp.gmail.com with ESMTPSA id 81-20020a621954000000b0056b9ec7e2desm7141682pfz.125.2022.12.13.01.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 01:02:02 -0800 (PST)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V6 17/24] mmc: sdhci-uhs2: add uhs2_control() to initialise the interface
Date:   Tue, 13 Dec 2022 17:00:40 +0800
Message-Id: <20221213090047.3805-18-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221213090047.3805-1-victor.shih@genesyslogic.com.tw>
References: <20221213090047.3805-1-victor.shih@genesyslogic.com.tw>
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
 drivers/mmc/host/sdhci-uhs2.c | 92 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c      | 11 +++++
 2 files changed, 103 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index c7e411fa0a6e..de15a6559702 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -276,6 +276,48 @@ static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	sdhci_set_clock(host, host->clock);
 }
 
+static void sdhci_uhs2_set_config(struct sdhci_host *host)
+{
+	u32 value;
+	u16 sdhci_uhs2_set_ptr = sdhci_readw(host, SDHCI_UHS2_SETTINGS_PTR);
+	u16 sdhci_uhs2_gen_set_reg = (sdhci_uhs2_set_ptr + 0);
+	u16 sdhci_uhs2_phy_set_reg = (sdhci_uhs2_set_ptr + 4);
+	u16 sdhci_uhs2_tran_set_reg = (sdhci_uhs2_set_ptr + 8);
+	u16 sdhci_uhs2_tran_set_1_reg = (sdhci_uhs2_set_ptr + 12);
+
+	/* Set Gen Settings */
+	value = FIELD_PREP(SDHCI_UHS2_GEN_SETTINGS_N_LANES_MASK, host->mmc->uhs2_caps.n_lanes_set);
+	sdhci_writel(host, value, sdhci_uhs2_gen_set_reg);
+
+	/* Set PHY Settings */
+	value = FIELD_PREP(SDHCI_UHS2_PHY_N_LSS_DIR_MASK, host->mmc->uhs2_caps.n_lss_dir_set) |
+		FIELD_PREP(SDHCI_UHS2_PHY_N_LSS_SYN_MASK, host->mmc->uhs2_caps.n_lss_sync_set);
+	if (host->mmc->flags & MMC_UHS2_SPEED_B)
+		value |= SDHCI_UHS2_PHY_SET_SPEED_B;
+	sdhci_writel(host, value, sdhci_uhs2_phy_set_reg);
+
+	/* Set LINK-TRAN Settings */
+	value = FIELD_PREP(SDHCI_UHS2_TRAN_RETRY_CNT_MASK, host->mmc->uhs2_caps.max_retry_set) |
+		FIELD_PREP(SDHCI_UHS2_TRAN_N_FCU_MASK, host->mmc->uhs2_caps.n_fcu_set);
+	sdhci_writel(host, value, sdhci_uhs2_tran_set_reg);
+	sdhci_writel(host, host->mmc->uhs2_caps.n_data_gap_set, sdhci_uhs2_tran_set_1_reg);
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
@@ -361,6 +403,55 @@ static int sdhci_uhs2_enable_clk(struct mmc_host *mmc)
 	return 0;
 }
 
+static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc);
+
+static int sdhci_uhs2_control(struct mmc_host *mmc, enum sd_uhs2_operation op)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	int err = 0;
+	u16 sdhci_uhs2_set_ptr = sdhci_readw(host, SDHCI_UHS2_SETTINGS_PTR);
+	u16 sdhci_uhs2_phy_set_reg = (sdhci_uhs2_set_ptr + 4);
+
+	DBG("Begin uhs2 control, act %d.\n", op);
+
+	switch (op) {
+	case UHS2_PHY_INIT:
+		err = sdhci_uhs2_do_detect_init(mmc);
+		break;
+	case UHS2_SET_CONFIG:
+		sdhci_uhs2_set_config(host);
+		break;
+	case UHS2_ENABLE_INT:
+		sdhci_uhs2_clear_set_irqs(host, 0, SDHCI_INT_CARD_INT);
+		break;
+	case UHS2_DISABLE_INT:
+		sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_CARD_INT, 0);
+		break;
+	case UHS2_SET_SPEED_B:
+		sdhci_writeb(host, SDHCI_UHS2_PHY_SET_SPEED_B, sdhci_uhs2_phy_set_reg);
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
+	return err;
+}
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
@@ -489,6 +580,7 @@ static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
 	host->mmc_host_ops.start_signal_voltage_switch =
 		sdhci_uhs2_start_signal_voltage_switch;
 	host->mmc_host_ops.uhs2_set_ios = sdhci_uhs2_set_ios;
+	host->mmc_host_ops.uhs2_control = sdhci_uhs2_control;
 
 	return 0;
 }
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 49bbdc155b2b..3656e66fcca7 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -234,6 +234,17 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
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
+
 static bool sdhci_do_reset(struct sdhci_host *host, u8 mask)
 {
 	if (host->quirks & SDHCI_QUIRK_NO_CARD_NO_RESET) {
-- 
2.25.1

