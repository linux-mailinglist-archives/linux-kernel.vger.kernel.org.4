Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AFF68EE35
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjBHLpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 06:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjBHLpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:45:50 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2043.outbound.protection.outlook.com [40.107.212.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDA54901C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 03:45:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XD1lEV2jAGllwC29fSm4d5142s7rvi6Y4HKMi6DTjHsb7t1rCdzzugV7i76MNJ8zTxqFhiCLhPWd+a9L4eAJIRzg0j4sxmN5pGo9S9fhwOJs7/yfS5asRAkOxTMChCwdiEuGL90bVMaeCOANb2pwAEIDUqfNwFAfDGErOnjxNWZIDiQi6dLSAmsxTN3NNhaXVH232gqHHOmxe5b6Pbiq7UirJGCGMDYvfMjsk/gOgEx6cDjReUzQGBZykqdbgn9Vev4mspZ5w0WBKbJYYxTvDeTPOGTNmMmDFuvt7qJy8yfRDd466VDGAcetQYg9eqxotTpI5ZeYKglBvq1SqQT4Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBwnBKJO+SIzVEor+gcJ1P9BvVjgkKK/1Tdu1RHrpto=;
 b=OWpDF2zJkaQITxsx13OjzWbhEHh6SyZXv50jz7KCN4McErs3ZxYO9JJaUYiX6iYwwZNl1eE7WX3EApUtGwrPkh1gG1FXjpfuvCeZ8xESnjVuffsc2wnhUL8rYd035ngp2RqDLC3+NsOCnM0NEOFGYN4Pdjo0V2LWLrFk3Pu9Cnwa0C+9Zop+PTdDeJZ86+nWWIDfF4o2Xd7HPKWouT3Cz1AUgdt6gYJ8omgi/+bsYAvaLdVmAadISvz//WzWA8uL4PQ48MhA5xDiXdqTdXKt97LWR1u8ombC+KRLqbTvJ118ivmxAxELMwzlfeIKYBCtRBVZt+NSCuXT6NnKKWGAhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBwnBKJO+SIzVEor+gcJ1P9BvVjgkKK/1Tdu1RHrpto=;
 b=BVNGjBgOchzm6qsVtKnwslLCJNRy6jk8ScjIbFuZ2PqGyF5+bCES0OozoQ6T2/MvwJqhOj795F2HDif1OmeMpaEPgu1J3svTgbBI4GHynHyqM7rxig+w/MKA1cNjPOwDb2WHTQjUPgKSfKze3RlhJOUqlByRGZV5MPFICr7HgAVLpwPK8RAUoYeHj8QrvOwF87OnS16F5VI5HGjYM0m8nIbkfytXNH76VEo6IaNacuR09/QJ7P/iAXrE8sgyYY5ppW81QBszCruTcJIvn0bzyZ+UjRu3L0nfrBJ+Z3Z8t5JuYOXjHggL5er2c63aaP0fznleSWfW+tdazh2ubF2XHQ==
Received: from DM6PR05CA0063.namprd05.prod.outlook.com (2603:10b6:5:335::32)
 by IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Wed, 8 Feb
 2023 11:45:45 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::6) by DM6PR05CA0063.outlook.office365.com
 (2603:10b6:5:335::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17 via Frontend
 Transport; Wed, 8 Feb 2023 11:45:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.17 via Frontend Transport; Wed, 8 Feb 2023 11:45:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 8 Feb 2023
 03:45:35 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 8 Feb 2023
 03:45:35 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.36 via Frontend Transport; Wed, 8 Feb
 2023 03:45:34 -0800
From:   Eli Cohen <elic@nvidia.com>
To:     <linux-kernel@vger.kernel.org>, <bhutchings@solarflare.com>
CC:     Eli Cohen <elic@nvidia.com>
Subject: [PATCH] lib: cpu_rmap: Avoid use after free on rmap->obj array entries
Date:   Wed, 8 Feb 2023 13:45:15 +0200
Message-ID: <20230208114515.1216208-1-elic@nvidia.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT037:EE_|IA1PR12MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f6ceb8b-e5ad-48cc-4636-08db09ca03a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1yqlJJUv98/3U66dI+bKQOgzcMY9uquqxs9OEaS8S1CybGnq2ZEO0f8es+OAgnOlRPpcBhK71zmRiCF2ovpniuz2596+2IIZwX7l9TAml6syGv6eQNgVm5Zgnb3xQf/9joMQFVOq3prbz7OHMeSmhAzaGf6RkfzxzIdD/CyJwoeGwaoz4c/F8UcJJ7QnAs/wYl7iWu/DQ8jnemFLLsQv6erlS6eiVDOdMB5gx2FPq84QdYQKBMUjMMm4iwi8cigRUU7Qrgd6PLH92vjlRTkPA908x2ekHhCRPI2hVEK8m950WXZfV4l8dmh+ROjAyRZSvKG2kaRpSqHy5bvGC4A5w9PjQ6Nu0HEMHEV1fwxtX4ndwu2P19nNapww15BsG75KEs5FxcSOyd9YBmJPae2Mw5jjDBtmRoIfr8y1DYSThby5EZFV3KmiOR02Xuq48+suzsdczhjUm6FU3GBHVH9RWC2DGRkv+/Q0g7mVuqHvUg3gWODNmYobsPVJCnRTRRLmQ1DC+JumhdVazgr2uqV3BUxvPvN3erqtYhPts46lnSJ4BEbi7ntzVK7B6SF3k6b+poUdBrJglcaakNegr5lj9ZsM3/TfmVvtnN4u+wrLO97Zu6bvAbMMZOhwOd6McSUDnG2jmKsz1t1nT8o+leVpxrYIDN4eaje6xTFbp3OBzfQD1P+sBBx8COodOe3QOivl1SXCZ3tsKzhyVyGSMgnGYQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199018)(46966006)(36840700001)(40470700004)(316002)(2616005)(336012)(110136005)(6666004)(107886003)(47076005)(83380400001)(426003)(82740400003)(36756003)(40460700003)(186003)(26005)(4326008)(36860700001)(5660300002)(82310400005)(8936002)(8676002)(70586007)(1076003)(7696005)(40480700001)(70206006)(41300700001)(7636003)(86362001)(2906002)(356005)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 11:45:45.0505
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6ceb8b-e5ad-48cc-4636-08db09ca03a2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6018
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling irq_set_affinity_notifier() with NULL at the notify
argument, it will cause freeing of the glue pointer in the
corresponding array entry but will leave the pointer in the array. A
subsequent call to free_irq_cpu_rmap() will try to free this entry again
leading to possible use after free.

Fix that by setting NULL to the array entry and checking that we have
non-zero at the array entry when iterating over the array in
free_irq_cpu_rmap().

Fixes: c39649c331c7 ("lib: cpu_rmap: CPU affinity reverse-mapping")
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 lib/cpu_rmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/cpu_rmap.c b/lib/cpu_rmap.c
index f08d9c56f712..c2ce2200a202 100644
--- a/lib/cpu_rmap.c
+++ b/lib/cpu_rmap.c
@@ -232,7 +232,8 @@ void free_irq_cpu_rmap(struct cpu_rmap *rmap)
 
 	for (index = 0; index < rmap->used; index++) {
 		glue = rmap->obj[index];
-		irq_set_affinity_notifier(glue->notify.irq, NULL);
+		if (glue)
+			irq_set_affinity_notifier(glue->notify.irq, NULL);
 	}
 
 	cpu_rmap_put(rmap);
@@ -268,6 +269,7 @@ static void irq_cpu_rmap_release(struct kref *ref)
 		container_of(ref, struct irq_glue, notify.kref);
 
 	cpu_rmap_put(glue->rmap);
+	glue->rmap->obj[glue->index] = NULL;
 	kfree(glue);
 }
 
-- 
2.38.1

