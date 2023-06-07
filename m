Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E9F7271A4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 00:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjFGW1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 18:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjFGW1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 18:27:07 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF252733;
        Wed,  7 Jun 2023 15:26:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NI7hTkODxbHvpYdVDeYEy4rI43Zark624mY4sOK6RoZXxEU3czPdCdmpPQ9+OzdOUFd79CYZ0X2+XVX7TAoE/k3qOS94SvN6YLeZIS+z5QDalWVc5Gk94xKgAWRSLQoQOA7wTcOTxCviYHZQWJyGvS3yt0goWAFt4kV9xUK4rp0rD2yuCKeVGP2wKbdrqwnSmwFQGVOJQFNsZlPEh99dRJ2KwTn0+sRUehVb8uigwgwZpLsMt6HaY+/k1QP7zDhyWMTof+grs4nOe/DsG14u4O1BMSSBJmo/l5Uy45yJTNpwMIx+v2x9STPgyw35akDIN87+oO/vhVcnqko2886Hcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJWABMR2TSHbbc/8lvQdByOmDPNN3w9DLGRzPQ1LA58=;
 b=FkyFl//qkI/89z8Bm/kbiU35i7CqH6odiWDhONBHE4JNNNnLfpH7BIfTzB7j6dBC1Q4VN9t0aTWwOUtbO2U0AP/hf98pulA9svOi40+zywoPAomv8FqCi3uUlRyqGo2Un/ivq/CHzhJQr2iQ2WpS9f9hZ+CEYc6IhCIiERVSujjhM/rb/GWRQjKDfNIATKfrV0QxshSU+DFwaUl3ogwgZWMJJoRRDGlzx4kxgt8wd1oDex8pA5owcnXKC0dtUchqCeNsaH9pN9wvhVCqemowEv7mSI6/jZuEtZSObRahmvj9eSzEZTgxQ/zjVo6HtwAamTE0w+9PfBSugYisH0sVfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJWABMR2TSHbbc/8lvQdByOmDPNN3w9DLGRzPQ1LA58=;
 b=Eb71iniWpLa04StGi97MmFrgjHy7zAhvZT48K3otosK3NM5xybA9+SvN6QOeWpHrqMNXwxTIWvqdWfTOZ3IK5BJ3kSqyIJby/HRPbUvqG/shF76UYngSxqy2A/AULUJ0rmAAKXL9XhZIpcj55vMch8RjR8E8TKNikF9frvznb44=
Received: from DS7PR05CA0101.namprd05.prod.outlook.com (2603:10b6:8:56::21) by
 DM4PR12MB5104.namprd12.prod.outlook.com (2603:10b6:5:393::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.36; Wed, 7 Jun 2023 22:21:19 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:8:56:cafe::39) by DS7PR05CA0101.outlook.office365.com
 (2603:10b6:8:56::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 22:21:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 22:21:19 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 17:21:18 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v5 23/26] cxl/pci: Disable root port interrupts in RCH mode
Date:   Wed, 7 Jun 2023 17:16:48 -0500
Message-ID: <20230607221651.2454764-24-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|DM4PR12MB5104:EE_
X-MS-Office365-Filtering-Correlation-Id: b39cc678-86d3-4eba-a872-08db67a5846f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7HSC2lz7hMydXSKgpAR5vYK7xL1eTqJFWynbRACorQrB5hCN+QglMVoXBQ/3v/D0sG6KGR7ZqlOgjv4KDjA/o5PKDqtrnKgZvYov4zp0CtsH1OHpG4HUNzJGMFn0HyxOhstiyXZEb5mrsZ6pu29vqIP8KYytZyP+zMmuRPKc8Vnv+QOGgddOqyttjuQK+gXpHWI34AeqzvfbFGPbXTfWG7Ozou2fJeN28Xc/usTR3H7ngZFGyxdezCqq+wmN/n2Zp2hYwRYjSZ70s1JTZwhfLPBD3EKApPu9oAblEl5KdEKsIKTItOXPeFMvgakmQv5taHnSrF/jgxPdOBLkqJrevy28gJKzcf3jfjWeNWLsD5SV5HRe1rldMHP1ABs2JzgLe1sEX3jlhzee4JU856WJfqTJndmxZly2CXwOrlSC/e2hy4fqveAt5NXcsik5XWCsyd8bn8z3vg5bZmuevpQMiSVAoGZSvEzVnGwbGHl3aoHY/Eoag7u8Al371dXM5jQCbxVT0XS9FaReuz6EcjgIMWlj0OrtfQtrEuSodt56VXEmfXAkTlQfj+kT/YFomcKdP6iTwiarwdVEph+NrMAM5Hwp8cEp2iANLMySOFyrkmlhAzxjQ4df3egR0oM0xjnxDpSe414nfecQQBC3iVMcI1cPgZGBWcM9h1ukNr5tjfwJ+qgP/oQhmG5jsr5E0nexOGe+3fP4aovcLFmtDLQovLPdQBrDq+dtWYlgVAIGzNmN1uKcdv37I9ipqFyJt0CJuyPRie4TTSYhbvfhNHHbHQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199021)(36840700001)(40470700004)(46966006)(478600001)(2906002)(40460700003)(83380400001)(47076005)(2616005)(36860700001)(336012)(186003)(1076003)(26005)(426003)(86362001)(16526019)(82740400003)(81166007)(356005)(82310400005)(7696005)(36756003)(40480700001)(6666004)(5660300002)(8936002)(8676002)(41300700001)(70586007)(4326008)(70206006)(316002)(110136005)(54906003)(44832011)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 22:21:19.1294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b39cc678-86d3-4eba-a872-08db67a5846f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5104
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RCH root port contains root command AER registers that should not be
enabled.[1] Disable these to prevent root port interrupts.

[1] CXL 3.0 - 12.2.1.1 RCH Downstream Port-detected Errors

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/port.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index bc5d0ee9da54..828ae69086c4 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -981,6 +981,30 @@ static int cxl_dport_map_regs(struct cxl_dport *dport)
 	return cxl_dport_map_rch_aer(dport);
 }
 
+static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
+{
+	void __iomem *aer_base = dport->regs.dport_aer;
+	u32 aer_cmd_mask, aer_cmd;
+
+	if (!dport->rch || !aer_base)
+		return;
+
+	/*
+	 * Disable RCH root port command interrupts.
+	 * CXL 3.0 12.2.1.1 - RCH Downstream Port-detected Errors
+	 *
+	 * This sequnce may not be necessary. CXL spec states disabling
+	 * the root cmd register's interrupts is required. But, PCI spec
+	 * shows these are disabled by default on reset.
+	 */
+	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
+			PCI_ERR_ROOT_CMD_NONFATAL_EN |
+			PCI_ERR_ROOT_CMD_FATAL_EN);
+	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
+	aer_cmd &= ~aer_cmd_mask;
+	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
+}
+
 static struct cxl_dport *
 __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 		     int port_id, resource_size_t component_reg_phys,
@@ -1038,6 +1062,8 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	if (rc && rc != -ENODEV)
 		return ERR_PTR(rc);
 
+	cxl_disable_rch_root_ints(dport);
+
 	cond_cxl_root_lock(port);
 	rc = add_dport(port, dport);
 	cond_cxl_root_unlock(port);
-- 
2.34.1

