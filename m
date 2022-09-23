Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2116A5E7531
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 09:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiIWHuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 03:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiIWHub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 03:50:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13261126B7A;
        Fri, 23 Sep 2022 00:50:27 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28N7S4cT016504;
        Fri, 23 Sep 2022 07:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=5v3cM2LwNTiLfsyBInAWix2udANLBqi9gSZUWhePD2E=;
 b=j+ApA7CubdwSJYhRZmm+dVWoikYlvdoufsvqIlObS29L4ZYquxOuSdNotxvdHVgryj+I
 E642t9jNZojGlGkChEhGCqkGGnG1K8wTf5dzzUKt1sfhA+jZfim8CmH6uPfJ0t2Vyw0G
 h+uxI0Q9k94flKAPBp5BUmLqBFF9+Uvz7bMw/2OZKAeIfQDNcvpHPvMijCqwVGzqbctf
 C4NOZrk9hSR1HMqJqs7FUfuGUqNaifa5n8ExsbgyWumiIiTgicPXB8epa7xqZpfWWMZI
 3Ta0rIDmPbqYgrMzou0b5FTH+t3OeULZe2+Lll3eEI9D9fhIw4/4tbPS3RQHNDTXruiN NA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jrg4cumep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 07:49:56 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28N7ntW3014277
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 07:49:55 GMT
Received: from fenglinw2-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 23 Sep 2022 00:49:52 -0700
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
CC:     <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_fenglinw@quicinc.com>,
        David Collins <collinsd@codeaurora.org>
Subject: [PATCH v1 1/2] spmi: pmic-arb: add support to map SPMI addresses to physical addr
Date:   Fri, 23 Sep 2022 15:49:38 +0800
Message-ID: <20220923074939.2592244-2-quic_fenglinw@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220923074939.2592244-1-quic_fenglinw@quicinc.com>
References: <20220923074939.2592244-1-quic_fenglinw@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uRse436_NIh8N3-aVkZOVkTLdx8jwFrA
X-Proofpoint-ORIG-GUID: uRse436_NIh8N3-aVkZOVkTLdx8jwFrA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_02,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=917
 clxscore=1011 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209230049
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Collins <collinsd@codeaurora.org>

Add an exported function which can map an SPMI address to the
physical address range of the registers used to write to that
SPMI address.

The feature can be used by consumer drivers that need to lock
down access to certain PMIC peripherals temporarily for certain
secure use cases.

Signed-off-by: David Collins <collinsd@codeaurora.org>
Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
 drivers/spmi/spmi-pmic-arb.c           | 104 +++++++++++++++++++++++++
 include/linux/soc/qcom/spmi-pmic-arb.h |  23 ++++++
 2 files changed, 127 insertions(+)
 create mode 100644 include/linux/soc/qcom/spmi-pmic-arb.h

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 2cf3203b2397..1e7f5a9ff4bc 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -16,6 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spmi.h>
+#include <linux/soc/qcom/spmi-pmic-arb.h>
 
 /* PMIC Arbiter configuration registers */
 #define PMIC_ARB_VERSION		0x0000
@@ -124,6 +125,8 @@ struct apid_data {
  *
  * @rd_base:		on v1 "core", on v2 "observer" register base off DT.
  * @wr_base:		on v1 "core", on v2 "chnls"    register base off DT.
+ * @wr_base_phys:	base physical address of the register range used for
+ * 			SPMI write commands.
  * @intr:		address of the SPMI interrupt control registers.
  * @cnfg:		address of the PMIC Arbiter configuration registers.
  * @lock:		lock to synchronize accesses.
@@ -141,6 +144,7 @@ struct apid_data {
 struct spmi_pmic_arb {
 	void __iomem		*rd_base;
 	void __iomem		*wr_base;
+	phys_addr_t		wr_base_phys;
 	void __iomem		*intr;
 	void __iomem		*cnfg;
 	void __iomem		*core;
@@ -180,6 +184,9 @@ struct spmi_pmic_arb {
  * @irq_clear:		on v1 address of PMIC_ARB_SPMI_PIC_IRQ_CLEARn
  *			on v2 address of SPMI_PIC_IRQ_CLEARn.
  * @apid_map_offset:	offset of PMIC_ARB_REG_CHNLn
+ * @wr_addr_map:	maps from an SPMI address to the physical address
+ * 			range of the registers used to perform an SPMI write
+ * 			command to the SPMI address.
  */
 struct pmic_arb_ver_ops {
 	const char *ver_str;
@@ -196,6 +203,8 @@ struct pmic_arb_ver_ops {
 	void __iomem *(*irq_status)(struct spmi_pmic_arb *pmic_arb, u16 n);
 	void __iomem *(*irq_clear)(struct spmi_pmic_arb *pmic_arb, u16 n);
 	u32 (*apid_map_offset)(u16 n);
+	int (*wr_addr_map)(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
+			   struct resource *res_out);
 };
 
 static inline void pmic_arb_base_write(struct spmi_pmic_arb *pmic_arb,
@@ -972,6 +981,21 @@ static int pmic_arb_offset_v1(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
 	return 0x800 + 0x80 * pmic_arb->channel;
 }
 
+static int pmic_arb_wr_addr_map_v1(struct spmi_pmic_arb *pmic_arb, u8 sid,
+				   u16 addr, struct resource *res_out)
+{
+	int rc;
+
+	rc = pmic_arb_offset_v1(pmic_arb, sid, addr, PMIC_ARB_CHANNEL_RW);
+	if (rc < 0)
+		return rc;
+
+	res_out->start = pmic_arb->wr_base_phys + rc;
+	res_out->end = res_out->start + 0x80 - 1;
+
+	return 0;
+}
+
 static u16 pmic_arb_find_apid(struct spmi_pmic_arb *pmic_arb, u16 ppid)
 {
 	struct apid_data *apidd = &pmic_arb->apid_data[pmic_arb->last_apid];
@@ -1111,6 +1135,21 @@ static int pmic_arb_offset_v2(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
 	return 0x1000 * pmic_arb->ee + 0x8000 * apid;
 }
 
+static int pmic_arb_wr_addr_map_v2(struct spmi_pmic_arb *pmic_arb, u8 sid,
+				   u16 addr, struct resource *res_out)
+{
+	int rc;
+
+	rc = pmic_arb_offset_v2(pmic_arb, sid, addr, PMIC_ARB_CHANNEL_RW);
+	if (rc < 0)
+		return rc;
+
+	res_out->start = pmic_arb->wr_base_phys + rc;
+	res_out->end = res_out->start + 0x1000 - 1;
+
+	return 0;
+}
+
 /*
  * v5 offset per ee and per apid for observer channels and per apid for
  * read/write channels.
@@ -1145,6 +1184,21 @@ static int pmic_arb_offset_v5(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
 	return offset;
 }
 
+static int pmic_arb_wr_addr_map_v5(struct spmi_pmic_arb *pmic_arb, u8 sid,
+				   u16 addr, struct resource *res_out)
+{
+	int rc;
+
+	rc = pmic_arb_offset_v5(pmic_arb, sid, addr, PMIC_ARB_CHANNEL_RW);
+	if (rc < 0)
+		return rc;
+
+	res_out->start = pmic_arb->wr_base_phys + rc;
+	res_out->end = res_out->start + 0x10000 - 1;
+
+	return 0;
+}
+
 static u32 pmic_arb_fmt_cmd_v1(u8 opc, u8 sid, u16 addr, u8 bc)
 {
 	return (opc << 27) | ((sid & 0xf) << 20) | (addr << 4) | (bc & 0x7);
@@ -1254,6 +1308,7 @@ static const struct pmic_arb_ver_ops pmic_arb_v1 = {
 	.irq_status		= pmic_arb_irq_status_v1,
 	.irq_clear		= pmic_arb_irq_clear_v1,
 	.apid_map_offset	= pmic_arb_apid_map_offset_v2,
+	.wr_addr_map		= pmic_arb_wr_addr_map_v1,
 };
 
 static const struct pmic_arb_ver_ops pmic_arb_v2 = {
@@ -1267,6 +1322,7 @@ static const struct pmic_arb_ver_ops pmic_arb_v2 = {
 	.irq_status		= pmic_arb_irq_status_v2,
 	.irq_clear		= pmic_arb_irq_clear_v2,
 	.apid_map_offset	= pmic_arb_apid_map_offset_v2,
+	.wr_addr_map		= pmic_arb_wr_addr_map_v2,
 };
 
 static const struct pmic_arb_ver_ops pmic_arb_v3 = {
@@ -1280,6 +1336,7 @@ static const struct pmic_arb_ver_ops pmic_arb_v3 = {
 	.irq_status		= pmic_arb_irq_status_v2,
 	.irq_clear		= pmic_arb_irq_clear_v2,
 	.apid_map_offset	= pmic_arb_apid_map_offset_v2,
+	.wr_addr_map		= pmic_arb_wr_addr_map_v2,
 };
 
 static const struct pmic_arb_ver_ops pmic_arb_v5 = {
@@ -1293,6 +1350,7 @@ static const struct pmic_arb_ver_ops pmic_arb_v5 = {
 	.irq_status		= pmic_arb_irq_status_v5,
 	.irq_clear		= pmic_arb_irq_clear_v5,
 	.apid_map_offset	= pmic_arb_apid_map_offset_v5,
+	.wr_addr_map		= pmic_arb_wr_addr_map_v5,
 };
 
 static const struct irq_domain_ops pmic_arb_irq_domain_ops = {
@@ -1302,6 +1360,50 @@ static const struct irq_domain_ops pmic_arb_irq_domain_ops = {
 	.translate = qpnpint_irq_domain_translate,
 };
 
+static int _spmi_pmic_arb_map_address(struct spmi_pmic_arb *pmic_arb,
+				u32 spmi_address, struct resource *res_out)
+{
+	u32 sid, addr;
+
+	sid = (spmi_address >> 16) & 0xF;
+	addr = spmi_address & 0xFFFF;
+
+	return pmic_arb->ver_ops->wr_addr_map(pmic_arb, sid, addr, res_out);
+}
+
+/**
+ * spmi_pmic_arb_map_address() - returns physical addresses of registers used to
+ *		write to the PMIC peripheral at spmi_address
+ * @ctrl:		SPMI controller device pointer
+ * @spmi_address:	20-bit SPMI address of the form: 0xSPPPP
+ *			where S = global PMIC SID and
+ *			PPPP = SPMI address within the slave
+ * @res_out:		Resource struct (allocated by the caller) in which
+ *			physical addresses for the range are passed via start
+ *			and end elements
+ *
+ * Returns: 0 on success or an errno on failure.
+ */
+int spmi_pmic_arb_map_address(struct spmi_controller *ctrl, u32 spmi_address,
+			      struct resource *res_out)
+{
+	struct spmi_pmic_arb *pmic_arb;
+
+	if (!ctrl || !res_out) {
+		pr_err("%s: Invalid pointer\n", __func__);
+		return -EINVAL;
+	}
+
+	pmic_arb = spmi_controller_get_drvdata(ctrl);
+	if (!pmic_arb) {
+		pr_err("Missing PMIC arbiter device\n");
+		return -ENODEV;
+	}
+
+	return _spmi_pmic_arb_map_address(pmic_arb, spmi_address, res_out);
+}
+EXPORT_SYMBOL(spmi_pmic_arb_map_address);
+
 static int spmi_pmic_arb_probe(struct platform_device *pdev)
 {
 	struct spmi_pmic_arb *pmic_arb;
@@ -1341,6 +1443,7 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 	if (hw_ver < PMIC_ARB_VERSION_V2_MIN) {
 		pmic_arb->ver_ops = &pmic_arb_v1;
 		pmic_arb->wr_base = core;
+		pmic_arb->wr_base_phys = res->start;
 		pmic_arb->rd_base = core;
 	} else {
 		pmic_arb->core = core;
@@ -1367,6 +1470,7 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 			err = PTR_ERR(pmic_arb->wr_base);
 			goto err_put_ctrl;
 		}
+		pmic_arb->wr_base_phys = res->start;
 	}
 
 	dev_info(&ctrl->dev, "PMIC arbiter version %s (0x%x)\n",
diff --git a/include/linux/soc/qcom/spmi-pmic-arb.h b/include/linux/soc/qcom/spmi-pmic-arb.h
new file mode 100644
index 000000000000..adb999d6e246
--- /dev/null
+++ b/include/linux/soc/qcom/spmi-pmic-arb.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2020, The Linux Foundation. All rights reserved. */
+
+#ifndef _SPMI_PMIC_ARB_H
+#define _SPMI_PMIC_ARB_H
+
+#include <linux/spmi.h>
+#include <linux/ioport.h>
+#include <linux/types.h>
+
+
+#if IS_ENABLED(CONFIG_SPMI_MSM_PMIC_ARB)
+int spmi_pmic_arb_map_address(struct spmi_controller *ctrl, u32 spmi_address,
+			      struct resource *res_out);
+#else
+static inline int spmi_pmic_arb_map_address(struct spmi_controller *ctrl,
+				u32 spmi_address, struct resource *res_out)
+{
+	return -ENODEV;
+}
+#endif
+
+#endif
-- 
2.25.1

