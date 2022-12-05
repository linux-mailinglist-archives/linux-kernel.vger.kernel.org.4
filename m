Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCBF643815
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbiLEW1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbiLEW1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:27:43 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD91B1157
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 14:27:38 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id j4so20879260lfk.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 14:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ik/UwYGkNtvCKECth4XEynNimFfWTJwc3LAnHqyGcKM=;
        b=HpWcdPQye7eAnYl6/VFGcLZEkXqb0Gbfs2zHPaNL3UDbgG71N4p95sjHZWjmdAe7oW
         /X5V1wP7L5cVQEJngTBJbfUULlZzX0s/TRMni5oQZBhJ1khqOuxqOK6kS7XDZERRXl98
         eNNmoBGEAylwHs4VxWfdfnaaMoa1ec89Ds42RIULDMVTopSPazVDDajiUE/cq3wj5KKA
         4+rhOWdwiDkbyL4uQtJ6YHwkBbCg3owcvDXoL8pDt9+t1zrw5QoQJN8Lkms7AeSwIJwg
         8osV3Ip76RKWngK7UUY7GetBKctPsW+2DZFXIvR+xans3D4n59vAFsj4WKmd7zgwbFRo
         Di2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ik/UwYGkNtvCKECth4XEynNimFfWTJwc3LAnHqyGcKM=;
        b=iwBtLFkhgUzcaB/VNaRwzh1csA9V3V3KxGdFE/KReQEtCs/pr8T4ByE1YucuiQYOFk
         h6a+hylRSDMXp4m0kHMeQra+Ivtuw4DM8uj7+vHAD3LoaIBwpmNpQ4BzzxdQ1MP8V7Oz
         DmmuPzVGP2g5DXY/vhtCwbBFo7Me3YJAd8P3bPlCFuwQKilgokMN7O1yAwZLpmFGRk8H
         z/YfygOk/Iea1wYE1Nb/UzFrgkQfxGVQebgPQzh5/po/opHtJEGIaT+9E2fJES3fjmdm
         MfIkf/Z9N2/nrhCZTFryvQdnFET5x7bXwsF1ny1t4UqFD0UXUx1DvXOqb3Lkpq2FGhyp
         Fc6A==
X-Gm-Message-State: ANoB5pkUFzgCpqa4H8GE+kv6QSO3VjhEQsV3MVRx3o6yNatduiop/KBd
        d9RkwCctdTR/lWVoe5GWLvlzgA==
X-Google-Smtp-Source: AA0mqf4ix7dAZ17Pea+SOr+Lf9tdy75RBjwTknY7dYH+pwR4H3+ziQ7VLQVdGorXp/iwo9WROlWYEQ==
X-Received: by 2002:ac2:5636:0:b0:4b5:5f97:6a18 with SMTP id b22-20020ac25636000000b004b55f976a18mr4282631lff.77.1670279257008;
        Mon, 05 Dec 2022 14:27:37 -0800 (PST)
Received: from [127.0.0.1] ([94.25.229.129])
        by smtp.gmail.com with ESMTPSA id v20-20020a2e5054000000b002797d6bb516sm1503230ljd.20.2022.12.05.14.27.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Dec 2022 14:27:36 -0800 (PST)
Date:   Tue, 06 Dec 2022 01:26:26 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org
CC:     quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        ahalaney@redhat.com, abel.vesa@linaro.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_13/23=5D_scsi=3A_ufs=3A_ufs-qc?= =?US-ASCII?Q?om=3A_Remove_un-necessary_goto_statements?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20221201174328.870152-14-manivannan.sadhasivam@linaro.org>
References: <20221201174328.870152-1-manivannan.sadhasivam@linaro.org> <20221201174328.870152-14-manivannan.sadhasivam@linaro.org>
Message-ID: <3F1FB621-3368-43C6-8D91-115352BE6921@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1 December 2022 20:43:18 GMT+03:00, Manivannan Sadhasivam <manivannan=
=2Esadhasivam@linaro=2Eorg> wrote:
>goto in error path is useful if the function needs to do cleanup other
>than returning the error code=2E But in this driver, goto statements are
>used for just returning the error code in many places=2E This really
>makes it hard to read the code=2E
>
>So let's get rid of those goto statements and just return the error code
>directly=2E
>
>Reviewed-by: Dmitry Baryshkov <dmitry=2Ebaryshkov@linaro=2Eorg>
>Signed-off-by: Manivannan Sadhasivam <manivannan=2Esadhasivam@linaro=2Eor=
g>

Reviewed-by: Dmitry Baryshkov <dmitry=2Ebaryshkov@linaro=2Eorg>


>---
> drivers/ufs/host/ufs-qcom=2Ec | 100 +++++++++++++++---------------------
> 1 file changed, 41 insertions(+), 59 deletions(-)
>
>diff --git a/drivers/ufs/host/ufs-qcom=2Ec b/drivers/ufs/host/ufs-qcom=2E=
c
>index 8ad1415e10b6=2E=2E7cd996ac180b 100644
>--- a/drivers/ufs/host/ufs-qcom=2Ec
>+++ b/drivers/ufs/host/ufs-qcom=2Ec
>@@ -110,7 +110,7 @@ static void ufs_qcom_disable_lane_clks(struct ufs_qco=
m_host *host)
>=20
> static int ufs_qcom_enable_lane_clks(struct ufs_qcom_host *host)
> {
>-	int err =3D 0;
>+	int err;
> 	struct device *dev =3D host->hba->dev;
>=20
> 	if (host->is_lane_clks_enabled)
>@@ -119,7 +119,7 @@ static int ufs_qcom_enable_lane_clks(struct ufs_qcom_=
host *host)
> 	err =3D ufs_qcom_host_clk_enable(dev, "rx_lane0_sync_clk",
> 		host->rx_l0_sync_clk);
> 	if (err)
>-		goto out;
>+		return err;
>=20
> 	err =3D ufs_qcom_host_clk_enable(dev, "tx_lane0_sync_clk",
> 		host->tx_l0_sync_clk);
>@@ -137,7 +137,8 @@ static int ufs_qcom_enable_lane_clks(struct ufs_qcom_=
host *host)
> 		goto disable_rx_l1;
>=20
> 	host->is_lane_clks_enabled =3D true;
>-	goto out;
>+
>+	return 0;
>=20
> disable_rx_l1:
> 	clk_disable_unprepare(host->rx_l1_sync_clk);
>@@ -145,7 +146,7 @@ static int ufs_qcom_enable_lane_clks(struct ufs_qcom_=
host *host)
> 	clk_disable_unprepare(host->tx_l0_sync_clk);
> disable_rx_l0:
> 	clk_disable_unprepare(host->rx_l0_sync_clk);
>-out:
>+
> 	return err;
> }
>=20
>@@ -160,25 +161,25 @@ static int ufs_qcom_init_lane_clks(struct ufs_qcom_=
host *host)
> 	err =3D ufs_qcom_host_clk_get(dev, "rx_lane0_sync_clk",
> 					&host->rx_l0_sync_clk, false);
> 	if (err)
>-		goto out;
>+		return err;
>=20
> 	err =3D ufs_qcom_host_clk_get(dev, "tx_lane0_sync_clk",
> 					&host->tx_l0_sync_clk, false);
> 	if (err)
>-		goto out;
>+		return err;
>=20
> 	/* In case of single lane per direction, don't read lane1 clocks */
> 	if (host->hba->lanes_per_direction > 1) {
> 		err =3D ufs_qcom_host_clk_get(dev, "rx_lane1_sync_clk",
> 			&host->rx_l1_sync_clk, false);
> 		if (err)
>-			goto out;
>+			return err;
>=20
> 		err =3D ufs_qcom_host_clk_get(dev, "tx_lane1_sync_clk",
> 			&host->tx_l1_sync_clk, true);
> 	}
>-out:
>-	return err;
>+
>+	return 0;
> }
>=20
> static int ufs_qcom_check_hibern8(struct ufs_hba *hba)
>@@ -241,7 +242,7 @@ static int ufs_qcom_host_reset(struct ufs_hba *hba)
>=20
> 	if (!host->core_reset) {
> 		dev_warn(hba->dev, "%s: reset control not set\n", __func__);
>-		goto out;
>+		return 0;
> 	}
>=20
> 	reenable_intr =3D hba->is_irq_enabled;
>@@ -252,7 +253,7 @@ static int ufs_qcom_host_reset(struct ufs_hba *hba)
> 	if (ret) {
> 		dev_err(hba->dev, "%s: core_reset assert failed, err =3D %d\n",
> 				 __func__, ret);
>-		goto out;
>+		return ret;
> 	}
>=20
> 	/*
>@@ -274,15 +275,14 @@ static int ufs_qcom_host_reset(struct ufs_hba *hba)
> 		hba->is_irq_enabled =3D true;
> 	}
>=20
>-out:
>-	return ret;
>+	return 0;
> }
>=20
> static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
> {
> 	struct ufs_qcom_host *host =3D ufshcd_get_variant(hba);
> 	struct phy *phy =3D host->generic_phy;
>-	int ret =3D 0;
>+	int ret;
> 	bool is_rate_B =3D UFS_QCOM_LIMIT_HS_RATE =3D=3D PA_HS_MODE_B;
>=20
> 	/* Reset UFS Host Controller and PHY */
>@@ -299,7 +299,7 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba =
*hba)
> 	if (ret) {
> 		dev_err(hba->dev, "%s: phy init failed, ret =3D %d\n",
> 			__func__, ret);
>-		goto out;
>+		return ret;
> 	}
>=20
> 	/* power on phy - start serdes and phy's power and clocks */
>@@ -316,7 +316,7 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba =
*hba)
>=20
> out_disable_phy:
> 	phy_exit(phy);
>-out:
>+
> 	return ret;
> }
>=20
>@@ -374,7 +374,6 @@ static int ufs_qcom_hce_enable_notify(struct ufs_hba =
*hba,
> static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
> 			       u32 hs, u32 rate, bool update_link_startup_timer)
> {
>-	int ret =3D 0;
> 	struct ufs_qcom_host *host =3D ufshcd_get_variant(hba);
> 	struct ufs_clk_info *clki;
> 	u32 core_clk_period_in_ns;
>@@ -409,11 +408,11 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba,=
 u32 gear,
> 	 * Aggregation logic=2E
> 	*/
> 	if (ufs_qcom_cap_qunipro(host) && !ufshcd_is_intr_aggr_allowed(hba))
>-		goto out;
>+		return 0;
>=20
> 	if (gear =3D=3D 0) {
> 		dev_err(hba->dev, "%s: invalid gear =3D %d\n", __func__, gear);
>-		goto out_error;
>+		return -EINVAL;
> 	}
>=20
> 	list_for_each_entry(clki, &hba->clk_list_head, list) {
>@@ -436,7 +435,7 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u=
32 gear,
> 	}
>=20
> 	if (ufs_qcom_cap_qunipro(host))
>-		goto out;
>+		return 0;
>=20
> 	core_clk_period_in_ns =3D NSEC_PER_SEC / core_clk_rate;
> 	core_clk_period_in_ns <<=3D OFFSET_CLK_NS_REG;
>@@ -451,7 +450,7 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u=
32 gear,
> 					"%s: index %d exceeds table size %zu\n",
> 					__func__, gear,
> 					ARRAY_SIZE(hs_fr_table_rA));
>-				goto out_error;
>+				return -EINVAL;
> 			}
> 			tx_clk_cycles_per_us =3D hs_fr_table_rA[gear-1][1];
> 		} else if (rate =3D=3D PA_HS_MODE_B) {
>@@ -460,13 +459,13 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba,=
 u32 gear,
> 					"%s: index %d exceeds table size %zu\n",
> 					__func__, gear,
> 					ARRAY_SIZE(hs_fr_table_rB));
>-				goto out_error;
>+				return -EINVAL;
> 			}
> 			tx_clk_cycles_per_us =3D hs_fr_table_rB[gear-1][1];
> 		} else {
> 			dev_err(hba->dev, "%s: invalid rate =3D %d\n",
> 				__func__, rate);
>-			goto out_error;
>+			return -EINVAL;
> 		}
> 		break;
> 	case SLOWAUTO_MODE:
>@@ -476,14 +475,14 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba,=
 u32 gear,
> 					"%s: index %d exceeds table size %zu\n",
> 					__func__, gear,
> 					ARRAY_SIZE(pwm_fr_table));
>-			goto out_error;
>+			return -EINVAL;
> 		}
> 		tx_clk_cycles_per_us =3D pwm_fr_table[gear-1][1];
> 		break;
> 	case UNCHANGED:
> 	default:
> 		dev_err(hba->dev, "%s: invalid mode =3D %d\n", __func__, hs);
>-		goto out_error;
>+		return -EINVAL;
> 	}
>=20
> 	if (ufshcd_readl(hba, REG_UFS_TX_SYMBOL_CLK_NS_US) !=3D
>@@ -507,12 +506,8 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, =
u32 gear,
> 		 */
> 		mb();
> 	}
>-	goto out;
>=20
>-out_error:
>-	ret =3D -EINVAL;
>-out:
>-	return ret;
>+	return 0;
> }
>=20
> static int ufs_qcom_link_startup_notify(struct ufs_hba *hba,
>@@ -527,8 +522,7 @@ static int ufs_qcom_link_startup_notify(struct ufs_hb=
a *hba,
> 					0, true)) {
> 			dev_err(hba->dev, "%s: ufs_qcom_cfg_timers() failed\n",
> 				__func__);
>-			err =3D -EINVAL;
>-			goto out;
>+			return -EINVAL;
> 		}
>=20
> 		if (ufs_qcom_cap_qunipro(host))
>@@ -554,7 +548,6 @@ static int ufs_qcom_link_startup_notify(struct ufs_hb=
a *hba,
> 		break;
> 	}
>=20
>-out:
> 	return err;
> }
>=20
>@@ -691,8 +684,7 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba =
*hba,
>=20
> 	if (!dev_req_params) {
> 		pr_err("%s: incoming dev_req_params is NULL\n", __func__);
>-		ret =3D -EINVAL;
>-		goto out;
>+		return -EINVAL;
> 	}
>=20
> 	switch (status) {
>@@ -720,7 +712,7 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba =
*hba,
> 		if (ret) {
> 			pr_err("%s: failed to determine capabilities\n",
> 					__func__);
>-			goto out;
>+			return ret;
> 		}
>=20
> 		/* enable the device ref clock before changing to HS mode */
>@@ -761,7 +753,7 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba =
*hba,
> 		ret =3D -EINVAL;
> 		break;
> 	}
>-out:
>+
> 	return ret;
> }
>=20
>@@ -773,14 +765,11 @@ static int ufs_qcom_quirk_host_pa_saveconfigtime(st=
ruct ufs_hba *hba)
> 	err =3D ufshcd_dme_get(hba, UIC_ARG_MIB(PA_VS_CONFIG_REG1),
> 			     &pa_vs_config_reg1);
> 	if (err)
>-		goto out;
>+		return err;
>=20
> 	/* Allow extension of MSB bits of PA_SaveConfigTime attribute */
>-	err =3D ufshcd_dme_set(hba, UIC_ARG_MIB(PA_VS_CONFIG_REG1),
>+	return ufshcd_dme_set(hba, UIC_ARG_MIB(PA_VS_CONFIG_REG1),
> 			    (pa_vs_config_reg1 | (1 << 12)));
>-
>-out:
>-	return err;
> }
>=20
> static int ufs_qcom_apply_dev_quirks(struct ufs_hba *hba)
>@@ -957,9 +946,8 @@ static int ufs_qcom_init(struct ufs_hba *hba)
>=20
> 	host =3D devm_kzalloc(dev, sizeof(*host), GFP_KERNEL);
> 	if (!host) {
>-		err =3D -ENOMEM;
> 		dev_err(dev, "%s: no memory for qcom ufs host\n", __func__);
>-		goto out;
>+		return -ENOMEM;
> 	}
>=20
> 	/* Make a two way bind between the qcom host and the hba */
>@@ -980,10 +968,8 @@ static int ufs_qcom_init(struct ufs_hba *hba)
> 	host->rcdev=2Eowner =3D dev->driver->owner;
> 	host->rcdev=2Enr_resets =3D 1;
> 	err =3D devm_reset_controller_register(dev, &host->rcdev);
>-	if (err) {
>+	if (err)
> 		dev_warn(dev, "Failed to register reset controller\n");
>-		err =3D 0;
>-	}
>=20
> 	if (!has_acpi_companion(dev)) {
> 		host->generic_phy =3D devm_phy_get(dev, "ufsphy");
>@@ -1049,17 +1035,16 @@ static int ufs_qcom_init(struct ufs_hba *hba)
> 	host->dbg_print_en |=3D UFS_QCOM_DEFAULT_DBG_PRINT_EN;
> 	ufs_qcom_get_default_testbus_cfg(host);
> 	err =3D ufs_qcom_testbus_config(host);
>-	if (err) {
>+	if (err)
>+		/* Failure is non-fatal */
> 		dev_warn(dev, "%s: failed to configure the testbus %d\n",
> 				__func__, err);
>-		err =3D 0;
>-	}
>=20
>-	goto out;
>+	return 0;
>=20
> out_variant_clear:
> 	ufshcd_set_variant(hba, NULL);
>-out:
>+
> 	return err;
> }
>=20
>@@ -1085,7 +1070,7 @@ static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_=
div(struct ufs_hba *hba,
> 			    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
> 			    &core_clk_ctrl_reg);
> 	if (err)
>-		goto out;
>+		return err;
>=20
> 	core_clk_ctrl_reg &=3D ~DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MA=
SK;
> 	core_clk_ctrl_reg |=3D clk_cycles;
>@@ -1093,11 +1078,9 @@ static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear=
_div(struct ufs_hba *hba,
> 	/* Clear CORE_CLK_DIV_EN */
> 	core_clk_ctrl_reg &=3D ~DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT;
>=20
>-	err =3D ufshcd_dme_set(hba,
>+	return ufshcd_dme_set(hba,
> 			    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
> 			    core_clk_ctrl_reg);
>-out:
>-	return err;
> }
>=20
> static int ufs_qcom_clk_scale_up_pre_change(struct ufs_hba *hba)
>@@ -1180,7 +1163,7 @@ static int ufs_qcom_clk_scale_notify(struct ufs_hba=
 *hba,
>=20
> 		if (err || !dev_req_params) {
> 			ufshcd_uic_hibern8_exit(hba);
>-			goto out;
>+			return err;
> 		}
>=20
> 		ufs_qcom_cfg_timers(hba,
>@@ -1191,8 +1174,7 @@ static int ufs_qcom_clk_scale_notify(struct ufs_hba=
 *hba,
> 		ufshcd_uic_hibern8_exit(hba);
> 	}
>=20
>-out:
>-	return err;
>+	return 0;
> }
>=20
> static void ufs_qcom_print_hw_debug_reg_all(struct ufs_hba *hba,

--=20
With best wishes
Dmitry
