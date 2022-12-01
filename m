Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEFC63F696
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 18:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiLARqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 12:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiLARpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 12:45:49 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746D3B5DB7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 09:45:12 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id 130so2544150pfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 09:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEImNrrGJCLJR7lpSd2nSHN0zzQY9fzqQ71zihD+hPY=;
        b=abZ6cXJ5jEpFaBYzpmh43H4tsPfVt6pNfSbjqaUkYxoXHc1YeDebG+qIPFwFgY3yve
         DsLufoZGZPA7V30rvIHTUj6SAMbMslgXQ/VjI+uagzyAitDNv4Bszr0K0LWuyixnZ4rM
         g2gkHrG2uPN7xswI5gPSHuJd+jPZdgURBLhOYX3n2l0B9DtymQOh4tiQqtZN3rCOF32A
         wkULCIq6zD5DDJvrWxgtFMM995h9Ztozt9mSZgdLcoZxwWXkyQmxbq1+Q3b1Qiqx9PT7
         1pt/uEnSDruS2W74zjEz6YL8FdaQuUnVFvo7m5ace8kp6IhBOgDWiCcqKUums/+6Mm5p
         kvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEImNrrGJCLJR7lpSd2nSHN0zzQY9fzqQ71zihD+hPY=;
        b=qo9blcJmAP155RMgHyzFisGomMrCHum9Vo8O/VMCu0icp+zel55Mcrp1MpUUI9cNtO
         vLwLkTI+h2MriyNQkk67H47fZxRM4RYZ0cerNzqokyT13adCXEl5TC1itOP+0Xwjkmuo
         GQ5gQncr6G2jIbdR/ecBqFJsWaiSbduylSQ5OfQpfial/vUf9L614lvy9okh52zmC30F
         5DxCNxEQaVwy1nQk94of5/9twYdvYacef72gpOD0iUyQyK0x5ZgwHhx141i+Ko/6B6ZG
         bbZf2whWl4RHSzukC5jQjeJKPBjNMZ+IYh0FGguyWlNJ23Yhzt5r+LW0ngDaXoNEkFg2
         ERgQ==
X-Gm-Message-State: ANoB5pljF8MMi4hSQGR3lYFzDr4zmeLsuZl3Ij68zkwSujkuqmP56H6a
        1pI68gHihnpkJtGKP5TA5QOc
X-Google-Smtp-Source: AA0mqf6xxi+NiLugwTKa1a8nr6otS+6o/AZq2exeejeajSRynu2OEJXoy7j80va1kDe+Mp3k7eu4FA==
X-Received: by 2002:a63:234e:0:b0:470:4222:c3ee with SMTP id u14-20020a63234e000000b004704222c3eemr60697272pgm.571.1669916711871;
        Thu, 01 Dec 2022 09:45:11 -0800 (PST)
Received: from localhost.localdomain ([220.158.159.39])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016d9b101413sm3898743pll.200.2022.12.01.09.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 09:45:11 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org
Cc:     quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        dmitry.baryshkov@linaro.org, ahalaney@redhat.com,
        abel.vesa@linaro.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 13/23] scsi: ufs: ufs-qcom: Remove un-necessary goto statements
Date:   Thu,  1 Dec 2022 23:13:18 +0530
Message-Id: <20221201174328.870152-14-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221201174328.870152-1-manivannan.sadhasivam@linaro.org>
References: <20221201174328.870152-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

goto in error path is useful if the function needs to do cleanup other
than returning the error code. But in this driver, goto statements are
used for just returning the error code in many places. This really
makes it hard to read the code.

So let's get rid of those goto statements and just return the error code
directly.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 100 +++++++++++++++---------------------
 1 file changed, 41 insertions(+), 59 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 8ad1415e10b6..7cd996ac180b 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -110,7 +110,7 @@ static void ufs_qcom_disable_lane_clks(struct ufs_qcom_host *host)
 
 static int ufs_qcom_enable_lane_clks(struct ufs_qcom_host *host)
 {
-	int err = 0;
+	int err;
 	struct device *dev = host->hba->dev;
 
 	if (host->is_lane_clks_enabled)
@@ -119,7 +119,7 @@ static int ufs_qcom_enable_lane_clks(struct ufs_qcom_host *host)
 	err = ufs_qcom_host_clk_enable(dev, "rx_lane0_sync_clk",
 		host->rx_l0_sync_clk);
 	if (err)
-		goto out;
+		return err;
 
 	err = ufs_qcom_host_clk_enable(dev, "tx_lane0_sync_clk",
 		host->tx_l0_sync_clk);
@@ -137,7 +137,8 @@ static int ufs_qcom_enable_lane_clks(struct ufs_qcom_host *host)
 		goto disable_rx_l1;
 
 	host->is_lane_clks_enabled = true;
-	goto out;
+
+	return 0;
 
 disable_rx_l1:
 	clk_disable_unprepare(host->rx_l1_sync_clk);
@@ -145,7 +146,7 @@ static int ufs_qcom_enable_lane_clks(struct ufs_qcom_host *host)
 	clk_disable_unprepare(host->tx_l0_sync_clk);
 disable_rx_l0:
 	clk_disable_unprepare(host->rx_l0_sync_clk);
-out:
+
 	return err;
 }
 
@@ -160,25 +161,25 @@ static int ufs_qcom_init_lane_clks(struct ufs_qcom_host *host)
 	err = ufs_qcom_host_clk_get(dev, "rx_lane0_sync_clk",
 					&host->rx_l0_sync_clk, false);
 	if (err)
-		goto out;
+		return err;
 
 	err = ufs_qcom_host_clk_get(dev, "tx_lane0_sync_clk",
 					&host->tx_l0_sync_clk, false);
 	if (err)
-		goto out;
+		return err;
 
 	/* In case of single lane per direction, don't read lane1 clocks */
 	if (host->hba->lanes_per_direction > 1) {
 		err = ufs_qcom_host_clk_get(dev, "rx_lane1_sync_clk",
 			&host->rx_l1_sync_clk, false);
 		if (err)
-			goto out;
+			return err;
 
 		err = ufs_qcom_host_clk_get(dev, "tx_lane1_sync_clk",
 			&host->tx_l1_sync_clk, true);
 	}
-out:
-	return err;
+
+	return 0;
 }
 
 static int ufs_qcom_check_hibern8(struct ufs_hba *hba)
@@ -241,7 +242,7 @@ static int ufs_qcom_host_reset(struct ufs_hba *hba)
 
 	if (!host->core_reset) {
 		dev_warn(hba->dev, "%s: reset control not set\n", __func__);
-		goto out;
+		return 0;
 	}
 
 	reenable_intr = hba->is_irq_enabled;
@@ -252,7 +253,7 @@ static int ufs_qcom_host_reset(struct ufs_hba *hba)
 	if (ret) {
 		dev_err(hba->dev, "%s: core_reset assert failed, err = %d\n",
 				 __func__, ret);
-		goto out;
+		return ret;
 	}
 
 	/*
@@ -274,15 +275,14 @@ static int ufs_qcom_host_reset(struct ufs_hba *hba)
 		hba->is_irq_enabled = true;
 	}
 
-out:
-	return ret;
+	return 0;
 }
 
 static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
 	struct phy *phy = host->generic_phy;
-	int ret = 0;
+	int ret;
 	bool is_rate_B = UFS_QCOM_LIMIT_HS_RATE == PA_HS_MODE_B;
 
 	/* Reset UFS Host Controller and PHY */
@@ -299,7 +299,7 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 	if (ret) {
 		dev_err(hba->dev, "%s: phy init failed, ret = %d\n",
 			__func__, ret);
-		goto out;
+		return ret;
 	}
 
 	/* power on phy - start serdes and phy's power and clocks */
@@ -316,7 +316,7 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 
 out_disable_phy:
 	phy_exit(phy);
-out:
+
 	return ret;
 }
 
@@ -374,7 +374,6 @@ static int ufs_qcom_hce_enable_notify(struct ufs_hba *hba,
 static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
 			       u32 hs, u32 rate, bool update_link_startup_timer)
 {
-	int ret = 0;
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
 	struct ufs_clk_info *clki;
 	u32 core_clk_period_in_ns;
@@ -409,11 +408,11 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
 	 * Aggregation logic.
 	*/
 	if (ufs_qcom_cap_qunipro(host) && !ufshcd_is_intr_aggr_allowed(hba))
-		goto out;
+		return 0;
 
 	if (gear == 0) {
 		dev_err(hba->dev, "%s: invalid gear = %d\n", __func__, gear);
-		goto out_error;
+		return -EINVAL;
 	}
 
 	list_for_each_entry(clki, &hba->clk_list_head, list) {
@@ -436,7 +435,7 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
 	}
 
 	if (ufs_qcom_cap_qunipro(host))
-		goto out;
+		return 0;
 
 	core_clk_period_in_ns = NSEC_PER_SEC / core_clk_rate;
 	core_clk_period_in_ns <<= OFFSET_CLK_NS_REG;
@@ -451,7 +450,7 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
 					"%s: index %d exceeds table size %zu\n",
 					__func__, gear,
 					ARRAY_SIZE(hs_fr_table_rA));
-				goto out_error;
+				return -EINVAL;
 			}
 			tx_clk_cycles_per_us = hs_fr_table_rA[gear-1][1];
 		} else if (rate == PA_HS_MODE_B) {
@@ -460,13 +459,13 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
 					"%s: index %d exceeds table size %zu\n",
 					__func__, gear,
 					ARRAY_SIZE(hs_fr_table_rB));
-				goto out_error;
+				return -EINVAL;
 			}
 			tx_clk_cycles_per_us = hs_fr_table_rB[gear-1][1];
 		} else {
 			dev_err(hba->dev, "%s: invalid rate = %d\n",
 				__func__, rate);
-			goto out_error;
+			return -EINVAL;
 		}
 		break;
 	case SLOWAUTO_MODE:
@@ -476,14 +475,14 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
 					"%s: index %d exceeds table size %zu\n",
 					__func__, gear,
 					ARRAY_SIZE(pwm_fr_table));
-			goto out_error;
+			return -EINVAL;
 		}
 		tx_clk_cycles_per_us = pwm_fr_table[gear-1][1];
 		break;
 	case UNCHANGED:
 	default:
 		dev_err(hba->dev, "%s: invalid mode = %d\n", __func__, hs);
-		goto out_error;
+		return -EINVAL;
 	}
 
 	if (ufshcd_readl(hba, REG_UFS_TX_SYMBOL_CLK_NS_US) !=
@@ -507,12 +506,8 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
 		 */
 		mb();
 	}
-	goto out;
 
-out_error:
-	ret = -EINVAL;
-out:
-	return ret;
+	return 0;
 }
 
 static int ufs_qcom_link_startup_notify(struct ufs_hba *hba,
@@ -527,8 +522,7 @@ static int ufs_qcom_link_startup_notify(struct ufs_hba *hba,
 					0, true)) {
 			dev_err(hba->dev, "%s: ufs_qcom_cfg_timers() failed\n",
 				__func__);
-			err = -EINVAL;
-			goto out;
+			return -EINVAL;
 		}
 
 		if (ufs_qcom_cap_qunipro(host))
@@ -554,7 +548,6 @@ static int ufs_qcom_link_startup_notify(struct ufs_hba *hba,
 		break;
 	}
 
-out:
 	return err;
 }
 
@@ -691,8 +684,7 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
 
 	if (!dev_req_params) {
 		pr_err("%s: incoming dev_req_params is NULL\n", __func__);
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	switch (status) {
@@ -720,7 +712,7 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
 		if (ret) {
 			pr_err("%s: failed to determine capabilities\n",
 					__func__);
-			goto out;
+			return ret;
 		}
 
 		/* enable the device ref clock before changing to HS mode */
@@ -761,7 +753,7 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
 		ret = -EINVAL;
 		break;
 	}
-out:
+
 	return ret;
 }
 
@@ -773,14 +765,11 @@ static int ufs_qcom_quirk_host_pa_saveconfigtime(struct ufs_hba *hba)
 	err = ufshcd_dme_get(hba, UIC_ARG_MIB(PA_VS_CONFIG_REG1),
 			     &pa_vs_config_reg1);
 	if (err)
-		goto out;
+		return err;
 
 	/* Allow extension of MSB bits of PA_SaveConfigTime attribute */
-	err = ufshcd_dme_set(hba, UIC_ARG_MIB(PA_VS_CONFIG_REG1),
+	return ufshcd_dme_set(hba, UIC_ARG_MIB(PA_VS_CONFIG_REG1),
 			    (pa_vs_config_reg1 | (1 << 12)));
-
-out:
-	return err;
 }
 
 static int ufs_qcom_apply_dev_quirks(struct ufs_hba *hba)
@@ -957,9 +946,8 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 
 	host = devm_kzalloc(dev, sizeof(*host), GFP_KERNEL);
 	if (!host) {
-		err = -ENOMEM;
 		dev_err(dev, "%s: no memory for qcom ufs host\n", __func__);
-		goto out;
+		return -ENOMEM;
 	}
 
 	/* Make a two way bind between the qcom host and the hba */
@@ -980,10 +968,8 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 	host->rcdev.owner = dev->driver->owner;
 	host->rcdev.nr_resets = 1;
 	err = devm_reset_controller_register(dev, &host->rcdev);
-	if (err) {
+	if (err)
 		dev_warn(dev, "Failed to register reset controller\n");
-		err = 0;
-	}
 
 	if (!has_acpi_companion(dev)) {
 		host->generic_phy = devm_phy_get(dev, "ufsphy");
@@ -1049,17 +1035,16 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 	host->dbg_print_en |= UFS_QCOM_DEFAULT_DBG_PRINT_EN;
 	ufs_qcom_get_default_testbus_cfg(host);
 	err = ufs_qcom_testbus_config(host);
-	if (err) {
+	if (err)
+		/* Failure is non-fatal */
 		dev_warn(dev, "%s: failed to configure the testbus %d\n",
 				__func__, err);
-		err = 0;
-	}
 
-	goto out;
+	return 0;
 
 out_variant_clear:
 	ufshcd_set_variant(hba, NULL);
-out:
+
 	return err;
 }
 
@@ -1085,7 +1070,7 @@ static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
 			    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
 			    &core_clk_ctrl_reg);
 	if (err)
-		goto out;
+		return err;
 
 	core_clk_ctrl_reg &= ~DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK;
 	core_clk_ctrl_reg |= clk_cycles;
@@ -1093,11 +1078,9 @@ static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
 	/* Clear CORE_CLK_DIV_EN */
 	core_clk_ctrl_reg &= ~DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT;
 
-	err = ufshcd_dme_set(hba,
+	return ufshcd_dme_set(hba,
 			    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
 			    core_clk_ctrl_reg);
-out:
-	return err;
 }
 
 static int ufs_qcom_clk_scale_up_pre_change(struct ufs_hba *hba)
@@ -1180,7 +1163,7 @@ static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
 
 		if (err || !dev_req_params) {
 			ufshcd_uic_hibern8_exit(hba);
-			goto out;
+			return err;
 		}
 
 		ufs_qcom_cfg_timers(hba,
@@ -1191,8 +1174,7 @@ static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
 		ufshcd_uic_hibern8_exit(hba);
 	}
 
-out:
-	return err;
+	return 0;
 }
 
 static void ufs_qcom_print_hw_debug_reg_all(struct ufs_hba *hba,
-- 
2.25.1

