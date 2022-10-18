Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DD2602CDD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiJRNZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiJRNZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:25:08 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6998522B1C;
        Tue, 18 Oct 2022 06:24:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8qDgr9W5c5nuqUsGeqEl/h/OZMvFmq/BejYIkBoB3u1KgaX/CW9OKz7YVHZg3nds22/ieeGisLZ+bN3/Cx1uMz5/HGOwFYytIMqQBha2iBxII+VV8psXaxh/ho0FncFa+Lvs0uXzZTZtQgXDIbjH/dQH90kfVE4zTHH209Du6sp+RtubEoOIOAB5f9RlC6teDMnIF+b5bZEbNxb+ZpmuF1fEjOPibUUBcha3gJiZAgbb7EA5B+OrKMuIOwJAY+v7tk1UWrZ/e0e7tZqbyK0n6ALZkwA75ZOVs/jhOxEVF0nUu5a/o0961NZtOmBcLQJyqR5tL9coH4bfOqVR+drBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/hKkrxafFtc9IpK9px5m8cyyUbCJBZGiYZhwWSJUc8=;
 b=MT03qCk+OCyKqaV/DE3kypo/nPcYKJnOJC/Y+o5sZNN+E3dk0iJe1uJV/cujBLPl0J1XAIq4ZPUm4nUTOg4qwkcXO5qNPmtdZ6hoRDWrpyuBhbRsia/FNU4YMS0v/bwnEV9MNeeN7DoPukRpX5Kx3Mi153VgTLqK8Onzfwo3cQyb6SutRka3NNAfP0FWzr0RUDoH5YJ8uieBGIvUNadM5GnD8ku3SyTfKVZ7le6UhfovqR3/sN3VDGCcvh7SqdTQbApuKAkgDeZRVnc3cS3QJMMZZOKGF56z4QfCONYtrgbYQWTPcE2P7cDjlrXp++K9TZol4ilMf1ouXzqwHOaNmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/hKkrxafFtc9IpK9px5m8cyyUbCJBZGiYZhwWSJUc8=;
 b=XEs6srevGB8rHWZtPIipvD/UuE/KEIuz35zAiBJgbJB+4fGwIlNGX/2TYL9fzuOkZjnV+di7UhA4wKkd7vWuS7LJ5PjxJDQPnNiNAebDxsMR5nZUmN1r3U/0qdNAVZDyzG4xEe1sP2Q34Ki1TT9cg53W08mak2o2H6HSdZZG66s=
Received: from BN7PR06CA0066.namprd06.prod.outlook.com (2603:10b6:408:34::43)
 by PH7PR12MB6633.namprd12.prod.outlook.com (2603:10b6:510:1ff::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 18 Oct
 2022 13:24:31 +0000
Received: from BN8NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::8d) by BN7PR06CA0066.outlook.office365.com
 (2603:10b6:408:34::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34 via Frontend
 Transport; Tue, 18 Oct 2022 13:24:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT098.mail.protection.outlook.com (10.13.177.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 13:24:31 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 08:24:28 -0500
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
Subject: [PATCH v2 09/12] cxl: Extend devm_cxl_enumerate_ports() to support restricted devices (RCDs)
Date:   Tue, 18 Oct 2022 15:23:37 +0200
Message-ID: <20221018132341.76259-10-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT098:EE_|PH7PR12MB6633:EE_
X-MS-Office365-Filtering-Correlation-Id: 32af808b-a9af-4e45-f158-08dab10c1751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uakOhso2KtVFaqdyH1pcMOhWGYgnpVyrvUVkbAw2bx78JfBjpXz+MNuU8GAPbJfBVYrPpBrtn14AtgGj6LPUslnVyT5HXXwi5b98OB4ErTNqIM5GDZwvND65ngFLYMHCgiTT5U8gYC9uSwa1BiI5CZYHMaORcUC6X3kWObM0tMtzSTMrHOB+lHS10J19ipes/XmzyIE6grfL2qovDkdueSZB1D+VgD2PTdlDrigkjyvhbaJHCDGM20u/V7pZ/+ky4Ac80AC9KmgIkSQ2Uwve6L1oSO0gHa5IdmPN26Y98ZJK1uiNxM2LkUKrTzKso9vHSuGtDZEWseTfjxWn6paNGc524ue3Kqz1AFW/DmGwDhRCbZtDM90dk+/5v3d86Ff1KlIi71nobrJcncaDseEqvnd2hT0eJTLoC1psPIoowC6FSjqQGYz3BTlO6oU03sfP73uAbfakIa20ZFLnHkA2ozKgxVHvjjl7cmumOxiAU6VnCa5/n8r4wccf0k/7kbcaQwK2EVJMlTlazQEHaIy3rL0UlbITMli1w+NnQZNmHmHCR3xGbmZwCQZQ6fNlxe0JEQMLlfzm5mtpvKu8wt7iMP/K7arjdAvBsSjhYYCHGI1jg2VmpJ/YS+fFXj0hif3G8O3w7TvIuHQ7u27XHzcpGksXr/xpdEwu+MND0RZzkguTf0Al5J+vS3iEJj85M6N0Kr6r/7eXdiBmdQvZpV1jaIu/TJpLgdQI5XheDR8lCzmF7cuJH0NT53BwApaYWWVmyzdiA3bpZUK5IndjJ8NgoXudPo//1AOJ510IJL1U7tVVMJZSTa3MxFcOpv1hZf8f
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199015)(40470700004)(46966006)(36840700001)(82740400003)(81166007)(2906002)(40460700003)(356005)(8936002)(5660300002)(7416002)(70586007)(41300700001)(70206006)(8676002)(4326008)(36860700001)(316002)(54906003)(83380400001)(110136005)(186003)(16526019)(40480700001)(82310400005)(426003)(36756003)(1076003)(47076005)(2616005)(336012)(6666004)(26005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 13:24:31.4847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32af808b-a9af-4e45-f158-08dab10c1751
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6633
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

Extend devm_cxl_enumerate_ports() to support restricted devices
(RCDs). If an RCD is detected all to do is to search its corresponding
RCH's port and attach the EP to it. Update cxl_mem_find_port() for
proper removal of the EP in delete_endpoint().

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/port.c | 45 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 4b15481426f7..35f8fa98904e 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1384,16 +1384,56 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 	return rc;
 }
 
+static inline bool is_cxl_restricted(struct cxl_memdev *cxlmd)
+{
+	struct device *parent = cxlmd->dev.parent;
+	if (!dev_is_pci(parent))
+		return false;
+	return pci_pcie_type(to_pci_dev(parent)) == PCI_EXP_TYPE_RC_END;
+}
+
+static int restricted_host_enumerate_port(struct cxl_memdev *cxlmd)
+{
+	struct device *dev, *dport_dev, *uport_dev;
+	int count;
+
+	if (!is_cxl_restricted(cxlmd))
+		return 0;
+
+	/*
+	 * The cxlmd is an RCD, the dport_dev of it is the PCI device
+	 * and the uport_dev is its host bridge which is the parent of
+	 * the PCI device.
+	 */
+	dev = &cxlmd->dev;			/* cxlmd */
+	dport_dev = dev->parent;		/* pci_dev */
+	uport_dev = dev->parent->parent;	/* pci_host_bridge */
+
+	count = find_port_attach_ep(cxlmd, uport_dev, dport_dev, dev);
+
+	/* If missing the host is not yet ready. */
+	if (!count)
+		return -EAGAIN;
+
+	return count;
+}
+
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 {
 	struct device *dev = &cxlmd->dev;
 	struct device *iter;
-	int rc;
+	int count, rc;
 
 	rc = devm_add_action_or_reset(&cxlmd->dev, cxl_detach_ep, cxlmd);
 	if (rc)
 		return rc;
 
+	count = restricted_host_enumerate_port(cxlmd);
+	if (count < 0)
+		return count;
+	if (count)
+		return 0;
+
 	/*
 	 * Scan for and add all cxl_ports in this device's ancestry.
 	 * Repeat until no more ports are added. Abort if a port add
@@ -1445,6 +1485,9 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_ports, CXL);
 struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
 				   struct cxl_dport **dport)
 {
+	if (is_cxl_restricted(cxlmd))
+		return find_cxl_port(cxlmd->dev.parent, dport);
+
 	return find_cxl_port(grandparent(&cxlmd->dev), dport);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_find_port, CXL);
-- 
2.30.2

