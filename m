Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32444602CE1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiJRN0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbiJRNZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:25:50 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4364220F4A;
        Tue, 18 Oct 2022 06:25:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5XVzVLTsDyXNLRszvyUfBUaj3/9H1O1jVus0TTgns8q1lHNcLh4n+lkBzs1IQKwo0A8qTS5LPie60e8ea+PkX9dBDcsW4GZiRbRRlohX33i2p5SPU6xTra87J21DOIbp3S7ZpZTRyGNt9hVJpeHTcpm0JH3JBx0zm0wYsawqty4m2c8sT443FQnxTTozvW8szTBWVPoonGQIg4vUt2bXBB7/WKeZ9K8Q3pV2b6pWKWBEbndZAXWvrmN6MhQiiMyx1Sbit9IWXM2iH+9hlTfHLSYC93mU88AsBzdE5j7Q/3+moC8/kRgBfcpjCAt11cDYzvupEwgJf3BgLBI5QhKGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSlDXWGvidoCnzrNcuYQ6HS9PF/UoFr07bBjgjNrfXs=;
 b=CeiUuGeX0xJahZOuAXfr2viorXXlbK9wm1mfPj27enWlkd0/YYlgPyxmoWxR7K8ESMmVmmKmkxUWnOeBPEpauw5TBA3Ny4BMAFrdW2OaVRov+j2rFFx8AMFLnFpp0mk18X4wCzN67vUOHiwsB10nvg2XVPq1kl4Ot5l0erlHYOK8XyzXFpAxn/hsuqP/FQjHpQ/EVXHDM7fyEuPMdtJEwg+Fe/sjY0fWnSwUUm/Vx1pu3Fdh/V+153t9RKMmeVQvJi0iisY3bojB1KDeuUY8fos0ZFhy62APzfuiPrCiVlk75U8NKYysLdp5oA8dlHkFEaE8az4NTQhBpQCMggrmhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSlDXWGvidoCnzrNcuYQ6HS9PF/UoFr07bBjgjNrfXs=;
 b=HA5fncxaNr90T1rxQ7CupP3lGQPVX+1QqR6y9J6ob2vepKWNEAG4Pmk9bKl7YUdqobE647jvuQkLNCxL3GMR7HWveGmqUPc/ZA10im3wZd/mCy2jdZriCmzradSqfTBWwS5OY2zFfFB6MgnVGY7RdgQFLo+XkqNhlyqs4hnguAk=
Received: from BN9PR03CA0666.namprd03.prod.outlook.com (2603:10b6:408:10e::11)
 by BY5PR12MB4113.namprd12.prod.outlook.com (2603:10b6:a03:207::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 18 Oct
 2022 13:25:02 +0000
Received: from BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::e2) by BN9PR03CA0666.outlook.office365.com
 (2603:10b6:408:10e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33 via Frontend
 Transport; Tue, 18 Oct 2022 13:25:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT078.mail.protection.outlook.com (10.13.176.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 13:25:02 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 08:24:59 -0500
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
Subject: [PATCH v2 12/12] cxl: Extend devm_cxl_port_enumerate_dports() to support restricted hosts (RCH)
Date:   Tue, 18 Oct 2022 15:23:40 +0200
Message-ID: <20221018132341.76259-13-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT078:EE_|BY5PR12MB4113:EE_
X-MS-Office365-Filtering-Correlation-Id: 54cd921f-b359-4d0c-667b-08dab10c298d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Es/Uqk0Pq4ACISn1odl+Wc75MKbuifwqpeiQv7f2PfsVWoPS0DFN3RU0doKYobmR5aeQKHti871q2gJDbe5vKqu0AteWKYqzC9Tdjwj+aL6nJC2H6GYHkNbQpU1uJvjnS/O1QcKBhfNw9IPDzjIKELCUf/VmTW5NpZIoynpFa9VypY2PEpiTJSRxWr+6brJG9ybtn8Hu+fpbU1L59ETvOTCeiC3NoCDnlQCgqwt+QfOMduTqnrsjeqRksbM78AFtskbF3xSSKPeYGwV9FKfZYgeiKO3j+LXL+v1Dp40dNuS0cVbxQkuiBubdyYM0flTzyWaUrfHOdXQb/MUglmdT9f2CfTYHlGHStvpo+Nh6Hu92rDEavrQBEOJLtMMSgNvokeFdTWQbZiU5rUEqB9FDi/78s6xErfcyivMGToUc5kXJqtPUwbs9s/deE/JjzeTFuqxkS2Uv+fLD0nzjyxiSynnarL9Fmi/Y6DiTzUgHhvHR8kkTKeVvyYOWLO72ZUuSFxXi1xASuO8fHVZaQfe3B/L4uQEEZo7lxheq7t39oxPQcWjd3qFFLOXbPTCskVsKfPzmuEjxek8G3+hnL1he6UWlCHe6VUSR4mvYDvvYqelyeii5SbKfM3nKDFzw04m190S/617BIw4LnynkSip/5EUfmeUmqITbXLVAHsqNvPmSLU+iHl1fbq9GyaBFbgkfD60fqCY3oS11DNfm3bIOS90DGTCxyIAAflnJ+aWbzee613qmFsDSOTVVSsy1X14GdFeiZqWdBOKXaeKOR5AtJscv8rlIUMJOwtdXt8uduIeLk+YpD2ISI8tKXpE3kqsM
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199015)(40470700004)(36840700001)(46966006)(336012)(83380400001)(81166007)(426003)(8936002)(356005)(36860700001)(47076005)(82740400003)(5660300002)(70206006)(41300700001)(8676002)(4326008)(82310400005)(70586007)(2906002)(7416002)(186003)(2616005)(1076003)(110136005)(26005)(54906003)(6666004)(40480700001)(316002)(478600001)(16526019)(40460700003)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 13:25:02.0734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54cd921f-b359-4d0c-667b-08dab10c298d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4113
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PCIe Software View of an RCH and RCD is different to VH mode. An
RCD is paired with an RCH and shows up as RCiEP. Its downstream and
upstream ports are hidden to the PCI hierarchy. This different PCI
topology requires a different handling of RCHs.

Extend devm_cxl_port_enumerate_dports() to support restricted hosts
(RCH). If an RCH is detected, register its port as dport to the
device. An RCH is found if the host's dev 0 func 0 devices is an RCiEP
with an existing PCIe DVSEC for CXL Devices (ID 0000h).

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/pci.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 667de4f125f6..a6b1a1501db3 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -48,6 +48,37 @@ static int pci_dev_add_dport(struct pci_dev *pdev, struct cxl_port *port,
 	return 0;
 }
 
+static int restricted_host_enumerate_dport(struct cxl_port *port,
+					   struct pci_bus *bus)
+{
+	struct pci_dev *pdev;
+	bool is_restricted_host;
+	int rc;
+
+	/* Check CXL DVSEC of dev 0 func 0 */
+	pdev = pci_get_slot(bus, PCI_DEVFN(0, 0));
+
+	is_restricted_host = pdev
+		&& (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END)
+		&& pci_find_dvsec_capability(pdev,
+					PCI_DVSEC_VENDOR_ID_CXL,
+					CXL_DVSEC_PCIE_DEVICE);
+	if (is_restricted_host)
+		rc = pci_dev_add_dport(pdev, port, CXL_RESOURCE_NONE);
+
+	pci_dev_put(pdev);
+
+	if (!is_restricted_host)
+		return 0;
+
+	dev_dbg(bus->bridge, "CXL restricted host found\n");
+
+	if (rc)
+		return rc;
+
+	return 1;
+}
+
 static int match_add_dports(struct pci_dev *pdev, void *data)
 {
 	struct cxl_walk_context *ctx = data;
@@ -91,11 +122,15 @@ int devm_cxl_port_enumerate_dports(struct cxl_port *port)
 {
 	struct pci_bus *bus = cxl_port_to_pci_bus(port);
 	struct cxl_walk_context ctx;
-	int type;
+	int type, count;
 
 	if (!bus)
 		return -ENXIO;
 
+	count = restricted_host_enumerate_dport(port, bus);
+	if (count)
+		return count;
+
 	if (pci_is_root_bus(bus))
 		type = PCI_EXP_TYPE_ROOT_PORT;
 	else
-- 
2.30.2

