Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D91E680A17
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 10:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbjA3JzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 04:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbjA3JzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 04:55:16 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F1F12869
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 01:54:51 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso2735676wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 01:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7euBoOa7af+ZXKas2DHDDapwb4t3u4IzZW1n1QbZQso=;
        b=uRxM/vSxoKv4Ve6a2E9/wOUXksEUNi8FzD2ReJDW8xkNIyrbt+MuShJH9CzXU3Jeo1
         2ymIEy6m1MwfUU8ev3UR37DtvP0adj/EMEbioLj0aUEza5Nh+E4n/js/0tXyOvQ2I13Y
         cT5/BsNjlill6wbCrUBFiJpzeaMo5Vzg0+lEamcRIryAvE9ayLrlLXmE01wWm7rnh0gr
         McC2J6KgC817U+S5Iv5tB/atuCnjgzl66xDXnekN1lq+N3h5PvvjQyf3XErgh2XTwWLU
         wZHSDpeLblb1dx/O14/x+xuED8yZbKGuwpQQsvPlyL8mxqV/Lxct3skFfpwqL8yDGa9i
         8SbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7euBoOa7af+ZXKas2DHDDapwb4t3u4IzZW1n1QbZQso=;
        b=LytEcSCkY7HFmlvJLufjARGA9ZeNEg3lSqPhVQpOKNutxAyN4AI7aiMKCcS1FfCs1h
         zGlB3DNStMV1tVXQzvfu4V6jxICQyBJsFMyTV8CLGtuxmm5L52EbgMcmn6B8jzs3bmEG
         vkWJVoZ2zDwHTscvjSHGZNqJGH6SyI7RN/UwqW1dgLd1U0monb0QKwmyKNAC2//0dpfa
         WflJUETl9r6FgrKEQ8mndkAQzb8IoglgmiBe1vDoikdixm1nh87EfeFS3KytnRpZGBNa
         ZsA4i9mzl7c76kCNto1gbdQjOFyYI2oI0xQWeFLbJBtPLQnqEjKNyuxy8ALAWhom1GTG
         i/wg==
X-Gm-Message-State: AFqh2kraex5idV7lpm2ruB04W8huP5BXS6A1LVafkfkkVXjO1wlwKNl2
        cYlrCS6jDqxVgmmj/Hu1E4n8gQ==
X-Google-Smtp-Source: AMrXdXtGk7uV6IRoZx1GFEI3rEo383u1XXcjfcqvMURlt3fZsD1LVPBClqbfrspfrgExxNNGYYKGXw==
X-Received: by 2002:a05:600c:4395:b0:3da:2829:2935 with SMTP id e21-20020a05600c439500b003da28292935mr48559273wmn.11.1675072476160;
        Mon, 30 Jan 2023 01:54:36 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id k4-20020a5d4284000000b00241fde8fe04sm11453537wrq.7.2023.01.30.01.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 01:54:35 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 30 Jan 2023 10:54:32 +0100
Subject: [PATCH 1/7] usb: typec: ucsi: add PMIC Glink UCSI driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230130-topic-sm8450-upstream-pmic-glink-v1-1-0b0acfad301e@linaro.org>
References: <20230130-topic-sm8450-upstream-pmic-glink-v1-0-0b0acfad301e@linaro.org>
In-Reply-To: <20230130-topic-sm8450-upstream-pmic-glink-v1-0-0b0acfad301e@linaro.org>
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
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 drivers/usb/typec/ucsi/Kconfig      |   7 +
 drivers/usb/typec/ucsi/Makefile     |   1 +
 drivers/usb/typec/ucsi/ucsi_glink.c | 321 ++++++++++++++++++++++++++++++++++++
 3 files changed, 329 insertions(+)

diff --git a/drivers/usb/typec/ucsi/Kconfig b/drivers/usb/typec/ucsi/Kconfig
index 8f9c4b9f31f7..dee6069e46a2 100644
--- a/drivers/usb/typec/ucsi/Kconfig
+++ b/drivers/usb/typec/ucsi/Kconfig
@@ -58,4 +58,11 @@ config UCSI_STM32G0
 	  To compile the driver as a module, choose M here: the module will be
 	  called ucsi_stm32g0.
 
+config UCSI_PMIC_GLINK
+	tristate "UCSI Qualcomm PMIC GLINK Interface Driver"
+	depends on QCOM_PMIC_GLINK
+	help
+	  This driver enables UCSI support on platforms that expose UCSI
+	  interface as PMIC GLINK device.
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
index 000000000000..824ed6620de7
--- /dev/null
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -0,0 +1,321 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022-2023, Linaro Ltd
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
+	u64 command;
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
+static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
+				 const struct auxiliary_device_id *id)
+{
+	struct pmic_glink_ucsi *ucsi;
+	struct device *dev = &adev->dev;
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
+static const struct auxiliary_device_id pmic_glink_ucsi_id_table[] = {
+	{ .name = "pmic_glink.ucsi", },
+	{},
+};
+MODULE_DEVICE_TABLE(auxiliary, pmic_glink_ucsi_id_table);
+
+static struct auxiliary_driver pmic_glink_ucsi_driver = {
+	.name = "pmic_glink_ucsi",
+	.probe = pmic_glink_ucsi_probe,
+	.id_table = pmic_glink_ucsi_id_table,
+};
+
+module_auxiliary_driver(pmic_glink_ucsi_driver);
+
+MODULE_DESCRIPTION("Qualcomm PMIC GLINK UCSI driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1

