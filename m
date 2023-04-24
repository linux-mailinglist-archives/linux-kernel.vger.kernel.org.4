Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08AD6ED8CF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 01:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjDXX3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 19:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjDXX3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 19:29:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EABBD;
        Mon, 24 Apr 2023 16:29:35 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33OMsNSv013670;
        Mon, 24 Apr 2023 23:17:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=LqdXFjJd4ejcfQ68KiODkobeez3LzlbLJ/euPiBm1MI=;
 b=d8xlIAeGd40lvRzUBP+XSGitKHVDHITQEts4keAJ2C3y5U6L+yxJRLvsPmN2Q/iiuQck
 bXAWgl4rfydgbuv38zYu5DXoz9suvpW5Xv45FO3HrXomDGk4Uje5jHnGz7oHcs934+hg
 f0vX9MuPAMHZzXadB0FEs46R4J2SIbOEU0KQhS3XkVZBwNofowoTYJosz9Qer3kd78vr
 gL1tM1dOhLzzMTdzjtMTaN3ts/ozu8SyR5bk9044UPQL10AuTtTcH64u63fpx3u/ytAV
 4tW3GFgkK8v4xvRBxkA7yEi0BcbCfyL+DVe9jYvbiFz5CDWmCEaK2J6UoDvaL4dwnkAm Kg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q628x83cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 23:17:05 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33ONH5tO001574
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 23:17:05 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 24 Apr 2023 16:17:04 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>
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
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v12 24/25] virt: gunyah: Add ioeventfd
Date:   Mon, 24 Apr 2023 16:15:57 -0700
Message-ID: <20230424231558.70911-25-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230424231558.70911-1-quic_eberman@quicinc.com>
References: <20230424231558.70911-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Pd1y1fU33_4Te-idwVQ17Le8eHwJEsDl
X-Proofpoint-ORIG-GUID: Pd1y1fU33_4Te-idwVQ17Le8eHwJEsDl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_11,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304240211
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
 Documentation/virt/gunyah/vm-manager.rst |   2 +-
 drivers/virt/gunyah/Kconfig              |   9 ++
 drivers/virt/gunyah/Makefile             |   1 +
 drivers/virt/gunyah/gunyah_ioeventfd.c   | 117 +++++++++++++++++++++++
 include/uapi/linux/gunyah.h              |  37 +++++++
 5 files changed, 165 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virt/gunyah/gunyah_ioeventfd.c

diff --git a/Documentation/virt/gunyah/vm-manager.rst b/Documentation/virt/gunyah/vm-manager.rst
index c4960948c779..87838c5b5945 100644
--- a/Documentation/virt/gunyah/vm-manager.rst
+++ b/Documentation/virt/gunyah/vm-manager.rst
@@ -115,7 +115,7 @@ the VM *before* the VM starts.
 The argument types are documented below:
 
 .. kernel-doc:: include/uapi/linux/gunyah.h
-   :identifiers: gh_fn_vcpu_arg gh_fn_irqfd_arg gh_irqfd_flags
+   :identifiers: gh_fn_vcpu_arg gh_fn_irqfd_arg gh_irqfd_flags gh_fn_ioeventfd_arg gh_ioeventfd_flags
 
 Gunyah VCPU API Descriptions
 ----------------------------
diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
index bc2c46d9df94..63bebc5b9f82 100644
--- a/drivers/virt/gunyah/Kconfig
+++ b/drivers/virt/gunyah/Kconfig
@@ -48,3 +48,12 @@ config GUNYAH_IRQFD
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
index ad212a1cf967..63ca11e74796 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_GUNYAH) += gunyah.o
 
 obj-$(CONFIG_GUNYAH_VCPU) += gunyah_vcpu.o
 obj-$(CONFIG_GUNYAH_IRQFD) += gunyah_irqfd.o
+obj-$(CONFIG_GUNYAH_IOEVENTFD) += gunyah_ioeventfd.o
diff --git a/drivers/virt/gunyah/gunyah_ioeventfd.c b/drivers/virt/gunyah/gunyah_ioeventfd.c
new file mode 100644
index 000000000000..324a54fe0f5b
--- /dev/null
+++ b/drivers/virt/gunyah/gunyah_ioeventfd.c
@@ -0,0 +1,117 @@
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
+struct gh_ioeventfd {
+	struct gh_vm_function_instance *f;
+	struct gh_vm_io_handler io_handler;
+
+	struct eventfd_ctx *ctx;
+};
+
+static int gh_write_ioeventfd(struct gh_vm_io_handler *io_dev, u64 addr, u32 len, u64 data)
+{
+	struct gh_ioeventfd *iofd = container_of(io_dev, struct gh_ioeventfd, io_handler);
+
+	eventfd_signal(iofd->ctx, 1);
+	return 0;
+}
+
+static struct gh_vm_io_handler_ops io_ops = {
+	.write = gh_write_ioeventfd,
+};
+
+static long gh_ioeventfd_bind(struct gh_vm_function_instance *f)
+{
+	const struct gh_fn_ioeventfd_arg *args = f->argp;
+	struct gh_ioeventfd *iofd;
+	struct eventfd_ctx *ctx;
+	int ret;
+
+	if (f->arg_size != sizeof(*args))
+		return -EINVAL;
+
+	/* All other flag bits are reserved for future use */
+	if (args->flags & ~GH_IOEVENTFD_FLAGS_DATAMATCH)
+		return -EINVAL;
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
+	if (overflows_type(args->addr + args->len, u64))
+		return -EINVAL;
+
+	/* ioeventfd with no length can't be combined with DATAMATCH */
+	if (!args->len && (args->flags & GH_IOEVENTFD_FLAGS_DATAMATCH))
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
+	if (args->flags & GH_IOEVENTFD_FLAGS_DATAMATCH) {
+		iofd->io_handler.datamatch = true;
+		iofd->io_handler.len = args->len;
+		iofd->io_handler.data = args->datamatch;
+	}
+	iofd->io_handler.addr = args->addr;
+	iofd->io_handler.ops = &io_ops;
+
+	ret = gh_vm_add_io_handler(f->ghvm, &iofd->io_handler);
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
+static void gh_ioevent_unbind(struct gh_vm_function_instance *f)
+{
+	struct gh_ioeventfd *iofd = f->data;
+
+	eventfd_ctx_put(iofd->ctx);
+	gh_vm_remove_io_handler(iofd->f->ghvm, &iofd->io_handler);
+	kfree(iofd);
+}
+
+DECLARE_GH_VM_FUNCTION_INIT(ioeventfd, GH_FN_IOEVENTFD, 3,
+				gh_ioeventfd_bind, gh_ioevent_unbind);
+MODULE_DESCRIPTION("Gunyah ioeventfd VM Function");
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
index 0c480c622686..fa1cae7419d2 100644
--- a/include/uapi/linux/gunyah.h
+++ b/include/uapi/linux/gunyah.h
@@ -79,10 +79,13 @@ struct gh_vm_dtb_config {
  *              Return: file descriptor to manipulate the vcpu.
  * @GH_FN_IRQFD: register eventfd to assert a Gunyah doorbell
  *               &struct gh_fn_desc.arg is a pointer to &struct gh_fn_irqfd_arg
+ * @GH_FN_IOEVENTFD: register ioeventfd to trigger when VM faults on parameter
+ *                   &struct gh_fn_desc.arg is a pointer to &struct gh_fn_ioeventfd_arg
  */
 enum gh_fn_type {
 	GH_FN_VCPU = 1,
 	GH_FN_IRQFD,
+	GH_FN_IOEVENTFD,
 };
 
 #define GH_FN_MAX_ARG_SIZE		256
@@ -134,6 +137,40 @@ struct gh_fn_irqfd_arg {
 	__u32 padding;
 };
 
+/**
+ * enum gh_ioeventfd_flags - flags for use in gh_fn_ioeventfd_arg
+ * @GH_IOEVENTFD_FLAGS_DATAMATCH: the event will be signaled only if the
+ *                                written value to the registered address is
+ *                                equal to &struct gh_fn_ioeventfd_arg.datamatch
+ */
+enum gh_ioeventfd_flags {
+	GH_IOEVENTFD_FLAGS_DATAMATCH	= 1UL << 0,
+};
+
+/**
+ * struct gh_fn_ioeventfd_arg - Arguments to create an ioeventfd function
+ * @datamatch: data used when GH_IOEVENTFD_DATAMATCH is set
+ * @addr: Address in guest memory
+ * @len: Length of access
+ * @fd: When ioeventfd is matched, this eventfd is written
+ * @flags: See &enum gh_ioeventfd_flags
+ * @padding: padding bytes
+ *
+ * Create this function with &GH_VM_ADD_FUNCTION using type &GH_FN_IOEVENTFD.
+ *
+ * Attaches an ioeventfd to a legal mmio address within the guest. A guest write
+ * in the registered address will signal the provided event instead of triggering
+ * an exit on the GH_VCPU_RUN ioctl.
+ */
+struct gh_fn_ioeventfd_arg {
+	__u64 datamatch;
+	__u64 addr;        /* legal mmio address */
+	__u32 len;         /* 1, 2, 4, or 8 bytes; or 0 to ignore length */
+	__s32 fd;
+	__u32 flags;
+	__u32 padding;
+};
+
 /**
  * struct gh_fn_desc - Arguments to create a VM function
  * @type: Type of the function. See &enum gh_fn_type.
-- 
2.40.0

