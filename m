Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691ED5B56A8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiILIvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiILIvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:51:10 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC7F2B606
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:51:08 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id q3so7319052pjg.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=mcHAbmO6EYzrZ0AQ4Nq0MIDTLqHSTpgqW7T6LxyC0g4=;
        b=UaikZHsQWaBVtDxYanigIvpOM0cCjorIypmJifQR7VpRpbfydUYy3AKwVo1Ge3l9Iw
         RlplaqR89JzF6byxkwwwe54kIFytCCQ4yOdF8aSAIBc+NyaKhdbYEjVCFZO/DzyWIAii
         t6pVDguWJnxM9WZpXtMmUAgmXNZLQhzULtvJcMZJcMJC9Gkz0p4zrxUMxjsVNBgCsF6D
         ZWUna4BkQVlHGtNcCjDX0r/TV3iVU1hZGX9ckzL/JkKB8iqL1a7QGT4WSO78eLa39nRq
         1AOWZ0DD2c/dMka4X3NHz56/YP5c3RiFpko72q2ndySs3UcexHDBiJaGUmJMj0FPibew
         j0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=mcHAbmO6EYzrZ0AQ4Nq0MIDTLqHSTpgqW7T6LxyC0g4=;
        b=W67xp/LywRJ0i8PBwHJpK02N7xIeEeVxFKiqgMNtzIWuCjgSLTuMSJBN+k/Armo2aW
         BZ6pYiy1JA16GkK8AD9VtQgRo1+UzAGT9l90A3hPYkRX7rQGgfRoMdOBWb+U3jII4rWe
         pN5aKH7Yq1cPD7tWceMnlQhvV+xRm5qm7enD59tzxQiJ1X14ja+7XnVnzsh639AgoCCk
         dG1i3WR6jHJJNceIjLW4FnsV+GB9Kz8Fhbfji6tfuwy1z+T3RRuGwXTxRu7iwuTKp+lr
         h8TsRsr6lHdp9blLU+6QqYoDI6UjB3QJhqY8Utf24RnEhwFXJzi9R7/GdDd4AKZpcTz2
         oQcA==
X-Gm-Message-State: ACgBeo1nRZGUkS2nxaoMYtAZlzEiZvF00eZHNEMC3JbDwx7c8GUeS42d
        5KuspsXCVakpNcy9WDZ7A739GHEdDzCJeQ==
X-Google-Smtp-Source: AA6agR6BPT0VeddfEWpMcs/Eg9F6bXDo0Tniozwuzk82dLUZhUvXqyAc7kcwIrBmpwyzE460/FXY/w==
X-Received: by 2002:a17:90b:1bc7:b0:202:52ce:a1d with SMTP id oa7-20020a17090b1bc700b0020252ce0a1dmr23192138pjb.110.1662972667307;
        Mon, 12 Sep 2022 01:51:07 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:5362:9d7f:2354:1d0a:78e3])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902f54d00b00172897952a0sm5326699plf.283.2022.09.12.01.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 01:51:07 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, robh@kernel.org, andersson@kernel.org,
        rafael@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com
Subject: [PATCH 1/4] thermal: qcom: qmi_cooling: Add skeletal qmi cooling driver
Date:   Mon, 12 Sep 2022 14:20:46 +0530
Message-Id: <20220912085049.3517140-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220912085049.3517140-1-bhupesh.sharma@linaro.org>
References: <20220912085049.3517140-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a skeleton driver for supporting Qualcomm QMI thermal mitigation
(TMD) cooling devices.

The QMI TMD cooling devices are used for various mitigations for
remote subsystem(s) including remote processor mitigation, rail
voltage restriction etc. This driver uses kernel QMI interface
to send the message to remote subsystem(s).

Each child node of the QMI TMD devicetree node should represent
each remote subsystem and each child of this subsystem represents
separate cooling devices.

Cc: daniel.lezcano@linaro.org
Cc: rafael@kernel.org
Cc: andersson@kernel.org
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 .../qcom/qmi_cooling/qcom_qmi_cooling.c       | 632 ++++++++++++++++++
 .../qcom/qmi_cooling/qcom_tmd_services.c      | 352 ++++++++++
 .../qcom/qmi_cooling/qcom_tmd_services.h      | 120 ++++
 3 files changed, 1104 insertions(+)
 create mode 100644 drivers/thermal/qcom/qmi_cooling/qcom_qmi_cooling.c
 create mode 100644 drivers/thermal/qcom/qmi_cooling/qcom_tmd_services.c
 create mode 100644 drivers/thermal/qcom/qmi_cooling/qcom_tmd_services.h

diff --git a/drivers/thermal/qcom/qmi_cooling/qcom_qmi_cooling.c b/drivers/thermal/qcom/qmi_cooling/qcom_qmi_cooling.c
new file mode 100644
index 000000000000..4cb601533b9d
--- /dev/null
+++ b/drivers/thermal/qcom/qmi_cooling/qcom_qmi_cooling.c
@@ -0,0 +1,632 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022, Linaro Limited
+ */
+
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/net.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/remoteproc/qcom_rproc.h>
+#include <linux/slab.h>
+#include <linux/soc/qcom/qmi.h>
+#include <linux/thermal.h>
+
+#include "qcom_tmd_services.h"
+
+#define QMI_TMD_RESP_TIMEOUT		msecs_to_jiffies(100)
+#define QMI_CLIENT_NAME_LENGTH		40
+#define QMI_MAX_ALLOWED_INSTANCE_ID	0x80
+
+/**
+ * struct qmi_plat_data - qmi compile-time platform data
+ * @ninstances: Number of instances supported by platform
+ */
+struct qmi_plat_data {
+	const u32		ninstances;
+};
+
+struct qmi_cooling_device {
+	struct device_node		*np;
+	char				cdev_name[THERMAL_NAME_LENGTH];
+	char				qmi_name[QMI_CLIENT_NAME_LENGTH];
+	bool                            connection_active;
+	struct list_head		qmi_node;
+	struct thermal_cooling_device	*cdev;
+	unsigned int			mtgn_state;
+	unsigned int			max_level;
+	struct qmi_tmd_instance		*instance;
+};
+
+struct qmi_tmd_instance {
+	struct device			*dev;
+	struct qmi_handle		handle;
+	struct mutex			mutex;
+	u32				instance_id;
+	struct list_head		tmd_cdev_list;
+	struct work_struct		svc_arrive_work;
+};
+
+/**
+ * struct qmi_tmd_priv
+ * @dev: device.
+ * @instances: array of QMI TMD instances.
+ * @ninstances: number of QMI TMD instances.
+ */
+struct qmi_tmd_priv {
+	struct device			*dev;
+	struct qmi_tmd_instance		*instances;
+	u32				ninstances;
+};
+
+static char device_clients[][QMI_CLIENT_NAME_LENGTH] = {
+	{"pa"},
+	{"pa_fr1"},
+	{"cx_vdd_limit"},
+	{"modem"},
+	{"modem_current"},
+	{"modem_skin"},
+	{"modem_bw"},
+	{"modem_bw_backoff"},
+	{"vbatt_low"},
+	{"charge_state"},
+	{"mmw0"},
+	{"mmw1"},
+	{"mmw2"},
+	{"mmw3"},
+	{"mmw_skin0"},
+	{"mmw_skin1"},
+	{"mmw_skin2"},
+	{"mmw_skin3"},
+	{"wlan"},
+	{"wlan_bw"},
+	{"mmw_skin0_dsc"},
+	{"mmw_skin1_dsc"},
+	{"mmw_skin2_dsc"},
+	{"mmw_skin3_dsc"},
+	{"modem_skin_lte_dsc"},
+	{"modem_skin_nr_dsc"},
+	{"pa_dsc"},
+	{"pa_fr1_dsc"},
+	{"cdsp_sw"},
+	{"cdsp_hw"},
+	{"cpuv_restriction_cold"},
+	{"cpr_cold"},
+	{"modem_lte_dsc"},
+	{"modem_nr_dsc"},
+	{"modem_nr_scg_dsc"},
+	{"sdr0_lte_dsc"},
+	{"sdr1_lte_dsc"},
+	{"sdr0_nr_dsc"},
+	{"sdr1_nr_dsc"},
+	{"pa_lte_sdr0_dsc"},
+	{"pa_lte_sdr1_dsc"},
+	{"pa_nr_sdr0_dsc"},
+	{"pa_nr_sdr1_dsc"},
+	{"pa_nr_sdr0_scg_dsc"},
+	{"pa_nr_sdr1_scg_dsc"},
+	{"mmw0_dsc"},
+	{"mmw1_dsc"},
+	{"mmw2_dsc"},
+	{"mmw3_dsc"},
+	{"mmw_ific_dsc"},
+};
+
+static int qmi_get_max_state(struct thermal_cooling_device *cdev,
+				 unsigned long *state)
+{
+	struct qmi_cooling_device *qmi_cdev = cdev->devdata;
+
+	if (!qmi_cdev)
+		return -EINVAL;
+
+	*state = qmi_cdev->max_level;
+
+	return 0;
+}
+
+static int qmi_get_cur_state(struct thermal_cooling_device *cdev,
+				 unsigned long *state)
+{
+	struct qmi_cooling_device *qmi_cdev = cdev->devdata;
+
+	if (!qmi_cdev)
+		return -EINVAL;
+
+	*state = qmi_cdev->mtgn_state;
+
+	return 0;
+}
+
+static int qmi_tmd_send_state_request(struct qmi_cooling_device *qmi_cdev,
+				uint8_t state)
+{
+	int ret = 0;
+	struct tmd_set_mitigation_level_req_msg_v01 req;
+	struct tmd_set_mitigation_level_resp_msg_v01 tmd_resp;
+	struct qmi_tmd_instance *tmd_instance = qmi_cdev->instance;
+	struct qmi_txn txn;
+
+	memset(&req, 0, sizeof(req));
+	memset(&tmd_resp, 0, sizeof(tmd_resp));
+
+	strscpy(req.mitigation_dev_id.mitigation_dev_id, qmi_cdev->qmi_name,
+		QMI_TMD_MITIGATION_DEV_ID_LENGTH_MAX_V01);
+	req.mitigation_level = state;
+
+	mutex_lock(&tmd_instance->mutex);
+
+	ret = qmi_txn_init(&tmd_instance->handle, &txn,
+		tmd_set_mitigation_level_resp_msg_v01_ei, &tmd_resp);
+	if (ret < 0) {
+		pr_err("qmi set state:%d txn init failed for %s ret:%d\n",
+			state, qmi_cdev->cdev_name, ret);
+		goto qmi_send_exit;
+	}
+
+	ret = qmi_send_request(&tmd_instance->handle, NULL, &txn,
+			QMI_TMD_SET_MITIGATION_LEVEL_REQ_V01,
+			TMD_SET_MITIGATION_LEVEL_REQ_MSG_V01_MAX_MSG_LEN,
+			tmd_set_mitigation_level_req_msg_v01_ei, &req);
+	if (ret < 0) {
+		pr_err("qmi set state:%d txn send failed for %s ret:%d\n",
+			state, qmi_cdev->cdev_name, ret);
+		qmi_txn_cancel(&txn);
+		goto qmi_send_exit;
+	}
+
+	ret = qmi_txn_wait(&txn, QMI_TMD_RESP_TIMEOUT);
+	if (ret < 0) {
+		pr_err("qmi set state:%d txn wait failed for %s ret:%d\n",
+			state, qmi_cdev->cdev_name, ret);
+		goto qmi_send_exit;
+	}
+	if (tmd_resp.resp.result != QMI_RESULT_SUCCESS_V01) {
+		ret = tmd_resp.resp.result;
+		pr_err("qmi set state:%d NOT success for %s ret:%d\n",
+			state, qmi_cdev->cdev_name, ret);
+		goto qmi_send_exit;
+	}
+	ret = 0;
+	pr_debug("Requested qmi state:%d for %s\n", state, qmi_cdev->cdev_name);
+
+qmi_send_exit:
+	mutex_unlock(&tmd_instance->mutex);
+	return ret;
+}
+
+static int qmi_set_cur_state(struct thermal_cooling_device *cdev,
+				 unsigned long state)
+{
+	struct qmi_cooling_device *qmi_cdev = cdev->devdata;
+	int ret = 0;
+
+	if (!qmi_cdev)
+		return -EINVAL;
+
+	if (state > qmi_cdev->max_level)
+		return -EINVAL;
+
+	if (qmi_cdev->mtgn_state == state)
+		return 0;
+
+	/* save it and return if server exit */
+	if (!qmi_cdev->connection_active) {
+		qmi_cdev->mtgn_state = state;
+		pr_debug("Pending request:%ld for %s\n", state,
+				qmi_cdev->cdev_name);
+		return 0;
+	}
+
+	/* It is best effort to save state even if QMI fail */
+	ret = qmi_tmd_send_state_request(qmi_cdev, (uint8_t)state);
+
+	qmi_cdev->mtgn_state = state;
+
+	return ret;
+}
+
+static struct thermal_cooling_device_ops qmi_device_ops = {
+	.get_max_state = qmi_get_max_state,
+	.get_cur_state = qmi_get_cur_state,
+	.set_cur_state = qmi_set_cur_state,
+};
+
+static int qmi_register_cooling_device(struct qmi_cooling_device *qmi_cdev)
+{
+	qmi_cdev->cdev = thermal_of_cooling_device_register(
+					qmi_cdev->np,
+					qmi_cdev->cdev_name,
+					qmi_cdev,
+					&qmi_device_ops);
+	if (IS_ERR(qmi_cdev->cdev)) {
+		pr_err("Cooling register failed for %s, ret:%ld\n",
+			qmi_cdev->cdev_name, PTR_ERR(qmi_cdev->cdev));
+		return PTR_ERR(qmi_cdev->cdev);
+	}
+	pr_debug("Cooling register success for %s\n", qmi_cdev->cdev_name);
+
+	return 0;
+}
+
+static int verify_devices_and_register(struct qmi_tmd_instance *tmd_instance)
+{
+	struct tmd_get_mitigation_device_list_req_msg_v01 req;
+	struct tmd_get_mitigation_device_list_resp_msg_v01 *tmd_resp;
+	int ret = 0, i;
+	struct qmi_txn txn;
+
+	memset(&req, 0, sizeof(req));
+	/* size of tmd_resp is very high, use heap memory rather than stack */
+	tmd_resp = kzalloc(sizeof(*tmd_resp), GFP_KERNEL);
+	if (!tmd_resp)
+		return -ENOMEM;
+
+	mutex_lock(&tmd_instance->mutex);
+	ret = qmi_txn_init(&tmd_instance->handle, &txn,
+		tmd_get_mitigation_device_list_resp_msg_v01_ei, tmd_resp);
+	if (ret < 0) {
+		pr_err("Transaction Init error for instance_id:0x%x ret:%d\n",
+			tmd_instance->instance_id, ret);
+		goto reg_exit;
+	}
+
+	ret = qmi_send_request(&tmd_instance->handle, NULL, &txn,
+			QMI_TMD_GET_MITIGATION_DEVICE_LIST_REQ_V01,
+			TMD_GET_MITIGATION_DEVICE_LIST_REQ_MSG_V01_MAX_MSG_LEN,
+			tmd_get_mitigation_device_list_req_msg_v01_ei,
+			&req);
+	if (ret < 0) {
+		qmi_txn_cancel(&txn);
+		goto reg_exit;
+	}
+
+	ret = qmi_txn_wait(&txn, QMI_TMD_RESP_TIMEOUT);
+	if (ret < 0) {
+		pr_err("Transaction wait error for instance_id:0x%x ret:%d\n",
+			tmd_instance->instance_id, ret);
+		goto reg_exit;
+	}
+	if (tmd_resp->resp.result != QMI_RESULT_SUCCESS_V01) {
+		ret = tmd_resp->resp.result;
+		pr_err("Get device list NOT success for instance_id:0x%x ret:%d\n",
+			tmd_instance->instance_id, ret);
+		goto reg_exit;
+	}
+	mutex_unlock(&tmd_instance->mutex);
+
+	for (i = 0; i < tmd_resp->mitigation_device_list_len; i++) {
+		struct qmi_cooling_device *qmi_cdev = NULL;
+
+		list_for_each_entry(qmi_cdev, &tmd_instance->tmd_cdev_list,
+					qmi_node) {
+			struct tmd_mitigation_dev_list_type_v01 *device =
+				&tmd_resp->mitigation_device_list[i];
+
+			if ((strncasecmp(qmi_cdev->qmi_name,
+				device->mitigation_dev_id.mitigation_dev_id,
+				QMI_TMD_MITIGATION_DEV_ID_LENGTH_MAX_V01)))
+				continue;
+
+			qmi_cdev->connection_active = true;
+			qmi_cdev->max_level = device->max_mitigation_level;
+			/*
+			 * It is better to set current state
+			 * initially or during restart
+			 */
+			qmi_tmd_send_state_request(qmi_cdev,
+							qmi_cdev->mtgn_state);
+			if (!qmi_cdev->cdev)
+				ret = qmi_register_cooling_device(qmi_cdev);
+			break;
+		}
+	}
+
+	kfree(tmd_resp);
+	return ret;
+
+reg_exit:
+	mutex_unlock(&tmd_instance->mutex);
+	kfree(tmd_resp);
+
+	return ret;
+}
+
+static void qmi_tmd_svc_arrive(struct work_struct *work)
+{
+	struct qmi_tmd_instance *tmd_instance = container_of(work,
+						struct qmi_tmd_instance,
+						svc_arrive_work);
+
+	verify_devices_and_register(tmd_instance);
+}
+
+static void thermal_qmi_net_reset(struct qmi_handle *qmi)
+{
+	struct qmi_tmd_instance *tmd_instance = container_of(qmi,
+						struct qmi_tmd_instance,
+						handle);
+	struct qmi_cooling_device *qmi_cdev = NULL;
+
+	list_for_each_entry(qmi_cdev, &tmd_instance->tmd_cdev_list,
+					qmi_node) {
+		if (qmi_cdev->connection_active)
+			qmi_tmd_send_state_request(qmi_cdev,
+							qmi_cdev->mtgn_state);
+	}
+}
+
+static void thermal_qmi_del_server(struct qmi_handle *qmi,
+				    struct qmi_service *service)
+{
+	struct qmi_tmd_instance *tmd_instance = container_of(qmi,
+						struct qmi_tmd_instance,
+						handle);
+	struct qmi_cooling_device *qmi_cdev = NULL;
+
+	list_for_each_entry(qmi_cdev, &tmd_instance->tmd_cdev_list, qmi_node)
+		qmi_cdev->connection_active = false;
+}
+
+static int thermal_qmi_new_server(struct qmi_handle *qmi,
+				    struct qmi_service *service)
+{
+	struct qmi_tmd_instance *tmd_instance = container_of(qmi,
+						struct qmi_tmd_instance,
+						handle);
+	struct sockaddr_qrtr sq = {AF_QIPCRTR, service->node, service->port};
+
+	mutex_lock(&tmd_instance->mutex);
+	kernel_connect(qmi->sock, (struct sockaddr *)&sq, sizeof(sq), 0);
+	mutex_unlock(&tmd_instance->mutex);
+	queue_work(system_highpri_wq, &tmd_instance->svc_arrive_work);
+
+	return 0;
+}
+
+static struct qmi_ops thermal_qmi_event_ops = {
+	.new_server = thermal_qmi_new_server,
+	.del_server = thermal_qmi_del_server,
+	.net_reset = thermal_qmi_net_reset,
+};
+
+static void qmi_tmd_cleanup(struct qmi_tmd_priv *priv)
+{
+	int i;
+	struct qmi_tmd_instance *tmd_instance = priv->instances;
+	struct qmi_cooling_device *qmi_cdev, *c_next;
+
+	for (i = 0; i < priv->ninstances; i++) {
+		mutex_lock(&tmd_instance[i].mutex);
+		list_for_each_entry_safe(qmi_cdev, c_next,
+				&tmd_instance[i].tmd_cdev_list, qmi_node) {
+			qmi_cdev->connection_active = false;
+			if (qmi_cdev->cdev)
+				thermal_cooling_device_unregister(
+					qmi_cdev->cdev);
+
+			list_del(&qmi_cdev->qmi_node);
+		}
+		qmi_handle_release(&tmd_instance[i].handle);
+
+		mutex_unlock(&tmd_instance[i].mutex);
+	}
+}
+
+static int qmi_get_dt_instance_data(struct qmi_tmd_priv *priv,
+				    struct qmi_tmd_instance *instance,
+				    struct device_node *node)
+{
+	struct device *dev = priv->dev;
+	struct qmi_cooling_device *qmi_cdev;
+	struct device_node *subnode;
+	int ret, i;
+	u32 instance_id;
+
+	ret = of_property_read_u32(node, "qcom,instance-id", &instance_id);
+	if (ret) {
+		dev_err(dev, "error reading qcom,instance-id (%d)\n",
+				ret);
+		return ret;
+	}
+
+	if (instance_id >= QMI_MAX_ALLOWED_INSTANCE_ID) {
+		dev_err(dev, "Instance ID exceeds max allowed value (%d)\n", instance_id);
+		return -EINVAL;
+	}
+
+	instance->instance_id = instance_id;
+
+	instance->dev = dev;
+	mutex_init(&instance->mutex);
+	INIT_LIST_HEAD(&instance->tmd_cdev_list);
+	INIT_WORK(&instance->svc_arrive_work, qmi_tmd_svc_arrive);
+
+	for_each_available_child_of_node(node, subnode) {
+		const char *qmi_name;
+
+		qmi_cdev = devm_kzalloc(dev, sizeof(*qmi_cdev),
+				GFP_KERNEL);
+		if (!qmi_cdev) {
+			ret = -ENOMEM;
+			goto data_error;
+		}
+
+		strscpy(qmi_cdev->cdev_name, subnode->name,
+				THERMAL_NAME_LENGTH);
+
+		if (!of_property_read_string(subnode,
+					"label",
+					&qmi_name)) {
+			strscpy(qmi_cdev->qmi_name, qmi_name,
+					QMI_CLIENT_NAME_LENGTH);
+		} else {
+			dev_err(dev, "Fail to parse dev name for %s\n",
+					subnode->name);
+			of_node_put(subnode);
+			break;
+		}
+
+		/* Check for supported qmi dev */
+		for (i = 0; i < ARRAY_SIZE(device_clients); i++) {
+			if (strcmp(device_clients[i],
+						qmi_cdev->qmi_name) == 0)
+				break;
+		}
+
+		if (i >= ARRAY_SIZE(device_clients)) {
+			dev_err(dev, "Not supported dev name for %s\n",
+					subnode->name);
+			of_node_put(subnode);
+			break;
+		}
+		qmi_cdev->instance = instance;
+		qmi_cdev->np = subnode;
+		qmi_cdev->mtgn_state = 0;
+		list_add(&qmi_cdev->qmi_node, &instance->tmd_cdev_list);
+	}
+
+	of_node_put(node);
+
+	return 0;
+data_error:
+	of_node_put(subnode);
+
+	return ret;
+}
+
+static int qmi_tmd_device_init(struct qmi_tmd_priv *priv)
+{
+	int i, ret;
+	u32 ninstances = priv->ninstances;
+
+	for (i = 0; i < ninstances; i++) {
+		struct qmi_tmd_instance *tmd_instance = &priv->instances[i];
+
+		if (list_empty(&tmd_instance->tmd_cdev_list))
+			continue;
+
+		ret = qmi_handle_init(&tmd_instance->handle,
+			TMD_GET_MITIGATION_DEVICE_LIST_RESP_MSG_V01_MAX_MSG_LEN,
+			&thermal_qmi_event_ops, NULL);
+		if (ret < 0) {
+			dev_err(priv->dev, "QMI[0x%x] handle init failed. err:%d\n",
+					tmd_instance->instance_id, ret);
+			priv->ninstances = i;
+			return ret;
+		}
+
+		ret = qmi_add_lookup(&tmd_instance->handle, TMD_SERVICE_ID_V01,
+					TMD_SERVICE_VERS_V01,
+					tmd_instance->instance_id);
+		if (ret < 0) {
+			dev_err(priv->dev, "QMI register failed for 0x%x, ret:%d\n",
+				tmd_instance->instance_id, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static const struct of_device_id qmi_tmd_device_table[] = {
+	{.compatible = "qcom,qmi-tmd-devices"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, qmi_tmd_device_table);
+
+static int qmi_tmd_device_probe(struct platform_device *pdev)
+{
+	struct device *dev;
+	struct device_node *np;
+	struct device_node *child;
+	struct qmi_tmd_instance *instances;
+	const struct qmi_plat_data *data;
+	const struct of_device_id *id;
+	struct qmi_tmd_priv *priv;
+	int ret;
+	u32 ninstances;
+
+	if (pdev->dev.of_node)
+		dev = &pdev->dev;
+	else
+		dev = pdev->dev.parent;
+
+	np = dev->of_node;
+
+	id = of_match_node(qmi_tmd_device_table, np);
+	if (!id)
+		return -ENODEV;
+
+	data = id->data;
+
+	if (np)
+		ninstances = of_get_available_child_count(np);
+
+	if (ninstances <= 0) {
+		dev_err(dev, "No instances to process\n");
+		return -EINVAL;
+	}
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	priv->ninstances = ninstances;
+
+	priv->instances = devm_kcalloc(dev, priv->ninstances,
+					sizeof(*priv->instances), GFP_KERNEL);
+	if (!priv->instances)
+		return -ENOMEM;
+
+	instances = priv->instances;
+
+	for_each_available_child_of_node(np, child) {
+		ret = qmi_get_dt_instance_data(priv, instances, child);
+		if (ret) {
+			of_node_put(child);
+			return ret;
+		}
+
+		instances++;
+	}
+
+	platform_set_drvdata(pdev, priv);
+
+	ret = qmi_tmd_device_init(priv);
+	if (ret)
+		goto probe_err;
+
+	dev_dbg(dev, "QMI Thermal Mitigation Device driver probe success!\n");
+	return 0;
+
+probe_err:
+	qmi_tmd_cleanup(priv);
+	return ret;
+}
+
+static int qmi_tmd_device_remove(struct platform_device *pdev)
+{
+	struct qmi_tmd_priv *priv = platform_get_drvdata(pdev);
+
+	qmi_tmd_cleanup(priv);
+
+	return 0;
+}
+
+static struct platform_driver qmi_tmd_device_driver = {
+	.probe          = qmi_tmd_device_probe,
+	.remove         = qmi_tmd_device_remove,
+	.driver         = {
+		.name   = "qcom-qmi-tmd-devices",
+		.of_match_table = qmi_tmd_device_table,
+	},
+};
+
+module_platform_driver(qmi_tmd_device_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Qualcomm QMI Thermal Mitigation Device driver");
+MODULE_ALIAS("platform:qcom-qmi-tmd-devices");
diff --git a/drivers/thermal/qcom/qmi_cooling/qcom_tmd_services.c b/drivers/thermal/qcom/qmi_cooling/qcom_tmd_services.c
new file mode 100644
index 000000000000..5b950b8952f0
--- /dev/null
+++ b/drivers/thermal/qcom/qmi_cooling/qcom_tmd_services.c
@@ -0,0 +1,352 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022, Linaro Limited
+ */
+
+#include <linux/soc/qcom/qmi.h>
+
+#include "qcom_tmd_services.h"
+
+static struct qmi_elem_info tmd_mitigation_dev_id_type_v01_ei[] = {
+	{
+		.data_type      = QMI_STRING,
+		.elem_len       = QMI_TMD_MITIGATION_DEV_ID_LENGTH_MAX_V01 + 1,
+		.elem_size      = sizeof(char),
+		.array_type     = NO_ARRAY,
+		.tlv_type       = 0,
+		.offset         = offsetof(
+					struct tmd_mitigation_dev_id_type_v01,
+					mitigation_dev_id),
+	},
+	{
+		.data_type      = QMI_EOTI,
+		.array_type     = NO_ARRAY,
+		.tlv_type       = QMI_COMMON_TLV_TYPE,
+	},
+};
+
+static struct qmi_elem_info tmd_mitigation_dev_list_type_v01_ei[] = {
+	{
+		.data_type      = QMI_STRUCT,
+		.elem_len       = 1,
+		.elem_size      = sizeof(struct tmd_mitigation_dev_id_type_v01),
+		.array_type       = NO_ARRAY,
+		.tlv_type       = 0,
+		.offset         = offsetof(
+					struct tmd_mitigation_dev_list_type_v01,
+					mitigation_dev_id),
+		.ei_array      = tmd_mitigation_dev_id_type_v01_ei,
+	},
+	{
+		.data_type      = QMI_UNSIGNED_1_BYTE,
+		.elem_len       = 1,
+		.elem_size      = sizeof(uint8_t),
+		.array_type     = NO_ARRAY,
+		.tlv_type       = 0,
+		.offset         = offsetof(
+					struct tmd_mitigation_dev_list_type_v01,
+					max_mitigation_level),
+	},
+	{
+		.data_type      = QMI_EOTI,
+		.array_type     = NO_ARRAY,
+		.tlv_type       = QMI_COMMON_TLV_TYPE,
+	},
+};
+
+struct qmi_elem_info tmd_get_mitigation_device_list_req_msg_v01_ei[] = {
+	{
+		.data_type      = QMI_EOTI,
+		.array_type     = NO_ARRAY,
+		.tlv_type       = QMI_COMMON_TLV_TYPE,
+	},
+};
+
+struct qmi_elem_info tmd_get_mitigation_device_list_resp_msg_v01_ei[] = {
+	{
+		.data_type      = QMI_STRUCT,
+		.elem_len       = 1,
+		.elem_size      = sizeof(struct qmi_response_type_v01),
+		.array_type       = NO_ARRAY,
+		.tlv_type       = 0x02,
+		.offset         = offsetof(
+			struct tmd_get_mitigation_device_list_resp_msg_v01,
+			resp),
+		.ei_array      = qmi_response_type_v01_ei,
+	},
+	{
+		.data_type      = QMI_OPT_FLAG,
+		.elem_len       = 1,
+		.elem_size      = sizeof(uint8_t),
+		.array_type     = NO_ARRAY,
+		.tlv_type       = 0x10,
+		.offset         = offsetof(
+			struct tmd_get_mitigation_device_list_resp_msg_v01,
+				mitigation_device_list_valid),
+	},
+	{
+		.data_type      = QMI_DATA_LEN,
+		.elem_len       = 1,
+		.elem_size      = sizeof(uint8_t),
+		.array_type     = NO_ARRAY,
+		.tlv_type       = 0x10,
+		.offset         = offsetof(
+			struct tmd_get_mitigation_device_list_resp_msg_v01,
+				mitigation_device_list_len),
+	},
+	{
+		.data_type      = QMI_STRUCT,
+		.elem_len       = QMI_TMD_MITIGATION_DEV_LIST_MAX_V01,
+		.elem_size      = sizeof(
+				struct tmd_mitigation_dev_list_type_v01),
+		.array_type       = VAR_LEN_ARRAY,
+		.tlv_type       = 0x10,
+		.offset         = offsetof(
+			struct tmd_get_mitigation_device_list_resp_msg_v01,
+				mitigation_device_list),
+		.ei_array      = tmd_mitigation_dev_list_type_v01_ei,
+	},
+	{
+		.data_type      = QMI_EOTI,
+		.array_type     = NO_ARRAY,
+		.tlv_type       = QMI_COMMON_TLV_TYPE,
+	},
+};
+
+struct qmi_elem_info tmd_set_mitigation_level_req_msg_v01_ei[] = {
+	{
+		.data_type      = QMI_STRUCT,
+		.elem_len       = 1,
+		.elem_size      = sizeof(struct tmd_mitigation_dev_id_type_v01),
+		.array_type     = NO_ARRAY,
+		.tlv_type       = 0x01,
+		.offset         = offsetof(
+				struct tmd_set_mitigation_level_req_msg_v01,
+					mitigation_dev_id),
+		.ei_array      = tmd_mitigation_dev_id_type_v01_ei,
+	},
+	{
+		.data_type      = QMI_UNSIGNED_1_BYTE,
+		.elem_len       = 1,
+		.elem_size      = sizeof(uint8_t),
+		.array_type     = NO_ARRAY,
+		.tlv_type       = 0x02,
+		.offset         = offsetof(
+				struct tmd_set_mitigation_level_req_msg_v01,
+					mitigation_level),
+	},
+	{
+		.data_type      = QMI_EOTI,
+		.array_type     = NO_ARRAY,
+		.tlv_type       = QMI_COMMON_TLV_TYPE,
+	},
+};
+
+struct qmi_elem_info tmd_set_mitigation_level_resp_msg_v01_ei[] = {
+	{
+		.data_type      = QMI_STRUCT,
+		.elem_len       = 1,
+		.elem_size      = sizeof(struct qmi_response_type_v01),
+		.array_type     = NO_ARRAY,
+		.tlv_type       = 0x02,
+		.offset         = offsetof(
+			struct tmd_set_mitigation_level_resp_msg_v01,
+				resp),
+		.ei_array      = qmi_response_type_v01_ei,
+	},
+	{
+		.data_type      = QMI_EOTI,
+		.array_type     = NO_ARRAY,
+		.tlv_type       = QMI_COMMON_TLV_TYPE,
+	},
+};
+
+struct qmi_elem_info tmd_get_mitigation_level_req_msg_v01_ei[] = {
+	{
+		.data_type      = QMI_STRUCT,
+		.elem_len       = 1,
+		.elem_size      = sizeof(struct tmd_mitigation_dev_id_type_v01),
+		.array_type     = NO_ARRAY,
+		.tlv_type       = 0x01,
+		.offset         = offsetof(
+				struct tmd_get_mitigation_level_req_msg_v01,
+					mitigation_device),
+		.ei_array      = tmd_mitigation_dev_id_type_v01_ei,
+	},
+	{
+		.data_type      = QMI_EOTI,
+		.array_type     = NO_ARRAY,
+		.tlv_type       = QMI_COMMON_TLV_TYPE,
+	},
+};
+
+struct qmi_elem_info tmd_get_mitigation_level_resp_msg_ei[] = {
+	{
+		.data_type      = QMI_STRUCT,
+		.elem_len       = 1,
+		.elem_size      = sizeof(struct qmi_response_type_v01),
+		.array_type     = NO_ARRAY,
+		.tlv_type       = 0x02,
+		.offset         = offsetof(
+				struct tmd_get_mitigation_level_resp_msg_v01,
+					resp),
+		.ei_array      = qmi_response_type_v01_ei,
+	},
+	{
+		.data_type      = QMI_OPT_FLAG,
+		.elem_len       = 1,
+		.elem_size      = sizeof(uint8_t),
+		.array_type     = NO_ARRAY,
+		.tlv_type       = 0x10,
+		.offset         = offsetof(
+				struct tmd_get_mitigation_level_resp_msg_v01,
+					current_mitigation_level_valid),
+	},
+	{
+		.data_type      = QMI_UNSIGNED_1_BYTE,
+		.elem_len       = 1,
+		.elem_size      = sizeof(uint8_t),
+		.array_type     = NO_ARRAY,
+		.tlv_type       = 0x10,
+		.offset         = offsetof(
+				struct tmd_get_mitigation_level_resp_msg_v01,
+					current_mitigation_level),
+	},
+	{
+		.data_type      = QMI_OPT_FLAG,
+		.elem_len       = 1,
+		.elem_size      = sizeof(uint8_t),
+		.array_type     = NO_ARRAY,
+		.tlv_type       = 0x11,
+		.offset         = offsetof(
+				struct tmd_get_mitigation_level_resp_msg_v01,
+					requested_mitigation_level_valid),
+	},
+	{
+		.data_type      = QMI_UNSIGNED_1_BYTE,
+		.elem_len       = 1,
+		.elem_size      = sizeof(uint8_t),
+		.array_type     = NO_ARRAY,
+		.tlv_type       = 0x11,
+		.offset         = offsetof(
+				struct tmd_get_mitigation_level_resp_msg_v01,
+					requested_mitigation_level),
+	},
+	{
+		.data_type      = QMI_EOTI,
+		.array_type     = NO_ARRAY,
+		.tlv_type       = QMI_COMMON_TLV_TYPE,
+	},
+};
+
+struct qmi_elem_info
+	tmd_register_notification_mitigation_level_req_msg_v01_ei[] = {
+	{
+		.data_type      = QMI_STRUCT,
+		.elem_len       = 1,
+		.elem_size      = sizeof(struct tmd_mitigation_dev_id_type_v01),
+		.array_type     = NO_ARRAY,
+		.tlv_type       = 0x01,
+		.offset         = offsetof(
+		struct tmd_register_notification_mitigation_level_req_msg_v01,
+				mitigation_device),
+		.ei_array      = tmd_mitigation_dev_id_type_v01_ei,
+	},
+	{
+		.data_type      = QMI_EOTI,
+		.array_type     = NO_ARRAY,
+		.tlv_type       = QMI_COMMON_TLV_TYPE,
+	},
+};
+
+struct qmi_elem_info
+	tmd_register_notification_mitigation_level_resp_msg_v01_ei[]
+									= {
+	{
+		.data_type      = QMI_STRUCT,
+		.elem_len       = 1,
+		.elem_size      = sizeof(struct qmi_response_type_v01),
+		.array_type     = NO_ARRAY,
+		.tlv_type       = 0x02,
+		.offset         = offsetof(
+		struct tmd_register_notification_mitigation_level_resp_msg_v01,
+				resp),
+		.ei_array      = qmi_response_type_v01_ei,
+	},
+	{
+		.data_type      = QMI_EOTI,
+		.array_type     = NO_ARRAY,
+		.tlv_type       = QMI_COMMON_TLV_TYPE,
+	},
+};
+
+struct qmi_elem_info
+	tmd_deregister_notification_mitigation_level_req_msg_v01_ei[]
+									= {
+	{
+		.data_type      = QMI_STRUCT,
+		.elem_len       = 1,
+		.elem_size      = sizeof(struct tmd_mitigation_dev_id_type_v01),
+		.array_type     = NO_ARRAY,
+		.tlv_type       = 0x01,
+		.offset         = offsetof(struct
+		tmd_deregister_notification_mitigation_level_req_msg_v01,
+				mitigation_device),
+		.ei_array      = tmd_mitigation_dev_id_type_v01_ei,
+	},
+	{
+		.data_type      = QMI_EOTI,
+		.array_type     = NO_ARRAY,
+		.tlv_type       = QMI_COMMON_TLV_TYPE,
+	},
+};
+
+struct qmi_elem_info
+	tmd_deregister_notification_mitigation_level_resp_msg_v01_ei[]
+									= {
+	{
+		.data_type      = QMI_STRUCT,
+		.elem_len       = 1,
+		.elem_size      = sizeof(struct qmi_response_type_v01),
+		.array_type     = NO_ARRAY,
+		.tlv_type       = 0x02,
+		.offset         = offsetof(struct
+		tmd_deregister_notification_mitigation_level_resp_msg_v01,
+					   resp),
+		.ei_array      = qmi_response_type_v01_ei,
+	},
+	{
+		.data_type      = QMI_EOTI,
+		.array_type     = NO_ARRAY,
+		.tlv_type       = QMI_COMMON_TLV_TYPE,
+	},
+};
+
+struct qmi_elem_info tmd_mitigation_level_report_ind_msg_v01_ei[] = {
+	{
+		.data_type      = QMI_STRUCT,
+		.elem_len       = 1,
+		.elem_size      = sizeof(struct tmd_mitigation_dev_id_type_v01),
+		.array_type     = NO_ARRAY,
+		.tlv_type       = 0x01,
+		.offset         = offsetof(
+				struct tmd_mitigation_level_report_ind_msg_v01,
+					mitigation_device),
+		.ei_array      = tmd_mitigation_dev_id_type_v01_ei,
+	},
+	{
+		.data_type      = QMI_UNSIGNED_1_BYTE,
+		.elem_len       = 1,
+		.elem_size      = sizeof(uint8_t),
+		.array_type     = NO_ARRAY,
+		.tlv_type       = 0x02,
+		.offset         = offsetof(
+				struct tmd_mitigation_level_report_ind_msg_v01,
+					   current_mitigation_level),
+	},
+	{
+		.data_type      = QMI_EOTI,
+		.array_type     = NO_ARRAY,
+		.tlv_type       = QMI_COMMON_TLV_TYPE,
+	},
+};
diff --git a/drivers/thermal/qcom/qmi_cooling/qcom_tmd_services.h b/drivers/thermal/qcom/qmi_cooling/qcom_tmd_services.h
new file mode 100644
index 000000000000..8af0bfd7eb48
--- /dev/null
+++ b/drivers/thermal/qcom/qmi_cooling/qcom_tmd_services.h
@@ -0,0 +1,120 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022, Linaro Limited
+ */
+
+#ifndef __QCOM_TMD_SERVICES_H
+#define __QCOM_TMD_SERVICES_H
+
+#define TMD_SERVICE_ID_V01 0x18
+#define TMD_SERVICE_VERS_V01 0x01
+
+#define QMI_TMD_GET_MITIGATION_DEVICE_LIST_RESP_V01	0x0020
+#define QMI_TMD_GET_MITIGATION_LEVEL_REQ_V01		0x0022
+#define QMI_TMD_GET_SUPPORTED_MSGS_REQ_V01		0x001E
+#define QMI_TMD_SET_MITIGATION_LEVEL_REQ_V01		0x0021
+#define QMI_TMD_REGISTER_NOTIFICATION_MITIGATION_LEVEL_RESP_V01		0x0023
+#define QMI_TMD_GET_SUPPORTED_MSGS_RESP_V01				0x001E
+#define QMI_TMD_SET_MITIGATION_LEVEL_RESP_V01				0x0021
+#define QMI_TMD_DEREGISTER_NOTIFICATION_MITIGATION_LEVEL_RESP_V01	0x0024
+#define QMI_TMD_MITIGATION_LEVEL_REPORT_IND_V01				0x0025
+#define QMI_TMD_GET_MITIGATION_LEVEL_RESP_V01				0x0022
+#define QMI_TMD_GET_SUPPORTED_FIELDS_REQ_V01				0x001F
+#define QMI_TMD_GET_MITIGATION_DEVICE_LIST_REQ_V01			0x0020
+#define QMI_TMD_REGISTER_NOTIFICATION_MITIGATION_LEVEL_REQ_V01		0x0023
+#define QMI_TMD_DEREGISTER_NOTIFICATION_MITIGATION_LEVEL_REQ_V01	0x0024
+#define QMI_TMD_GET_SUPPORTED_FIELDS_RESP_V01				0x001F
+
+#define QMI_TMD_MITIGATION_DEV_ID_LENGTH_MAX_V01	32
+#define QMI_TMD_MITIGATION_DEV_LIST_MAX_V01		32
+
+struct tmd_mitigation_dev_id_type_v01 {
+	char mitigation_dev_id[QMI_TMD_MITIGATION_DEV_ID_LENGTH_MAX_V01 + 1];
+};
+
+struct tmd_mitigation_dev_list_type_v01 {
+	struct tmd_mitigation_dev_id_type_v01 mitigation_dev_id;
+	uint8_t max_mitigation_level;
+};
+
+struct tmd_get_mitigation_device_list_req_msg_v01 {
+	char placeholder;
+};
+#define TMD_GET_MITIGATION_DEVICE_LIST_REQ_MSG_V01_MAX_MSG_LEN	0
+extern struct qmi_elem_info tmd_get_mitigation_device_list_req_msg_v01_ei[];
+
+struct tmd_get_mitigation_device_list_resp_msg_v01 {
+	struct qmi_response_type_v01 resp;
+	uint8_t mitigation_device_list_valid;
+	uint32_t mitigation_device_list_len;
+	struct tmd_mitigation_dev_list_type_v01
+		mitigation_device_list[QMI_TMD_MITIGATION_DEV_LIST_MAX_V01];
+};
+#define TMD_GET_MITIGATION_DEVICE_LIST_RESP_MSG_V01_MAX_MSG_LEN	1099
+extern struct qmi_elem_info tmd_get_mitigation_device_list_resp_msg_v01_ei[];
+
+struct tmd_set_mitigation_level_req_msg_v01 {
+	struct tmd_mitigation_dev_id_type_v01 mitigation_dev_id;
+	uint8_t mitigation_level;
+};
+#define TMD_SET_MITIGATION_LEVEL_REQ_MSG_V01_MAX_MSG_LEN	40
+extern struct qmi_elem_info tmd_set_mitigation_level_req_msg_v01_ei[];
+
+struct tmd_set_mitigation_level_resp_msg_v01 {
+	struct qmi_response_type_v01 resp;
+};
+#define TMD_SET_MITIGATION_LEVEL_RESP_MSG_V01_MAX_MSG_LEN	7
+extern struct qmi_elem_info tmd_set_mitigation_level_resp_msg_v01_ei[];
+
+struct tmd_get_mitigation_level_req_msg_v01 {
+	struct tmd_mitigation_dev_id_type_v01 mitigation_device;
+};
+#define TMD_GET_MITIGATION_LEVEL_REQ_MSG_V01_MAX_MSG_LEN	36
+extern struct qmi_elem_info tmd_get_mitigation_level_req_msg_v01_ei[];
+
+struct tmd_get_mitigation_level_resp_msg_v01 {
+	struct qmi_response_type_v01 resp;
+	uint8_t current_mitigation_level_valid;
+	uint8_t current_mitigation_level;
+	uint8_t requested_mitigation_level_valid;
+	uint8_t requested_mitigation_level;
+};
+#define TMD_GET_MITIGATION_LEVEL_RESP_MSG_V01_MAX_MSG_LEN	15
+extern struct qmi_elem_info tmd_get_mitigation_level_resp_msg_v01_ei[];
+
+struct tmd_register_notification_mitigation_level_req_msg_v01 {
+	struct tmd_mitigation_dev_id_type_v01 mitigation_device;
+};
+#define TMD_REGISTER_NOTIFICATION_MITIGATION_LEVEL_REQ_MSG_V01_MAX_MSG_LEN	36
+extern struct qmi_elem_info
+		tmd_register_notification_mitigation_level_req_msg_v01_ei[];
+
+struct tmd_register_notification_mitigation_level_resp_msg_v01 {
+	struct qmi_response_type_v01 resp;
+};
+#define TMD_REGISTER_NOTIFICATION_MITIGATION_LEVEL_RESP_MSG_V01_MAX_MSG_LEN	7
+extern struct qmi_elem_info
+	tmd_register_notification_mitigation_level_resp_msg_v01_ei[];
+
+struct tmd_deregister_notification_mitigation_level_req_msg_v01 {
+	struct tmd_mitigation_dev_id_type_v01 mitigation_device;
+};
+#define TMD_DEREGISTER_NOTIFICATION_MITIGATION_LEVEL_REQ_MSG_V01_MAX_MSG_LEN	36
+extern struct qmi_elem_info
+	tmd_deregister_notification_mitigation_level_req_msg_v01_ei[];
+
+struct tmd_deregister_notification_mitigation_level_resp_msg_v01 {
+	struct qmi_response_type_v01 resp;
+};
+#define TMD_DEREGISTER_NOTIFICATION_MITIGATION_LEVEL_RESP_MSG_V01_MAX_MSG_LEN	7
+extern struct qmi_elem_info
+	tmd_deregister_notification_mitigation_level_resp_msg_v01_ei[];
+
+struct tmd_mitigation_level_report_ind_msg_v01 {
+	struct tmd_mitigation_dev_id_type_v01 mitigation_device;
+	uint8_t current_mitigation_level;
+};
+#define TMD_MITIGATION_LEVEL_REPORT_IND_MSG_V01_MAX_MSG_LEN			40
+extern struct qmi_elem_info tmd_mitigation_level_report_ind_msg_v01_ei[];
+
+#endif
-- 
2.37.1

