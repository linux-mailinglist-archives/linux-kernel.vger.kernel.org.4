Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CC16D8044
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238557AbjDEPBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238509AbjDEPBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:01:48 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD3E4EE9
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 08:01:44 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id k37so47090706lfv.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 08:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680706903;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Enslf/wirWR/vFKVajt29WdovTFd9sBu4HdJK5iLVV8=;
        b=ZLKpkDYJBL1i3E5zK9vhu3Ry2Tog6qgOhFAv/eFFG+3ZWjzoUGVQgG4U2KdsbjzdJR
         Ul7w35P2cLihFz8D3hE50IJadFTSfhbDB3rDdcZlri8wtuCk8vJlxWnLGE06jZkGDHZW
         GgjARyDs0E8MaLfx0QL2dR/oqOUlIi3mmNh3RbgK9XoYmluTVdNTNCPSmSTqBodrrxyi
         tayLC75wtGMDIdAh8HnIw8QE9yVHCyEZjWe+oGRU1X+Qjph/qjzFYI35dwRjmDPXor+3
         YLiFhhTYNlgG8gJVczs+agBQLVYtw0XuR2KZP+HAwGYjyposZxsgbwbMlPG/x9WymW72
         sCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680706903;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Enslf/wirWR/vFKVajt29WdovTFd9sBu4HdJK5iLVV8=;
        b=dq0Gn1rgwOZG0hzprxoIprWl3+1rTXeTWI8X0QetnZSlRVS14EZZ3anpJXyNhNo+pr
         KNg2YLF3jxEw5BbhfY0B4WcoIRXmbOKCfWbTzRMFZZ+Iu2EwVJ5VCcklP7A32FXglVPi
         MqkvutkMXoKecxO0ac7cC0xyPjGJTnmf69qQTP0sBRCfrfUly4qgX9UByAH/W70ZFGmi
         iLGyOUFYjkXv4wftwLDoB7u2G527309ljNZxz8NzQHG+12bPtQF/oJWheS9sffyJo0XW
         TILYDHNp/7oH11PryCwfMaNrvzbUiEN/StZ/ImD0Lr5ZYjpa0j3KR18SuY+CAXoMSINA
         KJjQ==
X-Gm-Message-State: AAQBX9eGCCR8UP+u6USo59/agm2kHCe8XOz2nqCAFeJyy2poCZ6Pq9xU
        WDm5YJ9VK76DyiUgrF2xWHxHow==
X-Google-Smtp-Source: AKy350bFEWbqcOh52PgLamfiC+UN3gs5kBXP7o0H2B6ga0jJyt/MyQJ1j4DsNa+0qwYDsfYDIJypJg==
X-Received: by 2002:ac2:5111:0:b0:4de:f972:6aa with SMTP id q17-20020ac25111000000b004def97206aamr1694910lfb.4.1680706903094;
        Wed, 05 Apr 2023 08:01:43 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id 16-20020ac25690000000b004e84896253asm2833994lfr.251.2023.04.05.08.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 08:01:42 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 05 Apr 2023 17:01:36 +0200
Subject: [PATCH 2/2] soc: qcom: Introduce RPM master stats driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-topic-master_stats-v1-2-1b1fa2739953@linaro.org>
References: <20230405-topic-master_stats-v1-0-1b1fa2739953@linaro.org>
In-Reply-To: <20230405-topic-master_stats-v1-0-1b1fa2739953@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680706899; l=7204;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=UojBg6OM/XiZOOjQEvx052TRoaZQuzw+LM43xt276lg=;
 b=O7MAzoUHuFf4/U/KwYy3sM0ib5EvM8BsD4dzoO09CF0JNsrcOlt1mmu19Ugaayf4MVmuTkscpeRn
 zhsgQfVCBR6Z3C4M6sgfmCL9OC55Yq7+Sxi5xdmFA1llCFaiBdF/
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
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
 drivers/soc/qcom/rpm_master_stats.c | 160 ++++++++++++++++++++++++++++++++++++
 3 files changed, 172 insertions(+)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index a25df9e3c70e..325b733c102c 100644
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
index 6e88da899f60..196bb87f2576 100644
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
index 000000000000..759bfa1e01c4
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
+					     "Couldn't parse MSG RAM phandle idx %s", i);
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

