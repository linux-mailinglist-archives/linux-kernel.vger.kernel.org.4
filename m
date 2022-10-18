Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787D8602CD8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbiJRNYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiJRNYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:24:18 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BD8C90E9;
        Tue, 18 Oct 2022 06:24:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvekJYqY1nNyuoyTQGmXABUzUe6OhqankkHNa8g30SUqgDEz9ejrXE8wScXg+mIls43TvFLgI9fyDAfG0VVtIMNaMRuR6rW2ICu4d01KB2ihpq5S7XePL+MjXfgTyDo7IGSkoSFOwtQAlxB2SKWDMo8PL3cyHN1UyXQXptBFl6bCIriksPEAUFlPSdSCKAgwUkHqR1zbkreVQNwgj9MQOCWWNuLHWT9xo23h+elfndjOYEQERmy/CL57Q5zbrawziOPSnMXBDIL4L/jhMrIJ86CnNznpH/pZlCzD19wNgk70g1vJRg1+m+AxgifWpv+vwQM4SbH5+mxuI+Bv7DwAqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VI7/Md+lydGPyjBUrpWJnTZAnscxR9jQx0xHAMMwxI=;
 b=Fl+8k6XU/tg/2mni+CT3zORfaiR4Ry4hPe1jkhFTU511f0EjfascWBWjca990sJAEbwwKJFK3EhjcGR6VzIZQecNEL8ksDet1hMENVMs15Nv1oSSpz1lXO5/aI9u2xYAcomzD+vO9wGDC8yrpiizHRAu7GOakjscqQJAbfB7/NzHxlEGbHO+/v+q2EWVxxRhv4na/m4O8aEPwnoaJn7wxsGA5LgWBFOfvo6c5FKmgjHkIatwgBZ9XJH2/d9SLtweooqlnuEmXpWUgymNqSp3P5YtoEa9dTVSW/QXiBN+KJHfr3KUwD3TCWlFWqIPzua7RS2blG2giuNpIF3GO5ZcVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VI7/Md+lydGPyjBUrpWJnTZAnscxR9jQx0xHAMMwxI=;
 b=pN/g8q4eqKMlqriLXADB+RqxMCeGRzS6yNyAy/z48f72vgLnzCDIwIb2dp9CIDtIU94urW8NFAhoa1DiUisVPVPPC27/8XELdB76tg+IuTGzDCASFuN/59RL8v5Bg6OkdqfKgvhjigSb2K6+UpBSwJVcBA77q4+Ki3ybP1ZldPE=
Received: from BN8PR16CA0032.namprd16.prod.outlook.com (2603:10b6:408:4c::45)
 by SA0PR12MB4493.namprd12.prod.outlook.com (2603:10b6:806:72::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 18 Oct
 2022 13:24:14 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::b0) by BN8PR16CA0032.outlook.office365.com
 (2603:10b6:408:4c::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26 via Frontend
 Transport; Tue, 18 Oct 2022 13:24:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 13:24:13 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 08:24:11 -0500
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
Subject: [PATCH v2 03/12] cxl: Unify debug messages when calling devm_cxl_add_port()
Date:   Tue, 18 Oct 2022 15:23:31 +0200
Message-ID: <20221018132341.76259-4-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT009:EE_|SA0PR12MB4493:EE_
X-MS-Office365-Filtering-Correlation-Id: 55624dd2-140a-4275-3dbd-08dab10c0cbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dwj/PHQH/F/b3AErb47P9wTmU3v34TiZDF7Pc7BtLrkrsu9GmhWRyaKeaity82Qd0bBn+XW6pq0Tbn03JGZBLXaESP5dDUn0tLQrPVlFl4NEqbXR3k7wSPX/dtgdKsddOKe+JMsX8/5GsMpegf49t/Q+8mtuVUqANBooUnCpRkdHmszbLYiF0qgAp316WjQpdxfvkWiB4X7xmECT8vv5zUHu9lTnFXcmIrtQOx38QnPrPSpE27cLJLY85LSxLRIKCJ0rvaLw7Nq0ygCR+1ec5iKGnEO4dWMEwQJMjnwEfp4b2N9zYimMe29SjwgBdAP1otGfppudBKO74waNEp6b1i44cjv5UhqTxL3x6iJVroWp50QFFl7F60v5P4JUqkf7PaSopGXD9gre1tfM1IWqeJ/wKJ8mXR6v1Jas66Kg8AF3KIFTlMVHdt0XG1lUtav50Ya7crzMTIWClW9NT5q2UHzc3kMTpft3kiTLHudzVmtox28kPyVDmVPg2Y3w683Ew4ge8L0Ci7TG9igzjMdHAZpwVVedyaQTJynpHwSH3tkGW+9rhKXcqHFrPnUYNiuohkl/+fK+8pd9CNBqe7hhWFNI2wpJuo4YZ00ZR6cg2FYBM2GJkOfW2Fa25zCf6uoALxfTrj1p9qay2sHpLMUjzyBDRQYDB8dqZY2WOuEQQgdtiLQIEydbKXLlrEZA2rMQbZowuyGLw6hpta30LOIAaGP1ZhtsuzIi7NpltEFqncxGBowWRFdpXTcvZMZT0SNTdxnbvZHSHQCirR+Y7WZarnOb8eWE+CvNyBNi3S2V3X800xnKC/7FED3AGt9O3ipW
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199015)(36840700001)(46966006)(40470700004)(2906002)(15650500001)(7416002)(8676002)(54906003)(70206006)(4326008)(110136005)(70586007)(36756003)(36860700001)(478600001)(5660300002)(6666004)(8936002)(41300700001)(26005)(83380400001)(316002)(47076005)(426003)(40480700001)(40460700003)(81166007)(356005)(336012)(186003)(1076003)(16526019)(82740400003)(82310400005)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 13:24:13.7395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55624dd2-140a-4275-3dbd-08dab10c0cbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4493
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CXL ports are added in a couple of code paths using devm_cxl_add_
port(). Debug messages are individually generated, but are incomplete
and inconsistent. Change this by moving its generation to devm_cxl_
add_port(). This unifies the messages and reduces code duplication.
Also, generate messages on failure. Use a __devm_cxl_add_port()
wrapper to keep the readability of the error exits.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/acpi.c      |  2 --
 drivers/cxl/core/port.c | 51 +++++++++++++++++++++++++++++++----------
 2 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index fb649683dd3a..767a91f44221 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -220,7 +220,6 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 	port = devm_cxl_add_port(host, match, dport->component_reg_phys, dport);
 	if (IS_ERR(port))
 		return PTR_ERR(port);
-	dev_dbg(host, "%s: add: %s\n", dev_name(match), dev_name(&port->dev));
 
 	return 0;
 }
@@ -466,7 +465,6 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	root_port = devm_cxl_add_port(host, host, CXL_RESOURCE_NONE, NULL);
 	if (IS_ERR(root_port))
 		return PTR_ERR(root_port);
-	dev_dbg(host, "add: %s\n", dev_name(&root_port->dev));
 
 	rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
 			      add_host_bridge_dport);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index bffde862de0b..9bfd01b4e5b5 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -655,16 +655,10 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
 	return ERR_PTR(rc);
 }
 
-/**
- * devm_cxl_add_port - register a cxl_port in CXL memory decode hierarchy
- * @host: host device for devm operations
- * @uport: "physical" device implementing this upstream port
- * @component_reg_phys: (optional) for configurable cxl_port instances
- * @parent_dport: next hop up in the CXL memory decode hierarchy
- */
-struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
-				   resource_size_t component_reg_phys,
-				   struct cxl_dport *parent_dport)
+static struct cxl_port *__devm_cxl_add_port(struct device *host,
+					    struct device *uport,
+					    resource_size_t component_reg_phys,
+					    struct cxl_dport *parent_dport)
 {
 	struct cxl_port *port;
 	struct device *dev;
@@ -702,6 +696,41 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
 	put_device(dev);
 	return ERR_PTR(rc);
 }
+
+/**
+ * devm_cxl_add_port - register a cxl_port in CXL memory decode hierarchy
+ * @host: host device for devm operations
+ * @uport: "physical" device implementing this upstream port
+ * @component_reg_phys: (optional) for configurable cxl_port instances
+ * @parent_dport: next hop up in the CXL memory decode hierarchy
+ */
+struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
+				   resource_size_t component_reg_phys,
+				   struct cxl_dport *parent_dport)
+{
+	struct cxl_port *port, *parent_port;
+
+	port = __devm_cxl_add_port(host, uport, component_reg_phys,
+				   parent_dport);
+
+	parent_port = parent_dport ? parent_dport->port : NULL;
+	if (IS_ERR(port)) {
+		dev_dbg(uport, "Failed to add %s%s%s%s: %ld\n",
+			dev_name(&port->dev),
+			parent_port ? " to " : "",
+			parent_port ? dev_name(&parent_port->dev) : "",
+			parent_port ? "" : " (root port)",
+			PTR_ERR(port));
+	} else {
+		dev_dbg(uport, "%s added%s%s%s\n",
+			dev_name(&port->dev),
+			parent_port ? " to " : "",
+			parent_port ? dev_name(&parent_port->dev) : "",
+			parent_port ? "" : " (root port)");
+	}
+
+	return port;
+}
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_port, CXL);
 
 struct pci_bus *cxl_port_to_pci_bus(struct cxl_port *port)
@@ -1140,8 +1169,6 @@ int devm_cxl_add_endpoint(struct cxl_memdev *cxlmd,
 	if (IS_ERR(endpoint))
 		return PTR_ERR(endpoint);
 
-	dev_dbg(&cxlmd->dev, "add: %s\n", dev_name(&endpoint->dev));
-
 	rc = cxl_endpoint_autoremove(cxlmd, endpoint);
 	if (rc)
 		return rc;
-- 
2.30.2

