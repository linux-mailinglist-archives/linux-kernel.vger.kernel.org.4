Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8E570E98C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 01:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238831AbjEWX2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 19:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238822AbjEWX2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 19:28:07 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::61a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953D11AC;
        Tue, 23 May 2023 16:27:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARA/zJBYfkRrUAvgHYPRa7D8DNXZ4HALr4Foa0YBRLwjX6x2sVBXmtPgfkkjO+x4jn84sm19kYnPcjte3qDkp2ezTqTKGGRi50nPskXYrFNOytgLxlst/1lmwt6ByfMZ28tkuhGBTrd7DvJdl//LBkRvcq3Hpr0pVrdFTt5+cwIQbFDeXAQUYP4J0st4111NjFYBlor8BgJzY+ql4eSYaZ2yHOiI8GgMpy9l8ZlSf6tiWMP+3r2H3alvpojzfGEbZMU3F/yw38+29UksuDteMd2k29BLKS+o7wSQEqy1+kHgXKhzcKjrXDI8DgYpYh9+9++mPysOrtQ2kZNi46M1Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EL810x2wZZL+OP8fLWiOe4/g4sok4UI7ItBAzJMy2Ig=;
 b=krAH8/Nx8wX5Abas4ixGUa4D0bef2YoJOIa2oNVf1RSWYEtbEcgriLj/vPH7qAA+RSI7/My621rMSXNzsSYq/HPCK/iO7+Cj5Iz/QylDtJ/hk12vxMtlz2r4W9vlv0vAxJYQ9NzsBejNDbY5PrYEq5zB1yk018UYSnmXvdt3GmAbwqtgvtKwsKCfXvzbJQA1oofukpr4C7czlJRb3Mxe5+Fc/kCt0LYgKoO2cjMEwHAtlrlOTNBDm7FzkOMAMz1PcV1gh7XD82t0ItsjDxmws7RO8xjT2b3c20KfU4tDBpAsfg0NP+/WHys8GOtqTglB/l1tMtbnK1thKsBdI9yr0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EL810x2wZZL+OP8fLWiOe4/g4sok4UI7ItBAzJMy2Ig=;
 b=Ew0luMocbnvmskhsTKohnW4vjIVxTLybxCG7o6N9pOE6IzfvVJ5pxsDknAAauJ7X/smt9IB3ZvrKauhLvfm0havolpSjCEbX6ZawvrICJsNsv7/edqUtqiZnpF9BmXyqoYjddHcFScZfMjTxgAb2XUQ6J0+ZoXFIiezzw9PXjLw=
Received: from MW4PR03CA0067.namprd03.prod.outlook.com (2603:10b6:303:b6::12)
 by DS0PR12MB8765.namprd12.prod.outlook.com (2603:10b6:8:14e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 23:25:46 +0000
Received: from CO1NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::64) by MW4PR03CA0067.outlook.office365.com
 (2603:10b6:303:b6::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Tue, 23 May 2023 23:25:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT099.mail.protection.outlook.com (10.13.175.171) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.30 via Frontend Transport; Tue, 23 May 2023 23:25:45 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 18:25:44 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v4 15/23] cxl/port: Remove Component Register base address from struct cxl_dport
Date:   Tue, 23 May 2023 18:22:06 -0500
Message-ID: <20230523232214.55282-16-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT099:EE_|DS0PR12MB8765:EE_
X-MS-Office365-Filtering-Correlation-Id: 226e3edf-2479-4bbc-649f-08db5be50910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LVRh+ASfsfKbCqx8ZhM3Fa+/SremA1fkYe35PGUh6GGPJehVlv+uuvSxv4P+c7YK7UrNtBl3D6LH1J8Q/UoBMD1Vx/ESBcH+ERO1iCF39qp2kp6PHAShl+LhVOpAUK6vI5Hja/3Eo7nAFzDHWiGvYd4to7GGos14l8ut20yrFWlKmXlO1gtHC/YW5vHw6lvB5nIljWbX50lqibq30J1j+1SNguaRoo+WkdYt6n5yzmu6c8GYQs2Hp4yLMSDc0Bq3/ODbwxlzfHrtHtcMoGafzyMrAQ+1XEJEjybHAgaaj8ii2vAaOFeMXpig6uC5flLvtj07nPPDGheBBzxwieqplUtgJpWll77hMVA6jH/XzbkDH9h2YD4oB6vAo/aDgAGECp5TPbAmxJnhpKm2J+znAdwQpbXADV+WuIHkK8y/sdVDjGiTlZqKe1GZKa8vbEIwI+M4WcF7o9T9i+BaodBmbj8LSRYXNdrK0K70IUK1Z2YL3P6hOlLGa1612zfZedT6O/p/dROBAV600HerE2CBvb6gLMytD4y03Hja9OXBuem/xQFg0EFfrdOugLWnMs/awhngaUJ3u3kmu+qbR6uW/7cn94gaPi8bGzxjQII6uhnx/1ts9l7njl/YFoI2DCwRi8hsV6X53pve+kMjSwo55ReFKUpwv8Rzow+5kHkOIoDnIK0SoblcZKASRfakpLe2CcSyptJN6ymQ20MaOjC7mf5VtZq3kXFjMNaw55o2I2kzfobNlr0Dqa+H6HL+Bo960187eJCzL5QchETKW/reUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(110136005)(4326008)(70586007)(70206006)(478600001)(86362001)(54906003)(6666004)(41300700001)(7696005)(316002)(5660300002)(8936002)(8676002)(44832011)(1076003)(26005)(40460700003)(186003)(81166007)(356005)(82740400003)(7416002)(40480700001)(2906002)(16526019)(36756003)(36860700001)(426003)(336012)(83380400001)(2616005)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 23:25:45.9358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 226e3edf-2479-4bbc-649f-08db5be50910
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8765
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

The Component Register base address @component_reg_phys is no longer
used after the rework of the Component Register setup which now uses
struct member @comp_map instead. Remove the base address.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/port.c | 1 -
 drivers/cxl/cxl.h       | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 183f9f8548e2..d147f08780d0 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -987,7 +987,6 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 
 	dport->dev = dport_dev;
 	dport->port_id = port_id;
-	dport->component_reg_phys = component_reg_phys;
 	dport->port = port;
 	dport->rcrb.base = rcrb;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 4365d46606df..6134644b51f8 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -601,7 +601,6 @@ struct cxl_rcrb_info {
  * @port: reference to cxl_port that contains this downstream port
  * @comp_map: component register capability mappings
  * @port_id: unique hardware identifier for dport in decoder target list
- * @component_reg_phys: downstream port component registers
  * @rch: Indicate whether this dport was enumerated in RCH or VH mode
  * @rcrb: Data about the Root Complex Register Block layout
  */
@@ -610,7 +609,6 @@ struct cxl_dport {
 	struct cxl_port *port;
 	struct cxl_register_map comp_map;
 	int port_id;
-	resource_size_t component_reg_phys;
 	bool rch;
 	struct cxl_rcrb_info rcrb;
 };
-- 
2.34.1

