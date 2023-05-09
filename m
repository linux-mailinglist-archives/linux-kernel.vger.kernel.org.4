Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235916FD006
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 22:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbjEIUuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 16:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbjEIUto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 16:49:44 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBBA5BAA;
        Tue,  9 May 2023 13:49:23 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 349KFWhW032205;
        Tue, 9 May 2023 20:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=fzOlSRH2lfeon+ED+9RgTmrbqOjGWAo5HDVzVN9pErk=;
 b=jn84CExnSAY6RU9iOX19QFfmDnJlRFRVL8kvynb/CTqWG+ov7qyQR4ZvWIQlrS0ofqTB
 IuO5bLq1rcqb8vdBLhKDiNd9fJxxfT+NQJvCfmoP+lMLTdyLBH/ptJbpUrORR62hIBpK
 l8gmh2Vnhkgl8SIcJwHC+0+TBX17LBJ4U8KOMnQLxz0aR2Ef4RtsEYq9O8PwqWb2LpRC
 6LwbGDGEuzgHtsLpBWNEarxJOkEoM51zgXtJ1/eF/mX+88rx6qUstBVwJPwhiqAEsN/V
 gg95/lIANc0B0vvuVgZSUD1pdNyR98Y7VPbtM8c3c+tzQP405T3p6+GAlaUESP1Jnuh5 4A== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qfsxj8eys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 20:49:04 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 349Kn3PS014032
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 May 2023 20:49:03 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 9 May 2023 13:49:02 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Elliot Berman" <quic_eberman@quicinc.com>,
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
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v13 08/24] gunyah: vm_mgr: Introduce basic VM Manager
Date:   Tue, 9 May 2023 13:47:45 -0700
Message-ID: <20230509204801.2824351-9-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230509204801.2824351-1-quic_eberman@quicinc.com>
References: <20230509204801.2824351-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wB-iR8vs76m98u03mcheKFyiYdfrx70x
X-Proofpoint-GUID: wB-iR8vs76m98u03mcheKFyiYdfrx70x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_13,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305090171
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gunyah VM manager is a kernel moduel which exposes an interface to
Gunyah userspace to load, run, and interact with other Gunyah virtual
machines. The interface is a character device at /dev/gunyah.

Add a basic VM manager driver. Upcoming patches will add more ioctls
into this driver.

Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      |  1 +
 drivers/virt/gunyah/Makefile                  |  2 +-
 drivers/virt/gunyah/rsc_mgr.c                 | 50 +++++++++-
 drivers/virt/gunyah/vm_mgr.c                  | 93 +++++++++++++++++++
 drivers/virt/gunyah/vm_mgr.h                  | 20 ++++
 include/uapi/linux/gunyah.h                   | 23 +++++
 6 files changed, 187 insertions(+), 2 deletions(-)
 create mode 100644 drivers/virt/gunyah/vm_mgr.c
 create mode 100644 drivers/virt/gunyah/vm_mgr.h
 create mode 100644 include/uapi/linux/gunyah.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 176e8fc3f31b..396212e88f7d 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -137,6 +137,7 @@ Code  Seq#    Include File                                           Comments
 'F'   DD     video/sstfb.h                                           conflict!
 'G'   00-3F  drivers/misc/sgi-gru/grulib.h                           conflict!
 'G'   00-0F  xen/gntalloc.h, xen/gntdev.h                            conflict!
+'G'   00-0f  linux/gunyah.h                                          conflict!
 'H'   00-7F  linux/hiddev.h                                          conflict!
 'H'   00-0F  linux/hidraw.h                                          conflict!
 'H'   01     linux/mei.h                                             conflict!
diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index 241bab357b86..e47e25895299 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
-gunyah-y += rsc_mgr.o rsc_mgr_rpc.o
+gunyah-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o
 obj-$(CONFIG_GUNYAH) += gunyah.o
diff --git a/drivers/virt/gunyah/rsc_mgr.c b/drivers/virt/gunyah/rsc_mgr.c
index 88b5beb1ea51..4f6f96bdcf3d 100644
--- a/drivers/virt/gunyah/rsc_mgr.c
+++ b/drivers/virt/gunyah/rsc_mgr.c
@@ -15,8 +15,10 @@
 #include <linux/completion.h>
 #include <linux/gunyah_rsc_mgr.h>
 #include <linux/platform_device.h>
+#include <linux/miscdevice.h>
 
 #include "rsc_mgr.h"
+#include "vm_mgr.h"
 
 #define RM_RPC_API_VERSION_MASK		GENMASK(3, 0)
 #define RM_RPC_HEADER_WORDS_MASK	GENMASK(7, 4)
@@ -130,6 +132,7 @@ struct gh_rm_connection {
  * @cache: cache for allocating Tx messages
  * @send_lock: synchronization to allow only one request to be sent at a time
  * @nh: notifier chain for clients interested in RM notification messages
+ * @miscdev: /dev/gunyah
  */
 struct gh_rm {
 	struct device *dev;
@@ -146,6 +149,8 @@ struct gh_rm {
 	struct kmem_cache *cache;
 	struct mutex send_lock;
 	struct blocking_notifier_head nh;
+
+	struct miscdevice miscdev;
 };
 
 /**
@@ -581,6 +586,33 @@ int gh_rm_notifier_unregister(struct gh_rm *rm, struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(gh_rm_notifier_unregister);
 
+struct device *gh_rm_get(struct gh_rm *rm)
+{
+	return get_device(rm->miscdev.this_device);
+}
+EXPORT_SYMBOL_GPL(gh_rm_get);
+
+void gh_rm_put(struct gh_rm *rm)
+{
+	put_device(rm->miscdev.this_device);
+}
+EXPORT_SYMBOL_GPL(gh_rm_put);
+
+static long gh_dev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct miscdevice *miscdev = filp->private_data;
+	struct gh_rm *rm = container_of(miscdev, struct gh_rm, miscdev);
+
+	return gh_dev_vm_mgr_ioctl(rm, cmd, arg);
+}
+
+static const struct file_operations gh_dev_fops = {
+	.owner		= THIS_MODULE,
+	.unlocked_ioctl	= gh_dev_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
+	.llseek		= noop_llseek,
+};
+
 static int gh_msgq_platform_probe_direction(struct platform_device *pdev, bool tx,
 					    struct gh_resource *ghrsc)
 {
@@ -665,7 +697,22 @@ static int gh_rm_drv_probe(struct platform_device *pdev)
 	rm->msgq_client.rx_callback = gh_rm_msgq_rx_data;
 	rm->msgq_client.tx_done = gh_rm_msgq_tx_done;
 
-	return gh_msgq_init(&pdev->dev, &rm->msgq, &rm->msgq_client, &rm->tx_ghrsc, &rm->rx_ghrsc);
+	ret = gh_msgq_init(&pdev->dev, &rm->msgq, &rm->msgq_client, &rm->tx_ghrsc, &rm->rx_ghrsc);
+	if (ret)
+		goto err_cache;
+
+	rm->miscdev.name = "gunyah";
+	rm->miscdev.minor = MISC_DYNAMIC_MINOR;
+	rm->miscdev.fops = &gh_dev_fops;
+
+	ret = misc_register(&rm->miscdev);
+	if (ret)
+		goto err_msgq;
+
+	return 0;
+err_msgq:
+	mbox_free_channel(gh_msgq_chan(&rm->msgq));
+	gh_msgq_remove(&rm->msgq);
 err_cache:
 	kmem_cache_destroy(rm->cache);
 	return ret;
@@ -675,6 +722,7 @@ static int gh_rm_drv_remove(struct platform_device *pdev)
 {
 	struct gh_rm *rm = platform_get_drvdata(pdev);
 
+	misc_deregister(&rm->miscdev);
 	mbox_free_channel(gh_msgq_chan(&rm->msgq));
 	gh_msgq_remove(&rm->msgq);
 	kmem_cache_destroy(rm->cache);
diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
new file mode 100644
index 000000000000..a43401cb34f7
--- /dev/null
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#define pr_fmt(fmt) "gh_vm_mgr: " fmt
+
+#include <linux/anon_inodes.h>
+#include <linux/file.h>
+#include <linux/gunyah_rsc_mgr.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+
+#include <uapi/linux/gunyah.h>
+
+#include "vm_mgr.h"
+
+static __must_check struct gh_vm *gh_vm_alloc(struct gh_rm *rm)
+{
+	struct gh_vm *ghvm;
+
+	ghvm = kzalloc(sizeof(*ghvm), GFP_KERNEL);
+	if (!ghvm)
+		return ERR_PTR(-ENOMEM);
+
+	ghvm->parent = gh_rm_get(rm);
+	ghvm->rm = rm;
+
+	return ghvm;
+}
+
+static int gh_vm_release(struct inode *inode, struct file *filp)
+{
+	struct gh_vm *ghvm = filp->private_data;
+
+	gh_rm_put(ghvm->rm);
+	kfree(ghvm);
+	return 0;
+}
+
+static const struct file_operations gh_vm_fops = {
+	.owner = THIS_MODULE,
+	.release = gh_vm_release,
+	.llseek = noop_llseek,
+};
+
+static long gh_dev_ioctl_create_vm(struct gh_rm *rm, unsigned long arg)
+{
+	struct gh_vm *ghvm;
+	struct file *file;
+	int fd, err;
+
+	/* arg reserved for future use. */
+	if (arg)
+		return -EINVAL;
+
+	ghvm = gh_vm_alloc(rm);
+	if (IS_ERR(ghvm))
+		return PTR_ERR(ghvm);
+
+	fd = get_unused_fd_flags(O_CLOEXEC);
+	if (fd < 0) {
+		err = fd;
+		goto err_destroy_vm;
+	}
+
+	file = anon_inode_getfile("gunyah-vm", &gh_vm_fops, ghvm, O_RDWR);
+	if (IS_ERR(file)) {
+		err = PTR_ERR(file);
+		goto err_put_fd;
+	}
+
+	fd_install(fd, file);
+
+	return fd;
+
+err_put_fd:
+	put_unused_fd(fd);
+err_destroy_vm:
+	gh_rm_put(ghvm->rm);
+	kfree(ghvm);
+	return err;
+}
+
+long gh_dev_vm_mgr_ioctl(struct gh_rm *rm, unsigned int cmd, unsigned long arg)
+{
+	switch (cmd) {
+	case GH_CREATE_VM:
+		return gh_dev_ioctl_create_vm(rm, arg);
+	default:
+		return -ENOTTY;
+	}
+}
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
new file mode 100644
index 000000000000..1e94b58d7d34
--- /dev/null
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _GH_VM_MGR_H
+#define _GH_VM_MGR_H
+
+#include <linux/gunyah_rsc_mgr.h>
+
+#include <uapi/linux/gunyah.h>
+
+long gh_dev_vm_mgr_ioctl(struct gh_rm *rm, unsigned int cmd, unsigned long arg);
+
+struct gh_vm {
+	struct gh_rm *rm;
+	struct device *parent;
+};
+
+#endif
diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
new file mode 100644
index 000000000000..86b9cb60118d
--- /dev/null
+++ b/include/uapi/linux/gunyah.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _UAPI_LINUX_GUNYAH_H
+#define _UAPI_LINUX_GUNYAH_H
+
+/*
+ * Userspace interface for /dev/gunyah - gunyah based virtual machine
+ */
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+#define GH_IOCTL_TYPE			'G'
+
+/*
+ * ioctls for /dev/gunyah fds:
+ */
+#define GH_CREATE_VM			_IO(GH_IOCTL_TYPE, 0x0) /* Returns a Gunyah VM fd */
+
+#endif
-- 
2.40.0

