Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C506E79AC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbjDSMXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbjDSMX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:23:29 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97F646BA
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 05:23:26 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4eed6ddcae1so443120e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 05:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681907004; x=1684499004;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hPGiz4DXUUF5zE7ZJa4E2i3DA9cmsr64t3sVkYUckak=;
        b=liweVwjeZd7xiUNUU9zSgIRvEd1QCTNjuqzxoeX9TEHvyHiNNBNiR0e3gHsie/cHn7
         tytPvmq/2aRPMSyQsMoRatN9WJPmT32IRi1IqPR3Yd30conXLsEBUq963Q3uH1zXyikq
         B66qwJtFeR0Des9gLUgVhbTinlsOHTGergRmJrezE8Y9Hy5B3pys1EvCZz615lB+hN43
         SoH+5I/JkJeWrshWdACjjDcGiTkGZUs+MZmtFiximpfCqUqUrG4y6S3AHOYD8Iq2Y+32
         c18AmPAH0rlAZV4A+IHE4m9EYql2nOCLbZei3WGWZatpPubZYCaexVDH4mfQ+/K1vK/a
         vgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681907004; x=1684499004;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPGiz4DXUUF5zE7ZJa4E2i3DA9cmsr64t3sVkYUckak=;
        b=CSTCkkb6h0rfabw/NOneGMTw4WdMUHL6jhZtEwIdK36cKCCeSS/hIIITEzucsPZdhG
         jM1Wb6dyiM5j1PxGI2kTPvjOrff1I1It5Lsuq973pb6xwwgh8c0RvoBx43SpVzuTqEbE
         5h/Knweqfy/+qRMAbDUK5JgfnwPEE9OeB3u5PwR159orwnzYwpfYwazyD7hLomvrOHsB
         rGFgYXcTFnuEWcIXqc8KFvMyqv0g/pY/gp/W7eVOitOeEdCc36g7APuum2eQLJ37Wr2k
         yt/Cw3KSbUgMf+ftRTncY2kPlQUUKnyHQUBCHYSzxyf254yZ7zUrPf7mKXP8kRYg8UtV
         dUBw==
X-Gm-Message-State: AAQBX9cQiqirhNYZ93LbdgUAVMN9ty+D2kM+F2dyRedSZCV60k1nQALA
        N2lx8J2OqryUwRG2b0uRjlAuzA==
X-Google-Smtp-Source: AKy350bdUfr8EjCujHXiRsqGF2LhxlRAxkbhMDVdNFdrT5yw1pr7XoVoVvGL938plWbYX6jFJ7nTDA==
X-Received: by 2002:a05:6512:3b9e:b0:4eb:2b62:134f with SMTP id g30-20020a0565123b9e00b004eb2b62134fmr839280lfv.16.1681907004648;
        Wed, 19 Apr 2023 05:23:24 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id a23-20020a2e8317000000b002a79d7ceb93sm2925550ljh.9.2023.04.19.05.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 05:23:24 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 19 Apr 2023 14:23:21 +0200
Subject: [PATCH v5 2/2] soc: qcom: Introduce RPM master stats driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-topic-master_stats-v5-2-2e1c98a8b63e@linaro.org>
References: <20230405-topic-master_stats-v5-0-2e1c98a8b63e@linaro.org>
In-Reply-To: <20230405-topic-master_stats-v5-0-2e1c98a8b63e@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681907001; l=7371;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=lu9hWbptuXcs6u63YrwqzkyEo5+uuMeZ/4yHbAj3l0A=;
 b=JAQ5Kizlv6bz0d4E19ajASoRzr3M3/5CffPL428gGFhxafH9fvfZyDhfXTDNeF1tBkySs1C4lb60
 fL2bN+UEBeGI49nJCd3wdWk6AovX5zdLPXIyK4loILH+XdLdSN51
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 drivers/soc/qcom/rpm_master_stats.c | 163 ++++++++++++++++++++++++++++++++++++
 3 files changed, 175 insertions(+)

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
index 000000000000..6dd98b9f7129
--- /dev/null
+++ b/drivers/soc/qcom/rpm_master_stats.c
@@ -0,0 +1,163 @@
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
+	u32 active_cores;
+	u32 num_shutdowns;
+	u64 shutdown_req;
+	u64 wakeup_idx;
+	u64 bringup_req;
+	u64 bringup_ack;
+	u32 wakeup_reason; /* 0 = "rude wakeup", 1 = scheduled wakeup */
+	u32 last_sleep_trans_dur;
+	u32 last_wake_trans_dur;
+
+	/* Per-subsystem (*not necessarily* SoC-wide) XO shutdown stats */
+	u32 xo_count;
+	u64 xo_last_enter;
+	u64 last_exit;
+	u64 xo_total_dur;
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
+			return dev_err_probe(dev, PTR_ERR(dent),
+					     "Failed to create debugfs file %s!\n", data[i].label);
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
+		.name = "qcom_rpm_master_stats",
+		.of_match_table = rpm_master_table,
+	},
+};
+module_platform_driver(master_stats_driver);
+
+MODULE_DESCRIPTION("Qualcomm RPM Master Statistics driver");
+MODULE_LICENSE("GPL");

-- 
2.40.0

