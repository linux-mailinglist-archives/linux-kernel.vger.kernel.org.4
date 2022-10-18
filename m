Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D53602CD9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiJRNYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbiJRNYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:24:31 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49700100C;
        Tue, 18 Oct 2022 06:24:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfhQNpFw96RsM5zs4c995JcvRmRkgwW3Cs+CkNqkljkwv90nxEz696GjEa3493fx+1bau3ngtaBH4dW4AnejCVXHGRK/sfdmaLuOWTw45tjTiO4BTPrFZvbpb/6wIB81NsRuNiIz/Km0dYiY83Gs/xc5tw+kwSMh5HN45ulQDrh/GMON6H/uqpiiGEsBwiE9leKs5MmR6rlYCRRsMMWkrf2IRLMH77+F4rA3Vd2Lz4IfpnV0aR15FcGKk1BYAp8Ry55ESs8w437frtcLcWj2Rab9egc1lle62MOoLfcyuzC4dLrP81G9CxzHLcEAwUIi2uUNJeKDxCjtLbhu7PEZaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecXAcyzW+KTrtytwxsF6pUH5ze1HJh2cUj2l01F0pU4=;
 b=OGSKUtYLPffNE1AyZXJsm1+JpevptvDjtytvfQvS4STOpVYAgyGI6hNqGZ0pH/kbf2MP43Lt/nRDV7mbrLz2jpcC05eMgd4jRBfZ6Raz7prd84xWqfLfzOaILM1x+wGEZh3mKv1B16oicyIamcErEbwCKo9f3ZeU+Uu+NbHAeRsp61zNl2jR4rLw5Aa+T5EepavWybPw6aF7l5cscUvV5XEbuYm0sYFv02dnwReBAd7dktgXl+gZ7Bs83JSGLyyYBjLyIdGnM3MrYwpx62UXqS8+wjvtS4K62TkpAtBjSa7rHEppKsP2k+Uuq8Qx/2/QQ31afrFnuXPEP1Ptrk685g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecXAcyzW+KTrtytwxsF6pUH5ze1HJh2cUj2l01F0pU4=;
 b=fU9JuQnjllBRmtBRJ6OIJZrkcvrgv7zsL/ifEqoNCWIxufR9De8QxtA8PcxX2caD9S3mBNzoG+d4XmHf9AwD6loh2XA5cSE7D8LynfZBdmnzrvafks3HIbCjOQIS+ZkuhzeQr3+o1QGnWJxYrEMsJIiBthk8/RvExuoZC0szFKU=
Received: from BN9PR03CA0360.namprd03.prod.outlook.com (2603:10b6:408:f6::35)
 by BL1PR12MB5062.namprd12.prod.outlook.com (2603:10b6:208:313::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 18 Oct
 2022 13:24:17 +0000
Received: from BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::79) by BN9PR03CA0360.outlook.office365.com
 (2603:10b6:408:f6::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30 via Frontend
 Transport; Tue, 18 Oct 2022 13:24:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT115.mail.protection.outlook.com (10.13.177.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 13:24:17 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 08:24:14 -0500
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
Subject: [PATCH v2 04/12] cxl: Unify debug messages when calling devm_cxl_add_dport()
Date:   Tue, 18 Oct 2022 15:23:32 +0200
Message-ID: <20221018132341.76259-5-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT115:EE_|BL1PR12MB5062:EE_
X-MS-Office365-Filtering-Correlation-Id: a1662cbd-af51-484c-6b37-08dab10c0ec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kglsqrHRe4x/9r3HZ92F/D4Mu1v8BioDytlvKDW5Ndzd6/X4cl8j2PKeXEPP9K/ajPdKeadZIJ/Mm8rHhl1tgMzF5QhcyuVZFlVM0o/46+abWtFYaoVH2nOru2HU8gZwuMx2WcbcGK607QBRz5KdeECHrveOJ/f4xGZDlrtsaJAENCqZuVTEGAsjX+lv/q105So3HeYkzSxIiGAaHJnvZozoHLkx4T4Qhbj0M0x+xubOPevjRlGGdu06r6b9wkb3/AZEystWLntePwDqKf8QoYz7HHbSazAME8wqwfyw4c9aTpBhh9kO+DE0W8jhuMHKDX/m/BbS5e9t1eiYW/Ydb9jQx6VVgvxCRkKuReqqcukZ61McAS9gAulGmWUGk4m4HTuAFONWcz6WKRLUQP2wMSFcgEDeX/w2KQKBwRgzvtMCkJTl2aOcytNVaJlJpuGlajR/598yHenZSZ/mF/bXeqod6vXAdeY7s1e4D2OkqoBm/0tWXvQtnEvPkASacUYBOpEsYaBPt0Xnm40Rxuq7NgVBiIDBsLSkGov3bYAwCuVa4uNmrDHw0Ntf4vbTyXP3hvQuLsAcngKpwVxTpx/kWBW1DqiJ2oUSQgI8sKl6VPy3uTrGODtCPCZQVermYui66CrcTNkBGR1A7MJisMIG/BizqjhqOn74gx60FXC6eQLWhAVvkf2z43vlPG89q1VZc/F4xH++/Uul2hx99mMp/XbfrBTq6lMQj0TejxW3VGkwmZcMhFHOO9qnWRcH6xV0mJQOhbvxGM1YkF0maEu9WssvEx4+M43onX3E7eoxUkQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199015)(36840700001)(46966006)(40470700004)(26005)(41300700001)(40460700003)(186003)(6666004)(1076003)(16526019)(336012)(478600001)(2616005)(82310400005)(36756003)(2906002)(7416002)(5660300002)(4326008)(8936002)(36860700001)(110136005)(54906003)(82740400003)(40480700001)(316002)(426003)(47076005)(8676002)(70586007)(83380400001)(356005)(81166007)(70206006)(15650500001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 13:24:17.1249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1662cbd-af51-484c-6b37-08dab10c0ec0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5062
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CXL dports are added in a couple of code paths using devm_cxl_add_
dport(). Debug messages are individually generated, but are incomplete
and inconsistent. Change this by moving its generation to devm_cxl_
add_dport(). This unifies the messages and reduces code duplication.
Also, generate messages on failure. Use a __devm_cxl_add_dport()
wrapper to keep the readability of the error exits.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/acpi.c           |  7 ++----
 drivers/cxl/core/pci.c       |  2 --
 drivers/cxl/core/port.c      | 48 +++++++++++++++++++++++++-----------
 tools/testing/cxl/test/cxl.c |  8 +-----
 4 files changed, 37 insertions(+), 28 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 767a91f44221..31e104f0210f 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -282,12 +282,9 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 	}
 
 	dport = devm_cxl_add_dport(root_port, match, uid, ctx.chbcr);
-	if (IS_ERR(dport)) {
-		dev_err(host, "failed to add downstream port: %s\n",
-			dev_name(match));
+	if (IS_ERR(dport))
 		return PTR_ERR(dport);
-	}
-	dev_dbg(host, "add dport%llu: %s\n", uid, dev_name(match));
+
 	return 0;
 }
 
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 9240df53ed87..0dbbe8d39b07 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -62,8 +62,6 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
 	}
 	ctx->count++;
 
-	dev_dbg(&port->dev, "add dport%d: %s\n", port_num, dev_name(&pdev->dev));
-
 	return 0;
 }
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 9bfd01b4e5b5..0431ed860d8e 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -892,20 +892,10 @@ static void cxl_dport_unlink(void *data)
 	sysfs_remove_link(&port->dev.kobj, link_name);
 }
 
-/**
- * devm_cxl_add_dport - append downstream port data to a cxl_port
- * @port: the cxl_port that references this dport
- * @dport_dev: firmware or PCI device representing the dport
- * @port_id: identifier for this dport in a decoder's target list
- * @component_reg_phys: optional location of CXL component registers
- *
- * Note that dports are appended to the devm release action's of the
- * either the port's host (for root ports), or the port itself (for
- * switch ports)
- */
-struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
-				     struct device *dport_dev, int port_id,
-				     resource_size_t component_reg_phys)
+static struct cxl_dport *__devm_cxl_add_dport(struct cxl_port *port,
+					      struct device *dport_dev,
+					      int port_id,
+					      resource_size_t component_reg_phys)
 {
 	char link_name[CXL_TARGET_STRLEN];
 	struct cxl_dport *dport;
@@ -957,6 +947,36 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
 
 	return dport;
 }
+
+/**
+ * devm_cxl_add_dport - append downstream port data to a cxl_port
+ * @port: the cxl_port that references this dport
+ * @dport_dev: firmware or PCI device representing the dport
+ * @port_id: identifier for this dport in a decoder's target list
+ * @component_reg_phys: optional location of CXL component registers
+ *
+ * Note that dports are appended to the devm release action's of the
+ * either the port's host (for root ports), or the port itself (for
+ * switch ports)
+ */
+struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
+				     struct device *dport_dev, int port_id,
+				     resource_size_t component_reg_phys)
+{
+	struct cxl_dport *dport;
+
+	dport = __devm_cxl_add_dport(port, dport_dev, port_id,
+				     component_reg_phys);
+	if (IS_ERR(dport)) {
+		dev_dbg(dport_dev, "failed to add dport to %s: %ld\n",
+			dev_name(&port->dev), PTR_ERR(dport));
+	} else {
+		dev_dbg(dport_dev, "dport added to %s\n",
+			dev_name(&port->dev));
+	}
+
+	return dport;
+}
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_dport, CXL);
 
 static int add_ep(struct cxl_ep *new)
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index a072b2d3e726..c610625e8261 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -582,14 +582,8 @@ static int mock_cxl_port_enumerate_dports(struct cxl_port *port)
 		dport = devm_cxl_add_dport(port, &pdev->dev, pdev->id,
 					   CXL_RESOURCE_NONE);
 
-		if (IS_ERR(dport)) {
-			dev_err(dev, "failed to add dport: %s (%ld)\n",
-				dev_name(&pdev->dev), PTR_ERR(dport));
+		if (IS_ERR(dport))
 			return PTR_ERR(dport);
-		}
-
-		dev_dbg(dev, "add dport%d: %s\n", pdev->id,
-			dev_name(&pdev->dev));
 	}
 
 	return 0;
-- 
2.30.2

