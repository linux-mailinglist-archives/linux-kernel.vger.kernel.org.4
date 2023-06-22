Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A6073AA60
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 23:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjFVVAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 17:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjFVU7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 16:59:25 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::61c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56DA2684;
        Thu, 22 Jun 2023 13:58:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMVoVWyr3Jd8YBsZFEkPh99rGn/1loOBOxE1wwx86DJSzjYc1jwkearcT5niIwkeCMIHu6bqmGp5vIS9+J6x9ETWWMB5VenIVBuOkxFvkqyBcV75vSY0hrjfxbiF2X0TUmfrV95RrPg4PoCsJJyLrykuxSs2ZXI3/vSdlF171bdQghKVz4rgZtl5Baa9XaShrqdpyekwg772D3+2IS06q0L2fZPjAElIdpdi75veYEMqgKruCa67NfXO0NsEeXREqZlhm1uTrcyDVrp0yiSiIjb+8H9miUD1cTX39pLmlqri+1kIQK+FusjRhFoY4xnXKEt9xARQSp0X8iIDQTLT7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIiBrbF1x3fA6uozLpZ40liCTKQxjk/lyo3vYF/Xka0=;
 b=lKc7zNgSs/VCFmOFIfqeHVwieQ+0bUF1ibkQjniq4KEKGqGlTsgp/CHbSmXy3XrRTwAS5Y31huFd2uvZU75IoyDfyj/gOkWuSaehgvxcsuYqx2jNfMe1IDGOsj5MsrUOR4++DGE/2/fIcmtvslRnKRwxIem8nT5kuBKU4S31esiFifj8CGmgFxlOVRrRTRvjK5PYO8C54toCrM9KzcP32WqK4M3+LOPtuc23Zx65xmePt+97TTIHaEYbIMYS3qX7asrRswPrRXE7Qblb1YnwKaya262G7aKeJo+drEbIJkpZHup4XSbpCr+OkH84KrsTJn6PSpPWc8VJUBhuHwyjag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIiBrbF1x3fA6uozLpZ40liCTKQxjk/lyo3vYF/Xka0=;
 b=0MZaMcBCLBif8zZcopZa4gOXixyKGnB6LZ6uh8EqoEQgx31jtgPqhmZ7hsa2vkL4pZ/UJmdJynW/0G2rYl/IE3Tywvq8KIf0leuuCZXw1gs8UIcX9yzUp2O2coak8UXpdjcXrfQINqSlL0XmH0ZoWdnsSwtKZaC4zQfJp/iX0VA=
Received: from DM6PR13CA0005.namprd13.prod.outlook.com (2603:10b6:5:bc::18) by
 LV3PR12MB9267.namprd12.prod.outlook.com (2603:10b6:408:211::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23; Thu, 22 Jun 2023 20:58:07 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:bc:cafe::55) by DM6PR13CA0005.outlook.office365.com
 (2603:10b6:5:bc::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.9 via Frontend
 Transport; Thu, 22 Jun 2023 20:58:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 20:58:07 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 15:58:06 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v7 14/27] cxl/port: Store the port's Component Register mappings in struct cxl_port
Date:   Thu, 22 Jun 2023 15:55:10 -0500
Message-ID: <20230622205523.85375-15-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230622205523.85375-1-terry.bowman@amd.com>
References: <20230622205523.85375-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|LV3PR12MB9267:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d632427-6386-4782-9f3c-08db73636129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KQNpMI+6NGB7X+gudcb2RQvyjpnCVWH69Jt0vH6IZ/2heihMVYLJ/j4dJ1vYI9OXk8q9SeICFt89y5/Lrl5Gfu5w9botoJE0A76UeMOdt4fmobog7lGH0EtjR8tU4VCIzjSxZ99o9geceyF+CJEH1wUyO2w6K6TgdJD9hltWlTntt67nva/grN42h/UqP3ve+KXVDN2LAAzXgE8vyqy/zHgbF6fj6AiqaHoWFWIEk0KnCzg24TcfdJrFn6HSiBqwvsgSkdSIZ8HviIYoGz0QaEUtSp2oQ9CHvUuHfQjr76PiGdLU+Btu7Pizipt8jcMQFQxBVy/2oinTrteimUNCU+vfdVLvT8SIrl0iYJBjbn27xHC/egrhgWQpoQiwOlAVHAQoEdfl4Y+/VMjZBqqJ0y7JEgHwHK4KxQ3xuzbM7cUva1YC/zPV/4xnSCvGvQy3J7nKQlNACsx4qHI1HBieFVI/Yywyck4VOH+tm+GKcwqIOaZMYeriDDWYJisAI1Hy5qgJnjzLV2JMiL94PURD23/C+bYQb8Jgb2+ppEpwtGNBXgeb3n6/fxsY461GI9BYHvsdtrZhjWLT4pOt70Z80+9gfH69ns/eTfP1Qd8fW2cS5VSYXC7BLp3375bDPAC0ulSuK4RQV/wg0BSYpFHtOdBbAcrtGwpp2Rv1Xs3YPR9ZTpPP/UYrvErgmeRO32gT0LT6jfVkEhPbyZQG7Zb/QM+8XBDtNPQEkBN2Wvv40VR0IMQAexrcRRy22EPMofJtR/wQE2K6T71n4bSrUkdPew==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199021)(36840700001)(46966006)(40470700004)(7696005)(6666004)(478600001)(54906003)(110136005)(4326008)(47076005)(2616005)(40480700001)(336012)(426003)(83380400001)(36756003)(86362001)(36860700001)(2906002)(70586007)(82310400005)(40460700003)(16526019)(186003)(1076003)(26005)(82740400003)(356005)(81166007)(316002)(70206006)(41300700001)(8676002)(8936002)(5660300002)(7416002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 20:58:07.1037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d632427-6386-4782-9f3c-08db73636129
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9267
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Richter <rrichter@amd.com>

CXL capabilities are stored in the Component Registers. To use them,
the specific I/O ranges of the capabilities must be determined by
probing the registers. For this, the whole Component Register range
needs to be mapped temporarily to detect the offset and length of a
capability range.

In order to use more than one capability of a component (e.g. RAS and
HDM) the Component Register are probed and its mappings created
multiple times. This also causes overlapping I/O ranges as the whole
Component Register range must be mapped again while a capability's I/O
range is already mapped.

Different capabilities cannot be setup at the same time. E.g. the RAS
capability must be made available as soon as the PCI driver is bound,
the HDM decoder is setup later during port enumeration. Moreover,
during early setup it is still unknown if a certain capability is
needed. A central capability setup is therefore not possible,
capabilities must be individually enabled once needed during
initialization.

To avoid a duplicate register probe and overlapping I/O mappings, only
probe the Component Registers one time and store the Component
Register mapping in struct port. The stored mappings can be used later
to iomap the capability register range when enabling the capability,
which will be implemented in a follow-on patch.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/port.c | 27 +++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 679226023f0c..43ffecebf1d8 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -688,6 +688,29 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
 	return ERR_PTR(rc);
 }
 
+static int cxl_setup_comp_regs(struct device *dev, struct cxl_register_map *map,
+			       resource_size_t component_reg_phys)
+{
+	if (component_reg_phys == CXL_RESOURCE_NONE)
+		return 0;
+
+	*map = (struct cxl_register_map) {
+		.dev = dev,
+		.reg_type = CXL_REGLOC_RBI_COMPONENT,
+		.resource = component_reg_phys,
+		.max_size = CXL_COMPONENT_REG_BLOCK_SIZE,
+	};
+
+	return cxl_setup_regs(map);
+}
+
+static inline int cxl_port_setup_regs(struct cxl_port *port,
+				      resource_size_t component_reg_phys)
+{
+	return cxl_setup_comp_regs(&port->dev, &port->comp_map,
+				   component_reg_phys);
+}
+
 static struct cxl_port *__devm_cxl_add_port(struct device *host,
 					    struct device *uport_dev,
 					    resource_size_t component_reg_phys,
@@ -711,6 +734,10 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
 	if (rc)
 		goto err;
 
+	rc = cxl_port_setup_regs(port, component_reg_phys);
+	if (rc)
+		goto err;
+
 	rc = device_add(dev);
 	if (rc)
 		goto err;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index fe95f08acb69..37fa5b565362 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -547,6 +547,7 @@ struct cxl_dax_region {
  * @regions: cxl_region_ref instances, regions mapped by this port
  * @parent_dport: dport that points to this port in the parent
  * @decoder_ida: allocator for decoder ids
+ * @comp_map: component register capability mappings
  * @nr_dports: number of entries in @dports
  * @hdm_end: track last allocated HDM decoder instance for allocation ordering
  * @commit_end: cursor to track highest committed decoder for commit ordering
@@ -566,6 +567,7 @@ struct cxl_port {
 	struct xarray regions;
 	struct cxl_dport *parent_dport;
 	struct ida decoder_ida;
+	struct cxl_register_map comp_map;
 	int nr_dports;
 	int hdm_end;
 	int commit_end;
-- 
2.34.1

