Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0C6619830
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbiKDNfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbiKDNfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:35:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCDA2A402;
        Fri,  4 Nov 2022 06:35:06 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9CF506602986;
        Fri,  4 Nov 2022 13:35:04 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667568905;
        bh=rRp0gN0m9NNipSBCh5lNoz/2FWDCh98i5YbRdNTHBcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jDdInnBbZr+7YUHgIz8UgOHF7RLgtnX3m2PQIKKOt4HT8n8I5cMDEtlOadRq0qJT+
         IAsqcbzbc8Gor2ItSo6uJoN5hN619VnJKBetLAa2HnvD6yIcw+Zz9dKkq7VpUtzzm/
         7CpudtxTjH/hCAhd8IDHJvrvzG4VUBmB5WAYBJHuEzrot+gaoQoAADO3/4vtP1YhLc
         NbWMHgwGQMK2HLtgBnKs80A763HWCRFPHQm/PlMqLMpIeRIICrirjNFVTslUKjdEPk
         usZK0lh5hzZL66U2zuqWAMsB8Q/s0ViiTtRNEDUCmjNoy9kRdTYRVku2NZ6p7sMOYt
         tghHrVBf0DN+g==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, marijn.suijten@somainline.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [PATCH 2/2] soc: qcom: spm: Implement support for SAWv2.3, MSM8976 L2 PM
Date:   Fri,  4 Nov 2022 14:34:52 +0100
Message-Id: <20221104133452.131227-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221104133452.131227-1-angelogioacchino.delregno@collabora.com>
References: <20221104133452.131227-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

Implement the support for SAW v2.3, used in at least MSM8976, MSM8956
and APQ variants and while at it also add the configuration for the
MSM8976's little (a53) and big (a72) clusters cache power management.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
[Marijn: reorder struct definitions to follow high-to-low order]
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/qcom/spm.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
index 484b42b7454e..bfcd321d7837 100644
--- a/drivers/soc/qcom/spm.c
+++ b/drivers/soc/qcom/spm.c
@@ -98,6 +98,35 @@ static const struct spm_reg_data spm_reg_8916_cpu = {
 	.start_index[PM_SLEEP_MODE_SPC] = 5,
 };
 
+static const u16 spm_reg_offset_v2_3[SPM_REG_NR] = {
+	[SPM_REG_CFG]		= 0x08,
+	[SPM_REG_SPM_CTL]	= 0x30,
+	[SPM_REG_DLY]		= 0x34,
+	[SPM_REG_PMIC_DATA_0]	= 0x40,
+	[SPM_REG_PMIC_DATA_1]	= 0x44,
+};
+
+/* SPM register data for 8976 */
+static const struct spm_reg_data spm_reg_8976_gold_l2 = {
+	.reg_offset = spm_reg_offset_v2_3,
+	.spm_cfg = 0x14,
+	.spm_dly = 0x3c11840a,
+	.pmic_data[0] = 0x03030080,
+	.pmic_data[1] = 0x00030000,
+	.start_index[PM_SLEEP_MODE_STBY] = 0,
+	.start_index[PM_SLEEP_MODE_SPC] = 3,
+};
+
+static const struct spm_reg_data spm_reg_8976_silver_l2 = {
+	.reg_offset = spm_reg_offset_v2_3,
+	.spm_cfg = 0x14,
+	.spm_dly = 0x3c102800,
+	.pmic_data[0] = 0x03030080,
+	.pmic_data[1] = 0x00030000,
+	.start_index[PM_SLEEP_MODE_STBY] = 0,
+	.start_index[PM_SLEEP_MODE_SPC] = 2,
+};
+
 static const u16 spm_reg_offset_v2_1[SPM_REG_NR] = {
 	[SPM_REG_CFG]		= 0x08,
 	[SPM_REG_SPM_CTL]	= 0x30,
@@ -213,6 +242,10 @@ static const struct of_device_id spm_match_table[] = {
 	  .data = &spm_reg_8916_cpu },
 	{ .compatible = "qcom,msm8974-saw2-v2.1-cpu",
 	  .data = &spm_reg_8974_8084_cpu },
+	{ .compatible = "qcom,msm8976-gold-saw2-v2.3-l2",
+	  .data = &spm_reg_8976_gold_l2 },
+	{ .compatible = "qcom,msm8976-silver-saw2-v2.3-l2",
+	  .data = &spm_reg_8976_silver_l2 },
 	{ .compatible = "qcom,msm8998-gold-saw2-v4.1-l2",
 	  .data = &spm_reg_8998_gold_l2 },
 	{ .compatible = "qcom,msm8998-silver-saw2-v4.1-l2",
-- 
2.37.2

