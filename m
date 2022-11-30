Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E67463D363
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbiK3KaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235584AbiK3K3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:29:54 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD1542193
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:29:52 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id bx10so14269996wrb.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F81FRtQTN8/7lBiZFQTJl8otEU1xztcn6GaL7O0kwpk=;
        b=G28/KdJOjCg9+UIxofyjQV/U1xXgNCB4PJE7EMnOT0Crr+89VmtVf9IabZWFXVtC/S
         wPZcQIOFfeq8BQOdMdK5bsQmqGuwjhwW4SLsuYlJ/xvI+Lm4Npm5TFWxcEnJLnwfA+fb
         c7cLJ12el+y+ir9ivUbe9uy6ejDvbIOyq9/yyfdzLawA/FC+AUJWAVES6NcQuhXWPFG/
         CFtqkRMi1f3q8eVrBzCqoLngcD/Y4ao2cWVpWBb2LIKLWbxhdrdBGBK2VOixDCSgjPPn
         Az0bp9YhOPnoFGQPBK1t2cO47Kb7fLaNqxb6nioB75ltmLYiQhzk+aBVURQ91O+/zo0F
         7w3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F81FRtQTN8/7lBiZFQTJl8otEU1xztcn6GaL7O0kwpk=;
        b=tjI0vWDRIvfYm2NMwQItl2dH0+N1UKLT/QYvJyyBtVDXLqwhAt+3F43AHEMUDMdoEA
         QGYTWEzdchkqv02zasM4nRACdjf5VURJjJJLa8gWG3lXLUp88SAbQ2oScUQOTsC1xWZS
         R0K3C5f2nJ8n8u+R5jUrLkLnnPpQwlfIWW6N/56ssD5QXCqr6e79bvm80mZ2Elz8mLff
         9eQXofqI3sPIMfB5b6MZmLb3H41ka6I4F8cnIw88ZaVh9FEgT+SIzFgwP8WaHa59MB5E
         SAxvWvIJ2PKhKouJi/Yk1MtJ7bGJTB7QvO4g1nKicQaPmiKBrFPPyl3CAjxH9A0C3ueQ
         lVlA==
X-Gm-Message-State: ANoB5pmHVPyjcigJfvlPRt7CGURUMklt8h6Dz/b4W22it/utfpC6LnoW
        5JemfaoW+nepxiNZcfxR2V5lUjpzkq9v/+xt
X-Google-Smtp-Source: AA0mqf6teHsMlC9YXM5prFxbQla9Sftnvo9EmqE7qsvGWcACpTbGZqkBLQXAZKUt++vVYUB3i4qk4g==
X-Received: by 2002:adf:f84f:0:b0:236:7805:48d3 with SMTP id d15-20020adff84f000000b00236780548d3mr36727248wrq.644.1669804190602;
        Wed, 30 Nov 2022 02:29:50 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id j33-20020a05600c1c2100b003b4ff30e566sm4313570wms.3.2022.11.30.02.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 02:29:50 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 30 Nov 2022 11:29:47 +0100
Subject: [PATCH v2 3/5] remoteproc: qcom_q6v5_pas: add support for dtb co-firmware
 loading
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221114-narmstrong-sm8550-upstream-remoteproc-v2-3-12bc22255474@linaro.org>
References: <20221114-narmstrong-sm8550-upstream-remoteproc-v2-0-12bc22255474@linaro.org>
In-Reply-To: <20221114-narmstrong-sm8550-upstream-remoteproc-v2-0-12bc22255474@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        linux-remoteproc@vger.kernel.org
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
index 6afd0941e552..4fe09c7f25bd 100644
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
+		ret = of_property_read_string_index(pdev->dev.of_node, "firmware-name", 1,
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
