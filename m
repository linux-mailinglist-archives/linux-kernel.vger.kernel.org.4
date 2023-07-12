Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F767504D1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjGLKhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 06:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbjGLKgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:36:51 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A9D1FD8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:36:29 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-66869feb7d1so3752487b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689158176; x=1691750176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lRntyMiDXIrlEPonKFcypmd70adqqA/4SVPD5U+6Pw=;
        b=ddU83xthwqQHlQU/YGoDeOpAw9U+JX7LkQE4ctdRFq74dv4GDtENlF6DZ2gIqcGrNV
         yFv9MgvMVOqPOSjIhpaNyUq+WFmP4myJAzbj8BlEnoqWro/Hq1relo3krXlBnBqjbYdK
         ZFfdG6jo/q6kUwahfI1O4NH2bX6d2j8gsP+aqzgOpSwSrZAHcC75gJrbZeTU1vVXJsj+
         SmTVhKyBQhn4kkaMNRAFR4btcb2y2d9rDbKMDqOrjJQ8Sal6335uKM6Z7bsd62gP3ijy
         xtijtiu7X/WGwSYtaDpvrH5o05v97vKNW+KkfmRslinvlIRiueaTKlErJxNM4ZmwjMRi
         9ZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689158176; x=1691750176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9lRntyMiDXIrlEPonKFcypmd70adqqA/4SVPD5U+6Pw=;
        b=PbVsTFq3JHq9JrYCnk5+6QlON1ZNFX4xzaY0pBh9HtXs9j5mMmkWzgilvga36fQ2sx
         catMpYny6V3s9++0htZfm8Q8tYizZ9jfpv8wbfECzsFUlzhdZaV1ST1NavswI6BWNStw
         d+l0DK2f2znv/rLxE2qG8Aetk6gJgYHlnBR6WxWYhK7XotH9WE/78cD82k6q7JSejSSp
         A6clKY9VYa31antly+Dl1SmQMAVk81x2SbPd0QuPXgSCnfGz02e6eQuKRHW6gAOYn56l
         0eHf5i4HIpS8g2eUnNG5gROmGTyE7vMbFpIEBKSAZTNYtbXnFNnXgUJugpWgtMCzQ1k1
         RnZQ==
X-Gm-Message-State: ABy/qLZSp2I6VF4MeHh5eX5s6fqRQotvTMYhRiZFUKSewO91+y8vh7wT
        DE3Uxqksim+V+2EUmqV4DVny
X-Google-Smtp-Source: APBJJlGQUwDbSGJrHqVcu6A2gvQRGShHhK1KCG3qxa2uNIpsVhibSvARTj1VdpoTT6zli3Sjs1XNRQ==
X-Received: by 2002:a05:6a00:2d0c:b0:65b:351a:e70a with SMTP id fa12-20020a056a002d0c00b0065b351ae70amr16474124pfb.29.1689158176512;
        Wed, 12 Jul 2023 03:36:16 -0700 (PDT)
Received: from localhost.localdomain ([117.207.27.131])
        by smtp.gmail.com with ESMTPSA id k15-20020aa790cf000000b00666b3706be6sm3247860pfk.107.2023.07.12.03.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 03:36:16 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 14/14] scsi: ufs: qcom: Add support for scaling interconnects
Date:   Wed, 12 Jul 2023 16:02:13 +0530
Message-Id: <20230712103213.101770-19-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
References: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qcom SoCs require scaling the interconnect paths for proper working of the
peripherals connected through interconnects. Even for accessing the UFS
controller, someone should setup the interconnect paths. So far, the
bootloaders used to setup the interconnect paths before booting linux as
they need to access the UFS storage for things like fetching boot firmware.
But with the advent of multi boot options, bootloader nowadays like in
SA8540p SoC do not setup the interconnect paths at all.

So trying to configure UFS in the absence of the interconnect path
configuration, results in boot crash.

To fix this issue and also to dynamically scale the interconnects (UFS-DDR
and CPU-UFS), interconnect API support is added to the Qcom UFS driver.
With this support, the interconnect paths are scaled dynamically based on
the gear configuration.

During the early stage of ufs_qcom_init(), ufs_qcom_icc_init() will setup
the paths to max bandwidth to allow configuring the UFS registers. Touching
the registers without configuring the icc paths would result in a crash.
However, we don't really need to set max vote for the icc paths as any
minimal vote would suffice. But the max value would allow initialization to
be done faster. After init, the bandwidth will get updated using
ufs_qcom_icc_update_bw() based on the gear and lane configuration.

The bandwidth values defined in ufs_qcom_bw_table struct are taken from
Qcom downstream vendor devicetree source and are calculated as per the
UFS3.1 Spec, Section 6.4.1, HS Gear Rates. So it is fixed across platforms.

Cc: Brian Masney <bmasney@redhat.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 131 +++++++++++++++++++++++++++++++++++-
 drivers/ufs/host/ufs-qcom.h |   3 +
 2 files changed, 133 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 8d6fd4c3324f..8a3132d45a65 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -7,6 +7,7 @@
 #include <linux/time.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/interconnect.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -46,6 +47,49 @@ enum {
 	TSTBUS_MAX,
 };
 
+#define QCOM_UFS_MAX_GEAR 4
+#define QCOM_UFS_MAX_LANE 2
+
+enum {
+	MODE_MIN,
+	MODE_PWM,
+	MODE_HS_RA,
+	MODE_HS_RB,
+	MODE_MAX,
+};
+
+struct __ufs_qcom_bw_table {
+	u32 bw1;
+	u32 bw2;
+} ufs_qcom_bw_table[MODE_MAX + 1][QCOM_UFS_MAX_GEAR + 1][QCOM_UFS_MAX_LANE + 1] = {
+	[MODE_MIN][0][0] = { 0,		0 },	/* Bandwidth values are in KB/s */
+	[MODE_PWM][1][1] = { 922,	1000 },
+	[MODE_PWM][2][1] = { 1844,	1000 },
+	[MODE_PWM][3][1] = { 3688,	1000 },
+	[MODE_PWM][4][1] = { 7376,	1000 },
+	[MODE_PWM][1][2] = { 1844,	1000 },
+	[MODE_PWM][2][2] = { 3688,	1000 },
+	[MODE_PWM][3][2] = { 7376,	1000 },
+	[MODE_PWM][4][2] = { 14752,	1000 },
+	[MODE_HS_RA][1][1] = { 127796,	1000 },
+	[MODE_HS_RA][2][1] = { 255591,	1000 },
+	[MODE_HS_RA][3][1] = { 1492582,	102400 },
+	[MODE_HS_RA][4][1] = { 2915200,	204800 },
+	[MODE_HS_RA][1][2] = { 255591,	1000 },
+	[MODE_HS_RA][2][2] = { 511181,	1000 },
+	[MODE_HS_RA][3][2] = { 1492582,	204800 },
+	[MODE_HS_RA][4][2] = { 2915200,	409600 },
+	[MODE_HS_RB][1][1] = { 149422,	1000 },
+	[MODE_HS_RB][2][1] = { 298189,	1000 },
+	[MODE_HS_RB][3][1] = { 1492582,	102400 },
+	[MODE_HS_RB][4][1] = { 2915200,	204800 },
+	[MODE_HS_RB][1][2] = { 298189,	1000 },
+	[MODE_HS_RB][2][2] = { 596378,	1000 },
+	[MODE_HS_RB][3][2] = { 1492582,	204800 },
+	[MODE_HS_RB][4][2] = { 2915200,	409600 },
+	[MODE_MAX][0][0] = { 7643136, 307200 },
+};
+
 static struct ufs_qcom_host *ufs_qcom_hosts[MAX_UFS_QCOM_HOSTS];
 
 static void ufs_qcom_get_default_testbus_cfg(struct ufs_qcom_host *host);
@@ -789,6 +833,51 @@ static void ufs_qcom_dev_ref_clk_ctrl(struct ufs_qcom_host *host, bool enable)
 	}
 }
 
+static int ufs_qcom_icc_set_bw(struct ufs_qcom_host *host, u32 bw1, u32 bw2)
+{
+	struct device *dev = host->hba->dev;
+	int ret;
+
+	ret = icc_set_bw(host->icc_ddr, 0, bw1);
+	if (ret < 0) {
+		dev_err(dev, "failed to set bandwidth request: %d\n", ret);
+		return ret;
+	}
+
+	ret = icc_set_bw(host->icc_cpu, 0, bw2);
+	if (ret < 0) {
+		dev_err(dev, "failed to set bandwidth request: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct __ufs_qcom_bw_table ufs_qcom_get_bw_table(struct ufs_qcom_host *host)
+{
+	struct ufs_pa_layer_attr *p = &host->dev_req_params;
+	int gear = max_t(u32, p->gear_rx, p->gear_tx);
+	int lane = max_t(u32, p->lane_rx, p->lane_tx);
+
+	if (ufshcd_is_hs_mode(p)) {
+		if (p->hs_rate == PA_HS_MODE_B)
+			return ufs_qcom_bw_table[MODE_HS_RB][gear][lane];
+		else
+			return ufs_qcom_bw_table[MODE_HS_RA][gear][lane];
+	} else {
+		return ufs_qcom_bw_table[MODE_PWM][gear][lane];
+	}
+}
+
+static int ufs_qcom_icc_update_bw(struct ufs_qcom_host *host)
+{
+	struct __ufs_qcom_bw_table bw_table;
+
+	bw_table = ufs_qcom_get_bw_table(host);
+
+	return ufs_qcom_icc_set_bw(host, bw_table.bw1, bw_table.bw2);
+}
+
 static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
 				enum ufs_notify_change_status status,
 				struct ufs_pa_layer_attr *dev_max_params,
@@ -852,6 +941,8 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
 		memcpy(&host->dev_req_params,
 				dev_req_params, sizeof(*dev_req_params));
 
+		ufs_qcom_icc_update_bw(host);
+
 		/* disable the device ref clock if entered PWM mode */
 		if (ufshcd_is_hs_mode(&hba->pwr_info) &&
 			!ufshcd_is_hs_mode(dev_req_params))
@@ -981,7 +1072,9 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
 
 	switch (status) {
 	case PRE_CHANGE:
-		if (!on) {
+		if (on) {
+			ufs_qcom_icc_update_bw(host);
+		} else {
 			if (!ufs_qcom_is_link_active(hba)) {
 				/* disable device ref_clk */
 				ufs_qcom_dev_ref_clk_ctrl(host, false);
@@ -993,6 +1086,9 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
 			/* enable the device ref clock for HS mode*/
 			if (ufshcd_is_hs_mode(&hba->pwr_info))
 				ufs_qcom_dev_ref_clk_ctrl(host, true);
+		} else {
+			ufs_qcom_icc_set_bw(host, ufs_qcom_bw_table[MODE_MIN][0][0].bw1,
+					    ufs_qcom_bw_table[MODE_MIN][0][0].bw2);
 		}
 		break;
 	}
@@ -1031,6 +1127,34 @@ static const struct reset_control_ops ufs_qcom_reset_ops = {
 	.deassert = ufs_qcom_reset_deassert,
 };
 
+static int ufs_qcom_icc_init(struct ufs_qcom_host *host)
+{
+	struct device *dev = host->hba->dev;
+	int ret;
+
+	host->icc_ddr = devm_of_icc_get(dev, "ufs-ddr");
+	if (IS_ERR(host->icc_ddr))
+		return dev_err_probe(dev, PTR_ERR(host->icc_ddr),
+				    "failed to acquire interconnect path\n");
+
+	host->icc_cpu = devm_of_icc_get(dev, "cpu-ufs");
+	if (IS_ERR(host->icc_cpu))
+		return dev_err_probe(dev, PTR_ERR(host->icc_cpu),
+				    "failed to acquire interconnect path\n");
+
+	/*
+	 * Set Maximum bandwidth vote before initializing the UFS controller and
+	 * device. Ideally, a minimal interconnect vote would suffice for the
+	 * initialization, but a max vote would allow faster initialization.
+	 */
+	ret = ufs_qcom_icc_set_bw(host, ufs_qcom_bw_table[MODE_MAX][0][0].bw1,
+				  ufs_qcom_bw_table[MODE_MAX][0][0].bw2);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to set bandwidth request\n");
+
+	return 0;
+}
+
 /**
  * ufs_qcom_init - bind phy with controller
  * @hba: host controller instance
@@ -1085,6 +1209,10 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 		}
 	}
 
+	err = ufs_qcom_icc_init(host);
+	if (err)
+		goto out_variant_clear;
+
 	host->device_reset = devm_gpiod_get_optional(dev, "reset",
 						     GPIOD_OUT_HIGH);
 	if (IS_ERR(host->device_reset)) {
@@ -1282,6 +1410,7 @@ static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
 				    dev_req_params->pwr_rx,
 				    dev_req_params->hs_rate,
 				    false);
+		ufs_qcom_icc_update_bw(host);
 		ufshcd_uic_hibern8_exit(hba);
 	}
 
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 6289ad5a42d0..dc27395ecba1 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -206,6 +206,9 @@ struct ufs_qcom_host {
 	struct clk *tx_l1_sync_clk;
 	bool is_lane_clks_enabled;
 
+	struct icc_path *icc_ddr;
+	struct icc_path *icc_cpu;
+
 #ifdef CONFIG_SCSI_UFS_CRYPTO
 	struct qcom_ice *ice;
 #endif
-- 
2.25.1

