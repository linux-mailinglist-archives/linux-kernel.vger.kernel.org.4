Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A9B65163B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 00:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbiLSXCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 18:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbiLSXBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 18:01:47 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E813DBF7;
        Mon, 19 Dec 2022 15:00:41 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJL6gRw002293;
        Mon, 19 Dec 2022 23:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=6js+YZTPHaAwqI6SrIpLguIrJLCcDhCBL7e2LEMDA0U=;
 b=KlUXmkLBztcW55uOwIepxauOoDRSiA+pFX8YM4sMohVudY3t37vKfcuvXOCT7GZMed1D
 uAUznwcEzYSIMISsPVNC7Z+CP1hrFaamz9VyY84HNPtzlnlo633Ij+M2ebnYBtm/Hrh1
 UAHHVC4jw6eR8nc7N63lvYvtDqjulqmriJ4yj30JiR21p1cy77Lr27zeSP6jNgk8W5tC
 piJWR+xCwL5G6qytYD5xwfAEdroD9cXXm5vgtKU5NqOVvASuFh+7Rn2O68czbJpNtIxI
 GguslJ2uHwN5xgAaTpNLUUoSb0bBtYh+G05DxVcoqJzWlF94R7vBW0a3ttGSlF+9rUKG ag== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mjyk505wu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 23:00:16 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BJN0FbL006025
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 23:00:15 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 19 Dec 2022 15:00:15 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>
CC:     Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>
Subject: [PATCH v8 01/28] docs: gunyah: Introduce Gunyah Hypervisor
Date:   Mon, 19 Dec 2022 14:58:22 -0800
Message-ID: <20221219225850.2397345-2-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221219225850.2397345-1-quic_eberman@quicinc.com>
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9dzhIXzTIv05T14NMBChYA5zS4TVskKB
X-Proofpoint-ORIG-GUID: 9dzhIXzTIv05T14NMBChYA5zS4TVskKB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212190202
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
 Documentation/virt/gunyah/index.rst         | 114 ++++++++++++++++++++
 Documentation/virt/gunyah/message-queue.rst |  56 ++++++++++
 Documentation/virt/index.rst                |   1 +
 MAINTAINERS                                 |   7 ++
 4 files changed, 178 insertions(+)
 create mode 100644 Documentation/virt/gunyah/index.rst
 create mode 100644 Documentation/virt/gunyah/message-queue.rst

diff --git a/Documentation/virt/gunyah/index.rst b/Documentation/virt/gunyah/index.rst
new file mode 100644
index 000000000000..fbadbdd24da7
--- /dev/null
+++ b/Documentation/virt/gunyah/index.rst
@@ -0,0 +1,114 @@
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
+  A scheduler for virtual CPUs (vCPUs) on physical CPUs and enables time-sharing
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
+Gunyah allows access to manipulate that doorbell via the capability ID. These devices are described
+in Linux as a struct gunyah_resource.
+
+High level management of these resources is performed by the resource manager VM. RM informs a
+guest VM about resources it can access through either the device tree or via guest-initiated RPC.
+
+For each virtual machine, Gunyah maintains a table of resources which can be accessed by that VM.
+An entry in this table is called a "capability" and VMs can only access resources via this
+capability table. Hence, virtual Gunyah devices are referenced by a "capability IDs" and not a
+"resource IDs". A VM can have multiple capability IDs mapping to the same resource. If 2 VMs have
+access to the same resource, they may not be using the same capability ID to access that resource
+since the tables are independent per VM.
+
+Resource Manager
+================
+
+The resource manager (RM) is a privileged application VM supporting the Gunyah Hypervisor.
+It provides policy enforcement aspects of the virtualization system. The resource manager can
+be treated as an extension of the Hypervisor but is separated to its own partition to ensure
+that the hypervisor layer itself remains small and secure and to maintain a separation of policy
+and mechanism in the platform. On arm64, RM runs at NS-EL1 similar to other virtual machines.
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
+When booting a virtual machine which uses a devicetree, resource manager overlays a
+/hypervisor node. This node can let Linux know it is running as a Gunyah guest VM,
+how to communicate with resource manager, and basic description and capabilities of
+this VM. See Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml for a description
+of this node.
diff --git a/Documentation/virt/gunyah/message-queue.rst b/Documentation/virt/gunyah/message-queue.rst
new file mode 100644
index 000000000000..be4ab289236a
--- /dev/null
+++ b/Documentation/virt/gunyah/message-queue.rst
@@ -0,0 +1,56 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Message Queues
+==============
+Message queue is a simple low-capacity IPC channel between two VMs. It is
+intended for sending small control and configuration messages. Each message
+queue object is unidirectional, so a full-duplex IPC channel requires a pair of
+objects.
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
+2. Gunyah raises the corresponding interrupt for VM_B when any of these happens:
+
+   a. gh_msgq_send has PUSH flag. Queue is immediately flushed. This is the typical case.
+   b. Explicility with gh_msgq_push command from VM_A.
+   c. Message queue has reached a threshold depth.
+
+3. VM_B calls gh_msgq_recv and Gunyah copies message to requested buffer.
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
index 2f1cffa87b1b..418d540f5484 100644
--- a/Documentation/virt/index.rst
+++ b/Documentation/virt/index.rst
@@ -15,6 +15,7 @@ Linux Virtualization Support
    acrn/index
    coco/sev-guest
    hyperv/index
+   gunyah/index
 
 .. only:: html and subproject
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 886d3f69ee64..1dd8f58d6e01 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8934,6 +8934,13 @@ L:	linux-efi@vger.kernel.org
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
2.25.1

