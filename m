Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E64725379
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 07:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbjFGFjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 01:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbjFGFjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 01:39:48 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99A819BC
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 22:39:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=moWFisFp/daL9VRgxlaeDUm7jZBHp/7RQkHqMyuPVkBj5bARlwpOWx1t3HP4Tp/Oc5aOwM4JunFYGrsjLms0TlB9OLS/jGfGT4354eEFP+/ecHTnybpxzwtP6b1gwxO/kNgLRD9yd5C8JbLXYYS6a3ozAxYGMKrC3lgpFLKNl2p4NFdWfJJtJjtJWS727nnMtAmXQWJMy28ZMPUbZs9ZHIdq3R1yLsY7sLyx0tac5UqbTN2ztDredjbnUyRgyFRBeMR6uGfceN601ppZM1gJ1j9FnOfg6sdy2gksGKVYvmOYHvy2LH2V3hdXkHRIAj9b4+8ltOTBf5O4k5I+xZmxNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kl+/zgvkLCFkuHZQx+c1i39URpquNef/lyGZyxgXdjw=;
 b=Pwepf41iCXtu0biVb5ot9sSvb2NFBjaiIVcT0RQa4gyOcS1rmrAogvaQQxXLUNfbLGZIWXIwAWhTv4GBMiT6FeoFOMSy4XybuYzTjz1M2LXY/6+F0IaseVyBf4DARVhLVu9C1IvPvLeQokiEj48SpgL1EbubRe7KQEKMJVfYoHHZXcXl2XCrKsM+XnvjvVJkhfmaA1cbSi2LAMK8oSXQYd7psSUqL7dUG0Zvqq1wpY6WXBDBkqvqFYPR3HPqQcdR8+d9lZLx0SZ3YAq+0f3h8m0nP60SbTdLfFBup/UqhvHUco7SVhOdHA+aljm5NqTVm+mVKu/4sJ12K/YMpYyfzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kl+/zgvkLCFkuHZQx+c1i39URpquNef/lyGZyxgXdjw=;
 b=ECin2Sza7+PwhoStXoqDkn3eqRnc9zgR8DyEae8+V4D/taXsXyKrsoYefPsyuc1xtcbhHWGHbLTDn7GCeVAIJvIaW42jOEAX0mCpCJGNsYgUatukv0YVE01Rz6GDyhQfx+2ygGusV51aQaY1inRs4WonDR8PD+Wha+Nepm09FS0=
Received: from MW4PR04CA0229.namprd04.prod.outlook.com (2603:10b6:303:87::24)
 by MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Wed, 7 Jun
 2023 05:39:43 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::36) by MW4PR04CA0229.outlook.office365.com
 (2603:10b6:303:87::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Wed, 7 Jun 2023 05:39:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Wed, 7 Jun 2023 05:39:41 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 00:39:40 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 00:39:39 -0500
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 7 Jun 2023 00:39:38 -0500
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To:     <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC:     <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@amd.com>,
        <amitrkcian2002@gmail.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: [PATCH] Revert "mtd: rawnand: arasan: Prevent an unsupported configuration"
Date:   Wed, 7 Jun 2023 11:09:36 +0530
Message-ID: <20230607053936.14306-1-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT059:EE_|MN0PR12MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: 6356bdee-05b1-4573-6eb2-08db6719979a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p/gW6Eu0tN5p2BOxDcBIgrpVRpNMJiC8BwNOF0qPiIuOvdN/Z+CCncyER3PJ40aBtshid+PkhLEZ5S2mmLdHwNwpea5gSXHfme04seQqy2c22++e/53fmfIH6MSL81KGPDxORw9DRuZC5sVuHYrRhvBv5YrJNDYAGJE/3dn6Dvh2tnp1pdD+dDbaO0AxXnvW7P01f32T8MhR4UUi34xxENdMZzr1kZvXc2WfXMQCIbYhbX16+SAQX8gvM/Ue7A/t+nsLjLnv0Ge4PdQyVsHgbzAVcwiKHuPxjk7jo+mCMFMKkvLrLEL3FeVB33JBzXVkmoBMgjtkC0OTWGebMdNwV802PYehXpFM9h3PxFt/eCk2/vXX8l7vIcnNuVOPvM5oAKd6HgdSoh017iQ8ODhDh9pBKgCE5TuYb/sld/qZ4it2r5alfeLmG0AeNxzQflAxuhtmbK8oqtmmOya5FlB+GJc8Sa1edfrj87r674Exi35EWbJldwy0vn1/xRLSZuKWhm0ELiLCAb3TRL12Laix08Zt0TqmqxcyKBGFxnIZh8nuGjswA1+rPlMref8NmCjR+OId2phR7U/OLfTMrsBkhj7TcnxnqCQTMNQD0V2yxKtZJHb0PXV5Cbrj812sth2ajPeCofQpE85XbAcPvKrospffc7ZV+j44UYytez57Ah/1wBVbsHdQSBUp8DKNpsTjOylFfW5KhpXGAe2/n3is+HCDMpRqEWL4ptr1G3Wm90oqPEYiVkr3vGxhd6kZgBkVoDnQU6vneQWmpgoprcZRqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199021)(40470700004)(36840700001)(46966006)(86362001)(5660300002)(2906002)(41300700001)(4326008)(70206006)(70586007)(81166007)(82740400003)(8936002)(110136005)(356005)(8676002)(54906003)(82310400005)(316002)(478600001)(36860700001)(40460700003)(83380400001)(1076003)(47076005)(186003)(426003)(336012)(36756003)(2616005)(40480700001)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 05:39:41.6974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6356bdee-05b1-4573-6eb2-08db6719979a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5883
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

This reverts commit fc9e18f9e987ad46722dad53adab1c12148c213c.

This patch was a work around to fix timeout issue while operating in NVDDR
mode with software ECC engine. This patch prevents the Arasan NAND driver
from operating in NVDDR mode with software ECC engine resulting in a
significant performance degradation with SW-ECC.
'commit 7499bfeedb47 ("mtd: rawnand: arasan: Update NAND bus clock instead
of system clock")' and 'commit e16eceea863b ("mtd: rawnand: arasan: Fix
clock rate in NV-DDR")'
fixes the timeout issue in NVDDR mode with SW-ECC so, reverting the changes
as this work around is no longer required.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
BRANCH: nand/next
---
 drivers/mtd/nand/raw/arasan-nand-controller.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/mtd/nand/raw/arasan-nand-controller.c b/drivers/mtd/nand/raw/arasan-nand-controller.c
index d513d2db3549..906eef70cb6d 100644
--- a/drivers/mtd/nand/raw/arasan-nand-controller.c
+++ b/drivers/mtd/nand/raw/arasan-nand-controller.c
@@ -973,21 +973,6 @@ static int anfc_setup_interface(struct nand_chip *chip, int target,
 		nvddr = nand_get_nvddr_timings(conf);
 		if (IS_ERR(nvddr))
 			return PTR_ERR(nvddr);
-
-		/*
-		 * The controller only supports data payload requests which are
-		 * a multiple of 4. In practice, most data accesses are 4-byte
-		 * aligned and this is not an issue. However, rounding up will
-		 * simply be refused by the controller if we reached the end of
-		 * the device *and* we are using the NV-DDR interface(!). In
-		 * this situation, unaligned data requests ending at the device
-		 * boundary will confuse the controller and cannot be performed.
-		 *
-		 * This is something that happens in nand_read_subpage() when
-		 * selecting software ECC support and must be avoided.
-		 */
-		if (chip->ecc.engine_type == NAND_ECC_ENGINE_TYPE_SOFT)
-			return -ENOTSUPP;
 	} else {
 		sdr = nand_get_sdr_timings(conf);
 		if (IS_ERR(sdr))
-- 
2.17.1

