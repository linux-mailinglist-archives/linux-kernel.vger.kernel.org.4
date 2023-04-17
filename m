Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C51F6E4F5D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 19:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjDQRiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 13:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjDQRh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 13:37:59 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03F71BD1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 10:37:57 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id j11so14956339ljq.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 10:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681753076; x=1684345076;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uuOGCY0YC27DnDSyEpTKjfXfgDWLpz/eBDtA/u84pMU=;
        b=yzl5jrvhIWzjI5pWkNMEb78CStV/WJwKO5wgtOCKGW4MnV+w5xXofB4GKNlsxYPKhD
         byz8Bkog8atqwEJn09jcdrFzy1Y9RhsFn21YG5m8tuT4UNJLI6RQGR2edtSXQTyAbrif
         Ty+vWK/ClVhIBfwltFay+BztvmZ8jUC8Ww9/jsCUSIqsL+xt0CDAnGGDxmCzTw6Qxdjh
         gitlKKurBNMyrUmloPyk3oFzi3bi3q8Jh1u6mmMVaNsLpnjlN8Hy7muIEu2OKKQxOoLH
         ipboH1ckCosIk+pYs2m0x24hyntjbEYrys53mkPmZDO7oCKl3YS/Wf+PQ58REUbs0VFB
         4x1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681753076; x=1684345076;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uuOGCY0YC27DnDSyEpTKjfXfgDWLpz/eBDtA/u84pMU=;
        b=CGmtrB7lepixoWwlxCdPDUXsRyPSQuO4Lf2mhcigg8JP7hqJ2t9XbfZvzDyXUAyQRQ
         OYu+gOETXud9qAEEp5y5+lL/AktHEJBn4Joz2YDj1yOAMoZ77r/PLfZu0atVGLLa34nU
         z6BYSboJUmIt3uqyy8zs4zCoBvvxOboD6yVMQkOiwTNUjCG+aXoLq0Jhlno6kGIToOK1
         RCmVMCQjq4DLEq1QCDtVbXCkvxLMJ+eWvBmW8WQofUZ6mFBcceJ1csTq10eIIlWIvRBc
         tRYwyhnim6siqL+oCsbhpa0p2ddQjd0Wne/vkW8kf7XlD16cvmudSpDQYaeW1vNfbJ+a
         MX6Q==
X-Gm-Message-State: AAQBX9eCaIwOXRS19PrwPKdAeJbii/HYUw7FgffKFKvnkfnC8UtpOIAz
        oa4SJzF2tToX8CL81b7rrjiLDg==
X-Google-Smtp-Source: AKy350Z9L31Gs0ZHK2EiH6FyT/l7sc15FKi/hGVIc/dqdjW0VdWj4LEUE7f+e2St/BBqAf8xWTCPTQ==
X-Received: by 2002:a2e:9349:0:b0:2a8:b168:981f with SMTP id m9-20020a2e9349000000b002a8b168981fmr2508926ljh.46.1681753076185;
        Mon, 17 Apr 2023 10:37:56 -0700 (PDT)
Received: from [192.168.1.101] (abyk99.neoplus.adsl.tpnet.pl. [83.9.30.99])
        by smtp.gmail.com with ESMTPSA id h13-20020a2e900d000000b002987088bda4sm2191329ljg.69.2023.04.17.10.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 10:37:55 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 17 Apr 2023 19:37:53 +0200
Subject: [PATCH v4 2/2] soc: qcom: Introduce RPM master stats driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-topic-master_stats-v4-2-4217362fcc79@linaro.org>
References: <20230405-topic-master_stats-v4-0-4217362fcc79@linaro.org>
In-Reply-To: <20230405-topic-master_stats-v4-0-4217362fcc79@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681753072; l=7339;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=8gsn6U4CGo0S02zD/8MmPyM/NPVm8x4jX2vbho9jzHY=;
 b=ukvLi+DqJJTWvKsUbVpWpUxASYB/Vc19tPEfA7DmavN+Kvqi8D1LRWFzfD/beFnK0N76/gg5U0gy
 8Pb5hZRTBwH5cUuhN/sJTYx3buJwFR7crTOJVa2M5OKKioLYsCRm
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a driver to query and expose detailed, per-subsystem (as opposed
to the existing qcom_stats driver which exposes SoC-wide data) about low
power mode states of a given RPM master. That includes the APSS (ARM),
MPSS (modem) and other remote cores, depending on the platform
configuration.

This is a vastly cleaned up and restructured version of a similar
driver found in msm-5.4.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/Kconfig            |  11 +++
 drivers/soc/qcom/Makefile           |   1 +
 drivers/soc/qcom/rpm_master_stats.c | 162 ++++++++++++++++++++++++++++++++++++
 3 files changed, 174 insertions(+)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index a491718f8064..e597799e8121 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -135,6 +135,17 @@ config QCOM_RMTFS_MEM
 
 	  Say y here if you intend to boot the modem remoteproc.
 
+config QCOM_RPM_MASTER_STATS
+	tristate "Qualcomm RPM Master stats"
+	depends on ARCH_QCOM || COMPILE_TEST
+	help
+	  The RPM Master sleep stats driver provides detailed per-subsystem
+	  sleep/wake data, read from the RPM message RAM. It can be used to
+	  assess whether all the low-power modes available are entered as
+	  expected or to check which part of the SoC prevents it from sleeping.
+
+	  Say y here if you intend to debug or monitor platform sleep.
+
 config QCOM_RPMH
 	tristate "Qualcomm RPM-Hardened (RPMH) Communication"
 	depends on ARCH_QCOM || COMPILE_TEST
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 0f43a88b4894..7349371fdea1 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_QCOM_QMI_HELPERS)	+= qmi_helpers.o
 qmi_helpers-y	+= qmi_encdec.o qmi_interface.o
 obj-$(CONFIG_QCOM_RAMP_CTRL)	+= ramp_controller.o
 obj-$(CONFIG_QCOM_RMTFS_MEM)	+= rmtfs_mem.o
+obj-$(CONFIG_QCOM_RPM_MASTER_STATS)	+= rpm_master_stats.o
 obj-$(CONFIG_QCOM_RPMH)		+= qcom_rpmh.o
 qcom_rpmh-y			+= rpmh-rsc.o
 qcom_rpmh-y			+= rpmh.o
diff --git a/drivers/soc/qcom/rpm_master_stats.c b/drivers/soc/qcom/rpm_master_stats.c
new file mode 100644
index 000000000000..ac87401e2217
--- /dev/null
+++ b/drivers/soc/qcom/rpm_master_stats.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2012-2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Linaro Limited
+ *
+ * This driver supports what is known as "Master Stats v2" in Qualcomm
+ * downstream kernel terms, which seems to be the only version which has
+ * ever shipped, all the way from 2013 to 2023.
+ */
+
+#include <linux/debugfs.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+
+struct master_stats_data {
+	void __iomem *base;
+	const char *label;
+};
+
+struct rpm_master_stats {
+	uint32_t active_cores;
+	uint32_t num_shutdowns;
+	uint64_t shutdown_req;
+	uint64_t wakeup_idx;
+	uint64_t bringup_req;
+	uint64_t bringup_ack;
+	uint32_t wakeup_reason; /* 0 = "rude wakeup", 1 = scheduled wakeup */
+	uint32_t last_sleep_trans_dur;
+	uint32_t last_wake_trans_dur;
+
+	/* Per-subsystem (*not necessarily* SoC-wide) XO shutdown stats */
+	uint32_t xo_count;
+	uint64_t xo_last_enter;
+	uint64_t last_exit;
+	uint64_t xo_total_dur;
+} __packed;
+
+static int master_stats_show(struct seq_file *s, void *unused)
+{
+	struct master_stats_data *data = s->private;
+	struct rpm_master_stats stat;
+
+	memcpy_fromio(&stat, data->base, sizeof(stat));
+
+	seq_printf(s, "%s:\n", data->label);
+
+	seq_printf(s, "\tLast shutdown @ %llu\n", stat.shutdown_req);
+	seq_printf(s, "\tLast bringup req @ %llu\n", stat.bringup_req);
+	seq_printf(s, "\tLast bringup ack @ %llu\n", stat.bringup_ack);
+	seq_printf(s, "\tLast wakeup idx: %llu\n", stat.wakeup_idx);
+	seq_printf(s, "\tLast XO shutdown enter @ %llu\n", stat.xo_last_enter);
+	seq_printf(s, "\tLast XO shutdown exit @ %llu\n", stat.last_exit);
+	seq_printf(s, "\tXO total duration: %llu\n", stat.xo_total_dur);
+	seq_printf(s, "\tLast sleep transition duration: %u\n", stat.last_sleep_trans_dur);
+	seq_printf(s, "\tLast wake transition duration: %u\n", stat.last_wake_trans_dur);
+	seq_printf(s, "\tXO shutdown count: %u\n", stat.xo_count);
+	seq_printf(s, "\tWakeup reason: 0x%x\n", stat.wakeup_reason);
+	seq_printf(s, "\tShutdown count: %u\n", stat.num_shutdowns);
+	seq_printf(s, "\tActive cores bitmask: 0x%x\n", stat.active_cores);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(master_stats);
+
+static int master_stats_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct master_stats_data *data;
+	struct device_node *msgram_np;
+	struct dentry *dent, *root;
+	struct resource res;
+	int count, i, ret;
+
+	count = of_property_count_strings(dev->of_node, "qcom,master-names");
+	if (count < 0)
+		return count;
+
+	data = devm_kzalloc(dev, count * sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	root = debugfs_create_dir("qcom_rpm_master_stats", NULL);
+	platform_set_drvdata(pdev, root);
+
+	for (i = 0; i < count; i++) {
+		msgram_np = of_parse_phandle(dev->of_node, "qcom,rpm-msg-ram", i);
+		if (!msgram_np) {
+			debugfs_remove_recursive(root);
+			return dev_err_probe(dev, -ENODEV,
+					     "Couldn't parse MSG RAM phandle idx %d", i);
+		}
+
+		/*
+		 * Purposefully skip devm_platform helpers as we're using a
+		 * shared resource.
+		 */
+		ret = of_address_to_resource(msgram_np, 0, &res);
+		of_node_put(msgram_np);
+		if (ret < 0) {
+			debugfs_remove_recursive(root);
+			return ret;
+		}
+
+		data[i].base = devm_ioremap(dev, res.start, resource_size(&res));
+		if (IS_ERR(data[i].base)) {
+			debugfs_remove_recursive(root);
+			return dev_err_probe(dev, -EINVAL,
+					     "Could not map the MSG RAM slice idx %d!\n", i);
+		}
+
+		ret = of_property_read_string_index(dev->of_node, "qcom,master-names", i,
+						    &data[i].label);
+		if (ret < 0) {
+			debugfs_remove_recursive(root);
+			return dev_err_probe(dev, ret,
+					     "Could not read name idx %d!\n", i);
+		}
+
+		/*
+		 * Generally it's not advised to fail on debugfs errors, but this
+		 * driver's only job is exposing data therein.
+		 */
+		dent = debugfs_create_file(data[i].label, 0444, root,
+					   &data[i], &master_stats_fops);
+		if (IS_ERR(dent)) {
+			debugfs_remove_recursive(root);
+			return -EINVAL;
+		}
+	}
+
+	device_set_pm_not_required(dev);
+
+	return 0;
+}
+
+static void master_stats_remove(struct platform_device *pdev)
+{
+	struct dentry *root = platform_get_drvdata(pdev);
+
+	debugfs_remove_recursive(root);
+}
+
+static const struct of_device_id rpm_master_table[] = {
+	{ .compatible = "qcom,rpm-master-stats" },
+	{ },
+};
+
+static struct platform_driver master_stats_driver = {
+	.probe = master_stats_probe,
+	.remove_new = master_stats_remove,
+	.driver = {
+		.name = "rpm_master_stats",
+		.of_match_table = rpm_master_table,
+	},
+};
+module_platform_driver(master_stats_driver);
+
+MODULE_DESCRIPTION("Qualcomm RPM Master Statistics driver");
+MODULE_LICENSE("GPL");

-- 
2.40.0

