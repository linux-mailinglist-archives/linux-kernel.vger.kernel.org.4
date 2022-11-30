Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D88663D365
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbiK3KaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235698AbiK3K37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:29:59 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1991040476
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:29:53 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso1250399wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ki/VVnDlL+U9t3meGshSmXYJAvv54FtfX28ZlG2oSI0=;
        b=XUiR3oyX5qybgh2JXg2kRmIFchG4vbo8qeDrD51TO05JOy5O+XTsPFNRZmFz0AjHzm
         hPtr+12NrSLd0NPH+QntRYFEa1eGKfCqEv2GzRhYohiX/crLHTTa6oW4cHkMhzqFx0U4
         IKwT/5TVbwpOec7XpmD5iw/T8SIBAO6khbyhzFex359DlFnC7mKhtLqdq443MA3+Pv7C
         Lvx8LGgV2taDrZa4++CuStSq5Xarbv+XZ5fEy7atG0JENztUhfUnVPWWCV2bMJ2kB8/0
         6rLMyXEulM1R5+ArXQjUgZV/lC1a0ur+2bO/I2MQJCc5bhJBwGRlmser2hT5d5kP6wsL
         MlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ki/VVnDlL+U9t3meGshSmXYJAvv54FtfX28ZlG2oSI0=;
        b=IrSZuiC50PbQVGArXwjhmCbfaQMCiTAaa8LTJpAG4oZeZz2kFjb21Ufkc9zuvGf383
         LbLyQr0ThNxjhD8LrZCp8b40mtl7U5ogxhn9MYOODByUHnnvZvb/ZJgBqArxafb3XqdM
         DX6o7CGREuDWqyhxPCyO0AknWBUcAu1KFK4mAxKfdqKHfUO5lm+RtJxQeRRSwnPrW4Ru
         cHX3A/w8gDdIKxoPqt0EsZdXJONK0dFjZaKSLqL/C5Fk4Pa+qkbwzy9zgEO/iEMUn9Uj
         OtyJquSmTpggKhtS4WmTNU9P7J6BPixlPVvW5CWyppjumDGGISzEExvXUzw8Z30L6im/
         CBOw==
X-Gm-Message-State: ANoB5pkUUlK12hfbxH/DwBr/kKDpAEEcfbaU4sErOfwJ6KFsAYmL3SWq
        lJK480NItE5dvh/BOSnBW6R3vnXEaKyNv9AZ
X-Google-Smtp-Source: AA0mqf5gINEpfkTKS61dQlYZJHl21Rsl/i774hzJ9eA3ypFDyhWS7V2a7l630jk3TRjTfVWfkHUUVg==
X-Received: by 2002:a1c:790d:0:b0:3cf:935a:aaab with SMTP id l13-20020a1c790d000000b003cf935aaaabmr37712282wme.159.1669804191619;
        Wed, 30 Nov 2022 02:29:51 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id j33-20020a05600c1c2100b003b4ff30e566sm4313570wms.3.2022.11.30.02.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 02:29:51 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 30 Nov 2022 11:29:48 +0100
Subject: [PATCH v2 4/5] remoteproc: qcom_q6v5_pas: add support for assigning memory
 to firmware
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221114-narmstrong-sm8550-upstream-remoteproc-v2-4-12bc22255474@linaro.org>
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

Starting with SM8550, the DSM memory must now be shared to the
firmware by the APPS process instead of beeing defined in the
carveout memory reserved for MPSS.

In order to handle that, add a region_assign_idx in adsp_data
to specify with index of memory-region must be assigned to
the MPSS via the qcom_scm_assign_mem() call at probe time.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 71 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 4fe09c7f25bd..d6a288432b6c 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -49,6 +49,8 @@ struct adsp_data {
 	const char *ssr_name;
 	const char *sysmon_name;
 	int ssctl_id;
+
+	int region_assign_idx;
 };
 
 struct qcom_adsp {
@@ -86,10 +88,15 @@ struct qcom_adsp {
 	phys_addr_t dtb_mem_phys;
 	phys_addr_t mem_reloc;
 	phys_addr_t dtb_mem_reloc;
+	phys_addr_t region_assign_phys;
 	void *mem_region;
 	void *dtb_mem_region;
 	size_t mem_size;
 	size_t dtb_mem_size;
+	size_t region_assign_size;
+
+	int region_assign_idx;
+	int region_assign_perms;
 
 	struct qcom_rproc_glink glink_subdev;
 	struct qcom_rproc_subdev smd_subdev;
@@ -560,6 +567,64 @@ static int adsp_alloc_memory_region(struct qcom_adsp *adsp)
 	return 0;
 }
 
+static int adsp_assign_memory_region(struct qcom_adsp *adsp)
+{
+	struct qcom_scm_vmperm perm;
+	struct device_node *node;
+	struct resource r;
+	int ret;
+
+	if (!adsp->region_assign_idx)
+		return 0;
+
+	node = of_parse_phandle(adsp->dev->of_node, "memory-region", adsp->region_assign_idx);
+	if (!node) {
+		dev_err(adsp->dev, "missing shareable memory-region\n");
+		return -EINVAL;
+	}
+
+	ret = of_address_to_resource(node, 0, &r);
+	if (ret)
+		return ret;
+
+	perm.vmid = QCOM_SCM_VMID_MSS_MSA;
+	perm.perm = QCOM_SCM_PERM_RW;
+
+	adsp->region_assign_phys = r.start;
+	adsp->region_assign_size = resource_size(&r);
+	adsp->region_assign_perms = BIT(QCOM_SCM_VMID_HLOS);
+
+	ret = qcom_scm_assign_mem(adsp->region_assign_phys,
+				  adsp->region_assign_size,
+				  &adsp->region_assign_perms,
+				  &perm, 1);
+	if (ret < 0) {
+		dev_err(adsp->dev, "assign memory failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void adsp_unassign_memory_region(struct qcom_adsp *adsp)
+{
+	struct qcom_scm_vmperm perm;
+	int ret;
+
+	if (!adsp->region_assign_idx)
+		return;
+
+	perm.vmid = QCOM_SCM_VMID_HLOS;
+	perm.perm = QCOM_SCM_PERM_RW;
+
+	ret = qcom_scm_assign_mem(adsp->region_assign_phys,
+				  adsp->region_assign_size,
+				  &adsp->region_assign_perms,
+				  &perm, 1);
+	if (ret < 0)
+		dev_err(adsp->dev, "unassign memory failed\n");
+}
+
 static int adsp_probe(struct platform_device *pdev)
 {
 	const struct adsp_data *desc;
@@ -611,6 +676,7 @@ static int adsp_probe(struct platform_device *pdev)
 	adsp->has_aggre2_clk = desc->has_aggre2_clk;
 	adsp->info_name = desc->sysmon_name;
 	adsp->decrypt_shutdown = desc->decrypt_shutdown;
+	adsp->region_assign_idx = desc->region_assign_idx;
 	if (dtb_fw_name) {
 		adsp->dtb_firmware_name = dtb_fw_name;
 		adsp->dtb_pas_id = desc->dtb_pas_id;
@@ -625,6 +691,10 @@ static int adsp_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_rproc;
 
+	ret = adsp_assign_memory_region(adsp);
+	if (ret)
+		goto free_rproc;
+
 	ret = adsp_init_clock(adsp);
 	if (ret)
 		goto free_rproc;
@@ -676,6 +746,7 @@ static int adsp_remove(struct platform_device *pdev)
 	rproc_del(adsp->rproc);
 
 	qcom_q6v5_deinit(&adsp->q6v5);
+	adsp_unassign_memory_region(adsp);
 	qcom_remove_glink_subdev(adsp->rproc, &adsp->glink_subdev);
 	qcom_remove_sysmon_subdev(adsp->sysmon);
 	qcom_remove_smd_subdev(adsp->rproc, &adsp->smd_subdev);

-- 
b4 0.10.1
