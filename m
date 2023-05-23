Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21D370E985
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 01:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238764AbjEWX0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 19:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbjEWX0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 19:26:19 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on20624.outbound.protection.outlook.com [IPv6:2a01:111:f400:7ea9::624])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E9DE45;
        Tue, 23 May 2023 16:25:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkgT92ZR8fz/onD2j3I3kNEzCrfKOq0/QHcJ8zQ4pipOCnx5olYlESdJ8SUjrJCERTCK1DyE3hiphtB903QhRbWNLK4/6+53+LFWFBFgMt25OBiAiNfL2rIdYYLcfQJu+yrvouRMAURkmCQCojxnafMFNiGwYEHQTl4YM3n+SlktDzV57n6Bh7shZWgrCoNisvfP18Vsr7eRXRoQGg9x1/G0W0LrQIyaXsQKv8ObQNWaScQzm2fTmEtWMFsE0iPEgCIhv2b4h9eezesaare02lNzKImCDZeCgltbGAEZ2JL6KjsesnC3zpIKdowx/TrrXMlaNWD6T9ZDWeZ2ceV1OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t86lYdGjut2Bu5lLYRt419rT7a/Rrxw0c6IAPNR8Q6k=;
 b=JciuEIrorxdsYp/B6zcsun48YXG5vs0370iXBuvyu/1FTPqiYFgp0WrcliLmrR+/W3PlJgZ95OQrrvUBq35s9auMnzux9ALUpI5iPeaXK5LOUJhehpFIiXF1M1URShLfHR3O8O8eNm/O6bLpoaOFMTgzG46imRpg2ZQULX7lne2OiPg7agmgWFsk4SRZGbH+MAUdV5G/ZKQnc6u40wR2tZvA4jp28rU9N5qhxqQVA3qu+EVJTFQFKW7cA1TV4OQRSA3bDiQ54z6YZWvycTHMeOHalxaBOSSQCu5iVxndo5RxoXmAIBRcsXJ3EwdcawvJ/EFzlzGxQQAdlAnAVj2qFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t86lYdGjut2Bu5lLYRt419rT7a/Rrxw0c6IAPNR8Q6k=;
 b=N8HRTxpOZH/f4gOyW4SlDtpOIdfzV4hCUPiyN4peL1uuPx6s6rWW+tR1Tnmg2i3xSsr2hqBPWULWTQrpGR/YoBn3NUf8c7E//5/f0pq8vbfy8wPzFaAp/KINJDzy9WnliRrahL/sdKaCrhX8QVqK2XrFgaVjlgELP0ugqxikIEY=
Received: from MW4PR04CA0322.namprd04.prod.outlook.com (2603:10b6:303:82::27)
 by MW4PR12MB7335.namprd12.prod.outlook.com (2603:10b6:303:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 23:25:03 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::fa) by MW4PR04CA0322.outlook.office365.com
 (2603:10b6:303:82::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29 via Frontend
 Transport; Tue, 23 May 2023 23:25:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.29 via Frontend Transport; Tue, 23 May 2023 23:25:02 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 18:25:00 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v4 11/23] cxl/port: Store the downstream port's Component Register mappings in struct cxl_dport
Date:   Tue, 23 May 2023 18:22:02 -0500
Message-ID: <20230523232214.55282-12-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT066:EE_|MW4PR12MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: faaab463-f16f-49ed-d39f-08db5be4ef6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ZRKXlMNGIZQWnT2GwjBKHMJTp2vCKPDo7XE1jyLHxRnnugySfsUotOUairKbsWZT3oT3s/aciCtLWLvTWVwdqag76kpzLqNiLzUeK3ysgiL4xgxazYoBhAIWknu15thEdNG6i9IAmmrE7e6TDfKAqXG7xsqNFOCf4gErRbp9GvTsTdV8N1cq2DQ3ssYpd+7ZhsInXgy3k1NvEkeAvyLanH9OOM9fMpb6aQxG/fl7bkTC5vhCeOBEaM0lMV83EZPJOD/bQpXX2pyCtg4v32YcTBH/QUxAjcdo4s9GJHOqTG6QczuI85mTSJLGbWNAKrsR99IHgoIRHlzQ27GafFcWalC1NA2HNx3JQc5juZ3dvo7pQjkzRZyEhTcAomdd7GLDlp2nlQ8kcG/+CrbbmG2Mv3yXlF0DDv/LLOykTLwepQv4hfvYTZyJQpGGKMi/csZmI90p00TZyAyOH3XKSID+J6+HGiYdtzUNdU+TbJCnTXddcgiKqahqxwzV2eRBBIapbCFRTmpd2gkfDHrKesl/9l3vDPDtkUzLyMjcuyjV08ZlwGkNMmcMxtlRUcuD+otX5HS5oL/HGUuNvLpilWdS71WvWVXR53BWXT5Q3J3AmmWsl4CWRghyPN7fUGG3lW0B4ntGX5fRRLe+tVOJgRfhXIDMCcjCWJGe0ZQoZTF8MH0Sb8Zh0KOYPiKXXFDHBhUvNP4sjq04Eo7e2sMUDeo3k10WozLRBR6NUl5STCQfFKM2NdC2fijr+IsEKCtI35930t1rUDGVtituUqC9HnDbA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(70586007)(70206006)(478600001)(41300700001)(7696005)(110136005)(54906003)(316002)(4326008)(86362001)(8676002)(5660300002)(8936002)(7416002)(44832011)(356005)(26005)(16526019)(81166007)(186003)(1076003)(82740400003)(40460700003)(426003)(83380400001)(2906002)(40480700001)(336012)(2616005)(36756003)(36860700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 23:25:02.9405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faaab463-f16f-49ed-d39f-08db5be4ef6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7335
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Richter <rrichter@amd.com>

Same as for ports, also store the downstream port's Component Register
mappings, use struct cxl_dport for that.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/port.c | 11 +++++++++++
 drivers/cxl/cxl.h       |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 34e929f1723b..db2ba0c886e2 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -708,6 +708,13 @@ static inline int cxl_port_setup_regs(struct cxl_port *port,
 				   component_reg_phys);
 }
 
+static inline int cxl_dport_setup_regs(struct cxl_dport *dport,
+				       resource_size_t component_reg_phys)
+{
+	return cxl_setup_comp_regs(dport->dev, &dport->comp_map,
+				   component_reg_phys);
+}
+
 static struct cxl_port *__devm_cxl_add_port(struct device *host,
 					    struct device *uport,
 					    resource_size_t component_reg_phys,
@@ -986,6 +993,10 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	dport->port = port;
 	dport->rcrb.base = rcrb;
 
+	rc = cxl_dport_setup_regs(dport, component_reg_phys);
+	if (rc && rc != -ENODEV)
+		return ERR_PTR(rc);
+
 	cond_cxl_root_lock(port);
 	rc = add_dport(port, dport);
 	cond_cxl_root_unlock(port);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index c76e1f84ba61..dc83c1d0396e 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -601,6 +601,7 @@ struct cxl_rcrb_info {
  * struct cxl_dport - CXL downstream port
  * @dev: PCI bridge or firmware device representing the downstream link
  * @port: reference to cxl_port that contains this downstream port
+ * @comp_map: component register capability mappings
  * @port_id: unique hardware identifier for dport in decoder target list
  * @component_reg_phys: downstream port component registers
  * @rch: Indicate whether this dport was enumerated in RCH or VH mode
@@ -609,6 +610,7 @@ struct cxl_rcrb_info {
 struct cxl_dport {
 	struct device *dev;
 	struct cxl_port *port;
+	struct cxl_register_map comp_map;
 	int port_id;
 	resource_size_t component_reg_phys;
 	bool rch;
-- 
2.34.1

