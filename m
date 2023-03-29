Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483706CF62C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 00:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjC2WI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 18:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjC2WIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 18:08:17 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4B544A9;
        Wed, 29 Mar 2023 15:08:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQvoCchOsMFYyWdg5te7V+aGD7LgWtTLgeQGwSJrai8bD1yfGmRK3epC+/mEn+GSREgx1PReDCyeWVEMRk0JNDXxbLIzNsw47tiqE7vfJGDf76l1RbL4tk09eGXtoPML4KhFjSy3V/emueC4Km3c9N57KM8Mrw1EZFlvbswhlFizfsu5yApPBa3/GyfcWtH0mmrjPjAUVCa8SVi61dPbueH/srei6jAHk42H8bv1X79Mv67ILWZc/LVt3RJLjtrhmsmYeZ0JIZ1jtn5X4rcXl3Zpph5RuKboa1p5uJjIkdon7pvYORi4IZgfoZWi7I2MBkhOS7W1p0bNKV8NYQG2aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pyce0r//rglaJiecWUtG9Mej/HjSG5a0OqBICjtYQqU=;
 b=VDyNiNTnfRDBSDjgaIMEadnReVLo2vHzTWcmeUXo4G3B+C+j9tkEkpjqFLBjs5QM/BqKI+r+S+NcohW/v7vdODX0OZJtW+GOjImwIcRBvaRfBBnYigBLK6hs9n66+dxCnD3tGCZt+9QTtgRw83pGdqR+NGHJy9tyMlXu2gC7Zluw0mGN4eB3xDJXYkPsp1v8Cy7Fsi90Px9FEqlYoQoefqA8Z1KHFQYLOz1dLJbLrk7We8gbLAPQNPgDOgY0+8FGjdr7od/Ej+3/t1Pb1EQpe8Fi5tARvx+3SAod6VnxtIqOPDP7Gek1s5ObfP7ji1JOuWgGdAZ/zVrx/sno0KcB4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=semihalf.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pyce0r//rglaJiecWUtG9Mej/HjSG5a0OqBICjtYQqU=;
 b=WIx/WBS8nORVB54X5Ka+KMYgqP7WjYzedejK6UvoLgzPMOr7KZlih00R9OE48i+6wMEpdn480+o7+pdgrICIBr/0vWmGRQPAk54E2DbYqJqEWZptApwBsE8wxvPJE8Q5CKt7VmLwbJlWV09FhwFlITUSVWKkXteVTqAayGc7Ges=
Received: from BL0PR05CA0014.namprd05.prod.outlook.com (2603:10b6:208:91::24)
 by MW4PR12MB6874.namprd12.prod.outlook.com (2603:10b6:303:20b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Wed, 29 Mar
 2023 22:08:12 +0000
Received: from BL02EPF000145B8.namprd05.prod.outlook.com
 (2603:10b6:208:91:cafe::a8) by BL0PR05CA0014.outlook.office365.com
 (2603:10b6:208:91::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 22:08:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145B8.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.35 via Frontend Transport; Wed, 29 Mar 2023 22:08:11 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 17:08:10 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     =?UTF-8?q?Jan=20D=C4=85bro=C5=9B?= <jsd@semihalf.com>,
        Grzegorz Bernacki <gjb@semihalf.com>,
        Mark Hasemeyer <markhas@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>
CC:     Felix Held <Felix.Held@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 3/6] crypto: ccp: Return doorbell status code as an argument
Date:   Wed, 29 Mar 2023 17:07:49 -0500
Message-ID: <20230329220753.7741-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230329220753.7741-1-mario.limonciello@amd.com>
References: <20230329220753.7741-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B8:EE_|MW4PR12MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: a76c2cab-f538-4a18-1158-08db30a21647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xwnc+by7nHBBQYEc35KKd2yph7s9TK6mA/2d6mzqWv5QdW9ZL16wrLNH2ZXOPwEUKWjd/fkiZRxirKbhUcJpfheXbPczpOpr4MfH2+ipdMEmzUMSX9gUMbQzbuPDF7B29o2H3Q/oh0lHwCARLspgzcx7eRxF2AT6/h+/lJz3trHGyeItHg1MNNoI+G9JMERcl7CMEiQCeKeba9DuxlLzACYJfnWy6Wi1+aDt8DhMTHqZhkapevAhcUm3Gx95Kfp3Ob+v/GEq25OSKTap1rAHjmO6ycUDyOOJysHUdghSChKGJ4tnAGjYg7UBb1ekyvYevtkfLyMJrFsEB8duZIR7alaCudiUhNwjYYnsJjTWolv/sZv3Uwj0VOs8l/OPNT/LA6EvCiGXnllVDJWDB9QsYGWynhNt8T9+TuRE91tbGyRJ8AZThzBTsLxK8xT485bb0t285VPjnWVP1N79hZQ1W4CkSHteh3pOeTIDPyH8zZqMA2Z/5qVvq8af0JDWi8/Svz4V84dvSRJTaIO2AKHo4EoOV2iReBKyfW6+F5be0pQiWr7xp3CIQBwSybI11NQw4Cq2YdItmYbgqHG5yhp+O25ti4vv5Sbu2SHkZMLb82M0BmerKdVumZ5A2Md53BRWpZo/oZ5h5RBc2f6+YDIugqlpqLH9Y5r3M0+3cVJD9CHG7TfvLbh+aOEN7rssHGbEpWCJ2EXEr9OLc8ubpY559v0g78o55hHHptMRXOJ2vwHSmqzdSAYjOVr4OcLA+DeyWE4sC0gHR6syspoDBn7w1Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199021)(46966006)(36840700001)(40470700004)(336012)(316002)(426003)(8936002)(82740400003)(36860700001)(81166007)(6636002)(54906003)(41300700001)(2906002)(110136005)(356005)(4326008)(44832011)(8676002)(478600001)(70206006)(5660300002)(70586007)(2616005)(47076005)(40460700003)(7696005)(86362001)(40480700001)(83380400001)(16526019)(82310400005)(186003)(26005)(36756003)(6666004)(1076003)(36900700001)(134885004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 22:08:11.9179
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a76c2cab-f538-4a18-1158-08db30a21647
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6874
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the doorbell failed to ring we return -EIO, but the caller can't
determine why it failed.  Pass the reason for the failure in an
argument for caller to investigate.

Suggested-by: Mark Hasemeyer <markhas@chromium.org>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5->v6:
 * New patch
---
 drivers/crypto/ccp/platform-access.c | 4 +++-
 include/linux/psp-platform-access.h  | 4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/ccp/platform-access.c b/drivers/crypto/ccp/platform-access.c
index 1cc154a1c6ab..48f59ae91692 100644
--- a/drivers/crypto/ccp/platform-access.c
+++ b/drivers/crypto/ccp/platform-access.c
@@ -132,7 +132,7 @@ int psp_send_platform_access_msg(enum psp_platform_access_msg msg,
 }
 EXPORT_SYMBOL_GPL(psp_send_platform_access_msg);
 
-int psp_ring_platform_doorbell(int msg)
+int psp_ring_platform_doorbell(int msg, u32 *result)
 {
 	struct psp_device *psp = psp_get_master_device();
 	struct psp_platform_access_device *pa_dev;
@@ -164,6 +164,8 @@ int psp_ring_platform_doorbell(int msg)
 
 	val = FIELD_GET(PSP_CMDRESP_STS, ioread32(cmd));
 	if (val) {
+		if (result)
+			*result = val;
 		ret = -EIO;
 		goto unlock;
 	}
diff --git a/include/linux/psp-platform-access.h b/include/linux/psp-platform-access.h
index 89df4549fada..1b661341d8f3 100644
--- a/include/linux/psp-platform-access.h
+++ b/include/linux/psp-platform-access.h
@@ -45,9 +45,9 @@ int psp_send_platform_access_msg(enum psp_platform_access_msg, struct psp_reques
  *  -%EBUSY:     mailbox in recovery or in use
  *  -%ENODEV:    driver not bound with PSP device
  *  -%ETIMEDOUT: request timed out
- *  -%EIO:       unknown error (see kernel log)
+ *  -%EIO:       error will be stored in result argument
  */
-int psp_ring_platform_doorbell(int msg);
+int psp_ring_platform_doorbell(int msg, u32 *result);
 
 /**
  * psp_check_platform_access_status() - Checks whether platform features is ready
-- 
2.34.1

