Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D0673A9A7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 22:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjFVUzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 16:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjFVUzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 16:55:39 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDB0199D;
        Thu, 22 Jun 2023 13:55:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRD7naKhequIlLDNuYlzFxHefDF231J4ySxupL8pGj4M+K8PbQCTCMHSHY3OZvkZHjzTBEQ4eThVSKZ81CbTeUsy++efTzrXBjrJDsQvySw9ZKVE2MyzeU1eVBIa1qNPdzHH8oP6pp4z7uLe6bNvvx/QDAI86Aed66SjEov+9/vZHWci5fH2HXVsPOA5uiB/i+DC/tfBrOuILr8ThD1J+XmiTmSSms1qdSe9tFVEEpGYO1sWZWYZFwP5/tCkCHphCIAKavrYscNAFL9GP0SAAKhoC46gWgPTmWD+NMWTgDJCoedwykmvIKmtZSoPMGnkQwikY8f0wnMQEZE+DL2DxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtbRL3vEeGMCHhGCfNN1CU5iUWpV3jAH1iVM8ttW21c=;
 b=GgIqoib1BpUo9vsAF5AlncMNt+b79xECEEyJwpCMRzZPtkSta1kuR59SJmH9urcWtLCz3Iy7Cea/HivjpmTgG3q/Txxkt+mFdwajX81fb3tr24naHF6QdZjM8WrznRaRF4gI6VOnN29B0eBnTs2V2xclqbIQZlhkMhoTlfSAeWglu1dGPtxOqTdzkGMUuRljNdbVmQV+PdcvKmCrKwVR/sO70FTLZ7bs8EJM/ik911k+A4/OuO01011G3QJkvMopd+ZZImoBL9LlAICNbOdSmqXQClcXMkYm6pqp3ik4rVmxmdPoOTRn5sN3Afo+g0mWOJjWshZQxvIlTDWTlUoe8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtbRL3vEeGMCHhGCfNN1CU5iUWpV3jAH1iVM8ttW21c=;
 b=mWrGXAWU/1y7Ld/K6cIaYW9137qix0PRGgbFnsgFrEl7CM9y/R3cTWadJJAbHwifOBukyVrDYk5XTc251CQNrCkS6JAwTyAbmdRrw54+RaHgOcIlKr1iOP9kebSUihBefraadyqGrCtA8AtGzNdcM67k+oBWZsRfo1mdVY96fco=
Received: from MW4PR04CA0154.namprd04.prod.outlook.com (2603:10b6:303:85::9)
 by PH8PR12MB6817.namprd12.prod.outlook.com (2603:10b6:510:1c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 20:55:31 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:85:cafe::ac) by MW4PR04CA0154.outlook.office365.com
 (2603:10b6:303:85::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 20:55:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 20:55:30 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 15:55:29 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v7 00/27] cxl/pci: Add support for RCH RAS error handling
Date:   Thu, 22 Jun 2023 15:54:56 -0500
Message-ID: <20230622205523.85375-1-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|PH8PR12MB6817:EE_
X-MS-Office365-Filtering-Correlation-Id: bc8121f5-ed55-4ac2-0dbe-08db736303d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZiF4VaHJnvIA8yM050dGnec3BdrW1mpOFYpaAJSZeNUdsJbZlSfkc14qjZ4gbgjptl6jMfrBSdCqTfGY45pGEzNhuATcDOgOLrg8NBVbtWCp8+qHhXqZTA0JBamywQv441O5TLvxocydpPEWsbzLPhYJylzfqNkmRz3E1tTVyiKGBwD7CRYWrA2wO3Nv4vniibBKT677pgBu6vgXYpU5vFdpUkwv1rWQBug5llusvCTvvrm5Kc0cuv6G1QJo3P0p1LRfajLptYhJMGg+36fSRvaWHbvkvdxi8GaggSeF2pvjTw6k7VgQWaB8wVT7pRf4APd4yJS4NHhKuvrauvwBy+pVpvJuJst3nNtyrLEnt1p/vzTsZthOsEWSjIVvlmU1A/MugZfhA+6x0sJ07H6uHtmd5xw4E6hLs/G0oA3lWGGKRDkhVgLzJwZZBU7rOEMLFXSK3V9Do2ACFwMON/dHuEScdMVoRqeFIGYxQsE+2ik64ZzycgA/kJJLF+Hbe4QY93RqTMK/32w/7QV2MLuBIzTLE1RrxEgVCNmppsi0B6W7AbZVunmBoh24uMk5tNVKXWel5989Zz634oJb5P0x4+vJrf2u6d++7tUtkm+bsgNu7fOYYqEbSLF6qSd43kCfCrtJ4wau3v7OZmrf/IOstW2q9PV79MRieyq9HdFtvLiEytUtf8M/Qau7akpJfWKynr8dywCTsvaeit/LrsABazKlc9mro/PO+1q9KdMAzWefgraGj1nMv9HiLs2QnNDvSZsaNM2oFmTj4pQVCipdzg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199021)(36840700001)(40470700004)(46966006)(16526019)(26005)(1076003)(186003)(426003)(2616005)(336012)(4326008)(316002)(7696005)(36756003)(6666004)(36860700001)(47076005)(2906002)(70206006)(70586007)(40460700003)(41300700001)(82740400003)(86362001)(83380400001)(82310400005)(81166007)(54906003)(356005)(40480700001)(478600001)(5660300002)(7416002)(44832011)(8676002)(8936002)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 20:55:30.4120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8121f5-ed55-4ac2-0dbe-08db736303d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6817
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patches #1 to #18 are a rework of the Component Register setup. This
is needed to share multiple CXL capabilities (HDM and RAS) for the
same component, also there can be different components implementing
the same capability, finally RCH mode should be supported too. The
general approach to solve this is to:

   * Unify code for components and capabilities in VH and RCH modes.

   * Early setup of the Component Register base address.

   * Create and store the register mappings to later use it for mapping
     the capability I/O ranges.

Patches #19 to #27 enable CXL RCH error handling. These are needed because
RCH downstream port protocol error handling is implemented uniquely and not
currently supported. These patches address the following:

   * Discovery and mapping of RCH downstream port AER registers.

   * AER portdrv changes to support CXL RCH protocol errors. 

   * Interrupt setup specific to RCH mode: enabling RCEC internal
     errors and disabling root port interrupts.

Changes in V7:
  - cxl: Updates for CXL Test to work with RCH
    - Removed Robert's DSO.
  - cxl/core/regs: Add @dev to cxl_register_map
    - Corrected typo in patch description.
  - PCI/AER: Unmask RCEC internal errors to enable RCH downstream port
    error handling.
    - Changed int variable to bool.
  - cxl/pci: Map RCH downstream AER registers for logging protocol errors
    - Corrected patch description.
  - cxl/pci: Add RCH downstream port AER register discovery
    - Reverted empty line removal.
  - cxl/port: Store the port's Component Register mappings in struct
    cxl_port
    - Update to use structure initialization in cxl_setup_comp_regs().
  - Remove first patch (already in the tree) and added patch 27/27.
    - Was a one-off error caused when merging branches during internal
    review.

Changes in V6:
  - Added patch for cxl test fixes: 'cxl: Update CXl Test to Work with
    RCH'. Patch from Dan.
  - Simplified: 'cxl/rch: Prepare for caching the MMIO mapped PCIe AER
    capability'. Patch from Dan.
  - Added patch: 'cxl: Rename 'uport' to 'uport_dev''
  - Updated patch: 'cxl: Rename member @dport of struct cxl_dport to
    @dport_dev'
  - Updated *map assignment to use structure init in 'cxl/core/regs: Add
    @dev to cxl_register_map'. Also fixed whitespace.
  - Removed extra whitespace in 'cxl/core/regs: Add @dev to
    cxl_register_map'
  - Updated patch subject: 'cxl/acpi: Move add_host_bridge_uport() after
    cxl_get_chbs()'
  - Changes to work with CXL test. 'cxl/acpi: Directly bind the CEDT
    detected CHBCR to the Host Bridge's port'
  - 'cxl/pci: Early setup RCH dport component registers from RCRB'
    - Removed parameter from cxl_rcrb_get_comp_regs().
    - Changed return value to EPROBE_DEFER for retry during ACPI
      initialization.
    - Changed map to us struct initialization.
  - Remove ENODEV check in 'cxl/port: Store the downstream port's
    Component Register mappings in struct cxl_dport'
  - 'cxl/port: Remove Component Register base address from struct
    cxl_dport'
    - Moved earlier with same removal for cxl_port.
  - cxl/pci: Add RCH downstream port AER register discovery
    - Flattened {request,release}_mem_region() and ioremap() into
      cxl_rcrb_to_aer().
    - Add check if OS is assigned AER handling before discovering AER.
  - Added CXL namespace import to cxl_core (drivers/cxl/core/port.c).
    Needed for using pci_print_aer(). In 'PCI/AER: Refactor
    cper_print_aer() for use by CXL driver module'.
  - cxl/pci: Map RCH downstream AER registers for logging protocol errors
    - Changed dport device used in devm_cxl_iomap_block() call to be
      port->dev.
    - Removed ENODEV check.
  - cxl/pci: Disable root port interrupts in RCH mode
    - Removed unnecessary 'rch' check.
    - Moved cxl_disable_rch_root_ints() into core/pci.c. 
    - Added OSC AER assignment check before accessing AER registers.
  - cxl/pci: Update CXL error logging to use RAS register address
    - Renamed function handlers.
  - cxl/pci: Add RCH downstream port error logging
    - Moved RCD check to caller.
    - Added put_dev() after call to cxl_pci_find_port().
                                                          
Changes in V5:
  - Split 'cxl/rch: Prepare for logging RCH downstream port protocol
    errors' patch into 2 patches.
  - Added:
    cxl/core/regs: Rename phys_addr in cxl_map_component_regs()
    cxl/mem: Prepare for early RCH dport component register setup
  - Correct comments CXL3.0 to CXL 3.0.
  - changed cxl_port_get_comp_map() to static.

Changes in V4:
  - Made port RAS register discovery common and called from
    __devm_cxl_add_dport().
  - Changed RCH AER register discovery to be called from
    __devm_cxl_add_dport().
  - Changed RAS and RCH AER register mapping to be called from
    __devm_cxl_add_dport().
  - Changed component register mapping to support all CXL component
    mapping, cxl_map_component_regs().
  - Added cxl_regs to 'struct cxl_dport' for providing RCH downstream port
    mapped registers USED in error handler.
  - PCI/AER:
      - Improved description of PCIEAER_CXL option in Kconfig.
      - Renamed function to pci_aer_unmask_internal_errors(), added
        pcie_aer_is_native() check.
      - Improved comments and added spec refs.
      - Renamed functions to cxl_rch_handle_error*().
      - Modified cxl_rch_handle_error_iter() to only call the handler
        callbacks, this also simplifies refcounting of the pdev.
      - Refactored handle_error_source(), created pci_aer_handle_error().
      - Changed printk messages to pci_*() variants.
      - Added check for pcie_aer_is_native() to the RCEC.
      - Introduced function cxl_rch_enable_rcec().
      - Updated patch description ("PCI/AER: Forward RCH downstream
      port-detected errors to the CXL.mem dev handler").

Changes in V3:
  - Correct base commit in cover sheet.
  - Change hardcoded return 0 to NULL in regs.c.
  - Remove calls to pci_disable_pcie_error_reporting(pdev) and
    pci_enable_pcie_error_reporting(pdev) in mem.c;
  - Move RCEC interrupt unmask to PCIe port AER driver's probe.
    - Fixes missing PCIEAER and PCIEPORTBUS config option error.
  - Rename cxl_rcrb_setup() to cxl_setup_rcrb() in mem.c.
  - Update cper_mem_err_unpack() patch subject and description.

Changes in V2:
  - Refactor RCH initialization into cxl_mem driver.
    - Includes RCH RAS and AER register discovery and mapping.
  - Add RCEC protocol error interrupt forwarding to CXL endpoint
    handler.
  - Change AER and RAS logging to use existing trace routines.
  - Enable RCEC AER internal errors.

Dan Williams (3):
  cxl: Updates for CXL Test to work with RCH
  cxl/rch: Prepare for caching the MMIO mapped PCIe AER capability
  cxl: Rename 'uport' to 'uport_dev'

Robert Richter (17):
  cxl/acpi: Probe RCRB later during RCH downstream port creation
  cxl: Rename member @dport of struct cxl_dport to @dport_dev
  cxl/core/regs: Add @dev to cxl_register_map
  cxl/acpi: Move add_host_bridge_uport() after cxl_get_chbs()
  cxl/acpi: Directly bind the CEDT detected CHBCR to the Host Bridge's
    port
  cxl/port: Remove Component Register base address from struct cxl_dport
  cxl/regs: Remove early capability checks in Component Register setup
  cxl/mem: Prepare for early RCH dport component register setup
  cxl/pci: Early setup RCH dport component registers from RCRB
  cxl/port: Store the port's Component Register mappings in struct
    cxl_port
  cxl/port: Store the downstream port's Component Register mappings in
    struct cxl_dport
  cxl/pci: Store the endpoint's Component Register mappings in struct
    cxl_dev_state
  cxl/hdm: Use stored Component Register mappings to map HDM decoder
    capability
  cxl/port: Remove Component Register base address from struct cxl_port
  PCI/AER: Forward RCH downstream port-detected errors to the CXL.mem
    dev handler
  PCI/AER: Unmask RCEC internal errors to enable RCH downstream port
    error handling
  cxl/core/regs: Rename phys_addr in cxl_map_component_regs()

Terry Bowman (7):
  cxl/pci: Refactor component register discovery for reuse
  cxl/pci: Add RCH downstream port AER register discovery
  PCI/AER: Refactor cper_print_aer() for use by CXL driver module
  cxl/pci: Update CXL error logging to use RAS register address
  cxl/pci: Map RCH downstream AER registers for logging protocol errors
  cxl/pci: Add RCH downstream port error logging
  cxl/pci: Disable root port interrupts in RCH mode

base-commit: a70fc4ed20a6118837b0aecbbf789074935f473b

 drivers/cxl/acpi.c            | 206 +++++++++++++++++++---------------
 drivers/cxl/core/core.h       |  17 +++
 drivers/cxl/core/hdm.c        |  59 +++++-----
 drivers/cxl/core/pci.c        | 178 ++++++++++++++++++++++++++---
 drivers/cxl/core/port.c       | 195 ++++++++++++++++++++++++--------
 drivers/cxl/core/region.c     |  52 ++++-----
 drivers/cxl/core/regs.c       | 145 +++++++++++++++++++++---
 drivers/cxl/cxl.h             |  70 +++++++-----
 drivers/cxl/cxlmem.h          |   9 +-
 drivers/cxl/mem.c             |  18 +--
 drivers/cxl/pci.c             | 125 ++++++++-------------
 drivers/cxl/port.c            |   7 +-
 drivers/pci/pcie/Kconfig      |  12 ++
 drivers/pci/pcie/aer.c        | 162 +++++++++++++++++++++++++-
 include/linux/aer.h           |   2 +-
 tools/testing/cxl/Kbuild      |   3 +-
 tools/testing/cxl/test/cxl.c  |  30 ++---
 tools/testing/cxl/test/mem.c  |   1 -
 tools/testing/cxl/test/mock.c |  46 ++++++--
 tools/testing/cxl/test/mock.h |   3 -
 20 files changed, 951 insertions(+), 389 deletions(-)

-- 
2.34.1

