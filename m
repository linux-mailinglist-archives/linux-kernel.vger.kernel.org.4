Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEC56228B6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiKIKls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiKIKlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:41:37 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE40822BD8;
        Wed,  9 Nov 2022 02:41:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJTEcmIM8Clu+YV4zjzekBpYqoWF0kUvAB7GTRuE8YShl5ZKDeOrEpmZE2p5sRO/5AsVFeX5YxnX17Oa0+rSNqYNfZXW5iZV2J5HdSgCzslRNtEt4cHnQTHqwwhWqcDTEvTKcuDEfbpsvJRmlhTRBk8/x9Fn56ERPAio6vV5Bz+kKCFs9bBCKtCGVe5uYOZTLBVkNX7DvqVridrDhlsmHtf1tgbPWIGux8NHOIPUUXJJNSTyBisojlEh6z+mfAETXM7VRcY+dfbOERZLFdGpumYaTbyfcMGQ6HqoqQq9wbIysXfVsFQ2MMMqEq9jyo+3Fner2ZBqpTrPEpffqJyiKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73NwBsh+4VgARIZnefxl1VUD3O8ZaMkAlO+5ST6uapw=;
 b=UQ58EmE7yXELtA5l31/qGJOeEy7qSXpAR50onXICE/lyAa5Lfw5h8gDlEIb+BfQV1xtNROSLqqL5yyynT2DOYanGF82m5hbaX5DElx+SzcECAs+rK4AHCFnr9cIOvgLRvRBKwqAAP9+QhW8Zw4671IExwbDHngAnjwgdO/zBIwhwajQEcI1Fithpzgknnkc7V/HnUG26PoY8xt62T3vyepPP2jjeGrFO1+JmhNyxaRQo842YIizkB5EZ5REbG2KrIeb6A9Q5y32ZKQLlqePMVhn7ekgNDb6iDKZ28YYD1hooWAsDTJ3iGzfDTuR/5q8oP1O/RS5pP/AnmAwh9eAMKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73NwBsh+4VgARIZnefxl1VUD3O8ZaMkAlO+5ST6uapw=;
 b=pk4QiuI2MfaNBSCzScbbEN+AlWU3klOcUqE7abOndZMB+M334xDdYQc+MzQEReM7vQ54ZPjpT71aGkp35xY0wfFBXVQISvrKJK9xtcQjniF5ON5yw1CUDtJkcUYlc5elSlFFmalQkNUjSxhkb7hK+Hh8lPubzSlPUwIwpW2ajOQ=
Received: from BN0PR04CA0079.namprd04.prod.outlook.com (2603:10b6:408:ea::24)
 by DM6PR12MB4217.namprd12.prod.outlook.com (2603:10b6:5:219::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Wed, 9 Nov
 2022 10:41:32 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::c8) by BN0PR04CA0079.outlook.office365.com
 (2603:10b6:408:ea::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 10:41:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 10:41:32 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 04:41:29 -0600
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
        Dave Jiang <dave.jiang@intel.com>,
        Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 4/9] cxl/mem: Skip intermediate port enumeration of restricted endpoints (RCDs)
Date:   Wed, 9 Nov 2022 11:40:54 +0100
Message-ID: <20221109104059.766720-5-rrichter@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221109104059.766720-1-rrichter@amd.com>
References: <20221109104059.766720-1-rrichter@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT031:EE_|DM6PR12MB4217:EE_
X-MS-Office365-Filtering-Correlation-Id: f02be110-c5fe-4432-c41d-08dac23ef78e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FfGGGblVlpaC5xC8B9kIIV8/QMzZl+3QX7kfyHCVzq2jfPK/1Box8j9P5o8fWKVp2j8AOjHt6Hncug/CvrStzfO8LbX2jk4Y26/neDhFO+AEkfqMioWAL5XGBIPU059vh/Mwfr0bKRmcD1sox/VNXv8AJfFxet8DJbXfhGKJSvDmML1NIC7iw25QLbnmuKdAYz6I2nHuCa2g/oSdeqBmz8K/Xt7n/5aAemorkz/tt6MFoC5AFfr64EvzM+CDUUJLkb3Zbk/b/CBOVBwKhoneMZKhoPNgZf4Wz49xFGs1tXgJ5zODV/dC2Ajx+rhC5c9aX8Jk7o6oV6yzjYIbXmsYzhTmcrn2BI1X1BtCuJN1xnW4G7LweQbCc53GvhQdEX9lX+UNlm0uiraQAgwPSkrcnqjPPm2nxwcmEC7CRFnU62y6lNH1LSUKBHudgz3g+L6HLMWEbbovciq6PGPVRefKHjNTcrpIJ3xSv0SfBaWJ2OFdwDhO7UhlRMmmP9Wq8WWIluRAv1LZk+ldDUjguMGpwTQSTRhSVcWxYDJWvOFWBGkvdCG87AG4jSFjUxawIKDsOAN/aHkiocwb5+Z6uV8dP/lbE/qCyT8cQfCPVPXPl/u6mKb0fgdghpVNXgpJgNTdq6BDza+kJNC0MLOaYC25Kkl4VTZ5lLx6VkZwgbTqhlQrMoG2PQmAEq1yHfL+AQ9YgHoo7tNfNk3Vnex2BfOUy9OcqTi8sT8iVQCEv3xhqCORpUY/ARupMPo1VH+12c4WklNv2yh1vXN0RKsKRQIdaaABgmMJW3EgMIGr6+2fKiS5D+SyEQeJ/vLnAFkhTs9U
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199015)(46966006)(40470700004)(36840700001)(82310400005)(478600001)(356005)(6666004)(81166007)(54906003)(110136005)(316002)(26005)(426003)(47076005)(40480700001)(70206006)(70586007)(4326008)(82740400003)(8676002)(7416002)(41300700001)(5660300002)(8936002)(36756003)(2616005)(186003)(1076003)(16526019)(40460700003)(83380400001)(2906002)(36860700001)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 10:41:32.2967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f02be110-c5fe-4432-c41d-08dac23ef78e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4217
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an endpoint is found, all ports in beetween the endpoint and the
CXL host bridge need to be created. In the RCH case there are no ports
in between a host bridge and the endpoint. Skip the enumeration of
intermediate ports.

The port enumeration does not only create all ports, it also
initializes the endpoint chain by adding the endpoint to every
downstream port up to the root bridge. This must be done also in RCD
mode, but is much more simple as the endpoint only needs to be added
to the host bridge's dport.

Note: For endpoint removal the cxl_detach_ep() is not needed as it is
released in cxl_port_release().

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/port.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index d10c3580719b..e21a9c3fe4da 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1366,8 +1366,24 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 {
 	struct device *dev = &cxlmd->dev;
 	struct device *iter;
+	struct cxl_dport *dport;
+	struct cxl_port *port;
 	int rc;
 
+	/*
+	 * Skip intermediate port enumeration in the RCH case, there
+	 * are no ports in between a host bridge and an endpoint. Only
+	 * initialize the EP chain.
+	 */
+	if (is_cxl_restricted(cxlmd)) {
+		port = cxl_mem_find_port(cxlmd, &dport);
+		if (!port)
+			return -ENXIO;
+		rc = cxl_add_ep(dport, &cxlmd->dev);
+		put_device(&port->dev);
+		return rc;
+	}
+
 	rc = devm_add_action_or_reset(&cxlmd->dev, cxl_detach_ep, cxlmd);
 	if (rc)
 		return rc;
@@ -1381,8 +1397,6 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 	for (iter = dev; iter; iter = grandparent(iter)) {
 		struct device *dport_dev = grandparent(iter);
 		struct device *uport_dev;
-		struct cxl_dport *dport;
-		struct cxl_port *port;
 
 		if (!dport_dev)
 			return 0;
-- 
2.30.2

