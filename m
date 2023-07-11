Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC3174F165
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbjGKOOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjGKOOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:14:12 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF731171F;
        Tue, 11 Jul 2023 07:13:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkKg2nw2cX59PJH/H2ONVJ6T+MfEsyttMtgV2g11tRsK349QMls87hcSuaQYyw8HOZcmPsgMM70+PeXyx9/jXyHhhNhU1kww7nS4KtlBH3mDtpemMqdH2XtmStjbVNJ2k7Dtle2t5C9Aj89tTXZ9aUtR9mVjE7vIN6BBtr5SZ23I/4PvyQD1BvtnhqpGygE/Mc9GGPX9+qwUN82I3MOHSKOSzkUMmmoDvYzngOwcwLB4gjnsfSSkg8vEHZO4HY3VRIlbHaxTbiy7HIZNO4PsssiG5SUNvFBq7zEatrS1RzS5zQh7vhz16McmObk7El11HxHBJgF+l8QAW15WC2+wLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azDLca+gtMaslPJytjGM2HaMG72Dhto6HE6NvmqW9Pw=;
 b=dwcqiBTRXt/cOyF9qy4BomrWWtYKp9psThDW9Sm6RbHNDDcqRDRahOt66LmQ+m0CX8fE5FUhyxSIdBwBXdiXfcGCWKWKqSza5nU38AOT6LiIaQSeO+wFEF42TzH5CBjSJsJWvD+aqi29DTdmU8xAWkOSZ6fX7u95imwIPQO+VIU11f1T+iO7rx+0pPoDjnPckdGto+R8lm3SWMe3ovV2f+mPJRZE0mqAuPL3mILbjS0fotEXKPsdDwM3uW9PgCaWkX8HxLx9DVIRHeM8GMy84A7B+oEgEP+qk+iXOhgUM2WalH4f3RhttzEJAt4XV+3C4o+jB+EpdpFqytd7Xm6BVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azDLca+gtMaslPJytjGM2HaMG72Dhto6HE6NvmqW9Pw=;
 b=oEt1NlLvhcLNhfCZw+LBneSlsm7mH8EMP1xAvQC6xNhwwHv1PptRRN3oY8GcHk+9VbcuMyOzIMhq/mBAc4s45nJGwhUQ3TCCMOMpVbYW9QRiD51myyja7zuYJACdMnapGCfvtqGMNoLbY71mCeilc92Khg/M9LJWRzy6mHDyh+Y=
Received: from BN9PR03CA0629.namprd03.prod.outlook.com (2603:10b6:408:106::34)
 by MW4PR12MB6898.namprd12.prod.outlook.com (2603:10b6:303:207::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Tue, 11 Jul
 2023 14:13:50 +0000
Received: from BN8NAM11FT116.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::f5) by BN9PR03CA0629.outlook.office365.com
 (2603:10b6:408:106::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Tue, 11 Jul 2023 14:13:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT116.mail.protection.outlook.com (10.13.176.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Tue, 11 Jul 2023 14:13:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 11 Jul
 2023 09:13:45 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 11 Jul
 2023 09:13:45 -0500
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Tue, 11 Jul 2023 09:12:58 -0500
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
        <security@kernel.org>, Carlos Bilbao <carlos.bilbao@amd.com>,
        Larry Dewey <larry.dewey@amd.com>,
        David Kaplan <david.kaplan@amd.com>
Subject: [PATCH v3] docs: security: Confidential computing intro and threat model for x86 virtualization
Date:   Tue, 11 Jul 2023 09:12:57 -0500
Message-ID: <20230711141257.232312-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT116:EE_|MW4PR12MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: b6d1a076-02d0-412c-a17b-08db82190c27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V4hDRQfddXSBrFUekQXXfxKbDn9OpB3+uBA/R7HWw52wQtnIVgSNCe3FLZdIkSme2fdaFkH8X18tcbmMSGlO9KuTiyjl7EEucffVy+6WbneaU+7BgeHRxJQRAyrkj/o7GTUi+5gymU7aSbkyca6AsZXh43QB2VrRQvYY5pKejHNQinkJfUk1vynu8qa7PdvoNKBbyLPhChG/bRcZyqiNmjOdRcnaTcUnEzjO0AHaAn9ZV7lc9MDqieUk6QFOUt0OGbtML27qmxZ4509aBcZszfYhSfPjznXqE4ZPeBfCCl4t+6nJD8XpmvHxuqda6FpyZop6bP4xtJ8GQ8d6vucptJARWnCnrZTtZOlwtBlEbplT03d57s+wPDFGvMlOidLiZmGhSSfCRay9p1UxO+K6NYCVt1sLFmaIYjKRrSXpUO1TdkNikgABcRLfyRFmVudOJKN8UqWc0Bbk95CNlrK8/GSxSHR5tKNTc0wkzzIUNNTb4144lmlo9V2NX/RW0Vs8wnv71pperOB/G8zo//XSTa7+JdftJDfZbzSfrzKg8lva+8/Ag/lPPQXKQGm2dJIvKM+R6VohGTZ2K7PDX9sVMXqlIoMHtkdK1WF1D7XGfX1YOgFMEE1IFXYBKZZpJEzpL4Rmqc7346WYGTMY5+9C2rKiozzryEqjjF4cWML+XiczTQ8/vt3WtWZCzyERbcs/tRi8q9HcnyKVhiQYSKDt6wsV7+PoHbAUlFDT4Hc+n1bI3sJy9ATl9jUuGegJU3NJyPCe1uqM/vwhE7GP+A/tdBMMQbV6XfMGb0Ro3Ajwid8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199021)(36840700001)(46966006)(40470700004)(41300700001)(36860700001)(15650500001)(44832011)(30864003)(4326008)(6916009)(2906002)(7406005)(7416002)(70206006)(70586007)(5660300002)(82740400003)(356005)(86362001)(478600001)(8676002)(316002)(7696005)(8936002)(966005)(47076005)(82310400005)(36756003)(26005)(83380400001)(1076003)(336012)(426003)(186003)(40460700003)(81166007)(54906003)(40480700001)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 14:13:48.8555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d1a076-02d0-412c-a17b-08db82190c27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT116.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6898
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel developers working on confidential computing for virtualized
environments in x86 operate under a set of assumptions regarding the Linux
kernel threat model that differs from the traditional view. Historically,
the Linux threat model acknowledges attackers residing in userspace, as
well as a limited set of external attackers that are able to interact with
the kernel through networking or limited HW-specific exposed interfaces
(e.g. USB, thunderbolt). The goal of this document is to explain additional
attack vectors that arise in the virtualized confidential computing space
and discuss the proposed protection mechanisms for the Linux kernel.

Reviewed-by: Larry Dewey <larry.dewey@amd.com>
Reviewed-by: David Kaplan <david.kaplan@amd.com>
Co-developed-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---

V2 can be found in:
 https://lore.kernel.org/lkml/20230612164727.3935657-1-carlos.bilbao@amd.com/
Changes since V2:
 - Remove pKVM from the document. Although there are clear overlaps in the
   threat models, it might be good to omit pKVM for now to avoid further
   complexity. In the future, when pKVM is more mature, we can revisit and
   discuss its inclusion.
 - Change file name to "snp-tdx-threat-model.rst".
 - Replace hyphens (dashes) for parenthesis in a parenthetical sentence.
 - Change "technology specific" for "technology-specific".

V1 can be found in:
 https://lore.kernel.org/lkml/20230327141816.2648615-1-carlos.bilbao@amd.com/
Changes since v1:

- Apply feedback from first version of the patch
- Clarify that the document applies only to a particular angle of
  confidential computing, namely confidential computing for virtualized
  environments. Also, state that the document is specific to x86 and
  that the main goal is to discuss the emerging threats.
- Change commit message and file name accordingly
- Replace AMD's link to AMD SEV SNP white paper
- Minor tweaking and clarifications

---
 Documentation/security/index.rst              |   1 +
 .../security/snp-tdx-threat-model.rst         | 294 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 3 files changed, 301 insertions(+)
 create mode 100644 Documentation/security/snp-tdx-threat-model.rst

diff --git a/Documentation/security/index.rst b/Documentation/security/index.rst
index 6ed8d2fa6f9e..7f04f5267fb3 100644
--- a/Documentation/security/index.rst
+++ b/Documentation/security/index.rst
@@ -6,6 +6,7 @@ Security Documentation
    :maxdepth: 1
 
    credentials
+   snp-tdx-threat-model.rst
    IMA-templates
    keys/index
    lsm
diff --git a/Documentation/security/snp-tdx-threat-model.rst b/Documentation/security/snp-tdx-threat-model.rst
new file mode 100644
index 000000000000..14b253211432
--- /dev/null
+++ b/Documentation/security/snp-tdx-threat-model.rst
@@ -0,0 +1,294 @@
+======================================================
+Confidential Computing in Linux for x86 virtualization
+======================================================
+
+.. contents:: :local:
+
+By: Elena Reshetova <elena.reshetova@intel.com> and Carlos Bilbao <carlos.bilbao@amd.com>
+
+Motivation
+==========
+
+Kernel developers working on confidential computing for virtualized
+environments in x86 operate under a set of assumptions regarding the Linux
+kernel threat model that differ from the traditional view. Historically,
+the Linux threat model acknowledges attackers residing in userspace, as
+well as a limited set of external attackers that are able to interact with
+the kernel through various networking or limited HW-specific exposed
+interfaces (USB, thunderbolt). The goal of this document is to explain
+additional attack vectors that arise in the confidential computing space
+and discuss the proposed protection mechanisms for the Linux kernel.
+
+Overview and terminology
+========================
+
+Confidential Computing (CoCo) is a broad term covering a wide range of
+security technologies that aim to protect the confidentiality and integrity
+of data in use (vs. data at rest or data in transit). At its core, CoCo
+solutions provide a Trusted Execution Environment (TEE), where secure data
+processing can be performed and, as a result, they are typically further
+classified into different subtypes depending on the SW that is intended
+to be run in TEE. This document focuses on a subclass of CoCo technologies
+that are targeting virtualized environments and allow running Virtual
+Machines (VM) inside TEE. From now on in this document will be referring
+to this subclass of CoCo as 'Confidential Computing (CoCo) for the
+virtualized environments (VE)'.
+
+CoCo, in the virtualization context, refers to a set of HW and/or SW
+technologies that allow for stronger security guarantees for the SW running
+inside a CoCo VM. Namely, confidential computing allows its users to
+confirm the trustworthiness of all SW pieces to include in its reduced
+Trusted Computing Base (TCB) given its ability to attest the state of these
+trusted components.
+
+While the concrete implementation details differ between technologies, all
+available mechanisms aim to provide increased confidentiality and
+integrity for the VM's guest memory and execution state (vCPU registers),
+more tightly controlled guest interrupt injection, as well as some
+additional mechanisms to control guest-host page mapping. More details on
+the x86-specific solutions can be found in
+:doc:`Intel Trust Domain Extensions (TDX) </arch/x86/tdx>` and
+`AMD Memory Encryption <https://www.amd.com/system/files/techdocs/sev-snp-strengthening-vm-isolation-with-integrity-protection-and-more.pdf>`_.
+
+The basic CoCo guest layout includes the host, guest, the interfaces that
+communicate guest and host, a platform capable of supporting CoCo VMs, and
+a trusted intermediary between the guest VM and the underlying platform
+that acts as a security manager. The host-side virtual machine monitor
+(VMM) typically consists of a subset of traditional VMM features and
+is still in charge of the guest lifecycle, i.e. create or destroy a CoCo
+VM, manage its access to system resources, etc. However, since it
+typically stays out of CoCo VM TCB, its access is limited to preserve the
+security objectives.
+
+In the following diagram, the "<--->" lines represent bi-directional
+communication channels or interfaces between the CoCo security manager and
+the rest of the components (data flow for guest, host, hardware) ::
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
+The specific details of the CoCo security manager vastly diverge between
+technologies. For example, in some cases, it will be implemented in HW
+while in others it may be pure SW.
+
+Existing Linux kernel threat model
+==================================
+
+The overall components of the current Linux kernel threat model are::
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
+There is also communication between the bootloader and the kernel during
+the boot process, but this diagram does not represent it explicitly. The
+"Interfaces" box represents the various interfaces that allow
+communication between kernel and userspace. This includes system calls,
+kernel APIs, device drivers, etc.
+
+The existing Linux kernel threat model typically assumes execution on a
+trusted HW platform with all of the firmware and bootloaders included on
+its TCB. The primary attacker resides in the userspace, and all of the data
+coming from there is generally considered untrusted, unless userspace is
+privileged enough to perform trusted actions. In addition, external
+attackers are typically considered, including those with access to enabled
+external networks (e.g. Ethernet, Wireless, Bluetooth), exposed hardware
+interfaces (e.g. USB, Thunderbolt), and the ability to modify the contents
+of disks offline.
+
+Regarding external attack vectors, it is interesting to note that in most
+cases external attackers will try to exploit vulnerabilities in userspace
+first, but that it is possible for an attacker to directly target the
+kernel; particularly if the host has physical access. Examples of direct
+kernel attacks include the vulnerabilities CVE-2019-19524, CVE-2022-0435
+and CVE-2020-24490.
+
+Confidential Computing threat model and its security objectives
+===============================================================
+
+Confidential Computing adds a new type of attacker to the above list: a
+potentially misbehaving host (which can also include some part of a
+traditional VMM or all of it), which is typically placed outside of the
+CoCo VM TCB due to its large SW attack surface. It is important to note
+that this doesn’t imply that the host or VMM are intentionally
+malicious, but that there exists a security value in having a small CoCo
+VM TCB. This new type of adversary may be viewed as a more powerful type
+of external attacker, as it resides locally on the same physical machine
+(in contrast to a remote network attacker) and has control over the guest
+kernel communication with most of the HW::
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
+   |     CoCo security     |<--->| Host/Host-side VMM |
+   |      manager          |     +------------------------+
+   |                       |     +------------------------+
+   |                       |<--->|   CoCo platform        |
+   +-----------------------+     +------------------------+
+
+While traditionally the host has unlimited access to guest data and can
+leverage this access to attack the guest, the CoCo systems mitigate such
+attacks by adding security features like guest data confidentiality and
+integrity protection. This threat model assumes that those features are
+available and intact.
+
+The **Linux kernel CoCo VM security objectives** can be summarized as follows:
+
+1. Preserve the confidentiality and integrity of CoCo guest's private
+memory and registers.
+
+2. Prevent privileged escalation from a host into a CoCo guest Linux kernel.
+While it is true that the host (and host-side VMM) requires some level of
+privilege to create, destroy, or pause the guest, part of the goal of
+preventing privileged escalation is to ensure that these operations do not
+provide a pathway for attackers to gain access to the guest's kernel.
+
+The above security objectives result in two primary **Linux kernel CoCo
+VM assets**:
+
+1. Guest kernel execution context.
+2. Guest kernel private memory.
+
+The host retains full control over the CoCo guest resources, and can deny
+access to them at any time. Examples of resources include CPU time, memory
+that the guest can consume, network bandwidth, etc. Because of this, the
+host Denial of Service (DoS) attacks against CoCo guests are beyond the
+scope of this threat model.
+
+The **Linux CoCo VM attack surface** is any interface exposed from a CoCo
+guest Linux kernel towards an untrusted host that is not covered by the
+CoCo technology SW/HW protection. This includes any possible
+side-channels, as well as transient execution side channels. Examples of
+explicit (not side-channel) interfaces include accesses to port I/O, MMIO
+and DMA interfaces, access to PCI configuration space, VMM-specific
+hypercalls (towards Host-side VMM), access to shared memory pages,
+interrupts allowed to be injected into the guest kernel by the host, as
+well as CoCo technology-specific hypercalls, if present. Additionally, the
+host in a CoCo system typically controls the process of creating a CoCo
+guest: it has a method to load into a guest the firmware and bootloader
+images, the kernel image together with the kernel command line. All of this
+data should also be considered untrusted until its integrity and
+authenticity is established via attestation.
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
+     - Mitigation strategies
+
+   * - Guest malicious configuration
+     - A misbehaving host modifies one of the following guest's
+       configuration:
+
+       1. Guest firmware or bootloader
+
+       2. Guest kernel or module binaries
+
+       3. Guest command line parameters
+
+       This allows the host to break the integrity of the code running
+       inside a CoCo guest, and violates the CoCo security objectives.
+     - The integrity of the guest's configuration passed via untrusted host
+       must be ensured by methods such as remote attestation and signing.
+       This should be largely transparent to the guest kernel, and would
+       allow it to assume a trusted state at the time of boot.
+
+   * - CoCo guest data attacks
+     - A misbehaving host retains full control of the CoCo guest's data
+       in-transit between the guest and the host-managed physical or
+       virtual devices. This allows any attack against confidentiality,
+       integrity or freshness of such data.
+     - The CoCo guest is responsible for ensuring the confidentiality,
+       integrity and freshness of such data using well-established
+       security mechanisms. For example, for any guest external network
+       communications passed via the untrusted host, an end-to-end
+       secure session must be established between a guest and a trusted
+       remote endpoint using well-known protocols such as TLS.
+       This requirement also applies to protection of the guest's disk
+       image.
+
+   * - Malformed runtime input
+     - A misbehaving host injects malformed input via any communication
+       interface used by the guest's kernel code. If the code is not
+       prepared to handle this input correctly, this can result in a host
+       --> guest kernel privilege escalation. This includes traditional
+       side-channel and/or transient execution attack vectors.
+     - The attestation or signing process cannot help to mitigate this
+       threat since this input is highly dynamic. Instead, a different set
+       of mechanisms is required:
+
+       1. *Limit the exposed attack surface*. Whenever possible, disable
+       complex kernel features and device drivers (not required for guest
+       operation) that actively use the communication interfaces between
+       the untrusted host and the guest. This is not a new concept for the
+       Linux kernel, since it already has mechanisms to disable external
+       interfaces, such as attacker's access via USB/Thunderbolt subsystem.
+
+       2. *Harden the exposed attack surface*. Any code that uses such
+       interfaces must treat the input from the untrusted host as malicious,
+       and do sanity checks before processing it. This can be ensured by
+       performing a code audit of such device drivers as well as employing
+       other standard techniques for testing the code robustness, such as
+       fuzzing. This is again a well-known concept for the Linux kernel,
+       since all its networking code has been previously analyzed under
+       presumption of processing malformed input from a network attacker.
+
+   * - Malicious runtime input
+     - A misbehaving host injects a specific input value via any
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
+minimize changes to the Linux kernel code, while also providing usable
+and scalable means to facilitate the security of a CoCo guest kernel.
diff --git a/MAINTAINERS b/MAINTAINERS
index a73486c4aa6e..1d4ae60cdee9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5197,6 +5197,12 @@ S:	Orphan
 W:	http://accessrunner.sourceforge.net/
 F:	drivers/usb/atm/cxacru.c
 
+CONFIDENTIAL COMPUTING THREAT MODEL FOR X86 VIRTUALIZATION (SNP/TDX)
+M:    Elena Reshetova <elena.reshetova@intel.com>
+M:    Carlos Bilbao <carlos.bilbao@amd.com>
+S:    Maintained
+F:    Documentation/security/snp-tdx-threat-model.rst
+
 CONFIGFS
 M:	Joel Becker <jlbec@evilplan.org>
 M:	Christoph Hellwig <hch@lst.de>
-- 
2.34.1

