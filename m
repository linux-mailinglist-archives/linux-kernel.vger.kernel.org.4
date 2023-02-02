Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553BC687DA7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 13:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjBBMni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 07:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjBBMng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 07:43:36 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2124.outbound.protection.outlook.com [40.107.223.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6978D42A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 04:42:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9x5AVPPk2pAC8TJfeYRaHpVL4GlyzRI1G/z2lBAF+ryznCzj/RKDzZ+9ZT1MWVwPkxqAXwXU7NNoM+6TkbXQuLg1PuyC0v91jQGGdW1GhQZvkCpbiKu7NU1K5Ws0JsTf4YTUIN6GGauoenYFI8GMaUehN+YcEABFVu9auoUp6l1bKsjYCrH7niKSnbn99ZnoPlxxb48eFWkEr7C+iCDb5d0QUReqWuNw2Ej32kSDlslBnWmmTNr0FHZhDDrg3ZDV12WkT+FI5uxc6JNzIU3CEHDncuDFtFRSWdX7+RWoX0BvpmtyWIzwuqaEe8ION9drIT/hAqSv1pR32E8750yfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2Ux+NgFP24LT85zgffYOFdrl2w2hyjShQQDiQn3elE=;
 b=ZatOyWsUbuMRh4HP+OA3F8J86kYKJ1Ke5k3hEM8pzC1mVdtAoWJW63tQHQyXg8M0pFsHBYHwd4p/R+uPNKB9/sS++kBmXD4T6p3weTP98Mdci5ao0sbUk3qITx8U79c3HN2SC2urCbtXdU1K3Lee8sFJi6EbQNiKJi6IbH16huQprz2CanYwxE/+2aqZRaEobgPc/EM1k3SrQH+vVy+3i27GfAR5Wyl1HcxQPLvuS45W4N1tieZdIqYJTvBRe+kx9e6mXf8lHqaMdtPjUQQImNOQepnF9AWfx0ineeGB9qkHF4+QUGvDMeMTxXTHfhRa/lb3eS2NpEb5ZPAfEn/94Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2Ux+NgFP24LT85zgffYOFdrl2w2hyjShQQDiQn3elE=;
 b=U5genDZYLkOvFXXXTWfrrxAGZ2COrP2tlkJCVU0c/8/E/NWNqueatrpQZTGgrYKI19z8gnRJZQ6bleDNVmLttmIhqjjDvp7bXmYPGboSrS5Q5PpixXOtUyqyoR0IK6x2UzHglvkTSZrx02rDI+soLHPaSLpZQbNpflngj7SMuz8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 BY3PR01MB6689.prod.exchangelabs.com (2603:10b6:a03:36d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.24; Thu, 2 Feb 2023 12:41:14 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::6b5b:1242:818c:e70d]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::6b5b:1242:818c:e70d%3]) with mapi id 15.20.6064.027; Thu, 2 Feb 2023
 12:41:14 +0000
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, robin.murphy@arm.com, will@kernel.org,
        joro@8bytes.org
Cc:     jean-philippe@linaro.org, darren@os.amperecomputing.com,
        scott@os.amperecomputing.com, gankulkarni@os.amperecomputing.com
Subject: [PATCH] iommu/arm-smmu-v3: Enable PCI ATS in passthrough mode as well
Date:   Thu,  2 Feb 2023 04:40:53 -0800
Message-Id: <20230202124053.848792-1-gankulkarni@os.amperecomputing.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0053.namprd04.prod.outlook.com
 (2603:10b6:610:77::28) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|BY3PR01MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: 25fbf559-9139-4a5f-0d91-08db051ac573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6vkBXr03tQvbDRLB3NH/fc7KqZVTgRTr07tY/I0JbrXgplS0xOjUX4yq+iwtQln+ZnVet2F3N5IjR4GMqhFSALhMJkXl3urbZQTMH2AjTLDh9V98lY+sMJ2yvNYxVicPuJZhZsFYBXbsTZPDjHPhHt09xmCidsMitzjn3FkPqI0zEFxl83BJiunWdEaO8nr+cjDPzEs6HbtN7vrDnbx9KNAvZ3QT27r7xZMi7uNej68QWpKd07vNX5DTvZOoWKbBioWVlSnMlMLMfEBsOeV3AHo8aB0GiVm2w9WumrGfQ+8b731DwU7LNH5oM2TMPdykC/8aCXIXPyp16YqyWosV3cenp+UhQDNKr8+sqx28C86dw+Lj/FrxgRDKkdb41fjvrM/3cAEe9JxSqeBJ+ummOtXU8hhW2Kl/WoLIYeISITJUBXRX+fEZKTRh0u49AvGpqRpAZVC8NGG7kFJUigF0F1g1AkXCg1XstLyQ0tJsiOX+FwL72gUgNYfvMeU4tyCV3DMGZKi+QAY37JZXU9afNc+PIcdVz/YzfvDNMIXI+gY9uwtXsciiFKqriJeJNFrYMCaB1vCZDjmiRO891LvvTlMrAw3nNYKPDVCjvcC0tqasIEwyqtYm1Uj6MKDOjrt87/2etVA+PLOHW0symbrSN3402S+0qoG917s2Mg4hp+S4eF6xf9f3/sJEqLKvBCef3olyVV43aFwKaL/kzn7QzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(396003)(366004)(136003)(39850400004)(451199018)(2906002)(6486002)(478600001)(8936002)(5660300002)(316002)(41300700001)(8676002)(66476007)(4326008)(66556008)(83380400001)(66946007)(86362001)(52116002)(1076003)(6506007)(38100700002)(2616005)(6512007)(186003)(38350700002)(26005)(107886003)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bSFKmPSomKCnMupTSDp2wAXqfilZG9xno+8lnvb4QaZhEeWvb1kYDwZrvXyc?=
 =?us-ascii?Q?PZxpL3FXyHreI5Gir7pK7CnH1J6RXptRly6DIYgRV7ZnKWX0Ny23hl3fgcnO?=
 =?us-ascii?Q?lMNat55FMFhk8dbH1JpXrl7PXqoQ7M/aRUWf0Gpk7j/MRyYdv+Dm0Xz7bFhe?=
 =?us-ascii?Q?E86THXWagyptD1HYTr5qSebbTQSdPdAphz+mHFdkibtFxc7hL/zF/tH9zH4B?=
 =?us-ascii?Q?+tJy64q6dCuIW9a0y6hU4N40V4OIJsCXbMdB6SnyTn0SKnv7t9xA+oqMU5iq?=
 =?us-ascii?Q?Gd9X6oC+P8aCxnwVT726VKpg4EdnhhLB77prehzgSt5iRj9PsIVsDpASnM9F?=
 =?us-ascii?Q?crWn/y1SGDBR28XWWGOEqpxHTFXJ7m9BBNJJH3MXR42K4kRZ25gcvHbZwoyp?=
 =?us-ascii?Q?wDk+rJIKilNWcb6gvtLDBuLKwHo9qySyf1Da9SHiWRvGz3S/HR84JsuVdnrN?=
 =?us-ascii?Q?aCiBUBUrkxSnYXf4HH4wuBfxYHkmlAYOeZBccuvGAa7kNSd3HyzADlFXw7Lj?=
 =?us-ascii?Q?amtSBSxvJ6TA9QVCYGEr/a7lunHf+tbupApBJtZKcO6IV6kbJoe06mNgh1xH?=
 =?us-ascii?Q?cGCTu5FT3JG8+OpnlPgJxq4k6WBIq0SNyPCjJ1lSRfpKKfkVtKqdcRdxmCQJ?=
 =?us-ascii?Q?4+MONS6/7vx5AZhmHTf3YKlKxgdUTgCNHwk4Jzk6yMo2zGprD/zgvOnvRFWN?=
 =?us-ascii?Q?lPeeqv0of76EVmguhGUA4PO20CWViRLiFQQ10ryLpgXy0orCQyRMeQWGuf9G?=
 =?us-ascii?Q?BhoE3dMCaMb1X5Vd9+H8ruZSvGwN1TbvCUafVs3K6MW2H4/hnKWPNPoSJ12Q?=
 =?us-ascii?Q?yi7INKbwqPiLRB8vEQcOJXJwnZug/63OKLIO32R8jGr819ernxU22v8cWxif?=
 =?us-ascii?Q?Nyc6LhE9BMan6M1DcuhbEkFyiC7pcb6hGA2xEHeOJJn8vclX8iTuNTTrOYTX?=
 =?us-ascii?Q?ZYp34kfQ4YO8ijFa8nrpC54IXPuvdimKJuh9ayfI//PxcDKKCPxsGAzDBXZl?=
 =?us-ascii?Q?RyIrf/G6TEtK30TMpo4L0kioZ/3SvcCYi+kj9IKgrpiyO1rcH0I753Z4bVNQ?=
 =?us-ascii?Q?4Pr6a1ZKoiZYUIdUyBk7BFjZcYRjL24nHBrzN+HUuhaUh8pyNuIbgfwO4LOt?=
 =?us-ascii?Q?WbeFZTBCVK8uvbswZ81r2gB4HemKFzAi2yNMm5ZvHxULKvDJFyBf0HuNUm3I?=
 =?us-ascii?Q?fdX6df7aEPtdpkDdinJfasyzNhT8sxf9DUVrBu4LWjra9Gpfw842Q4+QNrX5?=
 =?us-ascii?Q?rs7wFVssX8xcIE3n+5IqUVb8j1dcqHJxOT8A/Q1yLm9N3f05IioMCqbdG0FU?=
 =?us-ascii?Q?3mxXJXINv8REgUn9lb0s7bhSJfBuKq1gTjwmHuDyZyeXr+YvM0ZJ4hw7jKqf?=
 =?us-ascii?Q?TbYVDYajRtZVVVt5sCBs4zdMrOKmK7r7T2dWh+DuM9DCaUl3QewLhQyoF+/J?=
 =?us-ascii?Q?wQWZvP9+mtx5oAVKstfUjCAyb7kbq9o9KTlENVNVte+R2JIGJCuxeR1TpvKx?=
 =?us-ascii?Q?4jNmkVaFJen140Ln0fVnezHx4iMIW5jqm8U91JhRJ4VarHqumzynWvGSUys5?=
 =?us-ascii?Q?3hGbrizIs55aNf1zT2iNyRlt6v3rPwaGuZ22Km/Oxem+/f/NU8zVKqXVhoOd?=
 =?us-ascii?Q?1r/RPGQgwphajVWaBgKl2xA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25fbf559-9139-4a5f-0d91-08db051ac573
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 12:41:14.4870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9obSNp/BVMPZW1zjQzkm+nJ4bb002nPbinRlOVkkYN6YBCah8O2h4fhbld23jL8yQznuD60orHDoGn0tjIAy30TiAU6SGidjv2TV+sGhiuhWG1pEKmLdDe/fF8dspAR2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6689
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current smmu-v3 driver does not enable PCI ATS for physical functions
of ATS capable End Points when booted in smmu bypass mode
(iommu.passthrough=1). This will not allow virtual functions to enable
ATS(even though EP supports it) while they are attached to a VM using
VFIO driver.

This patch adds changes to enable ATS support for physical functions
in passthrough/bypass mode as well.

Also, adding check to avoid disabling of ATS if it is not enabled,
to avoid unnecessary call-traces.

Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6d5df91c5c46..5a605cb5ccef 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2313,11 +2313,16 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
 static void arm_smmu_disable_ats(struct arm_smmu_master *master)
 {
 	struct arm_smmu_domain *smmu_domain = master->domain;
+	struct pci_dev *pdev;
 
 	if (!master->ats_enabled)
 		return;
 
-	pci_disable_ats(to_pci_dev(master->dev));
+	pdev = to_pci_dev(master->dev);
+
+	if (pdev->ats_enabled)
+		pci_disable_ats(pdev);
+
 	/*
 	 * Ensure ATS is disabled at the endpoint before we issue the
 	 * ATC invalidation via the SMMU.
@@ -2453,8 +2458,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	master->domain = smmu_domain;
 
-	if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
-		master->ats_enabled = arm_smmu_ats_supported(master);
+	master->ats_enabled = arm_smmu_ats_supported(master);
 
 	arm_smmu_install_ste_for_dev(master);
 
-- 
2.37.3

