Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF702602CDF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbiJRN0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiJRNZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:25:40 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A8BC58A5;
        Tue, 18 Oct 2022 06:25:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYzbO3ndLtkhbyTZNwPXLuK1JJyHDMcz9u0GiYRr2F97ePRlSBtUU8ZNIuZlwhlFGZerxtdtjUVKLb8+Y/7bAOTNvfyi33Mg9u3gLxgKkHlXxzuDgtDXwRbeaO1RAePBmWhN5G9pCbvUTNyeleI67hT+ALWruAeLrd2bOQjpoIHIUWVH/jblObEw53M6Tjbh51KO95SNa9hRyVKULwk5nWhUCe7+BBtCHMbPKN+rxZJrB9cWq+u3305tuU3rR+quFLx3p5QzIZ/8AbKEXyEnyzihsifGLmW0oU6lsOJQrj9tlau1ZXYGFDm0/ATf2atxOYTHib1nU2OV6EzipPmfpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=165J/0jl3YniOXsSGugeLHpDY9z5jKXw9zLnBFsDvys=;
 b=VXLiGJWadu4wGvN269dSRAYiwYoBv6cy6WzT7yLiZ86l/E19XKzkdMrrtVSxCTwvFpGYS5c6hoU1ME2coteDo9CbQVNc9tGvpUe1TbMPWq5aBIT3jq1vEe1W4FRLOxipll7+pQeQSxO3HjtR41DMGqxWkZDsxsR/DsqoHJTJRSBXR9qpC1rekWhpo7Ur2fE8B0E67ZHJsDWTrmzFSCjofxFk5W1u4zaPYucaA+sk0nPnWjYg2EkpLAcp8KM9ugTieLn3ZEAT0tJC1Fv7TbrIDqGvFcjoH9ERcEN6+2ZmkACWfo36mkQL8kUKUkGo4ev9TKKA7gq0TwBIZvc64jZe/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=165J/0jl3YniOXsSGugeLHpDY9z5jKXw9zLnBFsDvys=;
 b=Q4FotHxSQAj+0WyqGqBou+zLC3uVczELIcdQfwDo7LYv8lBsIaIfx/DbcKNSbRbqAqql3Xt5FvPMcRugL5eS2tUd6RtTZYzAe9QMmbQBBRIyRRygVzfiNWy4PMKuGzjOnNgfld+u/h42zTPlBTPnmpMFFQqf/u2wp3ynevZQI5c=
Received: from BN9PR03CA0590.namprd03.prod.outlook.com (2603:10b6:408:10d::25)
 by DM4PR12MB7696.namprd12.prod.outlook.com (2603:10b6:8:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Tue, 18 Oct
 2022 13:25:00 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::f4) by BN9PR03CA0590.outlook.office365.com
 (2603:10b6:408:10d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32 via Frontend
 Transport; Tue, 18 Oct 2022 13:25:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 13:25:00 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 08:24:31 -0500
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
Subject: [PATCH v2 10/12] cxl: Do not ignore PCI config read errors in match_add_dports()
Date:   Tue, 18 Oct 2022 15:23:38 +0200
Message-ID: <20221018132341.76259-11-rrichter@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221018132341.76259-1-rrichter@amd.com>
References: <20221018132341.76259-1-rrichter@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT028:EE_|DM4PR12MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a992286-763e-4550-d5a8-08dab10c2887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h1Lbfk/ShqNgnXB3bi5ZoTgpkClfgdf0DJt/h3M/RWecx7h1t7vhr4GGiDYVwUEeA+nVT6PBOgWxPqd7k1C0S2DsNSmvpIvdAsOWfhK8dYi08UcNH5LrYtGx0Acs0yI4H41lSzXbsz5qwHpVBMz53BYHvgtpvEFGm0+SqGE34gkSGEMR4WThl7Msj0EP2fm48srlvM9vwpJbHLJ4t7qKxZoj8Fki6u9QquAkUwVZGu655qJfAgf/AmSfVxFxuBZSOcF1CT4F0r2tB+vuo0r1OGGRp4C9j3EsMoKpHMlHBgC2PvYKqv/jsLvWzs28DbbOiw/zHshsJzbQqqVC/TJh0mLEpwCUFiTKU/m/Cpe8ftvoAvk/l76/Zn7fY/YtAPqVdEeBZ/dukaNeDVSGU0nVD+5Dt1d7PrE/zOYibtwPjlHBHjXXLR5sEXEuQSSKpw7gNsjFeXa0tim6GQ+iHSFP7cfTh1nDxpVqOz1C12Bu5dIzy5zu2qTigy5Z5m/fNa/kBYLuQV97+hoYXp8BQvcJCjz0fIdT1EL6Lt0i2fTPyBPb3t6w4BUWIQVVRp02HKIUbt2WSs7fp9Ls/tLO17nGiPYItHDatxPCLUS95L/OCCdOarJyiTYPrleDVbyORHMXclUQxO+8rAF7vZ1UippOZ2ZbEAIvUFjagPpmTz8DrQMwNxTjZF7fJhtEfG8AloqVHWtekfln2GklKqkfBZyVhuiwLpTFnpx7Yh85+M6VTovlHEQkCOu+6jH4dE+Yx/9hjHsbmmvPTUou+TWwZzDfmQqchUMj9FSQnM6n/8ofhtI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199015)(40470700004)(46966006)(36840700001)(478600001)(41300700001)(8936002)(4326008)(316002)(110136005)(54906003)(8676002)(36756003)(36860700001)(81166007)(356005)(40480700001)(40460700003)(186003)(82740400003)(2616005)(336012)(1076003)(16526019)(82310400005)(26005)(70206006)(83380400001)(47076005)(426003)(2906002)(70586007)(5660300002)(7416002)(4744005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 13:25:00.3592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a992286-763e-4550-d5a8-08dab10c2887
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7696
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The link capabilities of a PCI device are read when enumerating its
dports. This is done by reading the PCI config space. If that fails
port enumeration ignores that error. However, reading the PCI config
space should reliably work.

To reduce some complexity to the code flow when factoring out parts of
the code in match_add_dports() for later reuse, change this to throw
an error.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 0dbbe8d39b07..8271b8abde7a 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -47,7 +47,7 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
 		return 0;
 	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
 				  &lnkcap))
-		return 0;
+		return -ENXIO;
 
 	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
 	if (rc)
-- 
2.30.2

