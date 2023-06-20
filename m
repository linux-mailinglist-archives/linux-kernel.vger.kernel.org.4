Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBC0736109
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 03:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjFTBRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 21:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjFTBRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 21:17:37 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A882197
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 18:17:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/qCte+UO/aJxYx6S7Sg3Cn9tvL181TKnyO5EiPsRm1AeRX4b5b62+F4Dro/QF0a56xst0vRwzr3GSGADoXYYqKvJGQHRBK6m98sCUTq1Zd53SVEK2eqp3rTh+Gd1ILDnb3MICguCH0YIWrOo8O80SysAXXFACoXiTuZdUV+49/kkMUYrkGSpWU0iBGzjVqfRe+yEHMp5x8aPakaW+8Xf3HfPeKiZj53xG+ZKkSSBJQbRExoxikNvgxp+gwRAfe3hb1ET3fGFZCKNWqfm+0Azo3rKsqaOfHFhJhQ9jhP787W6pFFliowCazGjTLQDyB5iXNHYmm3p4xyVjszcS6J6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAgHsicGbXE7/y+61Ec/TG4fp5QK6NCUPay76C4Qy/s=;
 b=fEGVmKbVOGd/81SKuP1P7NH3EchbLJJa6Gbyo4vG7knSIMDN4gCcKYA0XJ5y/5DapHnlpISXb5Chei22plekwtXr+Xr3RLoWikwsUnmRljwBxm6na/W4FObthgLP02i4kRrHvosHIKJ4mRl8omr2GYk/rB4lKGlLMvZLquei9iTS2nDdLGUSk4X4yC9a6UYaV0sYpPXAa5YbZ9XQFC2Sb9LnssNWcffiiRbgEAHPqaRVWnEDJ6hWno+06zDM+fHbN6xQlplNpLPAghny1schny1Q2CqxCcSPTsY5Pw2VmaMpnOF4P/zAR8I57qT/XyYTONCc+WT5xKA7dTVJ6H0L7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAgHsicGbXE7/y+61Ec/TG4fp5QK6NCUPay76C4Qy/s=;
 b=TQtaRKoTsRXcos7BLB+e3jHbLm7EbjxS7jw8ivJN474NSEKa5ZwkvH3MQuEJ+OXQmmmLTx+YD3oywXHccZuWxH6KM79heldyGPg6IGezn0xFdDf9QoP3L+2yGNrymNzoKDdyhDA04PJhY5RrmUWnCpCnRyaWWULaYKKhgazTOwAPCb3f6adCoQKVnK/IdiLiNuOLJVTzBsiV68CYrMOax6f7RTiN28cFFeNp5Re7DNUl2mv7sPFaaxEzjmDl3we3Ws8Rb2eg+AKWu1uDf8fLgU2qnYzzy+E5Wc6D0upPtcotcLZaD7KTripJbNi0cysUVpvAXlcaHzVjtaHxDmjfXQ==
Received: from SA1PR02CA0006.namprd02.prod.outlook.com (2603:10b6:806:2cf::15)
 by DM4PR12MB6375.namprd12.prod.outlook.com (2603:10b6:8:a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 01:17:30 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::5d) by SA1PR02CA0006.outlook.office365.com
 (2603:10b6:806:2cf::15) with Microsoft SMTP Server (version=TLS1_2,
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
 18:17:23 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 19 Jun
 2023 18:17:23 -0700
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 19 Jun 2023 18:17:23 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 07/11] selftests/mm: fix a "possibly uninitialized" warning in pkey-x86.h
Date:   Mon, 19 Jun 2023 18:17:15 -0700
Message-ID: <20230620011719.155379-9-jhubbard@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|DM4PR12MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bbed8b2-9385-4bca-a469-08db712c1e17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xVPHgg1hlmhmbWUPHlyyt00twUTOkvQAv6CECljfOtJ4GKCbBDJMlzFeH6hA0FAO5SPhQ+jDdhP6mP9GQ8AH7zwvQkOaTTCiBfg3jD7mUrZdGS/53tmny+1Z/zRtrWNby4g+OuRoQ1n70O81u8Ay46ctJD4HNkMGIUbU8KgOErwRvxB4NP1khgbNXkBvpHuLaLmhHLwYKjEDebxNcSIWcu5PfGw6ROmLMYRXT3JIQgdRlSw7xxKfBTGz0GT/YVVUCP1BlTi/5sCVblclh68bGFz0tZt3mtYpNeNP0hVzWcBa1AUTurb4AAxe0wqR6+YhdHlLGGuQDACTk0XnC07nhK8u2GXT//sadiqYAPYxYAUODMJ6vA3oswZfhyFfhgRKnBXlYzR+AO486nkGCcZ07UMwzSfCLN5YWjBLWM6uohs3hVnzC97bbzMkcOC/j0xrWsGJw6GEXz2+I0HXBAwhY436wwUBS6s/PKGGRIA4MN1X2UOdAL0Sj3bK+2/PjvENXlzmd1yYg6ULpHygE3y5T/UuwBKLH1dcrSvucejW8fLEx/2YpwAE2i+CnBBtBf/x2GGzFQeUvcwhu8JwHHu1vQMwcQsKA3qflbTRBtZVMW9S/PLlkCYGFRCDMtVl/iHSa+RWsqNlSVsokYZ4BV3RVJ0sw77Xd5kOwqTYshI2Bpxhx5MN+8bWBQKaUnAqpsuLFvKj00a+Un209nd42c+hIayOIRydBUQA4cK0SCrwaOr2w7H8Vjye5nbEqlG2xSz5
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199021)(46966006)(36840700001)(40470700004)(8676002)(8936002)(82740400003)(356005)(5660300002)(7636003)(26005)(1076003)(186003)(7696005)(6666004)(40480700001)(47076005)(86362001)(36860700001)(2616005)(83380400001)(336012)(426003)(40460700003)(478600001)(110136005)(54906003)(41300700001)(36756003)(316002)(4326008)(70206006)(4744005)(70586007)(2906002)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 01:17:29.9172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bbed8b2-9385-4bca-a469-08db712c1e17
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6375
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

This fixes a real bug, too, because xstate_size()  was assuming that
the stack variable xstate_size was initialized to zero. That's not
guaranteed nor even especially likely.

Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/pkey-x86.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/pkey-x86.h b/tools/testing/selftests/mm/pkey-x86.h
index 72c14cd3ddc7..e32ae8a1cd99 100644
--- a/tools/testing/selftests/mm/pkey-x86.h
+++ b/tools/testing/selftests/mm/pkey-x86.h
@@ -132,7 +132,7 @@ int pkey_reg_xstate_offset(void)
 	unsigned int ecx;
 	unsigned int edx;
 	int xstate_offset;
-	int xstate_size;
+	int xstate_size = 0;
 	unsigned long XSTATE_CPUID = 0xd;
 	int leaf;
 
-- 
2.40.1

