Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288E7725FEE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241105AbjFGMrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241061AbjFGMrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:47:25 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040B01BFF
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 05:47:09 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f640e48bc3so1063877e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 05:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686142028; x=1688734028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/gi1wYyuTGyxRPCnXy/W6dl0ztApfjNz5N46Tr334c=;
        b=iAk48snIpP5FAUcrOXKzaso2EfYDoBqaGWM3B8Qdt+hejNMFNiyGWiUY7ipuqdhcIG
         YkRLuIzAv35XMuOwamJpKqrl8yKzF7KvysKf8JPh3nYZ2AUeWurkxIAYvk40xMRLw1Py
         r/N02dBKTh2IPq5oDDSKk+8nakTeTFMVBBS5LnpjxlojC/1YvyBV73zW1ur7QkC162oo
         PlyMV34cjVQ11mvjWMdfYjItPVRo9di3kX2R/ee3FSob0LVlZpyBLuMqInEotACmxtiC
         IzY5yfSEQ3WodR5SirsXRXi4fWLkxZPObgIMk9GOCHyKy3xWZ5HdN5pwG2IBh7udVHQP
         abTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686142028; x=1688734028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/gi1wYyuTGyxRPCnXy/W6dl0ztApfjNz5N46Tr334c=;
        b=FidHfiUbDrxMqPpCSjOh2LRuK9hIgljF9sWKzGhbdXuim+PY5Va+AiA6KBajF1vEAP
         qL9/0KDchIQpxuulya0tylOpSGt0gJDJhlqjWgGQngCgCCFQzLz2tWYbJ4hUE2ZShuiK
         cX1Z68Fe1A4feLdJwys0FSim03WxWZe313PXLkdubIsBiFpooxLCOwlcvDo1kiv6azng
         Zw3H5d7moou23KFPJ6p9kKZmcl85rKcglP8uvw8+BAGvdibBdDhIVpjuqi8SqUsyzarT
         bc+awjX36BiXIbi7/8qdW4kCWzR4TGN1frx9Q02quOG6+HjLVzdL4J1moN5L0kNAv2Co
         tBlw==
X-Gm-Message-State: AC+VfDwsMWb62rS9uVXUNjvi1Iav9xzUmYFaZm0coW/Wu5b3ESZkBpwf
        qD6e1tEs4T2E675zg7KhT0bntA==
X-Google-Smtp-Source: ACHHUZ6bmAujPPGUaE0p6wW6yTU2QtF+4D5UiiKNAqQSVwwLLD5tdqR7H3fNEKvFf2vmeP/ZqqmnYQ==
X-Received: by 2002:ac2:59db:0:b0:4f3:aa29:b672 with SMTP id x27-20020ac259db000000b004f3aa29b672mr2008947lfn.30.1686142028046;
        Wed, 07 Jun 2023 05:47:08 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id z7-20020a19f707000000b004f4b3e9e0cesm1781708lfe.297.2023.06.07.05.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 05:47:07 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/16] firmware: arm_scmi: Add the SCMI performance domain
Date:   Wed,  7 Jun 2023 14:46:22 +0200
Message-Id: <20230607124628.157465-11-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607124628.157465-1-ulf.hansson@linaro.org>
References: <20230607124628.157465-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable support for performance scaling (DVFS) for generic devices with
the SCMI performance protocol, let's add an SCMI performance domain. This
is being modelled as a genpd provider, with support for performance scaling
through genpd's ->set_performance_state() callback.

Note that, this adds the initial support that allows consumer drivers for
attached devices, to vote for a new performance state via calling the
dev_pm_genpd_set_performance_state(). However, this should be avoided as
it's in most cases preferred to use the OPP library to vote for a new OPP
instead. The support using the OPP library is implemented from subsequent
changes.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/firmware/arm_scmi/Kconfig            |  12 ++
 drivers/firmware/arm_scmi/Makefile           |   1 +
 drivers/firmware/arm_scmi/scmi_perf_domain.c | 155 +++++++++++++++++++
 3 files changed, 168 insertions(+)
 create mode 100644 drivers/firmware/arm_scmi/scmi_perf_domain.c

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index ea0f5083ac47..706d1264d038 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -181,6 +181,18 @@ config ARM_SCMI_POWER_DOMAIN
 	  will be called scmi_pm_domain. Note this may needed early in boot
 	  before rootfs may be available.
 
+config ARM_SCMI_PERF_DOMAIN
+	tristate "SCMI performance domain driver"
+	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
+	default y
+	select PM_GENERIC_DOMAINS if PM
+	help
+	  This enables support for the SCMI performance domains which can be
+	  enabled or disabled via the SCP firmware.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called scmi_perf_domain.
+
 config ARM_SCMI_POWER_CONTROL
 	tristate "SCMI system power control driver"
 	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index b31d78fa66cc..afee66a65dcb 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-module.o
 
 obj-$(CONFIG_ARM_SCMI_POWER_DOMAIN) += scmi_pm_domain.o
+obj-$(CONFIG_ARM_SCMI_PERF_DOMAIN) += scmi_perf_domain.o
 obj-$(CONFIG_ARM_SCMI_POWER_CONTROL) += scmi_power_control.o
 
 ifeq ($(CONFIG_THUMB2_KERNEL)$(CONFIG_CC_IS_CLANG),yy)
diff --git a/drivers/firmware/arm_scmi/scmi_perf_domain.c b/drivers/firmware/arm_scmi/scmi_perf_domain.c
new file mode 100644
index 000000000000..9be90a7d94de
--- /dev/null
+++ b/drivers/firmware/arm_scmi/scmi_perf_domain.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SCMI performance domain support.
+ *
+ * Copyright (C) 2023 Linaro Ltd.
+ */
+
+#include <linux/err.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/pm_domain.h>
+#include <linux/scmi_protocol.h>
+#include <linux/slab.h>
+
+struct scmi_perf_domain {
+	struct generic_pm_domain genpd;
+	const struct scmi_perf_proto_ops *perf_ops;
+	const struct scmi_protocol_handle *ph;
+	u32 domain_id;
+	bool can_level_set;
+};
+
+#define to_scmi_pd(pd) container_of(pd, struct scmi_perf_domain, genpd)
+
+static int
+scmi_pd_set_perf_state(struct generic_pm_domain *genpd, unsigned int state)
+{
+	struct scmi_perf_domain *pd = to_scmi_pd(genpd);
+	int ret;
+
+	if (!pd->can_level_set)
+		return 0;
+
+	ret = pd->perf_ops->level_set(pd->ph, pd->domain_id, state, true);
+	if (ret)
+		dev_warn(&genpd->dev, "Failed with %d when trying to set %d perf level",
+			 ret, state);
+
+	return ret;
+}
+
+static int scmi_perf_domain_probe(struct scmi_device *sdev)
+{
+	struct device *dev = &sdev->dev;
+	const struct scmi_handle *handle = sdev->handle;
+	const struct scmi_perf_proto_ops *perf_ops;
+	struct scmi_protocol_handle *ph;
+	struct scmi_perf_domain *scmi_pd;
+	struct genpd_onecell_data *scmi_pd_data;
+	struct generic_pm_domain **domains;
+	int num_domains, i, ret = 0;
+	u32 perf_level;
+
+	if (!handle)
+		return -ENODEV;
+
+	/* The OF node must specify us as a power-domain provider. */
+	if (!of_find_property(dev->of_node, "#power-domain-cells", NULL))
+		return 0;
+
+	perf_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PERF, &ph);
+	if (IS_ERR(perf_ops))
+		return PTR_ERR(perf_ops);
+
+	num_domains = perf_ops->num_domains_get(ph);
+	if (num_domains < 0) {
+		dev_warn(dev, "Failed with %d when getting num perf domains\n",
+			 num_domains);
+		return num_domains;
+	} else if (!num_domains) {
+		return 0;
+	}
+
+	scmi_pd = devm_kcalloc(dev, num_domains, sizeof(*scmi_pd), GFP_KERNEL);
+	if (!scmi_pd)
+		return -ENOMEM;
+
+	scmi_pd_data = devm_kzalloc(dev, sizeof(*scmi_pd_data), GFP_KERNEL);
+	if (!scmi_pd_data)
+		return -ENOMEM;
+
+	domains = devm_kcalloc(dev, num_domains, sizeof(*domains), GFP_KERNEL);
+	if (!domains)
+		return -ENOMEM;
+
+	for (i = 0; i < num_domains; i++, scmi_pd++) {
+		scmi_pd->domain_id = i;
+		scmi_pd->perf_ops = perf_ops;
+		scmi_pd->ph = ph;
+		scmi_pd->can_level_set = perf_ops->can_level_set(ph, i);
+
+		scmi_pd->genpd.name = perf_ops->name_get(ph, i);
+		scmi_pd->genpd.flags = GENPD_FLAG_OPP_TABLE_FW;
+		scmi_pd->genpd.set_performance_state = scmi_pd_set_perf_state;
+
+		ret = perf_ops->level_get(ph, i, &perf_level, false);
+		if (ret) {
+			dev_dbg(dev, "Failed to get perf level for %s",
+				 scmi_pd->genpd.name);
+			perf_level = 0;
+		}
+
+		/* Let the perf level indicate the power-state too. */
+		ret = pm_genpd_init(&scmi_pd->genpd, NULL, perf_level == 0);
+		if (ret)
+			goto err;
+
+		domains[i] = &scmi_pd->genpd;
+	}
+
+	scmi_pd_data->domains = domains;
+	scmi_pd_data->num_domains = num_domains;
+
+	ret = of_genpd_add_provider_onecell(dev->of_node, scmi_pd_data);
+	if (ret)
+		goto err;
+
+	dev_set_drvdata(dev, scmi_pd_data);
+	dev_info(dev, "Initialized %d performance domains", num_domains);
+	return 0;
+err:
+	for (i--; i >= 0; i--)
+		pm_genpd_remove(domains[i]);
+	return ret;
+}
+
+static void scmi_perf_domain_remove(struct scmi_device *sdev)
+{
+	struct device *dev = &sdev->dev;
+	struct genpd_onecell_data *scmi_pd_data = dev_get_drvdata(dev);
+	int i;
+
+	of_genpd_del_provider(dev->of_node);
+
+	for (i = 0; i < scmi_pd_data->num_domains; i++)
+		pm_genpd_remove(scmi_pd_data->domains[i]);
+}
+
+static const struct scmi_device_id scmi_id_table[] = {
+	{ SCMI_PROTOCOL_PERF, "perf" },
+	{ },
+};
+MODULE_DEVICE_TABLE(scmi, scmi_id_table);
+
+static struct scmi_driver scmi_perf_domain_driver = {
+	.name		= "scmi-perf-domain",
+	.probe		= scmi_perf_domain_probe,
+	.remove		= scmi_perf_domain_remove,
+	.id_table	= scmi_id_table,
+};
+module_scmi_driver(scmi_perf_domain_driver);
+
+MODULE_AUTHOR("Ulf Hansson <ulf.hansson@linaro.org>");
+MODULE_DESCRIPTION("ARM SCMI perf domain driver");
+MODULE_LICENSE("GPL v2");
-- 
2.34.1

