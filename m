Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53B8692166
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbjBJPCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbjBJPCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:02:23 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CAE4DBC6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:02:11 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id hn2-20020a05600ca38200b003dc5cb96d46so6474794wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dqkw1lFnczMmYP7vS5zM3rMDMKhGSXqs2chEQ2nY1FA=;
        b=nQF6GULB9+UcfVVsHbhon6Lxqi3qfh3eJzAmEWdOCzUg0Y81sXDcExpr/zz8ZQr+XB
         JapGGr/9nsY+p6Y00L6sNii6SALEWRFtX3UwphJZYO5xzmcj34a/Yo7QrFis8+cj4Wqn
         /TLFG46RwLBbOSz8Kagbn25YrgAl/RE3aZybM1YhkhNLJx0zCnh6niHSHZlPwv0IXDv8
         iiwVHXBCCzbUHQC7E7MX8B3KcAzXk54+f8INdVcbuPikM5ngr2JaYNdE8g/SR/9tdyUI
         XUUTVCO8jT9FSRiWIKKHu/xwvqL5nHkiWIIVMlYgKosoF4bMS5aYfiZkMR4Kx9Co5+Au
         rM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dqkw1lFnczMmYP7vS5zM3rMDMKhGSXqs2chEQ2nY1FA=;
        b=sLvJ2QJ165STCira3y8wPK5jRBYRmG+zxYwbx3e3oYCj2OvWv8QhueFHLg60SCnQ8x
         SZSqlfxf9MKe6DT0JcUo1fLhSjNXnioVXoiKxBynr75TEt63JZdUs+ySyuxgcClrVdvy
         zJ9MA4qLuy3WILFqTaNLS1eJFp4rDlwuzuLMJj+MF1s+eqJlNHe0VH51pR5nOTgZLjDE
         YU6qcNjghp9F3zQAec4yehUidsZRBGYw/jv1W8Rgo++w6Ha3mZnET5oSFcUhe/M00bDW
         lqXFKYpRRiY/Oy2WVZCM+ifmG5ldXevRnffoTQMCEuF0X77bRnRyuHsPu8Zg4va2garG
         4nsA==
X-Gm-Message-State: AO0yUKX1e1nbe3vBm0R2dcCspXGkI90UBD7CTfTyVlRkQTPNz7k2mfsL
        90zjrm36qXwiS6QwAtH1fFNWIA==
X-Google-Smtp-Source: AK7set8L9n5pErMPBq6++dt3D+WymR9Cgo1CyXx4DWYgfU5ICAZsfPBZuqqv4clnwVEbUSlh8VoqzQ==
X-Received: by 2002:a05:600c:1604:b0:3d2:3be4:2d9a with SMTP id m4-20020a05600c160400b003d23be42d9amr13476745wmn.20.1676041330218;
        Fri, 10 Feb 2023 07:02:10 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id w23-20020a1cf617000000b003db1d9553e7sm8282482wmc.32.2023.02.10.07.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 07:02:09 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 10 Feb 2023 16:02:04 +0100
Subject: [PATCH v2 01/11] usb: typec: ucsi: add PMIC Glink UCSI driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230130-topic-sm8450-upstream-pmic-glink-v2-1-71fea256474f@linaro.org>
References: <20230130-topic-sm8450-upstream-pmic-glink-v2-0-71fea256474f@linaro.org>
In-Reply-To: <20230130-topic-sm8450-upstream-pmic-glink-v2-0-71fea256474f@linaro.org>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/usb/typec/ucsi/ucsi_glink.c | 320 ++++++++++++++++++++++++++++++++++++
 3 files changed, 331 insertions(+)

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
index 000000000000..9123f8a571e7
--- /dev/null
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -0,0 +1,320 @@
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

