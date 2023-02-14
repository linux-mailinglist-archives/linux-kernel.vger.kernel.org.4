Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16E0697001
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 22:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjBNVqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 16:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjBNVqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 16:46:10 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F299029400;
        Tue, 14 Feb 2023 13:46:08 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31ELHFtl027210;
        Tue, 14 Feb 2023 21:25:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=XFIbjyjqBQ0YC71kR7vks/UO90Rz2T2TuIWzalc6tiI=;
 b=HVcDH1TCvKCeFPTooCj1iwZfuGQ7XtQ22SGOB8nLH0i0pkB02jujmQ6YuNSav8tzUwPA
 TJ4tzHrnoufGvvDkO6BGU7XE6pJA3tLRo82midoHJYGBH680VmW8egKAgUMTp1dECn1F
 sToMsYkujDuBRxME0F2mctMCrswOjM9NX/TZnNye1EgK98AKGo5qiZg+hLHk8ncSmkjJ
 aYbfII0tQC65fsczXXRx5WrzBLLN8KBIoQtrD7ENO/G89gvEXb4WwOxSRHz8RQbzS8mN
 3/Z+fSc98nI06owh6dSeHmRPcxBaraVknJkwuGHlYjCi4E4Uk1eH47PbDTjg4N2EXkJh nQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqyygttx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 21:25:31 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31ELPUmV001471
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 21:25:30 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 14 Feb 2023 13:25:29 -0800
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
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v10 18/26] virt: gunyah: Translate gh_rm_hyp_resource into gunyah_resource
Date:   Tue, 14 Feb 2023 13:25:20 -0800
Message-ID: <20230214212521.3322247-1-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214211229.3239350-1-quic_eberman@quicinc.com>
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eKEr1g2BVd_PtdDwXMlAEEUR0RkxzYGK
X-Proofpoint-GUID: eKEr1g2BVd_PtdDwXMlAEEUR0RkxzYGK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_15,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 malwarescore=0 adultscore=0 mlxlogscore=947 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140184
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 arch/arm64/include/asm/gunyah.h |  23 +++++
 drivers/virt/gunyah/rsc_mgr.c   | 161 +++++++++++++++++++++++++++++++-
 include/linux/gunyah.h          |   4 +
 include/linux/gunyah_rsc_mgr.h  |   4 +
 4 files changed, 191 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/gunyah.h

diff --git a/arch/arm64/include/asm/gunyah.h b/arch/arm64/include/asm/gunyah.h
new file mode 100644
index 000000000000..64cfb964efee
--- /dev/null
+++ b/arch/arm64/include/asm/gunyah.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#ifndef __ASM_GUNYAH_H_
+#define __ASM_GUNYAH_H_
+
+#include <linux/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+static inline int arch_gh_fill_irq_fwspec_params(u32 virq, struct irq_fwspec *fwspec)
+{
+	if (virq < 32 || virq > 1019)
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
index 73c5a6b7cbbc..eb1bc3f68792 100644
--- a/drivers/virt/gunyah/rsc_mgr.c
+++ b/drivers/virt/gunyah/rsc_mgr.c
@@ -18,6 +18,8 @@
 #include <linux/platform_device.h>
 #include <linux/miscdevice.h>
 
+#include <asm/gunyah.h>
+
 #include "rsc_mgr.h"
 #include "vm_mgr.h"
 
@@ -107,8 +109,137 @@ struct gh_rm {
 	struct blocking_notifier_head nh;
 
 	struct miscdevice miscdev;
+	struct irq_domain *irq_domain;
+};
+
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
+	struct irq_fwspec parent_fwspec;
+	struct gh_rm *rm = d->host_data;
+	u32 gh_virq = spec->gh_virq;
+	int ret;
+
+	if (nr_irqs != 1 || gh_virq == U32_MAX)
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
+		return ret;
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
+	struct gh_irq_chip_data *chip_data;
+	struct irq_data *irq_data;
+
+	irq_data = irq_domain_get_irq_data(d, virq);
+	if (!irq_data)
+		return;
+
+	chip_data = irq_data->chip_data;
+
+	kfree(chip_data);
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
 };
 
+struct gunyah_resource *gh_rm_alloc_resource(struct gh_rm *rm,
+						struct gh_rm_hyp_resource *hyp_resource)
+{
+	struct gunyah_resource *ghrsc;
+
+	ghrsc = kzalloc(sizeof(*ghrsc), GFP_KERNEL);
+	if (!ghrsc)
+		return NULL;
+
+	ghrsc->type = hyp_resource->type;
+	ghrsc->capid = le64_to_cpu(hyp_resource->cap_id);
+	ghrsc->irq = IRQ_NOTCONNECTED;
+	ghrsc->rm_label = le32_to_cpu(hyp_resource->resource_label);
+	if (hyp_resource->virq && le32_to_cpu(hyp_resource->virq) != U32_MAX) {
+		struct gh_irq_chip_data irq_data = {
+			.gh_virq = le32_to_cpu(hyp_resource->virq),
+		};
+
+		ghrsc->irq = irq_domain_alloc_irqs(rm->irq_domain, 1, NUMA_NO_NODE, &irq_data);
+		if (ghrsc->irq < 0) {
+			pr_err("Failed to allocate interrupt for resource %d label: %d: %d\n",
+				ghrsc->type, ghrsc->rm_label, ghrsc->irq);
+			ghrsc->irq = IRQ_NOTCONNECTED;
+		}
+	}
+
+	return ghrsc;
+}
+
+void gh_rm_free_resource(struct gunyah_resource *ghrsc)
+{
+	irq_dispose_mapping(ghrsc->irq);
+	kfree(ghrsc);
+}
+
 static struct gh_rm_connection *gh_rm_alloc_connection(__le32 msg_id, u8 type)
 {
 	struct gh_rm_connection *connection;
@@ -553,6 +684,8 @@ static int gh_msgq_platform_probe_direction(struct platform_device *pdev,
 
 static int gh_rm_drv_probe(struct platform_device *pdev)
 {
+	struct irq_domain *parent_irq_domain;
+	struct device_node *parent_irq_node;
 	struct gh_msgq_tx_data *msg;
 	struct gh_rm *rm;
 	int ret;
@@ -590,15 +723,40 @@ static int gh_rm_drv_probe(struct platform_device *pdev)
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
 	mbox_free_channel(gh_msgq_chan(&rm->msgq));
 	gh_msgq_remove(&rm->msgq);
@@ -612,6 +770,7 @@ static int gh_rm_drv_remove(struct platform_device *pdev)
 	struct gh_rm *rm = platform_get_drvdata(pdev);
 
 	misc_deregister(&rm->miscdev);
+	irq_domain_remove(rm->irq_domain);
 	mbox_free_channel(gh_msgq_chan(&rm->msgq));
 	gh_msgq_remove(&rm->msgq);
 	kmem_cache_destroy(rm->cache);
diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
index 2e13669c6363..a06d5fa68a65 100644
--- a/include/linux/gunyah.h
+++ b/include/linux/gunyah.h
@@ -27,6 +27,10 @@ struct gunyah_resource {
 	enum gunyah_resource_type type;
 	u64 capid;
 	int irq;
+
+	/* To help allocator of resource manager */
+	struct list_head list;
+	u32 rm_label;
 };
 
 /**
diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
index dc05d5b1e1a3..2fb6efbe2f70 100644
--- a/include/linux/gunyah_rsc_mgr.h
+++ b/include/linux/gunyah_rsc_mgr.h
@@ -147,6 +147,10 @@ int gh_rm_get_hyp_resources(struct gh_rm *rm, u16 vmid,
 				struct gh_rm_hyp_resources **resources);
 int gh_rm_get_vmid(struct gh_rm *rm, u16 *vmid);
 
+struct gunyah_resource *gh_rm_alloc_resource(struct gh_rm *rm,
+						struct gh_rm_hyp_resource *hyp_resource);
+void gh_rm_free_resource(struct gunyah_resource *ghrsc);
+
 struct gunyah_rm_platform_ops {
 	int (*pre_mem_share)(struct gh_rm *rm, struct gh_rm_mem_parcel *mem_parcel);
 	int (*post_mem_reclaim)(struct gh_rm *rm, struct gh_rm_mem_parcel *mem_parcel);
-- 
2.39.1

