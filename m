Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF27607E78
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 20:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJUS5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 14:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiJUS5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 14:57:13 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFAC28F278;
        Fri, 21 Oct 2022 11:57:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnCi6dsnpvHeugPfwT2JqybkHgM/4itAn+vtKTgQBS+nrEIuyMHM5ivtCb5WbeaFh6OYcyqAzt7ZWQ0chh3+loVSWNrN198H+RIMp6HgX6gq9D2zsSAmvVxoDTww8qX4rS+nEyum4NKKfWkB+Q4cRoU67GYwfNq+rM/UxtFJAqQkdcCJ9Hdm4Ue9xqUnvUtk/9HG6yqYB2UXRXyNeR+s0pwSxXZ5O7ZOQ8y2RhgSYtgBS4eBo3d3T2zni7dp1fBKLAoQ2gdDb+n372PDuU0XB2lvh2VXtosmrBzz92juf6vJtOyRsPI7Nm2sdwk+x+G5OpDGd6atZoZG7t5K75F1Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEUepIvqVCto5d9DOAhi8VyT1xoFQF7b2RHIibve5pU=;
 b=Qb36Y9np3bMzLVvtWEiDtWiX2g6YdWam+4pCrOoBTeRvY95DKCtP3QqUjA9kXWWw4ghQ2K4m1qNrkqt2wLX83524IdCwZ/6Qfv4/j187TetUiYKLEVPLqPpZGHq0ZCXVN92IgaA8Jo3FFG0jlQFr+8M/XXKszpO2DUIfXhsLielgPvn2kvugCrKv4657/okdtT3KHu4W9xL+0WErmzP01sIHoULX7faNIstmrTy61M4f7U1B3KZmA9+/hMmuiU90/3kNztOVQ96mfuJT/OowX/7P0HX/xq6O4g2qKt49hHM0wfCmzAFi0BzqmRW4X9myT3gKtIxwUyA1kD594zCL2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEUepIvqVCto5d9DOAhi8VyT1xoFQF7b2RHIibve5pU=;
 b=shCPxl6RQx2IAsRHZDj/SAf4em2eTKoSPnmUX6i0BaUZyBue9EC2T407lUL0CP1FKrJJICHAPMSgpKDAyUgujTaebUzBTYUhReH1Q0y5YIdZpQgEcWzulv/HOiTGZVQvnLWgPpfQL87OHTP76In9ASSLHlLo4MekAEHnUAKNk5c=
Received: from BN0PR04CA0095.namprd04.prod.outlook.com (2603:10b6:408:ec::10)
 by DS0PR12MB6416.namprd12.prod.outlook.com (2603:10b6:8:cb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.21; Fri, 21 Oct 2022 18:57:06 +0000
Received: from BN8NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::60) by BN0PR04CA0095.outlook.office365.com
 (2603:10b6:408:ec::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21 via Frontend
 Transport; Fri, 21 Oct 2022 18:57:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT096.mail.protection.outlook.com (10.13.177.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Fri, 21 Oct 2022 18:57:05 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 13:57:04 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>
CC:     <terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>,
        <rafael@kernel.org>, <lenb@kernel.org>,
        <Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>,
        <rrichter@amd.com>
Subject: [PATCH 4/5] cxl/pci: Enable RCD dport AER reporting
Date:   Fri, 21 Oct 2022 13:56:14 -0500
Message-ID: <20221021185615.605233-5-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221021185615.605233-1-terry.bowman@amd.com>
References: <20221021185615.605233-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT096:EE_|DS0PR12MB6416:EE_
X-MS-Office365-Filtering-Correlation-Id: 51e11ef2-2359-45fa-6a88-08dab3960c28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VE58TeLIba04z28DIZzytxZ8Xk/eJDXXsXNQOX2kXzpiKOu4vInWtLZsSWDLCCMHDrOMg7mSL4y86i4LByS7E5SeNRwO6O73Fy8Xc1GDioLYVtH5r41dJC678HeOqhLBW5Pj7GiiJWb/3bsOlf35Qh1/uUBYf4nKgsJBdYw0o+Z4sG+w35w3jngX5gRBZEGTKhmjRJMuEqrOb3SHVQmuMfMtzfCuCgz1oWTAZcTY+O6p8HfSwdz2PnHdILj/zvlghQqA/vdZnfuY4rEmsgCISvA3jZbuZlyLW5wUIpCuvgkcv9AROEECJJBu/gQwgflK5oeOAmJ4wchQwWku6uRE5fjpc4OHJD/h2gvl7kPX/CTwkLcATdN/mJzOwrf3vYXNIXvG45S3duqcosafG0fXIdwOhRCH1so7FgfqL8ZD0ykr0Z9clOntdPmnWFD51RCtlClsoqQPdStZF8qo+EeH0Z7ilarcfEfyrrQ1rQDEdRJWOC2kxxnJkdJ210kjnOdFD7n2q5EU+alioDPCjrqEFNP2vf/7BUifS2pxZZ7jK3siif9RyMt68MSl7qd/b1o2gnFIJI+h2DpK8dBFJZT0dQ5dNJv54Hluiv1SOxzYAkHkSW5iIkPGM6BuWdYeZysedTRvjASCcKhMnhIBhKlMWXVfFVFs+rsgWQOMKHv0FZQ6/EutocC+doYEhMewQCyA3JHR4XIeiSTUaThDGLbbaVimwEDPHSG0imwLFKZGyuqgWC5u0LGWNBYEtrTxQ6SnQjYH3N5UclVJ/t/5AOYGiCy5Lz0vma5kKtWNlJDmvCyRw5FYwsFTL02P7THIBrx5
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199015)(36840700001)(46966006)(40470700004)(36860700001)(40460700003)(82740400003)(316002)(81166007)(356005)(54906003)(4326008)(8676002)(70206006)(36756003)(70586007)(110136005)(82310400005)(2906002)(44832011)(41300700001)(8936002)(7416002)(5660300002)(426003)(47076005)(40480700001)(6666004)(7696005)(336012)(186003)(1076003)(16526019)(2616005)(26005)(478600001)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 18:57:05.6319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e11ef2-2359-45fa-6a88-08dab3960c28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6416
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RCD downport/upport include 'PCI express' capability with AER
registers. The PCI subsystem is not aware of RCD downport/upport AER
because the downport/upport are not enumerable devices. Since the
downport/upport are not enumerable the existing PCIe AER logic to enable
AER reporting does not apply.

Add logic to the CXL driver to enable AER reporting in the RCRB 'PCI
express' capability. These must be set for correctly reporting the PCIe
AER errors to the RCEC or root port.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/pci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 7f717fb47a36..80a01b304efe 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -553,6 +553,17 @@ static resource_size_t cxl_get_dport_cap(struct cxl_memdev *cxlmd, int cap_id)
 	return rcrb + offset;
 }
 
+static void cxl_enable_dport_aer(struct cxl_memdev *cxlmd)
+{
+	struct cxl_register_map *map = &cxlmd->cxlds->aer_map;
+	u32 devctl_cap;
+
+	devctl_cap = readl(map->base + PCI_EXP_DEVCTL);
+	devctl_cap |= (PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE |
+		       PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE);
+	writel(devctl_cap, map->base + PCI_EXP_DEVCTL);
+}
+
 static int cxl_setup_dport_aer(struct cxl_memdev *cxlmd, resource_size_t cap_base)
 {
 	struct cxl_register_map *map = &cxlmd->cxlds->aer_map;
@@ -566,6 +577,8 @@ static int cxl_setup_dport_aer(struct cxl_memdev *cxlmd, resource_size_t cap_bas
 	if (!map->base)
 		return -ENOMEM;
 
+	cxl_enable_dport_aer(cxlmd);
+
 	return 0;
 }
 
-- 
2.34.1

