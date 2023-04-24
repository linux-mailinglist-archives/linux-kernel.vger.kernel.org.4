Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09956ED860
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 01:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbjDXXQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 19:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjDXXQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 19:16:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6B4126;
        Mon, 24 Apr 2023 16:16:34 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33ON3LFe019448;
        Mon, 24 Apr 2023 23:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=iQ7VnyxO1qPvs8HMUoEtRg5bjjSA+GabCMD0yY6tri8=;
 b=DmD+ZoTrL0nF1Zt0sErjgv0Q3WDfXVMM1kVCdh3cTKRjyXTbt9hQWHj0zYsuvOVKkydB
 Rx87lJuN/RP6653rEf2asL7Vci/OvJej5uTmWPrwnm7+06AfHzIPY6nOAKm8+DhoUAbE
 fV1RqZ22UjGQw4L+EpbbU56XNSnjSt595OEDNF7b+RgRcZ8rCEpksbalDItTqrn089Ln
 58nDSzyTRCGmmevvNJk6nSKG20YKOZYGyQgybkpEcqNB/YiZToFZoAyMFHtQX4T/7vPC
 TwUSxFNbvMZQY/erpvy5thV3vYr3vrSB6qjixCtofQrTJItnPxB+j0VYjhmUTmTTpYKE fg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q5wrb0q0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 23:16:16 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33ONGExx024094
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 23:16:14 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 24 Apr 2023 16:16:13 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v12 00/25] Drivers for Gunyah hypervisor
Date:   Mon, 24 Apr 2023 16:15:33 -0700
Message-ID: <20230424231558.70911-1-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9bkZh2CRg-KqnWeW2DywNuu1opP-c0rH
X-Proofpoint-ORIG-GUID: 9bkZh2CRg-KqnWeW2DywNuu1opP-c0rH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_11,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0 spamscore=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304240211
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Manager, and a sample virtual machine manager capable of launching virtual machines.

The series relies on two other patches posted separately:
 - https://lore.kernel.org/all/20230213181832.3489174-1-quic_eberman@quicinc.com/
 - https://lore.kernel.org/all/20230213232537.2040976-2-quic_eberman@quicinc.com/

Changes in v12:
 - Stylistic/cosmetic tweaks suggested by Alex
 - Remove patch "virt: gunyah: Identify hypervisor version" and squash the
   check that we're running under a reasonable Gunyah hypervisor into RM driver
 - Refactor platform hooks into a separate module per suggestion from Srini
 - GFP_KERNEL_ACCOUNT and account_locked_vm() for page pinning
 - enum-ify related constants
 - Allow removal of VM functions by function-specific comparison -- specifically to allow
   removing irqfd by label only and not requiring original FD to be provided.

Changes in v11: https://lore.kernel.org/all/20230304010632.2127470-1-quic_eberman@quicinc.com/
 - Rename struct gh_vm_dtb_config:gpa -> guest_phys_addr & overflow checks for this
 - More docstrings throughout
 - Make resp_buf and resp_buf_size optional
 - Replace deprecated idr with xarray
 - Refconting on misc device instead of RM's platform device
 - Renaming variables, structs, etc. from gunyah_ -> gh_
 - Drop removal of user mem regions
 - Drop mem_lend functionality; to converge with restricted_memfd later

Changes in v10: https://lore.kernel.org/all/20230214211229.3239350-1-quic_eberman@quicinc.com/
 - Fix bisectability (end result of series is same, --fixups applied to wrong commits)
 - Convert GH_ERROR_* and GH_RM_ERROR_* to enums
 - Correct race condition between allocating/freeing user memory
 - Replace offsetof with struct_size
 - Series-wide renaming of functions to be more consistent
 - VM shutdown & restart support added in vCPU and VM Manager patches
 - Convert VM function name (string) to type (number)
 - Convert VM function argument to value (which could be a pointer) to remove memory wastage for arguments
 - Remove defensive checks of hypervisor correctness
 - Clean ups to ioeventfd as suggested by Srivatsa

Changes in v9: https://lore.kernel.org/all/20230120224627.4053418-1-quic_eberman@quicinc.com/
 - Refactor Gunyah API flags to be exposed as feature flags at kernel level
 - Move mbox client cleanup into gunyah_msgq_remove()
 - Simplify gh_rm_call return value and response payload
 - Missing clean-up/error handling/little endian fixes as suggested by Srivatsa and Alex in v8 series

Changes in v8: https://lore.kernel.org/all/20221219225850.2397345-1-quic_eberman@quicinc.com/
 - Treat VM manager as a library of RM
 - Add patches 21-28 as RFC to support proxy-scheduled vCPUs and necessary bits to support virtio
   from Gunyah userspace

Changes in v7: https://lore.kernel.org/all/20221121140009.2353512-1-quic_eberman@quicinc.com/
 - Refactor to remove gunyah RM bus
 - Refactor allow multiple RM device instances
 - Bump UAPI to start at 0x0
 - Refactor QCOM SCM's platform hooks to allow CONFIG_QCOM_SCM=Y/CONFIG_GUNYAH=M combinations

Changes in v6: https://lore.kernel.org/all/20221026185846.3983888-1-quic_eberman@quicinc.com/
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
 - Reworked gh_device design to drop the Gunyah bus.

Changes in v2: https://lore.kernel.org/all/20220801211240.597859-1-quic_eberman@quicinc.com/
 - DT bindings clean up
 - Switch hypercalls to follow SMCCC 

v1: https://lore.kernel.org/all/20220223233729.1571114-1-quic_eberman@quicinc.com/

Elliot Berman (25):
  docs: gunyah: Introduce Gunyah Hypervisor
  dt-bindings: Add binding for gunyah hypervisor
  gunyah: Common types and error codes for Gunyah hypercalls
  virt: gunyah: Add hypercalls to identify Gunyah
  virt: gunyah: msgq: Add hypercalls to send and receive messages
  mailbox: Add Gunyah message queue mailbox
  gunyah: rsc_mgr: Add resource manager RPC core
  gunyah: rsc_mgr: Add VM lifecycle RPC
  gunyah: vm_mgr: Introduce basic VM Manager
  gunyah: rsc_mgr: Add RPC for sharing memory
  gunyah: vm_mgr: Add/remove user memory regions
  gunyah: vm_mgr: Add ioctls to support basic non-proxy VM boot
  samples: Add sample userspace Gunyah VM Manager
  gunyah: rsc_mgr: Add platform ops on mem_lend/mem_reclaim
  firmware: qcom_scm: Register Gunyah platform ops
  docs: gunyah: Document Gunyah VM Manager
  virt: gunyah: Translate gh_rm_hyp_resource into gunyah_resource
  gunyah: vm_mgr: Add framework for VM Functions
  virt: gunyah: Add resource tickets
  virt: gunyah: Add IO handlers
  virt: gunyah: Add proxy-scheduled vCPUs
  virt: gunyah: Add hypercalls for sending doorbell
  virt: gunyah: Add irqfd interface
  virt: gunyah: Add ioeventfd
  MAINTAINERS: Add Gunyah hypervisor drivers section

 .../bindings/firmware/gunyah-hypervisor.yaml  |  82 ++
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 Documentation/virt/gunyah/index.rst           | 114 +++
 Documentation/virt/gunyah/message-queue.rst   |  71 ++
 Documentation/virt/gunyah/vm-manager.rst      | 142 +++
 Documentation/virt/index.rst                  |   1 +
 MAINTAINERS                                   |  13 +
 arch/arm64/Kbuild                             |   1 +
 arch/arm64/gunyah/Makefile                    |   3 +
 arch/arm64/gunyah/gunyah_hypercall.c          | 140 +++
 arch/arm64/include/asm/gunyah.h               |  24 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/gunyah-msgq.c                 | 210 ++++
 drivers/virt/Kconfig                          |   2 +
 drivers/virt/Makefile                         |   1 +
 drivers/virt/gunyah/Kconfig                   |  59 ++
 drivers/virt/gunyah/Makefile                  |  11 +
 drivers/virt/gunyah/gunyah_ioeventfd.c        | 117 +++
 drivers/virt/gunyah/gunyah_irqfd.c            | 167 ++++
 drivers/virt/gunyah/gunyah_platform_hooks.c   |  80 ++
 drivers/virt/gunyah/gunyah_qcom.c             | 147 +++
 drivers/virt/gunyah/gunyah_vcpu.c             | 456 +++++++++
 drivers/virt/gunyah/rsc_mgr.c                 | 910 ++++++++++++++++++
 drivers/virt/gunyah/rsc_mgr.h                 |  19 +
 drivers/virt/gunyah/rsc_mgr_rpc.c             | 500 ++++++++++
 drivers/virt/gunyah/vm_mgr.c                  | 792 +++++++++++++++
 drivers/virt/gunyah/vm_mgr.h                  |  70 ++
 drivers/virt/gunyah/vm_mgr_mm.c               | 256 +++++
 include/linux/gunyah.h                        | 207 ++++
 include/linux/gunyah_rsc_mgr.h                | 162 ++++
 include/linux/gunyah_vm_mgr.h                 | 124 +++
 include/uapi/linux/gunyah.h                   | 293 ++++++
 samples/Kconfig                               |  10 +
 samples/Makefile                              |   1 +
 samples/gunyah/.gitignore                     |   2 +
 samples/gunyah/Makefile                       |   6 +
 samples/gunyah/gunyah_vmm.c                   | 270 ++++++
 samples/gunyah/sample_vm.dts                  |  68 ++
 38 files changed, 5534 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
 create mode 100644 Documentation/virt/gunyah/index.rst
 create mode 100644 Documentation/virt/gunyah/message-queue.rst
 create mode 100644 Documentation/virt/gunyah/vm-manager.rst
 create mode 100644 arch/arm64/gunyah/Makefile
 create mode 100644 arch/arm64/gunyah/gunyah_hypercall.c
 create mode 100644 arch/arm64/include/asm/gunyah.h
 create mode 100644 drivers/mailbox/gunyah-msgq.c
 create mode 100644 drivers/virt/gunyah/Kconfig
 create mode 100644 drivers/virt/gunyah/Makefile
 create mode 100644 drivers/virt/gunyah/gunyah_ioeventfd.c
 create mode 100644 drivers/virt/gunyah/gunyah_irqfd.c
 create mode 100644 drivers/virt/gunyah/gunyah_platform_hooks.c
 create mode 100644 drivers/virt/gunyah/gunyah_qcom.c
 create mode 100644 drivers/virt/gunyah/gunyah_vcpu.c
 create mode 100644 drivers/virt/gunyah/rsc_mgr.c
 create mode 100644 drivers/virt/gunyah/rsc_mgr.h
 create mode 100644 drivers/virt/gunyah/rsc_mgr_rpc.c
 create mode 100644 drivers/virt/gunyah/vm_mgr.c
 create mode 100644 drivers/virt/gunyah/vm_mgr.h
 create mode 100644 drivers/virt/gunyah/vm_mgr_mm.c
 create mode 100644 include/linux/gunyah.h
 create mode 100644 include/linux/gunyah_rsc_mgr.h
 create mode 100644 include/linux/gunyah_vm_mgr.h
 create mode 100644 include/uapi/linux/gunyah.h
 create mode 100644 samples/gunyah/.gitignore
 create mode 100644 samples/gunyah/Makefile
 create mode 100644 samples/gunyah/gunyah_vmm.c
 create mode 100644 samples/gunyah/sample_vm.dts


base-commit: d71ee0d6ee72138dd4fda646a955a15286c46544
-- 
2.40.0

