Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243F27395FB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 05:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjFVD40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 23:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjFVDzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 23:55:40 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595941BD8;
        Wed, 21 Jun 2023 20:55:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNHiWiK6L37hFRPBBedMRYIPbijaDIV881ALwX2CSI4+AfFaz2YHKfgzGx+93UvDTeed0wQ5oyGkBArcscUkY3tDwlAgRQirP/1+B8u7p+KY1CvznkP+FbpImNSj0kORQN68gBvdb13XKgPiTzNfPj+wo0xx0nkEYqt5ftMcYfq+lKnrTUbkkMxvnc+on3MPqkW8WCcvgvJLuHNJhIKpD/643vpFUvEtivN7tDs8dLeDAYebKlL9C+sSd7SlxcVSJTn7oi9pf8rbNYtRmem5tGzBKpYMm20GM+/i2UnmHdS4jNhMiX2970VrRbRWkR/GQCdUf3ID3pe4/oWeQ7w2CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QayUoeXFL9pZZkSBfcDiLT7Wq6qSoSz/ZbOpneU2nbI=;
 b=feyo6v/OAu1BhcfKCCLXJgSNY1rzGWUyoIj9ofnkjJmWPa3X10OQZp/5eD1jG0WbBnQca+kmEEc5NgnoV/uNX7LxrjIHK9W3J7a2+nLFswkTFgWKp0MyLBFdOB6Kl2h9e0VpTCeLkwDHClWZMZ+SN/IwjLMRzjlGenwqikq1/LsXPr8BWflRs9ntSZiPt317cfdKIXOntiKPpMlMHaSkFC8GSflLeM2biMT8emR5XdgakZYO6pvJl9FDTMC0Pq9YODd0Nd0oLg38D1j8eR23mEJZC7j7/gFnLq44/zydNKqEHWtnDTj4gE8fp7TqNpeCZU+bcFBlc+AhEhWAXZ6rvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QayUoeXFL9pZZkSBfcDiLT7Wq6qSoSz/ZbOpneU2nbI=;
 b=GK0G1ZBJdngOiyHmVSslIUs1bpXOmtc0dL/AzncNvi6Q8FyRVer5F+ix4Jj83a0QkF2/dW06Mkb5p2+colhUcAqq7lkzuevT9gFFFUeQmlmR+3MjQI4MdVYEr72UYcAK2jhVFPgK2Uo7TOZE/n+0iLW4PDIZbGzhnNsUxxbs0qg=
Received: from BN9PR03CA0306.namprd03.prod.outlook.com (2603:10b6:408:112::11)
 by IA1PR12MB6233.namprd12.prod.outlook.com (2603:10b6:208:3e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 03:54:44 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::eb) by BN9PR03CA0306.outlook.office365.com
 (2603:10b6:408:112::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Thu, 22 Jun 2023 03:54:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.41 via Frontend Transport; Thu, 22 Jun 2023 03:54:43 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 22:54:42 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v6 11/27] cxl/port: Remove Component Register base address from struct cxl_dport
Date:   Wed, 21 Jun 2023 22:51:10 -0500
Message-ID: <20230622035126.4130151-12-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT012:EE_|IA1PR12MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bc9279d-7e14-49fa-7d39-08db72d469d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DcCuhafmN6N6CTm1Z2m4AL5wa9FUBusrjAZRphoxXXowaFVTR7BldEYY0R22Mxf0QfPYEPbhszmEkcBfvH/qRRpgHShD06ZnI19mr3n/KZ2EMO2T4knBt0sbbOLIwJz1QZGUOkPMl/kHNyKZbK7gAIeSneEcy9iv4UwDNBYt4IJgVYPKxBWEvbbff/Y2oAL9sYyCcFCAKMsENHIxxyr6CwWVKg8c2iMnQAAd2ssYX77PfyJY/gZ0aibSIYXZeE7oYUidzY2+qofwdTTvGTKTFqKFdKOAGF+Co1LSlJhZegcSxUkvWMV7B7tU6v3AAaTTtecZadR4MO2O8SXAMyHX43RPLVDQlWqgSbzbdFytKM7pi+qdYf1tfW+4uyI2NN28wDMUS0CntatvglKrNt0qdmsvOOr1hLDjQKm5B38I1cjYVZaO+YH08ZDO4O8+SAvAyJGTxfrUNQf7isLr+cMYx7yyKd4Sq3RIcDyL77OcyxIuxGTVI6HcxPzMyKYFiNVy4IjGuMMCXRWdinRiarZbKl/Ll5dXFNHWNFGs9kPiHD36YMIza9JQTCmYXI1a5nsZl2cfEGx2FkqMK02JxC6eKf5lOrbD5k8tf0d5wDKCbbn9KT34Tha5B1hTC6reUia4ULXWd1h+HuFjk13iZ03c19v8KUtd/GajPdA+8NasZvhQumqX1DjLkr0p0fELMx9mhrBKUP83cyMrZr9E5xHG0gGOSVtIfCmbKnjtWsEtDXS+MRYIZ1/Hj2H6SntCGi4rR21uyGt9ok8uFcASxzqR9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199021)(36840700001)(40470700004)(46966006)(82740400003)(8936002)(8676002)(7416002)(86362001)(44832011)(82310400005)(5660300002)(41300700001)(2906002)(81166007)(356005)(110136005)(54906003)(478600001)(40480700001)(83380400001)(6666004)(7696005)(36860700001)(4326008)(316002)(70206006)(40460700003)(36756003)(2616005)(16526019)(26005)(47076005)(426003)(336012)(70586007)(1076003)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 03:54:43.6623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc9279d-7e14-49fa-7d39-08db72d469d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6233
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

