Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B273769701C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 22:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjBNVwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 16:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBNVwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 16:52:34 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BB42B083;
        Tue, 14 Feb 2023 13:52:33 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EEfsJ9006217;
        Tue, 14 Feb 2023 21:26:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=LI21iyaD6256tDvZGp/UY35e1DSgHlcFcXiwafqOl98=;
 b=eGT6/LcLe7+dgJ/jYXMz3BTeKYvMt/E92s4uRXtaHRGDVaQx45WRWRktbX2dvtW5ZfvR
 ZpcunSM7FTRleO2QMyd4XADZuDoPVxydhPb3jF4ucJEm0ynR5OjqkQBCNGPpBPKIC5vn
 DpwbtpqSrayJoWJGDKdXeNHs4KucQ1vyupkmXiLJ104GU8Zd4YqATl2nT9Ajk25sObia
 +xSkR6r3BFgdRHJ+KWTZFCzLtMv9A9pXsoIS7zvBNGvUzf4b7CKmT25tmpmcgeIVXiow
 T65eyQSBxhmLw650VUftjYml5H1iWpPOZm30vOniVvUPGMwz0lAsX5ynxjLqgKnYLg5N Mg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nr26u2hvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 21:26:41 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31ELQeJJ003539
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 21:26:40 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 14 Feb 2023 13:26:39 -0800
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v10 25/26] virt: gunyah: Add ioeventfd
Date:   Tue, 14 Feb 2023 13:26:31 -0800
Message-ID: <20230214212632.3329812-1-quic_eberman@quicinc.com>
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
X-Proofpoint-GUID: IUqAugtH67wi5-c5bKUDzgyR-nmm0FcP
X-Proofpoint-ORIG-GUID: IUqAugtH67wi5-c5bKUDzgyR-nmm0FcP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_15,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 spamscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140184
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/virt/gunyah/gunyah_ioeventfd.c   | 113 +++++++++++++++++++++++
 include/uapi/linux/gunyah.h              |  24 +++++
 5 files changed, 168 insertions(+)
 create mode 100644 drivers/virt/gunyah/gunyah_ioeventfd.c

diff --git a/Documentation/virt/gunyah/vm-manager.rst b/Documentation/virt/gunyah/vm-manager.rst
index 55d4fb466644..62d628f810f0 100644
--- a/Documentation/virt/gunyah/vm-manager.rst
+++ b/Documentation/virt/gunyah/vm-manager.rst
@@ -170,3 +170,24 @@ the irqfd.label.
 
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
index 000000000000..b1d1e2d80f60
--- /dev/null
+++ b/drivers/virt/gunyah/gunyah_ioeventfd.c
@@ -0,0 +1,113 @@
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
+	struct gh_vm_function_instance *f;
+	struct gh_vm_io_handler io_handler;
+
+	struct eventfd_ctx *ctx;
+};
+
+static int gh_write_ioeventfd(struct gh_vm_io_handler *io_dev, u64 addr, u32 len, u64 data)
+{
+	struct gunyah_ioeventfd *iofd = container_of(io_dev, struct gunyah_ioeventfd, io_handler);
+
+	eventfd_signal(iofd->ctx, 1);
+	return 0;
+}
+
+static struct gh_vm_io_handler_ops io_ops = {
+	.write = gh_write_ioeventfd,
+};
+
+static long gunyah_ioeventfd_bind(struct gh_vm_function_instance *f)
+{
+	const struct gh_fn_ioeventfd_arg *args = f->argp;
+	struct eventfd_ctx *ctx = NULL;
+	struct gunyah_ioeventfd *iofd;
+	int ret;
+
+	if (f->arg_size != sizeof(*args))
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
+static void gunyah_ioevent_unbind(struct gh_vm_function_instance *f)
+{
+	struct gunyah_ioeventfd *iofd = f->data;
+
+	eventfd_ctx_put(iofd->ctx);
+	gh_vm_remove_io_handler(iofd->f->ghvm, &iofd->io_handler);
+	kfree(iofd);
+}
+
+DECLARE_GUNYAH_VM_FUNCTION_INIT(ioeventfd, GH_FN_IOEVENTFD,
+				gunyah_ioeventfd_bind, gunyah_ioevent_unbind);
+MODULE_DESCRIPTION("Gunyah ioeventfds");
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
index ce2ccb71993f..63b6d275a64f 100644
--- a/include/uapi/linux/gunyah.h
+++ b/include/uapi/linux/gunyah.h
@@ -78,6 +78,12 @@ struct gh_vm_dtb_config {
  */
 #define GH_FN_IRQFD 		2
 
+/**
+ * GH_FN_IOEVENTFD - register ioeventfd to trigger when VM faults on parameter
+ * gh_fn_desc usage: fill arg with gh_fn_ioeventfd_arg
+ */
+#define GH_FN_IOEVENTFD 	3
+
 #define GH_FN_MAX_ARG_SIZE		256
 
 /**
@@ -94,6 +100,24 @@ struct gh_fn_irqfd_arg {
 	__u32 reserved;
 };
 
+/**
+ * struct gh_fn_ioeventfd_arg - Arguments to create an ioeventfd function
+ * @datamatch: data used when GH_IOEVENTFD_DATAMATCH is set
+ * @addr: Address in guest memory
+ * @len: Length of access
+ * @fd: When ioeventfd is matched, this eventfd is written
+ * @flags: See Documentation/virt/gunyah/vm-manager.rst for flag usage.
+ */
+struct gh_fn_ioeventfd_arg {
+	__u64 datamatch;
+	__u64 addr;        /* legal mmio address */
+	__u32 len;         /* 1, 2, 4, or 8 bytes; or 0 to ignore length */
+	__s32 fd;
+#define GH_IOEVENTFD_DATAMATCH		(1UL << 0)
+	__u32 flags;
+	__u32 reserved;
+};
+
 /**
  * struct gh_fn_desc - Arguments to create a VM function
  * @type: Type of the function. See GH_FN_* macro for supported types
-- 
2.39.1

