Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C299690E38
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 17:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjBIQTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 11:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjBIQTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 11:19:21 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8E45C892
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 08:19:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g980/BHPITFVqnDE2idFhskETz/9nbf3vTsU+seIFHvuF55Eat5PnGCRhJTP3ZzBt/e9CA25lJ1Na+7JDCNtk9+jcP/p/O1ArM1OzesxhbjPq+JxV3GqmXTRbpgJ2szGPLekiefjHXGDlW57PPPGy4A+y08xWweu12oSqL4Q9nIMD60ltIRZY4eDAHnDXQJum3hRNd6UbrxemX1PYhf8XXUs0T03DQVwttdoxFW2sbSTjPbsWeV3Eunc3Jx56XJGaoBCB8dSf3InXkc8RWosoRzasSlnpDDt/lFMmDxtQMRteY1gLKZchjLv+nxgU6sZHAbehM+4Dk2l/q+1kGS3Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbVP/Sf9nyxYduaGi0oWVPqCWbCoEM9UbSeIYG2kvWM=;
 b=VnUvwtPDHkH0Mk47BdtJh+AkIQ1CNJdHrf/0q4xn9g1pWPgUZyqQGeLjxjHVZsFaG6m0T5ZpbIBYZB0t8tEQhh0sCgFounkdiTcS5ILp3jp2shYQ7TVChk3kCo8Cd6Yh9wXQ8a4qSp9pzTHRMKwes9gcLsFsxUOgTN+EbU0L0lNyuxhon8yqWCkPB9mFr/xHg2b/Wng2EW6ccp3ti1u6eo5LeTmiDvXMcIhkoUUuZmYW1NBh9sedg+ZEp3Iyla1BlIkc0/og457kAHftuBGl01lFhTKyitHMeSr9ZDij/hkZz3qyP0ERDkFLh76LABqYHMDnZ1alNvLPxPUw3F1sCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nod.at smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbVP/Sf9nyxYduaGi0oWVPqCWbCoEM9UbSeIYG2kvWM=;
 b=pZ+Mn9gOkz7xBZMFgixUgLL1aC1Snsum1kZjoRB5AMW8WTyVl/wEfG8KUgOiRxPIMCeZe2hiKik7KVuhu1fC2KOySl902ufb8TFSh5y36f+rEG1LpwVIutbAlh5ACs5S5EOze/ICTnTbzopiF2FNA06LJtkWCeaJSk7JLMrf9SQ=
Received: from BN9PR03CA0715.namprd03.prod.outlook.com (2603:10b6:408:ef::30)
 by SN7PR12MB7811.namprd12.prod.outlook.com (2603:10b6:806:34f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 16:19:17 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ef:cafe::a2) by BN9PR03CA0715.outlook.office365.com
 (2603:10b6:408:ef::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17 via Frontend
 Transport; Thu, 9 Feb 2023 16:19:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.19 via Frontend Transport; Thu, 9 Feb 2023 16:19:16 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 9 Feb
 2023 10:19:16 -0600
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 9 Feb 2023 10:19:16 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <richard@nod.at>, <anton.ivanov@cambridgegreys.com>,
        <johannes@sipsolutions.net>
CC:     <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Carlos Bilbao" <carlos.bilbao@amd.com>
Subject: [PATCH] uml: vector: fix definitios of VECTOR_WRITE and VECTOR_HEADERS
Date:   Thu, 9 Feb 2023 10:19:16 -0600
Message-ID: <20230209161916.3729757-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT064:EE_|SN7PR12MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a9b0a0e-a3de-4022-33c4-08db0ab9642e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +oKhXL2+iq5a6APnY0R0uBOBexsU8twv5zMl/qoQKI3wM+n5QXIbnsAvPkjv0O5DnaVjB+CRXnsnci7HCAbxFqG9mkungql1JpiviRyuCBnJxR2OhNHz71/EM7FIiFFhQXmy6zxrT+rOT7mcu8/SYSAxrfy/dNrynrtSa0x0FxH11oUcWO/z9INNYQ0hmB+/3QnC9pJLNSCrwYgb6rmTycZ4Ioo8olYkrpACURiOdTIDydu8yQLLj0dK6DtLq4a3PW46ZuLRWxBJ9sqitDesAlbjKRQObnhsQcKlQS6ErN48h4jsRqxcoMuscxAEHmKpO8qQmxAmATBNQszElQtPKy1i6ExK7oVt+S3rmZcuU+wTukiyfhYw58EFKCUdWsY/TWyrfqe5W1Gu0ayfU3O3J7l2cTereaCP0bkUM/6Z3BN1tzNHNIsxOJhhT2AFF8lcW+Q4ILcX2loP6HLlcUl0G5wLWRVdyuaApETg28Vkl4x1DCF8AOB8aCaH2oS/5LyRKIyeaGLXageTSsyQkVXcxXp46oDIrZl7g+P03W9PvN0r+36Tnh6OL3fauQCOsOx0LI4F08BwJsFJqj5JNNDWhyt4FnXFP41UPlJOFRqLEjMRg7K/IIgUulv+I+XG0NdYIaiN8KUYx2zBhLaEkZN52I+zL+ZZC/jAy9nTguUjVEz/kRvJz3ds32t+mCXTeg6z5r7eoLI6p+k1/jLOqeuwMcX+BLt4eXFo6dWjP/KWkSM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(36860700001)(44832011)(4744005)(2906002)(82310400005)(86362001)(82740400003)(81166007)(40460700003)(2616005)(110136005)(7696005)(1076003)(47076005)(336012)(186003)(26005)(40480700001)(36756003)(426003)(356005)(8676002)(70586007)(54906003)(316002)(83380400001)(41300700001)(4326008)(478600001)(70206006)(8936002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 16:19:16.8565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9b0a0e-a3de-4022-33c4-08db0ab9642e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7811
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix definitions of VECTOR_WRITE and VECTOR_HEADERS with proper bitwise
operand for bit shift.

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 arch/um/drivers/vector_user.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/vector_user.h b/arch/um/drivers/vector_user.h
index 3a73d17a0161..f7d3956f5c15 100644
--- a/arch/um/drivers/vector_user.h
+++ b/arch/um/drivers/vector_user.h
@@ -68,8 +68,8 @@ struct vector_fds {
 };
 
 #define VECTOR_READ	1
-#define VECTOR_WRITE	(1 < 1)
-#define VECTOR_HEADERS	(1 < 2)
+#define VECTOR_WRITE	(1 << 1)
+#define VECTOR_HEADERS	(1 << 2)
 
 extern struct arglist *uml_parse_vector_ifspec(char *arg);
 
-- 
2.34.1

