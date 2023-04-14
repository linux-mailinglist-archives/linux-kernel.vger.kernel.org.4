Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C45D6E225B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 13:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjDNLhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 07:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjDNLh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:37:26 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903B276B3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:37:23 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id x4so3071067lfr.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681472242; x=1684064242;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ISD1jIsYhapCYWWcz+5k3pAzTGPESmv5s/eS+sFm/Hg=;
        b=Yn+a8wJ8gv1qZmhb+z/wE+fuvt/rcYbb8kz7kfkqSXFgHRc0BgsLC0q8O4NMiEzR7o
         pKgUHRdqp+8IGGPNH8Ywgbf7DWpaI8ggAiibJFFIlaU5cRR3j2I5xbUHFtjDuKFTfzB5
         s20M5Ut1nHBArSCleX9AuBS07MaGJQLckXs9R7D9DCULQPN6sAA8bHp6l4OVgDRDZweH
         eF3XGQrwpxNgEttPBBrGAOfAz799scOk9U/AwVvXdDISPWBzr/sD2GGpfu+p04B7QpZO
         eMQz3qifremBL3yejGU5B8aznbnJfAJ6+73aEobu+dzwNvYZup+v1f92XXdyonajb/jH
         YCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681472242; x=1684064242;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISD1jIsYhapCYWWcz+5k3pAzTGPESmv5s/eS+sFm/Hg=;
        b=lC4XksvbhxJbZUIyTM70YBYvXW+c/sP6P64ukHXTK8iIJ774Eeq+DOGPFllKRCl0yv
         VesrMq+eUk8BWaFJtV58Q/ydi0aRR1LoWH8RUREiQZBaKITX8zYrf3hfK8/tyh9MXD0G
         MNy5cCE+37h6gvn0ZFZqzokqHRcbK9sqCwSdRF5VVoGdVsRFs6yUZ1o3BndoCDYNCpET
         9680fUei3Dq0/zmXdWAjtE5SL49td+wmhw/2Xup8tZwEA8WpZO6NR27XSNf0oJV80U/V
         9Sh7A72FQmRueBCBvHvMeXYxaeHuB2FPvREdyW9epI7qEUWrUPVb3POed3gCcl5TtQgR
         HBog==
X-Gm-Message-State: AAQBX9fts+3BjS1pVipT2eGmW5awYM5oPHwI8SFcQFgwfRKrQ0utJSqk
        Mjqh7vMeDoqe3PF565Qx/84xMH6ttU0ohiI4oiE=
X-Google-Smtp-Source: AKy350b/2Yd4GqLCpCTDVzD36MwXnIdkHJ777ub6Yn9XcKuAxZJRDQeHd4i9F9FU7ufFiAN4N74nUg==
X-Received: by 2002:a05:6512:75:b0:4db:3927:e2bc with SMTP id i21-20020a056512007500b004db3927e2bcmr2007693lfo.50.1681472241922;
        Fri, 14 Apr 2023 04:37:21 -0700 (PDT)
Received: from [192.168.1.101] (abyl123.neoplus.adsl.tpnet.pl. [83.9.31.123])
        by smtp.gmail.com with ESMTPSA id y5-20020ac24e65000000b004ec83bc3e43sm756946lfs.192.2023.04.14.04.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 04:37:21 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 14 Apr 2023 13:37:18 +0200
Subject: [PATCH v3 2/2] soc: qcom: Introduce RPM master stats driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-topic-master_stats-v3-2-2cb2ba4f2092@linaro.org>
References: <20230405-topic-master_stats-v3-0-2cb2ba4f2092@linaro.org>
In-Reply-To: <20230405-topic-master_stats-v3-0-2cb2ba4f2092@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681472238; l=7204;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=hb0oyhgLV35bIH5MUQG7WNpjMFfzdLIJfQqifL30BjY=;
 b=uUDbYx+s7nKX8/aLuRZUv8bje+vhs+kkDvgeYYX6mxdcN+8NbMTdggTUm4S/k97zgE+Axldis6gL
 v5e7WnwNCxuthqP7wyPeR2H40Gi5wss157ApgLKUCPoR6ijpz3GU
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
 drivers/soc/qcom/rpm_master_stats.c | 160 ++++++++++++++++++++++++++++++++++++
 3 files changed, 172 insertions(+)

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
index 000000000000..73080c92bf89
--- /dev/null
+++ b/drivers/soc/qcom/rpm_master_stats.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2012-2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Linaro Limited
+ *
+ * This driver supports what is known as "Master Stats v2", which seems to be
+ * the only version which has ever shipped, all the way from 2013 to 2023.
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
+};
+
+static int master_stats_show(struct seq_file *s, void *unused)
+{
+	struct master_stats_data *d = s->private;
+	struct rpm_master_stats stat;
+
+	memcpy_fromio(&stat, d->base, sizeof(stat));
+
+	seq_printf(s, "%s:\n", d->label);
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
+	struct device_node *msgram_np;
+	struct master_stats_data *d;
+	struct dentry *dent, *root;
+	struct resource res;
+	int count, i, ret;
+
+	count = of_property_count_strings(dev->of_node, "qcom,master-names");
+	if (count < 0)
+		return count;
+
+	d = devm_kzalloc(dev, count * sizeof(*d), GFP_KERNEL);
+	if (!d)
+		return -ENOMEM;
+
+	root = debugfs_create_dir("rpm_master_stats", NULL);
+	platform_set_drvdata(pdev, root);
+
+	for (i = 0; i < count; i++) {
+		msgram_np = of_parse_phandle(dev->of_node, "qcom,rpm-msg-ram", i);
+		if (!msgram_np) {
+			debugfs_remove_recursive(root);
+			return dev_err_probe(dev, -EINVAL,
+					     "Couldn't parse MSG RAM phandle idx %d", i);
+		}
+
+		/*
+		 * Purposefully skip devm_platform helpers as we're using a
+		 * shared resource.
+		 */
+		ret = of_address_to_resource(msgram_np, 0, &res);
+		if (ret < 0) {
+			debugfs_remove_recursive(root);
+			return ret;
+		}
+
+		d[i].base = devm_ioremap(dev, res.start, resource_size(&res));
+		if (IS_ERR(d[i].base)) {
+			debugfs_remove_recursive(root);
+			return dev_err_probe(dev, -EINVAL,
+					     "Could not map the MSG RAM slice idx %d!\n", i);
+		}
+
+		ret = of_property_read_string_index(dev->of_node, "qcom,master-names", i,
+						    &d[i].label);
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
+		dent = debugfs_create_file(d[i].label, 0444, root,
+					   &d[i], &master_stats_fops);
+		if (!dent) {
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
+MODULE_DESCRIPTION("RPM Master Statistics driver");
+MODULE_LICENSE("GPL");

-- 
2.40.0

