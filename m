Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2252602CD4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJRNYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiJRNYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:24:09 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4257FC90EA;
        Tue, 18 Oct 2022 06:24:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kfp5qSA+Zp5Cuh4rSuacxIOdA1eQ+eLF3Ao7xaaGtpbZ+4kvcK65/QCdML3zi6wWor2BcKeJwsoIrYPHE0EvZvLM9hGwUj9PwtLAYss9o0uYCO+3s98jdxWEE3WddDZsB+ua+bGFgwAG2vAXztzlcVd+e7pvhfpogTHnW7MdrVlQr43x9MHzCRqWzZAIw72+o3lXy0NIxZ7IoiikqDF/p704cNJVHQmNtl/ptLzI2OA2FZbayJwLkl2n1xRSyuKCv274+zxj2GgGwhjTO9sKclDX0a0MJxRVxzCpn50nnSGTOgHQzKiQ3R6nqW+L3JEc+kB+bhPVOIYTd1NCZ1caAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNEbkPpDXsrYH0Sxdwr6U7qbLj/0JKGZlpusjAJ50qQ=;
 b=eFouOZlbIZZpVeaB5AwCQHLLr/OhWQX44P8dxSQ/UNr7+lZOKVwoaLykPdrLiyVAxAwGw+mN09/I+PTvC71HqLtscsOt3KjWaoKJaus/I4GT7nv1YH1Zyt9zaoev8Zjt9ufpDB7bhOdPEJg2Xn23jOp+/YQ7FPQJw8pEvNyyX369rEbwwzr2B48P1isboO0gPj/1i7KM2qe+zJAr8Hv4k38Sz2vILpprgG44PZJsm8hR/RVm3xjt8tbFjWXOSg9WHTRgo4ZlWhTN7gZXNaA7FUuFwrmolhsh8Vl1bz36EJk3V+UdKzeaK59TKxKTjrQnYvEvSdXyZ0qlJYTRKvycjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNEbkPpDXsrYH0Sxdwr6U7qbLj/0JKGZlpusjAJ50qQ=;
 b=AY/m47d1R+GBB5URA8xHWhIlb7ptafTJ0MIfE7LNT+O1PNxFc0UGLURofJ13LdpHazXwCqr+m3K2GCnrk0QEKxh76QCpNOTV+fz0M7FNlbKTBviMn8to+yYMkCQIjHDMBMnU7pEiTOc14JR3eOXThKipH9CwZVRqFJkSRP6gjMM=
Received: from BN9PR03CA0943.namprd03.prod.outlook.com (2603:10b6:408:108::18)
 by IA1PR12MB7567.namprd12.prod.outlook.com (2603:10b6:208:42d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Tue, 18 Oct
 2022 13:24:05 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::3d) by BN9PR03CA0943.outlook.office365.com
 (2603:10b6:408:108::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32 via Frontend
 Transport; Tue, 18 Oct 2022 13:24:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 13:24:04 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 08:24:02 -0500
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
        Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 00/12] cxl: Add support for Restricted CXL hosts (RCD mode)
Date:   Tue, 18 Oct 2022 15:23:28 +0200
Message-ID: <20221018132341.76259-1-rrichter@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT054:EE_|IA1PR12MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: a934b5a8-2cbb-473a-e1c1-08dab10c0776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MiPOz966CZ0IHaQgO3NYYxMX5ypuiIG5QbHKGHj4Zmck6n27mOJlRz3l9ScoQfqFCMqacqfmk64VvBBwucB3jz2LIeQrNG1+lcnqdoYqt+H46faFIOWH4C07eOxcqJ1HaeUNYoJlKC0DTaMdil+BliMHpDxXvPNL4YVTdliujohjtSUJzUhnTaURH1PoJENW07mkzP6Ahwq3xbnYqy0dPMaEw3P9YNJjgHGlfkXuEOBaIls8itKXsoUh7SK6nnh3t/MktJ9IqZXhpPsbbdHUfdXkGLjVkwkG+gAC9lttH4lfLjvVsC1L+r0SdN2yYmQEzZ0v44AdnrjBOnp+65KD1GJermlJWY27nC3ynoBHHg8k6pUf7wIOWF9ChN41+aPfv7RBjimPEw3P2MneYvn8MGJD3hx9v4xgf0dopwHnxTmxd4x9DuMFEeKU6bb7EMylARFZROSZz2qznWxbLgWB+cgPb2jok7WD1+s1zS+UBKvZ8u08/9dlB+K01XUzdgvT4TXJTJbSukLViKroOrl8u4ucAX15GlqsijXXf3BkSRGZBAOCHjBz3wqNlGrcwZgG4rz9clfGF21wp8SrpaCzdMAy3V/KOAoQZLqBZr/bLMaGHDzwlKB59+Hj04ILZxuL+sLboM9vqn8s7CTBVgqwd7WEuYMMfrpGTA/7hd69rMDa/AbXFWeqfsApkIiK8VyXIwwkGA+OlZUhsP2Jxo7bjE/6CeMsatUxageNF63nR4LaomN3KEHKIa8R2tiCc6jM3GMjwscQK9wV5bytNiVYUrGqRnnMZ9YyR8uyeEFaWeJcxz0BKv4Ko/38/hokvCFGqlOHsWjC7dwj6j0H0CqRsg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199015)(40470700004)(46966006)(36840700001)(1076003)(2616005)(186003)(16526019)(426003)(83380400001)(47076005)(356005)(81166007)(336012)(36860700001)(82740400003)(7416002)(5660300002)(2906002)(82310400005)(8936002)(4326008)(40480700001)(8676002)(40460700003)(6666004)(478600001)(26005)(316002)(70206006)(41300700001)(70586007)(110136005)(966005)(54906003)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 13:24:04.8833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a934b5a8-2cbb-473a-e1c1-08dab10c0776
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7567
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
ACPI0016 host bridges to enable CXL. This implementation requires that
in RCD mode an ACPI0017 device exists, the host bridge must have the
ACPI0016 ID set. This implementation also expects the host's
downstream and upstream port RCRBs base address being reported by
firmware using the optional CEDT CHBS entry of the host bridge (see
CXL spec 3.0, 9.17.1.2).

RCD mode does not support hot-plug, so host discovery is at boot time
only.

Patches #1 to #5 are prerequisites of the series with fixes needed and
a rework of debug messages for port enumeration. Those are general
patches and could be applied earlier and independently from the rest
assuming there are no objections with them. Patches #6 to #12 contain
the actual implementation of RCD mode support.

[1] https://www.computeexpresslink.org/spec-landing

---

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

Robert Richter (12):
  cxl/core: Remove duplicate declaration of devm_cxl_iomap_block()
  cxl/core: Check physical address before mapping it in
    devm_cxl_iomap_block()
  cxl: Unify debug messages when calling devm_cxl_add_port()
  cxl: Unify debug messages when calling devm_cxl_add_dport()
  cxl/acpi: Improve debug messages in cxl_acpi_probe()
  cxl/acpi: Extract component registers of restricted hosts from RCRB
  cxl: Remove dev_is_cxl_root_child() check in
    devm_cxl_enumerate_ports()
  cxl: Factor out code in devm_cxl_enumerate_ports() to
    find_port_attach_ep()
  cxl: Extend devm_cxl_enumerate_ports() to support restricted devices
    (RCDs)
  cxl: Do not ignore PCI config read errors in match_add_dports()
  cxl: Factor out code in match_add_dports() to pci_dev_add_dport()
  cxl: Extend devm_cxl_port_enumerate_dports() to support restricted
    hosts (RCH)

 drivers/cxl/acpi.c           |  98 ++++++++++++----
 drivers/cxl/core/pci.c       |  76 +++++++++---
 drivers/cxl/core/port.c      | 219 +++++++++++++++++++++++++----------
 drivers/cxl/core/regs.c      |   5 +
 drivers/cxl/cxl.h            |   2 -
 tools/testing/cxl/test/cxl.c |   8 +-
 6 files changed, 305 insertions(+), 103 deletions(-)


base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
-- 
2.30.2

