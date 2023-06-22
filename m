Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FDF73A9B6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 22:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjFVU6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 16:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjFVU6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 16:58:33 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B68269F;
        Thu, 22 Jun 2023 13:57:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5ZFRwnZqZuE8YSzhFmST/l2ga5nlP42AWY9UKkxfkFAlYODQ80IApU41UPuPjevOtjLVvDloQReL8lLWt9oI0zUb5A9wobx0qVzcVKtr0apmoJ/1xtkrTEJfMOPi/+xu4nwHdX8L5G6TScWA6OuFSdUtsoWg/iHwTjdIqaojq1ktIN4aCDqaFEBSd/QPGVQPyfw12o4NV4tskfuEZSqsVnsNFUecEkSk+B2UrUuL+tvBZSJihah4tVzJaRvFgpx8e0L0cb/r8ItsKemdo0ALOQrnZmQVxH70vjlMHroMHt0P4RaRnxSOoX4tCYvdrJlEb3Qns2z2vFjLD9/6x5kDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IqJ+mOd5KPwVI76S2Q/gRsUbFq6Y6yh5uPvLB4Nqb4=;
 b=dHTFNSS0YCFedfhsrUBITbHOaqqw/4dfZXyb51Axfixin+kyD8gcaGLInODYJx34e5lItS/u5lWRPM+XNO5/epIQrztuBncTeIlenOmzdUXJPcoKavzcijJxiM9Z5YUGnX7UlqFf9udH8bRj3Sw8trKiVUSorJS29fA3p7PbGodZbPOKrR+q8kdwdWGtI1ZP+5isOg+5pY0pcjAEMvKasutS/fzDHDLDR89wUoJM3MQfHRQxmAwS+RPVrO3lFmkj1vFkQ8H/JIAkxzHgfZsA8nQ6HcjXt4Q9WRSoUhYI5QTG/mEi8LiZ/1qkhaAh7gAPVELgI/pqsElUbv88BqAIzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IqJ+mOd5KPwVI76S2Q/gRsUbFq6Y6yh5uPvLB4Nqb4=;
 b=LPrgvkN5Q6o7HlCcpacXY8ZQLK/rIZ/gWgdJc9NT6sENu+JM5uYRNfORdKfed+ScoMtrju7PJeiifmwTbXG+J0kaMcw2FP/z4DqsWxqVu7ngakMVw/1mMPruyS1khVFMBbjTDu9GSvBgC0qMolxb6dg/7MlJZMpe206seryulz4=
Received: from DS7PR03CA0022.namprd03.prod.outlook.com (2603:10b6:5:3b8::27)
 by IA1PR12MB7686.namprd12.prod.outlook.com (2603:10b6:208:422::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 20:57:35 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:5:3b8:cafe::ba) by DS7PR03CA0022.outlook.office365.com
 (2603:10b6:5:3b8::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 20:57:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 20:57:34 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 15:57:33 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v7 11/27] cxl/regs: Remove early capability checks in Component Register setup
Date:   Thu, 22 Jun 2023 15:55:07 -0500
Message-ID: <20230622205523.85375-12-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230622205523.85375-1-terry.bowman@amd.com>
References: <20230622205523.85375-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|IA1PR12MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b1d56f6-03c6-447c-f421-08db73634dd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y6JExo3EMnfpZgw8Bj4zGAdhQrLDV35oA0B6dIANE5ZQALbvUFnoJEJKGaCsS0fmV1xy56XzHFjMeZVdg0KAT265pmr35iR9GmL3+uUCiWTPvWCtd8cEQOygRDZdETnBj+Df50X5QOmmKebWq0kn01jFTH4hF/3etD7NdSoUnX2HT5GJECm7m89hoajqELWP9wvmIRfaZEyYDNLzdW41yUIxiK4k93dlcMDL03phl9Ptq9TqJeSo6Yzc6jp3qE6RbpD8dDoaO6og9e9c8Cw5+/oI5y0zniyxWWRrB5yM9LA8HNNt3DpoAmgo//4GiFggsSvkh/meTQzyv6/86cCXHGXukAxVNbNqK/MXQB3X901Dm2BBWLvfqXq2/PLpdJg6dY7eAJhObF7z+I39RhQY6CBQ7xqijjPtazHUm+ZhqxFFG9Nlfn6bYB1icQk/Mz38HCVZWXZ0RPnJ7x56KuRCIU8pfqw+KkHnJOAimPThCKlv6VneXXEFfb+zm27r7jVuGDnFvxZtOY6T/EsjTG4zk2S9NHeyL9pJAUHlhMw3XVZtoe68XpRLoXngwA/JafkbWoSrr8/Zlo9QhhYqDbA3m8GaHHNAF3GsXoOhfxrFDnI+Bs4VEtHpBXZMaZ8vqxCCNbgUGR7g+CGQuSlnHQerKvtY48CzYErZhJje/6AEK3SE+oaUBohiVehVXkiUpOXe8kHte9DMAy/1QrbtSGC2EojH+2UZb2xyhRTXgqnIvrmLA8+dONr4dw7Uw8FqpZj9vEWmGM4/YESCO7LlC/zlbg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199021)(40470700004)(36840700001)(46966006)(426003)(336012)(2616005)(47076005)(36860700001)(26005)(1076003)(186003)(83380400001)(16526019)(82740400003)(356005)(81166007)(478600001)(54906003)(7696005)(86362001)(110136005)(36756003)(6666004)(70586007)(70206006)(40480700001)(8676002)(7416002)(8936002)(4326008)(316002)(2906002)(41300700001)(44832011)(5660300002)(40460700003)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 20:57:34.6721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b1d56f6-03c6-447c-f421-08db73634dd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7686
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Richter <rrichter@amd.com>

When probing the Component Registers in function cxl_probe_regs()
there are also checks for the existence of the HDM and RAS
capabilities. The checks may fail for components that do not implement
the HDM capability causing the Component Registers setup to fail too.

Remove the checks for a generalized use of cxl_probe_regs() and check
them directly before mapping the RAS or HDM capabilities. This allows
it to setup other Component Registers esp. of an RCH Downstream Port,
which will be implemented in a follow-on patch.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/regs.c | 8 --------
 drivers/cxl/pci.c       | 2 ++
 drivers/cxl/port.c      | 5 ++++-
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index e035ad8827a4..e68848075bb6 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -369,14 +369,6 @@ static int cxl_probe_regs(struct cxl_register_map *map)
 	case CXL_REGLOC_RBI_COMPONENT:
 		comp_map = &map->component_map;
 		cxl_probe_component_regs(dev, base, comp_map);
-		if (!comp_map->hdm_decoder.valid) {
-			dev_err(dev, "HDM decoder registers not found\n");
-			return -ENXIO;
-		}
-
-		if (!comp_map->ras.valid)
-			dev_dbg(dev, "RAS registers not found\n");
-
 		dev_dbg(dev, "Set up component registers\n");
 		break;
 	case CXL_REGLOC_RBI_MEMDEV:
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index ac17bc0430dc..945ca0304d68 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -630,6 +630,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
 	if (rc)
 		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
+	else if (!map.component_map.ras.valid)
+		dev_dbg(&pdev->dev, "RAS registers not found\n");
 
 	cxlds->component_reg_phys = map.resource;
 
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 4cef2bf45ad2..01e84ea54f56 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -102,8 +102,11 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 		return rc;
 
 	cxlhdm = devm_cxl_setup_hdm(port, &info);
-	if (IS_ERR(cxlhdm))
+	if (IS_ERR(cxlhdm)) {
+		if (PTR_ERR(cxlhdm) == -ENODEV)
+			dev_err(&port->dev, "HDM decoder registers not found\n");
 		return PTR_ERR(cxlhdm);
+	}
 
 	/* Cache the data early to ensure is_visible() works */
 	read_cdat_data(port);
-- 
2.34.1

