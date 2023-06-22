Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DF8739603
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 05:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjFVD6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 23:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjFVD5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 23:57:15 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B9D2707;
        Wed, 21 Jun 2023 20:56:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkJqbywX10WQnlaN4DoGkEx8Sx2fbk6LNFqeqHzVSPxHDE9XM3PoLDXX/02yhfBwez5g239Ut1Fx85CMigQhpWhMexTGdt/QbyFMAk3keTPJYDnarqUVssyx0ObbyYHynX40Ysu+JlCWZUiuDoVP8YBrqamjnikVprjFGCb0iWCu9qvPEBwJUjsf36UFDQrunGbr8pzj9YPCWQOQ9EtAKedsRnszQgv99BXDi/RZx/Rm80DanMiyDzjob5mhGsmmY40/f9gkbrcIHqzW6Ofq6dcuQ9FIczLZbRJ7XkA3Pj3dtsFjBoQNuBDHxqizRqBTizXuaFBVBp23207UaVITbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2YL/oZ6BWmVEt16T2PDMBavkZ/Ot2HLc0Mn5CnXsYU=;
 b=PnAUJYx68UdAjK9zUzo++EDnp4bMBIib7646YJCu11+GOqTIZJbvI6nZpGmAZky11PtExgKDnN3k2x53ntPuXW4bOtzY/aLMO9BPcMXA6K/V9k6F6J126xk5iKnNIKZbrace/imgjh/BCPf2BDiqDILxQHFXxGPaT/xdMHRzIRii+M7bjDT1yFrD58+9AMcd1mcSSEkb3X6DnCQ6NLpsH4KTnofuypN3dMfcX6RtHv6OQnmWu8Dck5+BzW719rTjCImupjDFE24Y6nC+pnAn1gV/JsfE/nIOFXO6nb0lLgc+k2TK4fKynuw8IMOLI5HYR3kP5J6f28ExQWwF1vLdtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2YL/oZ6BWmVEt16T2PDMBavkZ/Ot2HLc0Mn5CnXsYU=;
 b=c3lUHbyf3o42HS/4+B5WTwSNgfIh0iwLbI5qFFZlL25VHo7fvkC04UriXR0jBMtZLdRei+axURXnVXGJFqHwGaXSn8ABsUmWoFFFBW5kyshvXQ1q9/TqYoJi7dbmtS3sTzFfZHV5In96QHLWlvzb8jZ/jbgkfE8SPlIrUXp8mRk=
Received: from BN9PR03CA0055.namprd03.prod.outlook.com (2603:10b6:408:fb::30)
 by SA3PR12MB7808.namprd12.prod.outlook.com (2603:10b6:806:31b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 03:56:12 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::32) by BN9PR03CA0055.outlook.office365.com
 (2603:10b6:408:fb::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 03:56:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.39 via Frontend Transport; Thu, 22 Jun 2023 03:56:11 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 22:56:10 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v6 19/27] cxl/port: Remove Component Register base address from struct cxl_port
Date:   Wed, 21 Jun 2023 22:51:18 -0500
Message-ID: <20230622035126.4130151-20-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT036:EE_|SA3PR12MB7808:EE_
X-MS-Office365-Filtering-Correlation-Id: 682e35b8-78cf-4f22-8211-08db72d49e42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 12TLP2MenOBQVNsfVAuB/7G3Id8om61T/rB+/AVA/QdNkkzyhF0NS0IU/6z86qq8N8gGXy7adXk9Ananwf8qr4epkgCAe05PZlwsdDVA4GLBzw5OOaPe53OhBvUJYdSP4tqfZMmrBgaOgSTFoWmOcj0psBloCet3V1GImg5J4bgxyqTF4agSMK0sYV+rvWvG4CTboVJ5FiURzCvRX2o9m83W/gVlbxnUvM7eOZpB2F5889lbLQZww8TJ7C1dnSFb1nUGvePXASXSPxORn/VAYx7AA4czwHp0oxzMJkJM89xpjYh2BC9blWx/exXdAjawnfGv1ChuC+XKxuCiPVPz7C72oHFDsxma4eEaCtjPRBAGftinIsQg+8jK+dHBsy6OTVGctfqHSoIQrdjoNPzODA67Ak6od9tvtCaODykfwcGTQHRMVnRVAwDE8mwM73xXPhgX0pvyVuzb5hqmpyXY6BhlHopNK7KJB6sVMZeyGehrUTGoyhqJ56Bzf6b5/3VW/kHbGGOe3BjJZb694WeCarREv8/lhP9MgrzYUU5nlwkZqjESJ3rbTaB3ugfQb4LN35kNYMB68g+f6O0zWia2E+OsQtdobXF3Mvf9nVCGWQ7HXc+cfGllSRM5/MlOqvtcLsPdaaZK5FJTnQfbXtMD/h/RcEuI2fuOtnusX3nu59X2vaL30kBkcpTbIzXs7JBtotQ9IGScyvfnGnEk0phiuvTSj4DeFrdVRXMwPgBb2MVOXIcJ/KlE27akfczxBwoEC6S7/J/R8MYmlDSYdA+XIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(82310400005)(7696005)(4326008)(70586007)(70206006)(478600001)(36756003)(316002)(54906003)(40460700003)(110136005)(86362001)(83380400001)(426003)(26005)(1076003)(47076005)(336012)(16526019)(186003)(2616005)(82740400003)(356005)(5660300002)(81166007)(2906002)(41300700001)(8676002)(8936002)(7416002)(36860700001)(44832011)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 03:56:11.6380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 682e35b8-78cf-4f22-8211-08db72d49e42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7808
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
 drivers/cxl/core/port.c | 4 +---
 drivers/cxl/cxl.h       | 2 --
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 45fe7d89f7f3..cfae8307de90 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -616,7 +616,6 @@ static int devm_cxl_link_parent_dport(struct device *host,
 static struct lock_class_key cxl_port_key;
 
 static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
-				       resource_size_t component_reg_phys,
 				       struct cxl_dport *parent_dport)
 {
 	struct cxl_port *port;
@@ -667,7 +666,6 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
 	} else
 		dev->parent = uport_dev;
 
-	port->component_reg_phys = component_reg_phys;
 	ida_init(&port->decoder_ida);
 	port->hdm_end = -1;
 	port->commit_end = -1;
@@ -726,7 +724,7 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
 	struct device *dev;
 	int rc;
 
-	port = cxl_port_alloc(uport_dev, component_reg_phys, parent_dport);
+	port = cxl_port_alloc(uport_dev, parent_dport);
 	if (IS_ERR(port))
 		return port;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b1adca9b27ba..9f46a4e1fbec 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -551,7 +551,6 @@ struct cxl_dax_region {
  * @nr_dports: number of entries in @dports
  * @hdm_end: track last allocated HDM decoder instance for allocation ordering
  * @commit_end: cursor to track highest committed decoder for commit ordering
- * @component_reg_phys: component register capability base address (optional)
  * @dead: last ep has been removed, force port re-creation
  * @depth: How deep this port is relative to the root. depth 0 is the root.
  * @cdat: Cached CDAT data
@@ -571,7 +570,6 @@ struct cxl_port {
 	int nr_dports;
 	int hdm_end;
 	int commit_end;
-	resource_size_t component_reg_phys;
 	bool dead;
 	unsigned int depth;
 	struct cxl_cdat {
-- 
2.34.1

