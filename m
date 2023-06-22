Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340F373961B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 06:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjFVEA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 00:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjFVD7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 23:59:52 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC221BF2;
        Wed, 21 Jun 2023 20:58:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mET5W2e5afvCkloTny/zNyYQCn+Cx6KGmUzTVFUH+UaD/5jgyYW715+sKZldisTE9CgwsIi77NXvNGZ7uz0Hcv710ofLXioYD4hPHq0WFY+8bPvwQyBdmoc1pC17Xzd0ySVnyKIC+Jpty7899bTbEMM3qzSS80LwFYtcll108WE31sUpckSSSFpU+ZksO5KgE94uLGKednWzvHLqfXN6OOSlClLE4orzTf/VptFaQ688ANjZadGdFuIWQpcp20eyKs0V9OcUBAgu4We9A4ebUMA+EerPSJ+/OJL0jy8DbItK0BCxJFtk+lPuuTmN0KIl/5k4/67Jgp5hF/dzfxfTWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7dzdAMBEGDFkSPI8yEapGzVikvApe9b+yymoXLELQ24=;
 b=Y3/in9TtNlziyPiSSrv9rhd0tnSC2fiEyMyGo3KjdOXkH2kIp8Z45KBJjRCxCeARt57AJLallYW+FK40WQfSffo+nEnw/COuG6YTAZMHoKFwhfPivRssv1ksAyMw6tirQ2z+yIHl1kM1+YF3akkpUj8S8UyPnnh3C/reEX0hTJSiVtCb7oLXt68z9TsuOhwkhjGbbRa339Qdj0P3cANvbHISlmWA8UomhDzKYe26wLW08hrSC9vVvlibwzLIBXy8xrj74eOwCcIYpnkoFMIizbM5DPjlwd9Wa6AL5X8zxpMvqQwQHlAAtj9FofM2EswPm1hSoZK31eSEsJDZh3IFhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7dzdAMBEGDFkSPI8yEapGzVikvApe9b+yymoXLELQ24=;
 b=FBKo5fPJm6q+Jtkbq3rFt1k8iT71h47Q9NHMbQ7cxkmvBNjW66cZp3HBfzK8KoGk8j8AE7hz2600X71UXTD9GqGNzZ2lPoeBvFwxxZKPGe9s3b9iZcQXdB/wrMRiNOI3OWDTlFBCwy9TxvXW051kiMd8xI9sLQZazZn+JEjxHiw=
Received: from BN9PR03CA0613.namprd03.prod.outlook.com (2603:10b6:408:106::18)
 by MW4PR12MB6952.namprd12.prod.outlook.com (2603:10b6:303:207::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Thu, 22 Jun
 2023 03:57:35 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::4e) by BN9PR03CA0613.outlook.office365.com
 (2603:10b6:408:106::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 03:57:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.41 via Frontend Transport; Thu, 22 Jun 2023 03:57:34 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 22:57:16 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v6 25/27] cxl/pci: Disable root port interrupts in RCH mode
Date:   Wed, 21 Jun 2023 22:51:24 -0500
Message-ID: <20230622035126.4130151-26-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230622035126.4130151-1-terry.bowman@amd.com>
References: <20230622035126.4130151-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT031:EE_|MW4PR12MB6952:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a6f8fa7-405f-42f5-6881-08db72d4cfa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HCGypy8GD/dkz8KZnPmdLUTjRzzS6FWxHXhikI9mU7mCAdo7NSBRclZp5X2Wgv4TIbpkuhpBdMDOGdAlOXdiG2N7NUzVsjGijtaVNhyWYJdiLM5M1pD5KTgQk8csOfGbZFnTup4Dx+6/yOT6UCo6ylJu9R/nvbcc4XggCVrDmbL9mJFehvQLlphn1mBsThK+Or6q9nUe03s/YTBxPAyRO+nPC+nD/Vgc4qEupItMBCa6aGmhczJrNsUck6M1mgNG1vvsh/e3aX952z2O8xy+73yJcfN0NwQKatKDTGwlK7rio+rZb1oopsNPfXqsENt+N/qomEVib+e8PVIByH23PMWH+w0Dhlr2vTJkDUfllPQ9H8l7xlETP/scdCA5vRuy72lVQNR3fDTcDw+a2A5JVOoj70YlhR5Q4mEEDMRRFD/L9IXeUc5s7d8TK2HxhDlKV3tY4ArDKttPUvr8HrIH1VUgWqIYhCLDld6flAo41v4rOedP6b2dh4Orj90WDYQyJrkGf1ucTAmhcRJsTB8AD3M/sgHZjGFYLTarug7X8wJOlxCcrTYwM58JK1grJDhYEnPB+vfCIJ62bJiUO3G1nQHqZufVNDJkZ92uv7MF33ucdnz1OjaKRbH3o9nXNhlkuqgrYgk2pFtAKG+fhHgtzy2pfb0FEgYaDbOWNgX4LDUf8gXb004nt5TiIVTRRmtzusfzSW+7grU4osocB2HHfV7v7+kOBMjAZ3AZY3OTYMG5xEVHyYudvWCWRmJyAMnB3uJfeeC56YXBrg5jZ8PlSw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(7696005)(478600001)(6666004)(36860700001)(16526019)(186003)(26005)(336012)(83380400001)(426003)(47076005)(36756003)(86362001)(2616005)(81166007)(82310400005)(356005)(1076003)(82740400003)(40480700001)(4326008)(70206006)(70586007)(316002)(5660300002)(44832011)(8676002)(8936002)(7416002)(41300700001)(110136005)(54906003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 03:57:34.4814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a6f8fa7-405f-42f5-6881-08db72d4cfa3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6952
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
index 9e0eba5ccfc4..39a2f9f4f115 100644
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
+	 * This sequnce may not be necessary. CXL spec states disabling
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
index 87a12e69aa8e..2d812bbaf05f 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1035,6 +1035,9 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 
 	cxl_dport_map_regs(dport);
 
+	if (dport->rch)
+		cxl_disable_rch_root_ints(dport);
+
 	cond_cxl_root_lock(port);
 	rc = add_dport(port, dport);
 	cond_cxl_root_unlock(port);
-- 
2.34.1

