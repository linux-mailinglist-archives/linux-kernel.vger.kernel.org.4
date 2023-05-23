Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B01A70E972
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 01:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238544AbjEWXXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 19:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjEWXXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 19:23:08 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F99E5;
        Tue, 23 May 2023 16:23:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhdR9ZT46nO54pXNLCxSw9jBkEvWL/nHnMMAeSEt09c9LJtYRZjro7AWHq3XqRK7KyY71Ac1Ha6q5BfAZZTzRTPmApGxf0X5W8+gknYc22BqnjewOJAvK8wIsYNBE1f3zs9ylIgrsE16d5UfRMlwULTVo9roABSJ6MYT4bL8eZ9HDHpgqTIvYMw3LezbjCy1TgkD6lOS9irloK9kVOaDB1LXV6gGNwuJm2wjOvzS1oD9uxKnKIaXGNs/jcAlirRLjJd0co1jNpXTqiIUjf69p+ui7H1jpTAQKTyQQWrUIOiaAyakzE5XJHASQFWucOyolt3AOtEEwhzaOn7gLrf+Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqkYDj08VZ/iS+MotKsdFn42vBHIyOzo2vCCoKZehe4=;
 b=XDqKOWCb6CCgQVgFJyYzWBlBvi/3lstmLIPsiUOskfP5I7rBNm3hGAEnFHEr5VJszr3V2SDBwlU6d1PlG0WdEKWxDFV71q8tWM+pDilj9fBOGzzBJfIOCfzbuNCpfVTwA7vWDi0sXYcyt+k5emedvpI+GsnqZo25ELV/EqnFjtsAbaxOjLdo86Z/ka3VqPlQYwSkmr5s/IXEEFZljAlv18LNHPTrxsyPt14q11VfWUj/WWRJOxbxP8sLGhLAk2eImMWbuWTqx19KhTiTiKwvjl/V5nvXi4J1662hCCL3fPxoQyzFDONNEBw+e4J8kJHHX6vMubfnQxmynnIKb4oRLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqkYDj08VZ/iS+MotKsdFn42vBHIyOzo2vCCoKZehe4=;
 b=aUsXtqjBuP3LUKWMYc7E0rPFA3HJwDWvce0Iw/2KpiNuyvSn3uCXssWdTVZYrldoGL+bg8D5EFvNmFWLHjTWnRRglNqHT0qD8xrIe4AyCP8Cup230xduLToh7jDla2IShXfzSeVQfqvmpKn11jMPALciVDfZkpkU7bXSm+obbbQ=
Received: from MW4P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::31)
 by PH7PR12MB7259.namprd12.prod.outlook.com (2603:10b6:510:207::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 23:23:02 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::3c) by MW4P220CA0026.outlook.office365.com
 (2603:10b6:303:115::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29 via Frontend
 Transport; Tue, 23 May 2023 23:23:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.29 via Frontend Transport; Tue, 23 May 2023 23:23:01 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 18:22:59 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v4 00/23]  cxl/pci: Add support for RCH RAS error handling
Date:   Tue, 23 May 2023 18:21:51 -0500
Message-ID: <20230523232214.55282-1-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT041:EE_|PH7PR12MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b982afc-c75b-4396-f341-08db5be4a71e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uWIzI8uKmgY/WeAypxSY2YO6rhhPED5wGQW7j3Nf249JMUAAF3xsL1DgLrfAp96BN0iglYIgSmBTSU5++eJAmySxFPksB12QiR8XJ6m4uBrOArMqQQngKG9XFm9WzPCPtS4WfhA/2VDPTk7MoITGMKrWMn4EdIocVYsk7VW8AH8kZDnKodHM9YqgO7FrBaIw6S3kbTu3pUVq3VWuoflFrZDC4x+nym7rk/tgx2AoXN+IHrL3MuFoAOi4iOJttGDhTHhyOFPZ7Y+gZmq47UzVjvAZyYi8NbOiPqZPvIO84xNrENYWCM4Od3PmMulDMldsbmTRSduukQAFEAdGwQh9dDAhob5y6u0LNKfcFu+vqcWkR7LLg9EHCyer4NjqYng8rhQM9qnheO+vSvwk30MfgP2/x6vs9MPSXLL46M6QyR2QvqI7u6zmPzOMhfRLva13vUvolgizhtUEqbsnrGsAPXbpCr6AUc1RU+hzivRrwS1VpjeNEDmvaR6P0fLzQUsu1c5fOTgf3jyO+cOPAqOLmC3ORVhixfibyxBubvzacKu1MK/L0d+Ot1bt8LRBMqdn4yjKrBc2Qkf3aP3IubircZjSRkFG+3hmefy6zD1d+YB8I0BYEMNFk4E3faX1SrSs9+LkkDm8Ul2H2Lu+lawL7WhS7AXd0jp7ALW1lKMD0zHfwPEEj4g0hIlfPtOLO/rXcBgP9XQA0G98kaJggG/bCT1vjYA25Vd6QNiWX1fW5mkfBBw7Xw7UlXY1U57jW5jQw4XY50RQYN7RnJYGqlm/FQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199021)(40470700004)(36840700001)(46966006)(82310400005)(70586007)(70206006)(478600001)(41300700001)(7696005)(6666004)(54906003)(316002)(110136005)(4326008)(86362001)(8676002)(5660300002)(8936002)(44832011)(356005)(16526019)(81166007)(26005)(186003)(1076003)(82740400003)(40460700003)(7416002)(426003)(83380400001)(2906002)(40480700001)(336012)(2616005)(36756003)(36860700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 23:23:01.6145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b982afc-c75b-4396-f341-08db5be4a71e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7259
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

Patches #1 to #16 are a rework of the Component Register setup. This
is needed to share multiple CXL capabilities (HDM and RAS) for the
same component, also there can be different components implementing
the same capability, finally RCH mode should be supported too. The
general approach to solve this is to:

   * Unify code for components and capabilities in VH and RCH modes.

   * Early setup of the Component Register base address.

   * Create and store the register mappings to later use it for mapping
     the capability I/O ranges.

Patches #17 to #23 enable CXL RCH error handling. These are needed because
RCH downstream port protocol error handling is implemented uniquely and not
currently supported. These patches address the following:

   * Discovery and mapping of RCH downstream port AER registers.

   * AER portdrv changes to support CXL RCH protocol errors. 

   * Interrupt setup specific to RCH mode: enabling RCEC internal
     errors and disabling root port interrupts.

Dan Williams (1):
  cxl/rch: Prepare for caching the MMIO mapped PCIe AER capability

Robert Richter (16):
  cxl/acpi: Probe RCRB later during RCH downstream port creation
  cxl: Rename member @dport of struct cxl_dport to @dev
  cxl/core/regs: Add @dev to cxl_register_map
  cxl/acpi: Moving add_host_bridge_uport() around
  cxl/acpi: Directly bind the CEDT detected CHBCR to the Host Bridge's
    port
  cxl/regs: Remove early capability checks in Component Register setup
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

Terry Bowman (6):
  cxl/pci: Refactor component register discovery for reuse
  cxl/pci: Add RCH downstream port AER register discovery
  PCI/AER: Refactor cper_print_aer() for use by CXL driver module
  cxl/pci: Update CXL error logging to use RAS register address
  cxl/pci: Prepare for logging RCH downstream port protocol errors
  cxl/pci: Add RCH downstream port error logging

base-commit: a70fc4ed20a6118837b0aecbbf789074935f473b

 drivers/cxl/acpi.c            | 191 +++++++++++++++++++---------------
 drivers/cxl/core/hdm.c        |  59 +++++------
 drivers/cxl/core/pci.c        | 140 ++++++++++++++++++++++---
 drivers/cxl/core/port.c       | 157 ++++++++++++++++++++++++----
 drivers/cxl/core/region.c     |   4 +-
 drivers/cxl/core/regs.c       | 152 ++++++++++++++++++++++++---
 drivers/cxl/cxl.h             |  56 ++++++----
 drivers/cxl/cxlmem.h          |   5 +-
 drivers/cxl/mem.c             |  16 +--
 drivers/cxl/pci.c             | 109 +++++++------------
 drivers/cxl/port.c            |   5 +-
 drivers/pci/pcie/Kconfig      |  12 +++
 drivers/pci/pcie/aer.c        | 173 ++++++++++++++++++++++++++++--
 include/linux/aer.h           |   2 +-
 tools/testing/cxl/Kbuild      |   2 +-
 tools/testing/cxl/test/cxl.c  |  10 +-
 tools/testing/cxl/test/mock.c |  12 +--
 tools/testing/cxl/test/mock.h |   7 +-
 18 files changed, 824 insertions(+), 288 deletions(-)

-- 
2.34.1

