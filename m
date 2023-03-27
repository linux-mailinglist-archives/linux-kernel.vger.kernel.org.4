Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82766CA767
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjC0OVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjC0OUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:20:41 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20604.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::604])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346095FED;
        Mon, 27 Mar 2023 07:18:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGUfPmGwP+tcroKhFoComYWCtk5PHwNS62hoYGrD3EGd+r6HtpijXXQntEt+V7xi3AJLtZg34PwoaVT8k/M+qiwrBZ1LAAC1Uc6iqPZUwbDCLDdAy3QmIJEPVsMu+dh/zHznLTjRMdafVjeZWHFPhEOMaNwZ5imYsgVMRgPg1VHe3hmVV6Ea3yaOkJEccyzGN1smkalfg6lSU2Y/drDccSajKQrYSurSlvytlSv5H32xKyUN1EZsWkvIGse0ppQFsgrHrlbgAuYRTm5U1sKQLrKWdq4izDoxVLPDi/KUTw771zNsvsms954uphmkCozCLOKosjpbj4Ho+wbLeX3MaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q53uDrNvLQJH3j4ppZtgNNSlsuOcoroG5/KaqLgEWrY=;
 b=c//+Xsi7hjIhvoS2+b0+zbfuPUv1I8x5TTEdSvpFNGsQjhRqPcBqARnedNurTaqy138ZJ3kFykcmOs2v9AkycBmokfZ/ONm0On5S8TxKACS2i7vfRE8OSOMpfoya4Fu8Jy3l1p9K78Xqf12Y0AXaFXYFGI9+1vPNCvBNkm4VLth+NQY6Z/gK/Zm6uXBxFgIRt36OsZJNsUxDLC49cyD/GlhkJZBNJdpSdY+CmsEnbhm6Aje4UiCVKz+2NlnJv0DINjmP6A1k5zTKQPsIpF5uCrnYrMHj4R8+6/WATZ+51Pz/liDVJrqsUYg7tEBLYXdV2DU/dv6rIoFyOPdVProrrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q53uDrNvLQJH3j4ppZtgNNSlsuOcoroG5/KaqLgEWrY=;
 b=L047neuv1DUUenC6Ou71EpwcWlWE20n+or/5T3xZYD5ddKIwPQDG+fDD/XovmfPNry4ErmHbkE38l/EBmTj8dyf2g6bcNnH63TPn/vcw87f7arBkVEKO7kh9sqx4bcV5o1zRIGqYI2j+naBNbZB7T6Ilvkcm+CdOPdH4oXxk7Ro=
Received: from DS7PR07CA0015.namprd07.prod.outlook.com (2603:10b6:5:3af::26)
 by BL1PR12MB5301.namprd12.prod.outlook.com (2603:10b6:208:31f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Mon, 27 Mar
 2023 14:18:24 +0000
Received: from DM6NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::9c) by DS7PR07CA0015.outlook.office365.com
 (2603:10b6:5:3af::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.42 via Frontend
 Transport; Mon, 27 Mar 2023 14:18:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT083.mail.protection.outlook.com (10.13.173.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Mon, 27 Mar 2023 14:18:24 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 09:18:23 -0500
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 27 Mar 2023 09:18:21 -0500
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <corbet@lwn.net>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ardb@kernel.org>, <kraxel@redhat.com>, <dovmurik@linux.ibm.com>,
        <elena.reshetova@intel.com>, <dave.hansen@linux.intel.com>,
        <Dhaval.Giani@amd.com>, <michael.day@amd.com>,
        <pavankumar.paluri@amd.com>, <David.Kaplan@amd.com>,
        <Reshma.Lal@amd.com>, <Jeremy.Powell@amd.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <alexander.shishkin@linux.intel.com>, <thomas.lendacky@amd.com>,
        <tglx@linutronix.de>, <dgilbert@redhat.com>,
        <gregkh@linuxfoundation.org>, <dinechin@redhat.com>,
        <linux-coco@lists.linux.dev>, <berrange@redhat.com>,
        <mst@redhat.com>, <tytso@mit.edu>, <jikos@kernel.org>,
        <joro@8bytes.org>, <leon@kernel.org>,
        <richard.weinberger@gmail.com>, <lukas@wunner.de>,
        <jejb@linux.ibm.com>, <cdupontd@redhat.com>, <jasowang@redhat.com>,
        <sameo@rivosinc.com>, <bp@alien8.de>, <seanjc@google.com>,
        <security@kernel.org>, Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH] docs: security: Confidential computing intro and threat model
Date:   Mon, 27 Mar 2023 09:18:16 -0500
Message-ID: <20230327141816.2648615-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT083:EE_|BL1PR12MB5301:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dc55725-99f1-43fb-9637-08db2ece202e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EVlec1KHihbYb2U1Mh/fKWBV4RfHksAG4zreOspA2pEmkY5OMXhDTCFuBExS8F7roZ3w8JywckNvdanw90RVjPLU/bY6lq7borYNoUBK/RjmlUTUT8WdzMyOz98StluUKuLuohVKnDpEkk9wkytM6kDrWk1fdPDX9Ig4xoXLzVcCn4QGoe/uxokCwR5URYlPSAMsUNZb7mJlb6r7gSRP3fgh8n7vlLAtIDwJiwcvhEHuCWrJIfDEFrB6p80nk3g3I0hFyFqba1CsA3ZmfnJuZT0JByTlfZjy4XFSloiQfO++ER64Xmyeh3QiTTiN1T1LW7JsGHnWtVT/epbWo27BGiGDAWcSn5i80KmSosvTWUR7taHO3B/6nZfEKOadjG/IJUi5lIyV9su7pNXMOUOhfVI2NPVrA6JZw1IUhZSOQEmzdYapHiFcnQDu97ev8Hl01xhXYz/B49yTDAPFr4FQeKz1bnRiZ6JQhrsTThM8c3qTcMPz/qkTKKLscz+2y0AXhMn/XTKd990kNDs3lAJi8LoZTy9ZzOtYM5aAveEl0nrAxfmPDX/OtUlAnbSnzdZQbuovOojG98Q4qG9VMKbu3TPukccLVSGkWh4l/2xcXCEZW2maLXHU4J9nbHTFk22Fu0sHU95SptKGRhGz0BOIGwu44NCtLPYWoTxaepXVr2Uey3lCBjBg9Oi9xDc1aKOTMoihToEc6OMeWVCXTQpx4HJB9qp/5OjLOcynS7UackQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199021)(36840700001)(40470700004)(46966006)(2616005)(47076005)(83380400001)(336012)(426003)(36860700001)(41300700001)(44832011)(86362001)(36756003)(5660300002)(8936002)(356005)(81166007)(82740400003)(40460700003)(54906003)(966005)(7696005)(478600001)(8676002)(70586007)(70206006)(4326008)(6916009)(2906002)(15650500001)(82310400005)(40480700001)(7406005)(30864003)(7416002)(6666004)(26005)(186003)(1076003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 14:18:24.0340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc55725-99f1-43fb-9637-08db2ece202e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5301
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel developers working on confidential computing operate under a set of
assumptions regarding the Linux kernel threat model that differ from the
traditional view. In order to effectively engage with the linux-coco
mailing list and contribute to ongoing kernel efforts, one must have a
thorough familiarity with these concepts. Add a concise,
architecture-agnostic introduction and threat model to provide a reference
for ongoing design discussions and to help developers gain a foundational
understanding of the subject.

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Co-developed-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 .../security/confidential-computing.rst       | 245 ++++++++++++++++++
 Documentation/security/index.rst              |   1 +
 MAINTAINERS                                   |   6 +
 3 files changed, 252 insertions(+)
 create mode 100644 Documentation/security/confidential-computing.rst

diff --git a/Documentation/security/confidential-computing.rst b/Documentation/security/confidential-computing.rst
new file mode 100644
index 000000000000..98439ef7ff9f
--- /dev/null
+++ b/Documentation/security/confidential-computing.rst
@@ -0,0 +1,245 @@
+===============================
+Confidential Computing in Linux
+===============================
+
+.. contents:: :local:
+
+By: Elena Reshetova <elena.reshetova@intel.com> and Carlos Bilbao <carlos.bilbao@amd.com>
+
+Motivation
+==========
+
+Kernel developers working on confidential computing for the cloud operate
+under a set of assumptions regarding the Linux kernel threat model that
+differ from the traditional view. In order to effectively engage with the
+linux-coco mailing list and contribute to its initiatives, one must have a
+thorough familiarity with these concepts. This document provides a concise,
+architecture-agnostic introduction to help developers gain a foundational
+understanding of the subject.
+
+Overview and terminology
+========================
+
+Confidential Cloud Computing (CoCo) refers to a set of HW and SW
+virtualization technologies that allow Cloud Service Providers (CSPs) to
+provide stronger security guarantees to their clients (usually referred to
+as tenants) by excluding all the CSP's infrastructure and SW out of the
+tenant's Trusted Computing Base (TCB).
+
+While the concrete implementation details differ between technologies, all
+of these mechanisms provide increased confidentiality and integrity of CoCo
+guest memory and execution state (vCPU registers), more tightly controlled
+guest interrupt injection, as well as some additional mechanisms to control
+guest-host page mapping. More details on the x86-specific solutions can be
+found in
+:doc:`Intel Trust Domain Extensions (TDX) </x86/tdx>` and
+:doc:`AMD Memory Encryption </x86/amd-memory-encryption>`.
+
+The basic CoCo layout includes the host, guest, the interfaces that
+communicate guest and host, a platform capable of supporting CoCo, and an
+intermediary between the guest virtual machine (VM) and the underlying
+platform that acts as security manager::
+
+    +-------------------+      +-----------------------+
+    | CoCo guest VM     |<---->|                       |
+    +-------------------+      |                       |
+      | Interfaces |           | CoCo security manager |
+    +-------------------+      |                       |
+    | Host VMM          |<---->|                       |
+    +-------------------+      |                       |
+                               |                       |
+    +--------------------+     |                       |
+    | CoCo platform      |<--->|                       |
+    +--------------------+     +-----------------------+
+
+The specific details of the CoCo intermediary vastly diverge between
+technologies, so much so that in some cases it will be HW and in others
+SW.
+
+Existing Linux kernel threat model
+==================================
+
+The components of the current Linux kernel threat model are::
+
+     +-----------------------+      +-------------------+
+     |                       |<---->| Userspace         |
+     |                       |      +-------------------+
+     |   External attack     |         | Interfaces |
+     |       vectors         |      +-------------------+
+     |                       |<---->| Linux Kernel      |
+     |                       |      +-------------------+
+     +-----------------------+      +-------------------+
+                                    | Bootloader/BIOS   |
+                                    +-------------------+
+                                    +-------------------+
+                                    | HW platform       |
+                                    +-------------------+
+
+The existing Linux kernel threat model typically assumes execution on a
+trusted HW platform with all of the firmware and bootloaders included on
+its TCB. The primary attacker resides in the userspace and all of the data
+coming from there is generally considered untrusted, unless userspace is
+privileged enough to perform trusted actions. In addition, external
+attackers are typically considered, including those with access to enabled
+external networks (e.g. Ethernet, Wireless, Bluetooth), exposed hardware
+interfaces (e.g. USB, Thunderbolt), and the ability to modify the contents
+of disks offline.
+
+Confidential Computing threat model and security objectives
+===========================================================
+
+Confidential Cloud Computing adds a new type of attacker to the above list:
+an untrusted and potentially malicious host. This can be viewed as a more
+powerful type of external attacker, as it resides locally on the same
+physical machine, in contrast to a remote network attacker, and has control
+over the guest kernel communication with most of the HW::
+
+                                 +------------------------+
+                                 |    CoCo guest VM       |
+   +-----------------------+     |  +-------------------+ |
+   |                       |<--->|  | Userspace         | |
+   |                       |     |  +-------------------+ |
+   |   External attack     |     |     | Interfaces |     |
+   |       vectors         |     |  +-------------------+ |
+   |                       |<--->|  | Linux Kernel      | |
+   |                       |     |  +-------------------+ |
+   +-----------------------+     |  +-------------------+ |
+                                 |  | Bootloader/BIOS   | |
+   +-----------------------+     |  +-------------------+ |
+   |                       |<--->+------------------------+
+   |                       |          | Interfaces |
+   |                       |     +------------------------+
+   |     CoCo security     |<--->|   Host VMM             |
+   |      manager          |     +------------------------+
+   |                       |     +------------------------+
+   |                       |<--->|   CoCo platform        |
+   +-----------------------+     +------------------------+
+
+While the traditional hypervisor has unlimited access to guest data and
+can leverage this access to attack the guest, the CoCo systems mitigate
+such attacks by adding security features like guest data confidentiality
+and integrity protection. This threat model assumes that those features
+are available and intact.
+
+The **Linux kernel CoCo security objectives** can be summarized as follows:
+
+1. Preserve the confidentiality and integrity of CoCo guest private memory.
+2. Prevent privileged escalation from a host into a CoCo guest Linux kernel.
+
+The above security objectives result in two primary **Linux kernel CoCo
+assets**:
+
+1. Guest kernel execution context.
+2. Guest kernel private memory.
+
+The host retains full control over the CoCo guest resources and can deny
+access to them at any time. Because of this, the host Denial of Service
+(DoS) attacks against CoCo guests are beyond the scope of this threat
+model.
+
+The **Linux CoCo attack surface** is any interface exposed from a CoCo
+guest Linux kernel towards an untrusted host that is not covered by the
+CoCo technology SW/HW protections. This includes any possible
+side-channels, as well as transient execution side channels. Examples of
+explicit (not side-channel) interfaces include accesses to port I/O, MMIO
+and DMA interfaces, access to PCI configuration space, VMM-specific
+hypercalls, access to shared memory pages, interrupts allowed to be
+injected to the guest kernel by the host, as well as CoCo technology
+specific hypercalls. Additionally, the host in a CoCo system typically
+controls the process of creating a CoCo guest: it has a method to load
+into a guest the firmware and bootloader images, the kernel image
+together with the kernel command line. All of this data should also be
+considered untrusted until its integrity and authenticity is established.
+
+The table below shows a threat matrix for the CoCo guest Linux kernel with
+the potential mitigation strategies. The matrix refers to CoCo-specific
+versions of the guest, host and platform.
+
+.. list-table:: CoCo Linux guest kernel threat matrix
+   :widths: auto
+   :align: center
+   :header-rows: 1
+
+   * - Threat name
+     - Threat description
+     - Mitigation strategy
+
+   * - Guest malicious configuration
+     - A malicious host modifies one of the following guest's
+       configuration:
+
+       1. Guest firmware or bootloader
+
+       2. Guest kernel or module binaries
+
+       3. Guest command line parameters
+
+       This allows the host to break the integrity of the code running
+       inside a CoCo guest and violate the CoCo security objectives.
+     - The integrity of the guest's configuration passed via untrusted host
+       must be ensured by methods such as remote attestation and signing.
+       This should be largely transparent to the guest kernel and would
+       allow it to assume a trusted state at the time of boot.
+
+   * - CoCo guest data attacks
+     - A malicious host retains full control of the CoCo guest's data
+       in-transit between the guest and the host-managed physical or
+       virtual devices. This allows any attack against confidentiality,
+       integrity or freshness of such data.
+     - The CoCo guest is responsible for ensuring the confidentiality,
+       integrity and freshness of such data using well-established
+       security mechanisms. For example, for any guest external network
+       communications that are passed via the untrusted host, an end-to-end
+       secure session must be established between a guest and a trusted
+       remote endpoint using well-known protocols such as TLS.
+       This requirement also applies to protection of the guest's disk
+       image.
+
+   * - Malformed runtime input
+     - A malicious host injects malformed input via any communication
+       interface used by guest's kernel code. If the code is not prepared
+       to handle this input correctly, this can result in a host --> guest
+       kernel privilege escalation. This includes classical side-channel
+       and/or transient execution attack vectors.
+     - The attestation or signing process cannot help to mitigate this
+       threat since this input is highly dynamic. Instead, a different set
+       of mechanisms is required:
+
+       1. *Limit the exposed attack surface*. Whenever possible, disable
+       complex kernel features and device drivers (not required for guest
+       operation) that actively use the communication interfaces between
+       the untrusted host and the guest. This is not a new concept for the
+       Linux kernel, since it already has mechanisms to disable external
+       interfaces such as attacker's access via USB/Thunderbolt subsystem.
+
+       2. *Harden the exposed attack surface*. Any code that uses such
+       interfaces must treat the input from the untrusted host as malicious
+       and do sanity checks before processing it. This can be ensured by
+       performing a code audit of such device drivers as well as employing
+       other standard techniques for testing the code robustness, such as
+       fuzzing. This is again a well-known concept for the Linux kernel
+       since all its networking code has been previously analyzed under
+       presumption of processing malformed input from a network attacker.
+
+   * - Malicious runtime input
+     - A malicious host injects a specific input value via any
+       communication interface used by the guest's kernel code. The
+       difference with the previous attack vector (malformed runtime input)
+       is that this input is not malformed, but its value is crafted to
+       impact the guest's kernel security. Examples of such inputs include
+       providing a malicious time to the guest or the entropy to the guest
+       random number generator. Additionally, the timing of such events can
+       be an attack vector on its own, if it results in a particular guest
+       kernel action (i.e. processing of a host-injected interrupt).
+     - Similarly, as with the previous attack vector, it is not possible to
+       use attestation mechanisms to address this threat. Instead, such
+       attack vectors (i.e. interfaces) must be either disabled or made
+       resistant to supplied host input.
+
+As can be seen from the above table, the potential mitigation strategies
+to secure the CoCo Linux guest kernel vary, but can be roughly split into
+mechanisms that either require or do not require changes to the existing
+Linux kernel code. One main goal of the CoCo security architecture is to
+limit the changes to the Linux kernel code to minimum, but at the same time
+to provide usable and scalable means to facilitate the security of a CoCo
+guest kernel for all the users of the CoCo ecosystem.
diff --git a/Documentation/security/index.rst b/Documentation/security/index.rst
index 6ed8d2fa6f9e..5de51b130e6a 100644
--- a/Documentation/security/index.rst
+++ b/Documentation/security/index.rst
@@ -6,6 +6,7 @@ Security Documentation
    :maxdepth: 1
 
    credentials
+   confidential-computing
    IMA-templates
    keys/index
    lsm
diff --git a/MAINTAINERS b/MAINTAINERS
index 7f86d02cb427..4a16727bf7f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5307,6 +5307,12 @@ S:	Orphan
 W:	http://accessrunner.sourceforge.net/
 F:	drivers/usb/atm/cxacru.c
 
+CONFIDENTIAL COMPUTING THREAT MODEL
+M:	Elena Reshetova <elena.reshetova@intel.com>
+M:	Carlos Bilbao <carlos.bilbao@amd.com>
+S:	Maintained
+F:	Documentation/security/confidential-computing.rst
+
 CONFIGFS
 M:	Joel Becker <jlbec@evilplan.org>
 M:	Christoph Hellwig <hch@lst.de>
-- 
2.34.1

