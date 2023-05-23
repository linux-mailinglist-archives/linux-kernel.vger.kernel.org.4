Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C69A70E989
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 01:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjEWX1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 19:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238772AbjEWX1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 19:27:37 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82B2E43;
        Tue, 23 May 2023 16:27:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBP6BsFJqld7FtzmaAWt0+2Isi4K2Q2FC+0pyArXzUAofMHcl9Z9jlGh8T/aXD0Bee5/5Ws5+yHm4VpQAl+vqt/nGhyPoTmLZ4Gl+bSzkQGcbI/qncjfX+fDlhft76HjwQ2Gp2plXYKpwIPK8ZY2KFSJ3fvXvI3SUVlGA+/oic3xMP7/iiSye8wUeI0XIlrh2g0bD2mq5WRCTSWIX9qnk1WqReFosZ2EH0fa3nGoki+VViM7/UpLum2EOaOIeiRRh0JcKjSJAT1NPg3wwIuSBXQIC4L1rQ9gK9uDcsTzDiGnvk/RB1hm1eC4LJ8pUcmjNCM5qmb/OQgAy1zhhYb6OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFCJvoWQOBJgfaFONxx5e0Zj4K02ZJPnBpZNxXR3g44=;
 b=G7DDVWB+QvnC4QAFYnD02KdwyHLWWSAsvy/JPM1+vopLfw8AWr6Sr4ZSZ/So3cEJ8ZwXIWTdu+/HiTEx8MOJF1slPVJ8IalPk4YlB1v+rpueX4GgdH3tdwLwXDg6c7ROG9dSfi8gS6EyeAxfeIkyLgC6ETCW+SDP1nOz9rbEA+PzvN6wmtQedXaART1AZfXpoODd49O8YxK1HjNw3JRu6tyDjn0BPVMzfnViuEB/k/jhMgxfgB1O32k4py/P9FDRem8SoENulggRkP7610drp1esRpmJAX1/3qha4+yuqL+5o6IqWHzlJliQvReC6fkZvFD5bp0AS0ywu4KaB9GZ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFCJvoWQOBJgfaFONxx5e0Zj4K02ZJPnBpZNxXR3g44=;
 b=sr97LWWfqCuGnoIgfIx7fV+We4/sF9B2THX3utBN2Ipv+ss9dadlDS/4kTTyirsaW6Q+DnzgxFSUC/ukA76QrhOnnZW/guE/Yy8au74YesxlaysGhheQKAqvATi0fzOq1R5f7MeJwt79TTl+HYeb2BN9I2lXkqSPBrWMO4nUwDY=
Received: from MW4PR03CA0164.namprd03.prod.outlook.com (2603:10b6:303:8d::19)
 by PH0PR12MB5629.namprd12.prod.outlook.com (2603:10b6:510:141::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 23:25:37 +0000
Received: from CO1NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::ba) by MW4PR03CA0164.outlook.office365.com
 (2603:10b6:303:8d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29 via Frontend
 Transport; Tue, 23 May 2023 23:25:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT108.mail.protection.outlook.com (10.13.175.226) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.30 via Frontend Transport; Tue, 23 May 2023 23:25:35 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 18:25:33 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v4 14/23] cxl/port: Remove Component Register base address from struct cxl_port
Date:   Tue, 23 May 2023 18:22:05 -0500
Message-ID: <20230523232214.55282-15-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT108:EE_|PH0PR12MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: 112863d9-ecdb-47db-3853-08db5be50324
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2btIc88zL8Uds4uVFdY1NOO++2PATW7HKyQ+SmSon9cBIOxq2raYYswHfCn69+6n5aHYT5Ox6Eo/OSNdoeh0zltC9JmK335QoRq82FVd0AuFl2D8DtZzujHbUK4+imutf0EKQg7igzBDp3ffg0voxEdsJXf4m2WvvSqZy6BRSiN8eed4F9H9ALprReu0BI10zmxlv/XhrHg84YoSZPEOaZricKtr1kwts5PAR6VFAiWFfGOpANZg6iZmn26HNYAxZcsZq4rx3doSI0BBt9g0phSjPFNcZqEgciJwCkxil6iandXBsJW6Kc00T/5a5/mwstBXAUPfS7SB9taix/FcmtTLEDzaEsIutll+c17hcwe81uaKUfcmmzNA04Bz05bLmnHq8w1V8ty7srJq9NMlf1OtPRANbtB+orcfynItultE72azM/VO8jFIaO3WLPCWjhsCkPFSjsi7T6Nfj7RY717YWcNHQpUXZQSvTXN36cICp2ENrmiWH0T95l9muOmmbrRksfbdzvBMB54yaagxQbZlVyT47RnkzSUSiPWhNfre1E5Xiw1QPAwrye1Y6+QEAHwp61n1Alm/QRiTYpsWiIGJtd69/uh++skCEGrczyevAUlNoG4K68jN+VM7YNnIv5VYZqB4dEFRB7S38RhHXfQ27IoiAFOAGsLtQE6yueYv3/i2DqDqdw/HOg+NpUDy7+h3QIPq5tISo/LjeLqGvX/n9Muow8rUb6i9bvGeQ0v8+GAab76VeXArHBBvXqZNfQEtbhqznCRRjtUoZZKoMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(47076005)(8676002)(8936002)(5660300002)(7416002)(82310400005)(44832011)(36860700001)(16526019)(186003)(81166007)(336012)(86362001)(2616005)(26005)(1076003)(82740400003)(356005)(426003)(83380400001)(40460700003)(6666004)(41300700001)(7696005)(40480700001)(70206006)(70586007)(316002)(478600001)(36756003)(4326008)(54906003)(110136005)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 23:25:35.9994
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 112863d9-ecdb-47db-3853-08db5be50324
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5629
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

The Component Register base address @component_reg_phys is no longer
used after the rework of the Component Register setup which now uses
struct member @comp_map instead. Remove the base address.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/port.c | 4 +---
 drivers/cxl/cxl.h       | 2 --
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index db2ba0c886e2..183f9f8548e2 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -615,7 +615,6 @@ static int devm_cxl_link_parent_dport(struct device *host,
 static struct lock_class_key cxl_port_key;
 
 static struct cxl_port *cxl_port_alloc(struct device *uport,
-				       resource_size_t component_reg_phys,
 				       struct cxl_dport *parent_dport)
 {
 	struct cxl_port *port;
@@ -665,7 +664,6 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
 	} else
 		dev->parent = uport;
 
-	port->component_reg_phys = component_reg_phys;
 	ida_init(&port->decoder_ida);
 	port->hdm_end = -1;
 	port->commit_end = -1;
@@ -724,7 +722,7 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
 	struct device *dev;
 	int rc;
 
-	port = cxl_port_alloc(uport, component_reg_phys, parent_dport);
+	port = cxl_port_alloc(uport, parent_dport);
 	if (IS_ERR(port))
 		return port;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index dc83c1d0396e..4365d46606df 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -556,7 +556,6 @@ struct cxl_dax_region {
  * @nr_dports: number of entries in @dports
  * @hdm_end: track last allocated HDM decoder instance for allocation ordering
  * @commit_end: cursor to track highest committed decoder for commit ordering
- * @component_reg_phys: component register capability base address (optional)
  * @dead: last ep has been removed, force port re-creation
  * @depth: How deep this port is relative to the root. depth 0 is the root.
  * @cdat: Cached CDAT data
@@ -576,7 +575,6 @@ struct cxl_port {
 	int nr_dports;
 	int hdm_end;
 	int commit_end;
-	resource_size_t component_reg_phys;
 	bool dead;
 	unsigned int depth;
 	struct cxl_cdat {
-- 
2.34.1

