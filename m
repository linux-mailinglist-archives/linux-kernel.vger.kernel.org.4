Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BAB672310
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjARQZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjARQYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:24:23 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC2F589AF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 08:22:47 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so1939755wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 08:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7UDmILlFdDJxDbC08Q7YjwI+b8eG2TMyfC4v8otxDr8=;
        b=qgGnz1Q6WPS+FyX3DMlX2rivJC1q62zonfADcdgI3i2pmzC+NGXO8O5yIOtl6gEu1i
         wRUpB2IL91CYtMcqYylYAWTE+dcXaK0jKVuRlR+Fj8H4xMciO9O7TFhDxQPUqJV9AabC
         PLQfSzoPtMhg/jvTz7ErB3oU5gj9C7TpeWHXjVl2xI6+LfxIq0stm2o4skCsROPG3cWT
         Zts00Eq5KlNQ9ZcTy4xTOLvyW1L2pwsp8b3Dd4whiYApPMNwtz/6vEiUex80apTsi7qX
         ZChCjTAvc6p6vzRaT2dCmqy2zvygZdvG6x1I8+o8m1GtNT+LU0ZvJLhCyD8yoTxxQ31S
         T0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7UDmILlFdDJxDbC08Q7YjwI+b8eG2TMyfC4v8otxDr8=;
        b=OUUXj5PurllLCRTTibEOWC2CcsN8yDfqquOfzoILb2Flya3IbgCe9aD82zBFhiIFq8
         iv/HVKCRqh5Jv45jnAvziU2B4q75Kzne9T9suvD8amKuLOmz8kSS56aZ5QaoUQsM1c0r
         ovoLP7QEsJGvnEId9kxHgPa4SSzoBhJjujPKPx6bMK5uN0oBCYUc497VDPMuJIjcNRbD
         kmKN7HW5tDx95DhrCXLDAMpX78v5hZ4EdH6nt655b2X+7yMFC8xTo7kKLxvpXZGDpj1H
         sZrgf1AoN+X/sKUVLOiQXD3PN+zuJXwQ2a+l11CKCGert9tMioArOCQVF9ZjZ5f8Md8s
         Vg/A==
X-Gm-Message-State: AFqh2krdXboOhdugXxCjh8r5daDQ8hwb4ufSTuqY/O3YZqE+xAr3h2PP
        49RTAOS4xn8j8J9aVwTZT59PXA==
X-Google-Smtp-Source: AMrXdXugImuMnBI+9iqbSaOt189Qdqlnjn0ziIBzTAMF8UCEohqjM5fbiLtParbqaRjuJUZYL4dn9w==
X-Received: by 2002:a05:600c:1712:b0:3d9:a145:91a with SMTP id c18-20020a05600c171200b003d9a145091amr7111434wmn.28.1674058965758;
        Wed, 18 Jan 2023 08:22:45 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id l23-20020a05600c1d1700b003db0dbbea53sm2744393wms.30.2023.01.18.08.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:22:45 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 18 Jan 2023 17:22:41 +0100
Subject: [PATCH v4 3/5] remoteproc: qcom_q6v5_pas: add support for dtb
 co-firmware loading
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221114-narmstrong-sm8550-upstream-remoteproc-v4-3-54154c08c0b7@linaro.org>
References: <20221114-narmstrong-sm8550-upstream-remoteproc-v4-0-54154c08c0b7@linaro.org>
In-Reply-To: <20221114-narmstrong-sm8550-upstream-remoteproc-v4-0-54154c08c0b7@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc:     Alex Elder <elder@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.11.1
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
index f95e0229a6c1..3837a21820d6 100644
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
 	bool auto_boot;
 	bool decrypt_shutdown;
@@ -64,19 +66,28 @@ struct qcom_adsp {
 
 	int proxy_pd_count;
 
+	const char *dtb_firmware_name;	
 	int pas_id;
+	int dtb_pas_id;
 	unsigned int minidump_id;
 	int crash_reason_smem;
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
@@ -84,6 +95,7 @@ struct qcom_adsp {
 	struct qcom_sysmon *sysmon;
 
 	struct qcom_scm_pas_metadata pas_metadata;
+	struct qcom_scm_pas_metadata dtb_pas_metadata;
 };
 
 static void adsp_minidump(struct rproc *rproc)
@@ -158,6 +170,8 @@ static int adsp_unprepare(struct rproc *rproc)
 	 * here.
 	 */
 	qcom_scm_pas_metadata_release(&adsp->pas_metadata);
+	if (adsp->dtb_pas_id)
+		qcom_scm_pas_metadata_release(&adsp->dtb_pas_metadata);
 
 	return 0;
 }
@@ -167,20 +181,40 @@ static int adsp_load(struct rproc *rproc, const struct firmware *fw)
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
@@ -216,24 +250,55 @@ static int adsp_start(struct rproc *rproc)
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
@@ -249,6 +314,9 @@ static int adsp_start(struct rproc *rproc)
 disable_irqs:
 	qcom_q6v5_unprepare(&adsp->q6v5);
 
+	/* Remove pointer to the loaded firmware, only valid in adsp_load() & adsp_start() */
+	adsp->firmware = NULL;
+
 	return ret;
 }
 
@@ -282,6 +350,12 @@ static int adsp_stop(struct rproc *rproc)
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
@@ -458,6 +532,28 @@ static int adsp_alloc_memory_region(struct qcom_adsp *adsp)
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
 
@@ -466,7 +562,7 @@ static int adsp_probe(struct platform_device *pdev)
 	const struct adsp_data *desc;
 	struct qcom_adsp *adsp;
 	struct rproc *rproc;
-	const char *fw_name;
+	const char *fw_name, *dtb_fw_name = NULL;
 	const struct rproc_ops *ops = &adsp_ops;
 	int ret;
 
@@ -483,6 +579,14 @@ static int adsp_probe(struct platform_device *pdev)
 	if (ret < 0 && ret != -EINVAL)
 		return ret;
 
+	if (desc->dtb_firmware_name) {
+		dtb_fw_name = desc->dtb_firmware_name;
+		ret = of_property_read_string_index(pdev->dev.of_node, "firmware-name", 1,
+					      &dtb_fw_name);
+		if (ret < 0 && ret != -EINVAL)
+			return ret;
+	}
+
 	if (desc->minidump_id)
 		ops = &adsp_minidump_ops;
 
@@ -503,6 +607,10 @@ static int adsp_probe(struct platform_device *pdev)
 	adsp->pas_id = desc->pas_id;
 	adsp->info_name = desc->sysmon_name;
 	adsp->decrypt_shutdown = desc->decrypt_shutdown;
+	if (dtb_fw_name) {
+		adsp->dtb_firmware_name = dtb_fw_name;
+		adsp->dtb_pas_id = desc->dtb_pas_id;
+	}
 	platform_set_drvdata(pdev, adsp);
 
 	ret = device_init_wakeup(adsp->dev, true);

-- 
2.34.1
