Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AFC7395FD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 05:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjFVD45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 23:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjFVD40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 23:56:26 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20625.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::625])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEED1BF5;
        Wed, 21 Jun 2023 20:55:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbqsO23Otzktk0u6AkErMtKYnLYUZm5ngogr+pjzgoyln/ZLKOPm/3pD9fQR5izqANDrpRhVpT1qEgbABC+aSiz0cgR+ls3zKpAQnlx8nqrGrIELvwjS/LzbHvJM1A+Dm+nqnIJ/VzX2OcSPKb+WvnL75hIwlUQpuLdqh1+DdcBtNXeXlrGAMOnfnkMWd1vi2rtry+1MTgXwN0oNmiKC9aYJ2Lwc876rkql/DMs1mmN0ZsN0p4Ek2Y/c1d1uqbsVIDqBTyfS3i0EOTDOQQrNhTE81fLKGSxr5uGdI9XGljFFPwr020IFM7+/v3e5qismOe7m5bH5K7u2/pNcA/PB/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JImqAp9zoln5nJysoPYyHl2b/2Gg4IfkFwSEYsrRYgw=;
 b=OOHdXyXwUE3/iH2/a1jtN79/Ph3+gHaPaTR/otjr7kWFEA7V5IjWjpqY94FYJSI2x1r957S119/5wSEp5ogU4Pa1/6tXxGNyPTub37R5aFO8AiSe7ewwM0rvvkmiDllg0DMADYzTW9oLXf0bxnr7jdmDmvg4/gKVlCo32Wq/0j3MqKlhxU2hkbdn1+OPo2w5FC4KCBfy+RFDPvMAbKjnTtgMNyii4qZBhwd8cabgx/HHliEE0AtIWcz+rZky5M7MtUZb4MqybLVKPI6TEByv9m3JTHqy0M2ti915jvuQcfK/2/fkBq6LOGq4xNH8aZhcrJnfqUCz+NvTzUo8dyI5Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JImqAp9zoln5nJysoPYyHl2b/2Gg4IfkFwSEYsrRYgw=;
 b=TGDfDePAe7VwIeOfnPEs+YA220Ll8jsFEuy6b7TcQpAHnvcJ1DzwicWhnkmQ+ZpoojrR2ogIGdX7dYOIO3Flx25AEawBea89NNgYlCwyVPPWS3hIAO/qvm7rMKdFydmV4jBdEyjqmu76JF/qdmq/PnND9nngFJ/y4ZtfwrRe9MM=
Received: from BN1PR13CA0025.namprd13.prod.outlook.com (2603:10b6:408:e2::30)
 by LV8PR12MB9109.namprd12.prod.outlook.com (2603:10b6:408:18a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 03:55:06 +0000
Received: from BN8NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::c0) by BN1PR13CA0025.outlook.office365.com
 (2603:10b6:408:e2::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.9 via Frontend
 Transport; Thu, 22 Jun 2023 03:55:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT077.mail.protection.outlook.com (10.13.177.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.41 via Frontend Transport; Thu, 22 Jun 2023 03:55:06 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 22:55:05 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v6 13/27] cxl/mem: Prepare for early RCH dport component register setup
Date:   Wed, 21 Jun 2023 22:51:12 -0500
Message-ID: <20230622035126.4130151-14-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT077:EE_|LV8PR12MB9109:EE_
X-MS-Office365-Filtering-Correlation-Id: d5c29e6e-a1b6-4476-db99-08db72d4772e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pA5VQX5d76RgfQpbyvQxpGcsF3qRo61NOCCl1Z/+9n9EDCtfBhXSd43Hi4x7bl236SH+RuzBrvFIDt70h2ZcfCbdKnKtaQYLdUDRB4Hz+JXlJLpSygB/atdmcaahZOWJTdiORuZ0XFzGxmBqRULSYX3v60IQ6jSflem8QZkknyDXtUe4i/I+e6NPAMHRvkH26qH+BUBSLWEHV1l1rK4DsQdd6xCEcoC/FTER89VuskzfOGyqvNwlcOu3aTTn/0VEMRSZM9CtrhNLuLuSPGsmtZz9upcM5gq9NClCW2HKGvGMyXfcUaFxq4dVQI7pMw8GfQrqksHW04jIsr+UexfY9NBWV1tdrJ5MR5tYCn4fc07Xlp11x6aCwTRccUnjG5VTidrR7blkwFQbhLfAdDyD3gtTbIgISHvf3O3slNP8XbP6l/4N7Zf3E8I6poeK2GVLELhxd4vkpHHrW7gPWINAEnBHZIIvNcldeT/yZI9qBixxeigZ+mO6jpnUid9+g8FHqKztYj9fcma6N9RkvPFYQ4tagGmP4uAI3MUyFQW1qOYsLnSmE8JoeLWNWQArxj1ffef4UT/qaqlUcwSTPQu6VZoO+fTDS43omA4y/mHZgIWXyh+W6J67vDqy/mSFbaJeesTOTwTSpR4Voj0W7sUJcTstNEaodIYQ2apiTmEmU3ORK5sZHjvxHvAuaBT1NIE1tHqHTWbLE/njQQF4VxrdJ51ztjoyRJztSO9puAoGxrgeadETMIWLGh2sYgLqlow5fhM1GtMIM1cl6yWYLUUSKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(6666004)(40460700003)(2906002)(426003)(336012)(16526019)(186003)(2616005)(36860700001)(47076005)(83380400001)(70206006)(70586007)(110136005)(7696005)(54906003)(316002)(7416002)(5660300002)(8936002)(26005)(478600001)(44832011)(1076003)(41300700001)(8676002)(40480700001)(81166007)(82740400003)(356005)(36756003)(82310400005)(86362001)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 03:55:06.0937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c29e6e-a1b6-4476-db99-08db72d4772e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9109
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

In order to move the RCH dport component register setup to cxl_pci the
base address must be stored in CXL device state (cxlds) for both
modes, RCH and VH. Store it in cxlds->component_reg_phys and use it
for endpoint creation.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/mem.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 4cc461c22b8b..7638a7f8f333 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -51,7 +51,6 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 	struct cxl_port *parent_port = parent_dport->port;
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_port *endpoint, *iter, *down;
-	resource_size_t component_reg_phys;
 	int rc;
 
 	/*
@@ -72,11 +71,11 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 	 * typical register locator mechanism.
 	 */
 	if (parent_dport->rch && cxlds->component_reg_phys == CXL_RESOURCE_NONE)
-		component_reg_phys =
+		cxlds->component_reg_phys =
 			cxl_rcd_component_reg_phys(&cxlmd->dev, parent_dport);
-	else
-		component_reg_phys = cxlds->component_reg_phys;
-	endpoint = devm_cxl_add_port(host, &cxlmd->dev, component_reg_phys,
+
+	endpoint = devm_cxl_add_port(host, &cxlmd->dev,
+				     cxlds->component_reg_phys,
 				     parent_dport);
 	if (IS_ERR(endpoint))
 		return PTR_ERR(endpoint);
-- 
2.34.1

