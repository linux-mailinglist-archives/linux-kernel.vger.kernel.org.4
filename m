Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3B66DE36E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 20:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjDKSEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 14:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjDKSES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 14:04:18 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20624.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::624])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CC36589;
        Tue, 11 Apr 2023 11:03:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acTtRDRv8F9NJXQyRX+YQ8j+l8EItASWKxHb1D3UdUqkpVbeCf9dBT/2Xambb0Eil7+cCVuaSFuFPqLS5j2IVBsUSY0qpX1WDtmft0n+gc33hRUU/xeIId7D8qrENs1/2Bnq5582VS5VRdjv5HwPGIVqRDv0ZfyWilsB4BL0blB6X6AvTmvPiTrc6oxFpVLSLU+Qm6xq4ixxG8gakpCQpGDPEp73esiNafyhofHR0X4D+PEEGzF/r06eJ5vfinIfsXuUDq5csgm4YGOCom6dt61Zirep/KSfdwyzDa1DpqJ7th3T4VBMdMpG5nYLMP8eizqYqmlkE1dHzPmihiPa7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TekEiq1p1gfZTxmnigy85PcBm9Edc44DGMZu6PCaP+Q=;
 b=VYv/sH/z+cI/QlplGu1IVLC3s8nQm0O+RsA7XCBAMfHYHdKypGi4aAn6WHZSeu/V3g0oI0ycgpUFJBNFYUvIo09HEcrtltC0wOO0DNHOpsnktKodQftxspOGIUYC2awEOQU3kB5Lw0RCr/X+cFPdFU8pT8zsJDTR4YLHikUb3F/LZBOmLKClaXRovDH47o/M92EhYLG3sYf7ShYMr4/unZ8jdnijRs6N1qSSPBoi70wiB0pgoYsVgwRILPgRRI7WfifwPY1tjfu0i/zccrYX4fhlPXlN74166E+IlkL4GPg8JzKs8VfmE/pE0N/2QTeovbd/EEK0dxK/xFFo3te+jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TekEiq1p1gfZTxmnigy85PcBm9Edc44DGMZu6PCaP+Q=;
 b=yBxuQPhTym2hVYwDKXJ9jk1vVeLfM8ZiNp5r/uHDOYeQAQ54pGDsCi9Kswikq5cq/A7coNsUBaFb0FCgwsNmEHMITKuZJHFU7cvOwvfT/r6NDmOXCXwUfHZmo/e38+j23Dgzc9nFvo5pR/c7fVyD6wLdhhNuOflFYNIN7SwGHHw=
Received: from BN9PR03CA0800.namprd03.prod.outlook.com (2603:10b6:408:13f::25)
 by CY8PR12MB8242.namprd12.prod.outlook.com (2603:10b6:930:77::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Tue, 11 Apr
 2023 18:03:11 +0000
Received: from BN8NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::be) by BN9PR03CA0800.outlook.office365.com
 (2603:10b6:408:13f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.40 via Frontend
 Transport; Tue, 11 Apr 2023 18:03:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT072.mail.protection.outlook.com (10.13.176.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.28 via Frontend Transport; Tue, 11 Apr 2023 18:03:11 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 11 Apr
 2023 13:03:10 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v3 0/6] cxl/pci: Add support for RCH RAS error handling
Date:   Tue, 11 Apr 2023 13:02:56 -0500
Message-ID: <20230411180302.2678736-1-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT072:EE_|CY8PR12MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: d0c69dd7-40b5-4150-b938-08db3ab70394
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oUvKqdCPXmsH1f/YvVgufu8C5p4AQdTEozNRHCFGpofOlMInoWVLZTHEeBb8RpMqnydzksmA/K/r+jfhwBP8Do59UCQmTECALkW1AaVJMCPkowaavHjouh2nrfbx+h/DngNkTHqS+p8RhLRucdal2nChIUWnMRoj7NXGilkR+SmGQM7EhQychM50GEPvSaTXIcA78WvjaDcLhylHWFf0BvOugj61VBKFKVTAcZeFy7OoMZC8hmnLKDN7z/1J9SLK+phVZJf5wJ1pginFgyS/Y9E/0ogGy6aMJtUz1+O1xmxvJpUib6ktIJ6aqrRj3cedfg3RUGVWAuPdMtNw/sLvANLqEwX6chDNhJsugRh79K3YYeScfwKCD2ZC1YbvE9UEc7QJKY3oUTv6aZrr9SOdI1hrGPKVVwaCPOZuwHzznkyjrfbXiDQDC7WUcxMKFU1pI2/Fi84IjPr1pHEVBvbjIBRglZjMp3r7ymp4m5DhkgFetj5NXmMhI3nObn3tQrGC25OZI6d2EvAEFjq9Lp9Te96FmFkmRt6j9TmZxmmx9Gftq3OvCdxuBFE2EaD6PfXAe+6Xqwnw7Qmmjt+GXOjc9hB5BNjwRi2cmmAnCbHrrFKXugzarC33b3pxGjIutoxVioddGM7bW/HQB0mYfqqnz55H/ZDrvkwsSLka8eZirGphgLvk+MzBgNNCbzkWw1gCLWHCsSdi4p4ODDvx2M/kjLwiFCWsVfgDoHz6rEKwneI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(46966006)(40470700004)(36840700001)(6666004)(8676002)(8936002)(316002)(82740400003)(41300700001)(70586007)(4326008)(40480700001)(70206006)(478600001)(54906003)(110136005)(356005)(81166007)(40460700003)(16526019)(186003)(36756003)(36860700001)(2906002)(1076003)(426003)(26005)(336012)(83380400001)(47076005)(82310400005)(2616005)(5660300002)(7416002)(7696005)(44832011)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 18:03:11.6092
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c69dd7-40b5-4150-b938-08db3ab70394
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8242
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds error handling support for restricted CXL host (RCH)
downstream ports. This is necessary because RCH downstream ports are
implemented in RCRBs and report protocol errors through a root complex
event collector (RCEC). The RCH error reporting flow is not currently
supported by the CXL driver and will be added by this patchset.

The first patch discovers the RCH dport AER and RAS registers. These will
be mapped later and used in CXL driver error logging.

The second patch exports cper_mem_err_unpack(). cper_mem_err_unpack() is a
dependency for using the cper_print_aer() AER trace logging.

The third patch exports cper_print_aer(). cper_print_aer() is used for
CXL AER error logging because it provides a common format for logging
into dmesg.

The fourth patch maps the AER and RAS registers. This patch also adds the
RCH handler for logging downstream port AER and RAS information. 

The fifth patch is AER port driver changes forwarding RCH errors to
the RCiEP RCH handler.

The sixth patch enables internal AER errors for RCEC's with CXL
RCiEPs. The CONFIG_PCIEAER_CXL kernel option is introduced to enable
this logic.

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
 
Robert Richter (2):
  PCI/AER: Forward RCH downstream port-detected errors to the CXL.mem
    dev handler
  PCI/AER: Unmask RCEC internal errors to enable RCH downstream port
    error handling

Terry Bowman (4):
  cxl/pci: Add RCH downstream port AER and RAS register discovery
  efi/cper: Export cper_mem_err_unpack() for use by modules
  PCI/AER: Export cper_print_aer() for use by modules
  cxl/pci: Add RCH downstream port error logging

 drivers/cxl/core/pci.c      | 126 +++++++++++++++++++++++++++++----
 drivers/cxl/core/regs.c     |  94 +++++++++++++++++++++----
 drivers/cxl/cxl.h           |  18 +++++
 drivers/cxl/mem.c           | 110 ++++++++++++++++++++++++++---
 drivers/firmware/efi/cper.c |   1 +
 drivers/pci/pcie/Kconfig    |   8 +++
 drivers/pci/pcie/aer.c      | 135 ++++++++++++++++++++++++++++++++++++
 7 files changed, 457 insertions(+), 35 deletions(-)

base-commit: ca712e47054678c5ce93a0e0f686353ad5561195

-- 
2.34.1

