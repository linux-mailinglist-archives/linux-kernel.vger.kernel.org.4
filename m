Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DF46228B4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiKIKlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiKIKlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:41:31 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C461C10D;
        Wed,  9 Nov 2022 02:41:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UA8oIOaJxhWvXdGaDYgV9R2YA1WN8A+B7WueAXUtm+0KuCghOVrbdlZipdqlIgqJA/aRWFpPNk6vBsADY1vmCEVfCw4TPdeiDMQ/UmCEGttwT/B0SnTMxb7/SQKTg+Ti8zP0f2SgcfSzeivcs5/KLL/Zi3W/PB54lA8hsxz8jQdbZmT9KUVXRyQo8dOqZ+U7O8vHaR2oEYDpssitWId2BG5FBvj/V1DRqb0lwzlOCjd9jOR/qXjlD65sosNO//SvIQOtOXXT+Aa0zZnqMrUgrsXeFJXjYZlTCu/MizOk9Ib5DKgugH06IyeCdMCkKZlQJbZFT+fAJnASvX8sQX+f4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmjvucrWL76xaSkdcKMv2J/9l8rMe5rFH3S3fU9xz8k=;
 b=SG2h2kXPddqsbBYQVXWYMgrCiaJ8CSH7vhNXJP+JEB94LubGv6kO2N0rVQnLNfW5SSBJFBx9dejOq4r1yjsAg7qlwlH0IeBpPYoRGW/8akVoZsUS31llzBxdzj0yrsGuM+7TArchet1mNFvZoibNMRj3yBf7ZJX1lyYAKqokbRZDRV1eTHTxcxWQj4XVW//IPdh1Aly/NTzD7ugwneqhAGEpVT7BA0tZ+esy0pdvZnv3hvnUJukY6caX3xMWdUds4bYv/AnkMH3XNn+XIALpuuYWaFFrwt6akAT3FYio+YbrGD/Fdhl6VMH1WVnwlJ5AqE3iZHqd1dMDjBMoqiGBlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmjvucrWL76xaSkdcKMv2J/9l8rMe5rFH3S3fU9xz8k=;
 b=fY1mU1tQdbYVhO6/YUBgs3GPzETZEgqw9tXkAtt/JuoUS9PlHekacRrVTu0UZG6lIJVIzaR0f8USXaWfPFghI1NCWHJdlOW4oWTBkhTzruBfE8LSe29+PIEFaipqqeYdAqomLOXWh3a4BfqMcsJT0veCuLXRbUySmDKVNQoUIvY=
Received: from BN9P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::27)
 by PH8PR12MB6700.namprd12.prod.outlook.com (2603:10b6:510:1cf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 10:41:28 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::1b) by BN9P220CA0022.outlook.office365.com
 (2603:10b6:408:13e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 10:41:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 10:41:22 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 04:41:20 -0600
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
Subject: [PATCH v3 1/9] cxl/acpi: Register CXL host ports by bridge device
Date:   Wed, 9 Nov 2022 11:40:51 +0100
Message-ID: <20221109104059.766720-2-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT036:EE_|PH8PR12MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: b57c4e48-c5ec-47cf-ecf8-08dac23ef1d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jaqi4CV/5UMVEI0BVvEJ0t+u/FolCQ6P1FRuc/uqeTpLTP06T3e+aVUct4Kbp1uIenye3eByx3sgUant5j7RFTjEJSyEMDB350HU1vd90EVwTuXrvVHKgHdLBzD9OsCUAIpJL/Dq6CfaAD77z4pSHTPveyWylrwao/a4g0mM+78tKFwQE12VKb5VSxtH5IFHs1EgOPsu8ZduLXaKbBIkR37jKTIdsvUKbr0mvsjVzjM/l5g4z+/OOY4RfpL0N+cUAIz9a12MYgRaLb1kMNAdZj22GBzGMRpV81ZxdDLg0yvPXwAIzb2hjO+14oaORk9x13OE4zA+1lwMSGu/P7jw6kjtciRC88iN5G8lL9e9ORSQxsPoaMUegxcAP05i0no1A/1MrA7ruYtMipu+fLJ7gF2Dm+NQUSgAQvHfyClfn6pLG5L7lNAtFUHpqbv/+K83JSv0iXqMA07K5LteYoEnO8NAlS3grGfsg+YBb6sbh0gNbF44b5jurR+CnZ8KuBj6+kVtQ02/15/UYKMYnEpv2KzopVai94K5xBfqElfvYHoKNk++KmtD8nNOIuNtmKzHrWSAACAmxrfqWFr0dfjroOWLSK4X02+sNOM/7jEAqRovHUUvnnMSh6WI4DX2lQY0nM46R8cFXil0eegOaomrimmLbVlIqdnJO/q06SPyV4lOs01kIe+wJ9bBfHOradqk8M5Kkvp44ZEbxk5IKtE9q813a3yJs0BQ2/Va4iE8dr5YPIl2hEjUa2WsCzKkxquj7VzHKWFQnUnW175D3+QqDr4LKu9rhBWcgvLqppyNnSCP1O9cYwd0ykcfOS6jK9aC
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199015)(36840700001)(40470700004)(46966006)(186003)(36756003)(8676002)(4326008)(26005)(41300700001)(81166007)(70206006)(7416002)(6666004)(40460700003)(356005)(2616005)(70586007)(16526019)(1076003)(8936002)(5660300002)(316002)(110136005)(54906003)(83380400001)(82740400003)(2906002)(426003)(36860700001)(82310400005)(336012)(47076005)(40480700001)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 10:41:22.6604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b57c4e48-c5ec-47cf-ecf8-08dac23ef1d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6700
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A port of a CXL host bridge links to the bridge's acpi device
(&adev->dev) with its corresponding uport/dport device (uport_dev and
dport_dev respectively). The device is not a direct parent device in
the PCI topology as pdev->dev.parent points to a PCI bridge's (struct
pci_host_bridge) device. The following CXL memory device hierarchy
would be valid for an endpoint once an RCD EP would be enabled (note
this will be done in a later patch):

VH mode:

 cxlmd->dev.parent->parent
        ^^^\^^^^^^\ ^^^^^^\
            \      \       pci_dev (Type 1, Downstream Port)
             \      pci_dev (Type 0, PCI Express Endpoint)
              cxl mem device

RCD mode:

 cxlmd->dev.parent->parent
        ^^^\^^^^^^\ ^^^^^^\
            \      \       pci_host_bridge
             \      pci_dev (Type 0, RCiEP)
              cxl mem device

In VH mode a downstream port is created by port enumeration and thus
always exists.

Now, in RCD mode the host bridge also already exists but it references
to an ACPI device. A port lookup by the PCI device's parent device
will fail as a direct link to the registered port is missing. The ACPI
device of the bridge must be determined first.

To prevent this, change port registration of a CXL host to use the
bridge device instead. Do this also for the VH case as port topology
will better reflect the PCI topology then.

If a mock device is registered by a test driver, the bridge pointer
can be NULL. Keep using the matching ACPI device (&adev->dev) as a
fallback in this case.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/acpi.c | 48 ++++++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index fb9f72813067..06150c953f58 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -185,6 +185,17 @@ __mock struct acpi_device *to_cxl_host_bridge(struct device *host,
 	return NULL;
 }
 
+static inline struct acpi_pci_root *to_cxl_pci_root(struct device *host,
+						    struct device *match)
+{
+	struct acpi_device *adev = to_cxl_host_bridge(host, match);
+
+	if (!adev)
+		return NULL;
+
+	return acpi_pci_find_root(adev->handle);
+}
+
 /*
  * A host bridge is a dport to a CFMWS decode and it is a uport to the
  * dport (PCIe Root Ports) in the host bridge.
@@ -193,35 +204,35 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 {
 	struct cxl_port *root_port = arg;
 	struct device *host = root_port->dev.parent;
-	struct acpi_device *bridge = to_cxl_host_bridge(host, match);
-	struct acpi_pci_root *pci_root;
+	struct acpi_pci_root *pci_root = to_cxl_pci_root(host, match);
 	struct cxl_dport *dport;
 	struct cxl_port *port;
+	struct device *bridge;
 	int rc;
 
-	if (!bridge)
+	if (!pci_root)
 		return 0;
 
-	dport = cxl_find_dport_by_dev(root_port, match);
+	/*
+	 * If it is a mock dev, the bridge can be NULL, use matching
+	 * device (&adev->dev) as a fallback then then.
+	 */
+	bridge = pci_root->bus->bridge ?: match;
+	dport = cxl_find_dport_by_dev(root_port, bridge);
 	if (!dport) {
 		dev_dbg(host, "host bridge expected and not found\n");
 		return 0;
 	}
 
-	/*
-	 * Note that this lookup already succeeded in
-	 * to_cxl_host_bridge(), so no need to check for failure here
-	 */
-	pci_root = acpi_pci_find_root(bridge->handle);
-	rc = devm_cxl_register_pci_bus(host, match, pci_root->bus);
+	rc = devm_cxl_register_pci_bus(host, bridge, pci_root->bus);
 	if (rc)
 		return rc;
 
-	port = devm_cxl_add_port(host, match, dport->component_reg_phys, dport);
+	port = devm_cxl_add_port(host, bridge, dport->component_reg_phys, dport);
 	if (IS_ERR(port))
 		return PTR_ERR(port);
 
-	dev_info(pci_root->bus->bridge, "host supports CXL\n");
+	dev_info(bridge, "host supports CXL\n");
 
 	return 0;
 }
@@ -258,13 +269,16 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 	struct cxl_chbs_context ctx;
 	struct cxl_port *root_port = arg;
 	struct device *host = root_port->dev.parent;
-	struct acpi_device *bridge = to_cxl_host_bridge(host, match);
+	struct acpi_pci_root *pci_root = to_cxl_pci_root(host, match);
+	struct device *bridge;
+	acpi_handle handle;
 
-	if (!bridge)
+	if (!pci_root)
 		return 0;
 
-	status = acpi_evaluate_integer(bridge->handle, METHOD_NAME__UID, NULL,
-				       &uid);
+	bridge = pci_root->bus->bridge ?: match;
+	handle = pci_root->device->handle;
+	status = acpi_evaluate_integer(handle, METHOD_NAME__UID, NULL, &uid);
 	if (status != AE_OK) {
 		dev_err(match, "unable to retrieve _UID\n");
 		return -ENODEV;
@@ -285,7 +299,7 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 
 	dev_dbg(match, "CHBCR found: 0x%08llx\n", (u64)ctx.chbcr);
 
-	dport = devm_cxl_add_dport(root_port, match, uid, ctx.chbcr);
+	dport = devm_cxl_add_dport(root_port, bridge, uid, ctx.chbcr);
 	if (IS_ERR(dport))
 		return PTR_ERR(dport);
 
-- 
2.30.2

