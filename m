Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868FD6228B1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiKIKl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiKIKlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:41:25 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E97E209BC;
        Wed,  9 Nov 2022 02:41:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=beMDoCH2tV/8reufENjK9q8ja4h7QV7G2wXBAhhn1wxP9Rf+jfR/N41j39exzO3llbqz1Acy+C7jjHLWzRmbAlxMWZ+XqlJvKYCxLSS4EBLlyC8bl1pvJ6uyag2a0GhqZZBNTBpcK+CjZT5WpKRpS6z0LI/wecgpW9leOsucvUQ6tf8GRhsq7icm6cnnHTOizSDtOeOjjwI9g7gf9UlO3Y9fCO1T2AQHYIEyZ+ZK5zr77uLNgMYClN6G4D5GGq9At7xNcJl3e6M+rBWDxBJjPmSwUbYp3AV2TlK7sbqtNZugizk8AQGPr5bim3GZig009VDxVZrlyQvXbdR2LrnmZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3GxGce7N2Vvclrj6fwkpqEZ5I2z/MACUP2j0wb4+Uw=;
 b=b/SWOa0qZdgP8390v3KVme8TSPRKWfJbys9ZsA1aRgsS/bOoqXn4o+gl+70Cbx1vCPQW6rQvbmp7gNmnAAhYVxV3fekyXSJocjmal6N16eK5TUEk1O3Pa6izSVARoq6qESeDim+9gAIFHM3GhGK/Jvs6GFI/1SC3+waDJTwJTqVG3JQDhY0pdu1AhrVWJ/n0htvMhFCMEw9N+vrYzAiwfpPrmidRpqpD4sP30AaNu0NILGPQzWc3/IIkNiGsxQoGZYjuC5Qb7y1ilN4XpGYvP7mCxrVv+cHALHzF/QxGHq1OOVzvrMrIDZiLF2wdD3c6ZDt3nIhyriglW7emBP0trg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3GxGce7N2Vvclrj6fwkpqEZ5I2z/MACUP2j0wb4+Uw=;
 b=p5iupReUX7vvDT+bMF9D7zuplAg3E4onEgKPc0EPkKB/qN0fyGd2omMhfExKi7Ue2CmdXlH/4yUXM7aN4uso/aJddtEmpp5D5Z+eq+rWpKc8I13hkQ93Kxd72mKtHXkrJmN3Ivd/vhNfyEKhyMrgbJv+IdcszHx5NSN1Lazfhvo=
Received: from BN9PR03CA0494.namprd03.prod.outlook.com (2603:10b6:408:130::19)
 by DM6PR12MB4468.namprd12.prod.outlook.com (2603:10b6:5:2ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Wed, 9 Nov
 2022 10:41:20 +0000
Received: from BN8NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::22) by BN9PR03CA0494.outlook.office365.com
 (2603:10b6:408:130::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 10:41:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT101.mail.protection.outlook.com (10.13.177.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 10:41:19 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 04:41:16 -0600
From:   Robert Richter <rrichter@amd.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 0/9] cxl: Add support for Restricted CXL hosts (RCD mode)
Date:   Wed, 9 Nov 2022 11:40:50 +0100
Message-ID: <20221109104059.766720-1-rrichter@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT101:EE_|DM6PR12MB4468:EE_
X-MS-Office365-Filtering-Correlation-Id: c30a3318-5394-45b8-f952-08dac23ef02c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6FTau+qmnv9OfrAK89Keup5xUutd21li0osyHqWo/HExCQLL85WBkNaAbzJ1daAuqPdX4gk/WChUyO6u1rlz65fV3rCyYPPNBJOFxvkyxTSbJb0TFxyfCL4JOXW5HMt6Fpni0fpWEGlBSKN5LKUU9bWoK8CnWGv3KytX8Lya/0JfgCeVQtFm7Sz/Di2OGe7p/nhLj8hn5NlJzEsoLQHHbPY1GsVqHndJQFPoTOaSaWRGx+UhzvVUv8nJijoMtp60iyIsn/GNcGOeaJ0dVa93HVSoqbUJ+mGb7QaDiysCLhGXnC9J0nTFIUKIIH2K9hC4JggE71vUObDVcuuJ92nuhe0UVAh3+aLiUpr7PF2TSMRTWEMaXU5RauOCi5g5r4G/ihS6rw1ioDUlNSw9QauduT3h/FPicFd1ClK87bwTSlYz+PwbM5GUvvnUtZHXODGxCxl2Zx2WLzRbIYYBhMClQbWqbRshW6APB0YyOdhtzWw3Urp2QS3FpM6QvoJiN2ZJWHhVcxknQa4vBEozEparHAalzCbuQLin48FNfxMsqDnOZ83GIBaXSD+Gj7v7/Qw86f4iF0A5Ma4NqlTjtq68XCd2VnhGLtGV6KpGhHu9NBusrLI8p7/nXznJu8ZyOAv63CT1Gz+oyXUKryX2rwbfHe6zU0KuNKN3R/WImMsqI8yJfgmo5LYLRJkHgPQbTg1TBFNt4/ukHU3+jAm+kMeXt2TZaG5RLkEli6y2xqeOZpS5vLHGI/lmnQPAy4HslhqZQoSV+E+JJjjatr6hDBATWF4WbXtsOsdYKKn0Wgo6k63SaETQ3hyx+U1dSPJrexWe4cTowJs1LIclqgMurvuNEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199015)(36840700001)(40470700004)(46966006)(966005)(82310400005)(478600001)(81166007)(6666004)(54906003)(356005)(110136005)(316002)(40480700001)(82740400003)(4326008)(8676002)(70206006)(70586007)(26005)(8936002)(2616005)(186003)(36756003)(16526019)(7416002)(5660300002)(1076003)(336012)(36860700001)(83380400001)(40460700003)(47076005)(41300700001)(426003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 10:41:19.9117
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c30a3318-5394-45b8-f952-08dac23ef02c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4468
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Restricted CXL Device (RCD) mode (formerly referred to as CXL 1.1)
the PCIe enumeration hierarchy is different from CXL VH Enumeration
(formerly referred to as 2.0, for both modes see CXL spec 3.0: 9.11
and 9.12, [1]). This series adds support for RCD mode. It implements
the detection of Restricted CXL Hosts (RCHs) and its corresponding
Restricted CXL Devices (RCDs). It does the necessary enumeration of
ports and connects the endpoints. With all the plumbing an RCH/RCD
pair is registered at the Linux CXL bus and becomes visible in sysfs
in the same way as CXL VH hosts and devices do already. RCDs are
brought up as CXL endpoints and bound to subsequent drivers such as
cxl_mem.

For CXL VH the host driver (cxl_acpi) starts host bridge discovery
once the ACPI0017 CXL root device is detected and then searches for
ACPI0016 host bridges to enable CXL. This implementation requires the
ACPI device enumeration for RCD mode. It also expects the host's
downstream and upstream port RCRBs base address being reported by
firmware using the optional CEDT CHBS entry of the host bridge (see
CXL spec 3.0, 9.17.1.2).

RCD mode does not support hot-plug, so host discovery is at boot time
only.

This version bases on 2b76fc22aefd ("cxl/acpi: Improve debug messages
in cxl_acpi_probe()") containing the already accepted patches.

[1] https://www.computeexpresslink.org/spec-landing

---

v3:

 * Rebased onto 2b76fc22aefd ("cxl/acpi: Improve debug messages in
   cxl_acpi_probe()").
 * Added Co-developed-by tag. (Rafael)
 * Added public function cxl_rcrb_to_component() to regs.c for later
   reuse. Added arg to switch between upstream and downstream RCRB.
   (Dan, Dave)
 * Added patch to register CXL host ports by bridge device. Note the
   alias detection in ndctl (cxl list command) need to check both
   sysfs entries, firmware_node and physical_node. A rework is needed
   here. (Dan, Vishal)
 * Reworked implementation to skip intermediate port enumeration of
   restricted endpoints (RCDs). (Dan, Dave)
 * Added check to only register RCDs with device 0, function 0 as CXL
   memory.
 * Added Terry's patch to set ACPI's CXL _OSC to indicate CXL1.1
   support.

v2:
 * Reworked series to use add_host_bridge_dport() and
   add_host_bridge_uport(). There is a single cxl root device
   (ACPI0017) also for RCHs (must have a ACPI0016 id). (Dan)
 * Rebased onto 6.1-rc1.
 * Added a WARN_ON_ONCE() to CXL_RESOURCE_NONE check. Updated patch
   description with an example case. (Dan, Jonathan)
 * Added wrapper functions to devm_cxl_add_port() and
   devm_cxl_add_dport(). (Dan)
 * Dropped "PCI/ACPI: Link host bridge to its ACPI fw node" patch.
 * Updated spec refs to use 3.0. Added PCIe base spec refs. (Jonathan)
 * Reused UID detect code. (Dan)
 * Dropped "cxl/acpi: Specify module load order dependency for the
   cxl_acpi module" patch. Return -EINVAL if host not yet ready. (Dan)
 * Minor other changes.
 * Note: I haven't included most of the received Reviewed-by tags due
   to the major rework. In any case, thanks to all here.

Robert Richter (8):
  cxl/acpi: Register CXL host ports by bridge device
  cxl/acpi: Extract component registers of restricted hosts from RCRB
  cxl/mem: Adjust cxl_mem_find_port() to find an RCH's port
  cxl/mem: Skip intermediate port enumeration of restricted endpoints
    (RCDs)
  cxl/pci: Only register RCDs with device 0, function 0 as CXL memory
    device
  cxl/pci: Do not ignore PCI config read errors in match_add_dports()
  cxl/pci: Factor out code in match_add_dports() to pci_dev_add_dport()
  cxl/pci: Extend devm_cxl_port_enumerate_dports() to support restricted
    hosts (RCH)

Terry Bowman (1):
  cxl/acpi: Set ACPI's CXL _OSC to indicate CXL1.1 support

 drivers/acpi/pci_root.c |  1 +
 drivers/cxl/acpi.c      | 89 +++++++++++++++++++++++++++++------------
 drivers/cxl/core/pci.c  | 74 ++++++++++++++++++++++++++++------
 drivers/cxl/core/port.c | 56 +++++++++++++++++++++++++-
 drivers/cxl/core/regs.c | 46 +++++++++++++++++++++
 drivers/cxl/cxl.h       |  8 ++++
 drivers/cxl/pci.c       | 25 +++++++++++-
 7 files changed, 257 insertions(+), 42 deletions(-)


base-commit: 2b76fc22aefd39820c0520255875f99b326ede99
-- 
2.30.2

