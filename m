Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551C070E98A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 01:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238813AbjEWX1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 19:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238808AbjEWX1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 19:27:51 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061c.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::61c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B76BE4C;
        Tue, 23 May 2023 16:27:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mud3zGYNeCwoauo5OEi99cnYP9p0TE9JGaNGQ2jGMJ0oH4vuhEZQFwOymYHOanJC+EXWUhNcuJkqBAa1lTdh1RNw2LoczDOH4tbj3Zd8fw6bxyhifMD0cGEI+RS08AppIDb/mG7IHGCix2xPsTRMChmVQ6gn1/agWBDD4iZiy0LLizQywp+BJzTkpiZVoHQ9jYsYhQu5X7s+0gcWMxixAQ5k4fjcEIY16NoIVvkVIkN7SEKe9rB1B0yi4UNrmpLJ1K7dM5h1TZt9Jf560EUxjWnMlkbNSyK2u11mOyUVuBTPsAkWxGUAMA4cSravCjir2Z6BLhjvn1I0QMihysMaOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAqq3iXHd2I7qAZR/a5UvjK88TLWG22R0HI+vDe8HSU=;
 b=IN7wHDbALa+zXruPCWzUt8Z43loFeEhUN1SiIkYgf4c+aHEpjVMHh+KMqD3AxE4gbkiIdOwW4mUKT9DXfzzYAGoOpe9NtJ+Yn5SHkOWCA3/gspG8L8D/Gl93RCeLwUT9xDDXV6K7ny9GTEN6kW4qi8OV5yhGKxnSNKCi/ZnM2qR+uhv0AFS/3if+fybaOKKu6EGSf+ihkGeSy9z3I9RnVA8RlgMvmme0Ts62K+IQTUQMft8DlVSpPUshwnxtEeGmQOXHzKybkXFit1s9brVvG26X+EQuUndzQyAqesbvoVLbZgWIFWT6ezdRNvzKmWzWu4btgh2yEsPKhJAXgZ/o+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAqq3iXHd2I7qAZR/a5UvjK88TLWG22R0HI+vDe8HSU=;
 b=Hg7xwdnaIPyosgruoQnxeWyXcJvYEVeYaCGxtUd1sGFQgrS5cbgcDo0oOV4fZky52OmUisUVilCibzbdbA5nqh3tclmDbLM/s7Se5AcFgHjLyoGTajwn+vOnuP8W2mZx0eiZqWU7ERBQAbMDrnCPoP+5xesK9pnCGHhP2fO39xQ=
Received: from MW4PR03CA0047.namprd03.prod.outlook.com (2603:10b6:303:8e::22)
 by BL1PR12MB5045.namprd12.prod.outlook.com (2603:10b6:208:310::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.14; Tue, 23 May
 2023 23:26:41 +0000
Received: from CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::a4) by MW4PR03CA0047.outlook.office365.com
 (2603:10b6:303:8e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29 via Frontend
 Transport; Tue, 23 May 2023 23:26:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT071.mail.protection.outlook.com (10.13.175.56) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.30 via Frontend Transport; Tue, 23 May 2023 23:26:40 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 18:26:39 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v4 20/23] cxl/pci: Prepare for logging RCH downstream port protocol errors
Date:   Tue, 23 May 2023 18:22:11 -0500
Message-ID: <20230523232214.55282-21-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523232214.55282-1-terry.bowman@amd.com>
References: <20230523232214.55282-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT071:EE_|BL1PR12MB5045:EE_
X-MS-Office365-Filtering-Correlation-Id: 782adad0-6b3c-41cb-bce1-08db5be529c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G5PkcTSKK7mB3vqLqZ0mZ6ey+RQ47ooSaBTKvN8MVqw87AwiZ1NE7tU9DkVEgs4xHnst9fs1VusdhASyuX54tTU8X/a0AyoBOa0g2T1i1aENytyqBA8fKsBmuZ/LRrMiT8x30pN0IgFPJJqZ2VKCZWdqMvDwFOJ6UuGTFtFFxMhRkKK1gL8v0jSbQMcTkjJZ1VqvkiZIuZn7+lS3sSO0W4Wgu85vVVrvpW7Tck5lc6fI2CXwopUvlU51mM1IjbLXputLIBj3niXS9VJLsQQXlpaa2R76dldQ0/t9QzmDxJsQEJ6Cs5qi7XzSS5eW3hNj57MQq0ENiy8cbiOStCIGWsUoi31yjkdEmFoUcmuJZjSDwusVcmgYXn/UtQM21cHOSlRN0936uWw+sWxAbxTFIDieKkKdShHGv8URrSLU/GSVjAaERaaOduIbF1QLQvlbpKrKdNw1ywJaXz7vmlC8JkYDswB5N4jMfv3l1Q/KYMewAb0zkJkSSFQi5IX1j5ymMab07AEEmBUN8K5HXkngVYqh2wSXzKAKHVJlqWDW9lleWZUjQeXcyzzQAT0Xk8ZGp849BtPdvJ6LknEgcfGnReNMxb4lO8LehZwzxIEiI/kUf9/zEv78b+pmW7VKoJ2tgvwtxt9EdBnbBFhi6h4KdzJ9UOs7Vn2zAvA0xvNkfRWdy7JhwoNhm1cGEiOL7FhOMVjHhUIy9lBVrB/3w62vLaoM4J7RE+GNaaf28nHWyrwIC3RBUtlMA9rioANl6+Z63r+6LE+SI74CWIdBlkp4tA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199021)(36840700001)(40470700004)(46966006)(2906002)(44832011)(7416002)(5660300002)(82310400005)(8936002)(8676002)(83380400001)(40460700003)(41300700001)(36756003)(4326008)(54906003)(110136005)(316002)(70206006)(7696005)(70586007)(478600001)(40480700001)(6666004)(426003)(336012)(2616005)(26005)(81166007)(356005)(1076003)(82740400003)(86362001)(36860700001)(47076005)(186003)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 23:26:40.8376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 782adad0-6b3c-41cb-bce1-08db5be529c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5045
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The restricted CXL host (RCH) error handler will log protocol errors
using AER and RAS status registers. The AER and RAS registers need
to be virtually memory mapped before enabling interrupts. Update
__devm_cxl_add_dport() to include RCH RAS and AER mapping.

Add 'struct cxl_regs' to 'struct cxl_dport' for saving a unique copy of
the RCH downstream port's mapped registers.

The RCH contains root command AER registers that should not be
enabled.[1] Disable these to prevent root port interrupt generation.

[1] CXL3.0 - 12.2.1.1 RCH Downstream Port-detected Errors

Co-developed-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/port.c | 64 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/regs.c |  1 +
 drivers/cxl/cxl.h       | 11 +++++++
 3 files changed, 76 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index d147f08780d0..80c643254b86 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -8,6 +8,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/idr.h>
+#include <linux/aer.h>
 #include <cxlmem.h>
 #include <cxlpci.h>
 #include <cxl.h>
@@ -940,6 +941,63 @@ static void cxl_dport_unlink(void *data)
 	sysfs_remove_link(&port->dev.kobj, link_name);
 }
 
+static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
+{
+	void __iomem *aer_base = dport->regs.dport_aer;
+	u32 aer_cmd_mask, aer_cmd;
+
+	if (!dport->rch || !aer_base)
+		return;
+
+	/*
+	 * Disable RCH root port command interrupts.
+	 * CXL3.0 12.2.1.1 - RCH Downstream Port-detected Errors
+	 *
+	 * This sequnce may not be necessary. CXL spec states disabling
+	 * the root cmd register's interrupts is required. But, PCI spec
+	 * shows these are disabled by default on reset.
+	 */
+	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
+			PCI_ERR_ROOT_CMD_NONFATAL_EN |
+			PCI_ERR_ROOT_CMD_FATAL_EN);
+	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
+	aer_cmd &= ~aer_cmd_mask;
+	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
+}
+
+static int cxl_dport_map_rch_aer(struct cxl_dport *dport)
+{
+	struct cxl_rcrb_info *ri = &dport->rcrb;
+	resource_size_t aer_phys;
+	void __iomem *dport_aer;
+
+	if (!dport->rch || !ri->aer_cap)
+		return -ENODEV;
+
+	aer_phys = ri->aer_cap + ri->base;
+	dport_aer = devm_cxl_iomap_block(dport->dev, aer_phys,
+					 sizeof(struct aer_capability_regs));
+	if (!dport_aer)
+		return -ENOMEM;
+
+	dport->regs.dport_aer = dport_aer;
+
+	return 0;
+}
+
+static int cxl_dport_map_regs(struct cxl_dport *dport)
+{
+	struct cxl_register_map *map = &dport->comp_map;
+
+	if (!map->component_map.ras.valid)
+		dev_dbg(map->dev, "RAS registers not found\n");
+	else if (cxl_map_component_regs(map, &dport->regs.component,
+					BIT(CXL_CM_CAP_CAP_ID_RAS)))
+		dev_dbg(dport->dev, "Failed to map RAS capability.\n");
+
+	return cxl_dport_map_rch_aer(dport);
+}
+
 static struct cxl_dport *
 __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 		     int port_id, resource_size_t component_reg_phys,
@@ -994,6 +1052,12 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	if (rc && rc != -ENODEV)
 		return ERR_PTR(rc);
 
+	rc = cxl_dport_map_regs(dport);
+	if (rc && rc != -ENODEV)
+		return ERR_PTR(rc);
+
+	cxl_disable_rch_root_ints(dport);
+
 	cond_cxl_root_lock(port);
 	rc = add_dport(port, dport);
 	cond_cxl_root_unlock(port);
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 045abc11add8..b34f9e04cae4 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -198,6 +198,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 
 	return ret_val;
 }
+EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, CXL);
 
 int cxl_map_component_regs(struct cxl_register_map *map,
 			   struct cxl_component_regs *regs,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 6134644b51f8..0e0bcbefefaf 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -209,6 +209,13 @@ struct cxl_regs {
 	struct_group_tagged(cxl_device_regs, device_regs,
 		void __iomem *status, *mbox, *memdev;
 	);
+	/*
+	 * RCH downstream port specific RAS register
+	 * @aer: CXL 3.0 8.2.1.1 RCH Downstream Port RCRB
+	 */
+	struct_group_tagged(cxl_rch_regs, rch_regs,
+		void __iomem *dport_aer;
+	);
 };
 
 struct cxl_reg_map {
@@ -255,6 +262,8 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			      struct cxl_component_reg_map *map);
 void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 			   struct cxl_device_reg_map *map);
+void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
+				   resource_size_t length);
 int cxl_map_component_regs(struct cxl_register_map *map,
 			   struct cxl_component_regs *regs,
 			   unsigned long map_mask);
@@ -603,6 +612,7 @@ struct cxl_rcrb_info {
  * @port_id: unique hardware identifier for dport in decoder target list
  * @rch: Indicate whether this dport was enumerated in RCH or VH mode
  * @rcrb: Data about the Root Complex Register Block layout
+ * @regs: Dport parsed register blocks
  */
 struct cxl_dport {
 	struct device *dev;
@@ -611,6 +621,7 @@ struct cxl_dport {
 	int port_id;
 	bool rch;
 	struct cxl_rcrb_info rcrb;
+	struct cxl_regs regs;
 };
 
 /**
-- 
2.34.1

