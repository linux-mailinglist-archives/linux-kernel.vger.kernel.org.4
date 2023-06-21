Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9570738042
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbjFUKFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjFUKDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:03:07 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFD919B1;
        Wed, 21 Jun 2023 03:02:50 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-66615629689so4851920b3a.2;
        Wed, 21 Jun 2023 03:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687341770; x=1689933770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQ/ejGwzr5fQf434gvF9Mt8T6F7YSHiktYA/rGcBM5Y=;
        b=Oga8BFfHzqYTHGgFb2CKLV4q70pTYMBm+MLq0BosJBMeRQMb2u6OXTs1zM41J33lFj
         a9xvdqoQ6uX6tU0IYW4zwccpD9xr9slMGUSSO/NB69HrHCO/uj9Xnx9ECPxZTqgdxP7C
         wmEIWbX1nAP2bCOy66dICLgdsP6AxTFoaQmYip0mmXJy9+YKW3h/LIt4H1tEuZb05VDx
         GscSONVpgLK1BXFQWslK/h8xcBDUGpbM0tGVvCgguUDNkEtb9QJMxmteAL/L+QCvDCAp
         EqQ/cENGPQrRB2cpWzNCdXlAlOB0+sI5enZ4NOFr0Z4t844NVKtdVLij5ldmybjhnFKz
         mBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687341770; x=1689933770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQ/ejGwzr5fQf434gvF9Mt8T6F7YSHiktYA/rGcBM5Y=;
        b=lCVlWd2HEYJXtWG3m4RsOns51Q480etGhT/wo4Q4cc61pnQZshCE/3bOPnCJoq0CbE
         +tnqsFsJ5CPbBF5NMXhl9SFLSvUftnAiiqJLfRErZRNMQSZQJr+e7H4t7g9Gc0W5WmeB
         2+x4+x65nrt2mxTeBJC5rvTfgiY2wmRTu1exxpr/Yfr1rY0rQghPF+hLzi0TCtAyaxZ6
         xZ44cks6q2gd3qSDsOhe+kPoyEvDlzcJ+WvHpVhxc5Yds54E0i/Cac2ksbxpkDh23r1y
         iXkJnz3i6lfeCw4pqPRc+/wZGSyU/R0JZUTdo8i1/U70e+TMVWLaihJs4G9menNzhikW
         aIxw==
X-Gm-Message-State: AC+VfDzEv8omXCQxTtcvUs08TrmB4U65QyAzy6DJy30AkSvyFPHa4Phl
        R6Yv0dwrUbPSiXAhHM3rpTc=
X-Google-Smtp-Source: ACHHUZ6I81g9fBA10D0mqoVTIm5479ovHzdWnB9TJJQ0Tg6iFpcB+Dp3tBMSKfe2177JEoJhFNiGLg==
X-Received: by 2002:a05:6a00:1504:b0:668:7325:e184 with SMTP id q4-20020a056a00150400b006687325e184mr11861640pfu.16.1687341769772;
        Wed, 21 Jun 2023 03:02:49 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e254-4eda-2716-05ea-20f5-b048.emome-ip6.hinet.net. [2001:b400:e254:4eda:2716:5ea:20f5:b048])
        by smtp.gmail.com with ESMTPSA id g2-20020aa78742000000b0064f46570bb7sm2611196pfo.167.2023.06.21.03.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 03:02:49 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V8 17/23] mmc: sdhci-uhs2: add uhs2_control() to initialise the interface
Date:   Wed, 21 Jun 2023 18:01:45 +0800
Message-Id: <20230621100151.6329-18-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230621100151.6329-1-victorshihgli@gmail.com>
References: <20230621100151.6329-1-victorshihgli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Victor Shih <victor.shih@genesyslogic.com.tw>

This is a sdhci version of mmc's uhs2_set_reg operation.
UHS-II interface (related registers) will be initialised here.

Updates in V8:
 - Reorder the definitions and lose the parentheses in
   sdhci_uhs2_set_config().
 - read_poll_timeout() to instead of read_poll_timeout_atomic()
   in sdhci_uhs2_check_dormant().

Updates in V7:
 - Remove unnecessary function.

Updates in V6:
 - Remove unnecessary function.
 - Remove unnecessary parameter when call the DBG().
 - Cancel export state of some functions.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-uhs2.c | 88 +++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index af1b0c5e48fd..09b86fec9f7b 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -278,6 +278,48 @@ static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	sdhci_set_clock(host, host->clock);
 }
 
+static void sdhci_uhs2_set_config(struct sdhci_host *host)
+{
+	u32 value;
+	u16 sdhci_uhs2_set_ptr = sdhci_readw(host, SDHCI_UHS2_SETTINGS_PTR);
+	u16 sdhci_uhs2_gen_set_reg	= sdhci_uhs2_set_ptr;
+	u16 sdhci_uhs2_phy_set_reg	= sdhci_uhs2_set_ptr + 4;
+	u16 sdhci_uhs2_tran_set_reg	= sdhci_uhs2_set_ptr + 8;
+	u16 sdhci_uhs2_tran_set_1_reg	= sdhci_uhs2_set_ptr + 12;
+
+	/* Set Gen Settings */
+	value = FIELD_PREP(SDHCI_UHS2_GEN_SETTINGS_N_LANES_MASK, host->mmc->uhs2_caps.n_lanes_set);
+	sdhci_writel(host, value, sdhci_uhs2_gen_set_reg);
+
+	/* Set PHY Settings */
+	value = FIELD_PREP(SDHCI_UHS2_PHY_N_LSS_DIR_MASK, host->mmc->uhs2_caps.n_lss_dir_set) |
+		FIELD_PREP(SDHCI_UHS2_PHY_N_LSS_SYN_MASK, host->mmc->uhs2_caps.n_lss_sync_set);
+	if (host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_B ||
+	    host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_B_HD)
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
+	int timeout = 100000; /* 100ms */
+	u32 val;
+
+	if (read_poll_timeout(sdhci_readl, val, (val & SDHCI_UHS2_IN_DORMANT_STATE),
+			      100, timeout, true, host, SDHCI_PRESENT_STATE)) {
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
@@ -359,6 +401,51 @@ static int sdhci_uhs2_enable_clk(struct mmc_host *mmc)
 	return 0;
 }
 
+static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc);
+
+static int sdhci_uhs2_control(struct mmc_host *mmc, enum sd_uhs2_operation op)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct mmc_ios *ios = &mmc->ios;
+	int err = 0;
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
+	case UHS2_CHECK_DORMANT:
+		err = sdhci_uhs2_check_dormant(host);
+		break;
+	case UHS2_DISABLE_CLK:
+		err = sdhci_uhs2_disable_clk(mmc);
+		break;
+	case UHS2_ENABLE_CLK:
+		err = sdhci_uhs2_enable_clk(mmc);
+		break;
+	case UHS2_SET_IOS:
+		err = sdhci_uhs2_set_ios(mmc, ios);
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
@@ -481,6 +568,7 @@ static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
 {
 	host->mmc_host_ops.start_signal_voltage_switch =
 		sdhci_uhs2_start_signal_voltage_switch;
+	host->mmc_host_ops.uhs2_control = sdhci_uhs2_control;
 
 	return 0;
 }
-- 
2.25.1

