Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E687395F1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 05:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjFVDwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 23:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjFVDwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 23:52:40 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7E51FE0;
        Wed, 21 Jun 2023 20:52:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LtkG0gooAB7a2eY7u25GkAWUVmcaC/PdGMdqO/ACkuUVoSaLjjoL137LpMUPz9bAy2bXYBA8EJoTkb2wxf544caOJo76cL4Gm21laOmb+0OIvk1nw8Fdn/cWlhgPC433PLDEa9FLrVqpBqnWPfClmCdLCredV+t6DP3i96xPXgVDGVMmBe/cOO/4mYWImwxKuiXXzQc3l+8M72wxIn37lJGA5s0OIIOnxPY4gin0OPUPcC37DmY5V3IB0HJ63ajbhKKxBIqS/QAyzpX9P95PaMnOnCW+3oMNfMJ1kmkUwEI0/Ks7dc8ttrgjuqiMn0agcGrSYRYZfcvlSzQsugiaDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mJVwN//roLFXnM4z7Qf7OWctnklzFk03oD5lVna0qU=;
 b=V/jp3IxRbRNtwGGPRaFZShR5SGqt+580IL3q+5GNFj4pmscmi8ZlSDPWJpMDYjg5azV5xLStngvMcjN2cF3/wkyTMINQ1Y+uqAk+GP5+bvMlxz9oVUHsOr1a+I52zi0shMMCfRWCi0z3OTXV7vk0920jFTxuSySba2wlskCds8TNP84SdTnW8Y8VnW/qv4pSqZ0lvxNPOkzQs75khteavdBRip+eb4a/gPNUowT+91CIDK6c2AWajy9sN7Kww28haMIwR4F6up0ELKkmT56IXoTmN/waLTAKrupTtZD5OIVtBcHeEjjzBF7fpmShNdGstoCZG0JiUowaIP6IMKurIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mJVwN//roLFXnM4z7Qf7OWctnklzFk03oD5lVna0qU=;
 b=bkAJ5lKGSMkzJDpWz8Fw86X3GOBLAYqyEurh++C+JW2oSFCXfneoFSYNVlpNpLA+bcMw1vWpG/ZV/WKBMpaGcbHfJcTedbDPRlBiKnOrF3BsvxEnQu5hYgrDqowXTt/DS2MYXIy6kOQaPJ7FVFwof7IoTb6GXjrLHVjJhT/spf0=
Received: from MW2PR16CA0051.namprd16.prod.outlook.com (2603:10b6:907:1::28)
 by BY5PR12MB4242.namprd12.prod.outlook.com (2603:10b6:a03:203::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Thu, 22 Jun
 2023 03:52:32 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:907:1:cafe::6a) by MW2PR16CA0051.outlook.office365.com
 (2603:10b6:907:1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Thu, 22 Jun 2023 03:52:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 03:52:32 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 22:52:31 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v6 01/27] cxl/port: Fix NULL pointer access in devm_cxl_add_port()
Date:   Wed, 21 Jun 2023 22:51:00 -0500
Message-ID: <20230622035126.4130151-2-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|BY5PR12MB4242:EE_
X-MS-Office365-Filtering-Correlation-Id: 6db536ca-ba78-44ff-7247-08db72d41b7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z7ZfV5sn1g88fnYWMorqL1JrVtoGgBn+vHjStBBHP3p9/0yb1cb+QY419Dtrk1lWvPsoVWlioQaWrlkU62jd28xBIoFaj5PpwZEtZtiOSeAv/7mRMtW+UZVHNNr8Wzzu4GDr/CLv2b5YcbCKb8fG7hTFiVxIBulr8jvxWzKrp+Nk7/DtRQvsgGOTZKEtpjosDT8EVWuhXfm/eODQKPn0H3N+wpRsVAlHuU0tymdfJ+Rj8/OFcARY9KX4E2p6MPdBb1KvNpTlgDObp10/C+fYrmu1GTwry5rY0/BD3PCAk6tCkxdkFkoi+TnhwWo4N2uVy4y/EKYyHYAlumXubAcs898ASk1ePPcfneqJl/zRENu6dKRNkFOxPtwlK5ity6Dbn+PXwAUJtzIf3a64lDEQFiF0kbwepF0IEbXheFIJKpr61H7THHgwj8fiC+i4+PXFyMtjbP4FUT1YWUFn4h+lIXirKuFB6yNqIgJN50kMU8V/vK+EC9g5aqdR6BY01f8Lyj8Sd4RGv9yV8CNNYp9opAKg84UlBzGBZITGkFYA+WazngrIm8LG7GRwz4dWG2fqDP0UZCgKuVr4uKd2sgCXbq2ojzenQmDH7eTChrFnzj5JQrGZAqmuL++RLvhlJJbrqw6CNds5oRL3eaDRqNd2CkppJdcRhyPW0AEcxIKRhbRZ4EOf3RUhHWzn/LqaY9FAVRyjEhxHZtNGKA5SHYT3Q5a3V5FCxjaVgYcRAREZZ3cOZFU2ocXT3LsRvAqUW/6k
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199021)(46966006)(36840700001)(40470700004)(36756003)(82310400005)(36860700001)(426003)(26005)(966005)(47076005)(478600001)(7696005)(336012)(6666004)(54906003)(110136005)(83380400001)(1076003)(2616005)(186003)(2906002)(5660300002)(7416002)(44832011)(40460700003)(81166007)(356005)(70206006)(40480700001)(82740400003)(316002)(70586007)(8936002)(41300700001)(4326008)(8676002)(86362001)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 03:52:32.1137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db536ca-ba78-44ff-7247-08db72d41b7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4242
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

In devm_cxl_add_port() the port creation may fail and its associated
pointer does not contain a valid address. During error message
generation this invalid port address is used. Fix that wrong address
access.

Fixes: f3cd264c4ec1 ("cxl: Unify debug messages when calling devm_cxl_add_port()")
Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Link: https://lore.kernel.org/r/20230519215436.3394532-1-rrichter@amd.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/port.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index da2068475fa2..e7c284c890bc 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -750,11 +750,10 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
 
 	parent_port = parent_dport ? parent_dport->port : NULL;
 	if (IS_ERR(port)) {
-		dev_dbg(uport, "Failed to add %s%s%s%s: %ld\n",
-			dev_name(&port->dev),
-			parent_port ? " to " : "",
+		dev_dbg(uport, "Failed to add%s%s%s: %ld\n",
+			parent_port ? " port to " : "",
 			parent_port ? dev_name(&parent_port->dev) : "",
-			parent_port ? "" : " (root port)",
+			parent_port ? "" : " root port",
 			PTR_ERR(port));
 	} else {
 		dev_dbg(uport, "%s added%s%s%s\n",
-- 
2.34.1

