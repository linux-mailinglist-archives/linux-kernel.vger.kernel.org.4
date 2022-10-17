Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18692600A20
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbiJQJON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiJQJNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:13:25 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393D24C63F;
        Mon, 17 Oct 2022 02:13:06 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l1-20020a17090a72c100b0020a6949a66aso10405445pjk.1;
        Mon, 17 Oct 2022 02:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0JaYjFQ+aDdA98wvr2uZtwG5pNvlC/TFpCGLaFw/7g=;
        b=WETiCRFuvp6zEGwSY7lZvFrhm3OPpqCkBRMM5f6eiRGbK/k0CDnylzqo9Dqz1YWOq8
         dYDhnYwp5TYH6pUMAo7PF7Fe8iqoDbx463549PAuH+/XqRAqg1Xy4vYUSyNc8Pa6gxHJ
         W7jYIS2QDZZpduYrfcnvbGm7Eeg1XwuYXnrXUNuUl+QpY8K/NDDasmJK51vWOIuTMqrs
         8LiLt1mzlnVhL4aNC/7O2yAWi/MQsFm0S4cA5Y6CxqNaMu4PLX+STjUSCfsYhB/bs43Q
         NuFTjD54hRwqVxlfcXWDRE61Dw0KQAUI/g85kClXYwAvUYWWUH2XAs6ov7l1bBqhnrRz
         wAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S0JaYjFQ+aDdA98wvr2uZtwG5pNvlC/TFpCGLaFw/7g=;
        b=qg5BiZKjAC65NnvKhBPun78LB/SOiZlW3oYR5f2rFsIIHCNaDAJVkKEtDIQz8WajV6
         HRKJwr+PlOm1xvyOqCP6lqHqBLoF6Rj5kCcjjXczh0bTi6Utdbd69pBdrYAm78Kymkqj
         a7xgFa/LqkBLnB38dRbPCPz9THqg3Rfywj4WYjnTgVtozcjpzEFhCXWg8vv1n0XZG/aJ
         Jg7jLTVyknv7+f7Tsk0Du1kyHpU6Jqu0GzzqMcUOQt4Nz/zYcLUEQOybmw8ala1kpCpM
         x+CCUyGR+Lp4td04mLPr6MG6xjO0bOU90Ki9s50xuFpbbDqfzwgOBKbAfFa5watR+qYe
         NXIQ==
X-Gm-Message-State: ACrzQf1VFmcEFv9D7KsegbB0T3Fuioc05AAiuGaZVTHDuB1MoyjVN5aR
        8PSUvdchnq1yiILIXr+FNy0=
X-Google-Smtp-Source: AMsMyM7HIprIJOiSrq2Lpcf7dhqwRWO6pZIRbfVL11kOifCgR5gvQKPwfTbpwXmOi5w6iC7A4cQbJw==
X-Received: by 2002:a17:90b:3908:b0:20d:4151:1b73 with SMTP id ob8-20020a17090b390800b0020d41511b73mr12828811pjb.45.1665997978582;
        Mon, 17 Oct 2022 02:12:58 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e258-8c34-4ca3-4989-34c1-7890.emome-ip6.hinet.net. [2001:b400:e258:8c34:4ca3:4989:34c1:7890])
        by smtp.gmail.com with ESMTPSA id t22-20020a170902b21600b0017f75bc7a61sm6091996plr.166.2022.10.17.02.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 02:12:58 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V5 16/26] mmc: sdhci-uhs2: add detect_init() to detect the interface
Date:   Mon, 17 Oct 2022 17:11:43 +0800
Message-Id: <20221017091153.454873-17-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221017091153.454873-1-victor.shih@genesyslogic.com.tw>
References: <20221017091153.454873-1-victor.shih@genesyslogic.com.tw>
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

Sdhci_uhs2_do_detect_init() is a sdhci version of mmc's uhs2_detect_init
operation. After detected, the host's UHS-II capabilities will be set up
here and interrupts will also be enabled.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-uhs2.c | 150 ++++++++++++++++++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index b535a47dc55a..145508918486 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -409,12 +409,162 @@ int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
  *                                                                           *
 \*****************************************************************************/
 
+static int sdhci_uhs2_interface_detect(struct sdhci_host *host)
+{
+	/* 100ms */
+	int timeout = 100000;
+	u32 val;
+
+	udelay(200); /* wait for 200us before check */
+
+	if (read_poll_timeout_atomic(sdhci_readl, val, (val & SDHCI_UHS2_IF_DETECT),
+				     100, timeout, true, host, SDHCI_PRESENT_STATE)) {
+		pr_warn("%s: not detect UHS2 interface in 200us.\n", mmc_hostname(host->mmc));
+		sdhci_dumpregs(host);
+		return -EIO;
+	}
+
+	/* Enable UHS2 error interrupts */
+	sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK,
+				  SDHCI_UHS2_ERR_INT_STATUS_MASK);
+
+	/* 150ms */
+	timeout = 150000;
+	if (read_poll_timeout_atomic(sdhci_readl, val, (val & SDHCI_UHS2_LANE_SYNC),
+				     100, timeout, true, host, SDHCI_PRESENT_STATE)) {
+		pr_warn("%s: UHS2 Lane sync fail in 150ms.\n", mmc_hostname(host->mmc));
+		sdhci_dumpregs(host);
+		return -EIO;
+	}
+
+	DBG("%s: UHS2 Lane synchronized in UHS2 mode, PHY is initialized.\n",
+	    mmc_hostname(host->mmc));
+	return 0;
+}
+
+static int sdhci_uhs2_init(struct sdhci_host *host)
+{
+	u16 caps_ptr = 0;
+	u32 caps_gen = 0;
+	u32 caps_phy = 0;
+	u32 caps_tran[2] = {0, 0};
+	struct mmc_host *mmc = host->mmc;
+
+	/*
+	 * TODO: may add corresponding members in sdhci_host to
+	 * keep these caps.
+	 */
+	caps_ptr = sdhci_readw(host, SDHCI_UHS2_HOST_CAPS_PTR);
+	if (caps_ptr < 0x100 || caps_ptr > 0x1FF) {
+		pr_err("%s: SDHCI_UHS2_HOST_CAPS_PTR(%d) is wrong.\n",
+		       mmc_hostname(mmc), caps_ptr);
+		return -ENODEV;
+	}
+	caps_gen = sdhci_readl(host,
+			       caps_ptr + SDHCI_UHS2_HOST_CAPS_GEN_OFFSET);
+	caps_phy = sdhci_readl(host,
+			       caps_ptr + SDHCI_UHS2_HOST_CAPS_PHY_OFFSET);
+	caps_tran[0] = sdhci_readl(host,
+				   caps_ptr + SDHCI_UHS2_HOST_CAPS_TRAN_OFFSET);
+	caps_tran[1] = sdhci_readl(host,
+				   caps_ptr
+					+ SDHCI_UHS2_HOST_CAPS_TRAN_1_OFFSET);
+
+	/* General Caps */
+	mmc->uhs2_caps.dap = caps_gen & SDHCI_UHS2_HOST_CAPS_GEN_DAP_MASK;
+	mmc->uhs2_caps.gap = (caps_gen & SDHCI_UHS2_HOST_CAPS_GEN_GAP_MASK) >>
+			     SDHCI_UHS2_HOST_CAPS_GEN_GAP_SHIFT;
+	mmc->uhs2_caps.n_lanes = (caps_gen & SDHCI_UHS2_HOST_CAPS_GEN_LANE_MASK)
+			>> SDHCI_UHS2_HOST_CAPS_GEN_LANE_SHIFT;
+	mmc->uhs2_caps.addr64 =
+		(caps_gen & SDHCI_UHS2_HOST_CAPS_GEN_ADDR_64) ? 1 : 0;
+	mmc->uhs2_caps.card_type =
+		(caps_gen & SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_MASK) >>
+		SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_SHIFT;
+
+	/* PHY Caps */
+	mmc->uhs2_caps.phy_rev = caps_phy & SDHCI_UHS2_HOST_CAPS_PHY_REV_MASK;
+	mmc->uhs2_caps.speed_range =
+		(caps_phy & SDHCI_UHS2_HOST_CAPS_PHY_RANGE_MASK)
+		>> SDHCI_UHS2_HOST_CAPS_PHY_RANGE_SHIFT;
+	mmc->uhs2_caps.n_lss_sync =
+		(caps_phy & SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_SYN_MASK)
+		>> SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_SYN_SHIFT;
+	mmc->uhs2_caps.n_lss_dir =
+		(caps_phy & SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_DIR_MASK)
+		>> SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_DIR_SHIFT;
+	if (mmc->uhs2_caps.n_lss_sync == 0)
+		mmc->uhs2_caps.n_lss_sync = 16 << 2;
+	else
+		mmc->uhs2_caps.n_lss_sync <<= 2;
+	if (mmc->uhs2_caps.n_lss_dir == 0)
+		mmc->uhs2_caps.n_lss_dir = 16 << 3;
+	else
+		mmc->uhs2_caps.n_lss_dir <<= 3;
+
+	/* LINK/TRAN Caps */
+	mmc->uhs2_caps.link_rev =
+		caps_tran[0] & SDHCI_UHS2_HOST_CAPS_TRAN_LINK_REV_MASK;
+	mmc->uhs2_caps.n_fcu =
+		(caps_tran[0] & SDHCI_UHS2_HOST_CAPS_TRAN_N_FCU_MASK)
+		>> SDHCI_UHS2_HOST_CAPS_TRAN_N_FCU_SHIFT;
+	if (mmc->uhs2_caps.n_fcu == 0)
+		mmc->uhs2_caps.n_fcu = 256;
+	mmc->uhs2_caps.host_type =
+		(caps_tran[0] & SDHCI_UHS2_HOST_CAPS_TRAN_HOST_TYPE_MASK)
+		>> SDHCI_UHS2_HOST_CAPS_TRAN_HOST_TYPE_SHIFT;
+	mmc->uhs2_caps.maxblk_len =
+		(caps_tran[0] & SDHCI_UHS2_HOST_CAPS_TRAN_BLK_LEN_MASK)
+		>> SDHCI_UHS2_HOST_CAPS_TRAN_BLK_LEN_SHIFT;
+	mmc->uhs2_caps.n_data_gap =
+		caps_tran[1] & SDHCI_UHS2_HOST_CAPS_TRAN_1_N_DATA_GAP_MASK;
+
+	return 0;
+}
+
+static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	int ret = -EIO;
+
+	DBG("%s: begin UHS2 init.\n", __func__);
+
+	if (sdhci_uhs2_interface_detect(host)) {
+		pr_warn("%s: cannot detect UHS2 interface.\n",
+			mmc_hostname(host->mmc));
+		goto out;
+	}
+
+	if (sdhci_uhs2_init(host)) {
+		pr_warn("%s: UHS2 init fail.\n", mmc_hostname(host->mmc));
+		goto out;
+	}
+
+	/* Init complete, do soft reset and enable UHS2 error irqs. */
+	host->ops->uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
+	sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK,
+				  SDHCI_UHS2_ERR_INT_STATUS_MASK);
+	/*
+	 * !!! SDHCI_INT_ENABLE and SDHCI_SIGNAL_ENABLE was cleared
+	 * by SDHCI_UHS2_SW_RESET_SD
+	 */
+	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
+	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
+
+	ret = 0;
+out:
+	return ret;
+}
+
 static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
 {
 	host->mmc_host_ops.start_signal_voltage_switch =
 		sdhci_uhs2_start_signal_voltage_switch;
 	host->mmc_host_ops.uhs2_set_ios = sdhci_uhs2_set_ios;
 
+	if (!host->mmc_host_ops.uhs2_detect_init)
+		host->mmc_host_ops.uhs2_detect_init = sdhci_uhs2_do_detect_init;
+
 	return 0;
 }
 
-- 
2.25.1

