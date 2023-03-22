Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055EA6C586B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 22:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjCVVFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 17:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjCVVF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 17:05:28 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEF1131;
        Wed, 22 Mar 2023 14:05:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWCMboaCs4qpfdU7BQU/K1ZnL8GE1TqnJkg9/lOA4NrFclPkgrWe17CdxdpZGoPbhZRRUqkNDMz9GMX1qV9aWDXC561M38Z1wJpN9bJqzC1rcKpIuWM8+c5u60XGCwPTsF8femGpLvS572xVRvXb5wQBDaFky0jwdpniBBhl8+INco1r4LVbFtiqf3ordiaVi8sgSz7hCX81LMq35kXaahcRoTNiErfyRBsmuwa5WQuh3/IshWYqoOUt/zun4gdTEunml+7+aDjvO+Q2RsGqYmAE3wRQtCZnJC/Nu6bBpozAgzwzWtGNk4p8aMbhNCbfztdjpWIxH35vQ0t3f+7oww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1WCTblmxhr0qRwwKSIK+KJG1K+4wb5zyYHURPy1NIo=;
 b=f+O4MTpzNm74bTGnmG5vGeEwneni79OCdn45ZmMIMR3mMVM7ERgLvmQkCZ1SCP/bBPntJ0+NgprtFK4Z7KUV5egVdwN9jlU5QhbDLfo7cm8paggNDHKk9IhCsObhO+Wjt7Ash1FRrmHywr2qVZKmWbNYkq5/VqhEeyqjUdVQmCme/0NUsKh9kTg6se6L3Yj/sokyB4QQF38ZVglCxbOO7no4TOZbIJOVuJPZtVOYzlGve32YTyE1+3KgtN9fqnza/TxZ+BQa/tLG8NfntZJRp4CnYC6F0K91ME/m9j6Az+W5UKNJjIqkDmAjr05+ZEH9a9fW586/ANr/0F3hhhUlXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=semihalf.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1WCTblmxhr0qRwwKSIK+KJG1K+4wb5zyYHURPy1NIo=;
 b=BR28pBGJiUUdGLfhU/BzFX3IoLz6AqTmulXRyKVr2Oy+RgWlnTGEKgJW5LpMma7ft2YtKj+4MLCsKCK6dQYKA8Jm39Ps0rYVpLVUx7RStQPkC4ZRIgl9ByPruUlMPfXk+JL1SyizzziAdXIXCdaslXw1A7JdNp2DqMG5Ne+bQLg=
Received: from DM5PR07CA0079.namprd07.prod.outlook.com (2603:10b6:4:ad::44) by
 PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Wed, 22 Mar 2023 21:05:24 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::63) by DM5PR07CA0079.outlook.office365.com
 (2603:10b6:4:ad::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Wed, 22 Mar 2023 21:05:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Wed, 22 Mar 2023 21:05:24 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 22 Mar
 2023 16:05:22 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     =?UTF-8?q?Jan=20D=C4=85bro=C5=9B?= <jsd@semihalf.com>,
        Grzegorz Bernacki <gjb@semihalf.com>,
        Mark Hasemeyer <markhas@chromium.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "John Allen" <john.allen@amd.com>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 2/4] crypto: ccp: Return doorbell status code as an argument
Date:   Wed, 22 Mar 2023 16:02:24 -0500
Message-ID: <20230322210227.464-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230322210227.464-1-mario.limonciello@amd.com>
References: <20230322210227.464-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT026:EE_|PH7PR12MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: f6130c86-3afe-4f25-ad7a-08db2b1927c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LmXGeqSzjPvrXMtKlXMsQrpqY1aiBD+F4spyD62J4u6ErpP2anNYLVCYapuXkckIH388v5u5otNiebbWlWqY+dYygAquPKF+RGOnIOSFbvCytkV8uSmG56B5oqLXv0z6K1fyI2CMTGK3ugoBIN/mIRvjBGr6G5DKDC+xEzm3u0bBGjjYT+xH07xKHNXPj72565ha4YssBlTQaOsKlrc/dm9/J8+AiRFBko8/IGPjcLqjAmzCePFevBjcz6/QmGE0LKKP47Z6Vld2CYZitKFyz/GL2H4j6cQRqkhvgEiQDMs2si19n7lEmxfSxaX2L4UnZQMDxBrfPAwkiHn3kR47re6ieoisPc7f09rEdP00RSSnHljvAMGyEL1wiidwHa7CXok1oA3SYgLD62GnAWxZgCu6mpAm9WH0gxWg1CfxcfBLUeChm3NltDLuR57Z0cXzgZm4FY7h/8a5V61Z+/Y1Luqh56uTQSruA7484wkynvhFE6QtKEJz/tXciTQ0Kj/SVzXtpQ9Qs0i8aGJBQz+utaNZ8Glbxso6htkloY++QM6Nbg+oRTEzHdfM504fyODVkG4RNJoFnwtX3igX0KacAVGDoHBLrBzrH/kuzXkC1vOv6iuSgaK2BVg1EmCFi6yO7fO1jXSG+TFeUZWIbgpnYHNIXBfC3RqliMHFskS7uzEYBfWjesZZLJ1snslHUd0rq1NGtK3Mo+yqDxGjH0vdUgaLPG91ix56vrIt1whzOf6B4ItzUahFy/lUMbdwObnPjpY/swBkhwzvOKiVsoWt4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199018)(40470700004)(46966006)(36840700001)(16526019)(356005)(2616005)(336012)(1076003)(186003)(26005)(86362001)(7696005)(47076005)(426003)(316002)(40460700003)(44832011)(2906002)(83380400001)(82740400003)(82310400005)(81166007)(478600001)(4326008)(8676002)(54906003)(6636002)(110136005)(5660300002)(40480700001)(70586007)(8936002)(41300700001)(70206006)(36860700001)(36756003)(36900700001)(134885004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 21:05:24.3562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6130c86-3afe-4f25-ad7a-08db2b1927c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7282
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 3e97ce60270d..9f3d469bbe76 100644
--- a/drivers/crypto/ccp/platform-access.c
+++ b/drivers/crypto/ccp/platform-access.c
@@ -140,7 +140,7 @@ int psp_send_platform_access_msg(enum psp_platform_access_msg msg,
 }
 EXPORT_SYMBOL_GPL(psp_send_platform_access_msg);
 
-int psp_ring_platform_doorbell(int msg)
+int psp_ring_platform_doorbell(int msg, u32 *result)
 {
 	struct psp_device *psp = psp_get_master_device();
 	struct psp_platform_access_device *pa_dev;
@@ -184,6 +184,8 @@ int psp_ring_platform_doorbell(int msg)
 
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

