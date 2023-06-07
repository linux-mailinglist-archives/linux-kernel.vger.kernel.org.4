Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DA1727173
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 00:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjFGWUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 18:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbjFGWTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 18:19:54 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CA9269A;
        Wed,  7 Jun 2023 15:19:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LhZbekVgqqmRangE4QAs4BuM4IykIALPeFY10O5g5DyZ9It+f4f5kLPeLtNWJiC6yWQtKwTOMSogWPjkF/dbc0VfYpSwEznjAZdJtYDTKxrDURlG+rbSeFSfQoKcRk+cvOgGSxXp88qh/wJxahQ2FgZ6oOnxA2DAPMQ0Y6lOese3hM6vJIoG4cx8rhNfQ+uMKd9MU34zydEvyt9YriIxtKz72Cu5+CCBQBm8cAjWRKqBDBJ2mFcOkZS638O5RRu2kMHhxsCuZgXTM5+bOzjWHTIyNVUorHuBd2M1d1mIuulW4e2I48jsClfVYCggPthAkn6G50r1kJf4LYV+WZ8ckA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLkOgtVLjx8oHQYJrLt14iPuRvcQoHcy7cSOqN0hnoA=;
 b=ZC/zLdQ/qovyTL+QRIWo54+2KWyofnhEzKS8GN4I8Tyjgy4Q/qolHFyPZTfQ66O1eHpzQIU30X6aM7SloMfgSl/So89KA/+iiVAgE5bd6TKck5D98ilf9F4D5fhCfREP6c3nMSBTvO06pbDYnngef+FpkfbJU6DtiEXIupZiwFkuI9cwpLFPSA5p0c6PAaoTNKRioHGOYuB8xWD8AhtAL9giXkkkVPUDkTUHRVUKjZQzjEsNKY93jVnPgCH9JpZlcpmjACh6z2rYCfkBY5J64Eo7jpyAp11rhrEUGD9W42dKAXYET+ntmvGB2gKkNloY8keVkp9s69HeGOFRLFc7Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLkOgtVLjx8oHQYJrLt14iPuRvcQoHcy7cSOqN0hnoA=;
 b=yb8yLO4ZgsLMT+MLSNMRbEBc6xlDMaZiKxdoEfMtrJ/sJC/UnkGB2ptGyeHtQARvdv0C7bIoF/B2k3Rh1wQm8lGuW2XehCRkUBFBDJbl2nN9DYVcII7SfaSMz6dAdlU15BsvKu0saT0D4AGIOaGe+QZezpXPE96qbsa1o+utnTs=
Received: from SN4PR0501CA0097.namprd05.prod.outlook.com
 (2603:10b6:803:42::14) by LV2PR12MB5895.namprd12.prod.outlook.com
 (2603:10b6:408:173::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Wed, 7 Jun
 2023 22:18:56 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com (2603:10b6:803:42::4)
 by SN4PR0501CA0097.outlook.office365.com (2603:10b6:803:42::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 22:18:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 22:18:56 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 17:18:55 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v5 10/26] cxl/mem: Prepare for early RCH dport component register setup
Date:   Wed, 7 Jun 2023 17:16:35 -0500
Message-ID: <20230607221651.2454764-11-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607221651.2454764-1-terry.bowman@amd.com>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|LV2PR12MB5895:EE_
X-MS-Office365-Filtering-Correlation-Id: 2655bd4c-4ee4-477b-b336-08db67a52f59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 74VWK9tqw56iT8TYJFWoZPkNspSimgGTf3Nq97UbQpA8MYRd4t42iqKA9kCCR0KXrWHO+CdTuTRLkip3O/YYRiUqQVO+e/eAawwGUsP2cflVF0XEv6dbOiWx7A/inXvlPHIYnmsHkn3OMLYSPI7XcBmroFQCVGCb249HMg1R5Na0DTogKYDAzgHjHSzpxjEdCWlGLth/i3KYvkNObLonP0E9wSTikGzskj2GLLGCJmuV02FbXMjbbxP0JPVv51AsWU82qmK2WtJVlcVk1ddy+41gfrHoRnBhxLwDU0Yl7JAnMW8dEepzjI+O9fhpqRGUZIuCmbeXa+N7AZgjqgdMgQ9gkww4e8OaIWvRoKBjfXYPXZ4VuXocLlW5E15ZnzJvdOTB0R2bMhTw+18AwACkd7JtpWV6sIHYfRwB2Ml3AcEpY0m+Zxom09d3yWJX74EFXqmQ+NyCZ+JF2AJ1/Ae1UFx/OdOQ3AC1PDgi1lwOtMppty5iRWe03e4SnKxGeW6/RkQP4f4ZhRv7pYbU22ZSvNyZpswoSPrR4uHfs6gNt/4iOpT8GXWYOoo7FvuP9MryzJAB8K/kqhVk+GQbUwwm9qOFEnXoVfAe7n2XQmGdV57DfWCmyJZhmobLcNbBOCgnuyA/nLfgnZfhka4vu7ZshOOHtAGuVye689Tkxp68sZapqZFPDil4A4diOEc+2Jv5xPOoIdZ44tSyTGx6CoHQqMqms7qzRXYgsHWb4UH98UH68hbtVAmzFWwv5MN+iQL9D7YS3oxlyWq/Id6zNtwy4A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199021)(36840700001)(40470700004)(46966006)(2616005)(8936002)(8676002)(16526019)(186003)(41300700001)(2906002)(5660300002)(44832011)(26005)(47076005)(1076003)(336012)(83380400001)(7416002)(426003)(7696005)(40480700001)(36860700001)(40460700003)(478600001)(316002)(110136005)(54906003)(6666004)(356005)(70206006)(81166007)(82740400003)(82310400005)(86362001)(70586007)(36756003)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 22:18:56.4104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2655bd4c-4ee4-477b-b336-08db67a52f59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5895
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

In order to move the RCH dport component register setup to cxl_pci the
base address must be stored in CXL device state (cxlds) for both
modes, RCH and VH. Store it in cxlds->component_reg_phys and use it
for endpoint creation.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/mem.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 43ecd150bdc7..a34d6560c25c 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -51,7 +51,6 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 	struct cxl_port *parent_port = parent_dport->port;
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_port *endpoint, *iter, *down;
-	resource_size_t component_reg_phys;
 	int rc;
 
 	/*
@@ -72,12 +71,12 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 	 * typical register locator mechanism.
 	 */
 	if (parent_dport->rch && cxlds->component_reg_phys == CXL_RESOURCE_NONE)
-		component_reg_phys =
+		cxlds->component_reg_phys =
 			cxl_probe_rcrb(&cxlmd->dev, parent_dport->rcrb.base,
 				       NULL, CXL_RCRB_UPSTREAM);
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

