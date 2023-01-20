Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61900676097
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 23:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjATWtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 17:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjATWso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 17:48:44 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FA8743BB;
        Fri, 20 Jan 2023 14:48:15 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KLS46r026515;
        Fri, 20 Jan 2023 22:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=XFJLx/WXuFDs7JAeLccnha22C3yPfKyzMwCj8d45lFY=;
 b=Cy9CiLCQbVEvjzMMG3Xu5gouVX+/ExPvfj5z1gR/bJ7EXSJrMvaU1CpzWuLXRBug+d4I
 jJ5oKL73vlkvSfMJFqWAmlWkT74T6s93g8IMJCKTo0+vN24dOYaxALE4oXyWPf5iqJ8s
 cfKpOjw/T6X+BqbBalOrS+v9hm0h8KLuMLeqQoJPeLVIybj1xdMMfO5Xd3g2ntieJhFd
 h0Hpc9tVCPgQazbWlb5aut9ni4wef/dO1gjGOFc7WS2B4b9MT0t5U2dK5Iu935+0qCs7
 gYUJZDG7krIsvqLNR9dR23CUg48rHItPipu/bjm5a6DPj8pfKFoiOzDv88kPeunMVlpD gg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n7593uqye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 22:48:00 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30KMlx00029311
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 22:47:59 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 20 Jan 2023 14:47:58 -0800
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
Subject: [PATCH v9 19/27] docs: gunyah: Document Gunyah VM Manager
Date:   Fri, 20 Jan 2023 14:46:18 -0800
Message-ID: <20230120224627.4053418-20-quic_eberman@quicinc.com>
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
X-Proofpoint-GUID: 68mAisyA32viiDKsF17vki1pwGe4-6pL
X-Proofpoint-ORIG-GUID: 68mAisyA32viiDKsF17vki1pwGe4-6pL
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

Document the ioctls and usage of Gunyah VM Manager driver.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 Documentation/virt/gunyah/index.rst      |   1 +
 Documentation/virt/gunyah/vm-manager.rst | 100 +++++++++++++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100644 Documentation/virt/gunyah/vm-manager.rst

diff --git a/Documentation/virt/gunyah/index.rst b/Documentation/virt/gunyah/index.rst
index 45adbbc311db..b204b85e86db 100644
--- a/Documentation/virt/gunyah/index.rst
+++ b/Documentation/virt/gunyah/index.rst
@@ -7,6 +7,7 @@ Gunyah Hypervisor
 .. toctree::
    :maxdepth: 1
 
+   vm-manager
    message-queue
 
 Gunyah is a Type-1 hypervisor which is independent of any OS kernel, and runs in
diff --git a/Documentation/virt/gunyah/vm-manager.rst b/Documentation/virt/gunyah/vm-manager.rst
new file mode 100644
index 000000000000..62513af09cbf
--- /dev/null
+++ b/Documentation/virt/gunyah/vm-manager.rst
@@ -0,0 +1,100 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================
+Virtual Machine Manager
+=======================
+
+The Gunyah Virtual Machine Manager is a Linux driver to support launching
+virtual machines using Gunyah. It presently supports launching non-proxy
+scheduled Linux-like virtual machines.
+
+Except for some basic information about the location of initial binaries,
+most of the configuration about a Gunyah virtual machine is described in the
+VM's devicetree. The devicetree is generated by userspace. Interacting with the
+virtual machine is still done via the kernel and VM configuration requires some
+of the corresponding functionality to be set up in the kernel. For instance,
+sharing userspace memory with a VM is done via the GH_VM_SET_USER_MEM_REGION
+ioctl. The VM itself is configured to use the memory region via the
+devicetree.
+
+Sample Userspace VMM
+====================
+
+A sample userspace VMM is included in samples/gunyah/ along with a minimal
+devicetree that can be used to launch a VM. To build this sample, enable
+CONFIG_SAMPLE_GUNYAH.
+
+IOCTLs and userspace VMM flows
+==============================
+
+The kernel exposes a char device interface at /dev/gunyah.
+
+To create a VM, use the GH_CREATE_VM ioctl. A successful call will return a
+"Gunyah VM" file descriptor.
+
+/dev/gunyah API Descriptions
+----------------------------
+
+GH_CREATE_VM
+~~~~~~~~~~~~
+
+Creates a Gunyah VM. The argument is reserved for future use and must be 0.
+
+Gunyah VM API Descriptions
+--------------------------
+
+GH_VM_SET_USER_MEM_REGION
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+::
+
+  struct gh_userspace_memory_region {
+	__u32 label;
+	__u32 flags;
+	__u64 guest_phys_addr;
+	__u64 memory_size;
+	__u64 userspace_addr;
+  };
+
+This ioctl allows the user to create or delete a memory parcel for a guest
+virtual machine. Each memory region is uniquely identified by a label;
+attempting to create two regions with the same label is not allowed.
+
+While VMM is guest-agnostic and allows runtime addition of memory regions,
+Linux guest virtual machines do not support accepting memory regions at runtime.
+Thus, memory regions should be provided before starting the VM and the VM must
+be configured to accept these at boot-up.
+
+The guest physical address is used by Linux kernel to check that the requested
+user regions do not overlap and to help find the corresponding memory region
+for calls like GH_VM_SET_DTB_CONFIG.
+
+To delete a memory region, call GH_VM_SET_USER_MEM_REGION with label set to the
+desired region and memory_size set to 0.
+
+The flags field of gh_userspace_memory_region accepts the following bits. All
+other bits must be 0 and are reserved for future use. The ioctl will return
+-EINVAL if an unsupported bit is detected.
+
+  - GH_MEM_ALLOW_READ/GH_MEM_ALLOW_WRITE/GH_MEM_ALLOW_EXEC sets read/write/exec
+    permissions for the guest, respectively.
+  - GH_MEM_LENT means that the memory will be unmapped from the host and be
+    unaccessible by the host while the guest has the region.
+
+GH_VM_SET_DTB_CONFIG
+~~~~~~~~~~~~~~~~~~~~
+
+::
+
+  struct gh_vm_dtb_config {
+	__u64 gpa;
+	__u64 size;
+  };
+
+This ioctl sets the location of the VM's devicetree blob and is used by Gunyah
+Resource Manager to allocate resources.
+
+GH_VM_START
+~~~~~~~~~~~
+
+This ioctl starts the VM.
-- 
2.39.0

