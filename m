Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB9968E8D3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjBHHSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBHHSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:18:35 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2703598;
        Tue,  7 Feb 2023 23:18:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9ZnJlPwMZ+6Wnq6wetkeOoEXt6JFDQNH1vxQqRZxjLhUDv+K+21ILMo0aLOTbjhIB850C4Zna7d0alKHTtkuYQ0bi1LAuXeKkZMacP6EpO2chY0Td+tjkLskKtAF36d77rRp/jZpJxIWN9HAQpIcyeOqOQLHQbFvhpclIi3BsXV7xVdDFeowd3dEV0werkQCoK9VqSBKMqTOiOR8TV6nMdIsdEF4ohxOn2+2unX0VF1DttARIrhqBmjr43D/Xvht17/BPyDMGFJ45sw4+QZa8vxmuEdhKmFgK2kUdXSN9Cqmgw7r5W3ELTNVRuq4f7Ziuc9o75OxQc3JDxqjxmAkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p5LL4M59Kg+oguPMAvgNNLUpJCZp+4Gp5zvjumpIHXw=;
 b=V90EvfVTIomEJB/neMAJxUtMznY8zNeOOQzFi6T3qUh1bdTz3rrybTbLebsTQSt9DLqm/1bkN8vpqOGByiCZd5MHCMTlwwDN3Gc3ueLVwazEAjY5ATVQdtiQrBmvG+F99bQ229G3he7XAZwe3s7hpZeR0ofIbX1wSe+2VQ+an21xuUxrCcla8LPRR42ke+N9njJB3I19sNr6PEKw9/OkrGDZ1Z89jiFkzOVRt79OL1pVLqKvn7lnKvtS6IkF+XiqwOJRc7hcHHAgtW4ZmVTWhkUNr3hh5Qp8++3UMux09t1bVIPYKicCDPtCAabfgzXWEc5C+b2fdtw27Jj1JzdXwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5LL4M59Kg+oguPMAvgNNLUpJCZp+4Gp5zvjumpIHXw=;
 b=Hqr1CO4DP5ABqR5RfBo1PFa3uw/HxrtB2xjhMIMWSCr1wmsgPYlgwGKvI9y5Xu+oaGI4McUiAPlPdwFzztZzMyaaaxV/ReRMhiKRw2+0gOVtOTlHnujjuOrSbe++PrXFOmdV1RrHNVQQFbcHdYGsr3NACoR8ilLc4LZ8PtKz24Y=
Received: from BN9PR03CA0748.namprd03.prod.outlook.com (2603:10b6:408:110::33)
 by BL1PR12MB5924.namprd12.prod.outlook.com (2603:10b6:208:39b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 07:18:22 +0000
Received: from BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::4d) by BN9PR03CA0748.outlook.office365.com
 (2603:10b6:408:110::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36 via Frontend
 Transport; Wed, 8 Feb 2023 07:18:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT105.mail.protection.outlook.com (10.13.176.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.17 via Frontend Transport; Wed, 8 Feb 2023 07:18:21 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 8 Feb
 2023 01:18:16 -0600
From:   Robert Richter <rrichter@amd.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Robert Richter <rrichter@amd.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] cxl/port: Disable decoder setup for endpoints in RCD mode
Date:   Wed, 8 Feb 2023 08:17:58 +0100
Message-ID: <20230208071758.658652-1-rrichter@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT105:EE_|BL1PR12MB5924:EE_
X-MS-Office365-Filtering-Correlation-Id: dfca6380-eb19-4995-785e-08db09a4a8ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bg6wn0QlIMdXCRX9OWTqNCT0vMFOxY9HG88EM2+msc738Q4YL7xGOBFCorCgq0inhxfu+eBH/HkFiOn5ROVtdYe9cHVoNrwDoN4LBVlyjOC+56OKLNgniQVQGT6etFrOOfvpJP9NltmLccBExsreRtyTww9N3ihr4UsrpvzPzA4iiyR0Ykk1z4zdqZcdB8bII44gfE9UTCsSxfPxcT5+ecgNrOT+h2hD6drzzi15QH/5PKFCCg+k6f8xFcJ45Fun8HAy1pP1kKEG8RaYDeWIfM2lROGrCmVaHmJReLyHI5Z/PWEeiKJDpAtKQU+Jc/dwYdi1T5NyLhVDHx8jlz4FHeCW3FSHrrnrofactobRAlYfiwNRYAtNm9uV0JTfA7PPMrRU5A9mil62XJqpshfF6fuLUfRpQKQGlnSJr05R/VORd0l4vS8LR8CA/xPq3ZAD5JmZJdZyArH7/9jjwDwbgthSoXlFaRAo+nEbyuxGCRE5k/HIcY3Rl9K2RKgyktX5fujvPlS6gJCkfgEEjpaU//emcVnMQjeuIHdjPZU62SgoT8ANPNKK0VD345b+5n/1GXSHUQN2PjTXdih0Zlj/yCL50uJiaJMuvC3INDGzB0LPt3ZOhBgKBtlO+HM87EFXYW+D9+5B0yZj/tQT8Ckw4+g/1apKeZttPw+TC5yGhGHVUjFEGpUbJc63o/KdXTlqqbRBc10LeZdjw6MHjX2/K3DDh8oMPvQWqanMEkg9tUk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199018)(40470700004)(36840700001)(46966006)(5660300002)(16526019)(81166007)(356005)(26005)(186003)(8936002)(6666004)(2906002)(82740400003)(8676002)(82310400005)(70206006)(70586007)(4326008)(41300700001)(36860700001)(316002)(40480700001)(426003)(2616005)(1076003)(40460700003)(478600001)(47076005)(54906003)(110136005)(36756003)(336012)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 07:18:21.3716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfca6380-eb19-4995-785e-08db09a4a8ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5924
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In RCD mode the HDM decoder capability is optional for endpoints and
may not exist. The HDM range registers are used instead. Since the
driver relies on the existence of an HDM decoder capability, its
absence will cause the initialization of a memory card to fail.

Moreover, the driver also tries to enable or reuse enabled memory
ranges. In the worst case this may lead to a system hang due to
disabling system memory that was previously provided and setup by
system firmware.

To solve the issues described, disable decoder setup for RCD endpoints
and instead rely exclusively on system firmware to enable those memory
ranges. Decoders are used by the kernel to setup and configure CXL
memory regions, esp. to enable and disable them. Since Hot-plug is not
supported for devices in RCD mode, the ability to disable that memory
by the kernel using a decoder is not a necessarily requirement,
decoders are not needed then.

Fixes: 34e37b4c432c ("cxl/port: Enable HDM Capability after validating DVSEC Ranges")
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/port.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 5453771bf330..19591d904bdf 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -43,11 +43,11 @@ static int cxl_port_probe(struct device *dev)
 			return rc;
 		if (rc == 1)
 			return devm_cxl_add_passthrough_decoder(port);
-	}
 
-	cxlhdm = devm_cxl_setup_hdm(port);
-	if (IS_ERR(cxlhdm))
-		return PTR_ERR(cxlhdm);
+		cxlhdm = devm_cxl_setup_hdm(port);
+		if (IS_ERR(cxlhdm))
+			return PTR_ERR(cxlhdm);
+	}
 
 	if (is_cxl_endpoint(port)) {
 		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
@@ -61,6 +61,19 @@ static int cxl_port_probe(struct device *dev)
 		if (rc)
 			return rc;
 
+		/*
+		 * The HDM decoder capability may not exist. Do not
+		 * use decoders in RCD mode, instead rely on firmware
+		 * to setup the range or decoder registers and to
+		 * enable memory.
+		 */
+		if (cxlds->rcd)
+			return cxl_await_media_ready(cxlds);
+
+		cxlhdm = devm_cxl_setup_hdm(port);
+		if (IS_ERR(cxlhdm))
+			return PTR_ERR(cxlhdm);
+
 		rc = cxl_hdm_decode_init(cxlds, cxlhdm);
 		if (rc)
 			return rc;

base-commit: 623c0751336e4035ab0047f2c152a02bd26b612b
-- 
2.30.2

