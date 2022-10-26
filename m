Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F90560E7C8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 20:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbiJZS7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 14:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbiJZS73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 14:59:29 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6346E9850;
        Wed, 26 Oct 2022 11:59:24 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QIsYv1012088;
        Wed, 26 Oct 2022 18:59:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=Faivh7nZFKP85xPzE06Kf8fs0nf+mw7xhuS7k5oqfz4=;
 b=IHPYA/H1zwhSjnAyW2VhX1l6MxaCUOJplRjWaW8Hk87FXNJb6+fm8/pVAwfVNkGeftbU
 CNseutk3Npnj4LdjVGgQxbAK+G/amUlb8k9lJDyFfOY3WRmlH+hQoXqxGXZp60mbZxan
 1DlVai2eJ9ppfcKYbYa55H96znowC7GhE7PUZ11HeCBj3O1yKLLlzR1TzjpOASQ/lJnb
 5U5Q+nJ3qj1aXXe+9HxZek8G8Ma4gMZNNpndHAU5XEQbyBkVXBjTgQt0zt9ZeyjqKsLY
 t484h2QPK5fVN+0AtO+Pmvqi2gLlGKF/RVoc7dNlYwrmMIGIH0kps9YhSLip6H/lDzFM 8A== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kfahvr0qc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 18:59:05 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29QIx4vw009803
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 18:59:04 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 26 Oct 2022 11:59:03 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Will Deacon" <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 00/21] Drivers for gunyah hypervisor
Date:   Wed, 26 Oct 2022 11:58:25 -0700
Message-ID: <20221026185846.3983888-1-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mxZMRW6FZ8LdWtRI8LlqDNbZkIpZWiSC
X-Proofpoint-ORIG-GUID: mxZMRW6FZ8LdWtRI8LlqDNbZkIpZWiSC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_07,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=767
 malwarescore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2210260105
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gunyah is a Type-1 hypervisor independent of any
high-level OS kernel, and runs in a higher CPU privilege level. It does
not depend on any lower-privileged OS kernel/code for its core
functionality. This increases its security and can support a much smaller
trusted computing base than a Type-2 hypervisor.

Gunyah is an open source hypervisor. The source repo is available at
https://github.com/quic/gunyah-hypervisor.

The diagram below shows the architecture.

::

         VM A                    VM B
     +-----+ +-----+  | +-----+ +-----+ +-----+
     |     | |     |  | |     | |     | |     |
 EL0 | APP | | APP |  | | APP | | APP | | APP |
     |     | |     |  | |     | |     | |     |
     +-----+ +-----+  | +-----+ +-----+ +-----+
 ---------------------|-------------------------
     +--------------+ | +----------------------+
     |              | | |                      |
 EL1 | Linux Kernel | | |Linux kernel/Other OS |   ...
     |              | | |                      |
     +--------------+ | +----------------------+
 --------hvc/smc------|------hvc/smc------------
     +----------------------------------------+
     |                                        |
 EL2 |            Gunyah Hypervisor           |
     |                                        |
     +----------------------------------------+

Gunyah provides these following features.

- Threads and Scheduling: The scheduler schedules virtual CPUs (VCPUs) on
physical CPUs and enables time-sharing of the CPUs.
- Memory Management: Gunyah tracks memory ownership and use of all memory
under its control. Memory partitioning between VMs is a fundamental
security feature.
- Interrupt Virtualization: All interrupts are handled in the hypervisor
and routed to the assigned VM.
- Inter-VM Communication: There are several different mechanisms provided
for communicating between VMs.
- Device Virtualization: Para-virtualization of devices is supported using
inter-VM communication. Low level system features and devices such as
interrupt controllers are supported with emulation where required.

This series adds the basic framework for detecting that Linux is running
under Gunyah as a virtual machine, communication with the Gunyah Resource
Manager, and a basic virtual machine manager capable of launching virtual
machines. In a future series, I'll add more functionality to the VM Manager,
but functionality is kept limited here to reduce the number of patches to
review.

Changes in v6:
 - *Replace gunyah-console with gunyah VM Manager*
 - Move include/asm-generic/gunyah.h into include/linux/gunyah.h
 - s/gunyah_msgq/gh_msgq/
 - Minor tweaks and documentation tidying based on comments from Jiri, Greg, Arnd, Dmitry, and Bagas.

Changes in v5: https://lore.kernel.org/all/20221011000840.289033-1-quic_eberman@quicinc.com/
 - Dropped sysfs nodes
 - Switch from aux bus to Gunyah RM bus for the subdevices
 - Cleaning up RM console

Changes in v4: https://lore.kernel.org/all/20220928195633.2348848-1-quic_eberman@quicinc.com/
 - Tidied up documentation throughout based on questions/feedback received
 - Switched message queue implementation to use mailboxes
 - Renamed "gunyah_device" as "gunyah_resource"

Changes in v3: https://lore.kernel.org/all/20220811214107.1074343-1-quic_eberman@quicinc.com/
 - /Maintained/Supported/ in MAINTAINERS
 - Tidied up documentation throughout based on questions/feedback received
 - Moved hypercalls into arch/arm64/gunyah/; following hyper-v's implementation
 - Drop opaque typedefs
 - Move sysfs nodes under /sys/hypervisor/gunyah/
 - Moved Gunyah console driver to drivers/tty/
 - Reworked gunyah_device design to drop the Gunyah bus.

Changes in v2: https://lore.kernel.org/all/20220801211240.597859-1-quic_eberman@quicinc.com/
 - DT bindings clean up
 - Switch hypercalls to follow SMCCC 

v1: https://lore.kernel.org/all/20220223233729.1571114-1-quic_eberman@quicinc.com/

Elliot Berman (21):
  docs: gunyah: Introduce Gunyah Hypervisor
  dt-bindings: Add binding for gunyah hypervisor
  gunyah: Common types and error codes for Gunyah hypercalls
  arm64: smccc: Include alternative-macros.h
  virt: gunyah: Add hypercalls to identify Gunyah
  virt: gunyah: Identify hypervisor version
  mailbox: Allow direct registration to a channel
  virt: gunyah: msgq: Add hypercalls to send and receive messages
  mailbox: Add Gunyah message queue mailbox
  gunyah: rsc_mgr: Add resource manager RPC core
  gunyah: rsc_mgr: Add subdevices bus
  gunyah: rsc_mgr: Add VM lifecycle RPC
  gunyah: vm_mgr: Introduce basic VM Manager
  gunyah: rsc_mgr: Add RPC for sharing memory
  gunyah: vm_mgr: Add/remove user memory regions
  gunyah: vm_mgr: Add ioctls to support basic non-proxy VM boot
  samples: Add sample userspace Gunyah VM Manager
  gunyah: rsc_mgr: Add platform ops on mem_lend/mem_reclaim
  firmware: qcom_scm: Use fixed width src vm bitmap
  firmware: qcom_scm: Register Gunyah platform ops
  docs: gunyah: Document Gunyah VM Manager

 .../bindings/firmware/gunyah-hypervisor.yaml  |  86 +++
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 Documentation/virt/gunyah/index.rst           | 115 +++
 Documentation/virt/gunyah/message-queue.rst   |  63 ++
 Documentation/virt/gunyah/vm-manager.rst      |  94 +++
 Documentation/virt/index.rst                  |   1 +
 MAINTAINERS                                   |  13 +
 arch/arm64/Kbuild                             |   1 +
 arch/arm64/gunyah/Makefile                    |   1 +
 arch/arm64/gunyah/gunyah_hypercall.c          | 102 +++
 arch/arm64/include/uapi/asm/gunyah.h          |  17 +
 drivers/firmware/qcom_scm.c                   | 126 +++-
 drivers/mailbox/Kconfig                       |  10 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/gunyah-msgq.c                 | 225 ++++++
 drivers/mailbox/mailbox.c                     |  96 ++-
 drivers/misc/fastrpc.c                        |   6 +-
 drivers/net/wireless/ath/ath10k/qmi.c         |   4 +-
 drivers/remoteproc/qcom_q6v5_mss.c            |   8 +-
 drivers/soc/qcom/rmtfs_mem.c                  |   2 +-
 drivers/virt/Kconfig                          |   1 +
 drivers/virt/Makefile                         |   1 +
 drivers/virt/gunyah/Kconfig                   |  35 +
 drivers/virt/gunyah/Makefile                  |   7 +
 drivers/virt/gunyah/gunyah.c                  |  46 ++
 drivers/virt/gunyah/rsc_mgr.c                 | 690 ++++++++++++++++++
 drivers/virt/gunyah/rsc_mgr.h                 | 146 ++++
 drivers/virt/gunyah/rsc_mgr_bus.c             |  83 +++
 drivers/virt/gunyah/rsc_mgr_rpc.c             | 475 ++++++++++++
 drivers/virt/gunyah/vm_mgr.c                  | 288 ++++++++
 drivers/virt/gunyah/vm_mgr.h                  |  52 ++
 drivers/virt/gunyah/vm_mgr_mm.c               | 245 +++++++
 include/linux/arm-smccc.h                     |   1 +
 include/linux/gunyah.h                        | 167 +++++
 include/linux/gunyah_rsc_mgr.h                | 161 ++++
 include/linux/mailbox_client.h                |   1 +
 include/linux/mod_devicetable.h               |   8 +
 include/linux/qcom_scm.h                      |   2 +-
 include/uapi/linux/gunyah.h                   |  53 ++
 samples/Kconfig                               |  10 +
 samples/Makefile                              |   1 +
 samples/gunyah/.gitignore                     |   2 +
 samples/gunyah/Makefile                       |   6 +
 samples/gunyah/gunyah_vmm.c                   | 270 +++++++
 samples/gunyah/sample_vm.dts                  |  69 ++
 scripts/mod/devicetable-offsets.c             |   3 +
 scripts/mod/file2alias.c                      |  10 +
 47 files changed, 3763 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
 create mode 100644 Documentation/virt/gunyah/index.rst
 create mode 100644 Documentation/virt/gunyah/message-queue.rst
 create mode 100644 Documentation/virt/gunyah/vm-manager.rst
 create mode 100644 arch/arm64/gunyah/Makefile
 create mode 100644 arch/arm64/gunyah/gunyah_hypercall.c
 create mode 100644 arch/arm64/include/uapi/asm/gunyah.h
 create mode 100644 drivers/mailbox/gunyah-msgq.c
 create mode 100644 drivers/virt/gunyah/Kconfig
 create mode 100644 drivers/virt/gunyah/Makefile
 create mode 100644 drivers/virt/gunyah/gunyah.c
 create mode 100644 drivers/virt/gunyah/rsc_mgr.c
 create mode 100644 drivers/virt/gunyah/rsc_mgr.h
 create mode 100644 drivers/virt/gunyah/rsc_mgr_bus.c
 create mode 100644 drivers/virt/gunyah/rsc_mgr_rpc.c
 create mode 100644 drivers/virt/gunyah/vm_mgr.c
 create mode 100644 drivers/virt/gunyah/vm_mgr.h
 create mode 100644 drivers/virt/gunyah/vm_mgr_mm.c
 create mode 100644 include/linux/gunyah.h
 create mode 100644 include/linux/gunyah_rsc_mgr.h
 create mode 100644 include/uapi/linux/gunyah.h
 create mode 100644 samples/gunyah/.gitignore
 create mode 100644 samples/gunyah/Makefile
 create mode 100644 samples/gunyah/gunyah_vmm.c
 create mode 100644 samples/gunyah/sample_vm.dts


base-commit: 247f34f7b80357943234f93f247a1ae6b6c3a740
-- 
2.25.1

