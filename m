Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26FD6FD020
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 22:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbjEIUvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 16:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235471AbjEIUuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 16:50:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675496581;
        Tue,  9 May 2023 13:49:33 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 349Kc70r029068;
        Tue, 9 May 2023 20:49:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=kr57aaAKJdmUa2qdJ5GfalbiCqXquEdT5NF7O6emnX8=;
 b=irQ/UtFyiSGw3gX+POqdojjF3nInOdzjZZ5Wj7vv1QTA6fvz0/zcrqMqKMDjLSqEwC4M
 R7+69jBiAVHo3WO+msdeYs6N3JW5gx0NwhMjnefZ0P1Ties6h6Zpca61OOBtuKSxUAI6
 pA9x++6uaOqhipa3sq98RURxvrYLCswp024/B03hbtY/9DOVKK+zOskxm7koHdCwzLLN
 JZfxm39X1w3JMzA4cedlnad+Oy+ML5BX3F0+NZM++GIdwhiqpHeOgAdHY6+K0LTUo49O
 ixtJNABHCoW7vY1klA+1oklLyVuKGt7Mos0Kcqnx/vzazL71XF3/dzYJKg9YycubSwqa Tg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qf77ktu3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 20:49:15 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 349KnEqj014166
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 May 2023 20:49:14 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 9 May 2023 13:49:13 -0700
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
Subject: [PATCH v13 15/24] docs: gunyah: Document Gunyah VM Manager
Date:   Tue, 9 May 2023 13:47:52 -0700
Message-ID: <20230509204801.2824351-16-quic_eberman@quicinc.com>
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
X-Proofpoint-GUID: F-TMXlyqfwprbILAY_axtuVYz2rrzczz
X-Proofpoint-ORIG-GUID: F-TMXlyqfwprbILAY_axtuVYz2rrzczz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_13,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
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

Document the ioctls and usage of Gunyah VM Manager driver.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 Documentation/virt/gunyah/index.rst      |  1 +
 Documentation/virt/gunyah/vm-manager.rst | 82 ++++++++++++++++++++++++
 2 files changed, 83 insertions(+)
 create mode 100644 Documentation/virt/gunyah/vm-manager.rst

diff --git a/Documentation/virt/gunyah/index.rst b/Documentation/virt/gunyah/index.rst
index 74aa345e0a14..7058249825b1 100644
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
index 000000000000..50d8ae7fabcd
--- /dev/null
+++ b/Documentation/virt/gunyah/vm-manager.rst
@@ -0,0 +1,82 @@
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
+sharing userspace memory with a VM is done via the `GH_VM_SET_USER_MEM_REGION`_
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
+To create a VM, use the `GH_CREATE_VM`_ ioctl. A successful call will return a
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
+This ioctl allows the user to create or delete a memory parcel for a guest
+virtual machine. Each memory region is uniquely identified by a label;
+attempting to create two regions with the same label is not allowed. Labels are
+unique per virtual machine.
+
+While VMM is guest-agnostic and allows runtime addition of memory regions,
+Linux guest virtual machines do not support accepting memory regions at runtime.
+Thus, memory regions should be provided before starting the VM and the VM must
+be configured to accept these at boot-up.
+
+The guest physical address is used by Linux kernel to check that the requested
+user regions do not overlap and to help find the corresponding memory region
+for calls like `GH_VM_SET_DTB_CONFIG`_. It must be page aligned.
+
+To add a memory region, call `GH_VM_SET_USER_MEM_REGION`_ with fields set as
+described above.
+
+.. kernel-doc:: include/uapi/linux/gunyah.h
+   :identifiers: gh_userspace_memory_region gh_mem_flags
+
+GH_VM_SET_DTB_CONFIG
+~~~~~~~~~~~~~~~~~~~~
+
+This ioctl sets the location of the VM's devicetree blob and is used by Gunyah
+Resource Manager to allocate resources. The guest physical memory should be part
+of the primary memory parcel provided to the VM prior to GH_VM_START.
+
+.. kernel-doc:: include/uapi/linux/gunyah.h
+   :identifiers: gh_vm_dtb_config
+
+GH_VM_START
+~~~~~~~~~~~
+
+This ioctl starts the VM.
-- 
2.40.0

