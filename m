Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316A5727179
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 00:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjFGWUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 18:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbjFGWUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 18:20:30 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A45213D;
        Wed,  7 Jun 2023 15:19:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSa3ayW3WpgQ/tTC7oMi6AcluuHVnEkz0O59WzzbqJTdxaGVl5ZgYDDFs9vAPcqNnI7aRlTZVrpJ4K66P3TTwsFf77TfNLfOKEKW9piHSi+BkDs1J6MoI7/rQoIegNMM1ePlGFCmeqDgTAaLHhgS9ziEPh2YpLQX9cRmZGw8OOGaGqJ996QA86fMubDnsMVXq4AreIWT5dtxJbkWS78W6UM0scbnvVQQ4+rxgRG1SGsNCV/evs2YBWYNPbIN3f7BwWqoGhGpZuX2hepCsWBeZYT7PoZ6uhekp93h/6yX/TqCzK7c1c59mqF40wyOYWzcaDPlN62/Nca10YTOUAt3Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9/jijfH+bw8KTnXojy/B2eIdYYiBlbDOWDaGDhrZoI=;
 b=Vb2uhtKUpG3VjFVB1vRHfPThYwB5NE8xtEVRvE8DrrqA0LyDlA+4vgnK87IMAGMS66tolqniIOePXFLRksEe78XM1W42N7AUZWYOxVQvvXp7UeEh0nYARMMCIMdO0Yk3EuRHOItzDGcyRSHMPyRwAGo1y+N+4zsozyr3fd61PIE14K+Um2YXcQv1Ke7imVg0gq9MpOtCMqDziuTah1Mzi1bcT9wXnPEtx5jHf9sOMnaozSc+OazmJ5u7KHv/1qEhPzxGUjvkAiiynTd0lc1Haxzi87ZMbZssgM/ZJX3K18C/EjdFFsG5pG1Sa69l+m1xEu/U+xU8O6wSZl10oF7ngw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9/jijfH+bw8KTnXojy/B2eIdYYiBlbDOWDaGDhrZoI=;
 b=aTN2ucnIFpFUG+scAnl2s0kI9ICWL+Iek4+Pw4DZDgYLfGKovtDS5UdH1V48FvHfz6KRG57+fBFNlwj/6MereMNTKcuF18CZvR57IURVEixss3/RGXGyHpSCQ4rtSevil9bcaRiW1C3FKXHAmr4IEuGxEgScg5Y6aKCrG530rD0=
Received: from SN7PR04CA0055.namprd04.prod.outlook.com (2603:10b6:806:120::30)
 by MN0PR12MB6224.namprd12.prod.outlook.com (2603:10b6:208:3c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 22:19:29 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:120:cafe::8e) by SN7PR04CA0055.outlook.office365.com
 (2603:10b6:806:120::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Wed, 7 Jun 2023 22:19:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 22:19:29 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 17:19:28 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v5 13/26] cxl/port: Store the downstream port's Component Register mappings in struct cxl_dport
Date:   Wed, 7 Jun 2023 17:16:38 -0500
Message-ID: <20230607221651.2454764-14-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|MN0PR12MB6224:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f3ad50d-97e8-49d7-12f7-08db67a542fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +1QRJhCDRseVYS/jy8P9X0k2YSwtL4i15uHrIHypIONz+Y5xj3DJa0HruWiLLMqBitYTrnJ+Qk+8oZ9etYjzVsQTRxtxK0KhFUogC1IYLzBEJZwFEUnKX+iyuyOB7XxrJDAGuYdtmn1i4wWbZbnxz7ZYz26Hoa6nrY4p/2Tp6o2MVjr//F+Nc2YadQSsznvT31NDzF27nDbssCH2Vy9rPpppHxMns4MqLAbHFXah6oVs38wtgBOFk9CJjwe91zrM8dbG9X2Q31Qnt0AT+rLE+HpET15SVw1oKbOONVUWp5CpCYA5NGm86WxYkCEMFEJJozY1cqeAv6pVuzSiOsCxJqOLX3v4pIvf5zsW0aMyuxT9NCrzdic22x+RGopeBBm0VWSb6sI/KUxcjCZcJBcM5A21dkhAL3sgHrOwmke62/KjvY/GNiH33SA7V4w0jhOP+j8p83Dmu5HzGsq5ent/vh1V/oPWCWH3zH9OxTmJvAyzlgbwIyAATfgQ/EcquaoZ8gJmXaMVMUqy+GQoO/sWKHfgZTCR5MitgMN0Ojxairgg5wROnEOjQ/CK2X1IzF1bU41vosLeKc2p1vu7bGPsEursQhxH+CkoFzklRw6LylgVOiIZuYcXV7dsAt90+mYnpCxq6//2B3miw1l29GycwjkXLyBJI2TS9TMpuKm8dBxT98Z70e2ypz0HVtijpvjlhgQziD3UpQBw4wbBNvTVXt1SC6fEapjdZq4fr3T7p2HHCXY+7Xjk9wL2XM/8aWMalC8qM+NzxK+VG7CMVTEC1Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(336012)(7696005)(6666004)(70206006)(82740400003)(2906002)(81166007)(356005)(70586007)(54906003)(36756003)(110136005)(8936002)(5660300002)(86362001)(8676002)(7416002)(44832011)(316002)(41300700001)(40480700001)(4326008)(478600001)(40460700003)(426003)(2616005)(83380400001)(26005)(1076003)(82310400005)(186003)(36860700001)(16526019)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 22:19:29.3447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3ad50d-97e8-49d7-12f7-08db67a542fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6224
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
index 305125b193ce..a40d8cefb57d 100644
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
@@ -992,6 +999,10 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	dport->component_reg_phys = component_reg_phys;
 	dport->port = port;
 
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

