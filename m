Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DA6607E70
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 20:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJUS41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 14:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJUS4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 14:56:25 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F79924BA93;
        Fri, 21 Oct 2022 11:56:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWpzSbKmasBNR5LzVXEXdkTxlGiDLooYy/UUetJ62aRRSEJTwD4vtslpDurW97eYawFsTMVNYP8q0Pzg+Hc25m3lOe4MApB2BesoLqts+KYsrbqsNUgVaGK9F8GFh2N+rrx5hnEE3c7oD2qqHRt8kQSr8XpsPiood9eX/kkDjhTpIHsP7Nihveu4bfEM30maQqoyCoPCzI8dw2s31T+shwyaXi34wPwrHpBC4Zb72IJT8emVA3F9dc5+ClHsRedXY2cad+gCNmW1NGh6x4b+frJSKEXIM9/lHlm+o2yMZkJ4scpJDvoomGDttbdMMJPGk6P9+H0jI933iRfQB94W6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9ACCsIjWA0YwP9TlylyaaVj6ixQT0keiRDFcduQHeo=;
 b=GhosUWcadPoyQAfQNyprbrHfs6UgUywmYj6BbexiYAl4ZRicdAQs7n8PS7ukA51f4zA5Ok4FByoMOLhegBxDa01Hh9alEnYoaKGvJtQ3aDp+e523ziAXxCXe5OHK2Uybyc+SFeJfeALdg71Y93aXqH6Wv7nE9dKcCP8y2Zczq0nlB+qQQuFgtQ7G7qEzONtN8RNKHiDTwLkuPVr/+PP3oCrMTr0fi0m7LBu37ta0JTEW4k9iBMzgRJihQSOJhzA9clFjrzgW9DwFFC7832ApUAaaJDUCiigseEggLYCK6HRtafzCBjiNyu/Q7xEvREL6Ojz5kCsLWf7+kapo48cRGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9ACCsIjWA0YwP9TlylyaaVj6ixQT0keiRDFcduQHeo=;
 b=Hk9Q/oxsaFbHasHlih+Y5DFYHvsCZANSvv+4+MbRWJ1bGQ7gagr5KbWDH99S6iICG/2ybPDzUrjNUz7RbKMrn8xwW931RE8huG+I9Wg62cCDx/espCFtcp24OQa22x20KpIzqMWqQhoE1VZs7VZ+Umn0uf34CwJQmda28xV0hTA=
Received: from BN9PR03CA0513.namprd03.prod.outlook.com (2603:10b6:408:131::8)
 by MN0PR12MB6342.namprd12.prod.outlook.com (2603:10b6:208:3c1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Fri, 21 Oct
 2022 18:56:21 +0000
Received: from BN8NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::34) by BN9PR03CA0513.outlook.office365.com
 (2603:10b6:408:131::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34 via Frontend
 Transport; Fri, 21 Oct 2022 18:56:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT104.mail.protection.outlook.com (10.13.177.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Fri, 21 Oct 2022 18:56:21 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 13:56:20 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>
CC:     <terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>,
        <rafael@kernel.org>, <lenb@kernel.org>,
        <Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>,
        <rrichter@amd.com>
Subject: [PATCH 0/5] cxl: Log downport PCIe AER and CXL RAS error information
Date:   Fri, 21 Oct 2022 13:56:10 -0500
Message-ID: <20221021185615.605233-1-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT104:EE_|MN0PR12MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: 88834bbb-6545-49aa-51b0-08dab395f1f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ArgqHOdH/vrz4L9lTmTVRSDpidfHMz/ELyxsY4ZefvyIuYlMjN3pqC7WI9Li5g8GcOYKAAh67KBDEUsGsuEr0T+Bn3h3gddlx40gU60q88kHpucBEvcvsAm5DA8qOD3roqx8UVfAESoasujIrWopHVIEEMDkphXar4vGilz5aqM2LDeir6QTCpYFGlJLT687G4Zx5gFMGm8vPjvQkf2Otm4G+02+0whzTOddC+t3Ug+qBLCO4GRZTJxwc1LUNSuviN+/1lbdApNlyyqFiLTjlQufsR0MMXOEYOe63hd8t6U8cvMBFelVq8dtJ9y/5PXBmhG5vWaXhENrAMiEZL222sJBPhZEm2vPJjJEy4f68HRudSmrIAdAcrIq2kfQ644cb3vgivZAlSzwSnsqeB/dD7rqXUL0/11mL0YmscMD2doCx16VAz5zJ34krKaMtyDrHASHMP346QL+dCqPL3J0oP1oRU8mz6D6nkmfh8j2UE97aoUO9CcN35xHXLYS2wSiI/4uTNxIjTDoDeW7g3mFLskC/lAIa+3kfHBpbGEZM45zGsV3LxU7nZvwgnK4pLUGuMJDl1fTKP3H7kocTusnX9QfMR6UGvHisNj8YaOQ6Slxi5sNoBBP0jzCfXqCb3ShJ11PAhQWl95aij3kAwyxA9bbj7k/Gbw4nqiR9CS5j1TocW1SPQUxqemoMqXcDl7XiQL4by2fQh5Q1GUAvKro2lkQapLuvqq0j3HFyKWL975PsEoujRFA8n0117u/CJ8xwVNI8Lz8m0EKMdhHsJvZjnQR7ocuw2TBZk7LE31KVTLFzACXIx1Fe9RTiz610KL8O1vMQGwVfUmIX74m295lxkM5VDkyrNQDPC66DChba9j589AqOHm0KD6MTSGKDgqg
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199015)(40470700004)(36840700001)(46966006)(83380400001)(40460700003)(47076005)(478600001)(82740400003)(82310400005)(54906003)(110136005)(426003)(356005)(81166007)(966005)(26005)(2616005)(86362001)(36860700001)(16526019)(316002)(8936002)(44832011)(7696005)(2906002)(186003)(40480700001)(7416002)(1076003)(6666004)(36756003)(5660300002)(41300700001)(70206006)(336012)(4326008)(70586007)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 18:56:21.6697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88834bbb-6545-49aa-51b0-08dab395f1f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6342
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds CXL downport PCI AER and CXL RAS logging to the CXL
error handling. This is necessary for communicating CXL HW issues to users.
The included patches find and cache pointers to the AER and CXL RAS PCIe
capability structures. The cached pointers are then used to display the
error information in a later patch. These changes follow the CXL
specification, Chapter 8 'Control and Status Registers'.[1]

The first patch enables CXL1.1 RCD support through the ACPI _OSC support
method.

The 2nd and 3rd patches find and map PCIe AER and CXL RAS capabilities.

The 4th patch enables AER error reporting.

The 5th patch adds functionality to log the PCIe AER and RAS capabilities. 

TODO work remains to consolidate the HDM and CXL RAS register mapping
(patch#3). The current CXL RAS register mapping will be replaced to reuse
cxl_probe_component_regs() function as David Jiang and Alison Schofield
upstreamed. Should the same be done for the AER registers (patch#2)? The
AER registers are not in the component register block but are instead in
the downport and upport (RCRB).

TODO work remains to add support for upports in some cases here where
downport is addressed. For instance, will need another aer_map to support
upport AER ?

TODO work to support CXL2.0. Should be trivial since aer_cap and aer_stats
is member of 'struct pci_dev'.

Base is from: https://patchwork.kernel.org/project/cxl/list/?series=686272

[1] - https://www.computeexpresslink.org/spec-landing

Terry Bowman (5):
  cxl/acpi: Set ACPI's CXL _OSC to indicate CXL1.1 support
  cxl/pci: Discover and cache pointer to RCD dport's PCIe AER capability
  cxl/pci: Discover and cache pointer to RCD dport's CXL RAS registers
  cxl/pci: Enable RCD dport AER reporting
  cxl/pci: Log CXL device's PCIe AER and CXL RAS error information

 drivers/acpi/pci_root.c |   1 +
 drivers/cxl/acpi.c      |  56 +++++++
 drivers/cxl/core/regs.c |   1 +
 drivers/cxl/cxl.h       |  13 ++
 drivers/cxl/cxlmem.h    |   3 +
 drivers/cxl/mem.c       |   2 +
 drivers/cxl/pci.c       | 319 ++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/aer.c  |  45 +++++-
 include/linux/pci.h     |   4 +
 9 files changed, 443 insertions(+), 1 deletion(-)

-- 
2.34.1

