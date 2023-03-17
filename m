Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA416BEC2B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 16:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjCQPEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 11:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjCQPEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 11:04:31 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A084510EA99
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:04:27 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id o7so4727509wrg.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679065466;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mMoATSuSsIt3se9YT3bxIIdIc3bwo/1URpZulmbGFlU=;
        b=eDv/oaA6inXnYI9ssfRzC0QsP7q2KDBsyVJKwB6PGLcrTRnE6nmbm7F0/oVr6US8Iy
         CFy8myZ6CY4Dl8sRM7s2n16Gozv3IEAnzbWI2hcpPJjYlIPFBmq8lHiZ9MmvjUe0Ted9
         30RXP8MnZv++QFvHy2QfS6KhVPwvTHi4DSzMKPMBGzLhlEBi+5i1D4EvUH9TjLmNfPLN
         ZzJ7muE1n1z/SE5q/P7md5uTm8QjXG2jEh1qenEDvi2BtQutfXTeovlsGBqFMvdrYdzp
         N16LuwPKqZqeTZgi2Dy4X1Jx8VoPG/e+LeuRGSgD1ZQmq3Ir4QizZvLSBntLooCeSkvK
         UASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679065466;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMoATSuSsIt3se9YT3bxIIdIc3bwo/1URpZulmbGFlU=;
        b=nN/AsWFdccs6uw86zfCy8wDiN29+TF2t/gWZsFDlNiAGXIREIfCzBEa3UXCqKR9JzK
         rveL/8J7nLQqPrKqJze/+dTflot1JI5/ApUEtZS+BfjuzdfWVzjD+BXp2yNLBPjcP1sI
         pQUdG/fFWG2LJnOth0ipHIHCpi5rYW/rEb1Dofx8HF75b7ZVC3+y3f+xlggrUzV3maH3
         BHiPHk7fQrU8D7FKlPRvIg96E7faZNqdDjCcoWeiSVtfhruqj0H3w+2h+1hd8/rJjLIt
         dEoXwkS59XGG3xNSyhuudHQSfw5hHT/3gpk+W2hh42uSN0hnJGw/ZLwnJbfy0Fx+Yl+4
         3dfw==
X-Gm-Message-State: AO0yUKVMxU9UOTApsjy839XwWqrSOievfUWaV2Q11W/75MD1wRLFqhjv
        SCd9z+6C7QTb744ZKXDltTp8GA==
X-Google-Smtp-Source: AK7set+DzsOiCmoB6ZAfcm9pj6D7addqBi/5cl1MIoLYh/o6kB/SAvcz4DwPuLZ65n78DJzOMyUZ9Q==
X-Received: by 2002:a5d:464b:0:b0:2c7:faf:af28 with SMTP id j11-20020a5d464b000000b002c70fafaf28mr7185749wrs.43.1679065465877;
        Fri, 17 Mar 2023 08:04:25 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id q14-20020a05600000ce00b002be505ab59asm2133773wrx.97.2023.03.17.08.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 08:04:25 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 17 Mar 2023 16:04:17 +0100
Subject: [PATCH v4 01/12] usb: typec: ucsi: add PMIC Glink UCSI driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230130-topic-sm8450-upstream-pmic-glink-v4-1-38bf0f5d07bd@linaro.org>
References: <20230130-topic-sm8450-upstream-pmic-glink-v4-0-38bf0f5d07bd@linaro.org>
In-Reply-To: <20230130-topic-sm8450-upstream-pmic-glink-v4-0-38bf0f5d07bd@linaro.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the UCSI PMIC Glink aux driver that communicates
with the aDSP firmware with the UCSI protocol which handles
the USB-C Port(s) Power Delivery.

The UCSI messaging is necessary on newer Qualcomm SoCs to
provide USB role switch and altmode notifications.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/usb/typec/ucsi/Kconfig      |  10 ++
 drivers/usb/typec/ucsi/Makefile     |   1 +
 drivers/usb/typec/ucsi/ucsi_glink.c | 345 ++++++++++++++++++++++++++++++++++++
 3 files changed, 356 insertions(+)

diff --git a/drivers/usb/typec/ucsi/Kconfig b/drivers/usb/typec/ucsi/Kconfig
index 8f9c4b9f31f7..b3bb0191987e 100644
--- a/drivers/usb/typec/ucsi/Kconfig
+++ b/drivers/usb/typec/ucsi/Kconfig
@@ -58,4 +58,14 @@ config UCSI_STM32G0
 	  To compile the driver as a module, choose M here: the module will be
 	  called ucsi_stm32g0.
 
+config UCSI_PMIC_GLINK
+	tristate "UCSI Qualcomm PMIC GLINK Interface Driver"
+	depends on QCOM_PMIC_GLINK
+	help
+	  This driver enables UCSI support on platforms that expose UCSI
+	  interface as PMIC GLINK device.
+
+	  To compile the driver as a module, choose M here: the module will be
+	  called ucsi_glink.
+
 endif
diff --git a/drivers/usb/typec/ucsi/Makefile b/drivers/usb/typec/ucsi/Makefile
index 480d533d762f..77f09e136956 100644
--- a/drivers/usb/typec/ucsi/Makefile
+++ b/drivers/usb/typec/ucsi/Makefile
@@ -18,3 +18,4 @@ endif
 obj-$(CONFIG_UCSI_ACPI)			+= ucsi_acpi.o
 obj-$(CONFIG_UCSI_CCG)			+= ucsi_ccg.o
 obj-$(CONFIG_UCSI_STM32G0)		+= ucsi_stm32g0.o
+obj-$(CONFIG_UCSI_PMIC_GLINK)		+= ucsi_glink.o
diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
new file mode 100644
index 000000000000..b454a5159896
--- /dev/null
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -0,0 +1,345 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Linaro Ltd
+ */
+#include <linux/auxiliary_bus.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/soc/qcom/pdr.h>
+#include <linux/soc/qcom/pmic_glink.h>
+#include "ucsi.h"
+
+#define UCSI_BUF_SIZE                   48
+
+#define MSG_TYPE_REQ_RESP               1
+#define UCSI_BUF_SIZE                   48
+
+#define UC_NOTIFY_RECEIVER_UCSI         0x0
+#define UC_UCSI_READ_BUF_REQ            0x11
+#define UC_UCSI_WRITE_BUF_REQ           0x12
+#define UC_UCSI_USBC_NOTIFY_IND         0x13
+
+struct ucsi_read_buf_req_msg {
+	struct pmic_glink_hdr   hdr;
+};
+
+struct ucsi_read_buf_resp_msg {
+	struct pmic_glink_hdr   hdr;
+	u8                      buf[UCSI_BUF_SIZE];
+	u32                     ret_code;
+};
+
+struct ucsi_write_buf_req_msg {
+	struct pmic_glink_hdr   hdr;
+	u8                      buf[UCSI_BUF_SIZE];
+	u32                     reserved;
+};
+
+struct ucsi_write_buf_resp_msg {
+	struct pmic_glink_hdr   hdr;
+	u32                     ret_code;
+};
+
+struct ucsi_notify_ind_msg {
+	struct pmic_glink_hdr   hdr;
+	u32                     notification;
+	u32                     receiver;
+	u32                     reserved;
+};
+
+struct pmic_glink_ucsi {
+	struct device *dev;
+
+	struct pmic_glink_client *client;
+
+	struct ucsi *ucsi;
+	struct completion read_ack;
+	struct completion write_ack;
+	struct completion sync_ack;
+	bool sync_pending;
+	struct mutex lock;	/* protects concurrent access to PMIC Glink interface */
+
+	int sync_val;
+
+	struct work_struct notify_work;
+	struct work_struct register_work;
+
+	u8 read_buf[UCSI_BUF_SIZE];
+};
+
+static int pmic_glink_ucsi_read(struct ucsi *__ucsi, unsigned int offset,
+				void *val, size_t val_len)
+{
+	struct pmic_glink_ucsi *ucsi = ucsi_get_drvdata(__ucsi);
+	struct ucsi_read_buf_req_msg req = {};
+	unsigned long left;
+	int ret;
+
+	req.hdr.owner = PMIC_GLINK_OWNER_USBC;
+	req.hdr.type = MSG_TYPE_REQ_RESP;
+	req.hdr.opcode = UC_UCSI_READ_BUF_REQ;
+
+	mutex_lock(&ucsi->lock);
+	memset(ucsi->read_buf, 0, sizeof(ucsi->read_buf));
+	reinit_completion(&ucsi->read_ack);
+
+	ret = pmic_glink_send(ucsi->client, &req, sizeof(req));
+	if (ret < 0) {
+		dev_err(ucsi->dev, "failed to send UCSI read request: %d\n", ret);
+		goto out_unlock;
+	}
+
+	left = wait_for_completion_timeout(&ucsi->read_ack, 5 * HZ);
+	if (!left) {
+		dev_err(ucsi->dev, "timeout waiting for UCSI read response\n");
+		ret = -ETIMEDOUT;
+		goto out_unlock;
+	}
+
+	memcpy(val, &ucsi->read_buf[offset], val_len);
+	ret = 0;
+
+out_unlock:
+	mutex_unlock(&ucsi->lock);
+
+	return ret;
+}
+
+static int pmic_glink_ucsi_locked_write(struct pmic_glink_ucsi *ucsi, unsigned int offset,
+					const void *val, size_t val_len)
+{
+	struct ucsi_write_buf_req_msg req = {};
+	unsigned long left;
+	int ret;
+
+	req.hdr.owner = PMIC_GLINK_OWNER_USBC;
+	req.hdr.type = MSG_TYPE_REQ_RESP;
+	req.hdr.opcode = UC_UCSI_WRITE_BUF_REQ;
+	memcpy(&req.buf[offset], val, val_len);
+
+	reinit_completion(&ucsi->write_ack);
+
+	ret = pmic_glink_send(ucsi->client, &req, sizeof(req));
+	if (ret < 0) {
+		dev_err(ucsi->dev, "failed to send UCSI write request: %d\n", ret);
+		return ret;
+	}
+
+	left = wait_for_completion_timeout(&ucsi->write_ack, 5 * HZ);
+	if (!left) {
+		dev_err(ucsi->dev, "timeout waiting for UCSI write response\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int pmic_glink_ucsi_async_write(struct ucsi *__ucsi, unsigned int offset,
+				       const void *val, size_t val_len)
+{
+	struct pmic_glink_ucsi *ucsi = ucsi_get_drvdata(__ucsi);
+	int ret;
+
+	mutex_lock(&ucsi->lock);
+	ret = pmic_glink_ucsi_locked_write(ucsi, offset, val, val_len);
+	mutex_unlock(&ucsi->lock);
+
+	return ret;
+}
+
+static int pmic_glink_ucsi_sync_write(struct ucsi *__ucsi, unsigned int offset,
+				      const void *val, size_t val_len)
+{
+	struct pmic_glink_ucsi *ucsi = ucsi_get_drvdata(__ucsi);
+	unsigned long left;
+	int ret;
+
+	/* TOFIX: Downstream forces recipient to CON when UCSI_GET_ALTERNATE_MODES command */
+
+	mutex_lock(&ucsi->lock);
+	ucsi->sync_val = 0;
+	reinit_completion(&ucsi->sync_ack);
+	ucsi->sync_pending = true;
+	ret = pmic_glink_ucsi_locked_write(ucsi, offset, val, val_len);
+	mutex_unlock(&ucsi->lock);
+
+	left = wait_for_completion_timeout(&ucsi->sync_ack, 5 * HZ);
+	if (!left) {
+		dev_err(ucsi->dev, "timeout waiting for UCSI sync write response\n");
+		ret = -ETIMEDOUT;
+	} else if (ucsi->sync_val) {
+		dev_err(ucsi->dev, "sync write returned: %d\n", ucsi->sync_val);
+	}
+
+	ucsi->sync_pending = false;
+
+	return ret;
+}
+
+static const struct ucsi_operations pmic_glink_ucsi_ops = {
+	.read = pmic_glink_ucsi_read,
+	.sync_write = pmic_glink_ucsi_sync_write,
+	.async_write = pmic_glink_ucsi_async_write
+};
+
+static void pmic_glink_ucsi_read_ack(struct pmic_glink_ucsi *ucsi, const void *data, int len)
+{
+	const struct ucsi_read_buf_resp_msg *resp = data;
+
+	if (resp->ret_code)
+		return;
+
+	memcpy(ucsi->read_buf, resp->buf, UCSI_BUF_SIZE);
+	complete(&ucsi->read_ack);
+}
+
+static void pmic_glink_ucsi_write_ack(struct pmic_glink_ucsi *ucsi, const void *data, int len)
+{
+	const struct ucsi_write_buf_resp_msg *resp = data;
+
+	if (resp->ret_code)
+		return;
+
+	ucsi->sync_val = resp->ret_code;
+	complete(&ucsi->write_ack);
+}
+
+static void pmic_glink_ucsi_notify(struct work_struct *work)
+{
+	struct pmic_glink_ucsi *ucsi = container_of(work, struct pmic_glink_ucsi, notify_work);
+	unsigned int con_num;
+	u32 cci;
+	int ret;
+
+	ret = pmic_glink_ucsi_read(ucsi->ucsi, UCSI_CCI, &cci, sizeof(cci));
+	if (ret) {
+		dev_err(ucsi->dev, "failed to read CCI on notification\n");
+		return;
+	}
+
+	con_num = UCSI_CCI_CONNECTOR(cci);
+	if (con_num)
+		ucsi_connector_change(ucsi->ucsi, con_num);
+
+	if (ucsi->sync_pending && cci & UCSI_CCI_BUSY) {
+		ucsi->sync_val = -EBUSY;
+		complete(&ucsi->sync_ack);
+	} else if (ucsi->sync_pending &&
+		   (cci & (UCSI_CCI_ACK_COMPLETE | UCSI_CCI_COMMAND_COMPLETE))) {
+		complete(&ucsi->sync_ack);
+	}
+}
+
+static void pmic_glink_ucsi_register(struct work_struct *work)
+{
+	struct pmic_glink_ucsi *ucsi = container_of(work, struct pmic_glink_ucsi, register_work);
+
+	ucsi_register(ucsi->ucsi);
+}
+
+static void pmic_glink_ucsi_callback(const void *data, size_t len, void *priv)
+{
+	struct pmic_glink_ucsi *ucsi = priv;
+	const struct pmic_glink_hdr *hdr = data;
+
+	switch (hdr->opcode) {
+	case UC_UCSI_READ_BUF_REQ:
+		pmic_glink_ucsi_read_ack(ucsi, data, len);
+		break;
+	case UC_UCSI_WRITE_BUF_REQ:
+		pmic_glink_ucsi_write_ack(ucsi, data, len);
+		break;
+	case UC_UCSI_USBC_NOTIFY_IND:
+		schedule_work(&ucsi->notify_work);
+		break;
+	};
+}
+
+static void pmic_glink_ucsi_pdr_notify(void *priv, int state)
+{
+	struct pmic_glink_ucsi *ucsi = priv;
+
+	if (state == SERVREG_SERVICE_STATE_UP)
+		schedule_work(&ucsi->register_work);
+	else if (state == SERVREG_SERVICE_STATE_DOWN)
+		ucsi_unregister(ucsi->ucsi);
+}
+
+static void pmic_glink_ucsi_destroy(void *data)
+{
+	struct pmic_glink_ucsi *ucsi = data;
+
+	/* Protect to make sure we're not in a middle of a transaction from a glink callback */
+	mutex_lock(&ucsi->lock);
+	ucsi_destroy(ucsi->ucsi);
+	mutex_unlock(&ucsi->lock);
+}
+
+static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
+				 const struct auxiliary_device_id *id)
+{
+	struct pmic_glink_ucsi *ucsi;
+	struct device *dev = &adev->dev;
+	int ret;
+
+	ucsi = devm_kzalloc(dev, sizeof(*ucsi), GFP_KERNEL);
+	if (!ucsi)
+		return -ENOMEM;
+
+	ucsi->dev = dev;
+	dev_set_drvdata(dev, ucsi);
+
+	INIT_WORK(&ucsi->notify_work, pmic_glink_ucsi_notify);
+	INIT_WORK(&ucsi->register_work, pmic_glink_ucsi_register);
+	init_completion(&ucsi->read_ack);
+	init_completion(&ucsi->write_ack);
+	init_completion(&ucsi->sync_ack);
+	mutex_init(&ucsi->lock);
+
+	ucsi->ucsi = ucsi_create(dev, &pmic_glink_ucsi_ops);
+	if (IS_ERR(ucsi->ucsi))
+		return PTR_ERR(ucsi->ucsi);
+
+	/* Make sure we destroy *after* pmic_glink unregister */
+	ret = devm_add_action_or_reset(dev, pmic_glink_ucsi_destroy, ucsi);
+	if (ret)
+		return ret;
+
+	ucsi_set_drvdata(ucsi->ucsi, ucsi);
+
+	ucsi->client = devm_pmic_glink_register_client(dev,
+						       PMIC_GLINK_OWNER_USBC,
+						       pmic_glink_ucsi_callback,
+						       pmic_glink_ucsi_pdr_notify,
+						       ucsi);
+	return PTR_ERR_OR_ZERO(ucsi->client);
+}
+
+static void pmic_glink_ucsi_remove(struct auxiliary_device *adev)
+{
+	struct pmic_glink_ucsi *ucsi = dev_get_drvdata(&adev->dev);
+
+	/* Unregister first to stop having read & writes */
+	ucsi_unregister(ucsi->ucsi);
+}
+
+static const struct auxiliary_device_id pmic_glink_ucsi_id_table[] = {
+	{ .name = "pmic_glink.ucsi", },
+	{},
+};
+MODULE_DEVICE_TABLE(auxiliary, pmic_glink_ucsi_id_table);
+
+static struct auxiliary_driver pmic_glink_ucsi_driver = {
+	.name = "pmic_glink_ucsi",
+	.probe = pmic_glink_ucsi_probe,
+	.remove = pmic_glink_ucsi_remove,
+	.id_table = pmic_glink_ucsi_id_table,
+};
+
+module_auxiliary_driver(pmic_glink_ucsi_driver);
+
+MODULE_DESCRIPTION("Qualcomm PMIC GLINK UCSI driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1

