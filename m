Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DBA602CDE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbiJRNZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiJRNZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:25:11 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2060.outbound.protection.outlook.com [40.107.100.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B11215803;
        Tue, 18 Oct 2022 06:24:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gb4M5dxm1KN6Y2P4pJP6Hiv5gNvZLZ18wq4eMI+v1Kqy3UnKgdUTr7iKw/TGzhhEhGA2rOShRaP2G6cfX2BqRFlb258tVmOI3YG00kf4o4j79Is9MaMHQonU1X11P4jy8p0bmD1gJY0IgVVhuBKV7w8Vj3f20UbeKmum1vG4QC4aRkF5xLk90iNHTxjY6tPxGEP4g5U9NIh8XmTM9t0c8bYxOFV++5NK91dXJtlzFJA5aMxyCxLjYrCMs2rKYfocmDECyF9apuhDP5lomutYKG3ZsOABGokO55HtQXizw3GjJQin0nr7cP/4GvsuW1FKXCS+WrMyy9UcwX4sO8fdEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jo2Lg1CBLmLriTl/NpqSzdE8UaXgVmfhgM1KORTc794=;
 b=MgD0cXLS/eFRzmhgHvDgJraPud2J9Sps6XDFpAKw6vovaqWUA8lNbE/RMXZM04xu3Ege0huayB/KRsRNkAY2zhuLT3iskl/e2suxAgEKELf+Z6xeQB+oTJxXMWP+fy8cOeNbXLszGYfj/sbiZ8K/RBxEeiPdsjhZoP8fbPyxEYk2sykLOAEmhr0LyvngKJxlJtzosvZJRaAcoBVnVK/zazaFdMgTPv9XS2THAzrEiG3jd1tPnnqZl6K3JBshGK6Af36l06ijbB9DHIAO54x5LrCfVuSY6aHiSaDmmGJPPvVnZSI30+GEodjyD9VJqM84VCyrDja0SdbfbM8S2TBA3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jo2Lg1CBLmLriTl/NpqSzdE8UaXgVmfhgM1KORTc794=;
 b=1rOGaMUdVSkp8q4sExtcMVTRObBz3nV03WBzDnoLNc0gs01RaLp2oF1QTDNPVxd7kLmdLfdLI9CBjJ6F+M3L3ZI1o9XYv46NwS5CQKkd7TseWUZdmyInf/zcdeXhkiV+1e41BFLqG/dGfUm14DFbj4mAeOVz+nC3Ryci9IcxizU=
Received: from BN9PR03CA0860.namprd03.prod.outlook.com (2603:10b6:408:13d::25)
 by SA1PR12MB6773.namprd12.prod.outlook.com (2603:10b6:806:258::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Tue, 18 Oct
 2022 13:24:28 +0000
Received: from BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::2e) by BN9PR03CA0860.outlook.office365.com
 (2603:10b6:408:13d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31 via Frontend
 Transport; Tue, 18 Oct 2022 13:24:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT086.mail.protection.outlook.com (10.13.176.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 13:24:28 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 08:24:26 -0500
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
Subject: [PATCH v2 08/12] cxl: Factor out code in devm_cxl_enumerate_ports() to find_port_attach_ep()
Date:   Tue, 18 Oct 2022 15:23:36 +0200
Message-ID: <20221018132341.76259-9-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT086:EE_|SA1PR12MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: c78db01a-9cc5-446e-4ee1-08dab10c15a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 05CNkMk0OF8A2mAbo+VxWEJOfJNQ+WHnKCRX54UjR+KpttCyOsvMKjzLFvFZIHS+5yR2tIvlvhjhSmU39GXWpDgUxsTOeP1D96xXH61pZ4BQyjcAptzAIFjZKK9gkd/LiXchPZLHB9vkL8ecK9/a7mV27wDBLqUoMeQrZO/ET29bhkL4mzq5YT+p+dxcspEqWrewpkKcs29If636NdIBYJID/OWkfN8HU+I1pa+F5BGbjoFq+Rzzxefcgybqh5vEmDqFVvUvbHeCu8AlOHjsuAZ+y2POACQ3sfg9hN6p8rqoO56bSrgrcOfjj1kpGT+FOzI/P538UHOPkQX+RJ9rEj76vo8y/tWVKdUOQxJn1hTC5tytb24G4aL8NEsAIMKF9QYauwOhB1uUOMpgjStuNiZUYmo5SIueIL0Q5dciPGkiXlBHqfVosOxPEWNe1iwu9h3nIt2bWRNQI4glGPaD0/AZD460Zq09x7fqXUYOAKV1gcRQQk/Q8Xsdrf4QzZHnykPcRmtlKsXqPXarxm/AF+ye3dTm8i+UG58wdpNRYS7bT8T8unDuyGo/2/ZLvtyy50N26iIlsv1CEQUcGGK6FOnX+tjWOolePB30qp5sLYiqE2WxPSX/6A+rL1dHmndPE+0xUa5iUgHMS8zbrImeJFEGckyOFgfmtSJqdprxstCOxChn+h+kqi6/3dzKWYSOc1m+BUsBJ+Rpdp/T8f1an82st0+zM6XFPX9b7JxNC0ABRUFts7PbYxJuOl7h+VVJt0h8w6jX5Osi0FYAEMCgg5pH57Knn4hk2jkeqdQFkFAL6WuL+GLrDxacXu4pGEuSsNJb4AdcZ1ydZRWuKtvmqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(41300700001)(4326008)(40480700001)(83380400001)(110136005)(54906003)(70206006)(26005)(316002)(16526019)(186003)(7416002)(1076003)(81166007)(5660300002)(356005)(2616005)(82740400003)(8936002)(36756003)(336012)(426003)(40460700003)(70586007)(2906002)(6666004)(478600001)(47076005)(8676002)(82310400005)(36860700001)(37363002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 13:24:28.6822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c78db01a-9cc5-446e-4ee1-08dab10c15a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6773
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out the code to attach an EP to an existing port. It will be
reused to implement RCH discovery.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/port.c | 66 +++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 25 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 9af2d91db9bf..4b15481426f7 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1286,6 +1286,36 @@ static resource_size_t find_component_registers(struct device *dev)
 	return cxl_regmap_to_base(pdev, &map);
 }
 
+static int find_port_attach_ep(struct cxl_memdev *cxlmd,
+			      struct device *uport_dev,
+			      struct device *dport_dev,
+			      struct device *origin)
+{
+	struct device *dev = &cxlmd->dev;
+	struct cxl_dport *dport;
+	struct cxl_port *port;
+	int rc;
+
+	dev_dbg(dev, "scan: origin: %s dport_dev: %s parent: %s\n",
+		dev_name(origin), dev_name(dport_dev),
+		uport_dev ? dev_name(uport_dev) : "(null)");
+
+	port = find_cxl_port(dport_dev, &dport);
+	if (!port)
+		return 0;
+
+	dev_dbg(dev, "found already registered port %s:%s\n",
+		dev_name(&port->dev), dev_name(port->uport));
+
+	rc = cxl_add_ep(dport, &cxlmd->dev);
+	put_device(&port->dev);
+	if (rc)
+		return rc;
+
+	/* Continue to add more ports between this one and the root. */
+	return 1;
+}
+
 static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 			      struct device *uport_dev,
 			      struct device *dport_dev)
@@ -1373,8 +1403,6 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 	for (iter = dev; iter; iter = grandparent(iter)) {
 		struct device *dport_dev = grandparent(iter);
 		struct device *uport_dev;
-		struct cxl_dport *dport;
-		struct cxl_port *port;
 
 		if (!dport_dev)
 			return 0;
@@ -1386,30 +1414,18 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 			return -ENXIO;
 		}
 
-		dev_dbg(dev, "scan: iter: %s dport_dev: %s parent: %s\n",
-			dev_name(iter), dev_name(dport_dev),
-			dev_name(uport_dev));
-		port = find_cxl_port(dport_dev, &dport);
-		if (port) {
-			dev_dbg(&cxlmd->dev,
-				"found already registered port %s:%s\n",
-				dev_name(&port->dev), dev_name(port->uport));
-			rc = cxl_add_ep(dport, &cxlmd->dev);
-			put_device(&port->dev);
-
-			/*
-			 * If the endpoint already exists in the port's list,
-			 * that's ok, it was added on a previous pass.
-			 * Otherwise, retry in add_port_attach_ep() after taking
-			 * the parent_port lock as the current port may be being
-			 * reaped.
-			 */
-			if (rc && rc != -EBUSY)
-				return rc;
-
-			/* Any more ports to add between this one and the root? */
+		rc = find_port_attach_ep(cxlmd, uport_dev, dport_dev, iter);
+		/*
+		 * If the endpoint already exists in the port's list,
+		 * that's ok, it was added on a previous pass.
+		 * Otherwise, retry in add_port_attach_ep() after taking
+		 * the parent_port lock as the current port may be being
+		 * reaped.
+		 */
+		if (rc > 0 || rc == -EBUSY)
 			continue;
-		}
+		if (rc)
+			return rc;
 
 		rc = add_port_attach_ep(cxlmd, uport_dev, dport_dev);
 		/* port missing, try to add parent */
-- 
2.30.2

