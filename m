Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475A3672312
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjARQZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjARQYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:24:23 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA97589A1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 08:22:47 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso1935851wmq.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 08:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGzHrMG3hr3Zooc6YVSDSOl6T9u3WLIHlDj6p+zw1Ms=;
        b=DFgjwP8Maa/fVHV9FbuWiKu4x2xgl0uzbDWsvLFSvNMmMhb2RGVJec6bEldAGMJfQq
         umfaaUbLB677DZwYQH4ln7K+C6cdw2RlYXCGVlRAqyLGtMPq8T7cEdhAO0BZiHIrlqyk
         h7hghN1USHxMUqpzY7N446Qd8cLwieI9MimHa8kXHnXbli1KTpFH4PUdpyXp9oWjlW+5
         rIYPL3Xf5Gzhf1n6IdqQOaYYuGkItgyfWURCIQEu9tO2lhBD/5mKvtqUIfvfqrqUDZdU
         XEVfC1sGhBA1zgKqOVYcmeJ295hVG8Rx3HqJYEP0+RYKW/dQKrh4eGNZ3BjkqktkCfro
         40YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TGzHrMG3hr3Zooc6YVSDSOl6T9u3WLIHlDj6p+zw1Ms=;
        b=765w6heFNWtWzPiJFlI6MIfFCUqo+5jF2FkQv6Mnp/1QfezpR9WBoRtbbWExQPw0wb
         rUjsQEEbnzgaSprGRcBe3ID/h5uxFMP+x6Fh2KDxz5sayTo5P49vwd6ubPMsuPucyBre
         /IuZ2llaSn/x6dKzvs2DVGDqdnU8MvVQNxZQHg6fpNShUpaQJmvqmygwHe/BX/p6Gljg
         B1oCv4DTdTymgHcOJTz50oZqAD+4YRaxh8H+Q0jm34HohZVwxs/+E8oPnDexLv9lJ1kw
         g8Nq4GBY5F7R2+gKsz8ADN502P1+leCn9b3vBrNQLTyRB+hdXfbV9RwAyJcE7U0DRDqy
         82bg==
X-Gm-Message-State: AFqh2koTYh1wdAq8q+L7HAkHISE+WDDhQoDwCSk46DezLdFiuwnFdVLk
        ZkWJyL74h3dUMjJoWU+9W23f6Q==
X-Google-Smtp-Source: AMrXdXuwudbAkNcO2ugsDvhbHLTFpG9VcZS9oag+CekWkhv9Wf/eyrCVuOLDGR71ziG0v6pBEN2bIg==
X-Received: by 2002:a05:600c:198a:b0:3d9:cb4c:af5a with SMTP id t10-20020a05600c198a00b003d9cb4caf5amr7555794wmq.33.1674058966810;
        Wed, 18 Jan 2023 08:22:46 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id l23-20020a05600c1d1700b003db0dbbea53sm2744393wms.30.2023.01.18.08.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:22:46 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 18 Jan 2023 17:22:42 +0100
Subject: [PATCH v4 4/5] remoteproc: qcom_q6v5_pas: add support for assigning
 memory to firmware
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221114-narmstrong-sm8550-upstream-remoteproc-v4-4-54154c08c0b7@linaro.org>
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
index 3837a21820d6..445020f8baf8 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -48,6 +48,8 @@ struct adsp_data {
 	const char *ssr_name;
 	const char *sysmon_name;
 	int ssctl_id;
+
+	int region_assign_idx;
 };
 
 struct qcom_adsp {
@@ -84,10 +86,15 @@ struct qcom_adsp {
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
@@ -557,6 +564,64 @@ static int adsp_alloc_memory_region(struct qcom_adsp *adsp)
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
@@ -607,6 +672,7 @@ static int adsp_probe(struct platform_device *pdev)
 	adsp->pas_id = desc->pas_id;
 	adsp->info_name = desc->sysmon_name;
 	adsp->decrypt_shutdown = desc->decrypt_shutdown;
+	adsp->region_assign_idx = desc->region_assign_idx;
 	if (dtb_fw_name) {
 		adsp->dtb_firmware_name = dtb_fw_name;
 		adsp->dtb_pas_id = desc->dtb_pas_id;
@@ -621,6 +687,10 @@ static int adsp_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_rproc;
 
+	ret = adsp_assign_memory_region(adsp);
+	if (ret)
+		goto free_rproc;
+
 	ret = adsp_init_clock(adsp);
 	if (ret)
 		goto free_rproc;
@@ -673,6 +743,7 @@ static int adsp_remove(struct platform_device *pdev)
 	rproc_del(adsp->rproc);
 
 	qcom_q6v5_deinit(&adsp->q6v5);
+	adsp_unassign_memory_region(adsp);
 	qcom_remove_glink_subdev(adsp->rproc, &adsp->glink_subdev);
 	qcom_remove_sysmon_subdev(adsp->sysmon);
 	qcom_remove_smd_subdev(adsp->rproc, &adsp->smd_subdev);

-- 
2.34.1
