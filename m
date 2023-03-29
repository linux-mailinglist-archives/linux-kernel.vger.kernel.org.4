Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D106CF629
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 00:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjC2WIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 18:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjC2WIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 18:08:14 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409C34EF1;
        Wed, 29 Mar 2023 15:08:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkPR/txEHV4YtcO/t0spduZBlKyE2T00MZuGGkSsEme/L44Ln4qo3RjPv14KYSFecNpY8qEg8FgbzlhdCMKx1EsKgMvwpX/rW0gLse9eQspFUg5rqqwDdZV4zw3e6PHXlzI0dx7Z8V3VvA3fZaKtBx6ktJzwN+2hvR/86a7rckCzvWLmQHVRojCCNzdxQpTPLvLmHNVGoAlRE8cfYP7MPB3CwNDmt1gQfveiQUYtLepuiCtWDwloeHOsWWHMyyx3aJzLWkQ9bbchL3YGz7ndCTUsCJosQcM1Pb/0W+2ZNttDFrxpRdiFZXkuAc8u+EIPIKv9mCFE0AJiJD4vdu6HrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6S8dkR5yo43HwTojP4Wgu6lcLkIeRpN6JtWy1saf/E=;
 b=m6g6mKiYSvDcEcSEvrflpS4i+znmBxnFiuwr/obRRr5Rbpqddeiy2SOXCJI3kVC6xqpW473W3yKpAuHhOmpF/zStFnbrKH2eRNJaU4EbsIimGKezYZ4TTkwrZyDBXUGYqgygzuvCCh4pLzFjl2A4Lu571eazYFk+frj6rzEadhRLhDLapeoHwo4GoYPxSwCwDQhlfstJpwDq/dy30UmRlbk/Fs+sxPzyze6kK8hoXhX1FEvpuC3LjMxCqLnn5meZ3FdAD6xuSqcdEaBaJ1YuTA9MHtRoQ2MtqY7FVu+5eXBs/IQ6JPfkFyxLNSwcXYktJIZPnJfEC0WPGxEm3z+4zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=semihalf.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6S8dkR5yo43HwTojP4Wgu6lcLkIeRpN6JtWy1saf/E=;
 b=NVe9KmWkH2W566Y25imaxssLeR2DWa4bMd5ml2/vnmuoCRD5FLiDhgAL+DrYLC4vjzaS2U87NlKB4Mfphq24C65f8/0dSUWSsXWtMONco20AWhvXNxnnwWazuD5o+0fS5gXxrcElt5sRrNOXKsohet5cnW+A/0tgAa0wMi9quOA=
Received: from BL0PR05CA0012.namprd05.prod.outlook.com (2603:10b6:208:91::22)
 by SA3PR12MB8021.namprd12.prod.outlook.com (2603:10b6:806:305::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Wed, 29 Mar
 2023 22:08:09 +0000
Received: from BL02EPF000145B8.namprd05.prod.outlook.com
 (2603:10b6:208:91:cafe::d9) by BL0PR05CA0012.outlook.office365.com
 (2603:10b6:208:91::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.18 via Frontend
 Transport; Wed, 29 Mar 2023 22:08:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145B8.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.35 via Frontend Transport; Wed, 29 Mar 2023 22:08:08 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 17:08:07 -0500
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
Subject: [PATCH v7 1/6] crypto: ccp: Drop extra doorbell checks
Date:   Wed, 29 Mar 2023 17:07:47 -0500
Message-ID: <20230329220753.7741-2-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF000145B8:EE_|SA3PR12MB8021:EE_
X-MS-Office365-Filtering-Correlation-Id: 33aa128f-6bfc-4714-6190-08db30a21471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hsD29L+sqWPnQgfAkkffKqpjH8S8CEQt8xpUotb4Qxy4iF0yzXWceXAkF4OryJfvCmelxWmjMxGftA5yRjR5s0VCpzUzsKvswjyJJPHrf0lvgpRm5xzb2jUKOD8yTcvu0/4HjK3Zb5YeHKM1+RIzzaZy3PNAjt5q63PcqDv+8q8CSxMSF2fAZWOpRkLsyJmDpiAq3Q+UADKhXpU+MCVH13ziytLqD6XQF7jljXx7GvbDPnJqP5DmEc6H5aAIszG6JG5/GzSyVN5w3gw00IxyXh5OuJLA2lcXxSh51RnWyIfNg7e19SwxP9aiEzsrXsZEoELhEo1SDX+TvJnmNutysOQMjgcz6lv2gJhzoKdfj2hvJ37GL/WWpprsk/Wq8Ly8lTU8OUr6eTNINyH8CO3UTx1wLXyqBWBh55z2PiujoU59abVoUMz7k+hIAtS39uCVj3Y4BfVnB0auFFf7CnXOs/gw9cgYWdx+GLtwxLUAj3KShI+mEafBspU+ZHAowaA4IGD+Kw++wnV2ackSLBMwyMLShpfASxrGCobJ09bdw1nVg38jIuhy+Am7KCYI/3EolxMxSA+jp8sKZghJRY8qS4DXy9BEZNkG+64SUpIsYndG1cFEBsaWrmBKOmYULeetxCtzK/SoHNh46mOfjTkDAaTMgmAoTVsfW0CjAR+wUKki+LNkv0WODRatodrq/kg3gnExragL1JslNKLydmLjV50/DqOZj5FeGOHKJXJn8kc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(47076005)(26005)(54906003)(1076003)(316002)(6666004)(6636002)(110136005)(16526019)(4326008)(8676002)(186003)(70586007)(70206006)(478600001)(36860700001)(82740400003)(5660300002)(44832011)(356005)(40460700003)(2906002)(36756003)(83380400001)(336012)(81166007)(426003)(2616005)(7696005)(41300700001)(86362001)(8936002)(40480700001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 22:08:08.8399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33aa128f-6bfc-4714-6190-08db30a21471
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8021
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The doorbell register set used for I2C arbitration is dedicated for this
purpose and there is no need to utilize other safety checks the platform
access register set uses.

Suggested-by: Mark Hasemeyer <markhas@chromium.org>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v6->v7:
 * new patch
---
 drivers/crypto/ccp/platform-access.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/crypto/ccp/platform-access.c b/drivers/crypto/ccp/platform-access.c
index b51fb1196932..1ad3a0a512b1 100644
--- a/drivers/crypto/ccp/platform-access.c
+++ b/drivers/crypto/ccp/platform-access.c
@@ -20,14 +20,6 @@
 
 #define PSP_CMD_TIMEOUT_US	(500 * USEC_PER_MSEC)
 
-/* Doorbell shouldn't be ringing */
-static int check_doorbell(u32 __iomem *doorbell)
-{
-	u32 tmp;
-
-	return readl_poll_timeout(doorbell, tmp, tmp != 0, 0, PSP_CMD_TIMEOUT_US);
-}
-
 /* Recovery field should be equal 0 to start sending commands */
 static int check_recovery(u32 __iomem *cmd)
 {
@@ -156,18 +148,6 @@ int psp_ring_platform_doorbell(int msg)
 
 	mutex_lock(&pa_dev->doorbell_mutex);
 
-	if (check_doorbell(button)) {
-		dev_dbg(psp->dev, "doorbell is not ready\n");
-		ret = -EBUSY;
-		goto unlock;
-	}
-
-	if (check_recovery(cmd)) {
-		dev_dbg(psp->dev, "doorbell command in recovery\n");
-		ret = -EBUSY;
-		goto unlock;
-	}
-
 	if (wait_cmd(cmd)) {
 		dev_dbg(psp->dev, "doorbell command not done processing\n");
 		ret = -EBUSY;

base-commit: 9117e682b8b79f7b5e2517fd28d42757d3e8b860
-- 
2.34.1

