Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D7B67EDCC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 19:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbjA0SrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 13:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbjA0SrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 13:47:07 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821D775790;
        Fri, 27 Jan 2023 10:47:04 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so6016262wma.1;
        Fri, 27 Jan 2023 10:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpe+bVeYsi0cP/h3pLpQx4qS1D1xnS2ts9XErjiPfKI=;
        b=qqyGyqcqXg+TOV0KOCjfUky6Ur+3GADtp2S96S8xIkauyXfBB0wQDqNgsh6T2/GUDM
         S/HERvbYwGKTIIX1fp9RxOCB46v8k+lNwIJbLTlcp4h2111nN7sNvSD6XB/hPh9NAI6r
         889DlT/swG/rXKdTmbZKiWuFcZbV+8NqHrm/JcIEcfD6v8mHTj4KDQJYJwN82Rdhunxu
         hu3eJRFolokmMk2dS34NkJDOuqfAWlOaaUyqH/V9TkgA5ohRUkQnJkBRbpPPaF3ZUIP6
         foM5NNnX4Q9YQjvL8G/nufWOCDsUyqIQgH4D3fZ38UfngWablIINYqd7Ni5Jr+F5tBOe
         4WZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mpe+bVeYsi0cP/h3pLpQx4qS1D1xnS2ts9XErjiPfKI=;
        b=fkW2YXydWgEQl/zPOUCHDs2BbZNZqKB3TGWn4ZCJNTxOzsfSHkejFeIp836XkC9OMg
         WFyM402HMaqYzfQdqXzm6c6fn7HKkrExaywTIVRIQ4xU6ahGLOlH/XVA7G1OywpsZ4ms
         wpSVKbkctLXitsfFlRgLs4zAhV8H38pQeFOnDTUDbmgUuGa/k9EKpreRz5mPkhtF7rJV
         gY6ITB2ErKZYvGDEt8ih/sc0IF+68zXe++wImFmS3Vg2La8IckcipSjDbr8SbDSI5s/B
         GHINXUbBI9ikjBrSMg0xozfDILIbWMP1PNdLim9CWfgWOpv8tS0piELnf40W0ktvGm8M
         ZlVA==
X-Gm-Message-State: AFqh2kr9JjB0wylCHMz1o1zjzR8Q2SZfytX0LCCGfI7inlW2Z7PxdIsu
        2d5xJg2JaVTFdBRLvPEfc/8=
X-Google-Smtp-Source: AMrXdXtTpaQj9B3jDtpqC4wXUhZ73jOnhGVdE6Fn5KwR7HSJYKQJkrYoWZzKvOEwcrsBpwnfQe2gaw==
X-Received: by 2002:a05:600c:4b9a:b0:3da:fcdc:cafd with SMTP id e26-20020a05600c4b9a00b003dafcdccafdmr40290663wmp.13.1674845222937;
        Fri, 27 Jan 2023 10:47:02 -0800 (PST)
Received: from xws.localdomain (pd9ea339c.dip0.t-ipconnect.de. [217.234.51.156])
        by smtp.gmail.com with ESMTPSA id g12-20020a05600c310c00b003db012d49b7sm16234208wmo.2.2023.01.27.10.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 10:47:02 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] firmware: Add support for Qualcomm Secure Execution Environment SCM interface
Date:   Fri, 27 Jan 2023 19:46:48 +0100
Message-Id: <20230127184650.756795-3-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230127184650.756795-1-luzmaximilian@gmail.com>
References: <20230127184650.756795-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for SCM calls to Secure OS and the Secure Execution
Environment (SEE) residing in the TrustZone (TZ) via the QSEECOM
interface. This allows communication with Secure/TZ applications, for
example 'uefisecapp' managing access to UEFI variables.

The interface is managed by a platform device to ensure correct lifetime
and establish a device link to the Qualcomm SCM device.

While this patch introduces only a very basic interface without the more
advanced features (such as re-entrant and blocking SCM calls and
listeners/callbacks), this is enough to talk to the aforementioned
'uefisecapp'.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---

Changes in v2:
 - Bind the interface to a device.
 - Establish a device link to the SCM device to ensure proper ordering.
 - Register client apps as child devices instead of requiring them to be
   specified in the device tree.
 - Rename (qctree -> qseecom) to allow differentiation between old
   (qseecom) and new (smcinvoke) interfaces to the trusted execution
   environment.

---
 MAINTAINERS                     |   7 +
 drivers/firmware/Kconfig        |  15 ++
 drivers/firmware/Makefile       |   1 +
 drivers/firmware/qcom_qseecom.c | 314 ++++++++++++++++++++++++++++++++
 include/linux/qcom_qseecom.h    | 190 +++++++++++++++++++
 5 files changed, 527 insertions(+)
 create mode 100644 drivers/firmware/qcom_qseecom.c
 create mode 100644 include/linux/qcom_qseecom.h

diff --git a/MAINTAINERS b/MAINTAINERS
index f2c3d471fe8f..846d6c927840 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17387,6 +17387,13 @@ F:	Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
 F:	drivers/net/ethernet/qualcomm/rmnet/
 F:	include/linux/if_rmnet.h
 
+QUALCOMM SECURE EXECUTION ENVIRONMENT COMMUNICATION DRIVER
+M:	Maximilian Luz <luzmaximilian@gmail.com>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	drivers/firmware/qcom_qseecom.c
+F:	include/linux/qcom_qseecom.h
+
 QUALCOMM TSENS THERMAL DRIVER
 M:	Amit Kucheria <amitk@kernel.org>
 M:	Thara Gopinath <thara.gopinath@gmail.com>
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index b59e3041fd62..22eec0835abf 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -226,6 +226,21 @@ config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
 
 	  Say Y here to enable "download mode" by default.
 
+config QCOM_QSEECOM
+	tristate "Qualcomm QSEECOM interface driver"
+	select MFD_CORE
+	select QCOM_SCM
+	help
+	  Various Qualcomm SoCs have a Secure Execution Environment (SEE) running
+	  in the Trust Zone. This module provides an interface to that via the
+	  QSEECOM mechanism, using SCM calls.
+
+	  The QSEECOM interface allows, among other things, access to applications
+	  running in the SEE. An example of such an application is 'uefisecapp',
+	  which is required to access UEFI variables on certain systems.
+
+	  Select M or Y here to enable the QSEECOM interface driver.
+
 config SYSFB
 	bool
 	select BOOT_VESA_SUPPORT
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 28fcddcd688f..aa48e0821b7d 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_RASPBERRYPI_FIRMWARE) += raspberrypi.o
 obj-$(CONFIG_FW_CFG_SYSFS)	+= qemu_fw_cfg.o
 obj-$(CONFIG_QCOM_SCM)		+= qcom-scm.o
 qcom-scm-objs += qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
+obj-$(CONFIG_QCOM_QSEECOM)	+= qcom_qseecom.o
 obj-$(CONFIG_SYSFB)		+= sysfb.o
 obj-$(CONFIG_SYSFB_SIMPLEFB)	+= sysfb_simplefb.o
 obj-$(CONFIG_TI_SCI_PROTOCOL)	+= ti_sci.o
diff --git a/drivers/firmware/qcom_qseecom.c b/drivers/firmware/qcom_qseecom.c
new file mode 100644
index 000000000000..2553742ccc43
--- /dev/null
+++ b/drivers/firmware/qcom_qseecom.c
@@ -0,0 +1,314 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Interface driver for the Qualcomm Secure Execution Environment (SEE) /
+ * TrustZone OS (TzOS). Manages communication via the QSEECOM interface, using
+ * Secure Channel Manager (SCM) calls.
+ *
+ * Copyright (C) 2023 Maximilian Luz <luzmaximilian@gmail.com>
+ */
+
+#include <asm/barrier.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/mfd/core.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/qcom_scm.h>
+#include <linux/string.h>
+
+#include <linux/qcom_qseecom.h>
+
+
+/* -- Secure-OS SCM call interface. ----------------------------------------- */
+
+static int __qseecom_scm_call(const struct qcom_scm_desc *desc,
+			      struct qseecom_scm_resp *res)
+{
+	struct qcom_scm_res scm_res = {};
+	int status;
+
+	status = qcom_scm_call(desc, &scm_res);
+
+	res->status = scm_res.result[0];
+	res->resp_type = scm_res.result[1];
+	res->data = scm_res.result[2];
+
+	if (status)
+		return status;
+
+	return 0;
+}
+
+/**
+ * qseecom_scm_call() - Perform a QSEECOM SCM call.
+ * @qsee: The QSEECOM device.
+ * @desc: SCM call descriptor.
+ * @res:  SCM call response (output).
+ *
+ * Performs the QSEECOM SCM call described by @desc, returning the response in
+ * @rsp.
+ *
+ * Return: Returns zero on success, nonzero on failure.
+ */
+int qseecom_scm_call(struct qseecom_device *qsee, const struct qcom_scm_desc *desc,
+		     struct qseecom_scm_resp *res)
+{
+	int status;
+
+	/*
+	 * Note: Multiple QSEECOM SCM calls should not be executed same time,
+	 * so lock things here. This needs to be extended to callback/listener
+	 * handling when support for that is implemented.
+	 */
+
+	mutex_lock(&qsee->scm_call_lock);
+	status = __qseecom_scm_call(desc, res);
+	mutex_unlock(&qsee->scm_call_lock);
+
+	dev_dbg(qsee->dev, "%s: owner=%x, svc=%x, cmd=%x, status=%lld, type=%llx, data=%llx",
+		__func__, desc->owner, desc->svc, desc->cmd, res->status,
+		res->resp_type, res->data);
+
+	if (status) {
+		dev_err(qsee->dev, "qcom_scm_call failed with error %d\n", status);
+		return status;
+	}
+
+	/*
+	 * TODO: Handle incomplete and blocked calls:
+	 *
+	 * Incomplete and blocked calls are not supported yet. Some devices
+	 * and/or commands require those, some don't. Let's warn about them
+	 * prominently in case someone attempts to try these commands with a
+	 * device/command combination that isn't supported yet.
+	 */
+	WARN_ON(res->status == QSEECOM_RESULT_INCOMPLETE);
+	WARN_ON(res->status == QSEECOM_RESULT_BLOCKED_ON_LISTENER);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qseecom_scm_call);
+
+
+/* -- Secure App interface. ------------------------------------------------- */
+
+/**
+ * qseecom_app_get_id() - Query the app ID for a given SEE app name.
+ * @qsee:     The QSEECOM device.
+ * @app_name: The name of the app.
+ * @app_id:   The returned app ID.
+ *
+ * Query and return the application ID of the SEE app identified by the given
+ * name. This returned ID is the unique identifier of the app required for
+ * subsequent communication.
+ *
+ * Return: Returns zero on success, nonzero on failure. Returns -ENOENT if the
+ * app has not been loaded or could not be found.
+ */
+int qseecom_app_get_id(struct qseecom_device *qsee, const char *app_name, u32 *app_id)
+{
+	unsigned long name_buf_size = QSEECOM_MAX_APP_NAME_SIZE;
+	unsigned long app_name_len = strlen(app_name);
+	struct qcom_scm_desc desc = {};
+	struct qseecom_scm_resp res = {};
+	dma_addr_t name_buf_phys;
+	char *name_buf;
+	int status;
+
+	if (app_name_len >= name_buf_size)
+		return -EINVAL;
+
+	name_buf = kzalloc(name_buf_size, GFP_KERNEL);
+	if (!name_buf)
+		return -ENOMEM;
+
+	memcpy(name_buf, app_name, app_name_len);
+
+	name_buf_phys = dma_map_single(qsee->dev, name_buf, name_buf_size, DMA_TO_DEVICE);
+	if (dma_mapping_error(qsee->dev, name_buf_phys)) {
+		kfree(name_buf);
+		dev_err(qsee->dev, "failed to map dma address\n");
+		return -EFAULT;
+	}
+
+	desc.owner = QSEECOM_TZ_OWNER_QSEE_OS;
+	desc.svc = QSEECOM_TZ_SVC_APP_MGR;
+	desc.cmd = 0x03;
+	desc.arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_RW, QCOM_SCM_VAL);
+	desc.args[0] = name_buf_phys;
+	desc.args[1] = app_name_len;
+
+	status = qseecom_scm_call(qsee, &desc, &res);
+	dma_unmap_single(qsee->dev, name_buf_phys, name_buf_size, DMA_TO_DEVICE);
+	kfree(name_buf);
+
+	if (status)
+		return status;
+
+	if (res.status != QSEECOM_RESULT_SUCCESS)
+		return -ENOENT;
+
+	*app_id = res.data;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qseecom_app_get_id);
+
+/**
+ * qseecom_app_send() - Send to and receive data from a given SEE app.
+ * @qsee:   The QSEECOM device.
+ * @app_id: The ID of the app to communicate with.
+ * @req:    DMA region of the request sent to the app.
+ * @rsp:    DMA region of the response returned by the app.
+ *
+ * Sends a request to the SEE app identified by the given ID and read back its
+ * response. The caller must provide two DMA memory regions, one for the
+ * request and one for the response, and fill out the @req region with the
+ * respective (app-specific) request data. The SEE app reads this and returns
+ * its response in the @rsp region.
+ *
+ * Return: Returns zero on success, nonzero on failure.
+ */
+int qseecom_app_send(struct qseecom_device *qsee, u32 app_id, struct qseecom_dma *req,
+		     struct qseecom_dma *rsp)
+{
+	struct qseecom_scm_resp res = {};
+	int status;
+
+	struct qcom_scm_desc desc = {
+		.owner = QSEECOM_TZ_OWNER_TZ_APPS,
+		.svc = QSEECOM_TZ_SVC_APP_ID_PLACEHOLDER,
+		.cmd = 0x01,
+		.arginfo = QCOM_SCM_ARGS(5, QCOM_SCM_VAL,
+					 QCOM_SCM_RW, QCOM_SCM_VAL,
+					 QCOM_SCM_RW, QCOM_SCM_VAL),
+		.args[0] = app_id,
+		.args[1] = req->phys,
+		.args[2] = req->size,
+		.args[3] = rsp->phys,
+		.args[4] = rsp->size,
+	};
+
+	/* Make sure the request is fully written before sending it off. */
+	dma_wmb();
+
+	status = qseecom_scm_call(qsee, &desc, &res);
+
+	/* Make sure we don't attempt any reads before the SCM call is done. */
+	dma_rmb();
+
+	if (status)
+		return status;
+
+	if (res.status != QSEECOM_RESULT_SUCCESS)
+		return -EIO;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qseecom_app_send);
+
+
+/* -- Platform specific data. ----------------------------------------------- */
+
+struct qseecom_data {
+	const struct mfd_cell *cells;
+	int num_cells;
+};
+
+static const struct of_device_id qseecom_dt_match[] = {
+	{ .compatible = "qcom,qseecom-sc8280xp", },
+	{ .compatible = "qcom,qseecom", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, qseecom_dt_match);
+
+
+/* -- Driver setup. --------------------------------------------------------- */
+
+static int qseecom_setup_scm_link(struct platform_device *pdev)
+{
+	const u32 flags = DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_CONSUMER;
+	struct platform_device *scm_dev;
+	struct device_node *scm_node;
+	struct device_link *link;
+	int status = 0;
+
+	if (!pdev->dev.of_node)
+		return -ENODEV;
+
+	/* Find the SCM device. */
+	scm_node = of_parse_phandle(pdev->dev.of_node, "qcom,scm", 0);
+	if (!scm_node)
+		return -ENOENT;
+
+	scm_dev = of_find_device_by_node(scm_node);
+	if (!scm_dev) {
+		status = -ENODEV;
+		goto put;
+	}
+
+	/* Establish the device link. */
+	link = device_link_add(&pdev->dev, &scm_dev->dev, flags);
+	if (!link) {
+		status = -EINVAL;
+		goto put;
+	}
+
+	/* Make sure SCM has a driver bound, otherwise defer probe. */
+	if (link->supplier->links.status != DL_DEV_DRIVER_BOUND) {
+		status = -EPROBE_DEFER;
+		goto put;
+	}
+
+put:
+	of_node_put(scm_node);
+	return status;
+}
+
+static int qseecom_probe(struct platform_device *pdev)
+{
+	const struct qseecom_data *data;
+	struct qseecom_device *qsee;
+	int status;
+
+	/* Get platform data. */
+	data = of_device_get_match_data(&pdev->dev);
+
+	/* Set up device link. */
+	status = qseecom_setup_scm_link(pdev);
+	if (status)
+		return status;
+
+	/* Set up QSEECOM device. */
+	qsee = devm_kzalloc(&pdev->dev, sizeof(*qsee), GFP_KERNEL);
+	if (!qsee)
+		return -ENOMEM;
+
+	qsee->dev = &pdev->dev;
+	mutex_init(&qsee->scm_call_lock);
+
+	platform_set_drvdata(pdev, qsee);
+
+	/* Add child devices. */
+	if (data) {
+		status = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE, data->cells,
+					      data->num_cells, NULL, 0, NULL);
+	}
+
+	return status;
+}
+
+static struct platform_driver qseecom_driver = {
+	.probe = qseecom_probe,
+	.driver = {
+		.name = "qcom_qseecom",
+		.of_match_table = qseecom_dt_match,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+};
+module_platform_driver(qseecom_driver);
+
+MODULE_AUTHOR("Maximilian Luz <luzmaximilian@gmail.com>");
+MODULE_DESCRIPTION("Driver for Qualcomm QSEECOM secure OS and secure application interface");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/qcom_qseecom.h b/include/linux/qcom_qseecom.h
new file mode 100644
index 000000000000..4bee5e551d6e
--- /dev/null
+++ b/include/linux/qcom_qseecom.h
@@ -0,0 +1,190 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Interface driver for the Qualcomm Secure Execution Environment (SEE) /
+ * TrustZone OS (TzOS). Manages communication via the QSEECOM interface, using
+ * Secure Channel Manager (SCM) calls.
+ *
+ * Copyright (C) 2023 Maximilian Luz <luzmaximilian@gmail.com>
+ */
+
+#ifndef _LINUX_QCOM_QSEECOM_H
+#define _LINUX_QCOM_QSEECOM_H
+
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/mutex.h>
+#include <linux/qcom_scm.h>
+#include <linux/types.h>
+
+
+/* -- DMA helpers. ---------------------------------------------------------- */
+
+/* DMA requirements for QSEECOM SCM calls. */
+#define QSEECOM_DMA_ALIGNMENT		8
+#define QSEECOM_DMA_ALIGN(ptr)		ALIGN(ptr, QSEECOM_DMA_ALIGNMENT)
+
+/**
+ * struct qseecom_dma - DMA memory region.
+ * @size: Size of the memory region, in bytes.
+ * @virt: Pointer / virtual address to the memory, accessible by the kernel.
+ * @phys: Physical address of the memory region.
+ */
+struct qseecom_dma {
+	unsigned long size;
+	void *virt;
+	dma_addr_t phys;
+};
+
+/**
+ * qseecom_dma_alloc() - Allocate a DMA-able memory region suitable for QSEECOM
+ * SCM calls.
+ * @dev:  The device used for DMA memory allocation.
+ * @dma:  Where to write the allocated memory addresses and size to.
+ * @size: Minimum size of the memory to be allocated.
+ * @gfp:  Flags used for allocation.
+ *
+ * Allocate a DMA-able memory region suitable for interaction with SEE
+ * services/applications and the TzOS. The provided size is treated as the
+ * minimum required size and rounded up, if necessary. The actually allocated
+ * memory region will be stored in @dma. Allocated memory must be freed via
+ * qseecom_dma_free().
+ *
+ * Return: Returns zero on success, -ENOMEM on allocation failure.
+ */
+static inline int qseecom_dma_alloc(struct device *dev, struct qseecom_dma *dma,
+				    unsigned long size, gfp_t gfp)
+{
+	size = PAGE_ALIGN(size);
+
+	dma->virt = dma_alloc_coherent(dev, size, &dma->phys, GFP_KERNEL);
+	if (!dma->virt)
+		return -ENOMEM;
+
+	dma->size = size;
+	return 0;
+}
+
+/**
+ * qseecom_dma_free() - Free a DMA memory region.
+ * @dev: The device used for allocation.
+ * @dma: The DMA region to be freed.
+ *
+ * Free a DMA region previously allocated via qseecom_dma_alloc(). Note that
+ * freeing sub-regions is not supported.
+ */
+static inline void qseecom_dma_free(struct device *dev, struct qseecom_dma *dma)
+{
+	dma_free_coherent(dev, dma->size, dma->virt, dma->phys);
+}
+
+/**
+ * qseecom_dma_realloc() - Re-allocate DMA memory region with the requested size.
+ * @dev:  The device used for allocation.
+ * @dma:  The region descriptor to be updated.
+ * @size: The new requested size.
+ * @gfp:  Flags used for allocation.
+ *
+ * Re-allocates a DMA memory region suitable for QSEECOM SCM calls to fit the
+ * requested amount of bytes, if necessary. Does nothing if the provided region
+ * already has enough space to store the requested data.
+ *
+ * See qseecom_dma_alloc() for details.
+ *
+ * Return: Returns zero on success, -ENOMEM on allocation failure.
+ */
+static inline int qseecom_dma_realloc(struct device *dev, struct qseecom_dma *dma,
+				      unsigned long size, gfp_t gfp)
+{
+	if (PAGE_ALIGN(size) <= dma->size)
+		return 0;
+
+	qseecom_dma_free(dev, dma);
+	return qseecom_dma_alloc(dev, dma, size, gfp);
+}
+
+/**
+ * qseecom_dma_aligned() - Create a aligned DMA memory sub-region suitable for
+ * QSEECOM SCM calls.
+ * @base:   Base DMA memory region, in which the new region will reside.
+ * @out:    Descriptor to store the aligned sub-region in.
+ * @offset: The offset inside base region at which to place the new sub-region.
+ *
+ * Creates an aligned DMA memory region suitable for QSEECOM SCM calls at or
+ * after the given offset. The size of the sub-region will be set to the
+ * remaining size in the base region after alignment, i.e., the end of the
+ * sub-region will be equal the end of the base region.
+ *
+ * Return: Returns zero on success or -EINVAL if the new aligned memory address
+ * would point outside the base region.
+ */
+static inline int qseecom_dma_aligned(const struct qseecom_dma *base, struct qseecom_dma *out,
+				      unsigned long offset)
+{
+	void *aligned = (void *)QSEECOM_DMA_ALIGN((uintptr_t)base->virt + offset);
+
+	if (aligned - base->virt > base->size)
+		return -EINVAL;
+
+	out->virt = aligned;
+	out->phys = base->phys + (out->virt - base->virt);
+	out->size = base->size - (out->virt - base->virt);
+
+	return 0;
+}
+
+
+/* -- Common interface. ----------------------------------------------------- */
+
+struct qseecom_device {
+	struct device *dev;
+	struct mutex scm_call_lock;	/* Guards QSEECOM SCM calls. */
+};
+
+
+/* -- Secure-OS SCM call interface. ----------------------------------------- */
+
+#define QSEECOM_TZ_OWNER_TZ_APPS		48
+#define QSEECOM_TZ_OWNER_QSEE_OS		50
+
+#define QSEECOM_TZ_SVC_APP_ID_PLACEHOLDER	0
+#define QSEECOM_TZ_SVC_APP_MGR			1
+
+enum qseecom_scm_result {
+	QSEECOM_RESULT_SUCCESS			= 0,
+	QSEECOM_RESULT_INCOMPLETE		= 1,
+	QSEECOM_RESULT_BLOCKED_ON_LISTENER	= 2,
+	QSEECOM_RESULT_FAILURE			= 0xFFFFFFFF,
+};
+
+enum qseecom_scm_resp_type {
+	QSEECOM_SCM_RES_APP_ID			= 0xEE01,
+	QSEECOM_SCM_RES_QSEOS_LISTENER_ID	= 0xEE02,
+};
+
+/**
+ * struct qseecom_scm_resp - QSEECOM SCM call response.
+ * @status:    Status of the SCM call. See &enum qseecom_scm_result.
+ * @resp_type: Type of the response. See &enum qseecom_scm_resp_type.
+ * @data:      Response data. The type of this data is given in @resp_type.
+ */
+struct qseecom_scm_resp {
+	u64 status;
+	u64 resp_type;
+	u64 data;
+};
+
+int qseecom_scm_call(struct qseecom_device *qsee, const struct qcom_scm_desc *desc,
+		     struct qseecom_scm_resp *res);
+
+
+/* -- Secure App interface. ------------------------------------------------- */
+
+#define QSEECOM_MAX_APP_NAME_SIZE			64
+
+int qseecom_app_get_id(struct qseecom_device *qsee, const char *app_name, u32 *app_id);
+int qseecom_app_send(struct qseecom_device *qsee, u32 app_id, struct qseecom_dma *req,
+		     struct qseecom_dma *rsp);
+
+#endif /* _LINUX_QCOM_QSEECOM_H */
-- 
2.39.0

