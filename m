Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5BD739600
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 05:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjFVD5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 23:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjFVD5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 23:57:03 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2062e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A992947;
        Wed, 21 Jun 2023 20:56:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hD5ZUQYbqmYC7XI4TFqSWPUzAZuL8LAzuAZ4Y1spcxZVq9R3EcO57iLu93vNNOGeenTW6gyTISKo+rxoK2gBkvyeNWCDkMqpxDdrPQosr4rJRU1/4fyTDaCk6m3bABBNLMCXlda90n/tDofRX1sSqBmWsukhpHxDqgqjrPW9PbDnOktcbbZN0IEibsaeFW1NOKy4Dn0yaPipZqvO+1TI02ZKchp2hSL31npsUgd9z/ffM+ieLfLppRG0qM4DNHYWEUZLBsznwi2fUktrLsZGWF0SeQ7ZjTKhhf0aVwdv56uyoHTRKwfhydaL7eRSBl7v2jC575IANKYbVU/Jsgtt8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQqzNKS+p3Yjjar0WkUmWJnbHRjOuv4h456uwKvVzH4=;
 b=N3AjYCNt//eVIorUJPtjJ1it4D7g0BSOy/b18paqI0s8BuQZla4mxxEZmbSdh+LKDZLX3fqXmuCzo7LZ+kSYccYGHg977fAEEASEPkr5oYbdi0mY6ZOBsx4r2YyMqhEUt03f2yHk0BXry18HbsR7Y6GLe1doMc/tJFb10oTcMb/M9yg+MY3kbnmjzjCzS6qudktI1TPoyNyg/VqZnFwAvfcxlN2aurUta+MrbT4G/2uboIwDTTh6oBGR+F+1dHGyxFAZzOMIDi1GJ4GQcX2qvkegPw51TGdfuCDwGhcWr+mBKPvg4CIPZu0mT5rwzFnr8mcYq8K/d63o9ABbjF/jdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQqzNKS+p3Yjjar0WkUmWJnbHRjOuv4h456uwKvVzH4=;
 b=RQNZlyujD4ceVI2q02qRlpxpZ5dEEsSNn5Hp17bDeOFbglcARgPz5TjR9Dmffv6GMi3885sgJxEosXqc8g3bFMWZDtXVUxLmAFSkmE+YV5TWNDJwPimVVAc6jU55KwPmdOmo+egMt3zFBekWRTKnL0yg4og2PQTmxceXfMky7wk=
Received: from BN0PR04CA0048.namprd04.prod.outlook.com (2603:10b6:408:e8::23)
 by LV3PR12MB9215.namprd12.prod.outlook.com (2603:10b6:408:1a0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Thu, 22 Jun
 2023 03:55:40 +0000
Received: from BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::c2) by BN0PR04CA0048.outlook.office365.com
 (2603:10b6:408:e8::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Thu, 22 Jun 2023 03:55:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT114.mail.protection.outlook.com (10.13.177.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.41 via Frontend Transport; Thu, 22 Jun 2023 03:55:39 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 22:55:37 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v6 16/27] cxl/port: Store the downstream port's Component Register mappings in struct cxl_dport
Date:   Wed, 21 Jun 2023 22:51:15 -0500
Message-ID: <20230622035126.4130151-17-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230622035126.4130151-1-terry.bowman@amd.com>
References: <20230622035126.4130151-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT114:EE_|LV3PR12MB9215:EE_
X-MS-Office365-Filtering-Correlation-Id: b128c6b9-36c9-4a30-0f1e-08db72d48b0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NyGuUrGhjBqtEh5QZ3REX90mfTadn8E3YGyHIIeo1kP8bTl8nyehAxPM3/qR4+wsqYtIXA/SXfTSX/uNHH3GoFrERtReKqwVgoRNZ9sUSbOG0P1GpAUDf4R+mi6FQfAXV688jonFT3PUB7iaHFnKm4tFbVr47TOzy8Tzin3z9hWfr09z/jk6nVIOfEQPTlXPaLFp6WgxQnp9Q7gAroqskgwEa9hHUGmnZgzg5yAJ6Vq8q6b1vbUsPg+Rry0dSS4i+R+iG654+jXBM1nNcW3Tm1gmkWgOxGnU06lLJig0O45abmV1gDJab99PYJmAnWg21bmvsLV5kX4Zg0UNUY+9LclIQ0ct5bOs9tZfrlGUjGSgDnaNr7h864mCOjQgGHDhxlLjoFII1rTlodxys9H0s/EpBCb5CChQRUvmnYEvJReYGuisDbdiqzMGaSeBmPaQrUgWTZlXVTfg1prEXFNBtc+Ki2UZydKVrMFzd6c5Kbb44PCkV6wXqzkfQaL752WLTzMkkNw4J2QVyHBVVTVJH8GJeM4WbQxVIaKr+sNc814sMEqj47uIi/+1sWhDiRBATtuYreog85xRSGEX3GBOzvgzLj4U2M7zGfi0At1tfEP7p6RZUKFUqii3wEm9G9wKfsw8lKJhmopiHod3j0n/9zN1Y6HLkRnpaJvebdWJ1XfNUJK4vTsJVGMIhpn2XuSTfpPi4t0KqLnEmuky7Cd8MbTuvQde19l+GKfxag2mWsbgjtbnKT4guuh4A847/y7dT37OuUnekAUXhTLivCeFcw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(46966006)(36840700001)(40470700004)(82310400005)(7416002)(44832011)(356005)(86362001)(47076005)(8936002)(41300700001)(5660300002)(316002)(70206006)(70586007)(81166007)(2616005)(336012)(36860700001)(426003)(83380400001)(82740400003)(186003)(16526019)(26005)(40460700003)(1076003)(54906003)(4326008)(6666004)(110136005)(478600001)(2906002)(36756003)(8676002)(40480700001)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 03:55:39.4044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b128c6b9-36c9-4a30-0f1e-08db72d48b0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9215
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

Same as for ports, also store the downstream port's Component Register
mappings, use struct cxl_dport for that.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/port.c | 11 +++++++++++
 drivers/cxl/cxl.h       |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 2e239fd33df9..45fe7d89f7f3 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -710,6 +710,13 @@ static inline int cxl_port_setup_regs(struct cxl_port *port,
 				   component_reg_phys);
 }
 
+static inline int cxl_dport_setup_regs(struct cxl_dport *dport,
+				       resource_size_t component_reg_phys)
+{
+	return cxl_setup_comp_regs(dport->dport_dev, &dport->comp_map,
+				   component_reg_phys);
+}
+
 static struct cxl_port *__devm_cxl_add_port(struct device *host,
 					    struct device *uport_dev,
 					    resource_size_t component_reg_phys,
@@ -988,6 +995,10 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	dport->port_id = port_id;
 	dport->port = port;
 
+	rc = cxl_dport_setup_regs(dport, component_reg_phys);
+	if (rc)
+		return ERR_PTR(rc);
+
 	cond_cxl_root_lock(port);
 	rc = add_dport(port, dport);
 	cond_cxl_root_unlock(port);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 37fa5b565362..b1adca9b27ba 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -595,6 +595,7 @@ struct cxl_rcrb_info {
 /**
  * struct cxl_dport - CXL downstream port
  * @dport_dev: PCI bridge or firmware device representing the downstream link
+ * @comp_map: component register capability mappings
  * @port_id: unique hardware identifier for dport in decoder target list
  * @rcrb: Data about the Root Complex Register Block layout
  * @rch: Indicate whether this dport was enumerated in RCH or VH mode
@@ -602,6 +603,7 @@ struct cxl_rcrb_info {
  */
 struct cxl_dport {
 	struct device *dport_dev;
+	struct cxl_register_map comp_map;
 	int port_id;
 	struct cxl_rcrb_info rcrb;
 	bool rch;
-- 
2.34.1

