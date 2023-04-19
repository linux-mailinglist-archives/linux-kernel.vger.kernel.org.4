Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067FE6E7C14
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbjDSOPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbjDSOP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:15:26 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C837716FB1;
        Wed, 19 Apr 2023 07:14:47 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33JBIIBx016030;
        Wed, 19 Apr 2023 14:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=Id4uVjwXoscLl4Y0e98lOkqoloRZbS6hh1+6aGuwkvo=;
 b=TvVgFzzWkOwzPuPebaJlwSM7+nDpqIO8AeF+1FJHA84LO3m4nMSj18omBjhrTFsg4gl2
 ogE6wgJBWFGQH6kZpZXMR4ttHm27myHqJbQg2jWOTWkPF4WR+HLfMda0EduT4aSr3hOL
 XiuTM0Rc0HgZz6Fzev64o37mTcPrXsrpAjsJRiyjcO3znSA+IVIi2RLZ4xLH1k6NZ8Ok
 /cWt+ELBmMkTum+Jad611GxuBw1U6hgJAT4RcnN41OTCD0cFq7RyMBkk86oA2bOGvlar
 xztKW+T01w68yU8kdNH8IRduB2RpGCC/l/ubq8cEHYp07OK8qu9qMogLStNLUwGH53l8 KQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q1w21b229-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Apr 2023 14:13:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33JEDvnn001891
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Apr 2023 14:13:57 GMT
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 19 Apr 2023 07:13:53 -0700
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
Subject: [PATCH v2] stm: class: Add MIPI OST protocol support
Date:   Wed, 19 Apr 2023 22:13:28 +0800
Message-ID: <20230419141328.37472-1-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hRjNNcSDHr8pcnb-3s97ZZw0UQA2JOZz
X-Proofpoint-GUID: hRjNNcSDHr8pcnb-3s97ZZw0UQA2JOZz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-19_09,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304190127
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MIPI OST(Open System Trace) protocol support for stm to format
the traces. OST over STP packet consists of Header/Payload/End. In
header, there will be STARTSIMPLE/VERSION/ENTITY/PROTOCOL. STARTSIMPLE
is used to signal the beginning of a simplified OST base protocol
packet.The Entity ID field is a one byte unsigned number that identifies
the source. FLAG packet is used for END token.

Signed-off-by: Tingwei Zhang <quic_tingweiz@quicinc.com>
Signed-off-by: Yuanfang Zhang <quic_yuanfang@quicinc.com>
Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 .../ABI/testing/configfs-stp-policy-p_ost     |  13 ++
 Documentation/trace/p_ost.rst                 |  40 ++++
 drivers/hwtracing/stm/Kconfig                 |  14 ++
 drivers/hwtracing/stm/Makefile                |   2 +
 drivers/hwtracing/stm/p_ost.c                 | 213 ++++++++++++++++++
 5 files changed, 282 insertions(+)
 create mode 100644 Documentation/ABI/testing/configfs-stp-policy-p_ost
 create mode 100644 Documentation/trace/p_ost.rst
 create mode 100644 drivers/hwtracing/stm/p_ost.c

diff --git a/Documentation/ABI/testing/configfs-stp-policy-p_ost b/Documentation/ABI/testing/configfs-stp-policy-p_ost
new file mode 100644
index 000000000000..7ad11ae21760
--- /dev/null
+++ b/Documentation/ABI/testing/configfs-stp-policy-p_ost
@@ -0,0 +1,13 @@
+What:		/config/stp-policy/<device>:p_ost.<policy>/<node>/entity_available
+Date:		April 2023
+KernelVersion:	6.3
+Description:
+		Show entity that p_ost supports, RO.
+
+What:		/config/stp-policy/<device>:p_ost.<policy>/<node>/entity
+Date:		April 2023
+KernelVersion:	6.3
+Description:
+		Set the entity which is to identify the source, RW.
+		The available entity can be gotten by reading entity_available.
+
diff --git a/Documentation/trace/p_ost.rst b/Documentation/trace/p_ost.rst
new file mode 100644
index 000000000000..8d7afa341b9e
--- /dev/null
+++ b/Documentation/trace/p_ost.rst
@@ -0,0 +1,40 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================
+MIPI OST over STP
+===================
+
+The OST(Open System Trace) driver is used with STM class devices to
+generate standardized trace stream. Trace sources can be identified
+by different entity ids.
+
+CONFIG_STM_PROTO_OST is for p_ost driver enablement. Once this config
+is enabled, you can select the p_ost protocol by command below:
+
+# mkdir /sys/kernel/config/stp-policy/stm0:p_ost.policy
+
+The policy name format is extended like this:
+    <device_name>:<protocol_name>.<policy_name>
+
+With coresight-stm device, it will be look like "stm0:p_ost.policy".
+
+You can check if the protocol is set successfully by:
+# cat /sys/kernel/config/stp-policy/stm0:p_ost.policy/protocol
+p_ost
+
+With MIPI OST protocol driver, the attributes for each protocol node is:
+# mkdir /sys/kernel/config/stp-policy/stm0:p_ost.policy/default
+# ls /sys/kernel/config/stp-policy/stm0:p_ost.policy/default
+channels  entity    masters
+
+The entity here is the set the entity that p_ost supports. Currently
+p_ost supports ftrace and console entity.
+
+Get current available entity that p_ost supports:
+# cat /sys/kernel/config/stp-policy/stm0:p_ost.policy/default/entity_available
+ftrace console
+
+Set entity:
+# echo 'ftrace' > /sys/kernel/config/stp-policy/stm0:p_ost.policy/default/entity
+
+See Documentation/ABI/testing/configfs-stp-policy-p_ost for more details.
diff --git a/drivers/hwtracing/stm/Kconfig b/drivers/hwtracing/stm/Kconfig
index eda6b11d40a1..daa4aa09f64d 100644
--- a/drivers/hwtracing/stm/Kconfig
+++ b/drivers/hwtracing/stm/Kconfig
@@ -40,6 +40,20 @@ config STM_PROTO_SYS_T
 
 	  If you don't know what this is, say N.
 
+config STM_PROTO_OST
+	tristate "MIPI OST STM framing protocol driver"
+	default CONFIG_STM
+	help
+	  This is an implementation of MIPI OST protocol to be used
+	  over the STP transport. In addition to the data payload, it
+	  also carries additional metadata for entity, better
+	  means of trace source identification, etc.
+
+	  The receiving side must be able to decode this protocol in
+	  addition to the MIPI STP, in order to extract the data.
+
+	  If you don't know what this is, say N.
+
 config STM_DUMMY
 	tristate "Dummy STM driver"
 	help
diff --git a/drivers/hwtracing/stm/Makefile b/drivers/hwtracing/stm/Makefile
index 1692fcd29277..715fc721891e 100644
--- a/drivers/hwtracing/stm/Makefile
+++ b/drivers/hwtracing/stm/Makefile
@@ -5,9 +5,11 @@ stm_core-y		:= core.o policy.o
 
 obj-$(CONFIG_STM_PROTO_BASIC) += stm_p_basic.o
 obj-$(CONFIG_STM_PROTO_SYS_T) += stm_p_sys-t.o
+obj-$(CONFIG_STM_PROTO_OST) += stm_p_ost.o
 
 stm_p_basic-y		:= p_basic.o
 stm_p_sys-t-y		:= p_sys-t.o
+stm_p_ost-y		:= p_ost.o
 
 obj-$(CONFIG_STM_DUMMY)	+= dummy_stm.o
 
diff --git a/drivers/hwtracing/stm/p_ost.c b/drivers/hwtracing/stm/p_ost.c
new file mode 100644
index 000000000000..fe99b68569d3
--- /dev/null
+++ b/drivers/hwtracing/stm/p_ost.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ *
+ * MIPI OST framing protocol for STM devices.
+ */
+
+#include <linux/configfs.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/stm.h>
+#include "stm.h"
+
+
+#define OST_TOKEN_STARTSIMPLE		(0x10)
+#define OST_VERSION_MIPI1		(0x10 << 8)
+
+/* entity id to identify the source*/
+#define OST_ENTITY_FTRACE		(0x01 << 16)
+#define OST_ENTITY_CONSOLE		(0x02 << 16)
+
+#define OST_CONTROL_PROTOCOL		(0x0 << 24)
+
+/*
+ * OST Base Protocol Header
+ *
+ * Position	Bits	Field Name
+ *      0       8       STARTSIMPLE
+ *      1       8       Version
+ *      2       8       Entity ID
+ *      3       8       protocol ID
+ */
+#define DATA_HEADER (OST_TOKEN_STARTSIMPLE | OST_VERSION_MIPI1 | \
+			OST_CONTROL_PROTOCOL)
+
+#define STM_MAKE_VERSION(ma, mi)	((ma << 8) | mi)
+#define STM_HEADER_MAGIC		(0x5953)
+
+enum ost_entity_type {
+	OST_ENTITY_TYPE_NONE,
+	OST_ENTITY_TYPE_FTRACE,
+	OST_ENTITY_TYPE_CONSOLE,
+};
+
+static const char * const str_ost_entity_type[] = {
+	[OST_ENTITY_TYPE_NONE]		= "none",
+	[OST_ENTITY_TYPE_FTRACE]	= "ftrace",
+	[OST_ENTITY_TYPE_CONSOLE]	= "console",
+};
+
+struct ost_policy_node {
+	enum ost_entity_type	entity_type;
+};
+
+struct ost_output {
+	struct ost_policy_node	node;
+};
+
+/* Set default entity type as none */
+static void ost_policy_node_init(void *priv)
+{
+	struct ost_policy_node *pn = priv;
+
+	pn->entity_type = OST_ENTITY_TYPE_NONE;
+}
+
+static int ost_output_open(void *priv, struct stm_output *output)
+{
+	struct ost_policy_node *pn = priv;
+	struct ost_output *opriv;
+
+	opriv = kzalloc(sizeof(*opriv), GFP_ATOMIC);
+	if (!opriv)
+		return -ENOMEM;
+
+	memcpy(&opriv->node, pn, sizeof(opriv->node));
+	output->pdrv_private = opriv;
+	return 0;
+}
+
+static void ost_output_close(struct stm_output *output)
+{
+	kfree(output->pdrv_private);
+}
+
+static ssize_t ost_t_policy_entity_show(struct config_item *item,
+				char *page)
+{
+	struct ost_policy_node *pn = to_pdrv_policy_node(item);
+
+	return scnprintf(page, PAGE_SIZE, "%s\n",
+			str_ost_entity_type[pn->entity_type]);
+}
+
+static ssize_t
+ost_t_policy_entity_store(struct config_item *item, const char *page,
+			size_t count)
+{
+	struct mutex *mutexp = &item->ci_group->cg_subsys->su_mutex;
+	struct ost_policy_node *pn = to_pdrv_policy_node(item);
+	char str[10] = "";
+
+	mutex_lock(mutexp);
+	if (sscanf(page, "%s", str) != 1)
+		return -EINVAL;
+	mutex_unlock(mutexp);
+
+	if (!strcmp(str, str_ost_entity_type[OST_ENTITY_TYPE_FTRACE]))
+		pn->entity_type = OST_ENTITY_TYPE_FTRACE;
+	else if (!strcmp(str, str_ost_entity_type[OST_ENTITY_TYPE_CONSOLE]))
+		pn->entity_type = OST_ENTITY_TYPE_CONSOLE;
+	else
+		return -EINVAL;
+	return count;
+}
+CONFIGFS_ATTR(ost_t_policy_, entity);
+
+static ssize_t ost_t_policy_entity_available_show(struct config_item *item,
+				char *page)
+{
+	return scnprintf(page, PAGE_SIZE, "%s\n", "ftrace console");
+}
+CONFIGFS_ATTR_RO(ost_t_policy_, entity_available);
+
+static struct configfs_attribute *ost_t_policy_attrs[] = {
+	&ost_t_policy_attr_entity,
+	&ost_t_policy_attr_entity_available,
+	NULL,
+};
+
+static ssize_t notrace ost_write(struct stm_data *data,
+		struct stm_output *output, unsigned int chan,
+		const char *buf, size_t count)
+{
+	unsigned int c = output->channel + chan;
+	unsigned int m = output->master;
+	const unsigned char nil = 0;
+	u32 header = DATA_HEADER;
+	u8 trc_hdr[16];
+	ssize_t sz;
+
+	struct ost_output *op = output->pdrv_private;
+
+	/*
+	 * Identify the source by entity type.
+	 * If entity type is not set, return error value.
+	 */
+	if (op->node.entity_type == OST_ENTITY_TYPE_FTRACE) {
+		header |= OST_ENTITY_FTRACE;
+	} else if (op->node.entity_type == OST_ENTITY_TYPE_CONSOLE) {
+		header |= OST_ENTITY_CONSOLE;
+	} else {
+		pr_debug("p_ost: Entity must be set for trace data.");
+		return -EINVAL;
+	}
+
+	/*
+	 * STP framing rules for OST frames:
+	 *   * the first packet of the OST frame is marked;
+	 *   * the last packet is a FLAG with timestamped tag.
+	 */
+	/* Message layout: HEADER / DATA / TAIL */
+	/* HEADER */
+	sz = data->packet(data, m, c, STP_PACKET_DATA, STP_PACKET_MARKED,
+			  4, (u8 *)&header);
+	if (sz <= 0)
+		return sz;
+
+	/* DATA */
+	*(u16 *)(trc_hdr) = STM_MAKE_VERSION(0, 4);
+	*(u16 *)(trc_hdr + 2) = STM_HEADER_MAGIC;
+	*(u32 *)(trc_hdr + 4) = raw_smp_processor_id();
+	*(u64 *)(trc_hdr + 8) = task_tgid_nr(get_current());
+	sz = stm_data_write(data, m, c, false, trc_hdr, sizeof(trc_hdr));
+	if (sz <= 0)
+		return sz;
+
+	sz = stm_data_write(data, m, c, false, buf, count);
+
+	/* TAIL */
+	if (sz > 0)
+		data->packet(data, m, c, STP_PACKET_FLAG,
+			STP_PACKET_TIMESTAMPED, 0, &nil);
+
+	return sz;
+}
+
+static const struct stm_protocol_driver ost_pdrv = {
+	.owner			= THIS_MODULE,
+	.name			= "p_ost",
+	.write			= ost_write,
+	.policy_attr		= ost_t_policy_attrs,
+	.output_open		= ost_output_open,
+	.output_close		= ost_output_close,
+	.policy_node_init	= ost_policy_node_init,
+};
+
+static int ost_stm_init(void)
+{
+	return stm_register_protocol(&ost_pdrv);
+}
+
+static void ost_stm_exit(void)
+{
+	stm_unregister_protocol(&ost_pdrv);
+}
+
+module_init(ost_stm_init);
+module_exit(ost_stm_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MIPI Open System Trace STM framing protocol driver");
-- 
2.17.1

