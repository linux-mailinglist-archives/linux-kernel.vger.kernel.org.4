Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5620F727163
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 00:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjFGWRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 18:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjFGWRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 18:17:12 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A658C1725;
        Wed,  7 Jun 2023 15:17:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Opqva0Z8fX5ErdK7vVvXomGxkVyBlRjI7fCXujQk6voUWi5IhfA1RbBtuZ2k3Cy15l3K7wEgzpb5D+FnzL9JiQFsRRvtpfpbPt2srRvsgS1dObav7Xb9D+NpJOpfA1ZqwgmSrBh98Pc0jmSc7VfWq+rzlT7lo73XAY4re3RSTkhIdFC7bWrTlbzNuCRGPZwC9el9lrOOOvgDezw+duivA3NMAWmd0yPzL8TI7QXt0xOF5KQwI+SGiE1r59wfVo8R7ME4ixr9A6Jaj7UqF3SAzpuC6Ms5rfRSXyrP5tWqPKP1bQPXXMA2vh//JjJ0Xa9bwnbkiLnOzVBwkHRkRVgn9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVifTX2y/SYWZZShDOWp4cY7OT1TM5b2oVQxUVTWk1k=;
 b=HcscJriM5jJQmBKsmZiM9HblUKYR4NMbkWG/Y0mI9tVVA7/PJIMsrM4Q0ck9K7vIdzQ9MxvTUQeH2hTInL9mqiBmUxoANBHFnn9rGZYlmYpKDCbHlmPuB00Oumeke0FOD1RXn7DTzolLGzFl1ydbKdR9GtLX3Q7qzrLeeOTm0ag60X2FjwBZNhoji0fwzG3y1LFqx5Sqkq2/Q0HzDr5gpUtKH/erXbCmMeNXKIH5DD7+Rajyd1cdEEdsQhKXWv+ArmKdbSabOSQeIqn0XUCXB+aRlfL5el4Dt3tYGQtEuD8aEh6hjry0d6O4SWRjp4dqNkrKQ9Zqy4PTrPRJUK/m0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVifTX2y/SYWZZShDOWp4cY7OT1TM5b2oVQxUVTWk1k=;
 b=FDv3Pv0s8UsqLaIq1ne78jzkNIahMb+b7FVA5bG4PYEMjmcacVJAOe9H+oP+LtaA5vSkfKjwGvkM54itLRysmY/aCfCTeg16WcoQNBkjbpIoxJqwcbExC8UWQex8SXXUSv+gJUVAyAIml77XXz2/CIghuYqJVehRfWvppKRWvG0=
Received: from DS7PR05CA0006.namprd05.prod.outlook.com (2603:10b6:5:3b9::11)
 by IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Wed, 7 Jun
 2023 22:17:08 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::24) by DS7PR05CA0006.outlook.office365.com
 (2603:10b6:5:3b9::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 22:17:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 22:17:07 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 17:17:05 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v5 00/26]  cxl/pci: Add support for RCH RAS error handling
Date:   Wed, 7 Jun 2023 17:16:25 -0500
Message-ID: <20230607221651.2454764-1-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|IA1PR12MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: 748c3a02-8ffb-481e-10e8-08db67a4eea5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jU8bQDtxTSpkSAMZDngIm3QHSqaGKesZTeBKaEuzzOtnBNT+I3CavnEZYFcgNRdG6QZ125qQHyySNMPYfvie+Hcaqv7qKK3IOb2yv6gIfLlUGecqp+j8D9n+LwzMQmxOc6SdQUjQoNjRI98pNbN33Lk5nIvpF9pqhMLyHPVJo4j6MW7nGMS8iHitIevwqEiyc1NqQs2Q9ZtNOq08tt8f5MIJEG/K1wGvNzBV2VTwyjW5nRNCxT6N/Ka3CUK8Frr8j6H9c5WqfWSyLCh1uVeYpRaA7XLgFlNeJdeoL1b+73GDHARryNVK7E3qEg1bn1jEY5d1971i1zypWeMSS9GdUbHb9E2ajbhsJnp7t4/q5QNRKPOTRpGQCshCdQUFYjx8KsoZiucK38d5bCkRzO5o8zUGnWrak8I4z+6CV0iJmfE5/Q0Suv7RDoQ9YYGtXXnZwpcczPRBqgX0kqPW2zlzt499MBaHkFjjCV82pEl0SXOIQsMLrK77Rg8lzX0Z5kvBlESluSvJO/TEjyWsyS7GjNWPX1oiZ95hdAKnCLcmIhaQQDT5GVRTuIXcULAeTodss1qDkZbRG5rcwmGFOW9vNjX0Ll8FG7rDLhCrev8u0kV9Fc/nSdEwkb9Kvsrkc1UJhsf4bwo8UygqEZKAXYOiu464KMC4ZhFaLhfMQzDD36sTE8vXYeBdtsr1Fr25lSwo4H4hn95KpmJb+vhRoNBHoiBmXeEjHGtwJBc00RLQgoEkbQ652Myro/X4+Fc9+VgdX/IDKMajRccw6c7gWP/49A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199021)(46966006)(40470700004)(36840700001)(36860700001)(82310400005)(41300700001)(5660300002)(110136005)(8676002)(40460700003)(8936002)(54906003)(6666004)(478600001)(70586007)(70206006)(4326008)(316002)(7696005)(40480700001)(82740400003)(356005)(81166007)(36756003)(86362001)(16526019)(336012)(47076005)(426003)(186003)(83380400001)(2906002)(2616005)(44832011)(7416002)(26005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 22:17:07.8524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 748c3a02-8ffb-481e-10e8-08db67a4eea5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6330
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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

Patches #19 to #26 enable CXL RCH error handling. These are needed because
RCH downstream port protocol error handling is implemented uniquely and not
currently supported. These patches address the following:

   * Discovery and mapping of RCH downstream port AER registers.

   * AER portdrv changes to support CXL RCH protocol errors. 

   * Interrupt setup specific to RCH mode: enabling RCEC internal
     errors and disabling root port interrupts.

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

Dan Williams (1):
  cxl/rch: Prepare for caching the MMIO mapped PCIe AER capability

Robert Richter (18):
  cxl/acpi: Probe RCRB later during RCH downstream port creation
  cxl: Rename member @dport of struct cxl_dport to @dev
  cxl/core/regs: Rename phys_addr in cxl_map_component_regs()
  cxl/core/regs: Add @dev to cxl_register_map
  cxl/acpi: Moving add_host_bridge_uport() around
  cxl/acpi: Directly bind the CEDT detected CHBCR to the Host Bridge's
    port
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
  cxl/port: Remove Component Register base address from struct cxl_dport
  cxl/pci: Remove Component Register base address from struct
    cxl_dev_state
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
  cxl/pci: Disable root port interrupts in RCH mode
  cxl/pci: Add RCH downstream port error logging

base-commit: a70fc4ed20a6118837b0aecbbf789074935f473b

 drivers/cxl/acpi.c            | 191 +++++++++++++++++++---------------
 drivers/cxl/core/hdm.c        |  59 +++++------
 drivers/cxl/core/pci.c        | 140 ++++++++++++++++++++++---
 drivers/cxl/core/port.c       | 163 +++++++++++++++++++++++++----
 drivers/cxl/core/region.c     |   4 +-
 drivers/cxl/core/regs.c       | 154 ++++++++++++++++++++++++---
 drivers/cxl/cxl.h             |  56 ++++++----
 drivers/cxl/cxlmem.h          |   5 +-
 drivers/cxl/mem.c             |  16 +--
 drivers/cxl/pci.c             | 109 +++++++------------
 drivers/cxl/port.c            |   5 +-
 drivers/pci/pcie/Kconfig      |  12 +++
 drivers/pci/pcie/aer.c        | 162 ++++++++++++++++++++++++++--
 include/linux/aer.h           |   2 +-
 tools/testing/cxl/Kbuild      |   2 +-
 tools/testing/cxl/test/cxl.c  |  10 +-
 tools/testing/cxl/test/mock.c |  12 +--
 tools/testing/cxl/test/mock.h |   7 +-
 18 files changed, 822 insertions(+), 287 deletions(-)

-- 
2.34.1

