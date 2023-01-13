Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26DF668AB4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 05:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237640AbjAMENc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 23:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjAMEL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 23:11:57 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612E96086B;
        Thu, 12 Jan 2023 20:11:44 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30D3SRg5028573;
        Fri, 13 Jan 2023 04:11:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=3ncDAELSeSzxFGKL/D7gY1el1ay9r6I0xHOYMvyPMbY=;
 b=YXKvP9I0ygfg8H4SRl5K+L6uprUcF027/OGU/yeGqo+ROqV+42ixmrAPM5X3zwuHXC2x
 iSy+NNFIevwiRZKXP8QjqR8k164P8s+7BRu9Abo34d9LCC8IqoqQlP3tzP9GMTheKufV
 yVG3rlncBdvDbRvGufMBW627liVPAnbZvBVMb3aohPox4ktpEhY71zAe4/m8vVBFBlCs
 MooTIkina73SievMIUlsVQsDwGMiu9nPWFN+E7AdfHHB8gAJYIDYT6aCT4ak40Y8psyz
 PPNKVApbZyqDn3v7R9K1EcwTTeDh4wMqo87JBCpxb2yFqD4FBQ/HjXTsno8E/y1kUIff 2A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n2hum1rkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 04:11:39 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30D4BcYh011539
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 04:11:38 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 12 Jan 2023 20:11:38 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        "Subbaraman Narayanamurthy" <quic_subbaram@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 3/4] soc: qcom: pmic_glink: Introduce altmode support
Date:   Thu, 12 Jan 2023 20:11:31 -0800
Message-ID: <20230113041132.4189268-4-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230113041132.4189268-1-quic_bjorande@quicinc.com>
References: <20230113041132.4189268-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RCNoCFOiHr8LFv2lgC_PLPxFOXdr-Nmv
X-Proofpoint-ORIG-GUID: RCNoCFOiHr8LFv2lgC_PLPxFOXdr-Nmv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_14,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 mlxscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130026
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

With the PMIC GLINK service, the host OS subscribes to USB-C altmode
messages, which are sent by the firmware to notify the host OS about
state updates and HPD interrupts.

The pmic_glink_altmode driver registers for these notifications and
propagates the notifications as typec_mux, typec_switch and DRM OOB
notifications as necessary to implement DisplayPort altmode support.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---

Changes since v1:
- None

Johan reported a NULL pointer dereference in
drm_kms_helper_hotplug_event() for HPD event being reported while the
MSM DRM driver is still being initalized, a separate fix has been sent
in hope to remidy this race condition in the MSM driver.

 drivers/soc/qcom/Makefile             |   1 +
 drivers/soc/qcom/pmic_glink_altmode.c | 477 ++++++++++++++++++++++++++
 2 files changed, 478 insertions(+)
 create mode 100644 drivers/soc/qcom/pmic_glink_altmode.c

diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 29cccac472f3..f30552bf4da7 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_QCOM_MDT_LOADER)	+= mdt_loader.o
 obj-$(CONFIG_QCOM_OCMEM)	+= ocmem.o
 obj-$(CONFIG_QCOM_PDR_HELPERS)	+= pdr_interface.o
 obj-$(CONFIG_QCOM_PMIC_GLINK)	+= pmic_glink.o
+obj-$(CONFIG_QCOM_PMIC_GLINK)	+= pmic_glink_altmode.o
 obj-$(CONFIG_QCOM_QMI_HELPERS)	+= qmi_helpers.o
 qmi_helpers-y	+= qmi_encdec.o qmi_interface.o
 obj-$(CONFIG_QCOM_RAMP_CTRL)	+= ramp_controller.o
diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
new file mode 100644
index 000000000000..8d2d563cb756
--- /dev/null
+++ b/drivers/soc/qcom/pmic_glink_altmode.c
@@ -0,0 +1,477 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Linaro Ltd
+ */
+#include <linux/auxiliary_bus.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/soc/qcom/pdr.h>
+#include <drm/drm_bridge.h>
+
+#include <linux/usb/typec_altmode.h>
+#include <linux/usb/typec_dp.h>
+#include <linux/usb/typec_mux.h>
+
+#include <linux/soc/qcom/pmic_glink.h>
+
+#define PMIC_GLINK_MAX_PORTS	2
+
+#define USBC_SC8180X_NOTIFY_IND	0x13
+#define USBC_CMD_WRITE_REQ      0x15
+#define USBC_NOTIFY_IND		0x16
+
+#define ALTMODE_PAN_EN		0x10
+#define ALTMODE_PAN_ACK		0x11
+
+struct usbc_write_req {
+	struct pmic_glink_hdr   hdr;
+	__le32 cmd;
+	__le32 arg;
+	__le32 reserved;
+};
+
+#define NOTIFY_PAYLOAD_SIZE 16
+struct usbc_notify {
+	struct pmic_glink_hdr hdr;
+	char payload[NOTIFY_PAYLOAD_SIZE];
+	u32 reserved;
+};
+
+struct usbc_sc8180x_notify {
+	struct pmic_glink_hdr hdr;
+	__le32 notification;
+	__le32 reserved[2];
+};
+
+enum pmic_glink_altmode_pin_assignment {
+	DPAM_HPD_OUT,
+	DPAM_HPD_A,
+	DPAM_HPD_B,
+	DPAM_HPD_C,
+	DPAM_HPD_D,
+	DPAM_HPD_E,
+	DPAM_HPD_F,
+};
+
+struct pmic_glink_altmode;
+
+#define work_to_altmode_port(w) container_of((w), struct pmic_glink_altmode_port, work)
+
+struct pmic_glink_altmode_port {
+	struct pmic_glink_altmode *altmode;
+	unsigned int index;
+
+	struct typec_switch *typec_switch;
+	struct typec_mux *typec_mux;
+	struct typec_mux_state state;
+	struct typec_altmode dp_alt;
+
+	struct work_struct work;
+
+	struct drm_bridge bridge;
+
+	enum typec_orientation orientation;
+	u16 svid;
+	u8 dp_data;
+	u8 mode;
+	u8 hpd_state;
+	u8 hpd_irq;
+};
+
+#define work_to_altmode(w) container_of((w), struct pmic_glink_altmode, enable_work)
+
+struct pmic_glink_altmode {
+	struct device *dev;
+
+	unsigned int owner_id;
+
+	/* To synchronize WRITE_REQ acks */
+	struct mutex lock;
+
+	struct completion pan_ack;
+	struct pmic_glink_client *client;
+
+	struct work_struct enable_work;
+
+	struct pmic_glink_altmode_port ports[PMIC_GLINK_MAX_PORTS];
+};
+
+static int pmic_glink_altmode_request(struct pmic_glink_altmode *altmode, u32 cmd, u32 arg)
+{
+	struct usbc_write_req req = {};
+	unsigned long left;
+	int ret;
+
+	/*
+	 * The USBC_CMD_WRITE_REQ ack doesn't identify the request, so wait for
+	 * one ack at a time.
+	 */
+	mutex_lock(&altmode->lock);
+
+	req.hdr.owner = cpu_to_le32(altmode->owner_id);
+	req.hdr.type = cpu_to_le32(PMIC_GLINK_REQ_RESP);
+	req.hdr.opcode = cpu_to_le32(USBC_CMD_WRITE_REQ);
+	req.cmd = cpu_to_le32(cmd);
+	req.arg = cpu_to_le32(arg);
+
+	ret = pmic_glink_send(altmode->client, &req, sizeof(req));
+	if (ret) {
+		dev_err(altmode->dev, "failed to send altmode request: %#x (%d)\n", cmd, ret);
+		goto out_unlock;
+	}
+
+	left = wait_for_completion_timeout(&altmode->pan_ack, 5 * HZ);
+	if (!left) {
+		dev_err(altmode->dev, "timeout waiting for altmode request ack for: %#x\n", cmd);
+		ret = -ETIMEDOUT;
+	}
+
+out_unlock:
+	mutex_unlock(&altmode->lock);
+	return ret;
+}
+
+static void pmic_glink_altmode_enable_dp(struct pmic_glink_altmode *altmode,
+					 struct pmic_glink_altmode_port *port,
+					 u8 mode, bool hpd_state,
+					 bool hpd_irq)
+{
+	struct typec_displayport_data dp_data = {};
+	int ret;
+
+	dp_data.status = DP_STATUS_ENABLED;
+	if (hpd_state)
+		dp_data.status |= DP_STATUS_HPD_STATE;
+	if (hpd_irq)
+		dp_data.status |= DP_STATUS_IRQ_HPD;
+	dp_data.conf = DP_CONF_SET_PIN_ASSIGN(mode);
+
+	port->state.alt = &port->dp_alt;
+	port->state.data = &dp_data;
+	port->state.mode = TYPEC_MODAL_STATE(mode);
+
+	ret = typec_mux_set(port->typec_mux, &port->state);
+	if (ret)
+		dev_err(altmode->dev, "failed to switch mux to DP\n");
+}
+
+static void pmic_glink_altmode_enable_usb(struct pmic_glink_altmode *altmode,
+					  struct pmic_glink_altmode_port *port)
+{
+	int ret;
+
+	port->state.alt = NULL;
+	port->state.data = NULL;
+	port->state.mode = TYPEC_STATE_USB;
+
+	ret = typec_mux_set(port->typec_mux, &port->state);
+	if (ret)
+		dev_err(altmode->dev, "failed to switch mux to USB\n");
+}
+
+static void pmic_glink_altmode_worker(struct work_struct *work)
+{
+	struct pmic_glink_altmode_port *alt_port = work_to_altmode_port(work);
+	struct pmic_glink_altmode *altmode = alt_port->altmode;
+
+	typec_switch_set(alt_port->typec_switch, alt_port->orientation);
+
+	if (alt_port->svid == USB_TYPEC_DP_SID)
+		pmic_glink_altmode_enable_dp(altmode, alt_port, alt_port->mode,
+					     alt_port->hpd_state, alt_port->hpd_irq);
+	else
+		pmic_glink_altmode_enable_usb(altmode, alt_port);
+
+	if (alt_port->hpd_state)
+		drm_bridge_hpd_notify(&alt_port->bridge, connector_status_connected);
+	else
+		drm_bridge_hpd_notify(&alt_port->bridge, connector_status_disconnected);
+
+	pmic_glink_altmode_request(altmode, ALTMODE_PAN_ACK, alt_port->index);
+};
+
+static enum typec_orientation pmic_glink_altmode_orientation(unsigned int orientation)
+{
+	if (orientation == 0)
+		return TYPEC_ORIENTATION_NORMAL;
+	else if (orientation == 1)
+		return TYPEC_ORIENTATION_REVERSE;
+	else
+		return TYPEC_ORIENTATION_NONE;
+}
+
+#define SC8180X_PORT_MASK		0x000000ff
+#define SC8180X_ORIENTATION_MASK	0x0000ff00
+#define SC8180X_MUX_MASK		0x00ff0000
+#define SC8180X_MODE_MASK		0x3f000000
+#define SC8180X_HPD_STATE_MASK		0x40000000
+#define SC8180X_HPD_IRQ_MASK		0x80000000
+
+static void pmic_glink_altmode_sc8180xp_notify(struct pmic_glink_altmode *altmode,
+					       const void *data, size_t len)
+{
+	struct pmic_glink_altmode_port *alt_port;
+	const struct usbc_sc8180x_notify *msg;
+	u32 notification;
+	u8 orientation;
+	u8 hpd_state;
+	u8 hpd_irq;
+	u16 svid;
+	u8 port;
+	u8 mode;
+	u8 mux;
+
+	if (len != sizeof(*msg)) {
+		dev_warn(altmode->dev, "invalid length of USBC_NOTIFY indication: %zd\n", len);
+		return;
+	}
+
+	msg = data;
+	notification = le32_to_cpu(msg->notification);
+	port = FIELD_GET(SC8180X_PORT_MASK, notification);
+	orientation = FIELD_GET(SC8180X_ORIENTATION_MASK, notification);
+	mux = FIELD_GET(SC8180X_MUX_MASK, notification);
+	mode = FIELD_GET(SC8180X_MODE_MASK, notification);
+	hpd_state = FIELD_GET(SC8180X_HPD_STATE_MASK, notification);
+	hpd_irq = FIELD_GET(SC8180X_HPD_IRQ_MASK, notification);
+
+	svid = mux == 2 ? USB_TYPEC_DP_SID : 0;
+
+	if (!altmode->ports[port].altmode) {
+		dev_dbg(altmode->dev, "notification on undefined port %d\n", port);
+		return;
+	}
+
+	alt_port = &altmode->ports[port];
+	alt_port->orientation = pmic_glink_altmode_orientation(orientation);
+	alt_port->svid = mux == 2 ? USB_TYPEC_DP_SID : 0;
+	alt_port->mode = mode;
+	alt_port->hpd_state = hpd_state;
+	alt_port->hpd_irq = hpd_irq;
+	schedule_work(&alt_port->work);
+}
+
+#define SC8280XP_DPAM_MASK	0x3f
+#define SC8280XP_HPD_STATE_MASK BIT(6)
+#define SC8280XP_HPD_IRQ_MASK	BIT(7)
+
+static void pmic_glink_altmode_sc8280xp_notify(struct pmic_glink_altmode *altmode,
+					       u16 svid, const void *data, size_t len)
+{
+	struct pmic_glink_altmode_port *alt_port;
+	const struct usbc_notify *notify;
+	u8 orientation;
+	u8 hpd_state;
+	u8 hpd_irq;
+	u8 mode;
+	u8 port;
+
+	if (len != sizeof(*notify)) {
+		dev_warn(altmode->dev, "invalid length USBC_NOTIFY_IND: %zd\n",
+			 len);
+		return;
+	}
+
+	notify = data;
+
+	port = notify->payload[0];
+	orientation = notify->payload[1];
+	mode = FIELD_GET(SC8280XP_DPAM_MASK, notify->payload[8]) - DPAM_HPD_A;
+	hpd_state = FIELD_GET(SC8280XP_HPD_STATE_MASK, notify->payload[8]);
+	hpd_irq = FIELD_GET(SC8280XP_HPD_IRQ_MASK, notify->payload[8]);
+
+	if (!altmode->ports[port].altmode) {
+		dev_dbg(altmode->dev, "notification on undefined port %d\n", port);
+		return;
+	}
+
+	alt_port = &altmode->ports[port];
+	alt_port->orientation = pmic_glink_altmode_orientation(orientation);
+	alt_port->svid = svid;
+	alt_port->mode = mode;
+	alt_port->hpd_state = hpd_state;
+	alt_port->hpd_irq = hpd_irq;
+	schedule_work(&alt_port->work);
+}
+
+static void pmic_glink_altmode_callback(const void *data, size_t len, void *priv)
+{
+	struct pmic_glink_altmode *altmode = priv;
+	const struct pmic_glink_hdr *hdr = data;
+	u16 opcode;
+	u16 svid;
+
+	opcode = le32_to_cpu(hdr->opcode) & 0xff;
+	svid = le32_to_cpu(hdr->opcode) >> 16;
+
+	switch (opcode) {
+	case USBC_CMD_WRITE_REQ:
+		complete(&altmode->pan_ack);
+		break;
+	case USBC_NOTIFY_IND:
+		pmic_glink_altmode_sc8280xp_notify(altmode, svid, data, len);
+		break;
+	case USBC_SC8180X_NOTIFY_IND:
+		pmic_glink_altmode_sc8180xp_notify(altmode, data, len);
+		break;
+	}
+}
+
+static int pmic_glink_altmode_attach(struct drm_bridge *bridge,
+				     enum drm_bridge_attach_flags flags)
+{
+	return flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR ? 0 : -EINVAL;
+}
+
+static const struct drm_bridge_funcs pmic_glink_altmode_bridge_funcs = {
+	.attach = pmic_glink_altmode_attach,
+};
+
+static void pmic_glink_altmode_put_mux(void *data)
+{
+	typec_mux_put(data);
+}
+
+static void pmic_glink_altmode_put_switch(void *data)
+{
+	typec_switch_put(data);
+}
+
+static void pmic_glink_altmode_enable_worker(struct work_struct *work)
+{
+	struct pmic_glink_altmode *altmode = work_to_altmode(work);
+	int ret;
+
+	ret = pmic_glink_altmode_request(altmode, ALTMODE_PAN_EN, 0);
+	if (ret)
+		dev_err(altmode->dev, "failed to request altmode notifications\n");
+}
+
+static void pmic_glink_altmode_pdr_notify(void *priv, int state)
+{
+	struct pmic_glink_altmode *altmode = priv;
+
+	if (state == SERVREG_SERVICE_STATE_UP)
+		schedule_work(&altmode->enable_work);
+}
+
+static const struct of_device_id pmic_glink_altmode_of_quirks[] = {
+	{ .compatible = "qcom,sc8180x-pmic-glink", .data = (void *)PMIC_GLINK_OWNER_USBC },
+	{}
+};
+
+static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
+				    const struct auxiliary_device_id *id)
+{
+	struct pmic_glink_altmode_port *alt_port;
+	struct pmic_glink_altmode *altmode;
+	struct typec_altmode_desc mux_desc = {};
+	const struct of_device_id *match;
+	struct fwnode_handle *fwnode;
+	struct device *dev = &adev->dev;
+	u32 port;
+	int ret;
+
+	altmode = devm_kzalloc(dev, sizeof(*altmode), GFP_KERNEL);
+	if (!altmode)
+		return -ENOMEM;
+
+	altmode->dev = dev;
+
+	match = of_match_device(pmic_glink_altmode_of_quirks, dev->parent);
+	if (match)
+		altmode->owner_id = (unsigned long)match->data;
+	else
+		altmode->owner_id = PMIC_GLINK_OWNER_USBC_PAN;
+
+	INIT_WORK(&altmode->enable_work, pmic_glink_altmode_enable_worker);
+	init_completion(&altmode->pan_ack);
+	mutex_init(&altmode->lock);
+
+	device_for_each_child_node(dev, fwnode) {
+		ret = fwnode_property_read_u32(fwnode, "reg", &port);
+		if (ret < 0) {
+			dev_err(dev, "missing reg property of %pOFn\n", fwnode);
+			return ret;
+		}
+
+		if (port >= ARRAY_SIZE(altmode->ports)) {
+			dev_warn(dev, "invalid connector number, ignoring\n");
+			continue;
+		}
+
+		if (altmode->ports[port].altmode) {
+			dev_err(dev, "multiple connector definition for port %u\n", port);
+			return -EINVAL;
+		}
+
+		alt_port = &altmode->ports[port];
+		alt_port->altmode = altmode;
+		alt_port->index = port;
+		INIT_WORK(&alt_port->work, pmic_glink_altmode_worker);
+
+		alt_port->bridge.funcs = &pmic_glink_altmode_bridge_funcs;
+		alt_port->bridge.of_node = to_of_node(fwnode);
+		alt_port->bridge.ops = DRM_BRIDGE_OP_HPD;
+		alt_port->bridge.type = DRM_MODE_CONNECTOR_USB;
+
+		ret = devm_drm_bridge_add(dev, &alt_port->bridge);
+		if (ret)
+			return ret;
+
+		alt_port->dp_alt.svid = USB_TYPEC_DP_SID;
+		alt_port->dp_alt.mode = USB_TYPEC_DP_MODE;
+		alt_port->dp_alt.active = 1;
+
+		mux_desc.svid = USB_TYPEC_DP_SID;
+		mux_desc.mode = USB_TYPEC_DP_MODE;
+		alt_port->typec_mux = fwnode_typec_mux_get(fwnode, &mux_desc);
+		if (IS_ERR(alt_port->typec_mux))
+			return dev_err_probe(dev, PTR_ERR(alt_port->typec_mux),
+					     "failed to acquire mode-switch for port: %d\n",
+					     port);
+
+		ret = devm_add_action_or_reset(dev, pmic_glink_altmode_put_mux,
+					       alt_port->typec_mux);
+		if (ret)
+			return ret;
+
+		alt_port->typec_switch = fwnode_typec_switch_get(fwnode);
+		if (IS_ERR(alt_port->typec_switch))
+			return dev_err_probe(dev, PTR_ERR(alt_port->typec_switch),
+					     "failed to acquire orientation-switch for port: %d\n",
+					     port);
+
+		ret = devm_add_action_or_reset(dev, pmic_glink_altmode_put_switch,
+					       alt_port->typec_switch);
+		if (ret)
+			return ret;
+	}
+
+	altmode->client = devm_pmic_glink_register_client(dev,
+							  altmode->owner_id,
+							  pmic_glink_altmode_callback,
+							  pmic_glink_altmode_pdr_notify,
+							  altmode);
+	return PTR_ERR_OR_ZERO(altmode->client);
+}
+
+static const struct auxiliary_device_id pmic_glink_altmode_id_table[] = {
+	{ .name = "pmic_glink.altmode", },
+	{},
+};
+MODULE_DEVICE_TABLE(auxiliary, pmic_glink_altmode_id_table);
+
+static struct auxiliary_driver pmic_glink_altmode_driver = {
+	.name = "pmic_glink_altmode",
+	.probe = pmic_glink_altmode_probe,
+	.id_table = pmic_glink_altmode_id_table,
+};
+
+module_auxiliary_driver(pmic_glink_altmode_driver);
+
+MODULE_DESCRIPTION("Qualcomm PMIC GLINK Altmode driver");
+MODULE_LICENSE("GPL");
-- 
2.37.3

