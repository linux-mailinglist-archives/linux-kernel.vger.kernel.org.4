Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E09E70E982
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 01:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238761AbjEWXZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 19:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238786AbjEWXZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 19:25:36 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E149E1AE;
        Tue, 23 May 2023 16:25:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEAsfUkUA6cvASq7GrCsW2CflNRwq4Q6vvGloSRlIpAnHHS/PnC67ElDuwNYKUbjsTFNXOF+Gqm/FMixeyhd3MqBFlZKn0WBXqNTqt47k+eXfj7nAur1SdWGqNdHhWOjTBLZm/PPdtbcXbzAb1MdapJ7uQHNJfVZhdamgKTP1fywPM7Bwsf1ar/mitdtJE9DtxgJpBrwpUHP2OdSyItXc43GN4EF2NniUFY9TjmViNhfoYg4dE1ZHHnUi2wvtWvpXgIgVY9Ea2mncNQfXXpkGbfR3uunugCZh7iIRABpmyJGGXiNt0DnnnUWcQvRBXsmZM1Y7Yy8is6i1edeqqZtDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cnl+zAtd9pm6BxzOP/0cGIt0UtoAVtgJAnzduopQCp4=;
 b=TeKpA7r04xBXcFlkPxP9OQq/4XeqfcUJynA8BLP7KoOSTj/5N2MJnp8a+6feZf7VQdcinuNFonlNlhP7BlwE0HZpvrrdD1Z9AG5y8VaDVXyj2l4c1d05nHt3d6dJzQ2GVIANoj7LS/VqmIRpSMXoBH5+PhQwHcyzTEsyV/Q7ifn4rJM8dN6EH7dAVCCQABYpA8kUo5OPj7HPofDWHvVilTIY+ClXOkOC8aBC4ZTlUAcfFQHe/lfJPWeQWZuS0X5uGxQPcbnc8dzdkz25jdJKbx+KJkrkI0Czkt+jR54MWCMKPDLxi5Ktmt+dHASPTaK2OH6Z0aunPUajZZL0I6N3gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cnl+zAtd9pm6BxzOP/0cGIt0UtoAVtgJAnzduopQCp4=;
 b=YtUxkYxea2y+R7sTPfDHVl9P97caezI6CyyQ/fvJmUVcJGuYRa3nl2XAl4vqbAcG674+KLxz/maD7qAlvFPF/F0UXcq3Kp5o4W74sI0qiTjH0hd8xc0M0KVpe/UiLIs15wl+brpC7h3Lq9Pkne0aysTJ2QUJhTWT1fJoDKQckGM=
Received: from MW4P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::26)
 by SA1PR12MB6678.namprd12.prod.outlook.com (2603:10b6:806:251::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Tue, 23 May
 2023 23:24:52 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::18) by MW4P221CA0021.outlook.office365.com
 (2603:10b6:303:8b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29 via Frontend
 Transport; Tue, 23 May 2023 23:24:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.30 via Frontend Transport; Tue, 23 May 2023 23:24:51 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 18:24:50 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v4 10/23] cxl/port: Store the port's Component Register mappings in struct cxl_port
Date:   Tue, 23 May 2023 18:22:01 -0500
Message-ID: <20230523232214.55282-11-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT046:EE_|SA1PR12MB6678:EE_
X-MS-Office365-Filtering-Correlation-Id: 2936b461-c6da-4e11-4890-08db5be4e868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OwaRER3DDaRx/I4YAL3MG5R6w789arn8eZiN5wAAyCjF1syxXgrEt4C/llAMTqCsAYzDW8bBMxWn27n76+f7P8XOy04LPWSV2pYqxw4OpGhm24qLn/Qe6YgNGKOKQSHxVro+0V58gwZekSPl5za8z0LuB9zD/HFsWNVFZNdwXDVtJDeV4aPB8I+ql2hyMuEjUyMUO4RUpI5PKgjqblQBnvCVmhDjF3nFgoSp1SUGBGhOzUwbtxn7QxOVpEuLzyB3p7qXo6pVoKHH4MsrfGb+hyJO7ivxo9DS/a79zQ11CSk+nuv1okRUQCL3ZV9sIepsYSxRz/gTcZMQPsuBYPrbZCJdFVa+Ulnz4ttEMKqCaOXKjVnT4CWGYRpv3jsP3E7xiGaxGRoiGsUfTbLLl3OH185oBwdHJHGzW1F6YA/SWkSZTDjN6lg/4yghK91cJkIHDO/GLnGEMHCMz0KrA+8aIk+SkgfNiTVTqJd6SoNYo1jccTcb9XIxTT2LXiWgirY0sHkgmSyVnPNQc3hPHXGQvKnqKB4pHj0LqGcgcjp5P3jVbxZZvOSTvdI2XHKqzzZHoKt8P9bm9sfXaZO/nM34omg97U/aCt1d+B+WtDkMdMIzPH2VsEm0y5exKv5yQicH/aDxD2JSH4K2IfR/9S2ZbzUukZhXkqBll8xIebB7nJs+hDxLAAFDE/xCxaCC/yfGWfNpsN+0YXDEapoXpLGNhhGeH4xvnjMbF0u5UatyZ9vXaZpHwOpaEb2jDaDZUV/PEuhUNztUD5kMc8Ek0/5QEg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199021)(40470700004)(36840700001)(46966006)(54906003)(41300700001)(7696005)(110136005)(82310400005)(316002)(70206006)(4326008)(6666004)(70586007)(8676002)(8936002)(5660300002)(478600001)(86362001)(44832011)(16526019)(81166007)(356005)(82740400003)(26005)(40460700003)(7416002)(1076003)(186003)(40480700001)(2906002)(2616005)(36756003)(83380400001)(36860700001)(336012)(426003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 23:24:51.1470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2936b461-c6da-4e11-4890-08db5be4e868
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6678
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
 drivers/cxl/core/port.c | 26 ++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index eff91f141fde..34e929f1723b 100644
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
@@ -709,6 +731,10 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
 	if (rc)
 		goto err;
 
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

