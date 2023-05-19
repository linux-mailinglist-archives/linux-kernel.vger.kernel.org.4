Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80EF708D23
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjESA4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjESA4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:56:12 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BDC10C6
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:56:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M77n1xWojgWkNoGaaPbA/2W9IyLz4OwvIXDjRE2fZXJJ6fJ9hp3gZzyG9EvnTtqaH8dXo+65U1Zsykf93ttELgHiLaRbbvlx2wMirA17PK6vaol99B5XRbMJtq9WboV51coNAoEwQmFVVo9Lvi5r5vo8CFrLraVuVsTaB4G+1sKoPRWj/QWZHnqC0Ewom71nrlsrEvte8uE1MyupNs0fAuoxEooqRx1BkenblcWNLIm7A+tbqNwjO7DkIVKaR4h3YzsT2UmeJHbelGh7/x4STMV1Eg2jkzBshvzW/1e+7OhS4fWoG2IWn+Wig2t4aiJ/N7PrgvEJOtaeaUJ3yhbEAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhGNxVBuLU8j6nRMP9u1WkiBJLLOolekgHbORFlHSAg=;
 b=TMWwE53nzRML8EuV8ffzYFf9CPdnLU/mdoT5ZM9pcZHCDgngcflu2OQdbrJbQ+kvFVxfGvdR8NuOmvkVi86IszNQAa39tuIOnnAoOLep7SrvzOmoCnVk6MNrnvos0HmPrsaZe6HVbJCcMXOmjxKpD8sCaupJm0sznJ5GVK69deLAsb2Ih2KVgyqmsxnyWpss+RIgQ2e/56ziiaa4Xacc/4JXJEjb5qLNH97nK96NrurT98s6lLU8E9fc1ttCNV4cF8tQCPahMTmvDNcN2vsfsycXfzq82R4AZY594XjUcY1z9260IwX7hYcQLT8cdnlXX65UKUSZuyYbHa3lXwTbnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhGNxVBuLU8j6nRMP9u1WkiBJLLOolekgHbORFlHSAg=;
 b=YY4+bT5TMOWzCzlrzsOqFRtJ7ltErnnOxR6agfgLk3STM3Ua2Z1JoaA9mq3jzbP95uk3byiYLYwN4OJBK6i71k/4FlBvDcQnTn5gY3xR7PFXKZkfzTy/SbRIbFQ+SKMm5G5Jf7z4DM7x/ZwD7Fov8BX5A6HBaW4SYcCB64IbmNs=
Received: from MW4PR03CA0186.namprd03.prod.outlook.com (2603:10b6:303:b8::11)
 by DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 00:56:08 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::ac) by MW4PR03CA0186.outlook.office365.com
 (2603:10b6:303:b8::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Fri, 19 May 2023 00:56:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Fri, 19 May 2023 00:56:08 +0000
Received: from titanite-d432host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 18 May 2023 19:56:06 -0500
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC:     <joro@8bytes.org>, <joao.m.martins@oracle.com>,
        <alejandro.j.jimenez@oracle.com>, <boris.ostrovsky@oracle.com>,
        <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
        <vasant.hegde@amd.com>, <kishon.vijayabraham@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 4/5] iommu/amd: Do not Invalidate IRT when disable IRTE caching
Date:   Thu, 18 May 2023 20:55:28 -0400
Message-ID: <20230519005529.28171-5-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230519005529.28171-1-suravee.suthikulpanit@amd.com>
References: <20230519005529.28171-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT063:EE_|DM6PR12MB4123:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e2a9398-dd71-4a64-32f1-08db5803d4f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rLVYZFY0uUUPN++PsohbtXEg5Hb6N5zfhou3gn5ntPxQYv3aIo9i88yZQIlIJzBvNmPJdMXZc9r5JSEGjGHmzZKoOtwvtaVwRvuNkUp2KImEq04cd6eeYsNgxjzX5BcG6lxB+KIPjXJ03Top90AwncOexZ1OUN7uj0GyzLfGFHZdj2+tjFhp1U/FRhawdTjzIh7+sxbabDFHfhMWtOsa7TAeyCDdDbellvkCXYlOINrVPGaAM26rg8aa0FBYsKKiqQaGoHcYf1tQz8I2jU1zCF4VC4x0bc2wZV71vpXr+E1ni/jPalGVoJ0T4TMihUTXB638KnyY9AnKM7obxiukJFCa+guHKvNSBPtzNAEH2OdW8fqAhZ6fNCqd/xKpHy61N1mjGeZWo2CweQc/1RkqpVRKlrjCEgID2K6VwloqsaaCGrVneDIIluy0SHWXR0t+Bm3+0/MMk2Pje2TUNFESQDNSm6qEMJ6lLYKCiPa9CJWAwBH89LP1BOxtPirIHVgWXmfXkiGq2sd1M0E7suAXZaV46UJISvV1PRXR2JrGbvYk8yu9sah8QJZVjIym0G+CZS9PRMP3Gy0xghEUgSmk/5fL0hiiSndphSLW5JJu4+KPvFslBwGVf/upOAjf30dUlMRnFgd6MQCH7jMlu9TbqaYYPmpMMGvy0mp7PDOouIjaQ6w/nXrMo57OUX17Uz57IfFcY+PAlGprA2qUfAm0I/QYfCTHretFnEnsHzyF6QXRWR9m0StBFdt0bJ911bcN7Uu9o0n/hM+JXOkXVjPBrg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199021)(36840700001)(40470700004)(46966006)(1076003)(26005)(7696005)(40460700003)(36860700001)(36756003)(2616005)(40480700001)(47076005)(83380400001)(426003)(336012)(86362001)(82310400005)(82740400003)(356005)(16526019)(186003)(81166007)(110136005)(316002)(54906003)(44832011)(478600001)(2906002)(4326008)(8936002)(8676002)(41300700001)(5660300002)(70586007)(70206006)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 00:56:08.2283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2a9398-dd71-4a64-32f1-08db5803d4f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4123
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the Interrupt Remapping Table cache disabled, there is no need to
issue invalidate IRT and wait for its completion. Therefore, add logic
to bypass the operation.

Suggested-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 0c4a2796bb0a..51c2b018433d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1273,12 +1273,24 @@ static void amd_iommu_flush_irt_all(struct amd_iommu *iommu)
 	u32 devid;
 	u16 last_bdf = iommu->pci_seg->last_bdf;
 
+	if (iommu->irtcachedis_enabled)
+		return;
+
 	for (devid = 0; devid <= last_bdf; devid++)
 		iommu_flush_irt(iommu, devid);
 
 	iommu_completion_wait(iommu);
 }
 
+static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
+{
+	if (iommu->irtcachedis_enabled)
+		return;
+
+	iommu_flush_irt(iommu, devid);
+	iommu_completion_wait(iommu);
+}
+
 void iommu_flush_all_caches(struct amd_iommu *iommu)
 {
 	if (iommu_feature(iommu, FEATURE_IA)) {
@@ -3028,8 +3040,7 @@ static int modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
 
 	raw_spin_unlock_irqrestore(&table->lock, flags);
 
-	iommu_flush_irt(iommu, devid);
-	iommu_completion_wait(iommu);
+	iommu_flush_irt_and_complete(iommu, devid);
 
 	return 0;
 }
@@ -3048,8 +3059,7 @@ static int modify_irte(struct amd_iommu *iommu,
 	table->table[index] = irte->val;
 	raw_spin_unlock_irqrestore(&table->lock, flags);
 
-	iommu_flush_irt(iommu, devid);
-	iommu_completion_wait(iommu);
+	iommu_flush_irt_and_complete(iommu, devid);
 
 	return 0;
 }
@@ -3067,8 +3077,7 @@ static void free_irte(struct amd_iommu *iommu, u16 devid, int index)
 	iommu->irte_ops->clear_allocated(table, index);
 	raw_spin_unlock_irqrestore(&table->lock, flags);
 
-	iommu_flush_irt(iommu, devid);
-	iommu_completion_wait(iommu);
+	iommu_flush_irt_and_complete(iommu, devid);
 }
 
 static void irte_prepare(void *entry,
-- 
2.31.1

