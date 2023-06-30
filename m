Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F302744522
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 01:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbjF3XUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 19:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbjF3XTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 19:19:24 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495C649E0;
        Fri, 30 Jun 2023 16:18:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aw2Ugr8JDJPeaIuigOuwDj7/4R0nDon0iZFte0zPWuJWaBqKBbIqLbxTK3OnwP6vSJ2JsHOu+Z6g+9hGtjfYz3wBM4rRUXS+1OL/+CaQ21kQAVxfTqQVxJ9AED/RTKlAOPRlI1UrcogCQxgvJBfLobiUx0XXBNxwRCRuip2OFxAwiq+0sYMqEad9Iy2Kz0whYhMvbSq4b8B96219u82rR/0xQlLQ15oeCI1SiJyW3C68wakunw8R/Ook2xDho8zh63jwRtotCiCG/XtWPA2oDZhQmQzcTHJHPgPptfnjyqegvi2Da4spWy/v83nvvO2lqNzKe8Jij6AX3/SA83AsXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=veNqSvD3gLXGhiJ185dKC749JaNAfs93PbYY14peU/k=;
 b=H0hDvLQVGxtnoX/RbF8uad7I6DJ7xa84BF/1i4XyyZaRCFx4vlYcjyGudRUyX+FSW5WAaqvOPzIqYauYfR0jj02sU12k7m+MaKHtjiHsPvljIQ6raKtf9TUtDauB5Y+WiUy4eez2hv/wQcEiJL741KGHy+tcVYE5PAo3fnibQ/Wg6ZRw97iCptJMrdNw1bSntxKgWTeC0+1Za1YZ+0Ea8OOeDybUFHqxQqSQQVIr1BPevgPkhLO+q4SjJppqHEUfqh5h6oG8679gbB2jsKEt+xXEivj68mn2a5llbSGDY0bnDDwytFL0O22bRAEZDGjVm662IpavekBdocyXGvDk0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=veNqSvD3gLXGhiJ185dKC749JaNAfs93PbYY14peU/k=;
 b=E+6El6DU/X8c7y+Sws9JjZnNYjMeBcfekHiihxrAjYi8hh2lW4/68Hd7MenR8yIxenomXGlelrj7RuaWpiezMJwK5P0kmU1ckxDYYJSakPxDI0rwec3YClMGbongMJH1autFI5Xw6iyUnPisWrui2Kx1iAC53CDoZJJisCCnem8=
Received: from DM6PR21CA0023.namprd21.prod.outlook.com (2603:10b6:5:174::33)
 by PH8PR12MB7349.namprd12.prod.outlook.com (2603:10b6:510:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 30 Jun
 2023 23:18:51 +0000
Received: from DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::a) by DM6PR21CA0023.outlook.office365.com
 (2603:10b6:5:174::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.13 via Frontend
 Transport; Fri, 30 Jun 2023 23:18:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT110.mail.protection.outlook.com (10.13.173.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.43 via Frontend Transport; Fri, 30 Jun 2023 23:18:51 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 18:18:50 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v8 11/14] cxl/pci: Disable root port interrupts in RCH mode
Date:   Fri, 30 Jun 2023 18:16:32 -0500
Message-ID: <20230630231635.3132638-12-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT110:EE_|PH8PR12MB7349:EE_
X-MS-Office365-Filtering-Correlation-Id: 29ea222f-8f67-4a3e-7449-08db79c05d76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: atZt0sPdepsEBzuevCEeknfQnUEFtobIRZu30q0y0C53FgYGext1NXYSO9C9o5SGEflFERn0QMq07P3V+GDCkAY7KBcU+uC9biaISpAMI3ISlj1mABwITlqNkfRyaBgNgNB4wHWZ+VMB8KI04YHLkh7q+/iEASfi/OSvIfzakf410YrMAIlYoqQx/BTHBosA0HNvHlhMSWdjhnPyW+WKLzCm3Dvt8qJdPprUE6MESGtWEkoeUmua8rbBXFeJZJjUew+DwfE81D8dK3geDDBvFR6JrE86coAYnthgtMrvfLShNZzKriQxA2wu1IS2YY/a8747FExmAaV1fAd8htZaFKIhDQ3Af+skP/WiU6GrjQACNaykjumqD/4clR4VCSuocvh6Vj5+m99WTtXP6B4C8ovk9cpv6Am1MDm9zd+FdTJFP/vct/WrOA1EXRRWCUL8/QxZ3yrEFe80EM85ySz3abAfO54HyNfYM43BPTX/UvneQ3SAy2F9TEN2euFo8eu3VnpuL+ETy1FiVJmJJda1+glTOp2/7r/qLvK3i4G8Q3cu+wYa6BZneysQ3LgShvfanBthZSP/8S5x5EZGq3YpP7bkaNUXiyhYstmhJf44ijpJD01Tz3TizANweTLKnj7wyqRbK5V9nq5b0f5dRif9OAG0ORToUt25FgeFqvn7O97p3/0IMPB0cb3DGrGC9o36glDL3bcoKO5lVa67g+fGK4MeMFRZq0H1Vqk8Dh1LyVcks8VzS6FcmwxwvJBoDzqALJnv4NONDjXh/1w9NGpT5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(26005)(2906002)(82310400005)(7696005)(83380400001)(82740400003)(6666004)(16526019)(81166007)(2616005)(1076003)(186003)(356005)(47076005)(336012)(426003)(41300700001)(36860700001)(86362001)(110136005)(54906003)(4326008)(316002)(70206006)(40480700001)(8936002)(36756003)(5660300002)(8676002)(7416002)(478600001)(70586007)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 23:18:51.0845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ea222f-8f67-4a3e-7449-08db79c05d76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7349
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
Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/core.h |  6 ++++++
 drivers/cxl/core/pci.c  | 29 +++++++++++++++++++++++++++++
 drivers/cxl/core/port.c |  3 +++
 3 files changed, 38 insertions(+)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index f470ef5c0a6a..6b037030b936 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -87,4 +87,10 @@ enum cxl_poison_trace_type {
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
index 1c40270968b6..e306d3c9638b 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -819,6 +819,35 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
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
index a482341c0d89..71df10309be8 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1040,6 +1040,9 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 
 	cxl_dport_map_regs(dport);
 
+	if (dport->rch)
+		cxl_disable_rch_root_ints(dport);
+
 	cond_cxl_root_lock(port);
 	rc = add_dport(port, dport);
 	cond_cxl_root_unlock(port);
-- 
2.34.1

