Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13E6646FBB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 13:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiLHMcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 07:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLHMcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 07:32:18 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B3A2B185
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 04:32:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cI9TwvIhEXcArOcv8eUKb4kGXsw5T8ofsCSkRdlvCvwu8hZOPgwnjeavnBBiakspZFh4cLS2UjZzfARBRHceTVCUwtdBKjiogGERlebKfBqldGQVGPyc7UuJhdhZG5o6ZMY6wmjScfo2nTjpeBsR/hdxWJSv/HmgG9xrVRRp3HSUitqUwViw5e1faElFXlFDtRGogHRzDJ05NS/IvXphIOaXedtXQHu2jL86nk2IOSEM41Ti28jpGzPVmmiHHweUo8EPVaMDCFWrW1TcY1Z+3Yqo5pvjCVICgykqwy6z1iKNTwm15TLAvEv5+Az7UYeqioChaiHNu+bwb/a+93mU5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20l0jyi++KokQ77gDa4c7arM6BmheRm9LMhq8qCVtTM=;
 b=gShX8FNWN4lxthN3wYRI3YtXVkSbGNWF//Q9LZdEfQv2tNTp/CSJ1ENcbl0VodGswMhVpJJJSiW52eb5U8IXUrP2o3rZeRCkDFmfo8Ecgwbvt4Db4FsEAuDo9pjZUn5UM6ibArqtNWMFwU69IZ+U777W7sU/zw2i6j2lUzkVkj4BgrgHGiHu6vef8oP5RupAW9tX5fH+ORxYE7j4OgzXqzTXOLkvf4F1iHAuKqGsu28LE24qcpXrmIhZRA+o4ApuLCYyPA1ZlQKMwSXcG0IVQsh0cIpSX5iDPkmJ/nFYK17Km/pk2hzTDhlf8TSL7S7iL5GMZ9Q0rIH8K28Uf07MTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20l0jyi++KokQ77gDa4c7arM6BmheRm9LMhq8qCVtTM=;
 b=aTWu2aRuhO9Rt7jHlXrW8gRqYnghm7ZurtdzWVfGp1JNZ+l8Bkrz0f/ez2X18OustaHlV5V5u9zqFYC/H21Z0SEkzeAqrDJI0toonGW3VfdmcTa2n3Pag4kxmxSWL0A/uH3siDAqg7HdM7lsKkXV9J/07fmXDGfGauQji5fhoyE=
Received: from DM5PR07CA0113.namprd07.prod.outlook.com (2603:10b6:4:ae::42) by
 MN0PR12MB6078.namprd12.prod.outlook.com (2603:10b6:208:3ca::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Thu, 8 Dec 2022 12:32:16 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::df) by DM5PR07CA0113.outlook.office365.com
 (2603:10b6:4:ae::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16 via Frontend
 Transport; Thu, 8 Dec 2022 12:32:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.16 via Frontend Transport; Thu, 8 Dec 2022 12:32:16 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Dec
 2022 06:32:14 -0600
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] firmware: xilinx: Remove kernel-doc marking in the code
Date:   Thu, 8 Dec 2022 13:32:11 +0100
Message-ID: <f4c61cd5e45fab345c366a15766101408fbc3bcd.1670502727.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT010:EE_|MN0PR12MB6078:EE_
X-MS-Office365-Filtering-Correlation-Id: b5643995-548e-499f-27a0-08dad9183d85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gOkZTljYARPPyXik0qvmaeCL6QcxRx1pXB68Lsx0i4IO9I5aqxwKcf8ucuCDNgtURUEqk/EtIk+btepkvc43bc2YPPOHZx5H0H5r0ZXTdFROEjFrMb3Q4i/q+EfGNfT2r4614E2dgCM6DIAVWVtQUN3T2zvHvG3aFOyuCurFbBBSSDJCkZkom91Hd/BsVdeMxgwHFFPR/fCxeXBmOHFGapzO9H5M/hozVm6q7apFZToY2kl1UXyLq8aKFQkgUQsYq3yyWMsrmQRx727Q9DZVHYpWjCqa+GdPlIuBNBzMIUJ5X8+Z87+bRlii7nJsoV6n5bVnYyu3cINsdkRspPTehbjWEi5simet4g19qIEnjirm9iipSmgs/cNZCPuBsX+UDNwRJieCS1HO3esqIuX5R21JHpRBJJKYGj1HtGKwsApGH4EWFKORvBL/jiYy7pKcjLJSIAzLT0ZqxBlmElpDL5+xkT4lVtZtAYeOkHNo7nGMuXshjJQ56eiIV5TEESQOVXHOOE+JICCGKz+2zkROHhjvokyeM2/uMuNE3mA9FYtsG0mT1tlka8XHaTN7AiH67UKZx8h1lULERMEpTlnUNwCUlgbwCetYjx61P7Bc9kbTKhnbpIjVFgpK14eIGcQZFP73hkKUqS0TI7Hf0R2ptI55nq17cAp+eup06cuWpeK4FYpjrzNOCoB2YEMtFh8anAm6deSjz0gocveerfqPbVnTfiHx7kU0cvjDq4WIEdFYe8LIj/0JxqPrCgCReDgT
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(40480700001)(36756003)(82310400005)(336012)(426003)(2616005)(41300700001)(5660300002)(478600001)(6666004)(47076005)(316002)(110136005)(83380400001)(16526019)(186003)(2906002)(86362001)(4744005)(44832011)(8936002)(70586007)(70206006)(8676002)(26005)(81166007)(356005)(4326008)(40460700003)(82740400003)(36860700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 12:32:16.0144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5643995-548e-499f-27a0-08dad9183d85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6078
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial fix.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/soc/xilinx/zynqmp_pm_domains.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/xilinx/zynqmp_pm_domains.c b/drivers/soc/xilinx/zynqmp_pm_domains.c
index fcce2433bd6d..69d03ad4cf1e 100644
--- a/drivers/soc/xilinx/zynqmp_pm_domains.c
+++ b/drivers/soc/xilinx/zynqmp_pm_domains.c
@@ -227,7 +227,7 @@ static struct generic_pm_domain *zynqmp_gpd_xlate
 			goto done;
 	}
 
-	/**
+	/*
 	 * Add index in empty node_id of power domain list as no existing
 	 * power domain found for current index.
 	 */
-- 
2.36.1

