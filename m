Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F947395F0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 05:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjFVDwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 23:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjFVDwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 23:52:22 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF711BD8;
        Wed, 21 Jun 2023 20:52:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABoCdYXbOX/uH6aGQp/UiC60LGmuvDezIvJu7k5zRgly3tYyS3AfPJ0HvIyCJZR/TezGtLPtv16ZLNASrwZv6TELgTJ5LGOPmXGSU3en4SSkWe9n7uSc7hgZDH+UPf8Po3aWWR20Hqol6HqoXyGsGEQ7bWj/674SVQ3RpJrDXI0ZV/6t1kCm1vaf6/r9NgHMG2ygZSQR2Pu4h0EZ9KGdWtYPXgKIkqqnADdDK6BmweAygMLyOcGzMOne5bvl4lQyxHgila3n+keDPhm9mebjiTJLLSPiM9Ur4JmFxBi3AhZWIGMXy2DEBq9Lk7BFR+xxbmGxSwHicyU27ACrqTNpaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXRGBEtRMyE7Yr83qNiRheWVwBLSprEUhFYmBvfzswc=;
 b=C6qXEM5jWPzp81VJwxky4PTYycB8Ahiyba44Vtkbtu9puhdNKUrJx4M6bNyv6SwDJ9K8Q3PRZY1+8MUakxq0YVadw7TqVppgJ3tm4IVXgPFoitEdestCVIuOSqwY06PXqSw2fBFATC4Bz2ScI7b7KGPrI4pV7y+g2OFB2hYngTfSD80SpnBfHSqZqjmL0LJimdN+RSdGt77PCl7rTp3Vdc/WI30/z8p/k+nJyqc6k51SNAFXsTCx9W60whgJTgcuEsSKlPkS7W1pMDcOyyzHFL/RXH0erMcT1gipyVs2j6pCo6Kg3V65beVin2qpUNIn1CNBsNL5/ngv9NLxY38kfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXRGBEtRMyE7Yr83qNiRheWVwBLSprEUhFYmBvfzswc=;
 b=ALKtKLKre3/MuysEInEJSJAwMpMMJOmwFgbSp6lofiEott3z9p0uAEtLL499dinKP9VVoD6EaZID+D69xNtak0lTFwfoOU1sLwvJ6jdTEN0tCj8KUtUe8kEQ64cF2Yq/8XOAOBzOfOqF2ZnY0CrKJotitr5DgpiRlzTFR6KkFvE=
Received: from MW2PR16CA0040.namprd16.prod.outlook.com (2603:10b6:907:1::17)
 by DS7PR12MB5719.namprd12.prod.outlook.com (2603:10b6:8:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 03:52:16 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:907:1:cafe::5f) by MW2PR16CA0040.outlook.office365.com
 (2603:10b6:907:1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Thu, 22 Jun 2023 03:52:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 03:52:15 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 22:52:14 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v6 00/27]  cxl/pci: Add support for RCH RAS error handling
Date:   Wed, 21 Jun 2023 22:50:59 -0500
Message-ID: <20230622035126.4130151-1-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|DS7PR12MB5719:EE_
X-MS-Office365-Filtering-Correlation-Id: 215d41fd-17ad-46c3-bc3a-08db72d411c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ExwuKbzBnbwJQfvlCtfgsAceqotSCSVUkNYgfZpELal1u7eRsT7TMezODLgs/LNcab5C6eoDyy/NsbhVHqqcNY0u4xw/+dikNI4iOqv/0JpzlbEYSdd4iKQb7LWqWkzA7iQdWb8CVCbcuekIfuYmQ0uHnrbZptZjGh/g3rRAb3LYVvWeAuFVJotGKqgHFfSwBkq8fXIuP4uMOqLfwpP7bwf2KP2vbQohlFOygJEqMXnbBlXaj6xVwqry5+LMZKZR0Z/kr+jYZfcnoq6jE7hj4KpkIpta5X2ycczD4vvgGXmf+YzkSr5oG/X14K2lkqQVVYbbOMv78JbuJdPKGYhxnCtWKb49ZhzmdQnGkF7CqJ3Qzkg/DcohEszA6nFO2dFig4eTfn+JbPdAL0ZE1xmTvjmtXOspgrURpIvunGtjiWzuGS9t76UCOa1KxPB1NlyHitjYAiUjMDMS1siPezAvFHcMDrD6vzcTU+U5tWs9FEGTSUsKGRYeJ2A1bWXujiCcDaJdGY1/KzQ5kXcwZxehMgjkUtJcCebG+fPtB+gbknb4m2VyCtwp/YZq6QxdpmuQWJhLMCLbVmFd2rJGhnMb+052cE2yLeqXjoN+JnyZFOmXpN2oIcbR4TLBydlv2fWFLnGdf3YencC6+f3xH3JMuETIyARrLm0oJ1c5z2cSn8teUlo7sw9LEfvADejCQEpEjUYHvouKPS2lHRTT5yZHraduca0uDlYrF9QNUxpY/jn7Mn4y/m4X1LlUtGCvI8ctvjjcR4BoLF1GYlx48Y1VNA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199021)(46966006)(36840700001)(40470700004)(70206006)(70586007)(316002)(4326008)(8936002)(26005)(41300700001)(1076003)(8676002)(186003)(16526019)(2616005)(336012)(426003)(110136005)(478600001)(54906003)(6666004)(7696005)(40460700003)(82310400005)(2906002)(5660300002)(44832011)(7416002)(40480700001)(81166007)(356005)(82740400003)(47076005)(36860700001)(83380400001)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 03:52:15.8168
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 215d41fd-17ad-46c3-bc3a-08db72d411c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5719
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
  cxl/port: Fix NULL pointer access in devm_cxl_add_port()
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
 drivers/cxl/core/port.c       | 200 ++++++++++++++++++++++++---------
 drivers/cxl/core/region.c     |  52 ++++-----
 drivers/cxl/core/regs.c       | 139 +++++++++++++++++++++--
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
 20 files changed, 949 insertions(+), 390 deletions(-)

-- 
2.34.1

