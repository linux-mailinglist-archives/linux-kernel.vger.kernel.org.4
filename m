Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19034685E57
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 05:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjBAETT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 23:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjBAETH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 23:19:07 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F4353B12;
        Tue, 31 Jan 2023 20:19:05 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3110PsUW011612;
        Wed, 1 Feb 2023 04:19:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=VAwge3hX26fQLlflh2n1cJCMU9jEDXKbyEpKi/Au65U=;
 b=JfH8DyDU4XWVlJ6+TmR3SIIGb3ESh4lYeogTrqxK5K8TlXMGyJ710u97NNZnxOZEtLww
 YkLhe216XPCZ2Dg0aJA/UwroCV5m1VAeZLWUMN1UD97cXJYGIaPcHkO8pLhNHP8Y8c51
 yOAQa4Yd4EGp5DvFpZDrw85IP1ErigBlAQ/2imYtUJgsurYr8EjvfrgyPY03JBPpxEKK
 LpebvN1lOmpNy8V1VibxVKyfXPAetr4Y8SJWHvfnzJPZfhvS0oM1Trzrh6oHZWq7AC+h
 +D7a/Kr4yPYDxJ/UlWYS630agTAQq1ki5Z3yXCSt66Va0BwD9i1reNY7/a6ORBxvKCK0 dQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nfbyq0mxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 04:19:00 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3114IxGN004533
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Feb 2023 04:18:59 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 31 Jan 2023 20:18:59 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        "Subbaraman Narayanamurthy" <quic_subbaram@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v4 2/4] soc: qcom: pmic_glink: Introduce base PMIC GLINK driver
Date:   Tue, 31 Jan 2023 20:18:51 -0800
Message-ID: <20230201041853.1934355-3-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230201041853.1934355-1-quic_bjorande@quicinc.com>
References: <20230201041853.1934355-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Q8ILBQgvvOKt6Ue4FPy5ry5WfazL2vip
X-Proofpoint-GUID: Q8ILBQgvvOKt6Ue4FPy5ry5WfazL2vip
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302010035
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

The PMIC GLINK service runs on one of the co-processors of some modern
Qualcomm platforms and implements USB-C and battery managements. It uses
a message based protocol over GLINK for communication with the OS, hence
the name.

The driver implemented provides the rpmsg device for communication and
uses auxiliary bus to spawn off individual devices in respective
subsystem. The auxiliary devices are spawned off from a
platform_device, so that the drm_bridge is available early, to allow the
DisplayPort driver to probe even before the remoteproc has spun up.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org> # SM8350 PDX215
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-MTP & SM8450-HDK
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---

Changes since v3:
- None

 drivers/soc/qcom/Kconfig            |  15 ++
 drivers/soc/qcom/Makefile           |   1 +
 drivers/soc/qcom/pmic_glink.c       | 336 ++++++++++++++++++++++++++++
 include/linux/soc/qcom/pmic_glink.h |  32 +++
 4 files changed, 384 insertions(+)
 create mode 100644 drivers/soc/qcom/pmic_glink.c
 create mode 100644 include/linux/soc/qcom/pmic_glink.h

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 21c4ce2315ba..3f2b51905e23 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -100,6 +100,21 @@ config QCOM_PDR_HELPERS
 	tristate
 	select QCOM_QMI_HELPERS
 
+config QCOM_PMIC_GLINK
+	tristate "Qualcomm PMIC GLINK driver"
+	depends on RPMSG
+	depends on TYPEC
+	depends on DRM
+	select AUXILIARY_BUS
+	select QCOM_PDR_HELPERS
+	help
+	  The Qualcomm PMIC GLINK driver provides access, over GLINK, to the
+	  USB and battery firmware running on one of the coprocessors in
+	  several modern Qualcomm platforms.
+
+	  Say yes here to support USB-C and battery status on modern Qualcomm
+	  platforms.
+
 config QCOM_QMI_HELPERS
 	tristate
 	depends on NET
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 3b92c6c8e0ec..29cccac472f3 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_QCOM_GSBI)	+=	qcom_gsbi.o
 obj-$(CONFIG_QCOM_MDT_LOADER)	+= mdt_loader.o
 obj-$(CONFIG_QCOM_OCMEM)	+= ocmem.o
 obj-$(CONFIG_QCOM_PDR_HELPERS)	+= pdr_interface.o
+obj-$(CONFIG_QCOM_PMIC_GLINK)	+= pmic_glink.o
 obj-$(CONFIG_QCOM_QMI_HELPERS)	+= qmi_helpers.o
 qmi_helpers-y	+= qmi_encdec.o qmi_interface.o
 obj-$(CONFIG_QCOM_RAMP_CTRL)	+= ramp_controller.o
diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
new file mode 100644
index 000000000000..bb3fb57abcc6
--- /dev/null
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -0,0 +1,336 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Linaro Ltd
+ */
+#include <linux/auxiliary_bus.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/rpmsg.h>
+#include <linux/slab.h>
+#include <linux/soc/qcom/pdr.h>
+#include <linux/soc/qcom/pmic_glink.h>
+
+struct pmic_glink {
+	struct device *dev;
+	struct pdr_handle *pdr;
+
+	struct rpmsg_endpoint *ept;
+
+	struct auxiliary_device altmode_aux;
+	struct auxiliary_device ps_aux;
+	struct auxiliary_device ucsi_aux;
+
+	/* serializing client_state and pdr_state updates */
+	struct mutex state_lock;
+	unsigned int client_state;
+	unsigned int pdr_state;
+
+	/* serializing clients list updates */
+	struct mutex client_lock;
+	struct list_head clients;
+};
+
+static struct pmic_glink *__pmic_glink;
+static DEFINE_MUTEX(__pmic_glink_lock);
+
+struct pmic_glink_client {
+	struct list_head node;
+
+	struct pmic_glink *pg;
+	unsigned int id;
+
+	void (*cb)(const void *data, size_t len, void *priv);
+	void (*pdr_notify)(void *priv, int state);
+	void *priv;
+};
+
+static void _devm_pmic_glink_release_client(struct device *dev, void *res)
+{
+	struct pmic_glink_client *client = (struct pmic_glink_client *)res;
+	struct pmic_glink *pg = client->pg;
+
+	mutex_lock(&pg->client_lock);
+	list_del(&client->node);
+	mutex_unlock(&pg->client_lock);
+}
+
+struct pmic_glink_client *devm_pmic_glink_register_client(struct device *dev,
+							  unsigned int id,
+							  void (*cb)(const void *, size_t, void *),
+							  void (*pdr)(void *, int),
+							  void *priv)
+{
+	struct pmic_glink_client *client;
+	struct pmic_glink *pg = dev_get_drvdata(dev->parent);
+
+	client = devres_alloc(_devm_pmic_glink_release_client, sizeof(*client), GFP_KERNEL);
+	if (!client)
+		return ERR_PTR(-ENOMEM);
+
+	client->pg = pg;
+	client->id = id;
+	client->cb = cb;
+	client->pdr_notify = pdr;
+	client->priv = priv;
+
+	mutex_lock(&pg->client_lock);
+	list_add(&client->node, &pg->clients);
+	mutex_unlock(&pg->client_lock);
+
+	devres_add(dev, client);
+
+	return client;
+}
+EXPORT_SYMBOL_GPL(devm_pmic_glink_register_client);
+
+int pmic_glink_send(struct pmic_glink_client *client, void *data, size_t len)
+{
+	struct pmic_glink *pg = client->pg;
+
+	return rpmsg_send(pg->ept, data, len);
+}
+EXPORT_SYMBOL_GPL(pmic_glink_send);
+
+static int pmic_glink_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
+				     int len, void *priv, u32 addr)
+{
+	struct pmic_glink_client *client;
+	struct pmic_glink_hdr *hdr;
+	struct pmic_glink *pg = dev_get_drvdata(&rpdev->dev);
+
+	if (len < sizeof(*hdr)) {
+		dev_warn(pg->dev, "ignoring truncated message\n");
+		return 0;
+	}
+
+	hdr = data;
+
+	list_for_each_entry(client, &pg->clients, node) {
+		if (client->id == le32_to_cpu(hdr->owner))
+			client->cb(data, len, client->priv);
+	}
+
+	return 0;
+}
+
+static void pmic_glink_aux_release(struct device *dev) {}
+
+static int pmic_glink_add_aux_device(struct pmic_glink *pg,
+				     struct auxiliary_device *aux,
+				     const char *name)
+{
+	struct device *parent = pg->dev;
+	int ret;
+
+	aux->name = name;
+	aux->dev.parent = parent;
+	aux->dev.release = pmic_glink_aux_release;
+	device_set_of_node_from_dev(&aux->dev, parent);
+	ret = auxiliary_device_init(aux);
+	if (ret)
+		return ret;
+
+	ret = auxiliary_device_add(aux);
+	if (ret)
+		auxiliary_device_uninit(aux);
+
+	return ret;
+}
+
+static void pmic_glink_del_aux_device(struct pmic_glink *pg,
+				      struct auxiliary_device *aux)
+{
+	auxiliary_device_delete(aux);
+	auxiliary_device_uninit(aux);
+}
+
+static void pmic_glink_state_notify_clients(struct pmic_glink *pg)
+{
+	struct pmic_glink_client *client;
+	unsigned int new_state = pg->client_state;
+
+	if (pg->client_state != SERVREG_SERVICE_STATE_UP) {
+		if (pg->pdr_state == SERVREG_SERVICE_STATE_UP && pg->ept)
+			new_state = SERVREG_SERVICE_STATE_UP;
+	} else {
+		if (pg->pdr_state == SERVREG_SERVICE_STATE_UP && pg->ept)
+			new_state = SERVREG_SERVICE_STATE_DOWN;
+	}
+
+	if (new_state != pg->client_state) {
+		list_for_each_entry(client, &pg->clients, node)
+			client->pdr_notify(client->priv, new_state);
+		pg->client_state = new_state;
+	}
+}
+
+static void pmic_glink_pdr_callback(int state, char *svc_path, void *priv)
+{
+	struct pmic_glink *pg = priv;
+
+	mutex_lock(&pg->state_lock);
+	pg->pdr_state = state;
+
+	pmic_glink_state_notify_clients(pg);
+	mutex_unlock(&pg->state_lock);
+}
+
+static int pmic_glink_rpmsg_probe(struct rpmsg_device *rpdev)
+{
+	struct pmic_glink *pg = __pmic_glink;
+	int ret = 0;
+
+	mutex_lock(&__pmic_glink_lock);
+	if (!pg) {
+		ret = dev_err_probe(&rpdev->dev, -ENODEV, "no pmic_glink device to attach to\n");
+		goto out_unlock;
+	}
+
+	dev_set_drvdata(&rpdev->dev, pg);
+
+	mutex_lock(&pg->state_lock);
+	pg->ept = rpdev->ept;
+	pmic_glink_state_notify_clients(pg);
+	mutex_unlock(&pg->state_lock);
+
+out_unlock:
+	mutex_unlock(&__pmic_glink_lock);
+	return ret;
+}
+
+static void pmic_glink_rpmsg_remove(struct rpmsg_device *rpdev)
+{
+	struct pmic_glink *pg;
+
+	mutex_lock(&__pmic_glink_lock);
+	pg = __pmic_glink;
+	if (!pg)
+		goto out_unlock;
+
+	mutex_lock(&pg->state_lock);
+	pg->ept = NULL;
+	pmic_glink_state_notify_clients(pg);
+	mutex_unlock(&pg->state_lock);
+out_unlock:
+	mutex_unlock(&__pmic_glink_lock);
+}
+
+static const struct rpmsg_device_id pmic_glink_rpmsg_id_match[] = {
+	{ "PMIC_RTR_ADSP_APPS" },
+	{}
+};
+
+static struct rpmsg_driver pmic_glink_rpmsg_driver = {
+	.probe = pmic_glink_rpmsg_probe,
+	.remove = pmic_glink_rpmsg_remove,
+	.callback = pmic_glink_rpmsg_callback,
+	.id_table = pmic_glink_rpmsg_id_match,
+	.drv  = {
+		.name  = "qcom_pmic_glink_rpmsg",
+	},
+};
+
+static int pmic_glink_probe(struct platform_device *pdev)
+{
+	struct pdr_service *service;
+	struct pmic_glink *pg;
+	int ret;
+
+	pg = devm_kzalloc(&pdev->dev, sizeof(*pg), GFP_KERNEL);
+	if (!pg)
+		return -ENOMEM;
+
+	dev_set_drvdata(&pdev->dev, pg);
+
+	pg->dev = &pdev->dev;
+
+	INIT_LIST_HEAD(&pg->clients);
+	mutex_init(&pg->client_lock);
+	mutex_init(&pg->state_lock);
+
+	ret = pmic_glink_add_aux_device(pg, &pg->altmode_aux, "altmode");
+	if (ret)
+		return ret;
+	ret = pmic_glink_add_aux_device(pg, &pg->ps_aux, "power-supply");
+	if (ret)
+		goto out_release_altmode_aux;
+
+	pg->pdr = pdr_handle_alloc(pmic_glink_pdr_callback, pg);
+	if (IS_ERR(pg->pdr)) {
+		ret = dev_err_probe(&pdev->dev, PTR_ERR(pg->pdr), "failed to initialize pdr\n");
+		goto out_release_aux_devices;
+	}
+
+	service = pdr_add_lookup(pg->pdr, "tms/servreg", "msm/adsp/charger_pd");
+	if (IS_ERR(service)) {
+		ret = dev_err_probe(&pdev->dev, PTR_ERR(service),
+				    "failed adding pdr lookup for charger_pd\n");
+		goto out_release_pdr_handle;
+	}
+
+	mutex_lock(&__pmic_glink_lock);
+	__pmic_glink = pg;
+	mutex_unlock(&__pmic_glink_lock);
+
+	return 0;
+
+out_release_pdr_handle:
+	pdr_handle_release(pg->pdr);
+out_release_aux_devices:
+	pmic_glink_del_aux_device(pg, &pg->ps_aux);
+out_release_altmode_aux:
+	pmic_glink_del_aux_device(pg, &pg->altmode_aux);
+
+	return ret;
+}
+
+static int pmic_glink_remove(struct platform_device *pdev)
+{
+	struct pmic_glink *pg = dev_get_drvdata(&pdev->dev);
+
+	pdr_handle_release(pg->pdr);
+
+	pmic_glink_del_aux_device(pg, &pg->ps_aux);
+	pmic_glink_del_aux_device(pg, &pg->altmode_aux);
+
+	mutex_lock(&__pmic_glink_lock);
+	__pmic_glink = NULL;
+	mutex_unlock(&__pmic_glink_lock);
+
+	return 0;
+}
+
+static const struct of_device_id pmic_glink_of_match[] = {
+	{ .compatible = "qcom,pmic-glink", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, pmic_glink_of_match);
+
+static struct platform_driver pmic_glink_driver = {
+	.probe = pmic_glink_probe,
+	.remove = pmic_glink_remove,
+	.driver = {
+		.name = "qcom_pmic_glink",
+		.of_match_table = pmic_glink_of_match,
+	},
+};
+
+static int pmic_glink_init(void)
+{
+	platform_driver_register(&pmic_glink_driver);
+	register_rpmsg_driver(&pmic_glink_rpmsg_driver);
+
+	return 0;
+};
+module_init(pmic_glink_init);
+
+static void pmic_glink_exit(void)
+{
+	unregister_rpmsg_driver(&pmic_glink_rpmsg_driver);
+	platform_driver_unregister(&pmic_glink_driver);
+};
+module_exit(pmic_glink_exit);
+
+MODULE_DESCRIPTION("Qualcomm PMIC GLINK driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/soc/qcom/pmic_glink.h b/include/linux/soc/qcom/pmic_glink.h
new file mode 100644
index 000000000000..fd124aa18c81
--- /dev/null
+++ b/include/linux/soc/qcom/pmic_glink.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022, Linaro Ltd
+ */
+#ifndef __SOC_QCOM_PMIC_GLINK_H__
+#define __SOC_QCOM_PMIC_GLINK_H__
+
+struct pmic_glink;
+struct pmic_glink_client;
+
+#define PMIC_GLINK_OWNER_BATTMGR	32778
+#define PMIC_GLINK_OWNER_USBC		32779
+#define PMIC_GLINK_OWNER_USBC_PAN	32780
+
+#define PMIC_GLINK_REQ_RESP		1
+#define PMIC_GLINK_NOTIFY		2
+
+struct pmic_glink_hdr {
+	__le32 owner;
+	__le32 type;
+	__le32 opcode;
+};
+
+int pmic_glink_send(struct pmic_glink_client *client, void *data, size_t len);
+
+struct pmic_glink_client *devm_pmic_glink_register_client(struct device *dev,
+							  unsigned int id,
+							  void (*cb)(const void *, size_t, void *),
+							  void (*pdr)(void *, int),
+							  void *priv);
+
+#endif
-- 
2.25.1

