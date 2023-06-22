Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD55873A9B4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 22:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjFVU6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 16:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjFVU6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 16:58:00 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1AA269D;
        Thu, 22 Jun 2023 13:57:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3a/MKw40JvVootc8IJuqxodsI/S3gMG4jMYZAqrQKb04dQBIKPzShZRY6NYkN97ONU3BG5H7r9LtKW38oTuqzUbLlmZBjRBhgYe5foNysOBTe9F/3NJe+1m7cBwPIg3PZLdg9yJB96zUZqMqu+MMLfje3mL0KfAaNEfkhw6RUzL2/P7FzUR82NxbWpe6fqRu5XsqFTX4FT/+31gs5azCpBUVbbNCLrs7uu4LMZQVE0l78U8s2Q7P2qrTB1r/Amr87b5am4a5tYWv00CTxlHItSQKj9QOck8tuGOiaqBVwv8wleRU18iuokhlyHDrVNfV1q29EoW7LNtyiiCmV/TSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QayUoeXFL9pZZkSBfcDiLT7Wq6qSoSz/ZbOpneU2nbI=;
 b=OwyZVLihbBBN3LnJntj4C2b4elQqU9+TiNNpTvs/0siZYzjIjRkF+K4ewwFKtsLcb2yeC84nTJ9VYY5u6JCukZ0JvlMhmxMDVMDeR+kbCcu8X9b61Ho3yIAj+LwC2szP3v0yUFipbDICWQWSZeCr/oigClx+MRVZbJXES437jZ6h3aYwY7xeS4twf7QJhYKNwhp3pQMW2S2LfKrMy/YKawySvP2JdE19MydtjVLLa+TSLpj46xXx7JbmPO+onI758hlXTsA8dhiWx/C5T5PlAjjNuJ5m3uUoInQbujhNdp7OZcmRQOCAvyxDF2sDrt4/hfVjmQMLrbLphzeJCjwQDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QayUoeXFL9pZZkSBfcDiLT7Wq6qSoSz/ZbOpneU2nbI=;
 b=dDUMtEZIecqv1k23bJpf8We3JRZ1iZtAX8Qe+U79JN2y7kETMj8ICwSbg19uVDX4+E/Qwetd277RHJhnhc8ymR+BJo5pJPn0XXoGM1eCoopRQsOJikkc/2kRnM2LNk4VN6qHp+0MdNWzGwQdwF11Aua6am3VdrIZfk+4Gj46uH0=
Received: from MW4PR03CA0225.namprd03.prod.outlook.com (2603:10b6:303:b9::20)
 by DM4PR12MB5722.namprd12.prod.outlook.com (2603:10b6:8:5d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 20:57:23 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:303:b9:cafe::c9) by MW4PR03CA0225.outlook.office365.com
 (2603:10b6:303:b9::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 20:57:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 20:57:23 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 15:57:22 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v7 10/27] cxl/port: Remove Component Register base address from struct cxl_dport
Date:   Thu, 22 Jun 2023 15:55:06 -0500
Message-ID: <20230622205523.85375-11-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|DM4PR12MB5722:EE_
X-MS-Office365-Filtering-Correlation-Id: c08532ab-bddf-4385-f5a7-08db73634716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sFMjaGlC5qKkOJD+Dt6vlnIQ55DJjIYE7X/8cA9PtPsBD2A2JJAvAuZ9G/VKhFrTA1mUSEbyzANESuyrhhb5qrBNEE4ArPJrsQUIY7GFU4S3fXucukJZ4iywHtnQPVm1+8Ojp0c5LOxgNevMpVg8o1+m+G1/KYJkHUqDX5toB1odse364u3hMfZRkgL81t3weXk7/4meiv5P7yQZJHhBSGx1RTa1pRkcFznzwYD/fWs9gGxH/pnJ4jsKaFRfHwngp9ubltx2VbTmqR+9oe/WZZGMqvofRJ0tBPUdqm4vQTdZrVx8enpcCaxnISmnLf0hLro6wswwstWXR+pM0JQEiuxsuvxstVDn8IZefcAvUCJ7/ay/JLAhGM7L9LWgI+Z5wUKaERx0e8tMB0b5N63h/kFrsXRxf4xzZhkYsTWVgnG39EB4tw6qj/cOyqGicVQQYdHtrxMeatDUT6KFhD0oeSuvUIlh5pozoyC0rvVYARWcY9NkeeusahMbdhyXh7HqmrReQ0Z58jDMIpn2qCQh2tK1fp2ny4yr3AF9BSuaSAQKu2NaTrbZDpxJQeJOgmlptVJ+XpU+9eoR9TfPA8DKmNIVM94/ZCsHLo2TTjJTdRpYZ1BbNaj0DYg1JrLO8eIzl3gRJe2vHXVy4y1visyLL/gj0sUNvd+rq8fGvEL5dW3rzCQHGXpWU0lVXMdiR6vXYD2jQIBZofylIkeYy0BdSnELvJMJUoDIFFppyR1vtTwOOcxw8xmylM1sNPRd5TF37KNEi3sFbYYJf/AE9168LA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199021)(40470700004)(46966006)(36840700001)(356005)(36860700001)(81166007)(4326008)(6666004)(82740400003)(26005)(186003)(16526019)(54906003)(110136005)(36756003)(2906002)(40480700001)(40460700003)(86362001)(82310400005)(2616005)(316002)(44832011)(336012)(8936002)(70586007)(70206006)(7696005)(1076003)(5660300002)(478600001)(426003)(7416002)(83380400001)(41300700001)(8676002)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 20:57:23.2981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c08532ab-bddf-4385-f5a7-08db73634716
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5722
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/port.c | 1 -
 drivers/cxl/cxl.h       | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index cdfe0ea7a2e9..e0d2e7596440 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -960,7 +960,6 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 
 	dport->dport_dev = dport_dev;
 	dport->port_id = port_id;
-	dport->component_reg_phys = component_reg_phys;
 	dport->port = port;
 
 	cond_cxl_root_lock(port);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ae265357170e..7fbc52b81554 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -594,7 +594,6 @@ struct cxl_rcrb_info {
  * struct cxl_dport - CXL downstream port
  * @dport_dev: PCI bridge or firmware device representing the downstream link
  * @port_id: unique hardware identifier for dport in decoder target list
- * @component_reg_phys: downstream port component registers
  * @rcrb: Data about the Root Complex Register Block layout
  * @rch: Indicate whether this dport was enumerated in RCH or VH mode
  * @port: reference to cxl_port that contains this downstream port
@@ -602,7 +601,6 @@ struct cxl_rcrb_info {
 struct cxl_dport {
 	struct device *dport_dev;
 	int port_id;
-	resource_size_t component_reg_phys;
 	struct cxl_rcrb_info rcrb;
 	bool rch;
 	struct cxl_port *port;
-- 
2.34.1

