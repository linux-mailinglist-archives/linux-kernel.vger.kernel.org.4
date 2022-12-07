Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C9E6461A8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 20:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiLGTXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 14:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiLGTXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 14:23:38 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C084663FD
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 11:23:36 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id co23so2058144wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 11:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ki/VVnDlL+U9t3meGshSmXYJAvv54FtfX28ZlG2oSI0=;
        b=OtdNU1TprzJ6ahskEXgA9XlDXLyh31Y3PIpcerWesMj7QPUqGo7zQhlSO4LD6Qgz6I
         zOPrbxAX6pIjjJE7xCAvnfYZKziw92KQJ2Ly6m9LK6NEzm2cXhwaGOQDDe9yWk2sbVBQ
         mL6xQfpk5m2cVuBm6f0LDP01/cpPSmTd5Ur3EnaHJbXL5JKWl/btc+nQG/92nqkubYoW
         It3jI8exnTwK5ta8IqHyNI7jYhZUmw06potPjODJu3qdWcP5uvBFe0APgFmixrxMBZnp
         NptDzk6q+mc/r+03rd+xEyKoYZhl1KIMgh3FhFVco/Q55CNHmJY+NEl3IpycQGu5sFvF
         j83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ki/VVnDlL+U9t3meGshSmXYJAvv54FtfX28ZlG2oSI0=;
        b=UObvHTLai1yRjdjiDd9HX2BxO4FBr3LIgp99XxIlG8blQ7Vxox/F5QM/Ud8xobK4gQ
         cvCQMoMbKB0JagkYbUHfKgQS6rNSZB7+fmS5S7naNyw5dGZkBS6G6yZ3EdjaIpcRLfoH
         1ZEUKIMIl76B0a3gFH7uspDXeuwT60yoqimt6iYwzcLpDkwJGAcjXskSSaGlC7cLuhV7
         7zBnauaSdQiOPppVKAPD0VVaKlpoz8S9W1m/F5OFSJxZJshYVLsEG6o/Q+EEl2CUZyQr
         TNq5UTp8KZf5t+45o7VRDc2yJZO//jbnxjQa8Xj2sW8jPm7+HTYHsa8SWfZNpLuwGbXV
         bLFg==
X-Gm-Message-State: ANoB5plpslAJsFGGp7nXQtaG8v4lLN8iZf5q3SKywuZyB4ymo5mZK6Ub
        wTawJge0+yFdCrYbGhYeOq2z+A==
X-Google-Smtp-Source: AA0mqf5ikK9ZdMu7I787i/Zz3tWduKEA1DI04pBdd4i09qLOGQGpI1xOkWUhotYSTjmEaKdaauQ4nA==
X-Received: by 2002:adf:f08e:0:b0:242:5f1a:ddcc with SMTP id n14-20020adff08e000000b002425f1addccmr9451941wro.352.1670441015586;
        Wed, 07 Dec 2022 11:23:35 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id w1-20020a5d5441000000b002422b462975sm19400355wrv.34.2022.12.07.11.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 11:23:35 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 07 Dec 2022 20:23:26 +0100
Subject: [PATCH v3 4/5] remoteproc: qcom_q6v5_pas: add support for assigning memory
 to firmware
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221114-narmstrong-sm8550-upstream-remoteproc-v3-4-62162a1df718@linaro.org>
References: <20221114-narmstrong-sm8550-upstream-remoteproc-v3-0-62162a1df718@linaro.org>
In-Reply-To: <20221114-narmstrong-sm8550-upstream-remoteproc-v3-0-62162a1df718@linaro.org>
To:     Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-remoteproc@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
