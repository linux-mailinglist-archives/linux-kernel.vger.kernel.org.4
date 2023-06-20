Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3895273610A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 03:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjFTBRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 21:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjFTBRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 21:17:37 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021591A4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 18:17:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=briS3izfefAlpqtvsxXj+GDuRLVfL8j+dGW64vE/Y+cFbAMOPZ+fpdtD8MjZ1Yh4neG+CyL6vPlkL81xmvl7BLQuCn200Q173ukUiN3sugcccpPtm6G4g2c2Lt6Zn0GQvB/cQGJcMnMB52DZO72C1KFvG4Z6YXQWrjkkJNdWzikH01Lc5DP6lW0qsLYtGVocJzCvd/cBazwZ88AitUZznpORL0WQKqk6iAvLsdNCIkybVMkdrP3R2b/Cd8Crv4JV8aJNg1X1DJIeRzaHpVtRx+d3WQUJv4tIoJGIXGIozfT4VWpvFKvLtiESGCyqwF7JaDS2/NEXYjDL1JpWayoLQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ToV4OSx3QPDe8A2n5xRR83mlRss/zXSB19ewrV89/Lc=;
 b=FwRd8AmBxTx+iiNFME6enSNbzdDLDVp13+EAkgKt5E7pVI56AjPr7X9AAZHZmzcZWUEGOx17uXIp6FwRd1tcQV0resM66FxW9g53cB59hx14aLr0XonJWy9iyG1gbqrzaAQoFXwkANYeGdZsGMQjpr/cM6Ko9E8dvEa8GRosY9wsSw6x7monFEg83KDIUc5P+bz0VN2ZZuxDGBOZbZw6MnVWipwJ+SuCpM6YMQdbgotmjLbM0T/SXbVvyfFgOC0voDiHVOXRg8CLrqzRFD4Djh7SIA2ofb64z7HX6MaaTohD59QU986pvynNk+oKFwxAS5s54nQr3W9u9STvFFBDzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToV4OSx3QPDe8A2n5xRR83mlRss/zXSB19ewrV89/Lc=;
 b=sxrkxh9/kV8tz+ictTW8nFCBzF86TG80VpmmQwvOYAJMc4d1HhPUTr4iohsZ72BOogfwFuajeZjzzaQTnrOuLFxVVCNsWN2j+FDlKWfS3OMgWNXZc/gA8rm3nGYllb0FfqI7n1cbQG6uPxIdp7dnO7p0MDSv//Pa0CvWVja3mjzT8SM8UfAG5sCPkecPclcSlVoBMGQN2wQSd7Y0uQ6dJKHdR3hbzBqzQOI1C93bVgydbebZ4mACQY5EI3ayC3P1yKX8jRemaW/1LfAU70x3D0lSSe7uVOZBZs1z4hcd0dMIQZUVH0r24/yQjrLc6K3+j8bq+1wFxtExri6gZHisvw==
Received: from SA1PR02CA0007.namprd02.prod.outlook.com (2603:10b6:806:2cf::18)
 by BL1PR12MB5128.namprd12.prod.outlook.com (2603:10b6:208:316::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 01:17:29 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::ad) by SA1PR02CA0007.outlook.office365.com
 (2603:10b6:806:2cf::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Tue, 20 Jun 2023 01:17:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.17 via Frontend Transport; Tue, 20 Jun 2023 01:17:29 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 19 Jun 2023
 18:17:22 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 19 Jun
 2023 18:17:22 -0700
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 19 Jun 2023 18:17:22 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 05/11] selftests/mm: .gitignore: add mkdirty, va_high_addr_switch
Date:   Mon, 19 Jun 2023 18:17:13 -0700
Message-ID: <20230620011719.155379-7-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620011719.155379-1-jhubbard@nvidia.com>
References: <20230620011719.155379-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|BL1PR12MB5128:EE_
X-MS-Office365-Filtering-Correlation-Id: 062919ea-3105-4d1f-1e04-08db712c1dd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A7TXdtNcupxPcQPInqgEiMrdFmBH0c22yZ4TnH9U/bcv224FYzr+1hIekb92HYbJkb66wXmnBDfB99QUgZbz6cjLNcv6eb+LREEBsOUxt1ToJK1CFTb/L6YOF01PaUgtV12V2xN4cv8sf24KJcbS3wWiSktCVKntG4DsZ+eb/BUeHsQPNtc2Dg/4JvNuLzw1WjwWI1mMPu6EuiQnEQkZt7hQtVhrWbBwd9v6VsbSKwFCBJFsfWe1wm2FzbE7NZfd4fq4kH+1aD2Fq1NETIJhIEw134WKWCeghjH0WQpQs25jVI4qjNN+2FNkHKsjy5rn3hnFP8vdLU3I+pbLtygPxG3PSuSqD40LNu2hrSpU5pZBP4+QBJrhl1P6fPkV4Djtp7WZ6eUfr2Ad8nYOgGrz61htlDHIua4oH4ZbX2mqtjdgYKlxhwMqQuBKRzh1kNmKKPVChWjs5wa88gl2IKXb3nB3kNeFT/npE1vMmZJUUXMsWlOeG1YWhqeXIlt5BVvkxWc0bNo0QT1NQhN2JqLsjtl5I7pfMOKSs2/t6/Bs8w9GUyupMWNF8eXE/1ac8UYpz/ZyAZcBDUIvWCkq1aFEmsMArLJt0H79nnm4KMfrVDEOEm48gKOXFFxjQOIW5rF2DELTM9Z37OjgYkpcbkHA8yOo/BFIkV/ppGqqgJMyp5ZnZLTBjQ93gB+DYxXNk6ec1N957K2yqjLC5wPUhkGwJYHxio3coiq2229GnXAgmBu7oyuvdEDtSIewoH70TyAt
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199021)(36840700001)(40470700004)(46966006)(478600001)(6666004)(70206006)(70586007)(36756003)(8676002)(41300700001)(4326008)(7636003)(356005)(2616005)(47076005)(40480700001)(426003)(336012)(82310400005)(86362001)(7696005)(2906002)(5660300002)(110136005)(54906003)(8936002)(316002)(4744005)(40460700003)(1076003)(26005)(186003)(82740400003)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 01:17:29.4329
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 062919ea-3105-4d1f-1e04-08db712c1dd0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5128
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These new build products were left out of .gitignore, so add them now.

Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/.gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index 8917455f4f51..ab215303d8e9 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -39,3 +39,5 @@ local_config.h
 local_config.mk
 ksm_functional_tests
 mdwe_test
+mkdirty
+va_high_addr_switch
\ No newline at end of file
-- 
2.40.1

