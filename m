Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98ACA744512
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 01:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjF3XR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 19:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjF3XRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 19:17:18 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5693D422F;
        Fri, 30 Jun 2023 16:17:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1AJ/+C1mVEsgb3FkNL+tvtX08DJL9HiebJVHNgKAXL4jUb92JB59aoyL6qTi3iw83VLzmh0zSYTM9DgQBLDUjHD9TuuVUgd4s/KDAq9sZjknxhoSCSmYQ6kpeAydq1tljPHRpPt/wvX/C8S7wygIslTvKcitDmmaU80O3WbQ3zygVeYOwKQ3E4AyfjqtY473a7QJebxig7ry/Wusqp38Bm6yz2utXkQXoJ59H5G50yWIz1pzHXaGYtITf85mJkNktMDPgk2kmUtfm3fyIW5fG/sBmYRB/bJ5i/EtNXzDk9WLN0zN8cNXSHhgP7er8hFBe2oeq2WYuCfMefcJxuqAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56RYeX9FEUbjjvfF0XQyGJKCuOAJ9jsg5sVDPyKjJzg=;
 b=CIqPASpK7IfzCkIyJj32pVZctTgpHlKUyD/A7MUS4bGWsbvRE8ZH0t2azb7OwICj4WuMBP2Lhq+YKXUw8twhAt6Pz2GprynfPIVsprMEfS4UnTyrFA6DyLlFskhQOZscaEd4DCuwjtXH0zQ08ouspevM9xdwudVbNpxI2ABSMf8YSt3aDcm4tWFOQGZpVpBxrVpSQSnwewr2etY+99e13oCyV/oGElTOtB6NUfXjIMnxtbK4OjZ3npzqpf3sdOs7dxgUQ6Rk5lSDj6HW3olxmBN6+eE74ayUG5RUHXjeLER2NPpFgEZxrzSCF/NovF5gM5xtNgkduGEo/e4QZkP7HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56RYeX9FEUbjjvfF0XQyGJKCuOAJ9jsg5sVDPyKjJzg=;
 b=fgBzLyZsXmXDpThqwjET2mXMo+1FbzQg9lN4EChXFiJlPOF40JJCUSOkxrTgU7YrTxf0E/hOjCSdnVQ7QVhBHxKC9B93HFPRjefiWnCghlD+rtY1yr72RtaYXcdXDkhVxuI1qgj5JzSypuR4l/f0XDtQ6/jgTWgQeNmxZKT6ZT8=
Received: from DM6PR13CA0033.namprd13.prod.outlook.com (2603:10b6:5:bc::46) by
 IA1PR12MB8190.namprd12.prod.outlook.com (2603:10b6:208:3f2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.19; Fri, 30 Jun 2023 23:17:03 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::c2) by DM6PR13CA0033.outlook.office365.com
 (2603:10b6:5:bc::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.10 via Frontend
 Transport; Fri, 30 Jun 2023 23:17:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.51 via Frontend Transport; Fri, 30 Jun 2023 23:17:03 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 18:17:00 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v8 01/14] cxl/port: Pre-initialize component register mappings
Date:   Fri, 30 Jun 2023 18:16:22 -0500
Message-ID: <20230630231635.3132638-2-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630231635.3132638-1-terry.bowman@amd.com>
References: <20230630231635.3132638-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT062:EE_|IA1PR12MB8190:EE_
X-MS-Office365-Filtering-Correlation-Id: d713157a-8582-4dd4-9776-08db79c01d69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kwx+VgRhXAoBO3ywflOLdF8QKtLwLa9Sx8RGmUmiOis4xTKNBuGEjxgs/WfWWHETsb5xRYQyCudBhzZZeX7wxl/QAZdbBmuDE4Cez1lMv+Ym7oQ3FAqnl1InEqLVlWJvPSCIFSi+TI/Vq+BNav9ofnI0OwAFk1w8fZWiWvmcAu84uwU+hvPpaKeAgfsdmlzPZTXZeLQZEpyuC+ArvqvypRyFCTPTuMWaZvNLZfbfRnzgArPiQi1fMXcYP1hg9QXaaMHqsJa8iTdHKWBz8K5scX2GZR3CY/JT069ZdImAjbPFX2OkBiyw0++/T3/ukXyONmE8/0ehCilpxvW/H+IbgGi/LYJfgh1wpV3jte7am6d9Sl8QOUYYuX7roKOlQZEBicchGJVERXBx2FVxSeuUuH4XBKGf+U+oC47dEn3e0HarmOlm12ciRJNUQ4KPsS8nc7ywn6iH0Lf5OTv8d/yx/QlF6DoTTPyGsT1FRxBW8c0ahGUtQvCvRKQUnL6WY40KOn6+45cyKeICcudcgBb83wny6gE4G+FKAQQZZMZpmqR122ox6iwI+z6soU3etYAMF/3I8f565ifF7TwPy7dJ+fYRK4TL6X3UNx/9BxUhpfy5S62w5xb7UvsvG4VVDvaUtToKQLIPhNYziAAAkpxyimN70fp987/0joYceppmqTct8JaEvglyRXnMs/0Gqe7AwvwjY7QQV+gNB+S3Js22UEZU5zr1Elm8H54tyl+dPCeEzkjbc/BHMhOUaZT6PGk+oNuSlt05xgaJJer6E35KUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(86362001)(54906003)(8936002)(8676002)(5660300002)(82310400005)(110136005)(7416002)(26005)(1076003)(44832011)(7696005)(478600001)(4326008)(70206006)(70586007)(41300700001)(316002)(6666004)(16526019)(186003)(2616005)(2906002)(47076005)(40460700003)(83380400001)(336012)(426003)(36860700001)(40480700001)(36756003)(82740400003)(356005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 23:17:03.6416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d713157a-8582-4dd4-9776-08db79c01d69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8190
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

From: Robert Richter <rrichter@amd.com>

The component registers of a component may not exist or are not
needed. The setup may fail for that reason. In some cases the
initialization should continue anyway. Thus, always initialize struct
cxl_register_map with valid values. In case of errors, zero it, set a
value for @dev and make @resource a the valid value using
CXL_RESOURCE_NONE.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/port.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 724be8448eb4..2d22e7a5629b 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -693,16 +693,17 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
 static int cxl_setup_comp_regs(struct device *dev, struct cxl_register_map *map,
 			       resource_size_t component_reg_phys)
 {
-	if (component_reg_phys == CXL_RESOURCE_NONE)
-		return 0;
-
 	*map = (struct cxl_register_map) {
 		.dev = dev,
-		.reg_type = CXL_REGLOC_RBI_COMPONENT,
 		.resource = component_reg_phys,
-		.max_size = CXL_COMPONENT_REG_BLOCK_SIZE,
 	};
 
+	if (component_reg_phys == CXL_RESOURCE_NONE)
+		return 0;
+
+	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
+	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
+
 	return cxl_setup_regs(map);
 }
 
-- 
2.34.1

