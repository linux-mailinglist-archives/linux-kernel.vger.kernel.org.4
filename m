Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294B167606B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 23:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjATWsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 17:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjATWsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 17:48:00 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C509778;
        Fri, 20 Jan 2023 14:47:46 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KMb24V027326;
        Fri, 20 Jan 2023 22:47:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=9VxO+yl00zUxXfgp6XmdCqU9vdB2vjmzFe03W70hmXM=;
 b=k9+ZujqoqEuQFTuuZOLOOMoR3mCWw+sQffyPoD4EAiomqOthvPzw5Nd2AVHNsq4x9yQM
 ILlrWbi+fPuu8zMy8OjBcTGK97WE4L6+FMeqO/12CLdbnhNEkxEnOMM2ycEwlDbUUxj0
 hNcjHPuHIv0jmH6ydvjKGuKADcW1WRZMbvikIzljDKNi2TO5foo2PWFsb+DKnllxFkYZ
 hxDx0s4MIS1YYBriTyI5jFPoj3V9E47G3RXpwkVP0TLYE17zDxRAavBx3aHtNcBpnnLQ
 LstqHLIGbpBLVXwrCsLj6R4DAPlZfjpIig3hA8v+DTRhxMrbuXtldnt2zVvqy3imnAJS Xg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n7yc60ggu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 22:47:31 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30KMlUgt022158
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 22:47:30 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 20 Jan 2023 14:47:29 -0800
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
Subject: [PATCH v9 01/27] docs: gunyah: Introduce Gunyah Hypervisor
Date:   Fri, 20 Jan 2023 14:46:00 -0800
Message-ID: <20230120224627.4053418-2-quic_eberman@quicinc.com>
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
X-Proofpoint-GUID: VN-ujdXqtakzk-7582zg6dKwFPbGs2wi
X-Proofpoint-ORIG-GUID: VN-ujdXqtakzk-7582zg6dKwFPbGs2wi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_11,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301200218
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gunyah is an open-source Type-1 hypervisor developed by Qualcomm. It
does not depend on any lower-privileged OS/kernel code for its core
functionality. This increases its security and can support a smaller
trusted computing based when compared to Type-2 hypervisors.

Add documentation describing the Gunyah hypervisor and the main
components of the Gunyah hypervisor which are of interest to Linux
virtualization development.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 Documentation/virt/gunyah/index.rst         | 113 ++++++++++++++++++++
 Documentation/virt/gunyah/message-queue.rst |  61 +++++++++++
 Documentation/virt/index.rst                |   1 +
 MAINTAINERS                                 |   7 ++
 4 files changed, 182 insertions(+)
 create mode 100644 Documentation/virt/gunyah/index.rst
 create mode 100644 Documentation/virt/gunyah/message-queue.rst

diff --git a/Documentation/virt/gunyah/index.rst b/Documentation/virt/gunyah/index.rst
new file mode 100644
index 000000000000..45adbbc311db
--- /dev/null
+++ b/Documentation/virt/gunyah/index.rst
@@ -0,0 +1,113 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================
+Gunyah Hypervisor
+=================
+
+.. toctree::
+   :maxdepth: 1
+
+   message-queue
+
+Gunyah is a Type-1 hypervisor which is independent of any OS kernel, and runs in
+a higher CPU privilege level. It does not depend on any lower-privileged operating system
+for its core functionality. This increases its security and can support a much smaller
+trusted computing base than a Type-2 hypervisor.
+
+Gunyah is an open source hypervisor. The source repo is available at
+https://github.com/quic/gunyah-hypervisor.
+
+Gunyah provides these following features.
+
+- Scheduling:
+
+  A scheduler for virtual CPUs (vCPUs) on physical CPUs enables time-sharing
+  of the CPUs. Gunyah supports two models of scheduling:
+
+    1. "Behind the back" scheduling in which Gunyah hypervisor schedules vCPUS on its own.
+    2. "Proxy" scheduling in which a delegated VM can donate part of one of its vCPU slice
+       to another VM's vCPU via a hypercall.
+
+- Memory Management:
+
+  APIs handling memory, abstracted as objects, limiting direct use of physical
+  addresses. Memory ownership and usage tracking of all memory under its control.
+  Memory partitioning between VMs is a fundamental security feature.
+
+- Interrupt Virtualization:
+
+  Uses CPU hardware interrupt virtualization capabilities. Interrupts are handled
+  in the hypervisor and routed to the assigned VM.
+
+- Inter-VM Communication:
+
+  There are several different mechanisms provided for communicating between VMs.
+
+- Virtual platform:
+
+  Architectural devices such as interrupt controllers and CPU timers are directly provided
+  by the hypervisor as well as core virtual platform devices and system APIs such as ARM PSCI.
+
+- Device Virtualization:
+
+  Para-virtualization of devices is supported using inter-VM communication.
+
+Architectures supported
+=======================
+AArch64 with a GIC
+
+Resources and Capabilities
+==========================
+
+Some services or resources provided by the Gunyah hypervisor are described to a virtual machine by
+capability IDs. For instance, inter-VM communication is performed with doorbells and message queues.
+Gunyah allows access to manipulate that doorbell via the capability ID. These resources are
+described in Linux as a struct gunyah_resource.
+
+High level management of these resources is performed by the resource manager VM. RM informs a
+guest VM about resources it can access through either the device tree or via guest-initiated RPC.
+
+For each virtual machine, Gunyah maintains a table of resources which can be accessed by that VM.
+An entry in this table is called a "capability" and VMs can only access resources via this
+capability table. Hence, virtual Gunyah resources are referenced by a "capability IDs" and not
+"resource IDs". If 2 VMs have access to the same resource, they might not be using the same
+capability ID to access that resource since the capability tables are independent per VM.
+
+Resource Manager
+================
+
+The resource manager (RM) is a privileged application VM supporting the Gunyah Hypervisor.
+It provides policy enforcement aspects of the virtualization system. The resource manager can
+be treated as an extension of the Hypervisor but is separated to its own partition to ensure
+that the hypervisor layer itself remains small and secure and to maintain a separation of policy
+and mechanism in the platform. RM runs at arm64 NS-EL1 similar to other virtual machines.
+
+Communication with the resource manager from each guest VM happens with message-queue.rst. Details
+about the specific messages can be found in drivers/virt/gunyah/rsc_mgr.c
+
+::
+
+  +-------+   +--------+   +--------+
+  |  RM   |   |  VM_A  |   |  VM_B  |
+  +-.-.-.-+   +---.----+   +---.----+
+    | |           |            |
+  +-.-.-----------.------------.----+
+  | | \==========/             |    |
+  |  \========================/     |
+  |            Gunyah               |
+  +---------------------------------+
+
+The source for the resource manager is available at https://github.com/quic/gunyah-resource-manager.
+
+The resource manager provides the following features:
+
+- VM lifecycle management: allocating a VM, starting VMs, destruction of VMs
+- VM access control policy, including memory sharing and lending
+- Interrupt routing configuration
+- Forwarding of system-level events (e.g. VM shutdown) to owner VM
+
+When booting a virtual machine which uses a devicetree such as Linux, resource manager overlays a
+/hypervisor node. This node can let Linux know it is running as a Gunyah guest VM,
+how to communicate with resource manager, and basic description and capabilities of
+this VM. See Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml for a description
+of this node.
diff --git a/Documentation/virt/gunyah/message-queue.rst b/Documentation/virt/gunyah/message-queue.rst
new file mode 100644
index 000000000000..0667b3eb1ff9
--- /dev/null
+++ b/Documentation/virt/gunyah/message-queue.rst
@@ -0,0 +1,61 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Message Queues
+==============
+Message queue is a simple low-capacity IPC channel between two VMs. It is
+intended for sending small control and configuration messages. Each message
+queue is unidirectional, so a full-duplex IPC channel requires a pair of queues.
+
+Messages can be up to 240 bytes in length. Longer messages require a further
+protocol on top of the message queue messages themselves. For instance, communication
+with the resource manager adds a header field for sending longer messages via multiple
+message fragments.
+
+The diagram below shows how message queue works. A typical configuration involves
+2 message queues. Message queue 1 allows VM_A to send messages to VM_B. Message
+queue 2 allows VM_B to send messages to VM_A.
+
+1. VM_A sends a message of up to 240 bytes in length. It raises a hypercall
+   with the message to inform the hypervisor to add the message to
+   message queue 1's queue.
+
+2. Gunyah raises the corresponding interrupt for VM_B (Rx vIRQ) when any of
+   these happens:
+
+   a. gh_msgq_send has PUSH flag. Queue is immediately flushed. This is the typical case.
+   b. Explicility with gh_msgq_push command from VM_A.
+   c. Message queue has reached a threshold depth.
+
+3. VM_B calls gh_msgq_recv and Gunyah copies message to requested buffer.
+
+4. Gunyah buffers messages in the queue. If the queue became full when VM_A added a message,
+   the return values for gh_msgq_send() include a flag that indicates the queue is full.
+   Once VM_B receives the message and, thus, there is space in the queue, Gunyah
+   will raise the Tx vIRQ on VM_A to indicate it can continue sending messages.
+
+For VM_B to send a message to VM_A, the process is identical, except that hypercalls
+reference message queue 2's capability ID. Each message queue has its own independent
+vIRQ: two TX message queues will have two vIRQs (and two capability IDs).
+
+::
+
+      +---------------+         +-----------------+         +---------------+
+      |      VM_A     |         |Gunyah hypervisor|         |      VM_B     |
+      |               |         |                 |         |               |
+      |               |         |                 |         |               |
+      |               |   Tx    |                 |         |               |
+      |               |-------->|                 | Rx vIRQ |               |
+      |gh_msgq_send() | Tx vIRQ |Message queue 1  |-------->|gh_msgq_recv() |
+      |               |<------- |                 |         |               |
+      |               |         |                 |         |               |
+      | Message Queue |         |                 |         | Message Queue |
+      | driver        |         |                 |         | driver        |
+      |               |         |                 |         |               |
+      |               |         |                 |         |               |
+      |               |         |                 |   Tx    |               |
+      |               | Rx vIRQ |                 |<--------|               |
+      |gh_msgq_recv() |<--------|Message queue 2  | Tx vIRQ |gh_msgq_send() |
+      |               |         |                 |-------->|               |
+      |               |         |                 |         |               |
+      |               |         |                 |         |               |
+      +---------------+         +-----------------+         +---------------+
diff --git a/Documentation/virt/index.rst b/Documentation/virt/index.rst
index 56e003ff28ff..e92a9cf4b99d 100644
--- a/Documentation/virt/index.rst
+++ b/Documentation/virt/index.rst
@@ -16,6 +16,7 @@ Linux Virtualization Support
    coco/sev-guest
    coco/tdx-guest
    hyperv/index
+   gunyah/index
 
 .. only:: html and subproject
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 42fc47c6edfd..14fcfc7f91df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9041,6 +9041,13 @@ L:	linux-efi@vger.kernel.org
 S:	Maintained
 F:	block/partitions/efi.*
 
+GUNYAH HYPERVISOR DRIVER
+M:	Elliot Berman <quic_eberman@quicinc.com>
+M:	Murali Nalajala <quic_mnalajal@quicinc.com>
+L:	linux-arm-msm@vger.kernel.org
+S:	Supported
+F:	Documentation/virt/gunyah/
+
 HABANALABS PCI DRIVER
 M:	Oded Gabbay <ogabbay@kernel.org>
 S:	Supported
-- 
2.39.0

