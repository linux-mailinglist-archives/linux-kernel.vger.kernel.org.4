Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA5872E9A8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239051AbjFMRXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239426AbjFMRXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:23:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B162102;
        Tue, 13 Jun 2023 10:22:08 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DEOTkM008970;
        Tue, 13 Jun 2023 17:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=0EoPusqu98de6/QYJRAJ5A5E0IpiAs/i2FtOF590R1g=;
 b=HRlNCUeMPEI4kXaSQbT6H/8DLqpQIC0iJgCN9qYH0RVfCJIcdLahkB9nnd6Ganc7zKii
 F1b9YxQQ0QWZVSi0hY6a/Lnj44/WHnSzazyV7h4S0apRRTHTRFhr53TnoJkS2pNVXwQo
 vRMa08t+z0EmhxaR7b3TWZZoJ3L6XlrPAbsaG8uK5MIWdmO5VjxuEFII56NNYPn2d8sz
 5aoDZoY5cbTAm7Xl3kFPKQpT+h+ynRzebn1l3CoYZtHN9Ifgqog8JAEMvXhys8VSQHVG
 oXkhBgbhnDG8TokDtjaAjOROmPRQ9ydS1VHTqB0GZnq4zeZMq3hEZXZs+fseqfbXCBKV 9Q== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r6km41d4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 17:21:44 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35DHLiTb004391
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 17:21:44 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 13 Jun 2023 10:21:43 -0700
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
        Conor Dooley <conor+dt@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v14 16/25] docs: gunyah: Document Gunyah VM Manager
Date:   Tue, 13 Jun 2023 10:20:44 -0700
Message-ID: <20230613172054.3959700-17-quic_eberman@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 4Wj5x3wV_4OH3Cl_Y7491pAjq1I2qRVF
X-Proofpoint-GUID: 4Wj5x3wV_4OH3Cl_Y7491pAjq1I2qRVF
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

Document the ioctls and usage of Gunyah VM Manager driver.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 Documentation/virt/gunyah/index.rst      |  1 +
 Documentation/virt/gunyah/vm-manager.rst | 83 ++++++++++++++++++++++++
 2 files changed, 84 insertions(+)
 create mode 100644 Documentation/virt/gunyah/vm-manager.rst

diff --git a/Documentation/virt/gunyah/index.rst b/Documentation/virt/gunyah/index.rst
index 74aa345e0a144..7058249825b16 100644
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
index 0000000000000..df0e1a8279bf5
--- /dev/null
+++ b/Documentation/virt/gunyah/vm-manager.rst
@@ -0,0 +1,83 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================
+Virtual Machine Manager
+=======================
+
+The Gunyah Virtual Machine Manager is a Linux driver to support launching
+virtual machines using Gunyah. It presently supports launching virtual machines
+scheduled by Gunyah's scheduler.
+
+Configuration of a Gunyah virtual machine is done via a devicetree. When the VM
+is launched, memory is provided by the host VM which contains the devictree.
+Gunyah reads the devicetree to configure the memory map and create resources
+such as vCPUs for the VM. Memory can be shared with the VM with
+`GH_VM_SET_USER_MEM_REGION`_. Userspace can interact with the resources in Linux
+by adding "functions" to the VM.
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
+A successful call will return a Gunyah VM file descriptor. See
+`Gunyah VM API Descriptions`_ for list of IOCTLs that can be made on this file
+file descriptor.
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
+Thus, for Linux guests, memory regions should be provided before starting the VM
+and the VM must be configured via the devicetree to accept these at boot-up.
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
+Resource Manager to allocate resources. The guest physical memory must be part
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

