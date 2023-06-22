Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D9673AB29
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 23:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjFVVGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 17:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbjFVVFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 17:05:18 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20613.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::613])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041FA44BB;
        Thu, 22 Jun 2023 14:02:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFwQlbZmwlMXjYthGbWh73Nf/b1kQko+QcPV9Dz1m20G+M/MY2z9X8Re9L3wYNruNq1uggsa6yqBCzONp5f+ZRoCzvUWbtnMjt3wS4IEi5PrXEt/qiutRv10P6aAwislNMMnKW/TFJwK3tR28c3Ygx12N0EW/sIcOyBk+s30G+Fc8F7vZveENIkcbFFSyA1yA76UjvFHoNtVhebGmxU6f9gIWDrth82TZpHYQnsapda66YinUF10r6a0Ud0daYztqkH9F3pYobqa4o8ZJ2pq1dPThCpqwHtiyUOg07Dip7L554c/GqMlp5YtdTtb1hBZlo9wU8EYySNg2G4xVu9dUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABgIUzuhQ7UIBUB1FI626y4+Cs/XL5GbvRfsdINundY=;
 b=A5pdaBIyFo1OjpYVUJsoCnNhmo9oECWZdIuqCY02h/le4EiAMNrTKRMoDHt1fTLJrYYdc/nvNYvPygE2522DsoVgwKaYFb/F5jfPUwKriChM9eB30JqXnD6K0F74BRASKbXtCdYzPYYnI3qYw8H5ewsQ8zymDXg576Kdk2o8lRadwRPTHnVyF5yYd1KPdTP+jylExCExMau9jppqMlEMav2wf8Y2MjFIDPwmiRKf8R5mVYZFKyxM5/Wg50y2AYSDmshnQLko65b3CNcDi3IxrjVBNR64pPI3N28ixFV5Ws/w3CtoMYluTKmsmAbTX79+sSWXaEfzODvmvgQEplwXnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABgIUzuhQ7UIBUB1FI626y4+Cs/XL5GbvRfsdINundY=;
 b=edtT9Zf2DmLbVu9H1NyRE8KsERWvw3CMm3YkvbpYKLs3nF+zdVUAccAHNLp79SIg4W2qOjKjN9Qk4Fn6Z9fPabGY+bYHbg/+YEnhxOCGiqlpCcfY7MFiYc+hWf6dpvCWtN2QKF382UKsr3pzktDwP514uLfN/V3tMsGLRKIC+9E=
Received: from CY8PR12CA0014.namprd12.prod.outlook.com (2603:10b6:930:4e::16)
 by BY5PR12MB4998.namprd12.prod.outlook.com (2603:10b6:a03:1d4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 20:59:57 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:4e:cafe::b3) by CY8PR12CA0014.outlook.office365.com
 (2603:10b6:930:4e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 20:59:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 20:59:56 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 15:59:56 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v7 24/27] cxl/pci: Disable root port interrupts in RCH mode
Date:   Thu, 22 Jun 2023 15:55:20 -0500
Message-ID: <20230622205523.85375-25-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|BY5PR12MB4998:EE_
X-MS-Office365-Filtering-Correlation-Id: b538467c-ba22-4203-dd8d-08db7363a29d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iup8FG21r1gU16IYk6GawwcmdFdIu4Vb4KuyU8yjqcmv+FHviiYGOTbeifn6hhVr+ZFqjlh96tkoQGdstCAJ2MTbBD+pmBUbeUrbHq4gUS8tBvpf2TMOtSkAcVZM1c7L/6CXz97C6XEZ23RljqrLp5NWpNPF6MPyf1ERxmLJCbB5XP8clT5KTFi4aZzrChx1Jh4GGixMiKfhMAp77suo43SKXEoyWvgXe44Qd7yN+0tdzY3+WndrSGZQAE6Hk0sOsOEqwAMoyFOaTLDqLbXgcjekyac1QdujsaNvN5Hj/JrET84M9oJRUYhZhpBFfd8x94UJNPNWITV59GExsJ07aKrGsE7nMKRZYDDJ5e5glKVawvZORYDFJAMLE/HQjES4zgp6a4/1vZq1HfY8g+9IHfaQAoRbK7qnZ/GIFPTQpP4azrhRNe2nnYCAqddvijBGmp8tG96m9iiaN/QmHINfB7w9TLfhQlJjO+YzKJVM4RZYq7n3P+fOj5Hef9W6xtEgvR/juFUPrZvAmWlOoXrX7yk6oDa/WGG81Uztru44BNC1WxpqMp4J0cEVJ2WtgQWbECVrbnRd6TYgbuuQr4xw49wdkPCneqfi9xcQTW6Np3RD4nanEV8ZgM9etBddu7GAZjzE3V/o/7/XakuJ7cITmtXyEvqL+VhLxrwHBNXYwP2y0eW187MMxfocKBfAGH7MmFfvyuym1IIcrHFy/hlKcYO0uLa2IN5MBz/ZLUvBc2xLpB7njJ5g/HOSjn36Y2EB71bgbP7OX+xcI3oVat38oA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(7416002)(44832011)(40460700003)(36860700001)(5660300002)(8936002)(36756003)(8676002)(356005)(81166007)(82740400003)(2906002)(40480700001)(478600001)(6666004)(16526019)(186003)(7696005)(110136005)(86362001)(54906003)(2616005)(82310400005)(26005)(1076003)(4326008)(426003)(336012)(70586007)(70206006)(41300700001)(47076005)(83380400001)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 20:59:56.9331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b538467c-ba22-4203-dd8d-08db7363a29d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4998
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RCH root port contains root command AER registers that should not be
enabled.[1] Disable these to prevent root port interrupts.

[1] CXL 3.0 - 12.2.1.1 RCH Downstream Port-detected Errors

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/core.h |  6 ++++++
 drivers/cxl/core/pci.c  | 29 +++++++++++++++++++++++++++++
 drivers/cxl/core/port.c |  3 +++
 3 files changed, 38 insertions(+)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 87467c633123..880bac9db376 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -86,4 +86,10 @@ enum cxl_poison_trace_type {
 	CXL_POISON_TRACE_CLEAR,
 };
 
+#ifdef CONFIG_PCIEAER_CXL
+void cxl_disable_rch_root_ints(struct cxl_dport *dport);
+#else
+static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { };
+#endif
+
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 9e0eba5ccfc4..897830c19d1a 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -838,6 +838,35 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 		cxl_handle_rdport_ras(cxlds, dport);
 }
 
+void cxl_disable_rch_root_ints(struct cxl_dport *dport)
+{
+	void __iomem *aer_base = dport->regs.dport_aer;
+	struct pci_host_bridge *bridge;
+	u32 aer_cmd_mask, aer_cmd;
+
+	if (!aer_base)
+		return;
+
+	bridge = to_pci_host_bridge(dport->dport_dev);
+
+	/*
+	 * Disable RCH root port command interrupts.
+	 * CXL 3.0 12.2.1.1 - RCH Downstream Port-detected Errors
+	 *
+	 * This sequence may not be necessary. CXL spec states disabling
+	 * the root cmd register's interrupts is required. But, PCI spec
+	 * shows these are disabled by default on reset.
+	 */
+	if (bridge->native_cxl_error) {
+		aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
+				PCI_ERR_ROOT_CMD_NONFATAL_EN |
+				PCI_ERR_ROOT_CMD_FATAL_EN);
+		aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
+		aer_cmd &= ~aer_cmd_mask;
+		writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
+	}
+}
+
 #else
 static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
 #endif
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index a92794e6b7b4..2fdfb31f16c1 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1037,6 +1037,9 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 
 	cxl_dport_map_regs(dport);
 
+	if (dport->rch)
+		cxl_disable_rch_root_ints(dport);
+
 	cond_cxl_root_lock(port);
 	rc = add_dport(port, dport);
 	cond_cxl_root_unlock(port);
-- 
2.34.1

