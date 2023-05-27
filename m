Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA877133E2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 11:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjE0Jwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 05:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjE0Jwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 05:52:42 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2621B5;
        Sat, 27 May 2023 02:52:36 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-96fab30d1e1so349710266b.0;
        Sat, 27 May 2023 02:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685181154; x=1687773154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kpcjhIP9wfz8oAcR+AY3muz85PQ43dL7SamrC+hTTc=;
        b=RG7nQaTAWLflKCqHKvBI/TUVWOZUUL1SQHbxIeI4mupsK/WjDVd6Izo4ST3899I9JA
         msR5Cr7X3BTntuygXJajIfaojDl3LYpiqmtQRfLDlkgyB/Vf95NSZnv8SqOxS7TDxzJq
         GDirfmAzmlPHBWt7iN+PimTQJLrCfQh86Q1usiBPbZjAIyXRBJb+ZmXRN1NuKIzEZHQ9
         pyJKty9bA3QY7hs2inH9tqiVY4sLA6rSrUB9OEm4J65yrpIHeV9CMSXWIIfHLSYUVFQP
         MvhpHAHxVAI/G1EOevBhqIUQ9N8SY9YAaXt5wOMeAtmoaNp/+/hfqpzx8ZIVYouEcl7j
         0oTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685181154; x=1687773154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6kpcjhIP9wfz8oAcR+AY3muz85PQ43dL7SamrC+hTTc=;
        b=FXweVAkNAJ4Y38M0FhCLbhvDaWdXl9jM7doWD+R0IZm/M4D6o0pmtopKGTyVVU8E92
         WV48ISTgvhJzBGbId6eRe76hSQ46QM2ylADxh7kghlMIZ9GjNqzZF39FTRzlILoq1jUB
         aBYH2SfZhGA8ilKLJ9LpAqWvC/Cy6MMWJPDB/wL814csPh6tUFV0C6TkRAqjdiDmC856
         OcXVjM4myO1TQwBod6XtM4ALtMI4SF6udpXmBR5O1ehNOUdo59kcdXwZ11DF4dHZT/TA
         21mWXkf/sLh5VSVE9n0ST9Uoi/lopkt894HgNas2nX1fgSiGDuzX6BLTfbpNw7/WDmS+
         x46w==
X-Gm-Message-State: AC+VfDwx3hhh4/0IyLwIKtcbvFhyrNUmPSjQETliXDWN/iV84xM0a6H8
        ecHn/SQ+tIMg/HOM2n3gcdg=
X-Google-Smtp-Source: ACHHUZ4yQpoppZJrwCzfdbzIrt38IH+dOGJPOdk2ZPDwm16VS7QOmQRf3UCVoLYStn7MohDWz0fjqw==
X-Received: by 2002:a17:907:6ea8:b0:973:9443:c5fc with SMTP id sh40-20020a1709076ea800b009739443c5fcmr1501140ejc.14.1685181154352;
        Sat, 27 May 2023 02:52:34 -0700 (PDT)
Received: from fedora.. (dh207-98-6.xnet.hr. [88.207.98.6])
        by smtp.googlemail.com with ESMTPSA id kq10-20020a170906abca00b00960005e09a3sm3218262ejb.61.2023.05.27.02.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 02:52:33 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     ilia.lin@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ansuelsmth@gmail.com, Robert Marko <robimarko@gmail.com>
Subject: [PATCH 2/2] cpufreq: qcom-nvmem: add support for IPQ8074
Date:   Sat, 27 May 2023 11:52:29 +0200
Message-Id: <20230527095229.12019-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230527095229.12019-1-robimarko@gmail.com>
References: <20230527095229.12019-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ8074 comes in 2 families:
* IPQ8070A/IPQ8071A (Acorn) up to 1.4GHz
* IPQ8072A/IPQ8074A/IPQ8076A/IPQ8078A (Hawkeye) up to 2.2GHz

So, in order to be able to share one OPP table lets add support for IPQ8074
family based of SMEM SoC ID-s as speedbin fuse is always 0 on IPQ8074.

IPQ8074 compatible is blacklisted from DT platdev as the cpufreq device
will get created by NVMEM CPUFreq driver.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c |  1 +
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 40 ++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 14aa8281c7f4..e4d6d128647d 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -169,6 +169,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "ti,am625", },
 
 	{ .compatible = "qcom,ipq8064", },
+	{ .compatible = "qcom,ipq8074", },
 	{ .compatible = "qcom,apq8064", },
 	{ .compatible = "qcom,msm8974", },
 	{ .compatible = "qcom,msm8960", },
diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index a88b6fe5db50..607fc0273e9c 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -31,6 +31,9 @@
 
 #include <dt-bindings/arm/qcom,ids.h>
 
+#define IPQ8074_HAWKEYE_VERSION		BIT(0)
+#define IPQ8074_ACORN_VERSION		BIT(1)
+
 struct qcom_cpufreq_drv;
 
 struct qcom_cpufreq_match_data {
@@ -204,6 +207,38 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
 	return ret;
 }
 
+static int qcom_cpufreq_ipq8074_name_version(struct device *cpu_dev,
+					     struct nvmem_cell *speedbin_nvmem,
+					     char **pvs_name,
+					     struct qcom_cpufreq_drv *drv)
+{
+	u32 msm_id;
+	int ret;
+	*pvs_name = NULL;
+
+	ret = qcom_smem_get_soc_id(&msm_id);
+	if (ret)
+		return ret;
+
+	switch (msm_id) {
+	case QCOM_ID_IPQ8070A:
+	case QCOM_ID_IPQ8071A:
+		drv->versions = IPQ8074_ACORN_VERSION;
+		break;
+	case QCOM_ID_IPQ8072A:
+	case QCOM_ID_IPQ8074A:
+	case QCOM_ID_IPQ8076A:
+	case QCOM_ID_IPQ8078A:
+		drv->versions = IPQ8074_HAWKEYE_VERSION;
+		break;
+	default:
+		BUG();
+		break;
+	}
+
+	return 0;
+}
+
 static const struct qcom_cpufreq_match_data match_data_kryo = {
 	.get_version = qcom_cpufreq_kryo_name_version,
 };
@@ -218,6 +253,10 @@ static const struct qcom_cpufreq_match_data match_data_qcs404 = {
 	.genpd_names = qcs404_genpd_names,
 };
 
+static const struct qcom_cpufreq_match_data match_data_ipq8074 = {
+	.get_version = qcom_cpufreq_ipq8074_name_version,
+};
+
 static int qcom_cpufreq_probe(struct platform_device *pdev)
 {
 	struct qcom_cpufreq_drv *drv;
@@ -363,6 +402,7 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
 	{ .compatible = "qcom,msm8996", .data = &match_data_kryo },
 	{ .compatible = "qcom,qcs404", .data = &match_data_qcs404 },
 	{ .compatible = "qcom,ipq8064", .data = &match_data_krait },
+	{ .compatible = "qcom,ipq8074", .data = &match_data_ipq8074 },
 	{ .compatible = "qcom,apq8064", .data = &match_data_krait },
 	{ .compatible = "qcom,msm8974", .data = &match_data_krait },
 	{ .compatible = "qcom,msm8960", .data = &match_data_krait },
-- 
2.40.1

