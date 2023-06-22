Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A937773A9FD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 22:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjFVU7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 16:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjFVU7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 16:59:01 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CD2273F;
        Thu, 22 Jun 2023 13:58:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5llo0auFnhR0UQBmUAN/f33nA+/ZGlJf4BuG+IeCKZoRAlPmX/KFAFkaqVyXtjBojMrTPgKU1JTXBWZ8ac/RFzm2vivtgcbqGliYr81XCjK3ur7sWojleE1dAKkBWi8ehgvETyOLeDhAmN6H7R6bNOE03yBskvtpwEl15DTf6cDqS6gJS1H6n23gWTfBoWJg7JpEcL8JVfiBJl4BFIJF7lOdB80yP/Y0MzpNgip9O0sNc1kTVMkT9I5+Rm+5qY1IsTTHQUVwsLPtbQvA5TzIQXyyhPv+fVbsSTP1uwePGyyEbZfqZEWJ3x4gIYU5iVyPjhsVeKrXLRAyWNBRig9ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVQWi9UR51h7neunjftW5Jdr4fM3EkYOpUJJidl7hYw=;
 b=gy7P6fH6qHNU4cvmP9G1lT7hyJaJEsJ0yteDDUqMcnZH+fLCIJsA13+gVqEqOB/GS++zKmgcYhnMzYf8k+Q4yaVpgJJw8lyzpjEEpcJpdaB6e3y5OVtXfUCDRvzsCUhXXCpQZDeKXcm80uxhvVj+BcPlZpU6AUa4gqOAJNrXh+RIbFT5e3R5rEnb8/crZ0qZgDjbA83tIJRg+kDE6UDEqqN75/4qoSLRAwEsv4M0ARiPqxHZhpCo6GQADsQbp6fsKLBm0jMsvugKBGCY/StP9k96w6I3gd0Mce3PwuOeL6VDfYgfDiXmsxLXoLchG8sZX0e7xifKGNDEAULm4f/Z1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVQWi9UR51h7neunjftW5Jdr4fM3EkYOpUJJidl7hYw=;
 b=vxN8oFdWQ9hDn/AS0d6zZg7XWWggGTfje8F4DxvuEEODixO6FlwaM/Ohe5MNbXgXgoCWlH7owbAlHwjIpgHjni0S9UlCP8WSBB/xxlWELbi/u6/iPCXGzIF4ERxOzURm/98GvlF5UjPEnfRdCwnAq/SwxuqnLdIIz72S7XnFFko=
Received: from DS7PR03CA0003.namprd03.prod.outlook.com (2603:10b6:5:3b8::8) by
 SN7PR12MB7786.namprd12.prod.outlook.com (2603:10b6:806:349::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 20:57:45 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:5:3b8:cafe::16) by DS7PR03CA0003.outlook.office365.com
 (2603:10b6:5:3b8::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 20:57:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 20:57:45 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 15:57:44 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v7 12/27] cxl/mem: Prepare for early RCH dport component register setup
Date:   Thu, 22 Jun 2023 15:55:08 -0500
Message-ID: <20230622205523.85375-13-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|SN7PR12MB7786:EE_
X-MS-Office365-Filtering-Correlation-Id: 4829c2e1-4b87-46c3-83c3-08db73635419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wKegTKZaoEHF1DjIR/kADpfavsG8hLgecaiaHOooGSDPbhYGHBxOdRvhtiv0ilR6JWO2yLzB2wOA9lMQmNGgT4ItjHdlAqX0lRoxi+WlOFldrTNoTVC8ZQX9jK/Mm5gpGaBG5CZJie9kMwg3MAu1P4/GPliXZLLGi1Kh7YcwsXcUR72+M46dvl7rYYs0pc6ZfCeORCp6vhh16OpBj2JablC8PaAqa8Ya1R6rJhgTLumMr0DIwVtOIcWARto131Voehi5MXQRTHgvsdMIvB11XoUpo7yl01mMcAcH1i8Fl/XdCBaUieQvJWmFPHu9A/EbxbzhhAJXCslME8Jd/1feNWmy+6qHF72TLT44HKfTWXr7LO8o24LYJigeXU+lJ/0/4clfrcYaxvmFQ3qY+1MwD4yQwEVdeTNEpkcqXJQDBXrj3XcOoLDAQIUPoZf4yhQ9XaT+hH+ja57I0UApDM5optCMb7i848XkWKcMErj8T0GGnDB7TNOolmkvv7EFDUabn5Y4hnlzLiR3XfhhwI6uwKvD5vGf3/0prkaP88lUo385i+5wMjJVbpHTo16pRoBBwwiUSIgw5dOVdU6dwaJHVoUbmaROGPpVyitifICi6WEsR0tmPvUe9joB/j3OkZZjcB/bXQV4is6uJklVFFKDPD2VTz8/RxTzrcDoY/je8FdysoQZ6C5ql1BTv7jHiZLwsfJsx2nGlgnpDvMzCnkSN2DzMAC4wjLAPoTYaXKwl2klR9Yar5la8iMcOycD+cK1GQdwB6fFqA5YPOA21VHmWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199021)(40470700004)(46966006)(36840700001)(41300700001)(8676002)(70206006)(4326008)(70586007)(316002)(1076003)(186003)(8936002)(16526019)(26005)(2616005)(40460700003)(54906003)(110136005)(6666004)(7696005)(478600001)(82310400005)(2906002)(7416002)(44832011)(5660300002)(40480700001)(81166007)(356005)(82740400003)(36756003)(86362001)(83380400001)(336012)(426003)(47076005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 20:57:45.2034
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4829c2e1-4b87-46c3-83c3-08db73635419
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7786
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

In order to move the RCH dport component register setup to cxl_pci the
base address must be stored in CXL device state (cxlds) for both
modes, RCH and VH. Store it in cxlds->component_reg_phys and use it
for endpoint creation.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/mem.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 4cc461c22b8b..7638a7f8f333 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -51,7 +51,6 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 	struct cxl_port *parent_port = parent_dport->port;
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_port *endpoint, *iter, *down;
-	resource_size_t component_reg_phys;
 	int rc;
 
 	/*
@@ -72,11 +71,11 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 	 * typical register locator mechanism.
 	 */
 	if (parent_dport->rch && cxlds->component_reg_phys == CXL_RESOURCE_NONE)
-		component_reg_phys =
+		cxlds->component_reg_phys =
 			cxl_rcd_component_reg_phys(&cxlmd->dev, parent_dport);
-	else
-		component_reg_phys = cxlds->component_reg_phys;
-	endpoint = devm_cxl_add_port(host, &cxlmd->dev, component_reg_phys,
+
+	endpoint = devm_cxl_add_port(host, &cxlmd->dev,
+				     cxlds->component_reg_phys,
 				     parent_dport);
 	if (IS_ERR(endpoint))
 		return PTR_ERR(endpoint);
-- 
2.34.1

