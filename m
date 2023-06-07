Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663F4727178
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 00:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbjFGWUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 18:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjFGWUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 18:20:16 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917F02729;
        Wed,  7 Jun 2023 15:19:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEKhbnNPATSbS0sHSt3RaawTEENVcpKN6qJ1yJboI1qhFzwXwoIplTIX6skZzBXibeCRz8CxcuxyMM0E4aCalHaPhdSqrYjUO9G4HpWAHw8dikNGgNo9sGWGJZ50NqRjrUjs5DEb5pXlYHsaiSJF4z/2mYe0FI0SJxCptVYUE+RhyqyK574iiZTyeSsWtbkfccmTiCyHoWCHHqGKUHIwuhdbCcw98Rv+V2Fvs3gwGXZvCULFVkcCH9byAqJGmQH8Cu030DnpGHs2+MiF5FjBy0XNvmKukXKhDanWOskT/ziZV8jIcSKpF7TvZ14e88hofj0qOcJKj6M39DNYQvcF1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RgzAN5g3xKRwEG5lxS5xu9UA0u9rn6FBInBgoDYH2jQ=;
 b=nZu/dJ4QOj9G2dXg3oyQCQtG20AlbPE0n1jWmRLfmSsmspP/3sR5u5thstqbQixiNMtMIY/3Xe9iqIOYxMnAl1IirtNddLA8Q0xF8TOtUEmp4MSShIV+p0HcV50V9u6UcTRJdyiwlA0ZyUItxS8IaATY1LAi2rnuNEL8IafYR8wn4LryzdqAZINA8C3A9s5KnKGhAFq4sBbnxDLr/hC9Cx+VYYF/QUuOMxMc4wypvKD2CjDnuKb/NppLHOk0B22TAGc7Zalhj6GeHdx0y1CNtG0pknEGA024JA1PRfAn/4kwbjtKkrINOqEwgnmdeOuv3elubsSTqsUurTkIT1AOGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgzAN5g3xKRwEG5lxS5xu9UA0u9rn6FBInBgoDYH2jQ=;
 b=3z0AHjG1AWL9j0A5D6G09bcd8USiKBouHchZak7g48uW3+d3afyF01SkKh1ql9o15G+HFyH8aw46GogygdCyx/CXvh0WheetucFdV5q3GJcE7V21hByuxjG0oHn3T/BScQiUQzXaKpYiEMaBOs+apHeum/jtLV1ywLMoQIVFuBw=
Received: from SN7PR04CA0036.namprd04.prod.outlook.com (2603:10b6:806:120::11)
 by CH3PR12MB8510.namprd12.prod.outlook.com (2603:10b6:610:15b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 22:19:18 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:120:cafe::5c) by SN7PR04CA0036.outlook.office365.com
 (2603:10b6:806:120::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 22:19:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 22:19:18 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 17:19:17 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v5 12/26] cxl/port: Store the port's Component Register mappings in struct cxl_port
Date:   Wed, 7 Jun 2023 17:16:37 -0500
Message-ID: <20230607221651.2454764-13-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607221651.2454764-1-terry.bowman@amd.com>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|CH3PR12MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: 18af4236-ba0b-4ec1-d925-08db67a53c67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IjbcA7rPXdNUc/a4ZBY4InS1JogKjUzKiyd6+1K2Z+OwxRVPLauptVyT+/Kv56UIGF/Bp790GcRVgxAdfAXlHFnM8cUtduS1WaT32bruTpuKlcI9JVR+EW0ZeoTsQqdB2Wc+FX60WpFpzl3rVlSOPQblJy4LORdhJFdHwXeYdgL1Av3qYIPGMigkmiXZx61KZ3k2QnaF0j1wdLu4qSnuT0M7tqgD0tHJ0uIA5qatJy0TL0eEfi6+dO1Xdq75XsnNUHRorya7+v8P6sHehThy7fUe+AmaLgwHoHAdIpe5t4ByeRD5BbYwBI1DZ977aI7iAIktOHHtBbz79A0+CoNfxVsw3NYfwFXWlebgRCQqAW6lGnMIqxCCXJUq3Q1iKKPD1fXpmrwb9kDrqqwPpLKDlpqQfEFMiQEU+yiojvWWy4Mj72X19A0I98v7XeVJzBs27hZWhXE+TGdrr2yQO2CEm6nt5TpCShq24t3crBs/p2EHlPMPHQzMSUhOooQz/bk0uXlkoWoYzA/KNeQql0w8ra6SWz+pVyZdYDSBeoda4MGOyYOJSNRk+rkrAyE7EwBe4izUcKHWDFIK4iJW6lLh4NfiVS/FsIi4hOqNnDUSovMaQP6zZ2FWN6rntN1Bb+Wtk8rOXJyfIN+u9QOJNz/2SnFzF6LhetKXYDoU8ZeRR0bG9E5SFk4T7F5OeshenGN5hIveTsh09Rbv2+zimlyeeFVp8y5DhkgKYnITCxfKs8ePhj2oEMkxpEj35TVWVF5nEoopFDH5mAwh6LazwmOwBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(54906003)(110136005)(40460700003)(478600001)(40480700001)(44832011)(8936002)(8676002)(7416002)(2906002)(36756003)(5660300002)(86362001)(82310400005)(4326008)(81166007)(70206006)(70586007)(356005)(82740400003)(316002)(2616005)(1076003)(41300700001)(16526019)(47076005)(26005)(36860700001)(186003)(83380400001)(7696005)(6666004)(336012)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 22:19:18.3291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18af4236-ba0b-4ec1-d925-08db67a53c67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8510
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
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
 drivers/cxl/core/port.c | 33 +++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |  2 ++
 2 files changed, 35 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 8b688ac506ca..305125b193ce 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -686,6 +686,28 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
 	return ERR_PTR(rc);
 }
 
+static int cxl_setup_comp_regs(struct device *dev, struct cxl_register_map *map,
+			       resource_size_t component_reg_phys)
+{
+	if (component_reg_phys == CXL_RESOURCE_NONE)
+		return -ENODEV;
+
+	memset(map, 0, sizeof(*map));
+	map->dev = dev;
+	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
+	map->resource = component_reg_phys;
+	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
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
 					    struct device *uport,
 					    resource_size_t component_reg_phys,
@@ -709,6 +731,17 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
 	if (rc)
 		goto err;
 
+	/*
+	 * Some components may not use capablities or their
+	 * implementation is optional. A component register block may
+	 * not be present then and component_reg_phys is therefore
+	 * unset. Instead run the check later when setting up the
+	 * capabilities.
+	 */
+	rc = cxl_port_setup_regs(port, component_reg_phys);
+	if (rc && rc != -ENODEV)
+		goto err;
+
 	rc = device_add(dev);
 	if (rc)
 		goto err;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index e5ae5f4e6669..c76e1f84ba61 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -552,6 +552,7 @@ struct cxl_dax_region {
  * @regions: cxl_region_ref instances, regions mapped by this port
  * @parent_dport: dport that points to this port in the parent
  * @decoder_ida: allocator for decoder ids
+ * @comp_map: component register capability mappings
  * @nr_dports: number of entries in @dports
  * @hdm_end: track last allocated HDM decoder instance for allocation ordering
  * @commit_end: cursor to track highest committed decoder for commit ordering
@@ -571,6 +572,7 @@ struct cxl_port {
 	struct xarray regions;
 	struct cxl_dport *parent_dport;
 	struct ida decoder_ida;
+	struct cxl_register_map comp_map;
 	int nr_dports;
 	int hdm_end;
 	int commit_end;
-- 
2.34.1

