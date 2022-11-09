Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1006228BD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbiKIKmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiKIKl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:41:56 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2065.outbound.protection.outlook.com [40.107.102.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3A1222A2;
        Wed,  9 Nov 2022 02:41:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Skqh2ro1lyYt/n/IT5XzZ92Cb/KdU5qOxprqrC1z+2kKGfPTYHFjgnVlIDBWylfU+eht2K3jSu0Fd/JQMf+bCrvgNOuhwy2LrvzN+C4IvkYpiH1kJ+34wTm4OcU+e0j+VW1oD3g8vSHSBSds+kQRKqqUi08xqML39EWI5ljiEm1em9pQHiJbiEKMNjISpqgn2yWIfbY0lUyCakq+jYZAXSt5NiPJ+3yfKsF9d/gXM52r2NgP6bSoHb2stjyy1KvF0HlpdBsotvE6Ap01MfFhxdwiPsauf3PwrBGvCpOQ74RTyBmXsmy/HnQDLCDWNF5hBdT7jij7RqXw31fp8Ew79A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSlDXWGvidoCnzrNcuYQ6HS9PF/UoFr07bBjgjNrfXs=;
 b=FqOr4sSUl9yS2KZx8xfdPkUo8+Pftp7K0RlMiifiewqkN+nFSZJqZ885OfZ7I6hdEdsASbcAYvI2pU2bNjw5OR5JTyqt8Aq2WTk2qjSVeTGOR+3k9BNJO6EziaIArnd+/82kTZh58O4vDdzVivVd7eEbfv9ftbhBVUqj6tg8MIKuOe2rO9lViHcsKkLaPXlstmBM2AargCWwYx90aYaaoKjea7U1Q803aeIh2Uloc6RSOH+s4tgwC5uNTE2FALGewyOR2ft7XSYvNBTrvM7SYtVxAuaDBiCTPVWsGTAzdMmnIo6QwtCeVIJxYdPUK7Lg4J1YAI3KvfVOcfN1M2YNdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSlDXWGvidoCnzrNcuYQ6HS9PF/UoFr07bBjgjNrfXs=;
 b=uvGKs8Gxtarg4rtxIMvXQQRMOX/VcLw61lVGHH3vRoS0Oq4hYFvvUV8Q59yJW4EX8iwIJAUDTB5UBbdp149Nc23TTpPB2KW6j3jKfrMhAaPBEPLI+FX2Ds3FA0OLVpyVEFlzHlRDG8hBiHhYY5AjfZI+HiQvCBfU8TQnMIo+2eU=
Received: from BN0PR04CA0088.namprd04.prod.outlook.com (2603:10b6:408:ea::33)
 by DM6PR12MB4481.namprd12.prod.outlook.com (2603:10b6:5:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 10:41:45 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::cb) by BN0PR04CA0088.outlook.office365.com
 (2603:10b6:408:ea::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 10:41:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 10:41:44 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 04:41:41 -0600
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
Subject: [PATCH v3 8/9] cxl/pci: Extend devm_cxl_port_enumerate_dports() to support restricted hosts (RCH)
Date:   Wed, 9 Nov 2022 11:40:58 +0100
Message-ID: <20221109104059.766720-9-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT031:EE_|DM6PR12MB4481:EE_
X-MS-Office365-Filtering-Correlation-Id: 0287038a-b35f-4394-b974-08dac23eff06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lEsqxFwAYunNQNz5kz9lhhq6GukyPJ3BoB8+i+cC4Cj6HdX9JooaRTJzpNM68r71lXzVK5knrM7mHI5gvK9fAEY6jTYu5EaEvBbxLirPm/kDmIkFywkhcAkX6pmgahWPdvKcW3XFlY5YGk3pvN+pJZibRe2KycBFOwJM0+Osi9hrPxafkZ7V34fMMbTJVLRS15vdy3e8yS3n3gb0nAvrExpycrkS/zOm8NYtY86goCj2LDO5yIyM3HX/sMqj1N71xGhSYgJtA3tYvXvPNiVNaF4HSvcbCSDlWlsTwxvJco7WwcGL6vdvLRAAKP5Ki5pPWz81TPHHiQKn0XKHb2Vg8QRVstfxXmVVzNRW4Mdhuusog/JYdRlzI7Z/3zGZ+3jUWIL24j2muQ5oPZj5C+nOlgvxCWpvC4lcgs48sfBlMhB7ZEI2/hxCKVundMtrH3x/JyoBC4+hM/wm1VjfRdmM5V7U7zRx0uYCTAOjLTcM0MhUrRLQ6XXsIiG4nGzveATg/PSb403XhVXRrEP0VGvpbpFUTTq/KN0uHpLKxvAs7yU7ur2Z1cJs5z0mWfPl45Y+5gAeTJZma9eNLyzIJWl5LSSDyFQOxal1sL6Wmed4c/PdsrnyNcHwywuCQx9V/S2oVWd7DtCuQ0pDwH1LcKmIsVyYCGnIH7+hIZeESh3JI6Z67xjvYESUvGn1snDcPwRL6gvfR/VxOZTHBoQzHt1XXycnDNOVHcQ+ebrVr2Y3DuVTbjnM0HWfvSe9o8Pi++xjrIJovv3zwpB4Y6KiqQ/U2c5siCTuwAVnosZKMCQdWAa/vhDblSFFg0JsQYir+WdG
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199015)(40470700004)(36840700001)(46966006)(83380400001)(47076005)(426003)(40480700001)(2906002)(478600001)(81166007)(356005)(40460700003)(36756003)(82740400003)(336012)(82310400005)(36860700001)(26005)(1076003)(186003)(2616005)(16526019)(4326008)(70586007)(316002)(8676002)(70206006)(41300700001)(54906003)(6666004)(8936002)(7416002)(110136005)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 10:41:44.8269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0287038a-b35f-4394-b974-08dac23eff06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4481
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

