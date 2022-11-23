Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F12635160
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 08:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235985AbiKWHud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 02:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236351AbiKWHtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 02:49:50 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6DEFC703
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 23:49:35 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id a1-20020a17090abe0100b00218a7df7789so1189836pjs.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 23:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEImNrrGJCLJR7lpSd2nSHN0zzQY9fzqQ71zihD+hPY=;
        b=tNBVG03lVciDsO8t9kXfWt8DMe+QTB1RLzHEeAA+gi5fa25FWcL3vvPPKbbt9GO3Sf
         XQrOQdaEvEE205S9ivqL47uUIc8rbtQv2at1gVO3XEhPrihcfjfc3BcWu6qYmAddB+D2
         Pp8ajE/jhpo/VjAIMq1FfRaS3SQbaBzPdLLDcO8kuOaYrp6NMfltFZ9uU8rG0K0UfPoa
         +BpkcxjQ4/dxOnbGO4ikiVdpGJMv80iV1DHg4UHgtnux8JfHnbSF2rqTRefAuCHQVCPW
         WVmY/k1h6UVxcXYsU67U3vQXpqTlK3v08iT/mz3DuYxOgSczaz0WG0a24/ohf1LjwuNt
         kRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEImNrrGJCLJR7lpSd2nSHN0zzQY9fzqQ71zihD+hPY=;
        b=JIm9rJttsWdkqTeaMXuohTgMtlnHOn2RUbPGULp19GAjeqnwAQDM6hMFioJ18p2PFl
         EhQvrYq3BRgpFFg5CDAUKZAe2Hxqv6Dz9VymiwgMpFb+5+d8YQ90xRna77WJtmCgs8SI
         53/gEEfjNxjuSeAe77njnaCZUrOYbm80bQfdg4+1osem47JhkzbiLWJvBQOsztrmGFao
         cpHpfh7l8IbmESmbGSGCfzqfVLZpBFwBwIxiUqMJiKxrZX85CVOk/iihLwzTPesm6A+v
         YJ7jHN7xKMrvJ6njTz6XyJETUT5jZ2RxWSd4uiOSJ/Bvf0V4Hbgh8+VAI7CJayEyeaJ0
         94PA==
X-Gm-Message-State: ANoB5plW+u+IbP2tfQdrQ7oTrB771hSS8hN+TDftk2a8TnjoqbNY6pcR
        r8ewyOfAgNYbsNRE9Wu0W9FK
X-Google-Smtp-Source: AA0mqf7DJGG7ecY7teJvrrYsGj2x1etItgZsLZjyKRwrt+lLBpO+r/ijGXe0c8nugcqZqSiTjRBKSw==
X-Received: by 2002:a17:902:f1c5:b0:189:39e4:c0ed with SMTP id e5-20020a170902f1c500b0018939e4c0edmr4505578plc.108.1669189775133;
        Tue, 22 Nov 2022 23:49:35 -0800 (PST)
Received: from localhost.localdomain ([117.202.191.0])
        by smtp.gmail.com with ESMTPSA id s16-20020a170902a51000b001869f2120a5sm13334059plq.34.2022.11.22.23.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 23:49:34 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org
Cc:     quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        dmitry.baryshkov@linaro.org, ahalaney@redhat.com,
        abel.vesa@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 10/20] scsi: ufs: ufs-qcom: Remove un-necessary goto statements
Date:   Wed, 23 Nov 2022 13:18:16 +0530
Message-Id: <20221123074826.95369-11-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221123074826.95369-1-manivannan.sadhasivam@linaro.org>
References: <20221123074826.95369-1-manivannan.sadhasivam@linaro.org>
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

