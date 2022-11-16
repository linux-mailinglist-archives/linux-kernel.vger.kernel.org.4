Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEC162B7AC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237636AbiKPKUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbiKPKUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:20:11 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFD522299
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:20:10 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id l14so29123661wrw.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cYqc7qOp0vDZbB74DPEwdJqhwcxbDqw4f19kHt+4faI=;
        b=DMwUZkXoDp8R2G4cWfzFiWt0n3e+8NoCdSm9+Sd4pT1DONWsbAslB4lAx2KhlEHBfv
         zt+LiJ8it68uEJCxaaIH1TbLtJ2oYKHxgwLkWD/IFLuZr/REGmIeQl3Sq9JJ5zgBTbQM
         QKAf/MhFXZZeQdEprKmulrcIFlZQyZQjoIq+agCSp0mMqcrPb2mpDjDPRZ7frVqNJSYk
         5FpWMG+yJVHQt8WWu4wZ+KlOo2wn6+WZZuPE+X6eM1cWhNlkjXxe/ofng5COoKiovRzM
         +Kb+GpQZB+ChZZl+dnnTsWCKhglc12sMX+TebK1vgsOpJTVXPLiNZrOEXbrtxNe0ey1q
         XPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYqc7qOp0vDZbB74DPEwdJqhwcxbDqw4f19kHt+4faI=;
        b=bjODq6kLxhjCGAV4lwf3dAOy2EdInH8wIrqOUFSuwqFGAPAW2gzP83nEXDaPoAXM6u
         CUUjbB3CsEF5qDZ34zkn43rp5djuXfDmmZvk1toPuDDv1XOgrVtnDziPdqY6DIFICjlg
         omxHkfxTESWMkG0bkBFwFOlM6ZrE0sWausSBIaNaJTH50UcXq4WnFfPvmsMOqkL9g+bK
         DajdJG1svB4e9N6l598qyhfhE/5/3RM9nOAxEppQ5X3BLih2mlfMVIg4TL+xh9uKt1Vr
         RR/4bv7V2XQ9noxNDsaJM60BygGwf8nRKIg5/L0ZTWaRLyVzhvtYncBYBBwJt559ePEW
         hbjA==
X-Gm-Message-State: ANoB5pkA7sH4/phSft+3ypG2pRhLZpVCVOA3eRRc/8/QBeTSwWMMIvKW
        PrRNARl/O7EROrhJYNBgmMVBvQ==
X-Google-Smtp-Source: AA0mqf6glDZPaKQw/oYtSgPnqtqfz6XPO+eJZw01I2gjqQiExvFuw8LhIOCTWMjlbhGUN1+Jn0jkwQ==
X-Received: by 2002:a5d:4091:0:b0:236:4a87:2c25 with SMTP id o17-20020a5d4091000000b002364a872c25mr12954545wrp.19.1668594008965;
        Wed, 16 Nov 2022 02:20:08 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c4f1200b003c6f3f6675bsm1709900wmq.26.2022.11.16.02.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:20:08 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 16 Nov 2022 11:20:06 +0100
Subject: [PATCH 3/4] remoteproc: qcom_q6v5_pas: add support for dtb co-firmware
 loading
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221114-narmstrong-sm8550-upstream-remoteproc-v1-3-104c34cb3b91@linaro.org>
References: <20221114-narmstrong-sm8550-upstream-remoteproc-v1-0-104c34cb3b91@linaro.org>
In-Reply-To: <20221114-narmstrong-sm8550-upstream-remoteproc-v1-0-104c34cb3b91@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     devicetree@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting from the SM8550 SoC, starting the aDSP, cDSP and MPSS will
require loading a separate "Devicetree" firmware.

In order to satisfy the load & authentication order required by the SM8550
SoC, the following is implemented:
- "Devicetree" firmware request & load in dedicated memory
- Q6V5 prepare
- Power Domain & Clocks enable
- "Devicetree" firmware authentication
- Main firmware load in dedicated memory
- Main firmware authentication
- Q6V5 startup
- "Devicetree" firmware metadata release
- Main metadata release

When booting older platforms, the "Devicetree" steps would be
bypassed and the load & authentication order would still be valid.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 134 +++++++++++++++++++++++++++++++++----
 1 file changed, 121 insertions(+), 13 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 6afd0941e552..e79a5fcbc986 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -35,7 +35,9 @@
 struct adsp_data {
 	int crash_reason_smem;
 	const char *firmware_name;
+	const char *dtb_firmware_name;
 	int pas_id;
+	int dtb_pas_id;
 	unsigned int minidump_id;
 	bool has_aggre2_clk;
 	bool auto_boot;
@@ -65,20 +67,29 @@ struct qcom_adsp {
 
 	int proxy_pd_count;
 
+	const char *dtb_firmware_name;
 	int pas_id;
+	int dtb_pas_id;
 	unsigned int minidump_id;
 	int crash_reason_smem;
 	bool has_aggre2_clk;
 	bool decrypt_shutdown;
 	const char *info_name;
 
+	const struct firmware *firmware;
+	const struct firmware *dtb_firmware;
+
 	struct completion start_done;
 	struct completion stop_done;
 
 	phys_addr_t mem_phys;
+	phys_addr_t dtb_mem_phys;
 	phys_addr_t mem_reloc;
+	phys_addr_t dtb_mem_reloc;
 	void *mem_region;
+	void *dtb_mem_region;
 	size_t mem_size;
+	size_t dtb_mem_size;
 
 	struct qcom_rproc_glink glink_subdev;
 	struct qcom_rproc_subdev smd_subdev;
@@ -86,6 +97,7 @@ struct qcom_adsp {
 	struct qcom_sysmon *sysmon;
 
 	struct qcom_scm_pas_metadata pas_metadata;
+	struct qcom_scm_pas_metadata dtb_pas_metadata;
 };
 
 static void adsp_minidump(struct rproc *rproc)
@@ -160,6 +172,8 @@ static int adsp_unprepare(struct rproc *rproc)
 	 * here.
 	 */
 	qcom_scm_pas_metadata_release(&adsp->pas_metadata);
+	if (adsp->dtb_pas_id)
+		qcom_scm_pas_metadata_release(&adsp->dtb_pas_metadata);
 
 	return 0;
 }
@@ -169,20 +183,40 @@ static int adsp_load(struct rproc *rproc, const struct firmware *fw)
 	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
 	int ret;
 
-	ret = qcom_mdt_pas_init(adsp->dev, fw, rproc->firmware, adsp->pas_id,
-				adsp->mem_phys, &adsp->pas_metadata);
-	if (ret)
-		return ret;
+	/* Store firmware handle to be used in adsp_start() */
+	adsp->firmware = fw;
 
-	ret = qcom_mdt_load_no_init(adsp->dev, fw, rproc->firmware, adsp->pas_id,
-				    adsp->mem_region, adsp->mem_phys, adsp->mem_size,
-				    &adsp->mem_reloc);
-	if (ret)
-		return ret;
+	if (adsp->dtb_pas_id) {
+		ret = request_firmware(&adsp->dtb_firmware, adsp->dtb_firmware_name, adsp->dev);
+		if (ret) {
+			dev_err(adsp->dev, "request_firmware failed for %s: %d\n",
+				adsp->dtb_firmware_name, ret);
+			return ret;
+		}
 
-	qcom_pil_info_store(adsp->info_name, adsp->mem_phys, adsp->mem_size);
+		ret = qcom_mdt_pas_init(adsp->dev, adsp->dtb_firmware, adsp->dtb_firmware_name,
+					adsp->dtb_pas_id, adsp->dtb_mem_phys,
+					&adsp->dtb_pas_metadata);
+		if (ret)
+			goto release_dtb_firmware;
+
+		ret = qcom_mdt_load_no_init(adsp->dev, adsp->dtb_firmware, adsp->dtb_firmware_name,
+					    adsp->dtb_pas_id, adsp->dtb_mem_region,
+					    adsp->dtb_mem_phys, adsp->dtb_mem_size,
+					    &adsp->dtb_mem_reloc);
+		if (ret)
+			goto release_dtb_metadata;
+	}
 
 	return 0;
+
+release_dtb_metadata:
+	qcom_scm_pas_metadata_release(&adsp->dtb_pas_metadata);
+
+release_dtb_firmware:
+	release_firmware(adsp->dtb_firmware);
+
+	return ret;
 }
 
 static int adsp_start(struct rproc *rproc)
@@ -218,24 +252,55 @@ static int adsp_start(struct rproc *rproc)
 			goto disable_cx_supply;
 	}
 
+	if (adsp->dtb_pas_id) {
+		ret = qcom_scm_pas_auth_and_reset(adsp->dtb_pas_id);
+		if (ret) {
+			dev_err(adsp->dev,
+				"failed to authenticate dtb image and release reset\n");
+			goto disable_px_supply;
+		}
+	}
+
+	ret = qcom_mdt_pas_init(adsp->dev, adsp->firmware, rproc->firmware, adsp->pas_id,
+				adsp->mem_phys, &adsp->pas_metadata);
+	if (ret)
+		goto disable_px_supply;
+
+	ret = qcom_mdt_load_no_init(adsp->dev, adsp->firmware, rproc->firmware, adsp->pas_id,
+				    adsp->mem_region, adsp->mem_phys, adsp->mem_size,
+				    &adsp->mem_reloc);
+	if (ret)
+		goto release_pas_metadata;
+
+	qcom_pil_info_store(adsp->info_name, adsp->mem_phys, adsp->mem_size);
+
 	ret = qcom_scm_pas_auth_and_reset(adsp->pas_id);
 	if (ret) {
 		dev_err(adsp->dev,
 			"failed to authenticate image and release reset\n");
-		goto disable_px_supply;
+		goto release_pas_metadata;
 	}
 
 	ret = qcom_q6v5_wait_for_start(&adsp->q6v5, msecs_to_jiffies(5000));
 	if (ret == -ETIMEDOUT) {
 		dev_err(adsp->dev, "start timed out\n");
 		qcom_scm_pas_shutdown(adsp->pas_id);
-		goto disable_px_supply;
+		goto release_pas_metadata;
 	}
 
 	qcom_scm_pas_metadata_release(&adsp->pas_metadata);
+	if (adsp->dtb_pas_id)
+		qcom_scm_pas_metadata_release(&adsp->dtb_pas_metadata);
+
+	/* Remove pointer to the loaded firmware, only valid in adsp_load() & adsp_start() */
+	adsp->firmware = NULL;
 
 	return 0;
 
+release_pas_metadata:
+	qcom_scm_pas_metadata_release(&adsp->pas_metadata);
+	if (adsp->dtb_pas_id)
+		qcom_scm_pas_metadata_release(&adsp->dtb_pas_metadata);
 disable_px_supply:
 	if (adsp->px_supply)
 		regulator_disable(adsp->px_supply);
@@ -251,6 +316,9 @@ static int adsp_start(struct rproc *rproc)
 disable_irqs:
 	qcom_q6v5_unprepare(&adsp->q6v5);
 
+	/* Remove pointer to the loaded firmware, only valid in adsp_load() & adsp_start() */
+	adsp->firmware = NULL;
+
 	return ret;
 }
 
@@ -284,6 +352,12 @@ static int adsp_stop(struct rproc *rproc)
 	if (ret)
 		dev_err(adsp->dev, "failed to shutdown: %d\n", ret);
 
+	if (adsp->dtb_pas_id) {
+		ret = qcom_scm_pas_shutdown(adsp->dtb_pas_id);
+		if (ret)
+			dev_err(adsp->dev, "failed to shutdown dtb: %d\n", ret);
+	}
+
 	handover = qcom_q6v5_unprepare(&adsp->q6v5);
 	if (handover)
 		qcom_pas_handover(&adsp->q6v5);
@@ -461,6 +535,28 @@ static int adsp_alloc_memory_region(struct qcom_adsp *adsp)
 		return -EBUSY;
 	}
 
+	if (!adsp->dtb_pas_id)
+		return 0;
+
+	node = of_parse_phandle(adsp->dev->of_node, "memory-region", 1);
+	if (!node) {
+		dev_err(adsp->dev, "no dtb memory-region specified\n");
+		return -EINVAL;
+	}
+
+	ret = of_address_to_resource(node, 0, &r);
+	if (ret)
+		return ret;
+
+	adsp->dtb_mem_phys = adsp->dtb_mem_reloc = r.start;
+	adsp->dtb_mem_size = resource_size(&r);
+	adsp->dtb_mem_region = devm_ioremap_wc(adsp->dev, adsp->dtb_mem_phys, adsp->dtb_mem_size);
+	if (!adsp->dtb_mem_region) {
+		dev_err(adsp->dev, "unable to map dtb memory region: %pa+%zx\n",
+			&r.start, adsp->dtb_mem_size);
+		return -EBUSY;
+	}
+
 	return 0;
 }
 
@@ -469,7 +565,7 @@ static int adsp_probe(struct platform_device *pdev)
 	const struct adsp_data *desc;
 	struct qcom_adsp *adsp;
 	struct rproc *rproc;
-	const char *fw_name;
+	const char *fw_name, *dtb_fw_name = NULL;
 	const struct rproc_ops *ops = &adsp_ops;
 	int ret;
 
@@ -486,6 +582,14 @@ static int adsp_probe(struct platform_device *pdev)
 	if (ret < 0 && ret != -EINVAL)
 		return ret;
 
+	if (desc->dtb_firmware_name) {
+		dtb_fw_name = desc->dtb_firmware_name;
+		ret = of_property_read_string(pdev->dev.of_node, "qcom,dtb-firmware-name",
+					      &dtb_fw_name);
+		if (ret < 0 && ret != -EINVAL)
+			return ret;
+	}
+
 	if (desc->minidump_id)
 		ops = &adsp_minidump_ops;
 
@@ -507,6 +611,10 @@ static int adsp_probe(struct platform_device *pdev)
 	adsp->has_aggre2_clk = desc->has_aggre2_clk;
 	adsp->info_name = desc->sysmon_name;
 	adsp->decrypt_shutdown = desc->decrypt_shutdown;
+	if (dtb_fw_name) {
+		adsp->dtb_firmware_name = dtb_fw_name;
+		adsp->dtb_pas_id = desc->dtb_pas_id;
+	}
 	platform_set_drvdata(pdev, adsp);
 
 	ret = device_init_wakeup(adsp->dev, true);

-- 
b4 0.10.1
