Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBDB6760C1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 23:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjATWuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 17:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjATWuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 17:50:09 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C359C4DBDF;
        Fri, 20 Jan 2023 14:49:26 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KLvekf003343;
        Fri, 20 Jan 2023 22:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=w6/aHGaEUJiqoCCNWVVmdNmnpXulOdKevHNVnLS9tfw=;
 b=hMLgkUDpPUW2CE6uo1tfIsnKGboCUqJpscYvRG5uUbLY2GjdFz035TJpdZWFbyKnALUW
 f5W6N3BsRhzaPZH6vcAx8o4SsrE280Luobmll+d60qSp8w2l0lk0AGmQzMqRZLG/F8eP
 8fXMpd4MgvJVCsKJcHKy384Tx6+TYPzeA/91yU2elqcFo/+C0BBirCSRqBF3jgifKWwy
 Jt4Y50GYPqBo5AntJyDsajwxIcf5R+buOxEZNLFvZtOCZ9RSiDNC+8CSF8I1g2SB16V9
 WtuLtD6x9Q9vOdfSrVK9jYQWhmEnd2s37REYt/bwrhvLSZGLo+nSW7rpI4di0EOeviWL yg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n7593uqyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 22:48:13 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30KMmC59005805
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 22:48:12 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 20 Jan 2023 14:48:11 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>
CC:     Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v9 27/27] virt: gunyah: Add ioeventfd
Date:   Fri, 20 Jan 2023 14:46:26 -0800
Message-ID: <20230120224627.4053418-28-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120224627.4053418-1-quic_eberman@quicinc.com>
References: <20230120224627.4053418-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6VKb8RmDFqQGIsBLbynaHrsPWYv04-50
X-Proofpoint-ORIG-GUID: 6VKb8RmDFqQGIsBLbynaHrsPWYv04-50
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_11,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301200218
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow userspace to attach an ioeventfd to an mmio address within the guest.

Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 Documentation/virt/gunyah/vm-manager.rst |  21 +++++
 drivers/virt/gunyah/Kconfig              |   9 ++
 drivers/virt/gunyah/Makefile             |   1 +
 drivers/virt/gunyah/gunyah_ioeventfd.c   | 109 +++++++++++++++++++++++
 include/uapi/linux/gunyah.h              |  10 +++
 5 files changed, 150 insertions(+)
 create mode 100644 drivers/virt/gunyah/gunyah_ioeventfd.c

diff --git a/Documentation/virt/gunyah/vm-manager.rst b/Documentation/virt/gunyah/vm-manager.rst
index b6cf8db826b8..19ec859a7912 100644
--- a/Documentation/virt/gunyah/vm-manager.rst
+++ b/Documentation/virt/gunyah/vm-manager.rst
@@ -164,3 +164,24 @@ the irqfd.label.
 
 GH_IRQFD_LEVEL configures the corresponding doorbell to behave like a level
 triggered interrupt.
+
+Type: "ioeventfd"
+^^^^^^^^^^^^^^^^^
+
+::
+
+  struct gh_fn_ioeventfd_arg {
+	__u64 datamatch;
+	__u64 addr;        /* legal mmio address */
+	__u32 len;         /* 1, 2, 4, or 8 bytes */
+	__s32 fd;
+  #define GH_IOEVENTFD_DATAMATCH		(1UL << 0)
+	__u32 flags;
+  };
+
+Attaches an ioeventfd to a legal mmio address within the guest. A guest write
+in the registered address will signal the provided event instead of triggering
+an exit on the GH_VCPU_RUN ioctl.
+
+If datamatch flag is set, the event will be signaled only if the written value
+to the registered address is equal to datamatch in struct gh_fn_ioeventfd_arg.
diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
index 2cde24d429d1..bd8e31184962 100644
--- a/drivers/virt/gunyah/Kconfig
+++ b/drivers/virt/gunyah/Kconfig
@@ -35,3 +35,12 @@ config GUNYAH_IRQFD
 	  on Gunyah virtual machine.
 
 	  Say Y/M here if unsure and you want to support Gunyah VMMs.
+
+config GUNYAH_IOEVENTFD
+	tristate "Gunyah ioeventfd interface"
+	depends on GUNYAH
+	help
+	  Enable kernel support for creating ioeventfds which can alert userspace
+	  when a Gunyah virtual machine accesses a memory address.
+
+	  Say Y/M here if unsure and you want to support Gunyah VMMs.
diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index 6cf756bfa3c2..7347b1470491 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_GUNYAH) += gunyah_rsc_mgr.o
 
 obj-$(CONFIG_GUNYAH_VCPU) += gunyah_vcpu.o
 obj-$(CONFIG_GUNYAH_IRQFD) += gunyah_irqfd.o
+obj-$(CONFIG_GUNYAH_IOEVENTFD) += gunyah_ioeventfd.o
diff --git a/drivers/virt/gunyah/gunyah_ioeventfd.c b/drivers/virt/gunyah/gunyah_ioeventfd.c
new file mode 100644
index 000000000000..c16a6725fe7e
--- /dev/null
+++ b/drivers/virt/gunyah/gunyah_ioeventfd.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/eventfd.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/gunyah.h>
+#include <linux/gunyah_vm_mgr.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+
+#include <uapi/linux/gunyah.h>
+
+struct gunyah_ioeventfd {
+	struct gunyah_vm_function *f;
+	struct gunyah_vm_io_handler io_handler;
+
+	struct eventfd_ctx *ctx;
+};
+
+static int gh_write_ioeventfd(struct gunyah_vm_io_handler *io_dev, u64 addr, u32 len, u64 data)
+{
+	struct gunyah_ioeventfd *iofd = container_of(io_dev, struct gunyah_ioeventfd, io_handler);
+
+	eventfd_signal(iofd->ctx, 1);
+	return 0;
+}
+
+static struct gunyah_vm_io_handler_ops io_ops = {
+	.write = gh_write_ioeventfd,
+};
+
+static long gunyah_ioeventfd_bind(struct gunyah_vm_function *f)
+{
+	struct eventfd_ctx *ctx = NULL;
+	struct gunyah_ioeventfd *iofd;
+	const struct gh_fn_ioeventfd_arg *args = &f->fn.ioeventfd;
+	int ret;
+
+	/* must be natural-word sized, or 0 to ignore length */
+	switch (args->len) {
+	case 0:
+	case 1:
+	case 2:
+	case 4:
+	case 8:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* check for range overflow */
+	if (args->addr + args->len < args->addr)
+		return -EINVAL;
+
+	/* ioeventfd with no length can't be combined with DATAMATCH */
+	if (!args->len && (args->flags & GH_IOEVENTFD_DATAMATCH))
+		return -EINVAL;
+
+	ctx = eventfd_ctx_fdget(args->fd);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	iofd = kzalloc(sizeof(*iofd), GFP_KERNEL);
+	if (!iofd) {
+		ret = -ENOMEM;
+		goto err_eventfd;
+	}
+
+	f->data = iofd;
+	iofd->f = f;
+
+	iofd->ctx = ctx;
+
+	if (args->flags & GH_IOEVENTFD_DATAMATCH) {
+		iofd->io_handler.datamatch = true;
+		iofd->io_handler.len = args->len;
+		iofd->io_handler.data = args->datamatch;
+	}
+	iofd->io_handler.addr = args->addr;
+	iofd->io_handler.ops = &io_ops;
+
+	ret = gh_vm_mgr_add_io_handler(f->ghvm, &iofd->io_handler);
+	if (ret)
+		goto err_io_dev_add;
+
+	return 0;
+
+err_io_dev_add:
+	kfree(iofd);
+err_eventfd:
+	eventfd_ctx_put(ctx);
+	return ret;
+}
+
+static void gunyah_ioeventfd_release(struct gunyah_vm_function *f)
+{
+	struct gunyah_ioeventfd *iofd = f->data;
+
+	eventfd_ctx_put(iofd->ctx);
+	gh_vm_mgr_remove_io_handler(iofd->f->ghvm, &iofd->io_handler);
+	kfree(iofd);
+}
+
+DECLARE_GUNYAH_VM_FUNCTION_INIT(ioeventfd, gunyah_ioeventfd_bind, gunyah_ioeventfd_release);
+MODULE_DESCRIPTION("Gunyah ioeventfds");
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
index a947f0317ca9..3cc387f0831a 100644
--- a/include/uapi/linux/gunyah.h
+++ b/include/uapi/linux/gunyah.h
@@ -65,11 +65,21 @@ struct gh_fn_irqfd_arg {
 	__u32 flags;
 };
 
+struct gh_fn_ioeventfd_arg {
+	__u64 datamatch;
+	__u64 addr;        /* legal mmio address */
+	__u32 len;         /* 1, 2, 4, or 8 bytes; or 0 to ignore length */
+	__s32 fd;
+#define GH_IOEVENTFD_DATAMATCH		(1UL << 0)
+	__u32 flags;
+};
+
 struct gh_vm_function {
 	char name[GUNYAH_FUNCTION_NAME_SIZE];
 	union {
 		struct gh_fn_vcpu_arg vcpu;
 		struct gh_fn_irqfd_arg irqfd;
+		struct gh_fn_ioeventfd_arg ioeventfd;
 		char data[GUNYAH_FUNCTION_MAX_ARG_SIZE];
 	};
 };
-- 
2.39.0

