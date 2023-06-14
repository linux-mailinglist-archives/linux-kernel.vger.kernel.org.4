Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A640072E98F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239774AbjFMRXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239430AbjFMRXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:23:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AFF2107;
        Tue, 13 Jun 2023 10:22:09 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DAcB7U013140;
        Tue, 13 Jun 2023 17:21:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=4/SA01msRGmq1EICw6Qrx94Nx9mcHg58f7FWx5ylvo4=;
 b=bmW/UAvfsq19QMnyXzmEFLrw+GdyXR3UikR3iQ3Xm5Vuytl7F8pRkeAruZcRijcBzX47
 3OuEE2aKHLU0nyHxVgCRC/ayDKju8EdEXqYELpBcrxlhc5QAHzp6EiZBW61VnRNNKOa6
 GwlVLjqM69N2wzNTnl8H+aREohgCYjNKoknemhdfR8oqSgpt3oOMQXrB0wSxUPr2moym
 nKJ115ol/qYIkRRvgmQhvs68Kbl4hsSy5G8METXKyyziK47HOJ6IyImxOeJjHpcTpfRY
 ycDycTxnq6V7V5CBLN5iThigGzXvzahj6h8nbygWzc+c+K31ZMJpV8C9//CxbcWBNVAN Dg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r6km41d51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 17:21:46 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35DHLjAV013331
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 17:21:45 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 13 Jun 2023 10:21:44 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
CC:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v14 17/25] virt: gunyah: Translate gh_rm_hyp_resource into gunyah_resource
Date:   Tue, 13 Jun 2023 10:20:45 -0700
Message-ID: <20230613172054.3959700-18-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230613172054.3959700-1-quic_eberman@quicinc.com>
References: <20230613172054.3959700-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: m_wtWEYHroWtSy94Sy66X03BvXvtp2S1
X-Proofpoint-GUID: m_wtWEYHroWtSy94Sy66X03BvXvtp2S1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_18,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 impostorscore=0 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306130153
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When booting a Gunyah virtual machine, the host VM may gain capabilities
to interact with resources for the guest virtual machine. Examples of
such resources are vCPUs or message queues. To use those resources, we
need to translate the RM response into a gunyah_resource structure which
are useful to Linux drivers. Presently, Linux drivers need only to know
the type of resource, the capability ID, and an interrupt.

On ARM64 systems, the interrupt reported by Gunyah is the GIC interrupt
ID number and always a SPI.

Reviewed-by: Alex Elder <elder@linaro.org>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 arch/arm64/include/asm/gunyah.h |  24 +++++
 drivers/virt/gunyah/rsc_mgr.c   | 164 +++++++++++++++++++++++++++++++-
 include/linux/gunyah.h          |   3 +
 include/linux/gunyah_rsc_mgr.h  |   3 +
 4 files changed, 193 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/gunyah.h

diff --git a/arch/arm64/include/asm/gunyah.h b/arch/arm64/include/asm/gunyah.h
new file mode 100644
index 0000000000000..c83d983b0f4e0
--- /dev/null
+++ b/arch/arm64/include/asm/gunyah.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#ifndef _ASM_GUNYAH_H
+#define _ASM_GUNYAH_H
+
+#include <linux/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+static inline int arch_gh_fill_irq_fwspec_params(u32 virq, struct irq_fwspec *fwspec)
+{
+	/* Assume that Gunyah gave us an SPI; defensively check it */
+	if (WARN_ON(virq < 32 || virq > 1019))
+		return -EINVAL;
+
+	fwspec->param_count = 3;
+	fwspec->param[0] = GIC_SPI;
+	fwspec->param[1] = virq - 32;
+	fwspec->param[2] = IRQ_TYPE_EDGE_RISING;
+	return 0;
+}
+
+#endif
diff --git a/drivers/virt/gunyah/rsc_mgr.c b/drivers/virt/gunyah/rsc_mgr.c
index a0faf126ee56e..3255ae1855990 100644
--- a/drivers/virt/gunyah/rsc_mgr.c
+++ b/drivers/virt/gunyah/rsc_mgr.c
@@ -17,6 +17,8 @@
 #include <linux/platform_device.h>
 #include <linux/miscdevice.h>
 
+#include <asm/gunyah.h>
+
 #include "rsc_mgr.h"
 #include "vm_mgr.h"
 
@@ -133,6 +135,7 @@ struct gh_rm_connection {
  * @send_lock: synchronization to allow only one request to be sent at a time
  * @nh: notifier chain for clients interested in RM notification messages
  * @miscdev: /dev/gunyah
+ * @irq_domain: Domain to translate Gunyah hwirqs to Linux irqs
  */
 struct gh_rm {
 	struct device *dev;
@@ -151,6 +154,7 @@ struct gh_rm {
 	struct blocking_notifier_head nh;
 
 	struct miscdevice miscdev;
+	struct irq_domain *irq_domain;
 };
 
 /**
@@ -191,6 +195,135 @@ static inline int gh_rm_error_remap(enum gh_rm_error rm_error)
 	}
 }
 
+struct gh_irq_chip_data {
+	u32 gh_virq;
+};
+
+static struct irq_chip gh_rm_irq_chip = {
+	.name			= "Gunyah",
+	.irq_enable		= irq_chip_enable_parent,
+	.irq_disable		= irq_chip_disable_parent,
+	.irq_ack		= irq_chip_ack_parent,
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_mask_ack		= irq_chip_mask_ack_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.irq_set_type		= irq_chip_set_type_parent,
+	.irq_set_wake		= irq_chip_set_wake_parent,
+	.irq_set_vcpu_affinity	= irq_chip_set_vcpu_affinity_parent,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_get_irqchip_state	= irq_chip_get_parent_state,
+	.irq_set_irqchip_state	= irq_chip_set_parent_state,
+	.flags			= IRQCHIP_SET_TYPE_MASKED |
+				  IRQCHIP_SKIP_SET_WAKE |
+				  IRQCHIP_MASK_ON_SUSPEND,
+};
+
+static int gh_rm_irq_domain_alloc(struct irq_domain *d, unsigned int virq, unsigned int nr_irqs,
+				 void *arg)
+{
+	struct gh_irq_chip_data *chip_data, *spec = arg;
+	struct irq_fwspec parent_fwspec = {};
+	struct gh_rm *rm = d->host_data;
+	u32 gh_virq = spec->gh_virq;
+	int ret;
+
+	if (nr_irqs != 1)
+		return -EINVAL;
+
+	chip_data = kzalloc(sizeof(*chip_data), GFP_KERNEL);
+	if (!chip_data)
+		return -ENOMEM;
+
+	chip_data->gh_virq = gh_virq;
+
+	ret = irq_domain_set_hwirq_and_chip(d, virq, chip_data->gh_virq, &gh_rm_irq_chip,
+						chip_data);
+	if (ret)
+		goto err_free_irq_data;
+
+	parent_fwspec.fwnode = d->parent->fwnode;
+	ret = arch_gh_fill_irq_fwspec_params(chip_data->gh_virq, &parent_fwspec);
+	if (ret) {
+		dev_err(rm->dev, "virq translation failed %u: %d\n", chip_data->gh_virq, ret);
+		goto err_free_irq_data;
+	}
+
+	ret = irq_domain_alloc_irqs_parent(d, virq, nr_irqs, &parent_fwspec);
+	if (ret)
+		goto err_free_irq_data;
+
+	return ret;
+err_free_irq_data:
+	kfree(chip_data);
+	return ret;
+}
+
+static void gh_rm_irq_domain_free_single(struct irq_domain *d, unsigned int virq)
+{
+	struct irq_data *irq_data;
+
+	irq_data = irq_domain_get_irq_data(d, virq);
+	if (!irq_data)
+		return;
+
+	kfree(irq_data->chip_data);
+	irq_data->chip_data = NULL;
+}
+
+static void gh_rm_irq_domain_free(struct irq_domain *d, unsigned int virq, unsigned int nr_irqs)
+{
+	unsigned int i;
+
+	for (i = 0; i < nr_irqs; i++)
+		gh_rm_irq_domain_free_single(d, virq);
+}
+
+static const struct irq_domain_ops gh_rm_irq_domain_ops = {
+	.alloc		= gh_rm_irq_domain_alloc,
+	.free		= gh_rm_irq_domain_free,
+};
+
+struct gh_resource *gh_rm_alloc_resource(struct gh_rm *rm, struct gh_rm_hyp_resource *hyp_resource)
+{
+	struct gh_resource *ghrsc;
+	int ret;
+
+	ghrsc = kzalloc(sizeof(*ghrsc), GFP_KERNEL);
+	if (!ghrsc)
+		return NULL;
+
+	ghrsc->type = hyp_resource->type;
+	ghrsc->capid = le64_to_cpu(hyp_resource->cap_id);
+	ghrsc->irq = IRQ_NOTCONNECTED;
+	ghrsc->rm_label = le32_to_cpu(hyp_resource->resource_label);
+	if (hyp_resource->virq) {
+		struct gh_irq_chip_data irq_data = {
+			.gh_virq = le32_to_cpu(hyp_resource->virq),
+		};
+
+		ret = irq_domain_alloc_irqs(rm->irq_domain, 1, NUMA_NO_NODE, &irq_data);
+		if (ret < 0) {
+			dev_err(rm->dev,
+				"Failed to allocate interrupt for resource %d label: %d: %d\n",
+				ghrsc->type, ghrsc->rm_label, ret);
+			kfree(ghrsc);
+			return NULL;
+		} else {
+			ghrsc->irq = ret;
+		}
+	}
+
+	return ghrsc;
+}
+
+void gh_rm_free_resource(struct gh_resource *ghrsc)
+{
+	irq_dispose_mapping(ghrsc->irq);
+	kfree(ghrsc);
+}
+
 static int gh_rm_init_connection_payload(struct gh_rm_connection *connection, void *msg,
 					size_t hdr_size, size_t msg_size)
 {
@@ -660,6 +793,8 @@ static int gh_identify(void)
 
 static int gh_rm_drv_probe(struct platform_device *pdev)
 {
+	struct irq_domain *parent_irq_domain;
+	struct device_node *parent_irq_node;
 	struct gh_msgq_tx_data *msg;
 	struct gh_rm *rm;
 	int ret;
@@ -700,15 +835,41 @@ static int gh_rm_drv_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_cache;
 
+	parent_irq_node = of_irq_find_parent(pdev->dev.of_node);
+	if (!parent_irq_node) {
+		dev_err(&pdev->dev, "Failed to find interrupt parent of resource manager\n");
+		ret = -ENODEV;
+		goto err_msgq;
+	}
+
+	parent_irq_domain = irq_find_host(parent_irq_node);
+	if (!parent_irq_domain) {
+		dev_err(&pdev->dev, "Failed to find interrupt parent domain of resource manager\n");
+		ret = -ENODEV;
+		goto err_msgq;
+	}
+
+	rm->irq_domain = irq_domain_add_hierarchy(parent_irq_domain, 0, 0, pdev->dev.of_node,
+							&gh_rm_irq_domain_ops, NULL);
+	if (!rm->irq_domain) {
+		dev_err(&pdev->dev, "Failed to add irq domain\n");
+		ret = -ENODEV;
+		goto err_msgq;
+	}
+	rm->irq_domain->host_data = rm;
+
+	rm->miscdev.parent = &pdev->dev;
 	rm->miscdev.name = "gunyah";
 	rm->miscdev.minor = MISC_DYNAMIC_MINOR;
 	rm->miscdev.fops = &gh_dev_fops;
 
 	ret = misc_register(&rm->miscdev);
 	if (ret)
-		goto err_msgq;
+		goto err_irq_domain;
 
 	return 0;
+err_irq_domain:
+	irq_domain_remove(rm->irq_domain);
 err_msgq:
 	gh_msgq_remove(&rm->msgq);
 err_cache:
@@ -721,6 +882,7 @@ static int gh_rm_drv_remove(struct platform_device *pdev)
 	struct gh_rm *rm = platform_get_drvdata(pdev);
 
 	misc_deregister(&rm->miscdev);
+	irq_domain_remove(rm->irq_domain);
 	gh_msgq_remove(&rm->msgq);
 	kmem_cache_destroy(rm->cache);
 
diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
index 982e27d10d57f..4b398b59c2c5a 100644
--- a/include/linux/gunyah.h
+++ b/include/linux/gunyah.h
@@ -27,6 +27,9 @@ struct gh_resource {
 	enum gh_resource_type type;
 	u64 capid;
 	unsigned int irq;
+
+	struct list_head list;
+	u32 rm_label;
 };
 
 /**
diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
index cac4476b46ade..c0cf8b4dc7beb 100644
--- a/include/linux/gunyah_rsc_mgr.h
+++ b/include/linux/gunyah_rsc_mgr.h
@@ -139,6 +139,9 @@ int gh_rm_get_hyp_resources(struct gh_rm *rm, u16 vmid,
 				struct gh_rm_hyp_resources **resources);
 int gh_rm_get_vmid(struct gh_rm *rm, u16 *vmid);
 
+struct gh_resource *gh_rm_alloc_resource(struct gh_rm *rm, struct gh_rm_hyp_resource *hyp_resource);
+void gh_rm_free_resource(struct gh_resource *ghrsc);
+
 struct gh_rm_platform_ops {
 	int (*pre_mem_share)(struct gh_rm *rm, struct gh_rm_mem_parcel *mem_parcel);
 	int (*post_mem_reclaim)(struct gh_rm *rm, struct gh_rm_mem_parcel *mem_parcel);
-- 
2.40.0

